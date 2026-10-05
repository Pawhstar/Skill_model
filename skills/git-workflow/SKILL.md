---
name: git-workflow
description: >-
  Standard team git workflow procedures for branches, conventional commits, merge conflicts, and PR creation.
  Use when the user asks to commit changes, create branches, resolve git conflicts, or draft a pull request description.
---

# Team Git Workflow & Commit Guidelines

This skill provides step-by-step procedures for managing version control operations safely and consistently across team repositories.

---

## 1. Branch Naming Conventions

Always create feature branches off the latest `main` (or default branch):

```bash
git checkout main
git pull origin main
git checkout -b <type>/<short-description>
```

Branch types:
- `feat/<topic>`: New features or capabilities (e.g. `feat/auth-token-refresh`)
- `fix/<topic>`: Bug fixes (e.g. `fix/null-pointer-profile-avatar`)
- `refactor/<topic>`: Code cleanups without behavior changes
- `chore/<topic>`: Dependency updates, CI, build configs

---

## 2. Conventional Commit Standards

Every commit message must follow the Conventional Commits format:

```text
<type>(<scope>): <concise description in imperative mood>

[optional body providing deeper rationale and context]

[optional footer(s), e.g., Closes #123]
```

### Types:
- `feat`: A new user-facing feature or API.
- `fix`: A bug fix.
- `refactor`: Code change that neither fixes a bug nor adds a feature.
- `perf`: A code change that improves performance.
- `test`: Adding missing tests or correcting existing tests.
- `docs`: Documentation-only changes.
- `chore`: Build processes, tooling, or auxiliary tools.

### Guidelines:
- Keep the first line under 72 characters.
- Use imperative mood: "add capability" not "added capability" or "adds capability".
- Do not commit secrets, `.env` files, or build artifacts.

---

## 3. Pre-Commit Checklist

Before staging and committing:
1. `git status`: Confirm only intended files are modified.
2. `git diff`: Review all changes line-by-line.
3. Run project test suites or linters.
4. Verify no stray `console.log`, `print`, or debug code is left behind.

---

## 4. Pull Request Description Template

When drafting a PR description, format it as follows:

```markdown
## Summary
Brief description of changes and motivation.

## Changes Made
- Point 1
- Point 2

## How to Test
1. Step 1
2. Step 2

## Checklist
- [ ] Tests added/updated and passing
- [ ] Documentation updated if needed
- [ ] No breaking changes (or migration notes provided)
```
