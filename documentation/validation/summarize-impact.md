## Description

The `Summarize Impact` check is used to evaluate an incoming changeset on a PR to `azure-rest-api-specs` or `azure-rest-api-specs-pr`. This evaluation examines the code, and bucketizes the "types" of changes that are occurring. It is used so that the `summarize-checks` check can apply the correct labels and evaluate `automated merge requirements` without actually those details itself. Doing it this way creates a security boundary between the change itself and the code that will be executing privileged actions in the specs repo.

Questions that `Summarize Impact` answers will be similar to:

> Does this PR add or modify suppressions?

> Does this PR change TypeSpec?

> Does it add a new RP that isn't RPaaS?

And other `about` questions.

## Troubleshooting details

### Suppression change without triggering `Suppression Review Required`

In certain circumstances, devs can can modify the suppressions for a readme, _without_ requiring a suppression review. [This PR](https://github.com/Azure/azure-rest-api-specs/pull/36645/files) is one such example. It is adding two new suppressions to a new API version, but the suppressions themselves _already exist_ for a previous API version. In this case, `summarize impact` _intentionally_ evaluates this PR to not need suppression review. If the RP was approved previously, it should be approved for this new api version as well.
