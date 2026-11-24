# Changelog

## Unreleased

### Fixed

- Stop direct TypeSpec SDK generation when another active plan has an unreleased SDK pull request for the same project and language. Keep test plans separate and allow reruns on the existing pull request's branch.
- Select a pull request only when it is merged and its merge commit SHA matches the triggering commit, rather than using the first associated pull request.
