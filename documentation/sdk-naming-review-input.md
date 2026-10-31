# Generated SDK Review Input

The .NET SDK review path reuses the existing SDK Validation artifacts while
providing the source and repository context required by the canonical
`azure-sdk-for-net` code-review skill:

1. Azure Pipelines generates and builds the SDK.
2. Before the SDK checkout is reset, the runner records the exact SDK baseline,
   changed files, and a filtered snapshot of each generated package root.
3. `spec-gen-sdk-artifact.json` carries the review metadata.
4. The existing `packages` artifact carries the package snapshots beside the
   generated package files.
5. A read-only GitHub workflow validates the build identity, metadata, archive,
   paths, counts, and sizes.
6. A report-only GitHub Agentic Workflow reconstructs the generated changes on
   the exact SDK baseline and executes the canonical .NET code-review skill.

Neither workflow writes to the specification pull request.

## Existing artifact contract

Each `apiViewRequestData` entry continues to identify its existing generated
package artifact and adds a complete review-input group:

```json
{
  "packageName": "Azure.ResourceManager.Widget",
  "filePath": "Azure.ResourceManager.Widget.1.0.0.nupkg",
  "packageRootPath": "sdk/widget/Azure.ResourceManager.Widget",
  "changedFiles": [
    "sdk/widget/Azure.ResourceManager.Widget/api/Azure.ResourceManager.Widget.netstandard2.0.cs"
  ],
  "sdkBaseCommitSha": "0123456789abcdef0123456789abcdef01234567",
  "reviewInputPath": "Azure.ResourceManager.Widget/review-input",
  "reviewInputFileCount": 243,
  "reviewInputBytes": 1843210
}
```

The review fields are additive for existing consumers, but must be present
together when SDK review input is produced. `sdkBaseCommitSha` is the exact
checkout commit used for generation. Counts and bytes bind the manifest to the
snapshot extracted from the `packages` artifact.

The package snapshot preserves generated source, API files, project metadata,
README and changelog content, generator configuration, and unchanged
surrounding package context. It excludes transient content such as:

- `.git`, `.vs`, `bin`, `obj`, `node_modules`, `TestResults`, and `coverage`
- scratch `log.txt` files
- symbolic links

Snapshots and changed-file metadata are captured before the next generated SDK
checkout reset. Changed files include tracked changes, deletions, and untracked
generated files.

## Bounds

The shared contract enforces:

- at most 2,048 changed files per package and 4,096 across the artifact
- at most 20,000 snapshot files per package
- at most 40,000 snapshot files across the artifact
- at most 32 MiB of snapshot content per package
- at most 64 MiB of snapshot content across the artifact

The GitHub validator also caps the compressed `packages` archive at 256 MiB and
each extracted snapshot file at 8 MiB. It extracts only declared
`reviewInputPath` subtrees, rejects unsafe or duplicate paths, and verifies the
declared file counts and expanded byte totals.

## Pipeline and immutable identity

The source check is exactly `SDK Validation - .NET` from the Azure Pipelines
GitHub App. Its Azure Pipelines `external_id` must be:

```text
7516|<buildId>|<projectId>
```

Definition ID `7516` identifies the SDK validation pipeline. The build and
project IDs must match the trusted Azure DevOps `details_url`.

The validator also binds the artifact to the current specification PR and head
SHA. Authentication failures, throttling, server errors, malformed metadata,
oversized content, missing snapshots, and identity mismatches fail validation.

## Canonical skill execution

The report-only Agentic Workflow:

1. Downloads only a validated handoff artifact.
2. Groups packages by `sdkBaseCommitSha`.
3. Checks out each unique baseline once.
4. Replaces each package root with its validated generated snapshot.
5. Verifies that the reconstructed Git diff exactly matches `changedFiles`.
6. Resolves the canonical `azure-sdk-for-net` code-review skill from `main` and
   records its exact commit SHA.
7. Installs that exact skill revision in the agent workspace before the agent
   starts.
8. Runs the skill once per reconstructed baseline group.
9. Uploads `sdk-review-result.json`, a Markdown report, and the execution
   context as a report-only artifact.

The skill receives the changed-file scope plus unchanged package and repository
context. This is why APIView output or a `.nupkg` alone is insufficient.

## Ownership boundaries

| Component | Responsibility |
| --- | --- |
| SDK generation runner | Capture baseline identity, changed files, and filtered package snapshots |
| `spec-gen-sdk-artifact.json` | Existing cross-system review manifest |
| `packages` artifact | Existing payload transport extended with generated source snapshots |
| GitHub validation workflow | Trusted identity, schema, archive, path, count, and size validation |
| GitHub Agentic Workflow | Exact baseline reconstruction and canonical skill execution |
| Future publisher | Stale-result recheck and permission-separated PR publication |
