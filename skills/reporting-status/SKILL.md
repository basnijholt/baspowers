---
name: reporting-status
description: Use when asked where things stand, what is left, or whether work is done or stuck, and when ending a turn after work on several items
---

# Reporting Status

An item is done only when verified in the final environment its goal requires; merged is not deployed.

1. First line: `All done.` or `Open: <N> items.`
2. Table of open items only: Item | Reached | Next step | Waiting on (me/you) | Blocker.
3. One line naming done items, no details.
4. Mark suspicions `unconfirmed` and old approvals `stale (approved <sha>, head <sha>)`.
5. Last line: your next action or the one decision you need.
