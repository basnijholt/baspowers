---
name: orchestrating-pr-programs
description: Use when one thread coordinates several agent sessions that each deliver their own pull request, such as a refactor program, fixes from an issue sweep, or follow-ups to merged pull requests, including when a session reports ready, a review finding needs a ruling, or a pull request merges
---

# Orchestrating PR Programs

## Overview

You run the program; sessions write the code, one pull request each.
The program is done when a merge leaves nothing to fix.

## Launch

1. Start every item whose files no running item edits, all at once, each in its own worktree and session; cap shared resources such as full test suites and benchmarks, not sessions.
2. Brief each session with [session-brief.md](session-brief.md) and its item.
3. A session is idle only when its thread is not running, none of its sub-agents runs, and its last message waits on nothing.

## Gate and merge

4. Check the ready gate in item 9 of the session brief yourself.
   Offer a merge only when the session reports `VERDICT: better and simpler`, its judge agrees, and you agree; otherwise stop that pull request and report why.
5. Rule on review findings with the bar in item 7 of the session brief, also when a session or a reviewer asks you.
6. Merge one pull request at a time, as your human partner decides, after confirming that its head contains current main.
   Each merge of main into a pull request is a new head: follow your human partner's main-merge rule if they set one, and baspowers:merging-when-approved otherwise.

## Follow up

7. After a merge, once the session is idle, ask it for everything it left open.
8. Keep two kinds of item, and decline the rest with a one-line reason in your report:
   - **FIX-BUG:** a failure that meets the bar in item 7 of the session brief.
   - **FIX-CHEAP:** about 20 production lines or fewer, low risk, and a gain someone notices, such as an error that hides its cause, wrong advice in a message or doc, a test that checks less than its name says, or dead code a reader must still understand.
9. Open one issue with only those items, linking the merged pull request, or open none.
   Start its fix session at once with the same brief: approving the program approved its follow-up fixes, and only their merges wait for your human partner.
10. When a fix merges, close its issue with a comment that settles each item, then run steps 7 to 9 for that fix.

## Ask your human partner

11. Write each decision in plain words: what it is, the options with their cost, your recommendation, and your confidence in it as a percentage.
    Keep every other item running while you wait.

## Red Flags

| Thought | Reality |
|---|---|
| "Start no other work; scheduling the fixes is the owner's call" | Approving the program approved its follow-up fixes; start the fix session now. |
| "Valid finding, the fourth of one class: stop patching and redesign" | Rule on it with item 7 first; a failure below that bar is declined, not redesigned. |
| "Any push voids every gate; restart from the cleanup scan" | The scan runs once; a fix after it needs a new review round, not a new scan. |
