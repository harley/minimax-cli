#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Standalone installer for minimax-cli.

Usage:
  curl -fsSL https://github.com/harley/minimax-cli/releases/latest/download/install.sh | bash
  curl -fsSL https://github.com/harley/minimax-cli/releases/latest/download/install.sh | bash -s -- [options]

Options:
  --bin-dir <dir>  Install destination (default: ~/.local/bin)
  --copy           Copy files instead of symlinking
  --symlink        Symlink files (default)
  --repo <owner/repo>  GitHub repository (default: harley/minimax-cli)
  --ref <name>     Tag or branch to install (default: release tag, fallback: main)
  -h, --help       Show this help
EOF
}

BIN_DIR="${HOME}/.local/bin"
MODE="symlink"
REPO="${MINIMAX_INSTALL_REPO:-harley/minimax-cli}"
REF="${MINIMAX_INSTALL_REF:-__MINIMAX_RELEASE_TAG__}"

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
    --repo)
      shift
      if [[ $# -eq 0 ]]; then
        echo "Error: --repo requires a value." >&2
        exit 1
      fi
      REPO="$1"
      ;;
    --ref)
      shift
      if [[ $# -eq 0 ]]; then
        echo "Error: --ref requires a value." >&2
        exit 1
      fi
      REF="$1"
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

if [[ "${REF}" == "__MINIMAX_RELEASE_"'TAG__' ]]; then
  REF="main"
fi

download_file() {
  local url="$1"
  local output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsL "${url}" -o "${output}"
    return
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -qO "${output}" "${url}"
    return
  fi

  echo "Error: curl or wget is required." >&2
  exit 1
}

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/minimax-cli-install.XXXXXX")"
trap 'rm -rf "${TMP_DIR}"' EXIT

ARCHIVE_PATH="${TMP_DIR}/minimax-cli.tar.gz"
TAG_URL="https://github.com/${REPO}/archive/refs/tags/${REF}.tar.gz"
BRANCH_URL="https://github.com/${REPO}/archive/refs/heads/${REF}.tar.gz"
DOWNLOAD_OK=0

if download_file "${TAG_URL}" "${ARCHIVE_PATH}"; then
  DOWNLOAD_OK=1
else
  echo "Tag '${REF}' not found, trying branch '${REF}'..." >&2
fi

if [[ "${DOWNLOAD_OK}" -eq 0 ]]; then
  if download_file "${BRANCH_URL}" "${ARCHIVE_PATH}"; then
    DOWNLOAD_OK=1
  elif [[ "${REF}" == "main" ]]; then
    MASTER_URL="https://github.com/${REPO}/archive/refs/heads/master.tar.gz"
    echo "Branch 'main' not found, trying branch 'master'..." >&2
    if download_file "${MASTER_URL}" "${ARCHIVE_PATH}"; then
      DOWNLOAD_OK=1
    fi
  fi
fi

if [[ "${DOWNLOAD_OK}" -eq 0 ]]; then
  echo "Error: could not download '${REPO}' at ref '${REF}'." >&2
  exit 1
fi

ARCHIVE_ROOT="$(tar -tzf "${ARCHIVE_PATH}" | head -n1 | cut -d'/' -f1)"
if [[ -z "${ARCHIVE_ROOT}" ]]; then
  echo "Error: failed to inspect downloaded archive." >&2
  exit 1
fi

tar -xzf "${ARCHIVE_PATH}" -C "${TMP_DIR}"

INSTALL_SCRIPT="${TMP_DIR}/${ARCHIVE_ROOT}/scripts/install.sh"
if [[ ! -f "${INSTALL_SCRIPT}" ]]; then
  echo "Error: install script not found in downloaded archive." >&2
  exit 1
fi

INSTALL_ARGS=(--bin-dir "${BIN_DIR}")
if [[ "${MODE}" == "copy" ]]; then
  INSTALL_ARGS+=(--copy)
else
  INSTALL_ARGS+=(--symlink)
fi

bash "${INSTALL_SCRIPT}" "${INSTALL_ARGS[@]}"

cat <<'EOF'

Next steps:
  export MINIMAX_API_KEY="your_minimax_key"
  minimax
EOF
