import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Web;

/** Sensitive desired variables returned only by the separately authorized listVariables action. */
@added(Versions.v2026_09_01_preview)
model BuilderAppVariableValues {
  /** Current desired variable names and decrypted values. */
  @identifiers(#["name"])
  value: BuilderAppVariableValue[];
}

/** A sensitive variable value. Ordinary resource responses never include this value. */
@added(Versions.v2026_09_01_preview)
model BuilderAppVariableValue {
  /** Environment variable name. */
  name: string;

  /** Sensitive current desired value. */
  @secret
  value: string;
}

/** Request to begin or replay a bounded source archive upload. */
@added(Versions.v2026_09_01_preview)
model BuilderAppBeginSourceUploadRequest {
  /** Stable client key. Reusing the key requires identical immutable upload input. */
  idempotencyKey: string;

  /** App manifest supplied separately from the archive, at most 1 MiB UTF-8. */
  @maxLength(1048576)
  manifestYaml: string;

  /** Archive length in bytes, from 1 byte to 100 MiB. */
  @minValue(1)
  @maxValue(104857600)
  contentLength: int64;

  /** Lowercase SHA-256 digest of the archive. */
  @pattern("^[0-9a-f]{64}$")
  sha256: string;

  /** Self-reported workflow origin, used only for bounded audit metadata. */
  origin?: BuilderAppSourceUploadOrigin;
}

/** Optional workflow origin, not an authorization assertion. */
@added(Versions.v2026_09_01_preview)
model BuilderAppSourceUploadOrigin {
  /** Source repository name. */
  @maxLength(256)
  repository?: string;

  /** Workflow name. */
  @maxLength(128)
  workflow?: string;

  /** Workflow run identifier. */
  @maxLength(128)
  runId?: string;

  /** Workflow run attempt. */
  @maxLength(64)
  runAttempt?: string;
}

/** Source archive upload session state. */
@added(Versions.v2026_09_01_preview)
union BuilderAppSourceUploadState {
  /** Waiting for the archive upload. */
  WaitingForUpload: "waitingForUpload",

  /** Archive upload in progress. */
  Uploading: "uploading",

  /** Archive uploaded. */
  Uploaded: "uploaded",

  /** Archive bound to a deployment request. */
  Bound: "bound",

  /** Archive consumed by a deployment. */
  Consumed: "consumed",

  /** Upload failed. */
  Failed: "failed",

  /** Upload session expired. */
  Expired: "expired",

  string,
}

/** Customer-safe upload session response. */
@added(Versions.v2026_09_01_preview)
model BuilderAppSourceUpload {
  /** Opaque source artifact identifier. */
  artifactId: string;

  /** Upload session state. */
  state: BuilderAppSourceUploadState;

  /** Short-lived upload URL, when the session accepts an upload. */
  @secret
  uploadUrl?: url;

  /** Time by which the archive must be uploaded. */
  uploadDeadline: utcDateTime;

  /** Time by which the archive must be committed to a deployment. */
  uncommittedDeadline: utcDateTime;

  /** Associated deployment identifier, when consumed. */
  deploymentId?: string;

  /** Customer-safe failure information. */
  failure?: BuilderAppFailure;
}

/** Request to build or deploy a connected reference, retained version, or uploaded source. */
@added(Versions.v2026_09_01_preview)
model BuilderAppDeployRequest {
  /** Stable request key. Supply this or the x-ms-client-request-id header. */
  idempotencyKey?: string;

  /** Retained version to deploy. Cannot be combined with commitSha or uploaded source. */
  versionId?: string;

  /** Whether to rebuild source rather than reuse retained artifacts. */
  rebuild?: boolean;

  /** Exact repository commit, mutually exclusive with versionId and uploaded source. */
  @pattern("^[0-9a-fA-F]{40}$")
  commitSha?: string;

  /** Uploaded source artifact. Cannot be combined with repository commit, version, or rebuild selection. */
  source?: BuilderAppUploadedDeploymentSource;
}

/** A previously uploaded source artifact and its integrity information. */
@added(Versions.v2026_09_01_preview)
model BuilderAppUploadedDeploymentSource {
  /** Uploaded source discriminator. */
  kind: "uploadedArtifact";

  /** Opaque identifier returned by beginSourceUpload. */
  artifactId: string;

  /** Lowercase SHA-256 digest of the uploaded archive. */
  @pattern("^[0-9a-f]{64}$")
  sha256: string;

  /** Uploaded archive length in bytes. */
  @minValue(1)
  @maxValue(104857600)
  contentLength: int64;
}

/** Redeploy retained ready artifacts. Commit, version, source, and rebuild selection are not accepted. */
@added(Versions.v2026_09_01_preview)
model BuilderAppRedeployRequest {
  /** Stable request key. Supply this or the x-ms-client-request-id header. */
  idempotencyKey?: string;
}

/** Deployment admission details, not the final resource returned by operation polling. */
@added(Versions.v2026_09_01_preview)
model BuilderAppDeploymentAdmission {
  /** Opaque deployment identifier. */
  deploymentId: string;

  /** Deployment status. */
  status: string;
}

/** Optional client request identifier used as the deployment idempotency key. */
@added(Versions.v2026_09_01_preview)
model BuilderAppDeploymentParameters {
  /** Stable request identifier used when the body omits idempotencyKey. */
  @header("x-ms-client-request-id")
  clientRequestId?: string;
}

/** Deployment accepted with links to the operation monitor and final result. */
@added(Versions.v2026_09_01_preview)
model BuilderAppDeploymentAccepted {
  ...ArmAcceptedLroResponse<
    "Deployment accepted.",
    ArmCombinedLroHeaders<BuilderAppOperationStatus, BuilderApp> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Deployment admission details. */
  @bodyRoot
  body: BuilderAppDeploymentAdmission;
}
