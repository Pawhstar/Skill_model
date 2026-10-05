---
name: code-review
description: >-
  Conducts a comprehensive, actionable code review on modified files, diffs, or proposed pull requests.
  Use when the user asks to review code, inspect a git diff, evaluate PR readiness, or check code quality.
---

# Team Code Review Runbook

This skill guides the AI assistant in performing thorough, constructive, and actionable code reviews aligned with team standards.

---

## 1. Review Dimensions

Evaluate code against the following five core dimensions:

### A. Correctness & Reliability
- Are edge cases handled (empty lists, null/undefined values, unexpected types)?
- Are errors and exceptions caught and handled properly without swallowing critical failures?
- Are resources (file handles, database connections, streams) cleaned up?
- Is state mutation thread-safe or free of race conditions?

### B. Security & Safety
- Are external inputs sanitized and validated (SQL injection, XSS, command injection)?
- Are credentials, API tokens, or secrets excluded from version control?
- Are permissions, authentication, and authorization checks enforced?

### C. Performance & Resource Efficiency
- Are there unnecessary quadratic ($O(N^2)$) loops, duplicate API calls, or redundant database queries?
- Is memory allocated efficiently without leaks?
- Are standard library or native methods leveraged instead of costly custom algorithms?

### D. Maintainability & Simplicity
- Does the code adhere to YAGNI (You Aren't Gonna Need It)? Does it introduce speculative complexity?
- Are functions single-purpose and reasonably sized?
- Are variable and function names self-documenting and consistent with the codebase?
- Are existing comments and architectural patterns preserved?

### E. Testability & Verification
- Are new features or bug fixes accompanied by automated tests?
- Are edge cases and failure paths tested?

---

## 2. Review Process

1. **Inspect Changes**:
   - Run `git diff` or review the target files using file viewing tools.
2. **Analyze Context**:
   - Understand the intent of the change and surrounding architecture.
3. **Formulate Findings**:
   - Categorize issues by severity:
     - 🔴 **Critical**: Bugs, crashes, security vulnerabilities, or data loss risks.
     - 🟡 **Warning**: Performance bottlenecks, edge case omissions, or architectural flaws.
     - 🟢 **Suggestion**: Readability, minor style improvements, or refactoring opportunities.
4. **Deliver Constructive Feedback**:
   - Provide concrete file references and line numbers.
   - Include code diffs or snippet examples showing how to resolve the issue.
