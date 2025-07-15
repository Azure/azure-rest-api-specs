# `Summarize Impact`

This tool models the PR and produces an artifact that is consumed by the `summarize-checks` check.

The schema of the artifact looks like:

```json
{
    "pr-type": ["resource-manager", "data-plane"],
    "suppressionsChanged": true,
    "versioningReviewRequired": false,
    "breakingChangeReviewRequired": true,
    "rpaasChange": true,
    "newRP": true,
    "rpaasRPMissing": true
}
```

## Invocation

