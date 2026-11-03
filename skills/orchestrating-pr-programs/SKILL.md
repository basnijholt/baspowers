---
name: orchestrating-pr-programs
description: Use when one thread coordinates several agent sessions that each deliver their own pull request, such as a refactor program, fixes from an issue sweep, or follow-ups to merged pull requests, including when a session reports ready, a review finding needs a ruling, or a pull request merges
---

# Orchestrating PR Programs

## Overview

You run the program; sessions write the code, one pull request each.
The program ends when every item and every follow-up fix has merged or stopped, and no merged or stopped item's leftovers are still to collect.

## Launch

1. Before launching, tell your human partner that the program's follow-up fixes will start on their own unless they object, and that each merge still waits for their decision.
2. Go through the items in any order and start each one whose files no started, unfinished item owns and whose prerequisites have merged; repeat this pass whenever an item merges or stops.
   An item owns its files from its start until it merges or stops; when a prerequisite stops, stop the items that build on it.
   When a session asks for a file outside its list, give it only if no other started, unfinished item owns it.
   Follow-up fix sessions start by the same rule.
3. Brief each session with [session-brief.md](session-brief.md) and everything that brief says the session gets.
   When the host cannot run every session that may start, start the next one whenever a slot frees, never in fixed waves.
4. A session is idle only when its thread is not running, none of its sub-agents runs, and its last message waits on nothing.

## Gate and merge

5. Check gate 9 of the session brief yourself; if it fails, send the session back with what is missing.
   Offer a merge only when the session's verdict from gate 10 is positive, its judge agrees, and you agree; when any of the three says no, stop its work, leave the pull request open, and report why.
6. When a session asks you to rule on a review finding, use the bar in gate 7 of the session brief; if the reviewer still holds the finding after your ruling, ask your human partner.
7. Forward every security hole a session reports to your human partner privately at once, never into an issue, pull request, or comment.
8. Merge one pull request at a time, as your human partner decides, with step 5 of baspowers:merging-when-approved, after confirming that its head contains current main.
   Each merge of main into a pull request is a new head: follow your human partner's main-merge rule if they set one, and baspowers:merging-when-approved otherwise.

## Follow up

9. After a pull request merges or stops, once its session is idle, ask it for everything it left open.
10. Leave security holes out; step 7 covers them.
    Keep the failures that meet the bar in gate 7 of the session brief and the fixes on that gate's cheap list; decline the rest in a comment on that pull request, one line each.
11. Open one issue with the kept items, linking that pull request, or open none.
    When the item counts of successive follow-up issues stop shrinking, use baspowers:stopping-runaway-prs before starting a fix; otherwise start one fix session for the whole issue as step 2 allows.
12. When that fix merges, close the issue with a comment that settles each item, then run steps 9 to 11 for the fix.

## Ask your human partner

13. Write each decision in plain words: what it is, the options with their cost, your recommendation, and your confidence in it as a percentage.
    Each time you raise a pending decision again, restate it in full; a bare label such as "A or B?" means nothing to a partner who has been away.
    Keep every other item running while you wait.

## Red Flags

| Thought | Reality |
|---|---|
| "Start no other work; scheduling the fixes is the owner's call" | Step 1 told your human partner that follow-up fixes start on their own; start the fix session as soon as step 11 allows. |
| "Valid finding, the fourth of one class: stop patching and redesign" | Rule on it with gate 7 of the session brief first: below the bar, decline it; at or above it, baspowers:stopping-runaway-prs decides before any patch. |
| "Any push voids every gate; restart from the cleanup scan" | Gate 9 of the session brief: one scan, then a review round for each later fix, and live evidence on the final head. |
