#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Uninstall minimax-cli commands from a bin directory.

Usage:
  ./uninstall.sh [options]

Options:
  --bin-dir <dir>  Install destination (default: ~/.local/bin)
  -h, --help       Show this help
EOF
}

BIN_DIR="${HOME}/.local/bin"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --bin-dir)
      shift
      if [[ $# -eq 0 ]]; then
        echo "Error: --bin-dir requires a value." >&2
        exit 1
      fi
      BIN_DIR="$1"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Error: unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

for tool in minimax codex-mm claude-mm; do
  target="${BIN_DIR}/${tool}"
  if [[ -e "${target}" || -L "${target}" ]]; then
    rm -f "${target}"
    echo "Removed ${target}"
  else
    echo "Skip ${target} (not found)"
  fi
done

echo "Uninstall complete."
