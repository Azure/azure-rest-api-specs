using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

model CommitSandboxRequest {
  labels?: null | Record<string>;
}

model CommitSandboxResponseView {
  diskImage: DiskImageResponseView;
}

/**
 * Per-identity availability setting on a sandbox.
 * Allows explicit control over which identities from the group are served to the sandbox.
 */
model IdentitySetting {
  /**
   * The identity reference — ARM resource ID for user-assigned, "system" for system-assigned,
   * or a client ID.
   */
  identity: string;

  /** Lifecycle phase gating for this identity. */
  lifecycle?: IdentitySettingLifecycle;
}

/** Controls which identity lifecycle phases a specific identity is available in. */
union IdentitySettingLifecycle {
  "None",
  "Main",
  "All",
}

union PresetSandboxType {
  "None",
  "GitHubCopilot",

  @removed(Versions.v2026_09_01)
  "Moltbot",

  @removed(Versions.v2026_09_01)
  "UbuntuSystemd",

  "Claude",

  @removed(Versions.v2026_09_01)
  "OpenClaw",

  null,
}

scalar ProjectId;

/** Reference to an agent identity for assigning to a sandbox. */
model SandboxAgentIdentityRefView {
  /** Tenant ID where the agent identity is registered. */
  tenantId: TenantId;

  /** Unique identifier for the agent identity. */
  agentId: string;
}

model SandboxAutoDeletePolicy {
  enabled: boolean;
  deleteIntervalInDays?: NullableInt32OrString;
  deleteIntervalInSeconds?: NullableInt64OrString;
  @oneOf trigger?: null | AutoDeleteTrigger;
}

model SandboxAutoSuspendPolicy {
  enabled: boolean;
  interval?: NullableInt32OrString;
  @oneOf mode?: null | SandboxSuspendMode;
}

model SandboxExecuteCommandRequestView {
  command: string;
  args?: string[];
  environment?: Record<string>;
  workingDirectory?: null | string;
  user?: null | string;
  activationMode?: PortActivationMode;
}

model SandboxExecuteCommandResponseView {
  exitCode: Int32OrString;
  stdout: string;
  stderr: string;
  executionTimeMs: Int64OrString;
}

model SandboxExecuteShellCommandRequestView {
  command: string;
  shell?: null | string;
  environment?: Record<string>;
  workingDirectory?: null | string;
  user?: null | string;
  activationMode?: PortActivationMode;
}

model SandboxExecuteShellCommandResponseView {
  exitCode: Int32OrString;
  stdout: string;
  stderr: string;
  executionTimeMs: Int64OrString;
}

scalar SandboxGroupId;

/**
 * Customer-supplied selector that picks one of the managed identities
 * already on a sandbox group.
 */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union SandboxGroupIdentitySelector {
  SystemAssigned: SandboxGroupIdentitySelectorSystemAssignedIdentitySelector,
  UserAssigned: SandboxGroupIdentitySelectorUserAssignedIdentitySelector,
}

/** Selects the sandbox group's system-assigned managed identity. */
model SandboxGroupIdentitySelectorSystemAssignedIdentitySelector {
  kind?: "SystemAssigned";
}

/** Selects a specific user-assigned managed identity by its ARM resource ID. */
model SandboxGroupIdentitySelectorUserAssignedIdentitySelector {
  kind?: "UserAssigned";
  resourceId: ArmUserAssignedIdentityId;
}

scalar SandboxId;

model SandboxLifecyclePolicy {
  @oneOf autoSuspendPolicy: null | SandboxAutoSuspendPolicy;
  @oneOf autoDeletePolicy: null | SandboxAutoDeletePolicy;
}

/**
 * Preset-specific properties for sandbox creation.
 * These properties configure optional features for specific preset types.
 */
model SandboxPresetPropertiesView {
  /**
   * Whether to enable the WorkIQ (m365-mihshah) connection for the GitHubCopilot preset.
   * When true, the WorkIQ managed API must be available in the region.
   */
  isWorkIqConnectionEnabled?: boolean;
}

model SandboxRequestView {
  labels?: Record<string>;

  @removed(Versions.v2026_09_01)
  @oneOf
  vmmType?: null | VmmType;

  entrypoint?: null | string[];
  cmd?: null | string[];
  environment?: null | Record<string>;
  @oneOf sourcesRef?: null | SandboxSourceView;
  @oneOf resources?: null | SandboxResourcesView;
  connections?: null | unknown[];
  gatewayConnections?: null | GatewayConnectionView[];
  credentialRefs?: null | string[];
  ports?: null | AddPortRequest[];
  @oneOf egressPolicy?: null | SandboxEgressPolicyView;
  egressPolicyId?: null | string;
  @oneOf sandboxGroupId?: null | SandboxGroupId;
  @oneOf presetSandboxType?: null | PresetSandboxType;

  @secret
  anthropicApiKey?: null | string;

  @oneOf presetProperties?: null | SandboxPresetPropertiesView;
  @oneOf lifecycle?: null | SandboxLifecyclePolicy;
  @oneOf agentIdentity?: null | SandboxAgentIdentityRefView;
  identitySettings?: null | IdentitySetting[];
  @oneOf telemetryConfig?: null | TelemetryConfig;
  volumes?: null | SandboxVolumeView[];
  @oneOf projectId?: null | ProjectId;
  contentPackageDownloads?: null | SandboxContentPackageDownloadView[];
  vnetConnectionName?: null | string;

  @removed(Versions.v2026_09_01)
  customerVnetConnectionName?: null | string;

  systemVnetConnectionName?: null | string;

  @removed(Versions.v2026_09_01)
  @oneOf
  executionTokens?: null | SandboxExecutionTokensRequestView;

  /** Resolved server-side from the sandbox group. Not part of the wire contract. */
  isDelegationBackingResource?: boolean;
}

