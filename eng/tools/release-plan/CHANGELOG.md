# Changelog

## Unreleased

### Fixed

- Warn and post manual release-plan instructions when TypeSpec changes need a plan but automatic creation is not allowed.
- Report lookup command and JSON errors instead of treating them as missing release plans.
- Select a pull request only when it is merged and its merge commit SHA matches the triggering commit, rather than using the first associated pull request.
