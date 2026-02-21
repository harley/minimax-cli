# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0](https://github.com/harley/minimax-cli/compare/v0.1.0...v1.0.0) (2026-02-21)


### ⚠ BREAKING CHANGES

* codex-mm no longer proxies Codex; use official MiniMax Codex setup docs instead.

### Features

* pause codex support and make minimax claude-first ([52f89c1](https://github.com/harley/minimax-cli/commit/52f89c12ae235cb86c421fc280f615fd10342beb))


### Bug Fixes

* **ci:** remove rg dependency and add minimax screenshot asset ([03bd7f4](https://github.com/harley/minimax-cli/commit/03bd7f405aa6cd107fef5ef8be39e3a11e184f3f))

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
