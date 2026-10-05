# Team AI Coding Standards & Guidelines

This document outlines team conventions and best practices for AI coding assistants working across our team's repositories.

---

## 1. Core Engineering Principles

- **Simplicity & YAGNI**: Build what is needed right now. Avoid speculative generalization, unnecessary boilerplate, or complex abstraction layers unless explicitly requested.
- **Standard Library First**: Prefer native language features and standard libraries before pulling in external dependencies.
- **Documentation Integrity**: Preserve existing comments, docstrings, and architectural rationale unless specifically asked to change or update them.
- **Verification First**: Verify all changes before considering a task complete (run linters, tests, or dry-run scripts).

---

## 2. Code Quality & Formatting

- Follow the naming and formatting conventions of the active codebase.
- Keep diffs small, focused, and minimal. Do not rewrite surrounding unrelated code.
- Always include appropriate error handling for edge cases, null checks, and failed I/O operations.
- Avoid hardcoding configuration values, secrets, or environment-specific paths.

---

## 3. Tool & Command Execution Safety

- Do not execute destructive commands (e.g. `rm -rf`, `git reset --hard`, `drop table`) without explicit validation or request.
- Test commands in isolated or scratch directories when investigating or prototyping.
- Before committing or pushing code, ensure automated test suites pass.

---

## 4. Git & Contribution Workflow

- Use conventional commits format:
  - `feat: <description>` for new capabilities
  - `fix: <description>` for bug fixes
  - `refactor: <description>` for code restructuring without behavior changes
  - `test: <description>` for adding or updating tests
  - `docs: <description>` for documentation updates
  - `chore: <description>` for maintenance and dependency updates
- Maintain clean, self-contained commits with concise, meaningful messages.
