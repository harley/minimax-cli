#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Install minimax-cli commands into a bin directory.

Usage:
  ./install.sh [options]

Options:
  --bin-dir <dir>  Install destination (default: ~/.local/bin)
  --copy           Copy files instead of symlinking
  --symlink        Symlink files (default)
  -h, --help       Show this help
EOF
}

BIN_DIR="${HOME}/.local/bin"
MODE="symlink"

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
    --copy)
      MODE="copy"
      ;;
    --symlink)
      MODE="symlink"
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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

mkdir -p "${BIN_DIR}"

for tool in minimax codex-mm claude-mm; do
  src="${REPO_ROOT}/${tool}"
  dst="${BIN_DIR}/${tool}"

  if [[ ! -f "${src}" ]]; then
    echo "Error: missing source file: ${src}" >&2
    exit 1
  fi

  chmod +x "${src}"

  if [[ "${MODE}" == "symlink" ]]; then
    ln -sfn "${src}" "${dst}"
    echo "Linked ${dst} -> ${src}"
  else
    if command -v install >/dev/null 2>&1; then
      install -m 0755 "${src}" "${dst}"
    else
      cp "${src}" "${dst}"
      chmod 0755 "${dst}"
    fi
    echo "Copied ${src} -> ${dst}"
  fi
done

case ":${PATH}:" in
  *:"${BIN_DIR}":*)
    echo "Install complete. ${BIN_DIR} is already in PATH."
    ;;
  *)
    echo "Install complete, but ${BIN_DIR} is not in PATH."
    echo "Add this to your shell profile (~/.zshrc or ~/.bashrc):"
    echo "  export PATH=\"${BIN_DIR}:\$PATH\""
    ;;
esac
