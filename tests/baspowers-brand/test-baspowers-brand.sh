#!/usr/bin/env bash
set -euo pipefail

forbidden='super''powers'

if git grep -Ini "$forbidden" -- . ':!.gitmodules'; then
  printf 'legacy brand remains in tracked content\n' >&2
  exit 1
fi

if git ls-files | grep -i "$forbidden"; then
  printf 'legacy brand remains in a tracked path\n' >&2
  exit 1
fi

printf 'Baspowers branding test passed\n'
