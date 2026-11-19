# Private SDK check metadata POC

ADO still generates and validates SDKs. This POC transports the **entire existing
`spec-gen-sdk-artifact.json`**, not generated code/packages, to a companion GitHub
check in `Azure/azure-rest-api-specs-pr`. There is no public JSON store.
The native Azure Pipelines checks and existing artifact names remain unchanged.
The same change includes the private GitHub status and label readers; public readers
retain their ADO artifact path. Both ends use `@azure-tools/specs-shared/sdk-check-metadata`
for the envelope schema, codecs, byte limit, check names, and native build identity.

## Trust boundary and deployment prerequisites

**This is not deployed or live-integration verified.** A separate trusted pipeline
must be provisioned before enabling the consumer. Do not insert this publisher
into the SDK generation job or its PR-controlled pipeline YAML.

The existing Azure SDK Automation App (1086291) and signing connection are used
by PR jobs for private checkout. **Do not grant that App `checks:write`.** A narrower
token request in PR-editable YAML does not protect its signing credential.

Provision a **different GitHub App and signing key**, installed only on the private
specs repository with `checks:write` (and GitHub's implicit metadata permission).
Give a dedicated Azure service connection access to only that key. The key must
be inaccessible to **all existing source PR pipeline identities**: use a separate
vault if their current signing permissions are vault-wide. Merely adding another
key to a vault those identities can sign with is not isolation. Reuse
`eng/common/scripts/login-to-github.ps1` with explicit App/key arguments; nothing
under mirrored `eng/common` needs modification. The writer token requests only
`azure-rest-api-specs-pr` and `checks:write`.

The publisher pipeline must:

- Live in the private ADO `internal` project, with private logs and a read-only
  build identity allowed to read source builds/timelines/artifacts.
- Use YAML/templates/scripts/dependencies from **public
  `Azure/azure-rest-api-specs`, protected `refs/heads/main`**, not the private
  triggering repository. Same-repository pipeline-completion triggers can select
  the triggering PR commit; using a different repository avoids that trap.
- Authorize the dedicated signing connection only for this publisher, not for
  PR validation pipelines. Enforce a service-connection **required-template check**
  requiring `eng/pipelines/templates/sdk-metadata-publisher.yml` from protected
  public specs `refs/heads/main`. Use it via `extends`, not as an optional nested
  job. The template accepts no executable steps/jobs. Deny queue-time variable
  overrides, arbitrary YAML revisions, and untrusted publisher-definition edits.
  Script guards alone are not authorization.
- Use a protected environment with an **exclusive lock**, `lockBehavior:
  sequential`. Serialize all instances sharing the App/repo
  so simultaneous deliveries cannot race GitHub's non-unique `external_id`.
  The template allocates a fresh Microsoft-hosted agent, checks out only trusted
  code, disables implicit artifact downloads, and never executes source artifacts.
- Set protected variables `SdkMetadataCollectionUri` (canonical
  `https://dev.azure.com/azure-sdk/`), `SdkMetadataProjectId` (internal project
  GUID), `SdkMetadataDefinitionIds` (explicit comma-separated numeric source
  definition allowlist), `SdkMetadataPublisherAppId`, `SdkMetadataKeyVault`, and
  `SdkMetadataKeyName`. There are **no default definition IDs or writer App ID**.
  Set the consumer's protected `SDK_METADATA_PUBLISHER_APP_ID` to the same writer.

Provision **one protected publisher definition per approved private SDK source
definition**, sharing the same exclusive-lock environment. Wire exactly one
completion resource in each publisher's root YAML. Its `source` must be the
actual definition name (including its folder); no definition name/ID is guessed
by this POC. Use this structure with the provisioned values:

```yaml
trigger: none
pr: none
lockBehavior: sequential
resources:
  repositories:
    - repository: trustedPublisher
      type: github
      name: Azure/azure-rest-api-specs
      ref: refs/heads/main
      endpoint: <public specs read-only GitHub connection>
  pipelines:
    - pipeline: sdkValidation
      project: internal
      source: <approved private SDK pipeline definition name>
      trigger: true
extends:
  template: /eng/pipelines/templates/sdk-metadata-publisher.yml@trustedPublisher
  parameters:
    SourceBuildId: $(resources.pipeline.sdkValidation.runID)
    AzureServiceConnection: <dedicated writer signing connection>
    PublisherEnvironment: <protected exclusive-lock environment>
```

Keep the publisher's default branch set to `refs/heads/main`. The selected run is
also checked against its actual private GitHub repository, PR reason, completed
status, project GUID, and definition allowlist through authenticated ADO reads.
Do not pass a publisher build ID as the source build ID.
Do not add multiple source resources while passing a fixed alias's `runID`: a
non-triggering resource can resolve to an older successful build. Multi-resource
dispatch is outside this POC.
If adding branch-control checks, account for the deliberately unprotected source
PR pipeline resource: a blanket "all resources must be protected main" check also
blocks legitimate inputs. Do not waive the required-template check to work around
that; source artifacts are data, and only the publisher's execution is trusted.

Completion notification can precede GitHub's native check update. In that case the
publisher fails explicitly without a success companion. Retry the trusted
publisher against the **same source build** after the native check completes.
No live check write or ADO run is needed to exercise the mocked transport tests.

## Wire contract (version 1)

The name is `SDK metadata / <numeric source definitionId>`, distinguishing
provisioning and non-provisioning definitions even for the same SDK language.
The check's owner is the configured **dedicated writer App**, not Azure Pipelines.
Its `details_url` is copied from the original native pipeline check.

`output.text` is raw compact JSON, with no Markdown fence:

```json
{
  "schemaVersion": 1,
  "kind": "spec-gen-sdk-metadata",
  "build": {
    "collectionUri": "https://dev.azure.com/azure-sdk/",
    "projectId": "00000000-0000-4000-8000-000000000001",
    "definitionId": 123,
    "buildId": 456,
    "stageAttempt": 1,
    "jobAttempt": 1,
    "jobId": "00000000-0000-4000-8000-000000000002"
  },
  "sourceCheck": {
    "id": 789,
    "name": "SDK Validation - .NET - PR",
    "startedAt": "2026-01-01T00:00:00Z",
    "completedAt": "2026-01-01T01:00:00Z"
  },
  "artifact": {
    "language": "azure-sdk-for-net",
    "result": "failed",
    "headSha": "0123456789012345678901234567890123456789",
    "prNumber": "1",
    "labelAction": false,
    "isSpecGenSdkCheckRequired": true,
    "apiViewRequestData": []
  }
}
```

Example IDs are illustrative, not deployment defaults. `artifact` is the parsed
original manifest, validated with the shared `SdkMetadataSchema` **without
projecting away unknown fields**, including nested fields. No required flag or
generation result is reconstructed from configuration. Its PR number/head SHA
must match authenticated source-build trigger metadata.

The immutable `external_id` is:

```text
spec-gen-sdk-metadata:v1:<projectId>:<definitionId>:<buildId>:<stageAttempt>:<jobAttempt>
```

The private PR generation stage publishes a separate artifact named
`spec-gen-sdk-metadata-<stageAttempt>-<jobAttempt>` even on failure when a manifest
exists. Existing artifact publishing uses a canonical success name and
`-FailedAttempt<jobAttempt>` on failure, so those names alone cannot prove retry
freshness. The publisher requires the new exact name and its ADO `source` job ID
to match the single current completed job under stage `Build`. Missing latest
attempt metadata never falls back to a previous successful artifact.

The native check must have App ID 9426/slug `azure-pipelines`, head SHA matching
the source PR, `external_id` equal to
`<definitionId>|<buildId>|<projectId>`, matching collection/project/build URL, and
a completion time no earlier than the current source job. `sourceCheck` copies
its exact ID/name/start/completion timestamps. Consumers must match these against
the **current native check**, not select the highest available metadata attempt:
an old companion must become invalid when the native check is rerun. Consumers
must also validate the native name against their existing language mapping.

Successful **transport** creates one completed, `neutral` check. Its summary is
human-readable; `artifact.result` remains the actual generation result, which may
be failure. Invalid/missing/oversized manifest data produces a completed
`failure` companion **without a JSON envelope** and fails the publisher job.
Source identity/authentication/API/download failures fail the publisher without
inventing a success check; retrying a transient transport failure does not consume
the immutable publication identity. No credentials or downloaded data are printed.

The JSON must fit **65,535 UTF-8 bytes**, conservatively satisfying GitHub's
65,535-character limit; it is never truncated. Identical redelivery is a no-op;
conflicting payloads for the same immutable identity fail. No PATCH or redundant
completed event is emitted. A new source attempt gets a new identity/check.
An already published terminal manifest-validation failure is not rewritten into
success; fix the source metadata and rerun the source job to obtain a new attempt.
POST is not automatically retried after uncertain network results; an operator
can inspect GitHub and rerun the serialized publisher, which first checks for an
identical existing publication.

Publication happens **after** native pipeline completion. Consumers must expose
missing/invalid metadata rather than treating it as success, and re-evaluate
status/labels when the authenticated companion's completed event arrives.
This POC does not deploy App permissions, service
connections, protected variables/environments, pipeline definitions, or triggers.