model SandboxResourcesView {
  cpu: CpuQuantity;
  memory: MemoryQuantity;
  @oneOf disk?: null | StorageQuantity;

  @removed(Versions.v2026_09_01)
  @oneOf
  gpu?: null | SandboxGpuView;
}

model SandboxResponseView {
  id: SandboxId;
  labels?: Record<string>;

  @removed(Versions.v2026_09_01)
  vmmType: VmmType;

  entrypoint?: null | string[];
  cmd?: null | string[];
  sourcesRef: SandboxSourceView;
  resources: SandboxResourcesView;
  createdAt?: null | utcDateTime;
  @oneOf state?: null | SandboxState;
  @oneOf stateDetails?: null | SandboxStateDetails;
  @oneOf snapshotId?: null | SnapshotId;
  @oneOf coldStorageSizeInMB?: null | MegaBytes;
  ports?: SandboxPortView[];
  connections?: unknown[];
  gatewayConnections?: null | GatewayConnectionView[];
  credentialRefs?: string[];
  @oneOf egressPolicy?: null | SandboxEgressPolicyView;
  @oneOf sandboxGroupId?: null | SandboxGroupId;
  region?: null | string;
  @oneOf lifecycle?: null | SandboxLifecyclePolicy;
  @oneOf debug?: null | DebugInfo;
  appUrl?: null | string;
  managementUrl?: null | string;

  @removed(Versions.v2026_09_01)
  tokens?: null | Record<SandboxExecutionTokenResponseView>;

  @oneOf agentIdentity?: null | SandboxAgentIdentityRefView;
  volumes?: SandboxVolumeView[];
  contentPackageDownloads?: SandboxContentPackageDownloadView[];
  vnetConnectionName?: null | string;

  @removed(Versions.v2026_09_01)
  customerVnetConnectionName?: null | string;

  systemVnetConnectionName?: null | string;
  identitySettings?: null | IdentitySetting[];
  outboundIpAddresses?: null | string[];
  containerStatuses?: null | ContainerStatusView[];
}

model SandboxResumeRequestView {
  @removed(Versions.v2026_09_01)
  @oneOf
  executionTokens?: null | SandboxExecutionTokensRequestView;
}

model SandboxSourceArtifactVersionView {
  /** ARM id: .../Microsoft.App/artifacts/{name}/versions/{version} */
  id: string;

  /** Group identity selector (ARM id, client id, or system). */
  auth: SandboxSourceAuthView;
}

model SandboxSourceAuthView {
  identity: string;
}

model SandboxSourceView {
  @oneOf diskImage?: null | SandboxSourceDiskImageView;
  @oneOf snapshot?: null | SandboxSourceSnapshotView;
  @oneOf pod?: null | SandboxSourcePodView;
  @oneOf artifactVersion?: null | SandboxSourceArtifactVersionView;
}

union SandboxState {
  "Running",
  "Stopped",
  "Idle",
  "Creating",
  "Stopping",
  "StopFailed",
}

/**
 * Companion document to SandboxState. Populated when a sandbox transitions to
 * SandboxState.Stopped; null on SandboxState.Running sandboxes
 * (and on legacy stopped documents written before this field existed).
 */
model SandboxStateDetails {
  /** Why the sandbox is stopped. */
  stoppedReason: StoppedReason;

  /** Wall-clock time the stop transition was recorded. */
  stoppedAt: utcDateTime;
}

union SandboxSuspendMode {
  "Memory",
  "Disk",
  "None",
  null,
}

// Preview-only contract declarations retained from the 2026-08-01-preview OpenAPI document.

@removed(Versions.v2026_09_01)
model BatchSandboxRequestView {
  @minValue(1)
  @maxValue(1000)
  count: Int32OrString;

  sandbox: SandboxRequestView;
}

@removed(Versions.v2026_09_01)
model BatchSandboxResponseView {
  totalRequested: Int32OrString;
  succeeded: Int32OrString;
  failed: Int32OrString;
  sandboxes: SandboxResponseView[];
  errors: string[];
}

@removed(Versions.v2026_09_01)
model SandboxExecutionTokenResponseView {
  @secret
  token: string;

  expiresAt: utcDateTime;
}

@removed(Versions.v2026_09_01)
model SandboxExecutionTokensRequestView {
  accounts?: null | string[];
}

@removed(Versions.v2026_09_01)
model SandboxGenerateTokenRequestView {
  user?: null | string;
}

@removed(Versions.v2026_09_01)
model SandboxGpuView {
  sku: string;
  quantity: string;
}
