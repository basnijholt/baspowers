---
name: auditing-change-growth
description: Use when a pull request has grown well past its estimate, review rounds keep finding new defects, fixes keep spawning more fixes, or a change that claims to simplify code adds code
---

# Auditing Change Growth

## Overview

Growth and recurring review findings are design signals, not a to-do list.

**Core principle:** Before patching review round N, measure the change and decide whether its boundary is wrong.
Another round of targeted fixes is how a 300-line change becomes 3,000 lines.

## Trigger

Run this audit before writing any fix when one of these holds:

- Net production LOC exceeds twice the original estimate.
- A third review round finds new defects.
- A change described as a simplification adds net production code.

## The Audit

1. **Measure.**
   Net production LOC now, against the estimate and against the code it replaces.
   Count production files only: `git diff --numstat <base>...HEAD`.
2. **Cluster findings from every round.**
   Findings that share a root (one state machine, one missing owner, one duplicated invariant) mean the boundary is wrong, not the individual lines.
3. **Price the complexity.**
   List each mechanism and the guarantee it buys.
   Mark guarantees nobody asked for.
4. **Lay out options with net production LOC for each:**
   - keep patching;
   - restructure around the shared root;
   - shrink to the original goal and move the rest to follow-ups;
   - close and restart from a clean design.
5. **Send your human partner the numbers and one recommendation in under 150 words.**
   Choosing between these options changes scope, so wait for the choice before patching unless they already chose.

## Red Flags

| Thought | Reality |
|---|---|
| "They said fix these and merge" | They asked before seeing the PR is several times its estimate. Showing the numbers costs one message. |
| "Each fix is small" | Small fixes across seven rounds produced the growth. |
| "I'll root-cause these four issues" | The next round finds four more unless the boundary changes. |
| "Reviewers are just picky" | Defects that keep appearing in one area point to the design. |
