# Baspowers

Personal fork of [obra/superpowers](https://github.com/obra/superpowers): a set of composable skills for coding agents, plus the bootstrap that makes the agent use them.

- `skills/` — the skills
- `hooks/` — Claude Code `SessionStart` hook that injects `using-baspowers`
- `.claude-plugin/`, `.codex-plugin/`, `.agents/plugins/` — plugin and local marketplace manifests for Claude Code and Codex

## Install

```bash
claude plugin marketplace add /path/to/baspowers
claude plugin install baspowers@baspowers-dev

codex plugin marketplace add /path/to/baspowers
codex plugin add baspowers@baspowers-dev
```

## License

MIT — see [LICENSE](LICENSE).
