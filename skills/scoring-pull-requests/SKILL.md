---
name: scoring-pull-requests
description: Use when asked whether a pull request or change is good, clean, big, risky, over-engineered, or worth merging
---

# Scoring Pull Requests

Answer in under 200 words: a verdict line (merge / merge after X / don't merge, one reason), then this table.
Size is net production LOC from `git diff --numstat`; tests and docs are not a cost.

| Check | Answer |
|---|---|
| Production LOC (net) | |
| Tests / docs LOC | |
| User-visible change | |
| Root cause or bandage | |
| Over-engineered? | |
| Ownership and isolation | |
| Existing behavior changed | |
| Live evidence | |
| Reviews (SHA, current or stale) | |
| Risk / confidence | |

Mark anything not verified as **unverified**.
