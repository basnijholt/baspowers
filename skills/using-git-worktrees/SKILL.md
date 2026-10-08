---
name: using-git-worktrees
description: Use when starting feature work that needs isolation from the current workspace, or before executing implementation plans
---

# Using Git Worktrees

Implementation happens in a worktree that holds only your work, never directly
on main/master. If your human partner asks you to work in place, do so.

## Reuse the current checkout only if it is fresh

A session can open in an existing worktree that another agent is still using,
so being in a worktree is not enough. Reuse the current checkout only when all
of these hold:

- It is a linked worktree: `git rev-parse --git-dir` differs from
  `git rev-parse --git-common-dir`.
- `git status --porcelain` prints nothing.
- HEAD has no commits beyond the default branch (e.g.
  `git rev-list --count origin/main..HEAD` is 0), apart from commits you made
  in this session.

A detached HEAD in a fresh worktree is fine; baspowers:finishing-a-development-branch
creates the branch.

Otherwise create a new worktree. Never commit, stash, or reset changes you did
not make to get a checkout that looks fresh.

## Create a new worktree

- **Location:** the directory your instructions name, else an existing
  `.worktrees/` or `worktrees/` in the main checkout's root (first line of
  `git worktree list`), else `.worktrees/` there.
- **Ignored:** confirm with `git check-ignore`. If the directory is not
  ignored, add it to `info/exclude` in the common git dir
  (`git rev-parse --git-common-dir`) instead of committing a `.gitignore` change.
- **Base:** branch from the up-to-date default branch, not from the current
  HEAD: `git fetch origin`, then
  `git worktree add -b <branch> <dir>/<branch> origin/main`.
- **Stay there:** do all remaining work in the new worktree. Use absolute paths
  into it; some harnesses reset the shell's directory between commands.

If worktree creation is blocked (e.g. a sandbox denial), say so. Work on a new
branch in place only if the current checkout is fresh; otherwise stop and
report.

## Baseline

Install dependencies the way the project does and run its test suite before
changing anything. Report pre-existing failures separately from your work.
