---
name: scanning-for-simplifications
description: Use when asked to find behavior-preserving simplifications at scale, such as a cleanup pass over a large pull request before it is called ready, or a codebase or architecture scan that may feed several parallel refactor pull requests
---

# Scanning for Simplifications

## Overview

Many independent read-only scanners find more than one careful reader, and their proposals are untrusted until proven.
Scanners anchored on earlier passes propose cosmetic edits, and unverified proposals quietly change behavior.

The most productive lens is **two owners of one fact**: state, rules, or logic kept in two places, plus the code that keeps them in step.
Deriving one from the other deletes the copy and the sync code, and often a bug.

**Not for:** a small diff (review it directly), bug hunts, or performance work.

## PR mode: cleanup scan before ready

Run it last, when everything else is done; gates that wait on a quiet host or a lease may run once afterwards, on the post-cleanup head.

1. **Freeze.** Check out the pushed head in a detached, read-only snapshot outside the live worktree.
2. **Slice.** Take every file the PR adds or changes, tests included, read whole rather than as hunks, and group them into 3 to 6 slices of related files.
3. **Launch all scanners at once.** Per slice, one scanner from each model family on the same slice. Add one pair over the whole diff that looks only for duplication across slices and against existing helpers.
4. **Brief.** Fill in [scanner-brief.md](scanner-brief.md) and add nothing else: no earlier rounds, reviews, known findings, or cap on the number of proposals. Deduplicate at triage instead.
5. **Triage.** Deduplicate, verify each proposal in the code, and accept only those that are clearly simpler with behavior unchanged. Give each rejection a one-line reason. Bugs found go to a separate list: fix test-first when the PR introduced them, otherwise report them.
6. **Apply** in small commits. Break every production branch the cleanup rewrote (not deleted) and confirm a test fails. Run the full suite and the required gates, and rerun any benchmark the cleanup's paths fall under.
7. **Review fresh.** Approvals from before the cleanup do not count. Every reviewer reviews the whole PR at the post-cleanup head; ready means all of them approve the same head.

## Architecture mode: survey, then refactor programs

1. **Survey.** Pin one SHA. Run read-only surveyors, one per area of about 30k lines, plus one whole-codebase surveyor on the two-owners lens. Use the finding format in [survey-brief.md](survey-brief.md).
2. **Refute before launching.** For each shortlisted finding, a fresh agent from the other model family tries to refute it; drop the refuted ones. When a design choice hinges on a cost, measure the real end-to-end path first, not one step of it.
3. **Select.** Launch a finding only when it is a real bug or removes a duplicate owner with meaningful size. Build a file-overlap matrix: run at most about 4 sessions at once, on disjoint files, with cross-cutting changes first and one hot-path change at a time. Send the user the ranked list with one question: do they accept the main-merge rule in step 5?
4. **Brief each session** with the session brief in [survey-brief.md](survey-brief.md).
5. **Merge one at a time.** Merging stays the user's decision unless they delegated it. A session takes a lock before it merges and releases it right after. After each merge, every open PR merges main (never a rebase) at once, because a conflicting PR gets no CI. The main-merge rule:
   - **Mechanical** (import and list unions, regenerated files) with the suite green: approvals stand, and earlier green CI stands too.
   - **Anything else:** every reviewer runs a blockers-only round on `git show --remerge-diff <merge>`, and CI must pass.

   The rule applies only once the user accepted it in step 3; until then, baspowers:merging-when-approved applies to every merge commit.
6. **Monitor.** A session is idle only when its thread is not running, none of its sub-agents runs, and its last message waits on nothing. A between-turns status alone means it waits on a job. Cap concurrent full test suites so benchmarks stay valid. Before offering a merge, ask the session whether the PR honestly makes the code better and simpler than main, and confirm the answer with an independent judge.
