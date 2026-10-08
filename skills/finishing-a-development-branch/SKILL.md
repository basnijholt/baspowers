---
name: finishing-a-development-branch
description: Use when implementation is complete, all tests pass, and you need to decide how to integrate the work
---

# Finishing a Development Branch

## Overview

**Core principle:** Verify tests → Detect environment → Follow requested outcome → Clean up safely.

**Announce at start:** "I'm using the finishing-a-development-branch skill to complete this work."

## Step 1: Verify Tests

Run the project's full test suite (`npm test` / `cargo test` / `pytest` / `go test ./...`).

**If tests fail**, report the failures and stop — the menu comes after a green suite:

```
Tests failing (<N> failures). Must fix before completing:

[Show failures]
```

**If tests pass:** continue to Step 2.

## Step 2: Detect Environment

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
# Capture now, while still inside the workspace — Step 5 changes directory
# before cleanup (Step 6) needs this value
WORKTREE_PATH=$(git rev-parse --show-toplevel)
```

**Detached HEAD** (`git branch --show-current` prints nothing, common in
harness-managed worktrees): create a branch now with
`git switch -c <descriptive-branch>`. Commits left on a detached HEAD are
lost when the host deletes its worktree. If branch creation is blocked (e.g.
by a sandbox), report the detached state and the head SHA, and stop.

This determines how cleanup works:

| State | Cleanup |
|-------|---------|
| `GIT_DIR == GIT_COMMON` (normal repo) | No worktree to clean up |
| `GIT_DIR != GIT_COMMON` | Provenance-based (see Step 6) |

## Step 3: Determine Base Branch

The base branch is whatever this work forked from — usually named in the
plan, the conversation, or the branch's upstream. If it is not already
known, derive it from merge-base, upstream tracking, and repository defaults.
If those disagree, stop before merging or opening a PR and report the
ambiguity: integrating into the wrong base is expensive to undo.

## Step 4: Select Requested Integration

Follow the requested outcome already present in the task or repository
instructions:

- If the request includes opening a PR, push and create the PR.
- If the request includes local integration, merge locally.
- If no integration side effect was requested, keep the branch and worktree,
  report their state, and stop. Do not turn completion into a permission menu.

Publishing, merging, or deleting work without that outcome being requested
requires new authority. Preserve the branch instead of asking a routine
completion question.

## Step 5: Execute Choice

### Option 1: Merge Locally

```bash
# Get main repo root for CWD safety
MAIN_ROOT=$(git -C "$(git rev-parse --git-common-dir)/.." rev-parse --show-toplevel)
cd "$MAIN_ROOT"

# Worked in a linked worktree? The main checkout belongs to your human
# partner: merge there only if it is clean and already on the base branch.
git status --porcelain            # must print nothing
git branch --show-current         # must print <base-branch>
# Worked in the main checkout itself? Switch it: git checkout <base-branch>

# Merge first — verify success before removing anything
git pull
git merge <feature-branch>

# Verify tests on merged result
<test command>
```

If you worked in a linked worktree and the main checkout has uncommitted
changes or is on another branch, do not switch or stash it: report and stop.

If tests fail on the merged result: stop, leave the worktree and branch in
place, and investigate — nothing has been pushed, so the merge is local
and recoverable.

Once the merged result is green: clean up the worktree (Step 6), then
delete the branch:

```bash
git branch -d <feature-branch>
```

### Option 2: Push and Create PR

```bash
git push -u origin <feature-branch>
```

Then create the pull/merge request against <base-branch> with the forge's
tooling — its CLI if one is available, or the creation URL most forges
print when you push — following the repo's PR template and conventions if
present, and report the URL to your human partner.

Keep the worktree — your human partner iterates on PR feedback there.

### Option 3: Keep As-Is

Report: "Keeping branch <name>. Worktree preserved at <path>."

### If your human partner asks to discard the work

This path exists only as a response to an explicit request to throw the
work away. Confirm first:

```
This will permanently delete:
- Branch <name>
- All commits: <commit-list>
- Worktree at <path>

Type 'discard' to confirm.
```

Wait for that exact confirmation. When it arrives:

```bash
MAIN_ROOT=$(git -C "$(git rev-parse --git-common-dir)/.." rev-parse --show-toplevel)
cd "$MAIN_ROOT"
```

Then clean up the worktree (Step 6) and force-delete the branch:

```bash
git branch -D <feature-branch>
```

## Step 6: Cleanup Workspace

**Runs for local merge and confirmed discards.** PR and keep outcomes always
preserve the worktree. Both callers have already changed directory to the
main repo root — worktree removal must run from outside the worktree —
and use the `GIT_DIR`/`GIT_COMMON`/`WORKTREE_PATH` values captured in
Step 2, from before that directory change.

**If `GIT_DIR == GIT_COMMON`:** Normal repo, no worktree to clean up. Done.

**If `WORKTREE_PATH` is inside `$MAIN_ROOT/.worktrees/`, `$MAIN_ROOT/worktrees/`,
or the worktree directory your instructions name:** Baspowers created this
worktree — we own cleanup. Match against those exact directories, not any
path containing `worktrees`: harness-managed worktrees such as
`~/.t3/worktrees/...` or `~/.codex/worktrees/...` belong to the host.

```bash
git worktree remove "$WORKTREE_PATH"
git worktree prune  # Self-healing: clean up any stale registrations
```

**If removal is refused** (`contains modified or untracked files`): the
worktree holds files that exist nowhere else — uncommitted plans, notes,
or scratch work. Never `--force` on your own initiative. Show your human
partner what is at stake, preserve the worktree, and stop:

```bash
git -C "$WORKTREE_PATH" status --porcelain -uall
```

```
Worktree removal refused — these files were never committed:

<file list>

Cleanup paused. Tell me whether these files should be committed, moved, or
deleted.
```

Carry out a later explicit instruction, then remove the worktree.

**Otherwise:** The host environment owns this workspace — leave it in
place.

## Quick Reference

| Option | Merge | Push | Keep Worktree | Cleanup Branch |
|--------|-------|------|---------------|----------------|
| 1. Merge locally | yes | - | - | yes |
| 2. Create PR | - | yes | yes | - |
| 3. Keep as-is | - | - | yes | - |
| Discard (explicit request only) | - | - | - | yes (force) |

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Tests passed earlier this session" | Run the suite on the tree you are about to integrate. A green run only proves the tree it ran on. |
| "They obviously want it merged" | Merge only when local integration is part of the requested outcome; otherwise preserve the branch. |
| "They seem done with this feature — I'll offer to discard it" | Discard happens only when your human partner asks for it in so many words. |
| "'Yeah, get rid of it' counts as confirmation" | Only the typed word `discard` authorizes deletion. |
| "The PR is up, so the worktree is clutter now" | PR feedback gets fixed in that worktree. It stays until the work lands. |
| "This other worktree looks stale — I'll clean it too" | Clean up only worktrees inside `$MAIN_ROOT/.worktrees/`, `$MAIN_ROOT/worktrees/`, or the directory your instructions name. Everything else belongs to the host. |
| "Removal refused — `--force` is just finishing the cleanup" | The refusal means files exist only in that worktree. `--force` destroys them permanently. Preserve the worktree and report. |
| "The merged-result failure is probably flaky" | A failing merged result stops everything. Branch and worktree stay put while you investigate. |
| "The base branch is obviously main" | Derive the fork point and compare it with upstream/default branch evidence. Stop if they disagree. |
| "The push was rejected — force-push will fix it" | A rejected push means the remote moved. Investigate; force-push only on your human partner's explicit request. |
