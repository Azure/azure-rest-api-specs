import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./BuilderAppActions.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/** A managed application built from a connected repository or uploaded source. */
@added(Versions.v2026_11_15)
model BuilderApp is TrackedResource<BuilderAppProperties> {
  ...ResourceNameParameter<
    Resource = BuilderApp,
    KeyName = "name",
    SegmentName = "builderApps",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]{1,58}[A-Za-z0-9]$"
  >;
  ...ManagedServiceIdentityProperty;
}

/** Desired configuration and read-only serving state of a builder app. */
@added(Versions.v2026_11_15)
model BuilderAppProperties {
  /** Optional repository connection. Once attached, the provider and repository ID cannot change. */
  source?: BuilderAppSource;

  /** Current repository authorization state. */
  @visibility(Lifecycle.Read)
  sourceIntegrationState?: BuilderAppSourceIntegrationState;

  /** Resource operation state, independent of application runtime health. */
  @visibility(Lifecycle.Read)
  provisioningState?: BuilderAppProvisioningState;

  /** Desired external configuration captured by the next application version. */
  versionConfiguration?: BuilderAppVersionConfiguration;

  /** Telemetry applied independently of version activation. Omit to preserve; use {} to clear. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  telemetry?: BuilderAppTelemetry;

  /** Per-component scaling applied independently of version activation. Not accepted by PATCH. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scaling?: BuilderAppScaling;

  /** The deployment currently serving traffic. */
  @visibility(Lifecycle.Read)
  runtime?: BuilderAppRuntime;

  /** Progress of the latest managed identity update. */
  @visibility(Lifecycle.Read)
  identityUpdate?: BuilderAppIdentityUpdate;

  /** Assigned user-managed identity selected for AZURE_CLIENT_ID. Omission selects the system-assigned identity on PUT and preserves the selection on PATCH. */
  azureClientIdIdentityResourceId?: Azure.Core.armResourceIdentifier;
}

