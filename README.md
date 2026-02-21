# minimax-cli

Run Codex CLI and Claude Code on MiniMax without changing your default `codex` or `claude` setup.

## Install (30 seconds)

```bash
curl -fsSL https://github.com/harley/minimax-cli/releases/latest/download/install.sh | bash
export MINIMAX_API_KEY="your_minimax_key"
minimax
```

What this gives you:

- `minimax`: choose Codex or Claude with MiniMax config applied for that run only.
- `codex-mm`: Codex CLI wrapper pinned to MiniMax defaults.
- `claude-mm`: Claude Code wrapper pinned to MiniMax Anthropic-compatible endpoint.

## Screenshots

Drop your screenshots at these paths:

- `assets/screenshots/claude-mm.png`
- `assets/screenshots/codex-mm.png`

| Claude Code on MiniMax | Codex on MiniMax |
| --- | --- |
| ![Claude Code on MiniMax](assets/screenshots/claude-mm.png) | ![Codex on MiniMax](assets/screenshots/codex-mm.png) |

## Terminal Recordings

- `assets/asciinema/claude-mm.cast`
- `assets/asciinema/codex-mm.cast`

Regenerate recordings:

```bash
./demo/record-asciinema.sh
```

## Quick Verify

```bash
minimax --help
codex-mm --help
claude-mm --help
```

## Prerequisites

- Bash (macOS/Linux shell)
- `codex` CLI installed
- `claude` CLI installed
- MiniMax API key

## Usage

### `minimax`

```bash
minimax [codex|claude] [arguments]
```

Examples:

```bash
minimax
minimax codex chat
minimax claude -p "Explain this repository"
```

### `codex-mm`

```bash
codex-mm [codex arguments]
```

Examples:

```bash
codex-mm chat
codex-mm exec "Summarize this repository"
```

Defaults:

- Provider: `minimax`
- Model: `codex-MiniMax-M2.5`
- Base URL: `https://api.minimax.io/v1`
- Wire API: `responses`

Environment variables:

- `MINIMAX_API_KEY` (required)
- `MINIMAX_BASE_URL` (optional)
- `MINIMAX_CODEX_MODEL` (optional)
- `MINIMAX_CODEX_WIRE_API` (optional, default `responses`)

### `claude-mm`

```bash
claude-mm [claude arguments]
```

Examples:

```bash
claude-mm
claude-mm -p "Explain this project"
```

Defaults:

- Base URL: `https://api.minimax.io/anthropic`
- Model family vars: `MiniMax-M2.5`

Environment variables:

- `MINIMAX_API_KEY` (required)
- `MINIMAX_CLAUDE_BASE_URL` (optional)
- `MINIMAX_CLAUDE_MODEL` (optional)

## Install Options

Default destination is `~/.local/bin`.

```bash
# show installer help
curl -fsSL https://github.com/harley/minimax-cli/releases/latest/download/install.sh | bash -s -- --help

# custom bin directory
curl -fsSL https://github.com/harley/minimax-cli/releases/latest/download/install.sh | \
  bash -s -- --bin-dir /usr/local/bin

# copy files instead of symlinks
curl -fsSL https://github.com/harley/minimax-cli/releases/latest/download/install.sh | \
  bash -s -- --copy
```

Source checkout fallback:

```bash
git clone https://github.com/harley/minimax-cli.git
cd minimax-cli
./install.sh
```

Uninstall:

```bash
rm -f ~/.local/bin/minimax ~/.local/bin/codex-mm ~/.local/bin/claude-mm
```

## Troubleshooting

- `Error: MINIMAX_API_KEY is not set`
  - Set `MINIMAX_API_KEY` before running wrappers.
- `codex CLI not found`
  - Install Codex CLI and ensure it is in `PATH`.
- `claude CLI not found`
  - Install Claude Code and ensure it is in `PATH`.
- Unexpected provider behavior in Codex
  - Wrapper clears `OPENAI_API_KEY` and `OPENAI_BASE_URL` for that run to prevent provider conflicts.

## Official MiniMax Docs

- [MiniMax Claude Code setup](https://platform.minimax.io/docs/coding-plan/claude-code)
- [MiniMax Codex CLI setup](https://platform.minimax.io/docs/coding-plan/codex-cli)

## Development

```bash
./bin/ci
```

Release automation:

- `release-please` workflow: `.github/workflows/release-please.yml`
- Release asset upload workflow: `.github/workflows/release-install.yml`
- Commit messages should use Conventional Commits (`feat:`, `fix:`, etc.)

## Security Notes

- Do not commit API keys.
- Prefer shell profile exports or a local `.env` file loaded by your shell.
