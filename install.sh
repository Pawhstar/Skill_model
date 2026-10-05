#!/usr/bin/env bash
# install.sh - Installs Skill_model plugin across AI coding tools.
# Supports: Antigravity (agy), Claude Code (claude), OpenAI Codex (codex), and shared agent directories.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

MODE="symlink"
TARGET_DIR="${HOME}"
WORKSPACE_TARGET=""

usage() {
  cat <<EOF
Usage: ./install.sh [OPTIONS]

Installs the Skill_model AI Coding Plugin and skills for your local AI assistants.

Options:
  --symlink            Symlink skills and plugin (recommended: auto-updates on git pull) [default]
  --copy               Copy files instead of symlinking
  --workspace <DIR>    Install directly into a target repository/workspace (into .agents/)
  --help, -h           Show this help message

Supported AI Assistants:
  - Antigravity / Gemini CLI  (~/.gemini/config/plugins/skill-model)
  - Claude Code               (~/.claude/skills/*)
  - OpenAI Codex              (~/.codex/skills/*)
  - Shared Agent Directory    (~/.agents/skills/*)
EOF
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --symlink)
      MODE="symlink"
      shift
      ;;
    --copy)
      MODE="copy"
      shift
      ;;
    --workspace)
      WORKSPACE_TARGET="$2"
      shift 2
      ;;
    -h|--help)
      usage
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      usage
      ;;
  esac
done

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}         Skill_model AI Coding Plugin Installer       ${NC}"
echo -e "${BLUE}======================================================${NC}"

# Pre-flight check
echo -e "\n${CYAN}Running validation check before installation...${NC}"
"${SCRIPT_DIR}/scripts/validate.sh" >/dev/null || {
  echo -e "${RED}Validation failed. Please fix validation errors first.${NC}"
  exit 1
}
echo -e "${GREEN}✓ Verification passed.${NC}"

# Helper function to install a directory
install_path() {
  local src="$1"
  local dest="$2"
  local name="$3"

  mkdir -p "$(dirname "${dest}")"

  if [ -L "${dest}" ]; then
    local current_target
    current_target="$(readlink -f "${dest}")"
    local expected_target
    expected_target="$(readlink -f "${src}")"

    if [ "${current_target}" = "${expected_target}" ]; then
      echo -e "  ${GREEN}✓${NC} ${name}: already linked correctly."
      return 0
    else
      echo -e "  ${YELLOW}!${NC} ${name}: replacing existing symlink pointing to ${current_target}."
      rm -f "${dest}"
    fi
  elif [ -e "${dest}" ]; then
    echo -e "  ${YELLOW}!${NC} ${name}: existing directory/file found at ${dest}. Backing up to ${dest}.bak"
    mv "${dest}" "${dest}.bak.$(date +%s)"
  fi

  if [ "${MODE}" = "symlink" ]; then
    ln -s "${src}" "${dest}"
    echo -e "  ${GREEN}✓${NC} ${name}: symlinked -> ${dest}"
  else
    cp -r "${src}" "${dest}"
    echo -e "  ${GREEN}✓${NC} ${name}: copied -> ${dest}"
  fi
}

if [ -n "${WORKSPACE_TARGET}" ]; then
  echo -e "\n${CYAN}[Target: Workspace] ${WORKSPACE_TARGET}${NC}"
  if [ ! -d "${WORKSPACE_TARGET}" ]; then
    echo -e "${RED}Workspace directory does not exist: ${WORKSPACE_TARGET}${NC}"
    exit 1
  fi
  TARGET_AGENTS="${WORKSPACE_TARGET}/.agents"
  mkdir -p "${TARGET_AGENTS}/plugins" "${TARGET_AGENTS}/skills"

  # Link plugin into workspace
  install_path "${SCRIPT_DIR}" "${TARGET_AGENTS}/plugins/skill-model" "Workspace Plugin"

  # Link individual skills
  for skill in "${SCRIPT_DIR}/skills"/*; do
    [ -d "${skill}" ] || continue
    skill_name="$(basename "${skill}")"
    install_path "${skill}" "${TARGET_AGENTS}/skills/${skill_name}" "Skill (${skill_name})"
  done

  # Link rules
  install_path "${SCRIPT_DIR}/rules/AGENTS.md" "${TARGET_AGENTS}/rules/AGENTS.md" "Workspace Rules"

  echo -e "\n${GREEN}Successfully installed to workspace!${NC}"
  exit 0
fi

echo -e "\n${CYAN}[Target: Global User Environment]${NC}"

# 1. Antigravity / Gemini CLI Plugin (~/.gemini/config/plugins/skill-model)
echo -e "\n${YELLOW}1. Configuring Antigravity / Gemini CLI...${NC}"
AGY_PLUGIN_DIR="${TARGET_DIR}/.gemini/config/plugins/skill-model"
install_path "${SCRIPT_DIR}" "${AGY_PLUGIN_DIR}" "Antigravity Plugin"

# 2. Shared Agent Directory (~/.agents/skills) if present or created
echo -e "\n${YELLOW}2. Configuring Shared Agents directory (~/.agents)...${NC}"
SHARED_AGENTS_DIR="${TARGET_DIR}/.agents"
mkdir -p "${SHARED_AGENTS_DIR}/skills"
for skill in "${SCRIPT_DIR}/skills"/*; do
  [ -d "${skill}" ] || continue
  skill_name="$(basename "${skill}")"
  install_path "${skill}" "${SHARED_AGENTS_DIR}/skills/${skill_name}" "Shared Skill (${skill_name})"
done

# 3. Claude Code (~/.claude/skills and ~/.claude/CLAUDE.md)
echo -e "\n${YELLOW}3. Configuring Claude Code (~/.claude)...${NC}"
CLAUDE_SKILLS_DIR="${TARGET_DIR}/.claude/skills"
mkdir -p "${CLAUDE_SKILLS_DIR}"
for skill in "${SCRIPT_DIR}/skills"/*; do
  [ -d "${skill}" ] || continue
  skill_name="$(basename "${skill}")"
  install_path "${skill}" "${CLAUDE_SKILLS_DIR}/${skill_name}" "Claude Skill (${skill_name})"
done
install_path "${SCRIPT_DIR}/rules/AGENTS.md" "${TARGET_DIR}/.claude/CLAUDE.md" "Claude Global Rules (CLAUDE.md -> AGENTS.md)"

# 4. OpenAI Codex (~/.codex/skills)
echo -e "\n${YELLOW}4. Configuring OpenAI Codex (~/.codex)...${NC}"
CODEX_SKILLS_DIR="${TARGET_DIR}/.codex/skills"
mkdir -p "${CODEX_SKILLS_DIR}"
for skill in "${SCRIPT_DIR}/skills"/*; do
  [ -d "${skill}" ] || continue
  skill_name="$(basename "${skill}")"
  install_path "${skill}" "${CODEX_SKILLS_DIR}/${skill_name}" "Codex Skill (${skill_name})"
done

echo -e "\n${BLUE}======================================================${NC}"
echo -e "${GREEN}🎉 Skill_model successfully installed!${NC}"
echo -e "${BLUE}======================================================${NC}"
echo -e "Included Skills:"
for skill in "${SCRIPT_DIR}/skills"/*; do
  [ -d "${skill}" ] || continue
  echo -e "  • ${GREEN}$(basename "${skill}")${NC}"
done
echo -e "\nTips:"
echo -e "  • Because you used ${GREEN}${MODE}${NC} mode, pulling new updates via ${CYAN}git pull${NC} will automatically update your AI assistants."
echo -e "  • To verify in Antigravity: open an assistant session and type prompt referencing any skill."
echo -e "  • To uninstall anytime, simply run: ${CYAN}./uninstall.sh${NC}"
