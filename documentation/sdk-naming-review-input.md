# SDK Naming Review Input

The .NET naming-review handoff reuses existing SDK Validation artifacts:

1. Azure Pipelines generates and builds the SDK.
2. The runner records generated changed-file paths before the SDK checkout is reset.
3. The existing `spec-gen-sdk-artifact.json` carries that metadata with its APIView references.
4. A read-only GitHub workflow validates the trusted build, pull request, head SHA, and review metadata.

The current GitHub workflow is report-only. It does not invoke a review model or write to a pull request.

## Existing artifact contract

Each `apiViewRequestData` entry continues to identify the generated package artifact:

```json
{
  "packageName": "Azure.ResourceManager.Widget",
  "filePath": "Azure.ResourceManager.Widget.1.0.0.nupkg",
  "packageRootPath": "sdk/widget/Azure.ResourceManager.Widget",
  "changedFiles": [
    "sdk/widget/Azure.ResourceManager.Widget/api/Azure.ResourceManager.Widget.netstandard2.0.cs"
  ]
}
```

`packageRootPath` and `changedFiles` are additive. Existing consumers can continue using `packageName` and `filePath`. The package/APIView artifact remains the source of review content.

The changed-file metadata:

- is captured before the next generated SDK checkout reset
- contains tracked and untracked generated files
- excludes build intermediates and scratch logs
- uses normalized repository-relative POSIX paths
- is bounded per package and across the artifact

No generated-source patch or SDK baseline commit is transported.

## Pipeline and immutable identity

The source check is exactly `SDK Validation - .NET` from the Azure Pipelines GitHub App. Its Azure Pipelines `external_id` must be:

```text
7516|<buildId>|<projectId>
```

Definition ID `7516` identifies the SDK validation pipeline. The build and project IDs must match the trusted Azure DevOps `details_url`.

The consumer validates:

- spec PR number and current PR head SHA
- artifact head SHA
- SDK language
- APIView artifact paths
- package roots and changed-file paths
- package and changed-file limits

Only a verified HTTP 404 means the artifact is unavailable. Authentication failures, throttling, server errors, malformed metadata, oversized content, and identity mismatches fail validation.

## Ownership boundaries

| Component | Responsibility |
| --- | --- |
| SDK generation runner | Capture changed-file metadata and enrich existing APIView entries |
| `spec-gen-sdk-artifact.json` | Existing cross-system handoff contract |
| Package/APIView artifact | Generated public API review content |
| GitHub validation workflow | Trusted event/build identity, schema and path validation, summary, and validated metadata upload |

Skill execution and pull request publication remain separate future stages with independent permissions.
