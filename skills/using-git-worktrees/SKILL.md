---
name: using-git-worktrees
description: Use when starting feature work that needs isolation from the current workspace, or before executing implementation plans
---

# Using Git Worktrees

**Before reading or editing any project file, decide where to work.**
Implementation happens in a worktree that holds only your work, never in the
main checkout and never on main/master. If your human partner asks you to work
in place, do so.

## 1. Check the current checkout

```bash
git rev-parse --git-dir --git-common-dir
git status --porcelain
git rev-list --count origin/main..HEAD
```

Reuse the current checkout only if all of these hold:

- the two git dirs differ. Equal dirs (e.g. `.git` twice) mean you are in
  the main checkout: go to step 2, even if it is clean;
- `git status --porcelain` prints nothing;
- the count is 0, apart from commits you made in this session.

A session can open in a worktree another agent is still using, so being in a
worktree is not enough. Never commit, stash, or reset changes you did not make.
A detached HEAD in a fresh worktree is fine; baspowers:finishing-a-development-branch
creates the branch. If any check fails, go to step 2.

## 2. Create a new worktree

1. **Directory:** the one your instructions name, else an existing
   `.worktrees/` or `worktrees/` in the main checkout's root (first line of
   `git worktree list`), else `.worktrees/` there.
2. **Ignore it first:** `git check-ignore -q <dir>` must succeed before you
   create the worktree. If it fails, append the directory to
   `$(git rev-parse --git-common-dir)/info/exclude` (create the file if
   missing). Do not commit a `.gitignore` change.
3. **Create from the default branch, not HEAD:**
   `git fetch origin && git worktree add -b <branch> <dir>/<branch> origin/main`
4. **Stay there:** do all remaining work in the new worktree, with absolute
   paths; some harnesses reset the shell's directory between commands.

If worktree creation is blocked, say so. Work on a new branch in place only if
the current checkout is fresh; otherwise stop and report.

## 3. Baseline

Install dependencies the way the project does and run its test suite before
changing anything. Report pre-existing failures separately from your work.
