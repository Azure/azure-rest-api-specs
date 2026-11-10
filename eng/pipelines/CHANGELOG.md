# Pipeline Changes

## Unreleased

- Keep the dashboard publisher's Azure Storage network policy in the skill-eval entrypoint, reuse the
  common build, shard and summary jobs, and leave the shared 1ES redirect unchanged.
- Preserve dashboard setup and current SDK generation guidance when merging main; eval settings are
  unchanged.
