# Session brief

Each session delivers one item as one pull request, in its own worktree, and edits only the files it owns; it reports before touching any other file.
It gets its item as claims to re-verify, the files it owns, its live scenario, any main-merge rule and any contract break your human partner authorized, and these gates:

1. Re-verify the item at current main: a bug with a failing test at the interface callers use, a refactor finding by reading the code.
   If it no longer holds, report and stop.
2. For a refactor, pin the behavior being restructured with tests at the interface callers use, passing on main before any change.
   For a bug, fix the root cause with the smallest change.
3. Fix, test first, the bugs the session introduces.
   Report every other bug, including ones already on the item's paths, instead of fixing it, unless the brief authorizes the fix.
4. Delete the old internal path completely: no shims, aliases, or dual paths kept for old internal callers or tests.
   Public contracts (CLI, configuration, wire formats, names other repositories import) stay, unless the brief authorizes breaking one.
5. When two designs differ in cost, measure the real end-to-end path before choosing.
6. Before the first review: full suite, lint, type and boundary checks, a mutation check of every changed code path, and the benchmark when the change touches a hot path.
7. Review every head with steps 1 to 4 and 6 of baspowers:merging-when-approved, with reviewers from both model families, and use baspowers:stopping-runaway-prs when its triggers fire.
   A finding that describes a failure counts only when a normal configuration and normal use reach it and its worst effect is a crash or hang, lost or corrupted data, a lost, duplicated, or misdirected result, or a security hole.
   Decline every other failure finding on the pull request with that reason; a declined finding is not a new defect.
   The session never merges.
8. Merge main, never rebase, when it conflicts and right before the final check.
   Each merge of main follows the main-merge rule in this brief, or baspowers:merging-when-approved when none was set.
9. Ready means, in this order: all reviewers approved one head; the PR-mode cleanup scan of baspowers:scanning-for-simplifications ran once over that approved diff; all reviewers approved the post-cleanup head; live evidence from the item's live scenario covers the final head, with a contrast run on main for a bug; CI is green; and bot review threads are answered.
   A fix after the scan needs a new review round, not a new scan; a wording-only commit needs neither.
   The pull request body states every behavior change, the net production and test lines, and the benchmark result.
10. Report a first line of `VERDICT: better and simpler` or `VERDICT: not better and simpler` with the reasons, then each reviewer's verdict with the SHA it reviewed, the CI state, the live evidence, and `Open items:` with everything you noticed and left, or `none`.
    Have an independent judge from the other model family confirm the verdict with this brief:

```text
Judge whether one pull request makes the code better and simpler than main. Read only: the repository snapshot at {SNAPSHOT} holds main at {BASE} and the pull request at {HEAD}; look at nothing else. Answer with a first line of `VERDICT: better and simpler` or `VERDICT: not better and simpler`, then the reasons as path:line references.

You only read: no edits, no tests, no package installs, no commits, nothing posted anywhere. Never delete with a relative path, run probes only in a fresh temporary directory, stop only processes you started, and never sleep for a guessed duration.
```
