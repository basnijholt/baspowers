# Baspowers

Personal fork of [obra/superpowers](https://github.com/obra/superpowers): a set of composable skills for coding agents, plus the bootstrap that makes the agent use them.

- `skills/` — the skills
- `hooks/` — Claude Code `SessionStart` hook that injects `using-baspowers`
- `.claude-plugin/`, `.codex-plugin/`, `.agents/plugins/` — plugin and local marketplace manifests for Claude Code and Codex

## Skills

| Skill | What it does |
|---|---|
| `using-baspowers` | Bootstrap: pick the skills that apply at the start of each task |
| `brainstorming` | Turn an idea into a checked design before building |
| `writing-plans` | Write a step-by-step implementation plan from a spec |
| `executing-plans` | Execute a plan yourself in this session, with one final review |
| `subagent-driven-development` | Execute a plan task by task with fresh subagents and reviews |
| `dispatching-parallel-agents` | Run independent tasks in parallel subagents |
| `test-driven-development` | Write a failing test first, then the code |
| `systematic-debugging` | Find the root cause before proposing a fix |
| `verification-before-completion` | Run the checks before claiming anything works |
| `requesting-code-review` | Get a review before merging |
| `receiving-code-review` | Verify review feedback instead of blindly applying it |
| `using-git-worktrees` | Isolate feature work in a git worktree |
| `finishing-a-development-branch` | Decide how to merge, PR, or clean up finished work |
| `consulting-cross-model` | Ask another model about an ambiguous, costly decision |
| `merging-after-independent-review` | Merge only after independent reviewers approve the exact head |
| `assessing-pull-requests` | Verdict-first scorecard: net production LOC, root cause or bandage, risk |
| `auditing-change-growth` | Stop and re-plan when a change outgrows its estimate or reviews keep finding defects |
| `deploying-in-stages` | One deployment PR, staging first, production in a quiet window |
| `reporting-status` | Open items only, with how far each got |
| `triaging-pr-backlogs` | Close what is provably redundant, merge what passes review, report the rest |
| `writing-skills` | Create, edit, and test skills |
| `diagnosing-baspowers` | Diagnose from transcripts why a session went wrong |

## Install

```bash
claude plugin marketplace add /path/to/baspowers
claude plugin install baspowers@baspowers-dev

codex plugin marketplace add /path/to/baspowers
codex plugin add baspowers@baspowers-dev
```

## License

MIT — see [LICENSE](LICENSE).
