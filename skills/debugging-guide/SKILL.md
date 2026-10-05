---
name: debugging-guide
description: >-
  Systematic debugging methodology for investigating crashes, unexpected behaviors, and test failures.
  Use when the user reports a bug, an error trace, an unexplained failure, or asks for root-cause analysis.
---

# Systematic Debugging & Root Cause Analysis

This skill provides a structured method for tracking down and resolving defects efficiently.

---

## 1. The 5-Step Debugging Cycle

```text
[Reproduce] ➔ [Isolate] ➔ [Hypothesize] ➔ [Fix Root Cause] ➔ [Verify & Prevent]
```

### Step 1: Reproduce Reliably
- Formulate the minimal set of steps or minimal test case required to trigger the bug.
- Capture the exact error message, stack trace, and environment state.
- If nondeterministic, identify the variable factors (timing, concurrency, cached state, network latency).

### Step 2: Isolate the Fault Domain
- Narrow down the code path responsible for the erroneous state.
- Check recent commits (`git log -p`, `git bisect`) if the defect is a regression.
- Inspect inputs and outputs across function boundaries.

### Step 3: Formulate & Test Hypotheses
- State a clear hypothesis: *"The crash occurs because variable X is nil when Y event fires before Z."*
- Test the hypothesis using targeted assertions, log statements, or debugger checkpoints.
- Reject assumptions that are disproven by evidence.

### Step 4: Fix the Root Cause
- Address the underlying mechanism, not just the visible symptom.
- Avoid introducing defensive workarounds (`if (!val) return;`) that mask underlying architectural issues unless that is the intended design.
- Keep the fix minimal, targeted, and self-contained.

### Step 5: Verify & Add Regression Tests
- Re-run the reproduction test case to confirm the fix works.
- Add an automated regression test so the issue cannot reoccur unnoticed.
- Run the full test suite to guarantee zero side-effects or regressions in unrelated features.
