# Changelog

## Unreleased

### Fixed

- Create release plans for TypeSpec changes without requiring the `new-api-version` label, reusing only matching API-version plans in `In Progress` or `Finished` status.
- Skip SDK generation for finished plans and include clearer creation and error recovery instructions in PR comments.
- Report lookup command and JSON errors instead of treating them as missing release plans.
- Distinguish CLI creation from reuse, validate returned plan identity, and assert the expected API version before writes.
- Require manual selection for ambiguous metadata without performing plan lookups or creation; older CLI contracts stop before automatic creation.
- Select a pull request only when it is merged and its merge commit SHA matches the triggering commit, rather than using the first associated pull request.
