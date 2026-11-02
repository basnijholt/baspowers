# Session brief

Each session delivers one item as one pull request, in its own worktree, and edits only the files it owns; it reports before touching any other file.
An item is a refactor finding, a bug, or a follow-up issue of several fixes.
The session gets its item as claims to re-verify, the files it owns, its live scenario when the change alters runtime behavior, the host's limits on full test suites and benchmarks and how to get a slot, any main-merge rule and any contract break your human partner authorized, and these gates:

1. Re-verify the item at current main: a bug with a failing test at the interface callers use, a refactor finding or a doc or test fix by reading the code.
   If it no longer holds, report and stop.
2. For a refactor, pin the behavior being restructured with tests at the interface callers use, passing on main before any change.
   For a bug, fix its root cause with the smallest change.
3. Fix, test first, every regression the session introduces: behavior that works on main and breaks on the branch.
   Report every other bug, including ones already on the item's paths, instead of fixing it, unless the item includes it.
4. When the change replaces a code path, delete the old one completely: no shims, aliases, or dual paths kept for old internal callers or tests.
   Public contracts (CLI, configuration, wire formats, names other repositories import) stay, unless the brief authorizes breaking one.
5. When two designs differ in cost, measure the real end-to-end path before choosing.
6. Before the first review: full suite, the project's lint, type, and boundary checks, a mutation check of every changed code path, and the benchmark when the change touches a hot path.
7. Review every head with steps 1 to 4 and 6 of baspowers:merging-when-approved, with reviewers from both model families, and use baspowers:stopping-runaway-prs when its triggers fire.
   Give the reviewers this bar: apart from regressions (item 3), a failure finding counts only when its worst effect is a crash or hang, lost or corrupted user data, a lost, duplicated, or misdirected result, or a security hole, and a normal configuration reaches it through normal use or, for a security hole, through an attacker; a missing log or diagnostic line does not count.
   Decline every other failure finding on the pull request with that reason, then rerun that reviewer on the same head with the reasons; its approval still needs `VERDICT: APPROVE`.
   Never describe a security hole in a public issue or comment; report it to your human partner.
   The session never merges.
8. Merge main, never rebase, when it conflicts and right before the final check.
   Each merge of main follows the main-merge rule in this brief, or baspowers:merging-when-approved when none was set.
9. Ready means, in this order: all reviewers approved one head; the PR-mode cleanup scan of baspowers:scanning-for-simplifications ran once over that approved diff; all reviewers approved the post-cleanup head, unless the scan changed nothing; when the change alters runtime behavior, live evidence from the item's live scenario covers the final head, with a contrast run on main for a bug; CI is green; and bot review threads are answered.
   A fix after the scan needs a new review round, not a new scan, and a main merge that the main-merge rule accepts without review needs no new live evidence.
   The pull request body states every behavior change, the net production and test lines, and the benchmark result when one ran.
10. Report a first line with the verdict, then the reasons, each reviewer's verdict with the SHA it reviewed, the CI state, and the live evidence.
    A refactor reports `VERDICT: better and simpler` or `VERDICT: not better and simpler`; a bug or follow-up fix reports `VERDICT: smallest root fix` or `VERDICT: not the smallest root fix`.
    Have an independent judge from the other model family confirm the verdict, run with baspowers:consulting-cross-model in review mode and this brief, where {QUESTION} is "makes the code better and simpler than main" for a refactor, or "fixes the item quoted after this brief at its root cause with the smallest change" for a fix, and {YES} and {NO} are the two verdicts above:

```text
Judge whether one pull request {QUESTION}. Read only: the repository snapshot at {SNAPSHOT} holds main at {BASE} and the pull request at {HEAD}; look at nothing else. Answer with a first line of `VERDICT: {YES}` or `VERDICT: {NO}`, then the reasons as path:line references.

You only read: no edits, no tests, no package installs, no commits, nothing posted anywhere. Never delete with a relative path, run probes only in a fresh temporary directory, stop only processes you started, and never sleep for a guessed duration.
```
