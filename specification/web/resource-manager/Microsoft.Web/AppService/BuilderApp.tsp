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
  /** Preview environment settings and shared preview variable overrides. Omission on PUT resets them to defaults; omission on PATCH preserves them. */
  previews?: BuilderAppPreviewsConfiguration;

  /** Optional repository connection. Once attached, the provider and repository ID cannot change. */
  source?: BuilderAppSource;

  /** Current repository authorization state. */
  @visibility(Lifecycle.Read)
  sourceIntegrationState?: BuilderAppSourceIntegrationState;

  /** Resource operation state, independent of application runtime health. */
  @visibility(Lifecycle.Read)
  provisioningState?: BuilderAppProvisioningState;

  /** Desired external configuration captured by the next application version. Omission on PUT resets it; omission on PATCH preserves it. */
  versionConfiguration?: BuilderAppVersionConfiguration;

  /** Telemetry applied independently of version activation. Omission or {} on PUT disables export. Not accepted by PATCH. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  telemetry?: BuilderAppTelemetry;

  /** Per-component scaling applied independently of version activation. Not accepted by PATCH. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scaling?: BuilderAppScaling;

  /** The deployment currently serving traffic. */
  @visibility(Lifecycle.Read)
  runtime?: BuilderAppRuntime;

  /** Progress of the latest managed identity save. Deploy separately to apply saved identity changes to the runtime. */
  @visibility(Lifecycle.Read)
  identityUpdate?: BuilderAppIdentityUpdate;

  /** Progress of the latest deletion of this app name, retained after the app is recreated. */
  @visibility(Lifecycle.Read)
  deletion?: BuilderAppDeletionStatus;

  /** Assigned user-managed identity selected for AZURE_CLIENT_ID. Omission selects the system-assigned identity on PUT and preserves the selection on PATCH. */
  azureClientIdIdentityResourceId?: Azure.Core.armResourceIdentifier;
}

/** Preview environment configuration inherited by previews created from this app. */
@added(Versions.v2026_11_15)
model BuilderAppPreviewsConfiguration {
  /** Preview creation and lifetime policy. */
  settings?: BuilderAppPreviewSettings;

  /** Variable overrides applied over the app's variables when a preview is created. */
  versionConfiguration?: BuilderAppPreviewVersionConfiguration;
}

/** Preview creation and lifetime policy. */
@added(Versions.v2026_11_15)
model BuilderAppPreviewSettings {
  /** Whether a preview is created automatically for each new same-repository pull request. Defaults to false. */
  autoCreatePreviews?: boolean;

  /** Hours a preview lives before it is deleted. Defaults to 72. */
  @minValue(1)
  @maxValue(168)
  lifetimeHours?: int32;
}

