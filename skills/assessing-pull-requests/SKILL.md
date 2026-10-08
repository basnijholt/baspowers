---
name: assessing-pull-requests
description: Use when asked whether a pull request or change is good, clean, big, risky, over-engineered, or worth merging
---

# Assessing Pull Requests

## Overview

Answer with a fixed scorecard, verdict first.
Size means net production code.
Tests and docs never count against a change.

## Gather

- **Size:** `git diff --numstat <base>...<head>`.
  Classify each file as production, test, or docs/config.
  Net production LOC = production lines added minus production lines deleted.
- **Cause:** which failure motivated the change, and whether the change removes its cause or hides its symptom.
- **Reviews:** who approved which SHA, and whether that SHA is the current head.
- **Evidence:** whether anything ran against a real system, or only mocks.

## Output Shape

Keep it under 200 words.

**Verdict:** merge / merge after <X> / don't merge, with one reason.

| Check | Answer |
|---|---|
| Production LOC (net) | +N across <files> |
| Tests / docs LOC | +N / +N, not a cost |
| User-visible change | |
| Root cause or bandage | |
| Over-engineered? | name the unneeded machinery, or "no" |
| Ownership and isolation | does the logic live in the component that owns it; does a failure stay contained |
| Existing behavior changed | |
| Live evidence | real system, or mocks only |
| Reviews | reviewer, SHA, current or stale |
| Risk / confidence | low, medium, or high, with one reason |

When the structure matters for the decision, add a tree of the changed production files with one line each, or the call path the change sits on.

Mark every claim you did not verify as **unverified**.

## Common Mistakes

- Leading with total lines changed when tests dominate the diff.
- Reporting gross additions instead of net production LOC.
- Writing paragraphs instead of the table.
