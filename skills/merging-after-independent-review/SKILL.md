---
name: merging-after-independent-review
description: Use when asked to review a pull request and merge it only if approved, or before merging a pull request you wrote or changed
---

# Merging After Independent Review

## Overview

"Review it and merge only if approved" means reviewers who did not write the code approve the exact commit that gets merged.

**Core principle:** An approval belongs to one head SHA and one independent reviewer.
If you wrote or changed any commit in the PR, your own read is not a review.

## The Gate

1. **Pin the head.**
   `HEAD_SHA=$(gh pr view <N> --json headRefOid -q .headRefOid)`
2. **Dispatch two independent reviewers in parallel.**
   Neither gets your session history.
   - A fresh-context subagent, using the baspowers:requesting-code-review template.
   - The opposite model family when available (Claude reviews Codex work and vice versa).
     Use the `agent-cli dev run` commands from baspowers:consulting-cross-model, with a review prompt instead of a question.
     A full review takes longer than a consultation, so raise the `timeout` to fit the diff.

   Each prompt contains: PR number, base and head SHA, the PR's goal, and these instructions: "Review the full diff at HEAD_SHA.
   Report only real defects with file:line and a concrete failing scenario.
   Report over-engineering and scope creep as findings.
   Do not edit anything.
   End with exactly `VERDICT: APPROVE` or `VERDICT: CHANGES REQUIRED`."
3. **Validate every finding** against the code (baspowers:receiving-code-review).
   Fix valid findings minimally.
   Decline scope creep with a one-line reason on the PR.
4. **Any push creates a new head.**
   Return to step 1.
   Earlier approvals are void.
5. **Merge only when every reviewer approved the current head:**
   `gh pr merge <N> --squash --match-head-commit "$HEAD_SHA"`
   Use another merge method only if the repository requires it.
   Never `--admin`.
6. **Report:** merge commit, each reviewer's verdict and SHA, findings fixed, findings declined.

If three rounds each surface new defects, stop patching and use baspowers:auditing-change-growth.

If only one model family is available, use two fresh subagents and say so in the report.

## Red Flags

| Thought | Reality |
|---|---|
| "I re-read the diff, it looks fine" | You are the author. That is not a review. |
| "CI is green" | CI is not a reviewer. |
| "Only a small fix since the approval" | New head, new review. |
| "Reviewer raised nothing serious" | No `VERDICT: APPROVE` line means no approval. |
| "My partner is in a hurry" | The two reviews run in parallel. Speed is not a reason to merge unreviewed code. |