/** Shared variable overrides applied to previews. */
@added(Versions.v2026_11_15)
model BuilderAppPreviewVersionConfiguration {
  /** Replaces the overrides; [] clears them. Required when previews.versionConfiguration is supplied. An entry without a value preserves the existing override with that name, not the app's value. Values are write-only. */
  @maxItems(100)
  @identifiers(#["name"])
  variables?: BuilderAppVariable[];
}

/** Customer-safe deletion status. */
@added(Versions.v2026_11_15)
model BuilderAppDeletionStatus {
  /** Opaque deletion operation identifier. */
  operationId: string;

  /** Deletion operation status. */
  status: BuilderAppDeletionOperationStatus;

  /** Time the deletion started. */
  startTime: utcDateTime;

  /** Time the deletion completed. */
  endTime?: utcDateTime;

  /** Azure-AsyncOperation status URL for the deletion. */
  operationUrl?: url;

  /** Deletion progress. */
  properties: BuilderAppDeletionProgress;
}

/** Deletion operation status. */
@added(Versions.v2026_11_15)
union BuilderAppDeletionOperationStatus {
  /** Deletion is in progress. */
  InProgress: "InProgress",

  /** Deletion completed. */
  Succeeded: "Succeeded",

  string,
}

/** Deletion progress. Deadlines describe retry or eligibility times, never promised completion. */
@added(Versions.v2026_11_15)
model BuilderAppDeletionProgress {
  /** Current deletion phase. */
  phase: BuilderAppDeletionPhase;

  /** Artifacts removed by this deletion. */
  artifactCleanupScope: BuilderAppArtifactCleanupScope;

  /** Earliest time in-flight artifact publishers are drained. */
  publisherDrainUntil?: utcDateTime;

  /** Next time a failed cleanup step is retried. */
  nextRetryAt?: utcDateTime;

  /** Number of cleanup retries attempted. */
  retryAttemptCount: int32;

  /** Reason for the pending retry. */
  retryReason?: string;
}

/** Deletion phases. */
@added(Versions.v2026_11_15)
union BuilderAppDeletionPhase {
  /** Deletion is queued. */
  Queued: "Queued",

  /** The application runtime is being stopped. */
  StoppingApp: "StoppingApp",

  /** Waiting for in-flight artifact publishers to drain. */
  WaitingForPublishers: "WaitingForPublishers",

  /** Build and image artifacts are being deleted. */
  DeletingArtifacts: "DeletingArtifacts",

  /** Remaining state is being removed. */
  Finalizing: "Finalizing",

  /** Deletion completed. */
  Completed: "Completed",

  string,
}

/** Artifact cleanup scopes. */
@added(Versions.v2026_11_15)
union BuilderAppArtifactCleanupScope {
  /** Artifacts owned by this app's lifecycle. */
  LifecycleArtifacts: "LifecycleArtifacts",

  /** Runtime state only, for apps created before artifact ownership tracking. */
  LegacyRuntimeOnly: "LegacyRuntimeOnly",

  /** All artifacts in the subscription, during subscription deletion. */
  SubscriptionArtifacts: "SubscriptionArtifacts",

  string,
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

  /** Whether pushes to the selected reference automatically create deployments. Defaults to Push when attaching a repository; PATCH omission preserves the setting. */
  deploymentTrigger?: BuilderAppDeploymentTrigger;

  /**
   * Write-only source authorization assertion obtained from the BuilderApps repository-connection flow.
   * Valid for 10 minutes and bound to the repository, app, Azure caller, reference, and root directory.
   * Supply this or repositoryToken when attaching or reauthorizing a repository.
   * This is not the Azure Resource Manager bearer token. It is not persisted or returned.
   * Repository access is revalidated by the service; reconnect to obtain a new assertion after expiry or revocation.
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  authorizationToken?: string;

  /**
   * Write-only GitHub user access token obtained through GitHub authorization or the BuilderApps repository-connection flow.
   * The token must identify a user with access to the selected repository; the BuilderApps GitHub application must also have access.
   * Used transiently to validate the user, repository, installation, and reference during this write; not persisted or returned.
   * Expiry and revocation are controlled by GitHub. Obtain a replacement from the issuing authorization flow when needed.
   * Mutually exclusive with authorizationToken and distinct from the Azure Resource Manager bearer token.
   */
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

/** What starts a deployment of the connected source reference. */
@added(Versions.v2026_11_15)
union BuilderAppDeploymentTrigger {
  /** Each push to the selected reference creates a deployment. */
  Push: "Push",

  /** Deployments start only through the deploy action. */
  Manual: "Manual",

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
   * Omission on PUT resets variables to an empty set; [] clears. An explicit list replaces the set.
   * PATCH omission preserves the current set.
   * Names are unique ignoring case; PORT and BuilderApps platform-managed names are reserved.
   * Values are limited to 32 KiB UTF-8 each; all names and values together to 64 KiB.
   */
  @maxItems(100)
  @identifiers(#["name"])
  variables?: BuilderAppVariable[];

  /** Named components in the version configuration, unique by name. Not accepted by PATCH. */
  @maxItems(20)
  @identifiers(#["name"])
  @visibility(Lifecycle.Read, Lifecycle.Create)
  components?: BuilderAppVersionComponent[];

  /**
   * Service connections captured by the next application version, unique by name ignoring case.
   * Omission on PUT resets connections; [] clears them. PATCH omission preserves them.
   */
  @maxItems(20)
  @identifiers(#["name"])
  connections?: BuilderAppConnection[];
}

/** Version configuration for a named component. */
@added(Versions.v2026_11_15)
model BuilderAppVersionComponent {
  /** Component name. Must identify a component in the app manifest. */
  @maxLength(63)
  name: string;
}

/** A named service connection projected into application environment variables. */
@added(Versions.v2026_11_15)
model BuilderAppConnection {
  /** Connection name, unique ignoring case. */
  name: string;

  /** Connection profile type that defines the accepted settings and credential fields. */
  type: string;

  /** Destination resource validated by the connection profile, not the calling identity. */
  resourceId?: Azure.Core.armResourceIdentifier;

  /** Managed identity used by the application to reach the destination. Omission selects no identity. */
  managedIdentity?: BuilderAppConnectionManagedIdentity;

  /** Non-secret settings mapped to application environment variables. */
  @identifiers(#["field"])
  settings: BuilderAppConnectionSetting[];

  /** Protected credential fields mapped to application environment variables. */
  @identifiers(#["field"])
  credentials?: BuilderAppConnectionCredential[];
}

/** Identity selection for a connection. */
@added(Versions.v2026_11_15)
model BuilderAppConnectionManagedIdentity {
  /** SystemAssigned selects this app's identity; UserAssigned selects resourceId. */
  type: BuilderAppConnectionIdentityType;

  /** Assigned user-managed identity. Required when type is UserAssigned. */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/** Connection identity types. */
@added(Versions.v2026_11_15)
union BuilderAppConnectionIdentityType {
  /** The app's system-assigned identity. */
  SystemAssigned: "SystemAssigned",

  /** An assigned user-managed identity. */
  UserAssigned: "UserAssigned",

  string,
}

/** A non-secret connection setting. */
@added(Versions.v2026_11_15)
model BuilderAppConnectionSetting {
  /** Profile field name. */
  field: string;

  /** Setting value. */
  value: string;

  /** Application environment variable that receives the value. */
  environmentVariable: string;
}

/** A protected connection credential mapping. */
@added(Versions.v2026_11_15)
model BuilderAppConnectionCredential {
  /** Profile credential field name. */
  field: string;

  /** Application environment variable that receives the credential at runtime only. */
  environmentVariable: string;

  /** Write-only credential value, stored as a protected variable and never returned. Omission preserves only an existing value for the same connection, field, and environment variable. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;
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

/** Progress of an identity save. Saving identity settings does not deploy them to the application runtime. */
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

  /** Failure details when the update fails. */
  failure?: BuilderAppFailure;
}

/** Identity update phases. */
@added(Versions.v2026_11_15)
union BuilderAppIdentityUpdatePhase {
  /** Saving source identity settings. */
  SourcePending: "sourcePending",

  /** Identity settings saved. Deploy separately to apply the saved settings to the runtime. */
  Saved: "saved",

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
  /** Run state requested through the start and stop actions. */
  desiredRunState?: BuilderAppDesiredRunState;

  /** Observed run state of the application runtime. */
  runState?: BuilderAppRunState;

  /** Public application URL. */
  url?: url;

  /** Opaque identifier of the active deployment. */
  activeDeploymentId?: string;

  /** Opaque identifier of the active application version. */
  activeAppVersionId?: string;

  /** Configuration captured by the active version, excluding variable and credential values. */
  versionConfiguration?: BuilderAppVersionConfiguration;
}

/** Requested run states. */
@added(Versions.v2026_11_15)
union BuilderAppDesiredRunState {
  /** The app should serve traffic. */
  Running: "running",

  /** The app should be stopped and its public route blocked. */
  Stopped: "stopped",

  string,
}

/** Observed run states. */
@added(Versions.v2026_11_15)
union BuilderAppRunState {
  /** The app is running. */
  Running: "running",

  /** The app is stopped. */
  Stopped: "stopped",

  /** The run state could not be determined. */
  Unknown: "unknown",

  string,
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
  dataCollectionEndpointUrl: url;

  /** Immutable data collection rule ingestion identifier, not the rule's Azure Resource Manager resource ID. */
  dataCollectionRuleImmutableId: string;

  /** Custom stream declared by the rule. */
  streamName: string;

  /** User-assigned ingestion identity. Omit to use the app's system-assigned identity. */
  identityResourceId?: Azure.Core.armResourceIdentifier;
}

/** Desired scaling policies for named components. */
@added(Versions.v2026_11_15)
model BuilderAppScaling {
  /** Scaling policies joined to the active manifest by component name. Names must be unique and identify scalable manifest components; unknown or static targets are rejected. */
  @maxItems(20)
  @identifiers(#["name"])
  components?: BuilderAppScalingComponent[];
}

/** Autoscaling policy for one component. */
@added(Versions.v2026_11_15)
model BuilderAppScalingComponent {
  /** Component name. */
  @maxLength(63)
  name: string;

  /** Minimum replicas; zero enables scale-to-zero and requires RequestBased HTTP scaling. */
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

  /** HTTP request scaling. Defaults to None, or RequestBased when minReplicas is zero. */
  httpScaling?: BuilderAppHttpScaling;
}

/** HTTP request scaling modes. */
@added(Versions.v2026_11_15)
union BuilderAppHttpScaling {
  /** Replicas scale with concurrent HTTP requests, in addition to any utilization targets. */
  RequestBased: "RequestBased",

  /** HTTP traffic does not drive scaling. */
  None: "None",

  string,
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
  /** Preview settings and shared variable overrides to update. Omitted members preserve their current values; a supplied member replaces that member. */
  previews?: BuilderAppPreviewsConfiguration;

  /** Attach or update the same repository connection. Changing an attached repository identity is unsupported. */
  source?: BuilderAppSourcePatch;

  /** Variables to capture in the next application version. */
  versionConfiguration?: BuilderAppPatchVersionConfiguration;

  /** Desired user-assigned identity used for AZURE_CLIENT_ID, also available through PUT and GET. In PATCH, supply it with an identity object, name a user-assigned identity in the resulting assignment, and omit source and versionConfiguration. The selection applies on the next deployment. */
  azureClientIdIdentityResourceId?: Azure.Core.armResourceIdentifier;
}

/** PATCH accepts variables and connections but not component configuration. */
@added(Versions.v2026_11_15)
model BuilderAppPatchVersionConfiguration {
  /** Omit to preserve; [] clears; a supplied list replaces the set and preserves omitted existing values. */
  @maxItems(100)
  @identifiers(#["name"])
  variables?: BuilderAppVariable[];

  /** Omit to preserve; [] clears; a supplied list replaces the connections. */
  @maxItems(20)
  @identifiers(#["name"])
  connections?: BuilderAppConnection[];
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

  /** Update desired configuration. Identity updates save assignments; deploy separately after the save completes to apply them to the runtime. */
  update is ArmCustomPatchAsync<
    BuilderApp,
    BuilderAppPatch,
    Response = ArmResponse<BuilderApp> | BuilderAppPatchAccepted
  >;
  /** Delete the app. The Location result returns 202 while deletion is pending and 204 after it succeeds. */
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

  /** Build and deploy repository source, a retained version, or an uploaded artifact. The operation has no final result body; the Location result returns 204 after success. */
  deploy is ArmResourceActionNoResponseContentAsync<
    BuilderApp,
    BuilderAppDeployRequest,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = BuilderAppDeploymentParameters,
    OptionalRequestBody = true
  >;

  /** Redeploy retained ready artifacts without resolving or rebuilding repository source. The operation has no final result body; the Location result returns 204 after success. */
  redeploy is ArmResourceActionNoResponseContentAsync<
    BuilderApp,
    BuilderAppRedeployRequest,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = BuilderAppDeploymentParameters,
    OptionalRequestBody = true
  >;

  /** Start the latest deployed runtime without rebuilding its application version. The operation has no final result body; the Location result returns 204 after success. */
  start is ArmResourceActionNoResponseContentAsync<
    BuilderApp,
    BuilderAppRuntimeActionRequest,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = BuilderAppDeploymentParameters,
    OptionalRequestBody = true
  >;

  /** Stop the app and block its public route without deleting its deployment. The operation has no final result body; the Location result returns 204 after success. */
  stop is ArmResourceActionNoResponseContentAsync<
    BuilderApp,
    BuilderAppRuntimeActionRequest,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = BuilderAppDeploymentParameters,
    OptionalRequestBody = true
  >;
}
