# Changelog

## Unreleased

### Fixed

- Create or reuse release plans for TypeSpec changes without the `new-api-version` label, matching project, API version, release type, and active/finished status. Supply the PR link for matching PR-first lookup before project fallback.
- Support empty-version metadata without weakening concrete-version matching, and preserve Public Preview/beta for preview-only multi-version projects.
- Skip SDK generation for finished plans, stop on lookup/response errors, and report clear PR recovery guidance.
- Select a pull request only when it is merged and its merge commit SHA matches the triggering commit, rather than using the first associated pull request.
