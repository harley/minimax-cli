# minimax-cli

Lightweight wrappers that run Codex CLI and Claude Code against MiniMax endpoints.

## What this repo contains

- `codex-mm`: Runs `codex` with MiniMax provider config preloaded.
- `claude-mm`: Runs `claude` with MiniMax Anthropic-compatible config preloaded.

## Prerequisites

- Bash (macOS/Linux shell)
- `codex` CLI installed (for `codex-mm`)
- `claude` CLI installed (for `claude-mm`)
- A MiniMax API key

## Quick Start

```bash
cd minimax-cli
chmod +x codex-mm claude-mm

# required
export MINIMAX_API_KEY="your_minimax_key"

# run Codex on MiniMax
./codex-mm

# run Claude Code on MiniMax
./claude-mm
```

## Usage

### `codex-mm`

```bash
./codex-mm [codex arguments]
```

Examples:

```bash
./codex-mm --help
./codex-mm chat
./codex-mm exec "Summarize this repository"
```

Defaults used by this wrapper:

- Provider: `minimax`
- Model: `codex-MiniMax-M2.5`
- Base URL: `https://api.minimax.io/v1`

Environment overrides:

- `MINIMAX_API_KEY` (required)
- `MINIMAX_BASE_URL` (optional)
- `MINIMAX_CODEX_MODEL` (optional)

Compatibility fallback:

- If `MINIMAX_API_KEY` is missing and `MINIMAX_API_API` is set, wrapper will use `MINIMAX_API_API`.

Note:

- `--profile` is stripped from passthrough args intentionally, because this wrapper pins provider/model config directly.

### `claude-mm`

```bash
./claude-mm [claude arguments]
```

Examples:

```bash
./claude-mm
./claude-mm -p "Explain this project"
```

Defaults used by this wrapper:

- Base URL: `https://api.minimax.io/anthropic`
- Model family vars: `MiniMax-M2.5`

Environment overrides:

- `MINIMAX_API_KEY` (required)
- `MINIMAX_CLAUDE_BASE_URL` (optional)
- `MINIMAX_CLAUDE_MODEL` (optional)

Compatibility fallback:

- If `MINIMAX_API_KEY` is missing and `MINIMAX_API_API` is set, wrapper will use `MINIMAX_API_API`.

## Troubleshooting

- `Error: MINIMAX_API_KEY is not set`
  - Set `MINIMAX_API_KEY` before running wrappers.
- `codex CLI not found`
  - Install Codex CLI and ensure it is in `PATH`.
- `claude CLI not found`
  - Install Claude Code and ensure it is in `PATH`.
- Unexpected provider behavior in Codex
  - Wrapper clears `OPENAI_API_KEY` and `OPENAI_BASE_URL` for that run to prevent provider conflicts.

## Development

Validate scripts:

```bash
bash -n codex-mm claude-mm
```

## Security Notes

- Do not commit API keys.
- Prefer shell profile exports or a local `.env` file loaded by your shell.
