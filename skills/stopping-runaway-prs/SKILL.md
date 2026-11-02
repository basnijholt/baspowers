---
name: stopping-runaway-prs
description: Use when a pull request has grown well past its estimate, review rounds keep finding new defects, fixes keep spawning more fixes, a change that claims to simplify code adds code, or your human partner asks why a pull request is so large or needs so many review rounds
---

# Stopping Runaway PRs

Recurring review findings, bandages, and unrequested scope are design signals; size alone is not.
Audit before writing any fix when a third review round finds new defects, fixes keep spawning fixes, a fix works around a bug instead of removing its cause, or the diff holds work nobody asked for.
When a requested feature needs more code than estimated, or a simplification adds lines but leaves the code clearly simpler, keep going.

1. Measure net production LOC against the estimate (`git diff --numstat <base>...HEAD`, production files only), and name where the growth came from.
2. Cluster findings from all rounds; a shared root means the boundary is wrong.
3. Price the options with net LOC each: keep patching, restructure around the root, shrink to the original goal, or restart clean.
4. Choose one yourself. If the choice stays ambiguous, use baspowers:consulting-cross-model, then decide.
5. Carry it out, and tell your human partner the numbers and the choice in under 150 words.
   Wait for them only when the consult leaves the choice open or the choice adds scope they never asked for.

## Red Flags

| Thought | Reality |
|---|---|
| "Doing the four fixes now, and I'll flag the risk alongside" | Patching first is the next round of the same loop. Audit first. |
| "Ship it behind a flag for the deadline, redesign after" | That is one option to price in the audit, not a decision to make by patching. |
| "If the next round finds more, then we stop" | Every earlier round could have said that. Stop now. |
