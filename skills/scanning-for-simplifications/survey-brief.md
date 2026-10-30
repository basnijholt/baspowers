# Survey and refuter briefs

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

## Refuter brief

```text
Try to refute one architecture finding against the repository snapshot at {SNAPSHOT}, commit {SHA}. Read only. Read the project's agent instructions file first.

Finding: {FINDING}

Look for callers, consumers, configuration, persisted data, and recorded decisions that need the current design, and check whether the proposed end state is actually simpler. Answer with a first line of `REFUTED` or `STANDS`, then the evidence as path:line references.

You only read: no edits, no tests, no package installs, no commits, nothing posted anywhere. Never delete with a relative path, run probes only in a fresh temporary directory, stop only processes you started, and never sleep for a guessed duration.
```
