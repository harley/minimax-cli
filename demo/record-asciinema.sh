#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

mkdir -p "${REPO_ROOT}/assets/asciinema"

asciinema rec \
  --overwrite \
  --headless \
  --idle-time-limit 1 \
  --command "${SCRIPT_DIR}/demo-codex.sh" \
  "${REPO_ROOT}/assets/asciinema/codex-mm.cast"

asciinema rec \
  --overwrite \
  --headless \
  --idle-time-limit 1 \
  --command "${SCRIPT_DIR}/demo-claude.sh" \
  "${REPO_ROOT}/assets/asciinema/claude-mm.cast"

echo "Recorded:"
echo "  ${REPO_ROOT}/assets/asciinema/codex-mm.cast"
echo "  ${REPO_ROOT}/assets/asciinema/claude-mm.cast"
