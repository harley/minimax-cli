#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEMO_BIN="$(mktemp -d "${TMPDIR:-/tmp}/minimax-demo-bin.XXXXXX")"

cleanup() {
  rm -rf "${DEMO_BIN}"
}
trap cleanup EXIT

run() {
  local cmd="$1"
  printf '\n$ %s\n' "${cmd}"
  bash -lc "set -euo pipefail; export PATH=\"${DEMO_BIN}:\$PATH\"; export MINIMAX_API_KEY=\"demo_key_redacted\"; ${cmd}"
  sleep 0.5
}

printf 'minimax-cli demo: codex-mm\n'
sleep 0.8
printf '\n$ curl -fsSL https://github.com/harley/minimax-cli/releases/latest/download/install.sh | bash\n'
printf '# recording uses local source checkout equivalent\n'
sleep 1

run "${REPO_ROOT}/install.sh --bin-dir ${DEMO_BIN}"
run "ls -1 ${DEMO_BIN}"
run "codex-mm --profile demo --help | sed -n '1,70p'"
run "minimax codex --help | sed -n '1,35p'"

printf '\nDemo complete.\n'
