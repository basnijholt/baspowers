# Survey and session briefs

## Survey brief

Send one per area, filled in.
The whole-codebase surveyor gets "the whole repository, two owners of one fact only" as its area.

```text
Survey {AREA} of the repository snapshot at {SNAPSHOT}, commit {SHA}, for architecture simplifications. Read only. Read the project's agent instructions file first.

A finding qualifies when something disappears (an owner, layer, concept, flag, branch, or duplicate path) and the reason it was added no longer holds. Style, renames alone, abstractions for future flexibility, and hardening do not qualify.

Rank findings by value. For each finding report:
- Title: the end state, for example "X becomes the only owner of Y".
- Evidence: path:line references, symbols, and call-site counts, with the search commands you ran.
- Origin: the change that introduced it, its stated reason, and whether that reason still holds.
- Cost today: what one change must touch now, and any bug the design causes, marked reproduced or inferred.
- Change: the concrete end state and what callers see.
- Disappears: the modules, functions, flags, and branches deleted, with estimated net production and test lines.
- Footprint: the files touched and the public surfaces hit (configuration, CLI, HTTP or wire formats, persisted data, names other repositories import).
- Effort, risk, and confidence, saying what you verified and what you assumed.

Then list the candidates you rejected, one line each with the reason, and real bugs found along the way in their own section.

You only read: no edits, no tests, no package installs, no commits, nothing posted anywhere. Never delete with a relative path, run probes only in a fresh temporary directory, stop only processes you started, and never sleep for a guessed duration.
```

## Session brief

Each refactor session works in its own worktree.
It gets its finding as claims to re-verify, the files it owns, the main-merge rule if your human partner set one, and these gates:

1. Re-verify the finding at current main.
   If the premise no longer holds, report and stop.
2. Pin the behavior being restructured with tests at the interface callers use, passing on main before any change.
3. Fix, test first, only the bugs on the finding's code paths and the ones the session introduced.
   Report any other bug instead of fixing it.
4. Delete the old internal path completely: no shims, aliases, or dual paths kept for old internal callers or tests.
   A public contract that other repositories use stays, unless your human partner authorized breaking it.
5. When two designs differ in cost, measure the real end-to-end path before choosing.
6. Before the first review: full suite, lint, type and boundary checks, a mutation check of every changed code path, and the benchmark when the change touches a hot path.
7. Review every head with steps 1 to 4 of baspowers:merging-when-approved, with reviewers from both model families, and use baspowers:stopping-runaway-prs when its triggers fire.
   The session never merges; merging belongs to the orchestrator.
8. Merge main whenever main moves, and treat each merge of main under the main-merge rule, or under baspowers:merging-when-approved when no rule was set.
9. Ready means all reviewers approved the same final head, CI is green, and bot review threads are answered.
   The PR-mode cleanup scan ran last, before that final review.
   The PR body states every behavior change, the net production and test lines, and the benchmark result.
10. Report a first line of `VERDICT: better and simpler` or `VERDICT: not better and simpler`, confirmed by an independent judge that sees only main and the diff.
