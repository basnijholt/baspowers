---
name: orchestrating-pr-programs
description: Use when one thread coordinates several agent sessions that each deliver their own pull request, such as a refactor program, fixes from an issue sweep, or follow-ups to merged pull requests, including when a session reports ready, a review finding needs a ruling, or a pull request merges
---

# Orchestrating PR Programs

## Overview

You run the program; sessions write the code, one pull request each.
The program is done when no item and no follow-up fix is running or waiting to start.

## Launch

1. When your human partner approves the program, tell them that its follow-up fixes will start on their own and that every merge still waits for them.
2. Start at once every item that shares no file with, and does not build on, a running item or another item you start now; start each remaining item when the item it waits on merges.
   Follow-up fix sessions start by the same rule.
3. Brief each session with [session-brief.md](session-brief.md), its item, and the host's limits on shared resources such as full test suites and benchmarks; limit those resources, not the number of sessions.
4. A session is idle only when its thread is not running, none of its sub-agents runs, and its last message waits on nothing.

## Gate and merge

5. Check the ready gate in item 9 of the session brief yourself.
   Offer a merge only when the session's verdict from item 10 is positive, its judge agrees, and you agree; otherwise stop its work, leave the pull request open, and report why.
6. When a session asks you to rule on a review finding, use the bar in item 7 of the session brief.
7. Merge one pull request at a time, as your human partner decides, with step 5 of baspowers:merging-when-approved, after confirming that its head contains current main.
   Each merge of main into a pull request is a new head: follow your human partner's main-merge rule if they set one, and baspowers:merging-when-approved otherwise.

## Follow up

8. After a merge, once the session is idle, ask it for everything it left open.
9. Keep the failures that meet the bar in item 7 of the session brief, and the cheap fixes: about 20 production lines or fewer, low risk, with a gain someone notices.
   Decline the rest in a comment on the merged pull request, one line each.
   Report a security hole to your human partner privately, never in an issue or comment.
10. Open one issue with the kept items, linking the merged pull request, or open none; start one fix session for the whole issue.
11. When that fix merges, close the issue with a comment that settles each item, then run steps 8 to 10 for the fix.
    When follow-up issues stop shrinking, use baspowers:stopping-runaway-prs.

## Ask your human partner

12. Write each decision in plain words: what it is, the options with their cost, your recommendation, and your confidence in it as a percentage.
    Keep every other item running while you wait.

## Red Flags

| Thought | Reality |
|---|---|
| "Start no other work; scheduling the fixes is the owner's call" | They approved the follow-up fixes with the program; start the fix session now. |
| "Valid finding, the fourth of one class: stop patching and redesign" | Rule on it with item 7 of the session brief first; a failure below that bar is declined. |
| "Any push voids every gate; restart from the cleanup scan" | Item 9 of the session brief: one scan, then a review round for each later fix. |
