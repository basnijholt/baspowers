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

Run other-family scanners, refuters, and judges like baspowers:consulting-cross-model review mode: the same CLI call with `timeout 900`, the filled-in brief as the whole prompt, and no consultation limit.

**Not for:** a small diff (review it directly), bug hunts, or performance work.

## PR mode: cleanup scan before ready

Run it last, once everything else is done; checks that wait on shared resources may run once afterwards, on the post-cleanup head.

1. **Freeze.** Check out the pushed head in a detached, read-only snapshot outside the live worktree.
2. **Slice.** Take every file the PR adds or changes, tests included, and have scanners read each file whole, not as hunks.
   Group the files into slices of related files, about one per package or concern, and at most six.
3. **Launch the scanners together.** Per slice, one scanner from each model family on the same slice.
   Add one pair over the whole diff that looks only for duplication across slices and against existing helpers.
   If the host cannot run them all at once, run them in batches and wait for every one.
4. **Brief.** Fill in [scanner-brief.md](scanner-brief.md) and append only the project's own must-stay-unchanged rules to its behavior line.
   Mention no earlier rounds, reviews, or known findings, and set no cap on proposals; deduplicate at triage instead.
5. **Triage.** Deduplicate, verify each proposal in the code, and accept only those that are clearly simpler with behavior unchanged.
   Give each rejection a one-line reason.
   Bugs go to a separate list: fix test-first the ones the PR introduced, and report the rest.
6. **Apply** in small commits.
   Break each rewritten, not deleted, code path and confirm a test fails; if none fails, add a test or drop the rewrite.
   Run the full suite, the required gates, and any benchmark the cleanup's paths fall under.
7. **Review fresh** with baspowers:merging-when-approved.
   Approvals from before the cleanup do not count, and fixes from this review need no new scan.

## Architecture mode: survey, then refactor programs

1. **Survey.** Pin one SHA in a read-only snapshot.
   Run one surveyor per area of about 30k lines, plus one whole-codebase surveyor on the two-owners lens, each with [survey-brief.md](survey-brief.md).
2. **Refute.** For each shortlisted finding, a fresh agent from the other model family tries to refute it under the same read-only rules.
   Check each refutation in the code before dropping the finding.
   When a design choice hinges on a cost, measure the real end-to-end path first, not one step of it.
3. **Select.** Rank the surviving findings.
   If your human partner asked only for the scan, send the ranked list and stop.
   Otherwise launch a finding only when it is a real bug or deletes enough to matter.
   Build a file-overlap matrix and run at most about 4 sessions at once, each in its own worktree and on disjoint files, cross-cutting changes first and one hot-path change at a time.
4. **Brief each session** with the session brief in [survey-brief.md](survey-brief.md), including any main-merge rule your human partner set.
5. **Merge one at a time.** Merging stays your human partner's decision unless they delegated it.
   Hold a lock from the final check through the merge, and merge only a head that contains current main.
   After each merge, every open PR merges main, never rebases, because a conflicting PR gets no CI.
   Each merge of main is a new head: follow your human partner's main-merge rule if they set one, and baspowers:merging-when-approved otherwise.
6. **Monitor.** A session is idle only when its thread is not running, none of its sub-agents runs, and its last message waits on nothing.
   A between-turns status alone does not mean idle; the session may be waiting on a job.
   Cap concurrent full test suites so benchmarks stay valid.
   Before offering a merge, require the session's verdict from the last gate of its brief.
