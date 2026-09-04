---
name: consulting-cross-model
description: Use when a hard technical decision remains ambiguous after inspecting relevant evidence and choosing incorrectly would cause meaningful rework
---

# Consulting the Opposite Model

Use one independent model as an adviser, then own the decision yourself.
Codex consults Claude; Claude consults Codex. Consultation is advisory, not an
authorization and not a substitute for inspecting the repository.

## When to Consult

Consult only when all four hold:

1. You already read the relevant code, tests, history, and instructions.
2. Two or more technically defensible options remain.
3. A wrong choice would cause meaningful rework or lock in an interface.
4. The ambiguity is technical. Missing product intent goes to your human partner.

Cheap reversible choices do not qualify. Decide those yourself.

## Stopping Rules

- **One consultation per decision.** Decide after one reply. No rebuttal round.
- If `BASPOWERS_CONSULT_DEPTH` is already set, you are the consultant. Never consult again.
- Advice never grants permission for destructive, irreversible, security-sensitive, or external actions.
- Bound the call to 300 seconds. Failure, timeout, or empty output means decide from existing evidence.
- If two decisions in one task already needed consultation, a third indicates an under-specified task. Ask your human partner.

End every prompt with:

> You are an adviser. Inspect and recommend; do not edit, commit, or run
> `agent-cli`. Do not consult another agent. Reply in under 300 words with:
> recommendation, strongest reason, strongest counterargument.

## Run the Consultation

Write a self-contained prompt under `.claude/consultations/`. Include the
decision, evidence, options, constraints, target repository path, and requested
output. Keep it git-ignored.

Prefer synchronous `agent-cli dev run`; it returns the answer directly and
does not create a task file:

Non-login shells can omit user-level executable directories. Before reporting
a CLI unavailable, resolve it from `PATH`, then check
`$HOME/.local/bin/agent-cli` and `$HOME/.bun/bin/{claude,codex}`. Pass `--`
after the worktree name so `agent-cli` does not parse the nested CLI's flags.

```bash
# Codex -> Claude
consult_agent_cli=$(command -v agent-cli || printf '%s\n' "$HOME/.local/bin/agent-cli")
consult_claude_cli=$(command -v claude || printf '%s\n' "$HOME/.bun/bin/claude")
[ -x "$consult_agent_cli" ] && [ -x "$consult_claude_cli" ] || exit 127
BASPOWERS_CONSULT_DEPTH=1 timeout 300 \
  "$consult_agent_cli" dev run . -- "$consult_claude_cli" \
  -p --output-format text \
  --permission-mode plan "$(<.claude/consultations/question.md)"

# Claude -> Codex
consult_agent_cli=$(command -v agent-cli || printf '%s\n' "$HOME/.local/bin/agent-cli")
consult_codex_cli=$(command -v codex || printf '%s\n' "$HOME/.bun/bin/codex")
[ -x "$consult_agent_cli" ] && [ -x "$consult_codex_cli" ] || exit 127
BASPOWERS_CONSULT_DEPTH=1 timeout 300 \
  "$consult_agent_cli" dev run . -- "$consult_codex_cli" \
  exec --sandbox read-only --color never \
  "$(<.claude/consultations/question.md)"
```

When synchronous output is unavailable, use `agent-cli dev agent .` with the
opposite `--agent`, `--no-hooks`, `-m tmux`, and `--prompt-file`. Require a
unique report path. Remove generated `TASK-*` and consultation files after
reading the report.

`agent-cli dev path .` can resolve to a superproject when called inside a
submodule. Compare it with `git rev-parse --show-toplevel`; if they differ,
name the exact nested repository path in the prompt so the adviser inspects the
right tree.

## Decide and Record

Evaluate the advice against repository evidence. Record one line:

`Consulted <model>: <question> — <advice> — <decision>`

Then proceed. Escalate only if the remaining issue is missing human intent or
requires authority you do not have.
