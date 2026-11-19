import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Web;

/** Sensitive desired variables returned only by the separately authorized listVariables action. */
@added(Versions.v2026_11_15)
model BuilderAppVariableValues {
  /** Current desired variable names and decrypted values. */
  @identifiers(#["name"])
  value: BuilderAppVariableValue[];
}

/** A sensitive variable value. Ordinary resource responses never include this value. */
@added(Versions.v2026_11_15)
model BuilderAppVariableValue {
  /** Environment variable name. */
  name: string;

  /** Sensitive current desired value. */
  @secret
  value: string;
}

/** Request to begin or replay a bounded source archive upload. */
@added(Versions.v2026_11_15)
model BuilderAppBeginSourceUploadRequest {
  /** Stable client key. Reusing the key requires identical immutable upload input. */
  idempotencyKey: string;

  /** Optional app manifest supplied separately from the archive. When supplied, its decoded UTF-8 content must not exceed 1 MiB. This byte limit is distinct from the serialized JSON request size. */
  manifestYaml?: string;

  /** Self-reported workflow origin, used only for bounded audit metadata. */
  origin?: BuilderAppSourceUploadOrigin;
}

/** Optional workflow origin, not an authorization assertion. */
@added(Versions.v2026_11_15)
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
@added(Versions.v2026_11_15)
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
@added(Versions.v2026_11_15)
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
@added(Versions.v2026_11_15)
model BuilderAppDeployRequest {
  /** Stable request key. Supply this or the x-ms-client-request-id header. */
  idempotencyKey?: string;

  /** Retained version to deploy. Cannot be combined with commitSha, buildMode, or uploaded source. */
  versionId?: string;

  /** Whether to rebuild source or reuse retained build artifacts. Defaults to ReuseArtifacts. Rebuild cannot be combined with commitSha or uploaded source. */
  buildMode?: BuilderAppBuildMode;

  /** Exact repository commit, mutually exclusive with versionId and uploaded source. */
  @pattern("^[0-9a-fA-F]{40}$")
  commitSha?: string;

  /** Uploaded source artifact. Cannot be combined with repository commit, version, or build mode selection. */
  source?: BuilderAppUploadedDeploymentSource;
}

/** Build modes for a deployment. */
@added(Versions.v2026_11_15)
union BuilderAppBuildMode {
  /** Reuse retained build artifacts for the resolved source when available. */
  ReuseArtifacts: "ReuseArtifacts",

  /** Build the resolved source again even when retained artifacts exist. */
  Rebuild: "Rebuild",

  string,
}

/** A previously uploaded source artifact. Archive integrity metadata is computed by the service during upload. */
@added(Versions.v2026_11_15)
model BuilderAppUploadedDeploymentSource {
  /** Uploaded source discriminator. */
  kind: "uploadedArtifact";

  /** Opaque identifier returned by beginSourceUpload. */
  artifactId: string;
}

/** Redeploy retained ready artifacts. Commit, version, source, and build mode selection are not accepted. */
@added(Versions.v2026_11_15)
model BuilderAppRedeployRequest {
  /** Stable request key. Supply this or the x-ms-client-request-id header. */
  idempotencyKey?: string;
}

/** Request to start or stop the app runtime. */
@added(Versions.v2026_11_15)
model BuilderAppRuntimeActionRequest {
  /** Stable request key. Supply this or the x-ms-client-request-id header. */
  idempotencyKey?: string;
}

/** Optional client request identifier used as the deployment idempotency key. */
@added(Versions.v2026_11_15)
model BuilderAppDeploymentParameters {
  /** Stable request identifier used when the body omits idempotencyKey. */
  @header("x-ms-client-request-id")
  clientRequestId?: string;
}
