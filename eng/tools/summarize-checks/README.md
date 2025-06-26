# `summarize-checks`

This code base functions as a replacement for `pipelinebot` and is intended to be used with the new actions-only checks
present in azure-rest-api-specs.

## Invocation shortcuts

```
export GITHUB_TOKEN="blahblah"
npx summarize-checks --owner scbedd --repo azure-rest-api-specs --pr 1 --sha 826b0b976479e5c1aa5e66e1cf43a3f9e66a2477
```