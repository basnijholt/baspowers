---
name: stopping-runaway-prs
description: Use when a pull request has grown well past its estimate, review rounds keep finding new defects, fixes keep spawning more fixes, or a change that claims to simplify code adds code
---

# Stopping Runaway PRs

Growth and recurring review findings are design signals.
When net production LOC exceeds twice the estimate, a third review round finds new defects, or a "simplification" adds code, audit before writing any fix:

1. Measure net production LOC against the estimate (`git diff --numstat <base>...HEAD`, production files only).
2. Cluster findings from all rounds; a shared root means the boundary is wrong.
3. Give options with net LOC each: keep patching, restructure around the root, shrink to the original goal, or restart clean.
4. Send your human partner the numbers and one recommendation in under 150 words, and wait for the choice before patching.
   "Fix these and merge" was said before they saw the numbers.

## Red Flags

| Thought | Reality |
|---|---|
| "Doing the four fixes now, and I'll flag the risk alongside" | Patching first is the next round of the same loop. Audit first. |
| "Ship it behind a flag for the deadline, redesign after" | That is one option to price in the message, not a decision to make by patching. |
| "If the next round finds more, then we stop" | Every earlier round could have said that. Stop now. |
