# `Summarize Impact`

This tool describes changes to API services and writes `summary.json`, consumed by `summarize-checks`.
It does not decide which reviews are required or modify labels.

```bash
pnpm exec summarize-impact --sourceDirectory <pr-checkout> --targetDirectory <merge-base-checkout>
```

The source directory must be checked out at the PR head and the target directory at its merge base
with the target branch. The merge-base commit must also be available in the source repository.
The workflow fetches full history to compute this baseline, excluding unrelated target-branch changes.

The artifact groups facts by service directory (`specification/<service>`) and plane. A PR can affect
multiple services and both planes. The shared schema is
[`ImpactAssessmentSchema`](../../../.github/shared/src/impact.ts).

For example, changing only a management service's SDK configuration still classifies the service as
resource-manager, without describing the change as an API change:

```json
{
  "schemaVersion": 2,
  "services": [
    {
      "path": "specification/example",
      "plane": "resource-manager",
      "changes": ["sdk-configuration"],
      "typeSpec": true,
      "newApiVersions": [],
      "suppressionsChanged": false,
      "resourceProvider": {
        "newNamespaces": [],
        "usesRpaas": false,
        "hasAddedDefinitions": false,
        "registered": false
      }
    }
  ]
}
```

`changes` distinguishes API definitions, examples, SDK configuration, readmes, and other files.
`typeSpec` identifies TypeSpec-related changes, including changes to generated Swagger.
Plane classification uses path segments or the owning TypeSpec configuration's AutoRest output
plane/linter ruleset. Unresolved files use `unknown`; deleted projects can use the baseline config.
New API versions are compared against their own resource provider in the baseline checkout.
Resource-provider facts describe namespace additions, RPaaS configuration, added Swagger definitions,
and registration in the baseline checkout's `.github/arm-leases` directory.

`summarize-checks` evaluates review requirements using these facts and the PR's **current** draft
status and target branch, then reconciles labels separately. ARM review exemptions do not remove the
resource-manager classification. Version additions and suppression changes are scoped to their
service and plane, so unrelated changes cannot trigger another service's review.

The reader also accepts legacy flat artifacts from existing runs. Those artifacts retain their
original aggregate behavior because their per-service attribution cannot be recovered.
