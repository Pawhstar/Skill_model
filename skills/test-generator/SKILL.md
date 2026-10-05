---
name: test-generator
description: >-
  Generates robust unit, integration, and regression tests following team standards.
  Use when asked to write tests, increase test coverage, or test-drive new features and bug fixes.
---

# Automated Test Generation & Testing Runbook

This skill outlines guidelines for generating comprehensive, reliable, and maintainable test suites.

---

## 1. Core Testing Guidelines

- **Arrange-Act-Assert (AAA)**:
  - **Arrange**: Set up prerequisites, mock objects, and test inputs.
  - **Act**: Execute the specific function or code under test.
  - **Assert**: Verify expected return values, state changes, or emitted errors.
- **Deterministic & Isolated**: Tests must not rely on execution order or shared mutable state. Mock out network calls, file system side-effects, and random generators where appropriate.
- **Minimal Mocking**: Prefer testing real logic; mock only external boundaries (HTTP requests, external databases, third-party APIs).
- **Descriptive Test Names**: Name tests to explain the behavior being tested:
  - Good: `test_calculate_total_applies_discount_when_coupon_valid()`
  - Bad: `test_total()`

---

## 2. Test Coverage Matrix

For any function or module, ensure tests cover:
1. **Happy Path**: Standard valid input producing expected output.
2. **Boundary Conditions**: Min/max values, zero, empty arrays, single-element collections.
3. **Invalid Inputs & Edge Cases**: `null`, `undefined`, unexpected types, out-of-range values.
4. **Error & Exception Handling**: Verifying that invalid operations raise the expected errors with proper messages.
5. **Concurrency / Async**: Testing timeouts, rejected promises, or race conditions.

---

## 3. Workflow Steps

1. **Detect Testing Framework**:
   - Inspect repository config (`package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, etc.) to identify the runner (e.g. `pytest`, `vitest`, `jest`, `cargo test`, `go test`).
2. **Review Target Implementation**:
   - Examine public methods, signatures, and edge cases.
3. **Draft Tests**:
   - Follow existing project conventions for test location (e.g. `tests/`, `__tests__/`, or sibling `*.test.ts`).
4. **Execute & Validate**:
   - Run the test suite and verify all new tests pass.
   - Intentionally verify that tests fail if expectations are broken (sanctity check).