/** Repository connection and authorization supplied for a builder app. */
@added(Versions.v2026_11_15)
model BuilderAppSource {
  /** Source provider; existing connections cannot change provider. */
  provider: BuilderAppSourceType;

  /** Provider-stable repository identifier, represented as a string. Cannot replace an attached repository. */
  id: string;

  /** Provider-canonical repository name, such as owner/repository. */
  displayName: string;

  /** Moving reference, such as a branch or tag, resolved when deploying. */
  reference: string;

  /** Repository-relative root for the app manifest and component paths. */
  rootDirectory?: string;

  /** Whether pushes to the selected reference automatically create deployments. */
  autoDeploy?: boolean;

  /** Short-lived source authorization assertion. Mutually exclusive with repositoryToken; never returned. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  authorizationToken?: string;

  /** GitHub user credential used only during this write. Mutually exclusive with authorizationToken; never returned. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  repositoryToken?: string;
}

/** Repository fields to merge; omitted fields preserve the current source. Attaching source requires its complete identity and reference. */
@added(Versions.v2026_11_15)
model BuilderAppSourcePatch is OptionalProperties<BuilderAppSource>;

/** Supported source providers. */
@added(Versions.v2026_11_15)
union BuilderAppSourceType {
  /** A GitHub repository. */
  GitHub: "github",

  string,
}

/** State of the repository connection. */
@added(Versions.v2026_11_15)
union BuilderAppSourceIntegrationState {
  /** No repository has been connected. */
  NotConfigured: "NotConfigured",

  /** The repository requires authorization. */
  AuthorizationRequired: "AuthorizationRequired",

  /** The repository is connected and authorized. */
  Configured: "Configured",

  string,
}

/** Resource lifecycle state. */
@added(Versions.v2026_11_15)
@Azure.Core.lroStatus
union BuilderAppProvisioningState {
  ResourceProvisioningState,

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  string,
}

/** External configuration captured by an application version. */
@added(Versions.v2026_11_15)
model BuilderAppVersionConfiguration {
  /**
   * Omit to preserve variables; [] clears. An explicit list replaces the set.
   * Names are unique ignoring case; PORT and BuilderApps platform-managed names are reserved.
   * Values are limited to 32 KiB UTF-8 each; all names and values together to 64 KiB.
   */
  @maxItems(100)
  @identifiers(#["name"])
  variables?: BuilderAppVariable[];

  /** Named components in the version configuration. Not accepted by PATCH. */
  @identifiers(#["name"])
  @visibility(Lifecycle.Read, Lifecycle.Create)
  components?: BuilderAppVersionComponent[];
}

/** Version configuration for a named component. */
@added(Versions.v2026_11_15)
model BuilderAppVersionComponent {
  /** Component name. */
  name: string;
}

/** A version variable whose value is accepted on write but omitted from ordinary resource responses. */
@added(Versions.v2026_11_15)
model BuilderAppVariable {
  /** Environment variable name, unique ignoring case. PORT and BuilderApps platform-managed names are reserved. */
  name: string;

  /** Omit to preserve an existing value. A new name requires a value; an empty string is valid. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;
}

/** Progress of an identity update and its deployment handoff. */
@added(Versions.v2026_11_15)
model BuilderAppIdentityUpdate {
  /** Opaque identity operation identifier. */
  id: string;

  /** Time the operation was admitted. */
  createdAt: utcDateTime;

  /** Current phase of the operation. */
  phase: BuilderAppIdentityUpdatePhase;

  /** Requested identity assignment state. */
  requestedIdentity: CommonTypes.ManagedServiceIdentity;

  /** User-assigned identity selected for AZURE_CLIENT_ID. */
  azureClientIdIdentityResourceId?: Azure.Core.armResourceIdentifier;

  /** Deployment that owns runtime completion after handoff. */
  deploymentId?: string;

  /** Failure details when the update fails. */
  failure?: BuilderAppFailure;
}

/** Identity update phases. */
@added(Versions.v2026_11_15)
union BuilderAppIdentityUpdatePhase {
  /** Updating source identity. */
  SourcePending: "sourcePending",

  /** Preparing the redeployment. */
  RedeployPending: "redeployPending",

  /** Deployment submitted; deployment polling owns completion. */
  DeploymentSubmitted: "deploymentSubmitted",

  /** Identity update failed. */
  Failed: "failed",

  string,
}

/** Customer-safe operation failure. */
@added(Versions.v2026_11_15)
model BuilderAppFailure {
  /** Machine-readable error code. */
  code: string;

  /** Explanation of the failure. */
  message: string;
}

/** Serving-state projection, not an embedded deployment history. */
@added(Versions.v2026_11_15)
model BuilderAppRuntime {
  /** Public application URL. */
  url?: url;

  /** Opaque identifier of the active deployment. */
  activeDeploymentId?: string;

  /** Opaque identifier of the active application version. */
  activeAppVersionId?: string;

  /** Configuration captured by the active version, excluding variable values. */
  versionConfiguration?: BuilderAppVersionConfiguration;
}

/** Runtime telemetry destinations. */
@added(Versions.v2026_11_15)
model BuilderAppTelemetry {
  /** Azure Monitor Logs destination. An empty telemetry object disables export. */
  azureMonitorLogs?: BuilderAppAzureMonitorLogs;
}

/** Customer-owned Azure Monitor Logs ingestion destination. */
@added(Versions.v2026_11_15)
model BuilderAppAzureMonitorLogs {
  /** HTTPS data collection endpoint under ingest.monitor.azure.com. */
  dceEndpoint: url;

  /** Immutable data collection rule identifier. */
  dcrImmutableId: string;

  /** Custom stream declared by the rule. */
  streamName: string;

  /** User-assigned ingestion identity. Omit to use the app's system-assigned identity. */
  identityResourceId?: Azure.Core.armResourceIdentifier;
}

/** Desired scaling policies for named components. */
@added(Versions.v2026_11_15)
model BuilderAppScaling {
  /** Scaling policies joined to the active manifest by component name. */
  @identifiers(#["name"])
  components?: BuilderAppScalingComponent[];
}

/** Autoscaling policy for one component. */
@added(Versions.v2026_11_15)
model BuilderAppScalingComponent {
  /** Component name. */
  name: string;

  /** Minimum replicas; zero enables scale-to-zero. */
  @minValue(0)
  minReplicas: int32;

  /** Maximum replicas, greater than minReplicas and at most 20. */
  @minValue(1)
  @maxValue(20)
  maxReplicas: int32;

  /** Target average CPU utilization percentage. */
  cpuUtilizationPercent?: int32;

  /** Target average memory utilization percentage. */
  memoryUtilizationPercent?: int32;

  /** Enable HTTP request-based scaling; a zero minimum always enables it. */
  httpEnabled?: boolean;
}

/** PATCH input. Only supplied members change; read-only and PUT-only configuration is excluded. */
@added(Versions.v2026_11_15)
model BuilderAppPatch {
  /** Omit to preserve; a map replaces all tags; {} clears all tags. Values must be strings. */
  ...PickProperties<
    Foundations.ResourceUpdateModel<BuilderApp, BuilderAppPatchProperties>,
    "tags"
  >;

  /** Identity changes, including the assignment mode. Null dictionary entries remove assignments. */
  identity?: CommonTypes.ManagedServiceIdentity;

  /** Supported desired configuration changes. */
  properties?: BuilderAppPatchProperties;
}

/** Mutable builder app properties accepted by PATCH. */
@added(Versions.v2026_11_15)
model BuilderAppPatchProperties {
  /** Attach or update the same repository connection. Changing an attached repository identity is unsupported. */
  source?: BuilderAppSourcePatch;

  /** Variables to capture in the next application version. */
  versionConfiguration?: BuilderAppPatchVersionConfiguration;

  /** Desired user-assigned identity used for AZURE_CLIENT_ID, also available through PUT and GET. */
  azureClientIdIdentityResourceId?: Azure.Core.armResourceIdentifier;
}

/** PATCH accepts variables but not component configuration. */
@added(Versions.v2026_11_15)
model BuilderAppPatchVersionConfiguration {
  /** Omit to preserve; [] clears; a supplied list replaces the set and preserves omitted existing values. */
  @maxItems(100)
  @identifiers(#["name"])
  variables?: BuilderAppVariable[];
}

/** Pending identity update with operation polling links and no response body. */
@added(Versions.v2026_11_15)
model BuilderAppPatchAccepted {
  ...ArmAcceptedLroResponse<
    "Identity update accepted.",
    ArmCombinedLroHeaders<ArmOperationStatus, BuilderApp> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

/** Builder app resource operations. */
@added(Versions.v2026_11_15)
@armResourceOperations
interface BuilderApps {
  get is ArmResourceRead<BuilderApp>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<BuilderApp>;
  update is ArmCustomPatchAsync<
    BuilderApp,
    BuilderAppPatch,
    Response = ArmResponse<BuilderApp> | BuilderAppPatchAccepted
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    BuilderApp,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  listByResourceGroup is ArmResourceListByParent<BuilderApp>;
  listBySubscription is ArmListBySubscription<BuilderApp>;

  /** Get sensitive current variable values. The response is private and must not be cached. */
  listVariables is ArmResourceActionSync<
    BuilderApp,
    void,
    ArmResponse<BuilderAppVariableValues> & {
      /** Prevent storage of sensitive variable values. */
      @header("Cache-Control")
      cacheControl: "private, no-store";
    }
  >;

  /** Begin or replay a source archive upload session. */
  beginSourceUpload is ArmResourceActionSync<
    BuilderApp,
    BuilderAppBeginSourceUploadRequest,
    ArmResponse<BuilderAppSourceUpload>
  >;

  /** Build and deploy repository source, a retained version, or an uploaded artifact. */
  deploy is ArmResourceActionAsync<
    BuilderApp,
    BuilderAppDeployRequest,
    ArmResponse<BuilderApp>,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, BuilderApp> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = BuilderAppDeploymentParameters
  >;

  /** Redeploy retained ready artifacts without resolving or rebuilding repository source. */
  redeploy is ArmResourceActionAsync<
    BuilderApp,
    BuilderAppRedeployRequest,
    ArmResponse<BuilderApp>,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, BuilderApp> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = BuilderAppDeploymentParameters
  >;
}
