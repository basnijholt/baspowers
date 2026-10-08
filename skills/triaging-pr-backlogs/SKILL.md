---
name: triaging-pr-backlogs
description: Use when asked to clean up, triage, or prune a backlog of open pull requests or issues
---

# Triaging PR Backlogs

"Clean up the backlog" already authorizes these actions; do them without asking again, and ask only about items that fit no row.

| Class | Evidence | Action |
|---|---|---|
| Superseded, duplicate, or already fixed | The merged PR, commit, or code that contains it | Close with a comment linking it |
| Abandoned bot or agent PR | Weeks idle, nothing beyond main | Close with a one-line reason |
| Small or dependency bump, green | CI green, no conflicts, not a major bump | Merge via baspowers:merging-when-approved |
| External contributor, active | Recent activity | Comment with status; never close |
| External contributor, stale | No response for months | Close with thanks |
| Large or maintainer-owned | Any | Report only |

Finish with counts (closed, merged, commented, left) and a link per item.

## Red Flags

| Thought | Reality |
|---|---|
| "'Clean up' doesn't clearly authorize closing" | It does, for the rows in this table. |
| "Closing notifies people and is hard to undo" | A closed PR reopens in one click, and the linking comment is the evidence. |
| "Another agent was criticized for closing without checking" | The evidence column is the check; cite it in the comment. |
| "You're offline, so I'll only propose" | Being offline is why you were asked to clean up rather than propose. |
