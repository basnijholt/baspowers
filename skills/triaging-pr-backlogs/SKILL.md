---
name: triaging-pr-backlogs
description: Use when asked to clean up, triage, or prune a backlog of open pull requests or issues
---

# Triaging PR Backlogs

## Overview

"Clean up the backlog" authorizes closing what is provably redundant and merging what passes the normal review gate.
Classify every item with evidence, act on the safe classes now, and report the rest.

## Classes

| Class | Required evidence | Action |
|---|---|---|
| Superseded or duplicate | The merged PR or commit that contains the change | Close with a comment linking it |
| Already fixed on main | `git grep` or a test showing the fix is present | Close with a comment showing where |
| Abandoned bot or agent PR | No activity for weeks, and nothing beyond main | Close with a one-line reason |
| Small, green, mergeable | CI green at head, no conflicts | Merge through baspowers:merging-after-independent-review |
| Dependency bumps | CI green, not a major version | Same gate; batch bumps that touch one lockfile |
| External contributor, active | Recent activity | Comment with status or requested changes; never close |
| External contributor, stale | No response for months | Close with thanks and an invitation to reopen |
| Large or maintainer-owned | Any | Report only |

## Steps

1. Inventory every open item:
   `gh pr list --state open --limit 200 --json number,title,author,createdAt,updatedAt,mergeable,statusCheckRollup`
2. Classify each item and record the evidence.
3. Execute the close and merge classes without asking again.
   Ask only about items that fit no class.
4. Report counts (closed, merged, commented, left) with a link per item.

## Common Mistakes

- Waiting for approval to close items the request already covered.
- Closing without a comment that names the superseding work.
- Closing an active contributor's PR.
