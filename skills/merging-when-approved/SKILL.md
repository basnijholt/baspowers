---
name: merging-when-approved
description: Use when asked to review a pull request and merge it only if approved, or before merging a pull request you wrote or changed
---

# Merging When Approved

An approval belongs to one head SHA and one reviewer who did not write the code.
If you wrote or changed any commit in the PR, your own read is not a review, and neither is CI.

1. Pin the head: `HEAD_SHA=$(gh pr view <N> --json headRefOid -q .headRefOid)`.
2. In parallel, dispatch a fresh-context subagent (baspowers:requesting-code-review) and the opposite model family via baspowers:consulting-cross-model in review mode.
   Tell both: review the full diff at HEAD_SHA, report only real defects with file:line and a failing scenario, report over-engineering and scope creep, edit nothing, end with `VERDICT: APPROVE` or `VERDICT: CHANGES REQUIRED`.
   Ask them to label each finding `realistic` (normal configuration and use) or `edge case`, and to list problems outside the PR's change under `Out of scope`.
3. Validate findings (baspowers:receiving-code-review), fix valid realistic ones minimally, decline scope creep and edge cases with a reason on the PR, and record out-of-scope items for a separate PR.
4. Any push is a new head: go back to step 1.
5. Merge only when every reviewer approved the current head: `gh pr merge <N> --squash --match-head-commit "$HEAD_SHA"`, never `--admin`.
6. Report each verdict with its SHA, and the findings fixed and declined.

After three rounds with new defects, use baspowers:stopping-runaway-prs.

## Red Flags

| Thought | Reality |
|---|---|
| "One reviewer only, both won't fit in the time" | Both run in parallel; if they are not done in time, the PR waits. |
| "If you'd rather I merge on the old approval, say so" | Keep the gate and report its status instead of offering to lower it. |
| "Review just the delta since the last approval" | Review the full diff at the current head. |
