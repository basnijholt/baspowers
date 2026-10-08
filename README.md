# Baspowers

Personal fork of [obra/superpowers](https://github.com/obra/superpowers): a set of composable skills for coding agents, plus the bootstrap that makes the agent use them.

- `skills/` — the skills
- `hooks/` — Claude Code `SessionStart` hook that injects `using-baspowers`
- `.claude-plugin/`, `.codex-plugin/`, `.agents/plugins/` — plugin and local marketplace manifests for Claude Code and Codex

## Skills

Upstream is [obra/superpowers](https://github.com/obra/superpowers) v6.4.2 plus later bug fixes from its `dev` branch. Every skill is renamed from superpowers to baspowers. **Verbatim** means identical to upstream apart from that rename.

| Skill | What it does | Source |
|---|---|---|
| `using-baspowers` | Bootstrap: pick the skills that apply at the start of each task | Superpowers, **modified**: loads skills once per task instead of before every response; agent decides routine, reversible work itself |
| `brainstorming` | Turn an idea into a checked design before building | Superpowers, **modified**: no approval gates (agent presents the design and proceeds); keeps v6.4.2, not the unreleased `dev` rebuild |
| `writing-plans` | Write a step-by-step implementation plan from a spec | Superpowers, **modified**: agent picks the execution mode instead of asking |
| `executing-plans` | Execute a plan yourself in this session, with one final review | Superpowers, **modified**: creates an isolated branch instead of asking for consent |
| `subagent-driven-development` | Execute a plan task by task with fresh subagents and reviews | Superpowers, **modified**: creates an isolated branch instead of asking for consent |
| `dispatching-parallel-agents` | Run independent tasks in parallel subagents | Superpowers, **verbatim** |
| `test-driven-development` | Write a failing test first, then the code | Superpowers, **modified**: agent decides the named exceptions instead of asking |
| `systematic-debugging` | Find the root cause before proposing a fix | Superpowers, **modified**: after three failed fixes, consults another model instead of asking |
| `verification-before-completion` | Run the checks before claiming anything works | Superpowers, **verbatim** |
| `requesting-code-review` | Get a review before merging | Superpowers, **verbatim** |
| `receiving-code-review` | Verify review feedback instead of blindly applying it | Superpowers, **modified**: investigates instead of asking; consults another model when feedback conflicts with a recorded decision |
| `using-git-worktrees` | Isolate feature work in a git worktree | Superpowers, **rewritten**: 1063 to 354 words; reuses a worktree only if it is fresh |
| `finishing-a-development-branch` | Decide how to merge, PR, or clean up finished work | Superpowers, **modified**: follows the requested outcome instead of presenting an options menu |
| `consulting-cross-model` | Ask another model about an ambiguous, costly decision | **New** in Baspowers |
| `writing-skills` | Create, edit, and test skills | Superpowers, **verbatim** |
| `diagnosing-baspowers` | Diagnose from transcripts why a session went wrong | Superpowers (`diagnosing-superpowers`), **modified**: GitHub issue step removed |

## Install

```bash
claude plugin marketplace add /path/to/baspowers
claude plugin install baspowers@baspowers-dev

codex plugin marketplace add /path/to/baspowers
codex plugin add baspowers@baspowers-dev
```

## License

MIT — see [LICENSE](LICENSE).
