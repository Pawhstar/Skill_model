#!/usr/bin/env bash
# uninstall.sh - Safely removes symlinks and installations created by install.sh.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

remove_if_matches() {
  local target="$1"
  local name="$2"

  if [ -L "${target}" ]; then
    local dest
    dest="$(readlink -f "${target}" || true)"
    local expected
    expected="$(readlink -f "${SCRIPT_DIR}")"

    # Check if target points inside our repo
    if [[ "${dest}" == "${expected}"* ]]; then
      rm -f "${target}"
      echo -e "  ${GREEN}✓${NC} Removed: ${name} (${target})"
    fi
  fi
}

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}        Skill_model AI Coding Plugin Uninstaller     ${NC}"
echo -e "${BLUE}======================================================${NC}"

echo -e "\n${CYAN}Cleaning up installed links...${NC}"

# 1. Antigravity plugin
remove_if_matches "${HOME}/.gemini/config/plugins/skill-model" "Antigravity Plugin"

# 2. Skills
for skill in "${SCRIPT_DIR}/skills"/*; do
  [ -d "${skill}" ] || continue
  skill_name="$(basename "${skill}")"
  remove_if_matches "${HOME}/.agents/skills/${skill_name}" "Shared Skill (${skill_name})"
  remove_if_matches "${HOME}/.claude/skills/${skill_name}" "Claude Skill (${skill_name})"
  remove_if_matches "${HOME}/.codex/skills/${skill_name}" "Codex Skill (${skill_name})"
done
remove_if_matches "${HOME}/.claude/CLAUDE.md" "Claude Global Rules"

echo -e "\n${GREEN}Skill_model uninstallation complete.${NC}"
