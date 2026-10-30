# Scanner brief

Copy this brief, fill in the braces, and send it unchanged to every scanner.
The slice scanners get a file list as `{SCOPE}`; the duplication pair gets "the whole diff: look only for logic duplicated across these files or repeating an existing helper elsewhere in the repository".

```text
Find simplifications in one pull request that keep its behavior identical.

Inputs, read-only: the repository snapshot at {SNAPSHOT}, commit {HEAD}; the pull request's merge base is {BASE} (`git -C {SNAPSHOT} diff {BASE} {HEAD} -- <path>` shows one file's changes). Read the project's agent instructions file first.

Scope: {SCOPE}
Read every file in scope whole, not only its changed hunks, and follow callers and callees anywhere in the repository.

Goal: code that is easier to maintain and understand, and ideally shorter, though shorter is not required; a change may add lines when the result is clearly simpler.

Behavior stays identical: same return values, side effects and their order, raised errors and messages, log output, persisted data, wire and file formats, user-visible text, configuration, and await or lock points on hot paths.

Look for:
- two owners of one fact: state, rules, or conversions kept in two places, where one could be derived from the other;
- dead code, and parameters, fields, or return values nothing uses;
- pass-through wrappers and one-caller helpers that add a hop without a name worth having;
- duplicated logic within scope, or a new helper that repeats an existing one;
- defensive checks inside trusted internal code that the types already guarantee;
- options, flags, or branches nothing sets or reaches;
- stale names, and comments or docstrings that narrate history or describe old behavior;
- classes or protocols that a function or a dataclass would replace, and dicts where a dataclass fits;
- control flow that flattens;
- tests that duplicate each other, patch private internals instead of the owning seam, or carry dead fixtures and helpers.

Out of scope: behavior changes, new features or options, hardening, new edge-case handling, performance work, formatting churn, and renames that do not make the code clearer.

Bugs: report a real bug found along the way under "Bugs", never as a simplification.

Report every proposal that clearly makes the code simpler; there is no cap. For each: path:line, what is there now, the simpler shape, why behavior is unchanged, the rough line delta, and your confidence. Zero proposals is a valid result.

You only read: no edits, no tests, no package installs, no commits, nothing posted anywhere. Never delete with a relative path, run probes only in a fresh temporary directory, stop only processes you started, and never sleep for a guessed duration.
```
