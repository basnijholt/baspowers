---
name: using-baspowers
description: Use when starting a new conversation or task, or when the task changes enough that different skills may apply
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, ignore this skill.
</SUBAGENT-STOP>

<IMPORTANT>
At the start of each new task, determine which available skills apply. If a
skill applies, use it before substantive work begins.

Bootstrap once per task, not once per message or tool call.
</IMPORTANT>

## The Rule

At the **start of each new task**, invoke relevant or requested skills before
the first substantive response or action. A task continues through follow-up
questions, status checks, corrections, and its tool calls.

**Do not re-read or re-invoke** the same skill on every turn. When its contents
are already available in the current context, keep applying them directly.
Re-check skills only when:

- your human partner starts a materially different task;
- a new requirement makes another skill relevant;
- context compaction or another reset removed the instructions; or
- you know the skill file changed.

Do not run a shell command merely to prove that a skill was invoked. Use the
runtime's skill mechanism when available; otherwise read a needed skill once.

**Before entering plan mode:** if you haven't already brainstormed, invoke the brainstorming skill first.

Announce "Using [skill] to [purpose]" the first time it is selected for a task,
or when it materially changes the workflow. Follow the skill exactly. If it
has a checklist, create a todo per item.

## Autonomy and Authority

**Decide and proceed autonomously for routine, reversible, in-scope work.**
Do not turn workflow checkpoints into permission requests. Make reasonable
assumptions, record important decisions, self-review plans and designs, and
continue through implementation and verification.

Ask your human partner only when progress requires information you cannot
discover safely, a material expansion of scope, or new authority for a
destructive or irreversible action. External actions such as publishing,
deploying, merging, spending money, or messaging others require authorization
unless the request already clearly includes that side effect.

When a hard technical decision remains ambiguous after inspecting the code,
tests, and history, use **baspowers:consulting-cross-model** before
interrupting your human partner. Consultation is advice, never authority.

## Skill Priority

When multiple skills apply, process skills come first — they set the approach, then implementation skills (frontend-design, etc.) carry it out. Brainstorming and systematic-debugging are Baspowers' most common process skills, but the rule holds for any of them.

- "Let's build X" → baspowers:brainstorming first, then implementation skills.
- "Fix this bug" → baspowers:systematic-debugging first, then domain skills.

## Red Flags

These thoughts mean STOP—you're rationalizing:

| Thought | Reality |
|---------|---------|
| "This is just a simple question" | Questions are tasks. Check for skills. |
| "I need more context first" | Skill check comes BEFORE clarifying questions. |
| "Let me explore the codebase first" | Skills tell you HOW to explore. Check first. |
| "I can check git/files quickly" | Files lack conversation context. Check for skills. |
| "Let me gather information first" | Skills tell you HOW to gather information. |
| "This doesn't need a formal skill" | If a skill exists, use it. |
| "I remember this skill" | If it is not in current context, read it. If it is already loaded, apply it without another filesystem read. |
| "This doesn't count as a task" | Action = task. Check for skills. |
| "The skill is overkill" | Simple things become complex. Use it. |
| "I'll just do this one thing first" | Check BEFORE doing anything. |
| "This feels productive" | Undisciplined action wastes time. Skills prevent this. |
| "I know what that means" | Knowing the concept ≠ using the skill. Invoke it. |

## Platform Adaptation

If your harness appears here, read its reference file for special instructions:

- Codex: `references/codex-tools.md`
- Pi: `references/pi-tools.md`
- Antigravity: `references/antigravity-tools.md`
- Hermes Agent: `references/hermes-tools.md`

## User Instructions

User instructions (CLAUDE.md, AGENTS.md, GEMINI.md, etc, direct requests) take precedence over skills, which in turn override default behavior. Only skip skill workflows or instructions when your human partner has explicitly told you to.
