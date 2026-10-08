# Baspowers

Personal fork of [obra/superpowers](https://github.com/obra/superpowers): a set of composable skills for coding agents, plus the bootstrap that makes the agent use them.

- `skills/` — the skills
- `hooks/` — Claude Code `SessionStart` hook that injects `using-baspowers`
- `.claude-plugin/`, `.codex-plugin/`, `.agents/plugins/` — plugin and local marketplace manifests for Claude Code and Codex

## Skills

Upstream is [obra/superpowers](https://github.com/obra/superpowers) v6.4.2 plus later bug fixes from its `dev` branch.
Every upstream skill is renamed from superpowers to baspowers; that rename alone does not count as a change.

### Original to Baspowers (6)

| Skill | What it does |
|---|---|
| `consulting-cross-model` | Ask another model about an ambiguous, costly decision |
| `merging-when-approved` | Merge only after independent reviewers approve the exact head |
| `scoring-pull-requests` | Verdict-first scorecard: net production LOC, root cause or bandage, risk |
| `stopping-runaway-prs` | Stop and re-plan when a change outgrows its estimate or reviews keep finding defects |
| `reporting-status` | Open items only, with how far each got |
| `triaging-pr-backlogs` | Close what is provably redundant, merge what passes review, report the rest |

### Modified from Superpowers (11)

| Skill | What it does | What changed |
|---|---|---|
| `using-baspowers` | Bootstrap: pick the skills that apply at the start of each task | Loads skills once per task instead of before every response; agent decides routine, reversible work itself; adds a terse response style adapted from [caveman](https://github.com/JuliusBrussee/caveman) |
| `brainstorming` | Turn an idea into a checked design before building | No approval gates (agent presents the design and proceeds); keeps v6.4.2, not the unreleased `dev` rebuild |
| `writing-plans` | Write a step-by-step implementation plan from a spec | Agent picks the execution mode instead of asking |
| `executing-plans` | Execute a plan yourself in this session, with one final review | Creates an isolated branch instead of asking for consent |
| `subagent-driven-development` | Execute a plan task by task with fresh subagents and reviews | Creates an isolated branch instead of asking for consent |
| `test-driven-development` | Write a failing test first, then the code | Agent decides the named exceptions instead of asking |
| `systematic-debugging` | Find the root cause before proposing a fix | After three failed fixes, consults another model instead of asking |
| `receiving-code-review` | Verify review feedback instead of blindly applying it | Investigates instead of asking; consults another model when feedback conflicts with a recorded decision |
| `using-git-worktrees` | Isolate feature work in a git worktree | Rewritten: 1063 to 354 words; reuses a worktree only if it is fresh |
| `finishing-a-development-branch` | Decide how to merge, PR, or clean up finished work | Follows the requested outcome instead of presenting an options menu |
| `diagnosing-baspowers` | Diagnose from transcripts why a session went wrong | Was `diagnosing-superpowers`. GitHub issue step removed |

### Copied from Superpowers (4)

Identical to upstream apart from the rename.

| Skill | What it does |
|---|---|
| `dispatching-parallel-agents` | Run independent tasks in parallel subagents |
| `verification-before-completion` | Run the checks before claiming anything works |
| `requesting-code-review` | Get a review before merging |
| `writing-skills` | Create, edit, and test skills |

## Install

```bash
claude plugin marketplace add /path/to/baspowers
claude plugin install baspowers@baspowers-dev

codex plugin marketplace add /path/to/baspowers
codex plugin add baspowers@baspowers-dev
```

## License

MIT — see [LICENSE](LICENSE).
