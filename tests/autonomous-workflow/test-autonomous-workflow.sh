#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
cd "$repo_root"

failures=0

require_text() {
  local file=$1
  local pattern=$2
  if ! grep -Eq "$pattern" "$file"; then
    printf 'missing required autonomy rule: %s: %s\n' "$file" "$pattern" >&2
    failures=$((failures + 1))
  fi
}

reject_text() {
  local file=$1
  local pattern=$2
  if grep -Ein "$pattern" "$file"; then
    printf 'routine approval gate remains: %s: %s\n' "$file" "$pattern" >&2
    failures=$((failures + 1))
  fi
}

# Bootstrap stays reliable without reloading the same instructions every turn.
require_text skills/using-baspowers/SKILL.md 'start of each new task'
require_text skills/using-baspowers/SKILL.md 'Do not re-read or re-invoke'
require_text skills/using-baspowers/SKILL.md 'already available in the current context'
reject_text skills/using-baspowers/SKILL.md 'BEFORE any response or action|before ANY response'

# Routine workflow decisions belong to the agent.
require_text skills/using-baspowers/SKILL.md 'Decide and proceed autonomously'
require_text skills/using-baspowers/SKILL.md 'consulting-cross-model'
require_text skills/consulting-cross-model/SKILL.md 'Codex.*Claude|Claude.*Codex'
require_text skills/consulting-cross-model/SKILL.md 'agent-cli dev agent'
require_text skills/consulting-cross-model/SKILL.md 'One consultation per decision'
require_text skills/consulting-cross-model/SKILL.md 'BASPOWERS_CONSULT_DEPTH'
require_text skills/consulting-cross-model/SKILL.md 'read-only|permission-mode plan'
require_text skills/consulting-cross-model/SKILL.md 'advisory|not an authorization|never authoriz'
reject_text skills/brainstorming/SKILL.md 'human partner.*approv|user approv|Get approval|STOP and wait for an explicit yes|Wait for the user'
reject_text skills/brainstorming/SKILL.md 'Want me to\?|ask user to review'
reject_text skills/writing-plans/SKILL.md 'Which approach\?'
reject_text skills/executing-plans/SKILL.md 'Raise them with your human partner|Ask for clarification rather than guessing'
reject_text skills/using-git-worktrees/SKILL.md 'ask for consent|Would you like me to set up'
reject_text skills/test-driven-development/SKILL.md 'ask your human partner|human partner.s permission'
reject_text skills/finishing-a-development-branch/SKILL.md 'What would you like to do\?|Which option\?|Present Options'
require_text skills/finishing-a-development-branch/SKILL.md 'requested outcome|requested integration'
require_text skills/finishing-a-development-branch/SKILL.md 'typed word `discard`|Only the typed word `discard`'
require_text skills/finishing-a-development-branch/SKILL.md 'Never `--force` on your own initiative|`--force` destroys'
require_text skills/subagent-driven-development/SKILL.md 'Rulings, not stalls'
reject_text skills/subagent-driven-development/SKILL.md 'presents the options|human partner.s explicit consent'
require_text skills/systematic-debugging/SKILL.md 'consulting-cross-model'
require_text skills/receiving-code-review/SKILL.md 'consulting-cross-model'

# External and destructive actions still require authority when not already requested.
require_text skills/using-baspowers/SKILL.md 'destructive|irreversible'
require_text skills/using-baspowers/SKILL.md 'external action|external side effect|publish|deploy|merge'

exit "$failures"
