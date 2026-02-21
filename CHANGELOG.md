# Changelog

All notable changes to this project will be documented in this file.

## 0.2.0 - 2026-02-21

### Changed

- Made `minimax` Claude-first:
  - no args now run `claude-mm`
  - unknown first args are forwarded to `claude-mm`
  - `minimax codex` now exits with an explicit unsupported message
- Reworked `codex-mm` into a compatibility stub that always exits with code `2` and points to the official MiniMax Codex docs.
- Updated CI smoke tests to assert Codex-pause behavior and docs-link messaging for both `codex-mm` and `minimax codex`.
- Rewrote README to remove legacy Codex runtime instructions and clearly document current support boundaries.

### Contributor Notes

- Codex support is intentionally paused in this wrapper until an officially supported integration path is available.
- For Codex usage guidance, direct users to:
  - https://platform.minimax.io/docs/coding-plan/codex-cli
