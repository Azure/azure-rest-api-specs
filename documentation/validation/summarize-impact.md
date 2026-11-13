## Description

The `Summarize Impact` check is used to evaluate an incoming changeset on a PR to `azure-rest-api-specs` or `azure-rest-api-specs-pr`. This evaluation examines the code, and categorizes the "types" of changes that are occurring. It is used so that the `summarize-checks` check can apply the correct labels and evaluate `automated merge requirements` without actually those details itself. Doing it this way creates a security boundary between the change itself and the code that will be executing privileged actions in the specs repo.

Questions that `Summarize Impact` answers will be similar to:

> Does this PR add or modify suppressions?

> Does this PR change TypeSpec?

> Does it add a new RP that isn't RPaaS?

And other `about` questions.

## Troubleshooting details

### `js-yaml` reports multiple documents while processing a README

If `Summarize Impact` reports a `js-yaml` error such as `expected a single document in the stream, but found more`, inspect the Markdown code fences in the affected `readme.md` before assuming that the YAML content is invalid.

In particular, verify that every fenced YAML block has a closing triple backtick. A missing closing fence can cause later README content to be parsed as part of the YAML block. Close the fence and rerun the check before performing deeper YAML troubleshooting.

### Suppression change without triggering `Suppression Review Required`

In certain circumstances, devs can can modify the suppressions for a readme, _without_ requiring a suppression review. [This PR](https://github.com/Azure/azure-rest-api-specs/pull/36645/files) is one such example. It is adding two new suppressions to a new API version, but the suppressions themselves _already exist_ for a previous API version. In this case, `summarize impact` _intentionally_ evaluates this PR to not need suppression review. If the RP was approved previously, it should be approved for this new api version as well.
