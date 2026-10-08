---
name: reporting-status
description: Use when asked where things stand, what is left, or whether work is done or stuck, and when ending a turn after work on several items
---

# Reporting Status

## Overview

A status report lists what is still open.
An item is done only when it reached the final environment its goal requires and was verified there.

**State ladder:** implemented, PR open, reviewed at current head, merged, released, on staging, in production, verified.
Merged is not deployed.
Deployed is not verified.

## Output Shape

1. **First line:** `All done.` or `Open: <N> items.`
2. **Table of open items only:**

   | Item | Reached | Next step | Waiting on | Blocker |
   |---|---|---|---|---|

   "Waiting on" is `me` or `you`.
3. **One line naming the done items**, without details.
   Omit it if there are none.
4. **Labels:** mark a suspicion `unconfirmed`.
   Mark an approval on an older commit `stale (approved <sha>, head <sha>)`.
5. **Last line:** what you do next, or the single decision you need.

## Common Mistakes

- Filing an item as done when it is merged but not deployed.
- Opening with the done list.
- Writing a narrative recap instead of the table.
