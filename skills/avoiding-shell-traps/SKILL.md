---
name: avoiding-shell-traps
description: Use when writing shell commands that wait for, find, or stop processes, pass a list of files to a tool, or commit after running hooks, especially in zsh or background loops
---

# Avoiding Shell Traps

Each trap makes a command look successful while it did nothing, or stops the wrong process.

| Task | Do | Trap |
|---|---|---|
| Wait for a process | `wait "$pid"` in the shell that started it, otherwise `tail --pid="$pid" -f /dev/null` | `until ! pgrep -f pattern` matches the waiting shell's own command line and never ends |
| Stop a process | `pgrep -af '<anchored pattern>'`, read the result, then `kill <pid>` in a separate command | `pkill -f pattern` kills the shell running it (exit 144) and other sessions' processes |
| Pass several files | zsh: `files=(${(f)"$(git diff --name-only)"})`; bash: `mapfile -t files < <(git diff --name-only)`; then `tool "${files[@]}"` | `F="a b"; tool $F` passes one argument in zsh, so the tool checks nothing |
| Commit after hooks | `pre-commit run --files "${files[@]}" && git add "${files[@]}" && git commit -m "..."` | `;` between them commits even when the hooks failed |
| Act in another directory | absolute paths, joined with `&&`: `cd /abs/dir && rm -r build` | `cd dir; rm -rf x` runs in the wrong directory when `cd` fails |

Do not edit a worktree or a script while a test run or that script still reads it; edit a copy.
After any check, confirm it checked something: a non-zero count of files, hooks, or tests.
