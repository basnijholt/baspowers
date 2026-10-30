# Session brief

Each refactor session works in its own worktree and edits only the files it owns; it reports before touching any other file.
It gets its finding as claims to re-verify, the files it owns, any main-merge rule and any contract break your human partner authorized, and these gates:

1. Re-verify the finding at current main.
   If the premise no longer holds, report and stop.
2. Pin the behavior being restructured with tests at the interface callers use, passing on main before any change.
3. Fix, test first, the bugs the session introduces.
   Report every other bug, including ones already on the finding's paths, instead of fixing it, unless the brief authorizes the fix.
4. Delete the old internal path completely: no shims, aliases, or dual paths kept for old internal callers or tests.
   Public contracts (CLI, configuration, wire formats, names other repositories import) stay, unless the brief authorizes breaking one.
5. When two designs differ in cost, measure the real end-to-end path before choosing.
6. Before the first review: full suite, lint, type and boundary checks, a mutation check of every changed code path, and the benchmark when the change touches a hot path.
7. Review every head with steps 1 to 4 and 6 of baspowers:merging-when-approved, with reviewers from both model families, and use baspowers:stopping-runaway-prs when its triggers fire.
   The session never merges.
8. Merge main, never rebase, when it conflicts and right before the final check.
   Each merge of main follows the main-merge rule in this brief, or baspowers:merging-when-approved when none was set.
9. Ready means the PR-mode cleanup scan ran last, then all reviewers approved the same final head, CI is green, and bot review threads are answered.
   The PR body states every behavior change, the net production and test lines, and the benchmark result.
10. Report a first line of `VERDICT: better and simpler` or `VERDICT: not better and simpler` with the reasons, and have an independent judge from the other model family confirm it with this brief:

```text
Judge whether one pull request makes the code better and simpler than main. Read only: the repository snapshot at {SNAPSHOT} holds main at {BASE} and the pull request at {HEAD}; look at nothing else. Answer with a first line of `VERDICT: better and simpler` or `VERDICT: not better and simpler`, then the reasons as path:line references.

You only read: no edits, no tests, no package installs, no commits, nothing posted anywhere. Never delete with a relative path, run probes only in a fresh temporary directory, stop only processes you started, and never sleep for a guessed duration.
```
