name: feedback-analyze
description: >-
  Conduct a comprehensive and practical code review regarding feedback, ideas, and improvements.
Utilized when a user requests an evaluation of feedback, ideas, or improvements for the product.
---
# Team Code Review Runbook

This skill guides the AI assistant in feedback,ideas or improvement through, reviews aligned with team standards.

---
## 1. Review feedback,ideas or improvements.
Evaluate the feedback against the following seven core rules:

The 7 core rules (each scored 1 to 5):

### 1.Real problem: Is there a specific pain behind the request, and who has it?
### 2.Quality of signal: Is it a pattern or one loud voice? What people did counts for more than what they said.
### 3.Fit: Does it serve your product's purpose and target user?
### 4.Impact: How many people it reaches, how often, and how much it improves things for them.
### 5.Cost and complexity: What it really takes to build and to own, including the hidden work.
### 6.Risk and side effects: What could break or confuse people, and whether you can undo it.
### 7.Timing and opportunity cost: Why now, and what you give up by doing it.

Verdicts it can give: Do now, Test first, Reshape, Park, or Decline. It does not average the scores. A very weak score on Real problem or Fit usually decides the verdict.

Output format:

Verdict with a one-line reason
What the feedback is really about
Scorecard table
Next steps
A short draft reply you can send back to the person who gave the feedback
One insight "most people miss"