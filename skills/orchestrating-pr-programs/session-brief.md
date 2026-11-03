# Session brief

Each session delivers one item as one pull request, in its own worktree, and edits only the files it owns; it reports before touching any other file.
An item is a refactor finding, a bug, a doc or test fix, or a follow-up issue of several of these.
The session gets its item as claims to re-verify, the files it owns, its live scenario when the change touches runtime code, the host's limits on agent slots, full test suites, and benchmarks and how to get a slot, any main-merge rule and any contract break the human partner authorized, and these gates:

1. Re-verify each claim at current main: a bug with a failing test at the interface callers use, anything else by reading the code.
   Drop a claim that no longer holds and say why; if none holds, report and stop.
2. For a refactor, pin the behavior being restructured with tests at the interface callers use, passing on main before any change.
   For a bug, fix its root cause with the smallest change.
3. Fix, test first, every regression the session introduces: behavior that works on main and breaks on the branch.
   A failure only on a path the branch adds is not a regression; the bar in gate 7 decides it.
   Report every other bug, including ones already on the item's paths, instead of fixing it, unless the item includes it.
4. When the change replaces a code path, delete the old one completely: no shims, aliases, or dual paths kept for old internal callers or tests.
   Public contracts (CLI, configuration, wire formats, names other repositories import) stay, unless the brief authorizes breaking one.
5. When two designs differ in cost, measure the real end-to-end path before choosing.
6. Before the first review: full suite, the project's lint, type, and boundary checks, a mutation check of every changed code path, and the benchmark when the change touches a hot path.
7. Review every head with steps 1 to 4 and 6 of baspowers:merging-when-approved, with reviewers from both model families, and use baspowers:stopping-runaway-prs when its triggers fire.
   Reviewers report every finding and mark the failures that meet this bar, which decides what step 3 there calls valid: apart from regressions (gate 3), a failure counts only when its worst effect is a crash or hang, lost or corrupted user data, a wrong, lost, duplicated, or misdirected result, or a security hole, and a normal configuration reaches it through normal use or, for a security hole, through an attacker; a missing log, metric, or diagnostic line does not count.
   Decline every other failure finding on the pull request with that reason and give the reviewer the reasons in its next run; its approval still needs `VERDICT: APPROVE`, and if it still holds the finding, ask the orchestrator to rule.
   Report every security hole the item does not fix to the orchestrator privately, whatever the bar says, and never describe it in an issue, pull request, or comment.
   The session never merges.
8. Merge main, never rebase, when it conflicts and right before the review round you expect to be the last.
   Each merge of main follows the main-merge rule in this brief, or baspowers:merging-when-approved when none was set.
9. Ready means, in this order: all reviewers approved one head; the PR-mode cleanup scan of baspowers:scanning-for-simplifications ran once over that approved diff and scanned every slice; all reviewers approved the post-cleanup head, unless the scan changed nothing; when the change touches runtime code, live evidence from the item's live scenario covers the final head, with a contrast run on main for a bug; CI is green; and bot review threads are answered.
   A fix after the scan needs a new review round, not a new scan, and a main merge that the main-merge rule accepts without review needs no new live evidence.
   The pull request body states every behavior change, the net production and test lines, and the benchmark result when one ran.
10. Report a first line with the verdict, then the reasons, each reviewer's verdict with the SHA it reviewed, the judge's verdict with the SHA it judged, the cleanup scan's head and whether it changed anything, the CI and bot-thread state, and the live evidence.
    A refactor reports `VERDICT: better and simpler` or `VERDICT: not better and simpler`; any other item reports `VERDICT: smallest root fix` or `VERDICT: not the smallest root fix`.
    Have an independent judge from the other model family confirm the verdict, run with the CLI and `timeout 900` that baspowers:consulting-cross-model review mode uses; its whole prompt is the judge brief below, kept outside the snapshot, followed by the item's text for any item but a refactor.
    {QUESTION} is "makes the code better and simpler than main" for a refactor and "fixes the item quoted after this brief at its root cause with the smallest change" for any other item; {YES} and {NO} are that item kind's two verdict lines above.

```text
Judge whether one pull request {QUESTION}. Read only: the repository snapshot at {SNAPSHOT} holds main at {BASE} and the pull request at {HEAD}; look at nothing else. Answer with a first line of `{YES}` or `{NO}`, then the reasons as path:line references.

You only read: no edits, no tests, no package installs, no commits, nothing posted anywhere. Never delete with a relative path, run probes only in a fresh temporary directory, stop only processes you started, and never sleep for a guessed duration.
```
