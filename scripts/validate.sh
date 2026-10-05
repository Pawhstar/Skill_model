#!/usr/bin/env bash
# scripts/validate.sh - Validates plugin manifests, skills, and configuration files.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

ERRORS=0

echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}    Skill_model Validation Suite       ${NC}"
echo -e "${BLUE}=======================================${NC}"

# 1. Validate JSON manifests
echo -e "\n${YELLOW}[1/4] Checking JSON manifests...${NC}"
for json_file in "${ROOT_DIR}/plugin.json" "${ROOT_DIR}/gemini-extension.json" "${ROOT_DIR}/mcp_config.json" "${ROOT_DIR}/.claude-plugin/plugin.json"; do
  if [ -f "${json_file}" ]; then
    if python3 -m json.tool "${json_file}" >/dev/null 2>&1; then
      echo -e "  ${GREEN}✓${NC} Valid JSON: $(basename "${json_file}")"
    else
      echo -e "  ${RED}✗${NC} Invalid JSON: ${json_file}"
      ERRORS=$((ERRORS + 1))
    fi
  else
    echo -e "  ${RED}✗${NC} Missing expected manifest: ${json_file}"
    ERRORS=$((ERRORS + 1))
  fi
done

# 2. Validate Rules files
echo -e "\n${YELLOW}[2/4] Checking Rules files...${NC}"
if [ -f "${ROOT_DIR}/rules/AGENTS.md" ]; then
  echo -e "  ${GREEN}✓${NC} Found rules/AGENTS.md"
else
  echo -e "  ${RED}✗${NC} Missing rules/AGENTS.md"
  ERRORS=$((ERRORS + 1))
fi

# 3. Validate Skills frontmatter & structure
echo -e "\n${YELLOW}[3/4] Checking Skills structure and YAML frontmatter...${NC}"
SKILL_COUNT=0
for skill_dir in "${ROOT_DIR}/skills"/*; do
  [ -d "${skill_dir}" ] || continue
  SKILL_COUNT=$((SKILL_COUNT + 1))
  skill_name="$(basename "${skill_dir}")"
  skill_file="${skill_dir}/SKILL.md"

  if [ ! -f "${skill_file}" ]; then
    echo -e "  ${RED}✗${NC} Skill '${skill_name}' is missing SKILL.md"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check frontmatter opening
  FIRST_LINE=$(head -n 1 "${skill_file}")
  if [ "${FIRST_LINE}" != "---" ]; then
    echo -e "  ${RED}✗${NC} Skill '${skill_name}/SKILL.md' does not start with '---'"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check name and description presence
  if ! grep -q "^name:" "${skill_file}"; then
    echo -e "  ${RED}✗${NC} Skill '${skill_name}/SKILL.md' missing 'name:' in frontmatter"
    ERRORS=$((ERRORS + 1))
  fi

  if ! grep -q "^description:" "${skill_file}"; then
    echo -e "  ${RED}✗${NC} Skill '${skill_name}/SKILL.md' missing 'description:' in frontmatter"
    ERRORS=$((ERRORS + 1))
  fi

  echo -e "  ${GREEN}✓${NC} Skill verified: ${skill_name}"
done

if [ "${SKILL_COUNT}" -eq 0 ]; then
  echo -e "  ${RED}✗${NC} No skills found under skills/ directory."
  ERRORS=$((ERRORS + 1))
fi

# 4. Check Symlinks
echo -e "\n${YELLOW}[4/4] Checking symlinks...${NC}"
for link in "${ROOT_DIR}/AGENTS.md"; do
  if [ -L "${link}" ]; then
    if [ -e "${link}" ]; then
      echo -e "  ${GREEN}✓${NC} Valid link: $(basename "${link}") -> $(readlink "${link}")"
    else
      echo -e "  ${RED}✗${NC} Broken symlink: ${link}"
      ERRORS=$((ERRORS + 1))
    fi
  elif [ -f "${link}" ]; then
    echo -e "  ${GREEN}✓${NC} Regular file: $(basename "${link}")"
  fi
done

# Summary
echo -e "\n${BLUE}=======================================${NC}"
if [ "${ERRORS}" -eq 0 ]; then
  echo -e "${GREEN}All checks passed successfully! (${SKILL_COUNT} skills validated)${NC}"
  exit 0
else
  echo -e "${RED}Validation failed with ${ERRORS} error(s).${NC}"
  exit 1
fi
