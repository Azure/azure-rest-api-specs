# Changelog

## Unreleased

### Added

- Support manual pipeline replays with `SpecCommitSha`: keep the selected tooling revision while restoring the original specification snapshot. Leave the input empty for normal runs; do not combine it with `ReleasePlanId`.

### Fixed

- Report metadata generation and API-version resolution failures as CLI errors instead of successful no-TypeSpec-change skips.
- Select a pull request only when it is merged and its merge commit SHA matches the triggering commit, rather than using the first associated pull request.
