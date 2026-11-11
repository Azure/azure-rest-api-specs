## Description

The `Summarize Impact` check is used to evaluate an incoming changeset on a PR to `azure-rest-api-specs` or `azure-rest-api-specs-pr`. This evaluation examines the code, and categorizes the "types" of changes that are occurring. It is used so that the `summarize-checks` check can apply the correct labels and evaluate `automated merge requirements` without actually those details itself. Doing it this way creates a security boundary between the change itself and the code that will be executing privileged actions in the specs repo.

Questions that `Summarize Impact` answers will be similar to:

> Does this PR add or modify suppressions?

> Does this PR change TypeSpec?

> Does it add a new RP that isn't RPaaS?

And other `about` questions.

## Troubleshooting details

### Suppression change without triggering `Suppression Review Required`

In certain circumstances, devs can can modify the suppressions for a readme, _without_ requiring a suppression review. [This PR](https://github.com/Azure/azure-rest-api-specs/pull/36645/files) is one such example. It is adding two new suppressions to a new API version, but the suppressions themselves _already exist_ for a previous API version. In this case, `summarize impact` _intentionally_ evaluates this PR to not need suppression review. If the RP was approved previously, it should be approved for this new api version as well.

### `pnpm: command not found`

If `Summarize PR Impact` fails with `pnpm: command not found`, the PR branch may be out of date. The workflow loads `.github/actions/setup-node-install-deps` from the PR head checkout (`after/.github/actions/setup-node-install-deps`) and then runs `pnpm exec summarize-impact`. An older branch may still have a setup action that runs `npm ci` instead of setting up pnpm, so the later `pnpm` command is unavailable.

Update the PR branch with the latest target branch (`main` or `RPSaaSMaster`) and rerun the check from the updated PR head; rerunning without updating can repeat the failure. This is a branch/workflow mismatch, not a repo-wide workflow regression, and changing the spec content is not needed to fix it.
