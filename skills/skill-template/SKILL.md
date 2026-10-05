---
name: skill-template
description: >-
  Template and authoring guide for creating new skills within the Skill_model plugin repository.
  Use when the user asks to add, create, or structure a new skill for the team.
---

# Skill Authoring Guide & Template

This skill outlines the standards and procedure for defining a new skill in `Skill_model`.

---

## 1. Skill Directory Structure

Every skill lives under `skills/<skill_name>/`:

```text
skills/<skill_name>/
├── SKILL.md          # Required: Main instruction file with YAML frontmatter
├── scripts/          # Optional: Helper automation scripts (bash, python, etc.)
├── examples/         # Optional: Reference implementations and before/after snippets
├── resources/        # Optional: Assets, schemas, or templates
└── references/       # Optional: In-depth technical documentation
```

---

## 2. Frontmatter Specifications

The `SKILL.md` file MUST begin with a YAML frontmatter block:

```markdown
---
name: your-skill-name
description: >-
  Third-person explanation of what this skill does and precisely when to trigger it.
  Example: "Use this skill when asked to deploy the service to staging or run smoke tests."
---
```

### Critical Rules for Frontmatter:
- **`name`**: Lowercase alphanumeric characters and hyphens only (`[a-z0-9-]+`).
- **`description`**: This is read by the AI model during progressive disclosure. State **clearly** what the skill does and the specific keywords, questions, or scenarios that trigger it.

---

## 3. Best Practices for Team Skills

1. **Progressive Disclosure**:
   - Keep the root `SKILL.md` concise (procedural steps and quick checklist).
   - Put large manuals or deep reference materials in `references/` and link to them with relative links (e.g. `[Deep Dive](./references/guide.md)`).
2. **Actionable Steps**:
   - Provide concrete commands, checklists, and expected outputs.
   - Include validation/verification instructions so the agent can self-check whether a step succeeded.
3. **Executable Scripts**:
   - Put repeated complex multi-command sequences in `scripts/*.sh` or `scripts/*.py`.
   - Make scripts executable (`chmod +x`) and handle edge cases gracefully.
4. **Starter Template**:
   - Refer to [template.md](./template.md) for a ready-to-copy skeleton.
