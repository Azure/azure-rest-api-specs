# Changelog

## Unreleased

### Fixed

- Create release plans for TypeSpec changes without requiring the `new-api-version` label, reusing only matching API-version plans in `In Progress` or `Finished` status.
- Skip SDK generation for finished plans and include clearer creation and error recovery instructions in PR comments.
- Report lookup command and JSON errors instead of treating them as missing release plans.
- Distinguish CLI creation from reuse, validate returned plan identity, and assert the expected API version before writes.
- Preserve automatic creation and reuse for multi-version/empty metadata through the CLI's explicit empty-version flow; keep concrete-version matching strict and stop on unsupported CLI contracts.
- Preserve Public Preview/beta classification when a multi-version project contains only preview API versions.
- Select a pull request only when it is merged and its merge commit SHA matches the triggering commit, rather than using the first associated pull request.
