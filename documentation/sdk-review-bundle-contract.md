# SDK Review Bundle Contract

The SDK review bundle carries generated SDK changes from spec PR validation to later review and reporting stages. The stages are intentionally separate:

1. Azure Pipelines captures the bundle.
2. The GitHub validation workflow verifies and republishes a validated artifact.
3. A future review runner may consume the validated artifact and run the SDK review skill.
4. A future publisher may replace a managed PR comment.

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
- patch file name, byte count, and SHA-256 checksum

Neither manual replay nor later stages may accept a user-supplied URL or SHA in place of these identities.

## Capture completeness

A complete manifest is all-or-nothing. It contains every expected reviewable package entry and every declared patch. A failed capture is explicit and contains no usable entries. Consumers reject failed, partial, over-budget, path-unsafe, checksum-invalid, or identity-mismatched bundles.

The producer owns complete capture before the generated SDK checkout is reset. The shared schema defines the wire contract. The validation workflow owns event and build identity, resource limits, repository and path safety, checksums, and patch applicability.

## Artifact resolution and retention

The validation workflow resolves the Azure Pipelines artifact once and downloads all files from that resolved target. Only a verified HTTP 404 means the artifact is unavailable. Authentication failures, throttling, server errors, malformed metadata, and bounded-download failures fail validation.

Azure Pipelines retention can remove old artifacts. A replay after retention expiry is expected to report that no artifact is available. Manual replay accepts a PR number and optional build ID, resolves the PR head through GitHub, and selects a trusted completed check for that head. Closed or merged PRs are supported for post-merge canary validation because replay is read-only.

## Patch applicability

After identity, schema, path, size, and checksum validation, a separate validation step checks the complete patch set. Entries are grouped by SDK base commit. For each base, validation uses a sparse, partial public checkout of the declared SDK repository, limited to declared package roots, and runs:

```text
git apply --check --binary
```

The patch is not applied in the validation workspace. The GitHub artifact is uploaded only after every base group passes.

## Future review and publication

The future review runner owns skill execution and consumes only the uploaded validated artifact. Deterministic checks used by the skill should be `azsdk` commands with versioned, machine-readable results.

The future publisher is the only component that should receive PR write permissions. Reruns should replace one managed comment for the same PR and head rather than append duplicate comments. Review execution and comment publication should remain separate jobs or workflows so each receives only the permissions it needs.

## Ownership boundaries

| Component | Responsibility |
| --- | --- |
| Azure Pipelines producer | Generated SDK capture and complete bundle publication |
| Shared schema | Versioned bundle contract and structural limits |
| GitHub validation workflow | Trusted identity, resource, path, checksum, and applicability validation |
| Future review runner | SDK review skill execution |
| Future publisher | Managed PR comment replacement and all PR write permissions |

Validation, review, and publication must remain independently auditable boundaries.
