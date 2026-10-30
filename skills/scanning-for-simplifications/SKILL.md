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

Run other-family scanners, surveyors, refuters, and judges with the CLI that baspowers:consulting-cross-model review mode uses, started from the snapshot, with `timeout 900`, the filled-in brief as the whole prompt, and no consultation limit.
A timeout, an error, or an empty report means that scope was not scanned: rerun it, narrower if needed.

**Not for:** bug hunts or performance work.

## PR mode: cleanup scan before ready

Run it last, once everything else is done; checks that wait on shared resources may run once afterwards, on the post-cleanup head.

1. **Freeze.** Check out the pushed head in a detached, read-only snapshot outside the live worktree.
2. **Slice.** Take every file the PR adds or changes, tests included; scanners read each file whole, not as hunks.
   Group the files into slices of related files: one slice for a small PR, otherwise about one per package or concern, and at most six.
3. **Brief.** Fill in [scanner-brief.md](scanner-brief.md) and append only the project's own must-stay-unchanged rules to its behavior line.
   Mention no earlier rounds, reviews, or known findings, and set no cap on proposals; deduplicate at triage instead.
4. **Launch the scanners together.** Per slice, one scanner from each model family on the same slice, plus one pair over the whole diff with the duplication scope from the brief.
   If the host cannot run them all at once, run them in batches, and wait for every report.
5. **Triage.** If your human partner asked only for findings, report them and stop.
   Otherwise deduplicate, verify each proposal in the code, and accept only those that are clearly simpler with behavior unchanged; give each rejection a one-line reason.
   Bugs go to a separate list: fix test-first the ones the PR introduced, and report the rest.
   If the accepted set grows production code overall, baspowers:stopping-runaway-prs applies.
6. **Apply** in small commits.
   Break each rewritten, not deleted, code path and confirm a test fails.
   If none fails, add a test that passes on the pre-cleanup head and fails on the broken rewrite, or drop the rewrite.
   Run the full suite, the required gates, and any benchmark the cleanup's paths fall under.
7. **Review fresh** with steps 1 to 4 and 6 of baspowers:merging-when-approved, and merge only when asked.
   The scan runs once: approvals from before it do not count, and fixes from this review need no new scan.

## Architecture mode: survey, then refactor programs

1. **Survey.** Pin one SHA in a read-only snapshot.
   Run one surveyor per area of about 30k lines, plus one whole-codebase surveyor on the two-owners lens, each with [survey-brief.md](survey-brief.md).
2. **Refute.** For each shortlisted finding, a fresh agent from the other model family runs the refuter brief in [survey-brief.md](survey-brief.md).
   Check each refutation in the code before dropping the finding.
   When a design choice hinges on a cost, measure the real end-to-end path first, not one step of it.
3. **Select.** Write the ranked list to a file.
   If your human partner asked only for the scan, send the top five with the file's path, and stop.
   Otherwise launch a finding only when it deletes enough to matter, and send real bugs to the bug list instead.
   Build a file-overlap matrix and run at most about 4 sessions at once, each in its own worktree and on disjoint files, cross-cutting changes first and one hot-path change at a time.
4. **Brief each session** with [session-brief.md](session-brief.md), including any main-merge rule and any contract break your human partner authorized.
5. **Merge one at a time**, as your human partner decides, and right before each merge confirm that the head contains current main.
   Each merge of main into a PR is a new head: follow your human partner's main-merge rule if they set one, and baspowers:merging-when-approved otherwise.
6. **Monitor.** A session is idle only when its thread is not running, none of its sub-agents runs, and its last message waits on nothing; a between-turns status alone does not mean idle.
   Cap concurrent full test suites so benchmarks stay valid.
   Offer a merge only when the session reports `VERDICT: better and simpler` and its judge agrees; otherwise stop that PR and report why.
