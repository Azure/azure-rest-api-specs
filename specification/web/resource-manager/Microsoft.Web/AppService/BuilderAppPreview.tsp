import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "./BuilderApp.tsp";
import "./BuilderAppAuthConfig.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/** An ephemeral environment that deploys a branch of the parent builder app's repository. Previews cannot be updated; delete and recreate a preview to change it. */
@added(Versions.v2026_11_15)
@parentResource(BuilderApp)
model BuilderAppPreview is ProxyResource<BuilderAppPreviewProperties> {
  ...ResourceNameParameter<
    Resource = BuilderAppPreview,
    KeyName = "previewName",
    SegmentName = "previews",
    NamePattern = "^[A-Za-z0-9_-]{1,63}$"
  >;
}

/** Preview configuration and read-only serving state. The preview is created in the parent app's region, and configuration other than the branch is inherited from the parent app. */
@added(Versions.v2026_11_15)
model BuilderAppPreviewProperties {
  /** Repository branch deployed by the preview. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  branch: string;

  /** Pull request that created the preview, when created automatically. */
  @visibility(Lifecycle.Read)
  pullRequestNumber?: int32;

  /** Title of the pull request that created the preview. */
  @visibility(Lifecycle.Read)
  pullRequestTitle?: string;

  /** Time after which the preview is deleted. */
  @visibility(Lifecycle.Read)
  expiresAt?: utcDateTime;

  /** Repository connection inherited from the parent app. */
  @visibility(Lifecycle.Read)
  source?: BuilderAppSource;

  /** Current repository authorization state. */
  @visibility(Lifecycle.Read)
  sourceIntegrationState?: BuilderAppSourceIntegrationState;

  /** Resource operation state, independent of application runtime health. */
  @visibility(Lifecycle.Read)
  provisioningState?: BuilderAppProvisioningState;

  /** External configuration captured by the next preview version, including shared preview overrides. */
  @visibility(Lifecycle.Read)
  versionConfiguration?: BuilderAppVersionConfiguration;

  /** Telemetry inherited from the parent app. */
  @visibility(Lifecycle.Read)
  telemetry?: BuilderAppTelemetry;

  /** Scaling inherited from the parent app. */
  @visibility(Lifecycle.Read)
  scaling?: BuilderAppScaling;

  /** The deployment currently serving traffic. */
  @visibility(Lifecycle.Read)
  runtime?: BuilderAppRuntime;

  /** Progress of the latest deletion of this preview name. */
  @visibility(Lifecycle.Read)
  deletion?: BuilderAppDeletionStatus;
}

/** Request to deploy the head of the preview's branch or a retained version. Commits and uploaded source are not accepted. */
@added(Versions.v2026_11_15)
model BuilderAppPreviewDeployRequest {
  /** Client-generated identifier that deduplicates retries of this operation; repeating it returns the original operation. Supply this or the x-ms-client-request-id header. */
  clientOperationId?: string;

  /** Retained version to deploy. Cannot be combined with buildMode. */
  versionId?: string;

  /** Whether to rebuild the branch head or reuse retained build artifacts. Defaults to ReuseArtifacts. */
  buildMode?: BuilderAppBuildMode;
}

/** Builder app preview operations. */
@added(Versions.v2026_11_15)
@armResourceOperations
interface BuilderAppPreviews {
  get is ArmResourceRead<BuilderAppPreview>;

  /** Create a preview of a branch. Existing previews cannot be replaced; delete and recreate the preview to change its branch. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<BuilderAppPreview>;

  delete is ArmResourceDeleteSync<BuilderAppPreview>;
  listByBuilderApp is ArmResourceListByParent<BuilderAppPreview>;

  /** Deploy the head of the preview's branch or a retained version. The operation has no final result body. */
  deploy is ArmResourceActionNoResponseContentAsync<
    BuilderAppPreview,
    BuilderAppPreviewDeployRequest,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = BuilderAppDeploymentParameters,
    OptionalRequestBody = true
  >;
}

/** Fixed default authentication configuration of a preview. Use PUT with mode disabled to turn off authentication; DELETE is not supported. */
@added(Versions.v2026_11_15)
@parentResource(BuilderAppPreview)
@singleton("default")
model BuilderAppPreviewAuthConfig
  is ProxyResource<BuilderAppAuthConfigProperties> {
  ...ResourceNameParameter<
    Resource = BuilderAppPreviewAuthConfig,
    KeyName = "authConfigName",
    SegmentName = "authConfigs"
  >;
  ...PickProperties<CommonTypes.AzureEntityResource, "etag">;
}

/** Credential-safe preview authentication configuration response with cache protection and ETag. */
@added(Versions.v2026_11_15)
model BuilderAppPreviewAuthResponse {
  ...ArmResponse<BuilderAppPreviewAuthConfig>;
  ...PickProperties<BuilderAppAuthResponse, "etag" | "cacheControl">;
}

/** Newly persisted preview authentication configuration with cache protection and ETag. */
@added(Versions.v2026_11_15)
model BuilderAppPreviewAuthCreatedResult {
  ...ArmResourceCreatedSyncResponse<BuilderAppPreviewAuthConfig>;
  ...PickProperties<BuilderAppAuthResponse, "etag" | "cacheControl">;
}

/** Credential-safe preview authentication singleton collection with cache protection. */
@added(Versions.v2026_11_15)
model BuilderAppPreviewAuthListResult {
  ...ArmResponse<ResourceListResult<BuilderAppPreviewAuthConfig>>;
  ...PickProperties<BuilderAppAuthResponse, "cacheControl">;
}

/** Preview authentication configuration operations. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The default authentication configuration always exists; it is disabled through PUT with mode disabled rather than deleted."
@added(Versions.v2026_11_15)
@armResourceOperations
interface BuilderAppPreviewAuthConfigs {
  /** List the always-present default configuration, including when authentication is disabled. */
  listByBuilderAppPreview is ArmResourceListByParent<
    BuilderAppPreviewAuthConfig,
    Response = BuilderAppPreviewAuthListResult
  >;

  get is ArmResourceRead<
    BuilderAppPreviewAuthConfig,
    Response = BuilderAppPreviewAuthResponse
  >;

  /** Create or replace the preview's default policy and return its credential-safe representation. Use mode disabled to turn off authentication without deleting the resource. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    BuilderAppPreviewAuthConfig,
    Parameters = BuilderAppAuthConditions,
    Response =
      | BuilderAppPreviewAuthResponse
      | BuilderAppPreviewAuthCreatedResult
  >;
}
