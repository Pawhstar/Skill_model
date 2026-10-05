# Skill_model: Team AI Coding Plugin & Skills Framework

A unified, multi-platform AI coding plugin and skills repository designed to share consistent coding standards, automated workflows, and runbooks across engineering teams.

Compatible with **Antigravity (agy)**, **Claude Code**, **OpenAI Codex**, and **Cursor / Windsurf**.

---

## 🚀 Quickstart for Team Members

### 1. Clone the Repository
```bash
git clone https://github.com/Pawhstar/Skill_model.git
cd Skill_model
```

### 2. Install Across Your AI Assistants (One Command)
```bash
./install.sh
```

> **Why symlinking is recommended:** By default, `./install.sh` creates symbolic links. Whenever you or your team run `git pull` in this repository, all your AI coding assistants receive updated rules and skills immediately—no reinstall required!

### 3. Start Using with Any AI Coding Assistant
Open your favorite AI coding tool in any project and prompt it naturally:
- *"Review my staged git diff using our team standards."*
- *"Help me debug this error following the debugging guide."*
- *"Generate unit tests for this function with the test generator."*
- *"Format my commit message following our git workflow conventions."*

---

## 🧰 What's Included

### 1. Pre-Bundled Team Skills (`skills/`)
| Skill | Directory | Triggers & Description |
| :--- | :--- | :--- |
| **Code Review** | `skills/code-review` | Thorough review across correctness, security, performance, simplicity, and test coverage. |
| **Debugging Guide** | `skills/debugging-guide` | 5-step systematic root-cause analysis: reproduce, isolate, hypothesize, fix, and verify. |
| **Git Workflow** | `skills/git-workflow` | Standard feature branch naming, conventional commits syntax, and PR description template. |
| **Test Generator** | `skills/test-generator` | Structured AAA (Arrange-Act-Assert) unit and integration test generation. |
| **Skill Template** | `skills/skill-template` | Reference blueprint and authoring instructions for contributing new team skills. |

### 2. Consolidated Team Guidelines (`rules/AGENTS.md`)
Enforces standard behavior across all models:
- **Simplicity & YAGNI**: No speculative abstractions or unrequested dependencies.
- **Safety First**: Prohibits destructive commands without confirmation.
- **Code Hygiene**: Preserves existing comments and follows codebase style.
- **Conventional Commits**: Standard commit formatting (`feat:`, `fix:`, `refactor:`, etc.).

### 3. Model Context Protocol (`mcp_config.json`)
Shared MCP server configurations for connecting external tools, databases, and APIs.

---

## 🛠️ How to Add a New Skill for Your Team

Adding a new skill is simple and follows the standard `SKILL.md` specification:

1. **Create the skill folder**:
   ```bash
   mkdir -p skills/my-new-skill
   ```

2. **Create `skills/my-new-skill/SKILL.md`**:
   Copy from the included template in `skills/skill-template/template.md`:
   ```markdown
   ---
   name: my-new-skill
   description: >-
     Describe what the skill does and specific triggers.
     Example: "Automates API schema validation. Use when the user asks to validate OpenAPI specs."
   ---

   # Skill Title

   ## Workflow / Steps
   1. Step 1...
   2. Step 2...
   ```

3. **Validate the skill**:
   ```bash
   ./scripts/validate.sh
   ```

4. **Commit and Share**:
   ```bash
   git checkout -b feat/add-my-new-skill
   git add skills/my-new-skill
   git commit -m "feat(skills): add my-new-skill workflow"
   git push origin feat/add-my-new-skill
   ```
   Once merged to `main`, team members simply run `git pull` to get the new skill!

---

## 📂 Repository Layout

```text
Skill_model/
├── plugin.json                 # Antigravity plugin manifest
├── gemini-extension.json       # Gemini CLI extension manifest
├── mcp_config.json             # Shared MCP server configurations
├── AGENTS.md                   # Single source of truth for rules (symlinked to rules/AGENTS.md)
├── install.sh                  # 1-command installer script for members
├── uninstall.sh                # Clean uninstaller script
├── rules/
│   └── AGENTS.md               # Source of truth for team coding rules
├── skills/                     # Packaged skills
│   ├── code-review/
│   │   └── SKILL.md
│   ├── debugging-guide/
│   │   └── SKILL.md
│   ├── git-workflow/
│   │   └── SKILL.md
│   ├── skill-template/
│   │   ├── SKILL.md
│   │   └── template.md
│   └── test-generator/
│       └── SKILL.md
├── scripts/
│   └── validate.sh             # Lint & integrity checker
└── .claude-plugin/
    ├── marketplace.json        # Claude Code marketplace catalog
    └── plugin.json             # Claude Code plugin manifest
```

---

## ⚙️ Advanced Installer Options

### Install into a Specific Workspace / Project
To link the plugin directly into a specific repository rather than globally:
```bash
./install.sh --workspace /path/to/your/project
```

### Copy Instead of Symlinking
If working in an environment that restricts symbolic links:
```bash
./install.sh --copy
```

### Uninstallation
To cleanly remove all symlinks created by `install.sh`:
```bash
./uninstall.sh
```