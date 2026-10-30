# Survey and session briefs

## Survey brief

Send one per area, filled in and unchanged; the whole-codebase surveyor gets "the whole repository, two owners of one fact only" as its area.

```text
Survey {AREA} of the repository snapshot at {SNAPSHOT}, commit {SHA}, for architecture simplifications. Read only.

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

Each refactor session gets its finding as claims to re-verify, the files it owns, and these gates:

1. Re-verify the finding at current main. If the premise no longer holds, report and stop.
2. Pin the behavior being restructured with tests at the owning seam, passing on main before any change.
3. For each bug found, write the failing test first, then fix it.
4. Delete the old path completely: no shims, aliases, or dual paths kept for old callers or old tests.
5. When two designs differ in cost, measure the real end-to-end path before choosing.
6. Before the first review: full suite, lint, type and boundary checks, a mutation check of every changed branch, and the benchmark when the change touches a hot path.
7. Review every head with baspowers:merging-when-approved, with reviewers from both model families, and use baspowers:stopping-runaway-prs when its triggers fire.
8. Ready means the PR-mode cleanup scan ran last, then all reviewers approved the same post-cleanup head, CI is green, and bot review threads are answered. The PR body states every behavior change, the net production and test lines, and the benchmark result.
9. Report a first line of `VERDICT: better and simpler` or `VERDICT: not better and simpler`, confirmed by an independent judge that sees only main and the diff.
