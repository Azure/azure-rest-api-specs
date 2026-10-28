# SDK Review Bundle Contract

The SDK review bundle carries generated SDK changes from spec PR validation into a report-only GitHub handoff:

1. Azure Pipelines captures the bundle.
2. The GitHub validation workflow verifies and republishes a validated artifact.

The current validation workflow is read-only. It does not invoke a review model or write to a pull request.

## Versioning and compatibility

The manifest has a required `schemaVersion`. Producers and consumers must use the shared schema in `.github/shared/src/sdk-types.ts`. A consumer must reject an unsupported version rather than infer compatibility. Additive or breaking contract changes require a new shared schema version and an explicit compatibility decision in each consumer.

## Pipeline and immutable identity

The source check is exactly `SDK Validation - .NET` from the Azure Pipelines GitHub App. Its Azure Pipelines `external_id` must be:

```text
7516|<buildId>|<projectId>
```

Definition ID `7516` identifies the SDK validation pipeline. The build and project IDs must match the trusted Azure DevOps `details_url`.

The bundle binds the following immutable identities:

- spec PR number and PR head SHA
- Azure Pipelines build ID
- SDK repository and exact SDK base commit SHA
- package root
- patch file name and byte count

The event-driven consumer does not accept a user-supplied URL or SHA in place of these identities.

## Capture completeness

A complete manifest is all-or-nothing. It contains one entry for every generated package. Packages with changed files declare a patch file and byte count. Packages with zero changed files remain as metadata-only entries and do not declare or publish an empty patch. A failed capture is explicit and contains no usable entries. The consumer rejects failed, partial, over-budget, path-unsafe, byte-count-invalid, or identity-mismatched bundles.

The producer owns complete capture before the generated SDK checkout is reset. The shared schema defines the wire contract. The validation workflow owns event and build identity, resource limits, repository and path safety, and byte-count validation.

## Artifact resolution and retention

The Azure Pipelines artifact is one flat ZIP archive containing:

- `sdk-review-bundle.json`
- one patch for each non-empty package entry

No directories, nested paths, undeclared files, or empty-package patches are allowed. The validation workflow makes exactly one artifact metadata request and one `format=zip` archive request, regardless of package count. It streams extraction, validates each name before starting that entry, and enforces per-file and total limits from actual emitted bytes rather than declared ZIP sizes. It then schema-validates the manifest and verifies that the archive contains exactly the declared patches and byte counts. Only fully validated files are written to the local bundle directory.

Per-package patch semantics remain intentional even though transport uses one archive. Each package keeps its own package root, changed-file list, execution result, patch byte count when non-empty, and SDK baseline commit. Entries in one bundle may use different `sdkBaseCommitSha` values because generation can occur against separately resolved SDK baselines.

Only a verified HTTP 404 means the artifact is unavailable. Authentication failures, throttling, server errors, malformed metadata, and bounded-download or extraction failures fail validation. Azure Pipelines retention can remove old artifacts; the event-driven handoff then reports that no artifact is available.

## Ownership boundaries

| Component | Responsibility |
| --- | --- |
| Azure Pipelines producer | Generated SDK capture and complete bundle publication |
| Shared schema | Versioned bundle contract and structural limits |
| GitHub validation workflow | Trusted event/build identity, bounded archive extraction, resource/path/byte-count validation, summary, and validated artifact upload |

The handoff remains report-only and has no pull request write permissions.
