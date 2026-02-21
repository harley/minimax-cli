#!/usr/bin/env bash

MINIMAX_CODEX_DOCS_URL="https://platform.minimax.io/docs/coding-plan/codex-cli"

ensure_command() {
  local cmd="$1"
  local install_hint="$2"

  if ! command -v "${cmd}" >/dev/null 2>&1; then
    if [[ -n "${install_hint}" ]]; then
      echo "Error: ${cmd} CLI not found. ${install_hint}" >&2
    else
      echo "Error: ${cmd} CLI not found." >&2
    fi
    exit 1
  fi
}

ensure_minimax_api_key() {
  if [[ -z "${MINIMAX_API_KEY:-}" ]]; then
    if [[ -n "${MINIMAX_API_API:-}" ]]; then
      export MINIMAX_API_KEY="${MINIMAX_API_API}"
      echo "Notice: using MINIMAX_API_API as fallback for MINIMAX_API_KEY." >&2
    else
      echo "Error: MINIMAX_API_KEY is not set in your environment." >&2
      exit 1
    fi
  fi
}

clear_openai_conflicts() {
  if [[ -n "${OPENAI_API_KEY:-}" || -n "${OPENAI_BASE_URL:-}" ]]; then
    echo "Notice: clearing OPENAI_API_KEY/OPENAI_BASE_URL for this run to avoid provider conflicts." >&2
  fi
  unset OPENAI_API_KEY OPENAI_BASE_URL
}

print_codex_paused_message() {
  cat >&2 <<EOF
Codex support in minimax-cli is temporarily unavailable.
For official MiniMax Codex setup, see:
${MINIMAX_CODEX_DOCS_URL}
EOF
}

exit_codex_paused() {
  print_codex_paused_message
  exit 2
}
