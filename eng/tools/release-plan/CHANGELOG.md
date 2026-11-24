# Changelog

## Unreleased

### Fixed

- Stop direct TypeSpec SDK generation when another active release plan for the same project has an unreleased SDK pull request for the same language.
- Select a pull request only when it is merged and its merge commit SHA matches the triggering commit, rather than using the first associated pull request.
