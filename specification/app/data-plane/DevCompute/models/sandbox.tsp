namespace AzureDevCompute;

/** Sandbox response fields wire model. */
model SandboxFields {
  /** id value. */
  id: SandboxId;

  /** labels value. */
  labels?: Record<string>;

  /** vmmType value. */
  vmmType: VmmType;

  /** Entrypoint override for the sandbox container. */
  entrypoint?: string[] | null;

  /** Cmd override for the sandbox container. */
  cmd?: string[] | null;

  /** sourcesRef value. */
  sourcesRef: SandboxSource;

  /** resources value. */
  resources: SandboxResources;

  /** createdAt value. */
  createdAt?: utcDateTime | null;

  /** state value. */
  state?: null | SandboxState;

  /** stateDetails value. */
  stateDetails?: null | SandboxStateDetails;

  /** snapshotId value. */
  snapshotId?: null | SnapshotId;

  /** coldStorageSizeInMB value. */
  coldStorageSizeInMB?: null | MegaBytes;

  /** ports value. */
  ports?: SandboxPort[];

  /** List of connection IDs associated with this sandbox. */
  connections?: string[];

  /** AI Gateway connections associated with this sandbox (3P flow). */
  gatewayConnections?: GatewayConnection[] | null;

  /** Sandbox-group credential names associated with this sandbox. */
  credentialRefs?: string[];

  /** egressPolicy value. */
  egressPolicy?: null | SandboxEgressPolicy;

  /** sandboxGroupId value. */
  sandboxGroupId?: null | SandboxGroupId;

  /** The Azure region where this sandbox is running (extracted from cluster hostname). */
  region?: string | null;

  /** lifecycle value. */
  lifecycle?: null | SandboxLifecyclePolicy;

  /** debug value. */
  debug?: null | DebugInfo;

  /** The apps domain URL for sandboxes with type=app label. Only populated when the sandbox has the type=app label and AppsDnsSuffix is configured. */
  appUrl?: string | null;

  /** The base URL for data plane operations (exec, files, ports, etc.). Client SDKs should use this URL for all data plane calls. Currently points to the Global API, but may be redirected to cluster-direct URLs in the future. */
  managementUrl?: string | null;

  /** Sandbox execution tokens issued as part of the create or resume request, keyed by account. */
  tokens?: Record<SandboxExecutionTokenResponse> | null;

  /** agentIdentity value. */
  agentIdentity?: null | SandboxAgentIdentityRef;

  /** Volume mounts attached to this sandbox. */
  volumes?: SandboxVolume[];

  /** Content packages that were downloaded to this sandbox during creation. */
  contentPackageDownloads?: SandboxContentPackageDownload[];

  /** The name of the vnet connection used when creating this sandbox, if any. */
  vnetConnectionName?: string | null;

  /** Legacy alias for string? SandboxFields.VnetConnectionName. Emits the historical `customerVnetConnectionName` wire field so deployed SDKs and CLIs that parse it keep working. */
  customerVnetConnectionName?: string | null;

  /** The name of the system vnet connection used when creating this sandbox, if any. */
  systemVnetConnectionName?: string | null;

  /** Optional identity settings that control which managed identities from the group are available to this sandbox and in which lifecycle phases. */
  identitySettings?: IdentitySetting[] | null;

  /** Static outbound (egress) IP addresses for the cluster hosting this sandbox. Populated when live cluster data is available (sandbox is running). Null when the sandbox is stopped or cluster data is unavailable. Customers can use these to configure IP-based allowlists on downstream resources. */
  outboundIpAddresses?: string[] | null;

  /** Live per-container runtime statuses for pod sandboxes. Omitted when unavailable. */
  containerStatuses?: ContainerStatus[] | null;
}

/** AbsoluteDirectoryPath wire value. */
scalar AbsoluteDirectoryPath extends string;

/** AbsoluteFilePath wire value. */
scalar AbsoluteFilePath extends string;

/** AutoDeleteTrigger values. */
union AutoDeleteTrigger {
  /** Serialized AutoDeleteTrigger value. */
  AfterSuspend: "AfterSuspend",

  /** Serialized AutoDeleteTrigger value. */
  AfterCreation: "AfterCreation",
}

/** Represents a base64-encoded value. */
scalar Base64 extends string;

/** Probe configuration for checking a container's startup, liveness, or readiness state. */
model ContainerProbe {
  /** httpGet value. */
  httpGet?: null | ProbeHttpGetAction;

  /** exec value. */
  exec?: null | ProbeExecAction;

  /** tcpSocket value. */
  tcpSocket?: null | ProbeTcpSocketAction;

  /** initialDelaySeconds value. */
  initialDelaySeconds?: int32 | string | null;

  /** periodSeconds value. */
  periodSeconds?: int32 | string | null;

  /** timeoutSeconds value. */
  timeoutSeconds?: int32 | string | null;

  /** failureThreshold value. */
  failureThreshold?: int32 | string | null;

  /** successThreshold value. */
  successThreshold?: int32 | string | null;

  /** terminationGracePeriodSeconds value. */
  terminationGracePeriodSeconds?: int32 | string | null;
}

/** ContainerProbeResult values. */
union ContainerProbeResult {
  /** Serialized ContainerProbeResult value. */
  Success: "Success",

  /** Serialized ContainerProbeResult value. */
  Failure: "Failure",

  /** Serialized ContainerProbeResult value. */
  Unknown: "Unknown",
}

/** Runtime status for a configured container probe. */
model ContainerProbeStatus {
  /** lastResult value. */
  lastResult?: null | ContainerProbeResult;

  /** consecutiveFailures value. */
  consecutiveFailures: int32;

  /** consecutiveSuccesses value. */
  consecutiveSuccesses: int32;

  /** lastCheckedAt value. */
  lastCheckedAt?: utcDateTime | null;

  /** lastTransitionAt value. */
  lastTransitionAt?: utcDateTime | null;

  /** message value. */
  message?: string | null;
}

/** ContainerRestartPolicy values. */
union ContainerRestartPolicy {
  /** Serialized ContainerRestartPolicy value. */
  Always: "Always",

  /** Serialized ContainerRestartPolicy value. */
  OnFailure: "OnFailure",

  /** Serialized ContainerRestartPolicy value. */
  Never: "Never",
}

/** Customer-facing container runtime state. */
union ContainerRuntimeState {
  /** Serialized ContainerRuntimeState value. */
  Unknown: "Unknown",

  /** Serialized ContainerRuntimeState value. */
  Waiting: "Waiting",

  /** Serialized ContainerRuntimeState value. */
  Running: "Running",

  /** Serialized ContainerRuntimeState value. */
  Terminated: "Terminated",
}

/** Container-level security context — overrides pod-level settings where applicable. Follows Kubernetes container securityContext semantics. */
model ContainerSecurityContext {
  /** runAsUser value. */
  runAsUser?: int32 | string | null;

  /** runAsGroup value. */
  runAsGroup?: int32 | string | null;

  /** runAsNonRoot value. */
  runAsNonRoot?: boolean | null;

  /** privileged value. */
  privileged?: boolean = false;

  /** capabilities value. */
  capabilities?: null | LinuxCapabilities;

  /** allowPrivilegeEscalation value. */
  allowPrivilegeEscalation?: boolean = true;

  /** readOnlyRootFilesystem value. */
  readOnlyRootFilesystem?: boolean = false;

  /** seccompProfile value. */
  seccompProfile?: null | SeccompProfile;
}

/** ContainerStatusReason values. */
union ContainerStatusReason {
  /** Serialized ContainerStatusReason value. */
  Completed: "Completed",

  /** Serialized ContainerStatusReason value. */
  Error: "Error",

  /** Serialized ContainerStatusReason value. */
  CrashLoopBackOff: "CrashLoopBackOff",

  /** Serialized ContainerStatusReason value. */
  RootfsResetPending: "RootfsResetPending",

  /** Serialized ContainerStatusReason value. */
  RootfsResetFailed: "RootfsResetFailed",
}

/** Runtime status for one pod container. */
model ContainerStatus {
  /** name value. */
  name: PodContainerName;

  /** state value. */
  state: ContainerRuntimeState;

  /** ready value. */
  ready: boolean;

  /** started value. */
  started: boolean;

  /** restartCount value. */
  restartCount: int32;

  /** reason value. */
  reason?: null | ContainerStatusReason;

  /** message value. */
  message?: string | null;

  /** lastExitCode value. */
  lastExitCode?: int32 | string | null;

  /** lastStartedAt value. */
  lastStartedAt?: utcDateTime | null;

  /** lastFinishedAt value. */
  lastFinishedAt?: utcDateTime | null;

  /** probes value. */
  probes?: Record<ContainerProbeStatus> | null;
}

/** Specifies how a content package should be delivered to the container. */
union ContentPackageAction {
  /** Serialized ContentPackageAction value. */
  Download: "Download",

  /** Serialized ContentPackageAction value. */
  Mount: "Mount",
}

/** ContentPackageId wire value. */
scalar ContentPackageId extends string;

/** Kubernetes-style CPU resource quantity string (e.g. "500m", "2", "0.5"). */
scalar CpuQuantity extends string;

/** Debug information that can be included in API responses. */
model DebugInfo {
  /** The OTEL trace ID for correlating logs and requests across services. */
  traceId?: string | null;

  /** Performance spans for waterfall visualization. Flat list with parent-child relationships via ParentId. */
  traces?: PerfTrace[] | null;
}

/** DiskImageId wire value. */
scalar DiskImageId extends string;

/** Types of actions that an egress policy rule can take. */
union EgressPolicyActionType {
  /** Serialized EgressPolicyActionType value. */
  Allow: "Allow",

  /** Serialized EgressPolicyActionType value. */
  Deny: "Deny",

  /** Serialized EgressPolicyActionType value. */
  Transform: "Transform",

  /** Serialized EgressPolicyActionType value. */
  Rewrite: "Rewrite",
}

/** EgressPolicyEnforcementMode values. */
union EgressPolicyEnforcementMode {
  /** Serialized EgressPolicyEnforcementMode value. */
  Enforced: "Enforced",

  /** Serialized EgressPolicyEnforcementMode value. */
  Audit: "Audit",
}

/** Types of header transformation operations. */
union EgressPolicyHeaderOperation {
  /** Serialized EgressPolicyHeaderOperation value. */
  Set: "Set",

  /** Serialized EgressPolicyHeaderOperation value. */
  Insert: "Insert",

  /** Serialized EgressPolicyHeaderOperation value. */
  Remove: "Remove",
}

/** Describes a header transformation to apply to matching requests. */
model EgressPolicyHeaderTransform {
  /** operation value. */
  operation: EgressPolicyHeaderOperation;

  /** name value. */
  name: string;

  /** value value. */
  value?: string | null;

  /** valueRef value. */
  valueRef?: null | EgressPolicyValueRef;
}

/** What the egress proxy should do when a webhook invocation fails (timeout, non-2xx, invalid payload, SSRF-rejected URL, etc.). */
union EgressPolicyHookFailBehavior {
  /** Serialized EgressPolicyHookFailBehavior value. */
  Deny: "Deny",

  /** Serialized EgressPolicyHookFailBehavior value. */
  Allow: "Allow",
}

/** Configures a webhook called at request time for rules whose static decision cannot be expressed declaratively. When a rule's EgressPolicyHookRef? EgressPolicyRule.HookRef is set, the egress proxy POSTs a request-context payload to string EgressPolicyHookRef.Endpoint and applies the returned decision (Allow / Deny / Transform / Rewrite) in place of the rule's static Action.  EgressRuleRoutingMode EgressPolicyHookRef.RoutingMode controls how the egress proxy reaches the webhook endpoint itself: EgressRuleRoutingMode.Vnet binds the outbound socket to the sandbox's customer VNET IP (so the hook host can be a private service reachable only from inside the VNET), EgressRuleRoutingMode.Platform forces the node's platform egress (bypassing Swift SNAT), and EgressRuleRoutingMode.Default uses the sandbox-level routing. The webhook response itself can also carry a `routingMode` field that overrides routing for the downstream upstream call when the decision is Rewrite. */
model EgressPolicyHookRef {
  /** endpoint value. */
  endpoint: string;

  /** failBehavior value. */
  failBehavior?: EgressPolicyHookFailBehavior;

  /** requestHeaders value. */
  requestHeaders?: string[] | null;

  /** authHeaders value. */
  authHeaders?: EgressPolicyHeaderTransform[] | null;

  /** timeoutMs value. */
  timeoutMs?: int32 | string | null;

  /** routingMode value. */
  routingMode?: EgressRuleRoutingMode;
}

/** References a managed identity token to be fetched and injected as a header value. EgressPolicyManagedIdentityType? EgressPolicyManagedIdentityRef.Type must be set to specify which identity to use. */
model EgressPolicyManagedIdentityRef {
  /** resource value. */
  resource: string;

  /** format value. */
  format?: string | null;

  /** type value. */
  type?: null | EgressPolicyManagedIdentityType;

  /** identityResourceId value. */
  identityResourceId?: string | null;
}

/** EgressPolicyManagedIdentityType values. */
union EgressPolicyManagedIdentityType {
  /** Serialized EgressPolicyManagedIdentityType value. */
  SystemAssigned: "SystemAssigned",

  /** Serialized EgressPolicyManagedIdentityType value. */
  UserAssigned: "UserAssigned",
}

/** EgressPolicyMatchScheme values. */
union EgressPolicyMatchScheme {
  /** Serialized EgressPolicyMatchScheme value. */
  http: "http",

  /** Serialized EgressPolicyMatchScheme value. */
  https: "https",

  /** Serialized EgressPolicyMatchScheme value. */
  any: "any",
}

/** A single egress policy rule. Rules are evaluated in order; first match wins. A rule has either a static EgressPolicyRuleAction? EgressPolicyRule.Action or a dynamic EgressPolicyHookRef? EgressPolicyRule.HookRef, never both. When EgressPolicyHookRef? EgressPolicyRule.HookRef is set, the proxy calls the configured webhook at request time and applies the returned decision in place of EgressPolicyRuleAction? EgressPolicyRule.Action. */
model EgressPolicyRule {
  /** name value. */
  name: string | null;

  /** match value. */
  match: EgressPolicyRuleMatch;

  /** action value. */
  action?: null | EgressPolicyRuleAction;

  /** proxyActions value. */
  proxyActions?: string[] | null;

  /** source value. */
  source?: string | null;

  /** hookRef value. */
  hookRef?: null | EgressPolicyHookRef;
}

/** The action to take when a rule matches. For Rewrite actions, Scheme/Host/Path specify the destination to rewrite the request to, and EgressRuleRoutingMode EgressPolicyRuleAction.RoutingMode optionally overrides the sandbox-level egress routing for this rule. */
model EgressPolicyRuleAction {
  /** type value. */
  type: EgressPolicyActionType;

  /** headers value. */
  headers?: EgressPolicyHeaderTransform[] | null;

  /** scheme value. */
  scheme?: string | null;

  /** host value. */
  host?: string | null;

  /** path value. */
  path?: string | null;

  /** routingMode value. */
  routingMode?: EgressRuleRoutingMode;
}

/** Request matching criteria for an egress policy rule. All specified conditions must match (AND logic). EgressPolicyMatchScheme? EgressPolicyRuleMatch.Scheme is nullable; null means the author did not specify a scheme and the effective default is resolved per rule polarity at evaluation time. A static Deny defaults to EgressPolicyMatchScheme.Any so a block is not silently scoped to HTTPS and bypassed over HTTP. Every other rule — including positive rules (Allow / Transform / Rewrite) and dynamic EgressPolicyHookRef? EgressPolicyRule.HookRef rules (whose outcome can be Allow/Transform/Rewrite or fail open) — defaults to EgressPolicyMatchScheme.Https: on plaintext HTTP there is no SNI, so matching uses the sandbox-controlled Host header with no certificate validation, and a positive or hook match there would let a sandbox reach a non-allowlisted IP while spoofing an allowlisted Host. Set EgressPolicyMatchScheme.Any explicitly to match both schemes, or EgressPolicyMatchScheme.Http / EgressPolicyMatchScheme.Https to pin a single scheme. For IP-based match hosts, scheme matching is ignored (no TLS certificate validation applies to IPs anyway).bool? EgressPolicyRuleMatch.NormalizePath controls whether the request path is decoded and normalized (encoded-slash decode, slash merging, and ./.. dot-segment removal) before it is matched against string? EgressPolicyRuleMatch.Path. It defaults to enabled (null is treated as true) to prevent path-confusion bypasses where an encoded path such as /allowed%2F.. matches an allow rule but the upstream server resolves it to a different path. Set to false only for upstreams that require the raw, un-normalized path. */
model EgressPolicyRuleMatch {
  /** host value. */
  host: string;

  /** path value. */
  path?: string | null;

  /** methods value. */
  methods?: string[] | null;

  /** scheme value. */
  scheme?: null | EgressPolicyMatchScheme;

  /** normalizePath value. */
  normalizePath?: boolean | null;
}

/** References a secret stored via the Secrets API for header value injection. */
model EgressPolicySecretRef {
  /** secretId value. */
  secretId: string;

  /** secretKey value. */
  secretKey?: string | null;

  /** format value. */
  format?: string | null;
}

/** A dynamic value reference for header transforms. Exactly one of the ref fields should be set. */
model EgressPolicyValueRef {
  /** secretRef value. */
  secretRef?: null | EgressPolicySecretRef;

  /** managedIdentityRef value. */
  managedIdentityRef?: null | EgressPolicyManagedIdentityRef;
}

/** Per-rule override of how the egress proxy creates the upstream socket. Today only honored on EgressPolicyActionType.Rewrite rules. */
union EgressRuleRoutingMode {
  /** Serialized EgressRuleRoutingMode value. */
  Default: "Default",

  /** Serialized EgressRuleRoutingMode value. */
  Vnet: "Vnet",

  /** Serialized EgressRuleRoutingMode value. */
  Platform: "Platform",
}

/** FsGroupChangePolicy values. */
union FsGroupChangePolicy {
  /** Serialized FsGroupChangePolicy value. */
  OnRootMismatch: "OnRootMismatch",

  /** Serialized FsGroupChangePolicy value. */
  Always: "Always",

  /** Serialized FsGroupChangePolicy value. */
  None: "None",
}

/** The type of managed identity to use for a gateway connection. */
union GatewayConnectionAuthType {
  /** Serialized GatewayConnectionAuthType value. */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  /** Serialized GatewayConnectionAuthType value. */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/** Authentication configuration specifying which managed identity to use for a connection at runtime. */
model GatewayConnectionAuth {
  /** The type of managed identity to use: "SystemAssignedManagedIdentity" or "UserAssignedManagedIdentity". */
  type: GatewayConnectionAuthType;

  /** ARM resource ID of the user-assigned managed identity. Required when GatewayConnectionAuthType GatewayConnectionAuth.Type is GatewayConnectionAuthType.UserAssignedManagedIdentity, omitted when GatewayConnectionAuthType.SystemAssignedManagedIdentity. */
  identityResourceId?: string | null;
}

/** Represents an AI Gateway connection to associate with a sandbox (3P flow). On sandbox requests: only string GatewayConnection.ResourceId is required; full details are resolved from the parent sandbox group. On sandbox responses: legacy sandboxes include all fields; new sandboxes include only string GatewayConnection.ResourceId. */
model GatewayConnection {
  /** ARM resource ID of the AI Gateway MCP server config or connection. Format: /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Web/aigateways/{gw}/mcpServerConfigs/{config} or: /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Web/connectorGateways/{gw}/connections/{conn} */
  resourceId: string;

  /** Optional user-friendly name for this connection. Used as the key in mcp-config.json and connections.json. When not provided, derived from the last segment of string GatewayConnection.ResourceId. */
  name?: string | null;

  /** MCP server endpoint URL for invoking the connection (agent discovery). Resolved from the parent sandbox group; not required on sandbox requests. */
  mcpRuntimeUrl?: string | null;

  /** Direct API Hub connection endpoint URL for app invocation (non-MCP). Resolved from the parent sandbox group; not required on sandbox requests. */
  connectionRuntimeUrl?: string | null;

  /** authentication value. */
  authentication?: null | GatewayConnectionAuth;
}

/** Request to add a port to a sandbox. */
model AddPortRequest {
  /** Optional name for the port (must be unique per sandbox if provided). */
  name?: string | null;

  /** The port number to expose (required, must be unique per sandbox). */
  port: SandboxPortNumber;

  /** auth value. */
  auth?: null | PortAuthConfig;

  /** activationMode value. */
  activationMode?: null | PortActivationMode;

  /** The HTTP protocol version to use when forwarding requests to this port. Defaults to Http (HTTP/1.1). */
  protocol?: PortProtocol;

  /** ipAccessControl value. */
  ipAccessControl?: null | IpAccessControl;

  /** cors value. */
  cors?: null | PortCorsConfig;
}

/** Per-container resource configuration. CPU and Memory set cgroup limits inside the VM. Disk controls writable layer sizing. */
model ContainerResources {
  /** Kubernetes-style CPU resource quantity string (e.g. "500m", "2", "0.5"). */
  cpu?: CpuQuantity;

  /** Kubernetes-style memory resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
  memory?: MemoryQuantity;

  /** Kubernetes-style storage/disk resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
  disk?: StorageQuantity;
}

/** Per-container specification within a pod source. */
model ContainerSpec {
  /** name value. */
  name: PodContainerName;

  /** diskImage value. */
  diskImage: SandboxSourceDiskImage;

  /** command value. */
  command?: string[] | null;

  /** args value. */
  args?: string[] | null;

  /** env value. */
  env?: Record<string> | null;

  /** resources value. */
  resources?: null | ContainerResources;

  /** volumeMounts value. */
  volumeMounts?: ContainerVolumeMount[] | null;

  /** contentPackageDownloads value. */
  contentPackageDownloads?: SandboxContentPackageDownload[] | null;

  /** securityContext value. */
  securityContext?: null | ContainerSecurityContext;

  /** startupProbe value. */
  startupProbe?: null | ContainerProbe;

  /** livenessProbe value. */
  livenessProbe?: null | ContainerProbe;

  /** readinessProbe value. */
  readinessProbe?: null | ContainerProbe;
}

/** Per-container volume mount specifying which volume to mount and where. */
model ContainerVolumeMount {
  /** name value. */
  name: VolumeName;

  /** mountPath value. */
  mountPath: AbsoluteDirectoryPath;

  /** readOnly value. */
  readOnly?: boolean = false;
}

/** EgressHostRule wire model. */
model EgressHostRule {
  /** pattern value. */
  pattern: string;

  /** action value. */
  action?: null | EgressPolicyAction;
}

/** EgressPolicyAction values. */
union EgressPolicyAction {
  /** Serialized EgressPolicyAction value. */
  Allow: "Allow",

  /** Serialized EgressPolicyAction value. */
  Deny: "Deny",
}

/** The HTTP section of a sandbox egress policy. This is the canonical way to configure HTTP egress and is a sibling to TdsEgressSection? SandboxEgressPolicy.Tds and TransportEgressSection? SandboxEgressPolicy.TransportRules. It carries the same fields the policy view historically exposed at the top level. */
model HttpEgressSection {
  /** The default action applied when no rule matches. Required: a request that sends an `http` section must specify a default action. */
  defaultAction: EgressPolicyAction;

  /** hostRules value. */
  hostRules?: EgressHostRule[];

  /** Rich egress policy rules supporting Allow, Deny, and Transform actions with header mutations. Rules are evaluated after connector-generated rules, in order (first match wins). */
  rules?: EgressPolicyRule[] | null;

  /** Controls the scope of TLS inspection for the egress proxy. Defaults to Full. */
  trafficInspection?: TrafficInspection;

  /** enforcementMode value. */
  enforcementMode?: EgressPolicyEnforcementMode;
}

/** A single IP access control rule. */
model IpAccessControlRule {
  /** name value. */
  name: string;

  /** action value. */
  action: IpAccessControlAction;

  /** priority value. */
  @minValue(0)
  @maxValue(1000)
  priority: int32;

  /** sourceCidrs value. */
  sourceCidrs: string[];
}

/** IP access control configuration for a port. Rules are evaluated in priority order; first match wins. */
model IpAccessControl {
  /** defaultAction value. */
  defaultAction: IpAccessControlAction;

  /** rules value. */
  rules?: IpAccessControlRule[];
}

/** Request body for `PATCH /sandboxes/{id}`. Uses JSON Merge Patch semantics for labels: keys with non-null values are set, keys with null values are removed, absent keys are unchanged. */
model PatchSandboxRequest {
  /** labels value. */
  labels?: Record<string | null> | null;
}

/** Pod-level content package declaration. Declares a content package that the pod uses. Per-container downloads reference content packages by ContentPackageId PodContentPackage.ContentPackageId. */
model PodContentPackage {
  /** contentPackageId value. */
  contentPackageId: ContentPackageId;
}

/** Pod-level volume declaration. Declares a named volume source that can be referenced by containers via ContainerVolumeMount. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union PodVolume {
  /** AzureBlob variant. */
  AzureBlob: AzureBlobPodVolume,

  /** AzureBlobByo variant. */
  AzureBlobByo: AzureBlobByoPodVolume,

  /** Local variant. */
  Local: LocalPodVolume,

  /** DataDisk variant. */
  DataDisk: DataDiskPodVolume,
}

/** Bring-your-own (BYO) Azure Blob container volume source, backed by blobfuse2. */
model AzureBlobByoPodVolume {
  /** kind value. */
  kind?: "AzureBlobByo";

  /** fileCacheSizeLimit value. */
  fileCacheSizeLimit: StorageQuantity;

  /** readOnly value. */
  readOnly?: boolean = false;

  /** name value. */
  name: VolumeName;
}

/** Azure Blob Storage volume source, backed by blobfuse2. */
model AzureBlobPodVolume {
  /** kind value. */
  kind?: "AzureBlob";

  /** fileCacheSizeLimit value. */
  fileCacheSizeLimit: StorageQuantity;

  /** readOnly value. */
  readOnly?: boolean = false;

  /** name value. */
  name: VolumeName;
}

/** Data disk volume source backed by a persistent ext4 block device in cluster storage. */
model DataDiskPodVolume {
  /** kind value. */
  kind?: "DataDisk";

  /** name value. */
  name: VolumeName;
}

/** Local volume source backed by rootfs space. */
model LocalPodVolume {
  /** kind value. */
  kind?: "Local";

  /** size value. */
  size: StorageQuantity;

  /** name value. */
  name: VolumeName;
}

/** Entra ID-specific auth configuration for a port. */
model PortAuthConfigEntraId {
  /** Whether Entra ID authentication is enabled. */
  enabled?: boolean;

  /** List of allowed email addresses (exact match). Empty means any authenticated Entra ID user can access. Combined with emailSuffixes, objectIds, and tenantIds, maximum 100 entries allowed. */
  emails?: string[];

  /** List of allowed email domain suffixes (e.g., "@microsoft.com"). Matches any email ending with the suffix. Combined with emails, objectIds, and tenantIds, maximum 100 entries allowed. */
  emailSuffixes?: string[];

  /** List of allowed Entra ID object IDs (user or group GUIDs). Combined with emails, emailSuffixes, and tenantIds, maximum 100 entries allowed. */
  objectIds?: string[];

  /** List of allowed Entra ID tenant IDs (directory GUIDs). Matches any user from the specified tenant. Combined with emails, emailSuffixes, and objectIds, maximum 100 entries allowed. */
  tenantIds?: string[];
}

/** GitHub-specific auth configuration for a port. Permits users whose verified email ends with @microsoft.com or @github.com. */
model PortAuthConfigGithub {
  /** Whether GitHub authentication is enabled. */
  enabled?: boolean;

  /** List of allowed email addresses (exact match). Empty means any @microsoft.com or @github.com user can access. Combined with emailSuffixes, usernames, and usernameSuffixes, maximum 100 entries allowed. */
  emails?: string[];

  /** List of allowed email domain suffixes (e.g., "@microsoft.com"). Matches any email ending with the suffix. Combined with emails, usernames, and usernameSuffixes, maximum 100 entries allowed. */
  emailSuffixes?: string[];

  /** List of allowed GitHub usernames (exact match). Empty means any authenticated GitHub user can access. Combined with emails, emailSuffixes, and usernameSuffixes, maximum 100 entries allowed. */
  usernames?: string[];

  /** List of allowed username suffixes (e.g., "_microsoft" for EMU accounts). Matches any username ending with the suffix. Combined with emails, emailSuffixes, and usernames, maximum 100 entries allowed. */
  usernameSuffixes?: string[];
}

/** Auth configuration for a port. Each provider can be independently enabled/disabled without removing configuration. */
model PortAuthConfig {
  /** anonymous value. */
  anonymous?: boolean;

  /** github value. */
  github?: null | PortAuthConfigGithub;

  /** entraId value. */
  entraId?: null | PortAuthConfigEntraId;
}

/** CORS configuration for a sandbox port. */
model PortCorsConfig {
  /** allowOrigins value. */
  allowOrigins?: string[];

  /** allowMethods value. */
  allowMethods?: string[];

  /** allowHeaders value. */
  allowHeaders?: string[];

  /** allowCredentials value. */
  allowCredentials?: boolean;

  /** maxAge value. */
  maxAge?: int32 | string | null;
}

/** Represents a content package to be downloaded onto a sandbox during creation. */
model SandboxContentPackageDownload {
  /** The content package ID to download. */
  contentPackageId: ContentPackageId;

  /** The target path in the sandbox where the content package will be downloaded. Must be an absolute path. Parent directories will be created if they don't exist. */
  targetPath: AbsoluteFilePath;

  /** How the content package should be delivered: Download (default) or Mount. Mount presents the package contents as a read-only FUSE filesystem at the target path. Currently only supported for zip content packages. */
  action?: ContentPackageAction;
}

/** Sandbox egress policy wire model. */
model SandboxEgressPolicy {
  /** http value. */
  http?: null | HttpEgressSection;

  /** defaultAction value. */
  defaultAction?: null | EgressPolicyAction;

  /** hostRules value. */
  hostRules?: EgressHostRule[];

  /** Rich egress policy rules supporting Allow, Deny, and Transform actions with header mutations. Rules are evaluated after connector-generated rules, in order (first match wins). */
  rules?: EgressPolicyRule[] | null;

  /** tds value. */
  tds?: null | TdsEgressSection;

  /** transportRules value. */
  transportRules?: null | TransportEgressSection;

  /** Controls the scope of TLS inspection for the egress proxy. Defaults to Full (all HTTPS is MITM'd and non-HTTP TCP/UDP is blocked). Legacy is no longer accepted on sandbox creation (issue #6420) but remains valid as a stored value for sandboxes created before the deprecation. */
  trafficInspection?: TrafficInspection;

  /** enforcementMode value. */
  enforcementMode?: EgressPolicyEnforcementMode;

  /** validationWarnings value. */
  validationWarnings?: ValidationWarning[] | null;
}

/** Sandbox execution token response wire model. */
model SandboxExecutionTokenResponse {
  /** token value. */
  token: string;

  /** expiresAt value. */
  expiresAt: utcDateTime;
}

/** Sandbox execution tokens request wire model. */
model SandboxExecutionTokensRequest {
  /** accounts value. */
  accounts?: string[] | null;
}

/** Sandbox GPU wire model. */
model SandboxGpu {
  /** sku value. */
  sku: string;

  /** quantity value. */
  quantity: string;
}

/** Represents a port exposed on a sandbox. */
model SandboxPort {
  /** Optional name for the port (must be unique per sandbox if provided). */
  name?: string | null;

  /** The port number exposed on the sandbox (required, must be unique per sandbox). */
  port: SandboxPortNumber;

  /** The URL to access the port on the sandbox (required). */
  url: url;

  /** auth value. */
  auth?: null | PortAuthConfig;

  /** activationMode value. */
  activationMode?: null | PortActivationMode;

  /** The HTTP protocol version to use when forwarding requests to this port. Defaults to Http (HTTP/1.1). */
  protocol?: PortProtocol;

  /** ipAccessControl value. */
  ipAccessControl?: null | IpAccessControl;

  /** cors value. */
  cors?: null | PortCorsConfig;
}

/** Preset-specific properties for sandbox creation. These properties configure optional features for specific preset types. */
model SandboxPresetProperties {
  /** Whether to enable the WorkIQ (m365-mihshah) connection for the GitHubCopilot preset. When true, the WorkIQ managed API must be available in the region. */
  isWorkIqConnectionEnabled?: boolean;
}

/** Sandbox request wire model. */
model SandboxRequest {
  /** labels value. */
  labels?: Record<string>;

  /** vmmType value. */
  vmmType?: null | VmmType;

  /** entrypoint value. */
  entrypoint?: string[] | null;

  /** cmd value. */
  cmd?: string[] | null;

  /** Optional environment variables to set in the sandbox container. These variables will override any environment variables with the same key from the image. Cannot be specified when creating from a snapshot. The combined UTF-8 size of the environment entries in KEY=VALUE format must not exceed 1.75 MiB. Entries above the Linux 128 KiB per-entry limit are logged for compatibility monitoring. */
  environment?: Record<string> | null;

  /** sourcesRef value. */
  sourcesRef?: null | SandboxSource;

  /** resources value. */
  resources?: null | SandboxResources;

  /** Optional list of connection IDs to associate with the sandbox (1P flow). */
  connections?: string[] | null;

  /** Optional list of AI Gateway connections for 3P sandbox creation. Each entry contains the MCP server config resource ID, MCP runtime URL, and identity configuration. Mutually exclusive with IReadOnlyList&lt;ConnectionId&gt;? SandboxRequest.Connections — do not provide both. Maximum of 10 entries. */
  gatewayConnections?: GatewayConnection[] | null;

  /** Optional list of sandbox-group credential names to associate with the sandbox. Each name must reference a credential configured on the parent sandbox group. */
  credentialRefs?: string[] | null;

  /** Optional list of ports to expose on the sandbox during creation. */
  ports?: AddPortRequest[] | null;

  /** egressPolicy value. */
  egressPolicy?: null | SandboxEgressPolicy;

  /** Optional reference to a named egress policy. When specified, the named policy's rules are resolved and merged with any inline rules (inline rules take precedence). The named policy must exist in the sandbox's sandbox group. */
  egressPolicyId?: string | null;

  /** sandboxGroupId value. */
  sandboxGroupId?: null | SandboxGroupId;

  /** presetSandboxType value. */
  presetSandboxType?: null | PresetSandboxType;

  /** Optional Anthropic API key for Claude preset. Only used when presetSandboxType is Claude. */
  anthropicApiKey?: string | null;

  /** presetProperties value. */
  presetProperties?: null | SandboxPresetProperties;

  /** lifecycle value. */
  lifecycle?: null | SandboxLifecyclePolicy;

  /** agentIdentity value. */
  agentIdentity?: null | SandboxAgentIdentityRef;

  /** Optional identity settings that control which managed identities from the group are available to this sandbox and in which lifecycle phases. When null or empty, the default delegation behavior applies (delegated-only when any delegated identity exists). */
  identitySettings?: IdentitySetting[] | null;

  /** telemetryConfig value. */
  telemetryConfig?: null | TelemetryConfig;

  /** Optional list of volumes to mount in the sandbox. When SandboxSource? SandboxRequest.SourcesRef.Snapshot is set, the listed volumes are attached after the sandbox is restored from the snapshot — semantically equivalent to restoring the sandbox first and then calling the dynamic add-volume-mount API. In that mode the volumes must all be data disks, the snapshot must be non-pod, and the snapshot must not already have its own attached volumes; cluster placement is constrained to a cluster that already holds the referenced data disks (cross-cluster download is not supported). Those rules are enforced downstream after the snapshot/volume Cosmos lookups. */
  volumes?: SandboxVolume[] | null;

  /** projectId value. */
  projectId?: null | ProjectId;

  /** Optional list of content packages to download onto the sandbox during creation. Each entry specifies a content package ID and target path where it will be downloaded. */
  contentPackageDownloads?: SandboxContentPackageDownload[] | null;

  /** Optional vnet connection name to use for VNET injection. When specified, the sandbox traffic will be routed through the VNET identified by this connection. Requires the sandbox to be created within an ARM-managed sandbox group that has the named vnet connection. */
  vnetConnectionName?: string | null;

  /** Legacy alias for string? SandboxRequest.VnetConnectionName. Accepts and emits the historical `customerVnetConnectionName` wire field so deployed SDKs and CLIs keep working. Prefer string? SandboxRequest.VnetConnectionName for new callers. */
  customerVnetConnectionName?: string | null;

  /** Optional system vnet connection name for system-managed VNET injection. Works identically to string? SandboxRequest.VnetConnectionName but references a system VNet connection. */
  systemVnetConnectionName?: string | null;

  /** executionTokens value. */
  executionTokens?: null | SandboxExecutionTokensRequest;

  /** Indicates this sandbox is created within a sandbox group that has resource delegations. Resolved from the sandbox group at the controller level and forwarded to the cluster so the Identity Proxy can suppress non-delegated identities even when no delegated identities exist yet. */
  isDelegationBackingResource?: boolean;
}

/** SandboxResources wire model. */
model SandboxResources {
  /** cpu value. */
  cpu: CpuQuantity;

  /** memory value. */
  memory: MemoryQuantity;

  /** disk value. */
  disk?: null | StorageQuantity;

  /** gpu value. */
  gpu?: null | SandboxGpu;
}

/** Sandbox source disk image wire model. */
model SandboxSourceDiskImage {
  /** id value. */
  id?: null | DiskImageId;

  /** Disk image name for public disk images (e.g., "nginx", "python3.12"). Mutually exclusive with Id. */
  name?: string | null;

  /** Indicates whether this references a public disk image. Must be true when using Name, must be false when using Id. */
  isPublic?: boolean;
}

/** Pod source for sandbox creation. */
model SandboxSourcePod {
  /** containers value. */
  containers: ContainerSpec[];

  /** volumes value. */
  volumes?: PodVolume[] | null;

  /** contentPackages value. */
  contentPackages?: PodContentPackage[] | null;

  /** securityContext value. */
  securityContext?: null | PodSecurityContext;

  /** restartPolicy value. */
  restartPolicy?: null | ContainerRestartPolicy;
}

/** Sandbox source snapshot wire model. */
model SandboxSourceSnapshot {
  /** id value. */
  id: SnapshotId;
}

/** SandboxSource wire model. */
model SandboxSource {
  /** diskImage value. */
  diskImage?: null | SandboxSourceDiskImage;

  /** snapshot value. */
  snapshot?: null | SandboxSourceSnapshot;

  /** pod value. */
  pod?: null | SandboxSourcePod;
}

/** Volume configuration for a sandbox. */
model SandboxVolume {
  /** volumeName value. */
  volumeName: VolumeName;

  /** mountpoint value. */
  mountpoint: AbsoluteDirectoryPath;

  /** readOnly value. */
  readOnly?: boolean = false;
}

/** ValidationWarning wire model. */
model ValidationWarning {
  /** code value. */
  code: string;

  /** message value. */
  message: string;
}

/** Per-identity availability setting on a sandbox. Allows explicit control over which identities from the group are served to the sandbox. */
model IdentitySetting {
  /** The identity reference — ARM resource ID for user-assigned, "system" for system-assigned, or a client ID. */
  identity: string;

  /** Lifecycle phase gating for this identity. */
  lifecycle?: IdentitySettingLifecycle;
}

/** Controls which identity lifecycle phases a specific identity is available in. */
union IdentitySettingLifecycle {
  /** Serialized IdentitySettingLifecycle value. */
  None: "None",

  /** Serialized IdentitySettingLifecycle value. */
  Main: "Main",

  /** Serialized IdentitySettingLifecycle value. */
  All: "All",
}

/** IpAccessControlAction values. */
union IpAccessControlAction {
  /** Serialized IpAccessControlAction value. */
  Allow: "Allow",

  /** Serialized IpAccessControlAction value. */
  Deny: "Deny",
}

/** Linux capabilities to add or drop from the container's default capability set. */
model LinuxCapabilities {
  /** add value. */
  add?: string[] | null;

  /** drop value. */
  drop?: string[] | null;
}

/** Defines a single column in a custom log output schema. Polymorphic on `kind` discriminator: `"Value"` or `"Ref"`. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union LogColumnDef {
  /** Value variant. */
  Value: LogColumnDefValueLogColumnDef,

  /** Ref variant. */
  Ref: LogColumnDefRefLogColumnDef,
}

/** A column whose value is resolved from a well-known ADC attribute at runtime. */
model LogColumnDefRefLogColumnDef {
  /** kind value. */
  kind?: "Ref";

  /** The ADC attribute to resolve. */
  refName: LogColumnRef;
}

/** A column whose value is a literal string provided by the partner. */
model LogColumnDefValueLogColumnDef {
  /** kind value. */
  kind?: "Value";

  /** The static value injected into every log record. */
  value: string;
}

/** Well-known ADC attributes that can be referenced by custom columns. */
union LogColumnRef {
  /** Serialized LogColumnRef value. */
  LogContent: "LogContent",

  /** Serialized LogColumnRef value. */
  LogStream: "LogStream",

  /** Serialized LogColumnRef value. */
  SandboxId: "SandboxId",

  /** Serialized LogColumnRef value. */
  Region: "Region",

  /** Serialized LogColumnRef value. */
  ContainerName: "ContainerName",
}

/** MegaBytes wire value. */
scalar MegaBytes extends string;

/** Kubernetes-style memory resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
scalar MemoryQuantity extends string;

/** Represents a performance span for waterfall visualization. */
model PerfTrace {
  /** Base64-encoded span ID (12-char). */
  id: Base64;

  /** parentId value. */
  parentId: null | Base64;

  /** Unix timestamp in milliseconds when the span started. */
  startMs: int64;

  /** Span duration in milliseconds. */
  durationMs: int64;

  /** Descriptive name (e.g., "NodeAgent.InjectVmm"). */
  name: string;
}

/** User-provided container name within a pod. DNS label format: lowercase alphanumeric + hyphens, 1-63 chars, must start and end with alphanumeric. */
scalar PodContainerName extends string;

/** Pod-level security context — applies to all containers unless overridden at the container level. Follows Kubernetes pod securityContext semantics. */
model PodSecurityContext {
  /** runAsUser value. */
  runAsUser?: int32 | string | null;

  /** runAsGroup value. */
  runAsGroup?: int32 | string | null;

  /** runAsNonRoot value. */
  runAsNonRoot?: boolean | null;

  /** supplementalGroups value. */
  supplementalGroups?: int32[] | null;

  /** fsGroup value. */
  fsGroup?: int32 | string | null;

  /** fsGroupChangePolicy value. */
  fsGroupChangePolicy?: null | FsGroupChangePolicy;
}

/** PortActivationMode values. */
union PortActivationMode {
  /** Serialized PortActivationMode value. */
  Manual: "Manual",

  /** Serialized PortActivationMode value. */
  OnDemand: "OnDemand",
}

/** Specifies the HTTP protocol version to use when forwarding requests to a port. */
union PortProtocol {
  /** Serialized PortProtocol value. */
  Http: "Http",

  /** Serialized PortProtocol value. */
  Http2: "Http2",
}

/** PresetSandboxType values. */
union PresetSandboxType {
  /** Serialized PresetSandboxType value. */
  None: "None",

  /** Serialized PresetSandboxType value. */
  GitHubCopilot: "GitHubCopilot",

  /** Serialized PresetSandboxType value. */
  Moltbot: "Moltbot",

  /** Serialized PresetSandboxType value. */
  UbuntuSystemd: "UbuntuSystemd",

  /** Serialized PresetSandboxType value. */
  Claude: "Claude",

  /** Serialized PresetSandboxType value. */
  OpenClaw: "OpenClaw",
}

/** Exec probe handler that runs a command in the container. */
model ProbeExecAction {
  /** command value. */
  command: string[];
}

/** HTTP GET probe handler executed from inside the container VM. */
model ProbeHttpGetAction {
  /** port value. */
  port: SandboxPortNumber;

  /** path value. */
  path?: string | null;

  /** host value. */
  host?: string | null;

  /** scheme value. */
  scheme?: string | null;

  /** httpHeaders value. */
  httpHeaders?: ProbeHttpHeader[] | null;
}

/** HTTP header sent with a probe HTTP GET request. */
model ProbeHttpHeader {
  /** name value. */
  name: string;

  /** value value. */
  value: string;
}

/** TCP socket probe handler that checks whether a port accepts connections. */
model ProbeTcpSocketAction {
  /** port value. */
  port: SandboxPortNumber;

  /** host value. */
  host?: string | null;
}

/** ProjectId wire value. */
scalar ProjectId extends string;

/** Reference to an agent identity for assigning to a sandbox. */
model SandboxAgentIdentityRef {
  /** Tenant ID where the agent identity is registered. */
  tenantId: TenantId;

  /** Unique identifier for the agent identity. */
  agentId: string;
}

/** SandboxAutoDeletePolicy wire model. */
model SandboxAutoDeletePolicy {
  /** enabled value. */
  enabled: boolean;

  /** deleteIntervalInDays value. */
  deleteIntervalInDays?: int32 | string | null;

  /** deleteIntervalInSeconds value. */
  deleteIntervalInSeconds?: int64 | string | null;

  /** trigger value. */
  trigger?: null | AutoDeleteTrigger;
}

/** SandboxAutoSuspendPolicy wire model. */
model SandboxAutoSuspendPolicy {
  /** enabled value. */
  enabled: boolean;

  /** interval value. */
  interval?: int32 | string | null;

  /** mode value. */
  mode?: null | SandboxSuspendMode;
}

/** SandboxGroupId wire value. */
scalar SandboxGroupId extends string;

/** SandboxId wire value. */
scalar SandboxId extends string;

/** SandboxLifecyclePolicy wire model. */
model SandboxLifecyclePolicy {
  /** autoSuspendPolicy value. */
  autoSuspendPolicy: null | SandboxAutoSuspendPolicy;

  /** autoDeletePolicy value. */
  autoDeletePolicy: null | SandboxAutoDeletePolicy;
}

/** Represents a valid TCP/UDP port number on an instance (inside the VM). */
@minValue(1)
@maxValue(65535)
scalar SandboxPortNumber extends int32;

/** SandboxState values. */
union SandboxState {
  /** Serialized SandboxState value. */
  Running: "Running",

  /** Serialized SandboxState value. */
  Stopped: "Stopped",

  /** Serialized SandboxState value. */
  Idle: "Idle",

  /** Serialized SandboxState value. */
  Creating: "Creating",

  /** Serialized SandboxState value. */
  Stopping: "Stopping",

  /** Serialized SandboxState value. */
  StopFailed: "StopFailed",
}

/** Companion document to SandboxState. Populated when a sandbox transitions to SandboxState.Stopped; null on SandboxState.Running sandboxes (and on legacy stopped documents written before this field existed). */
model SandboxStateDetails {
  /** Why the sandbox is stopped. */
  stoppedReason: StoppedReason;

  /** Wall-clock time the stop transition was recorded. */
  stoppedAt: utcDateTime;
}

/** SandboxSuspendMode values. */
union SandboxSuspendMode {
  /** Serialized SandboxSuspendMode value. */
  Memory: "Memory",

  /** Serialized SandboxSuspendMode value. */
  Disk: "Disk",

  /** Serialized SandboxSuspendMode value. */
  None: "None",
}

/** Seccomp profile configuration for a container. */
model SeccompProfile {
  /** type value. */
  type: SeccompProfileType;
}

/** Seccomp profile type for container syscall filtering. */
union SeccompProfileType {
  /** Serialized SeccompProfileType value. */
  RuntimeDefault: "RuntimeDefault",

  /** Serialized SeccompProfileType value. */
  Unconfined: "Unconfined",
}

/** Represents a validated secret identifier. Must be 3-64 characters, containing only ASCII letters (upper/lower), digits, and hyphens. */
scalar SecretId extends string;

/** SnapshotId wire value. */
scalar SnapshotId extends string;

/** Reason a sandbox is in SandboxState.Stopped. Carried inside SandboxStateDetails. Distinguishes operator policy (StoppedReason.Disabled) from system-driven idle suspends (StoppedReason.Idle) and user-initiated stops (StoppedReason.UserStopped). Used by the OnDemand auto-resume gate: only StoppedReason.Disabled blocks auto-resume. */
union StoppedReason {
  /** Serialized StoppedReason value. */
  Idle: "Idle",

  /** Serialized StoppedReason value. */
  Disabled: "Disabled",

  /** Serialized StoppedReason value. */
  UserStopped: "UserStopped",
}

/** Kubernetes-style storage/disk resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
scalar StorageQuantity extends string;

/** Credential kind for a TDS egress connection. Managed identity is deferred (v1). */
union TdsAuthKind {
  /** Serialized TdsAuthKind value. */
  SqlPassword: "SqlPassword",

  /** Serialized TdsAuthKind value. */
  EntraToken: "EntraToken",
}

/** A declared TDS credential. string TdsCredential.Name uniquely identifies the credential within its TdsEgressSection and is what rules (string? TdsEgressAction.Credential) and webhook responses reference. On the API/contract path EgressPolicySecretRef? TdsCredential.SecretRef is set and string? TdsCredential.Secret is null. On the runtime path (after Global API resolution) string? TdsCredential.Secret holds the resolved material and flows (encrypted) to NodeAgent. */
model TdsCredential {
  /** name value. */
  name: string;

  /** kind value. */
  kind: TdsAuthKind;

  /** username value. */
  username?: string | null;

  /** secretRef value. */
  secretRef?: null | EgressPolicySecretRef;

  /** secret value. */
  secret?: string | null;
}

/** Static action for a TDS rule. EgressPolicyActionType TdsEgressAction.Type must be Allow or Deny (Transform/Rewrite are HTTP-only and rejected by validation). string? TdsEgressAction.Credential names a declared credential and is only valid on Allow. */
model TdsEgressAction {
  /** type value. */
  type: EgressPolicyActionType;

  /** credential value. */
  credential?: string | null;
}

/** Match criteria for a TDS egress rule (AND logic). Host is a glob over the SNI / original-dst server. */
model TdsEgressMatch {
  /** host value. */
  host: string;

  /** databases value. */
  databases?: string[] | null;
}

/** A single TDS egress rule. Rules are evaluated in order; first match wins. A rule has exactly one of TdsEgressAction? TdsEgressRule.Action (static) or EgressPolicyHookRef? TdsEgressRule.HookRef (dynamic webhook), never both — same XOR as HTTP. */
model TdsEgressRule {
  /** name value. */
  name: string | null;

  /** match value. */
  match: TdsEgressMatch;

  /** action value. */
  action?: null | TdsEgressAction;

  /** hookRef value. */
  hookRef?: null | EgressPolicyHookRef;
}

/** The TDS section of an egress policy. IReadOnlyList&lt;TdsCredential&gt; TdsEgressSection.Credentials is a list of named credentials (each string TdsCredential.Name unique within the section), declared once and referenced by name from static rules and webhook responses. The array-of-named-objects shape matches the rest of the ADC API (for example Connections); the runtime resolves it into a by-name map. On the runtime path each credential's string? TdsCredential.Secret is resolved. */
model TdsEgressSection {
  /** defaultAction value. */
  defaultAction: EgressPolicyActionType;

  /** credentials value. */
  credentials: TdsCredential[];

  /** rules value. */
  rules: TdsEgressRule[];
}

/** Authentication for an ApplicationInsights telemetry endpoint via secret reference. The connection string is resolved at runtime from the referenced user-managed secret. */
model TelemetryApplicationInsightsAuth {
  /** Reference to a user-managed secret containing key-value pairs. */
  secretId: SecretId;

  /** The key within the secret whose value is the Application Insights connection string. */
  secretKey: string;
}

/** Base type for telemetry authentication that uses a `kind` discriminator. Supports user-assigned and system-assigned managed identity; designed for future auth kinds (e.g., workload identity). */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union TelemetryAuth {
  /** ManagedIdentity variant. */
  ManagedIdentity: TelemetryAuthTelemetryManagedIdentityAuth,

  /** SystemAssignedManagedIdentity variant. */
  SystemAssignedManagedIdentity: TelemetryAuthTelemetrySystemAssignedManagedIdentityAuth,
}

/** User-assigned managed identity authentication for a Log Analytics telemetry endpoint. The egress proxy acquires a bearer token via Identity Proxy using the specified user-assigned MI. */
model TelemetryAuthTelemetryManagedIdentityAuth {
  /** kind value. */
  kind?: "ManagedIdentity";

  /** Full ARM resource ID of a user-assigned managed identity             (e.g., /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{name}). */
  identity: string;
}

/** System-assigned managed identity authentication for a Log Analytics telemetry endpoint. The egress proxy acquires a bearer token via Identity Proxy using the sandbox group's system-assigned MI. No explicit identity resource ID is needed — the Identity Proxy defaults to the system-assigned identity. */
model TelemetryAuthTelemetrySystemAssignedManagedIdentityAuth {
  /** kind value. */
  kind?: "SystemAssignedManagedIdentity";
}

/** Configures telemetry collection for a sandbox. Passed in sandbox creation requests. */
model TelemetryConfig {
  /** One or more telemetry endpoints to route data to. */
  endpoints: TelemetryEndpoint[];

  /** Optional metrics collection interval in seconds. Must be &gt;= 2. Defaults to 15 if not specified. */
  @pattern("^-?(?:0|[1-9]\\d*)$")
  metricsIntervalSeconds?: int32 | string | null;
}

/** Specifies which category of telemetry data to route to an endpoint. */
union TelemetryData {
  /** Serialized TelemetryData value. */
  ContainerStdoutStderr: "ContainerStdoutStderr",

  /** Serialized TelemetryData value. */
  ContainerOtel: "ContainerOtel",

  /** Serialized TelemetryData value. */
  Metrics: "Metrics",

  /** Serialized TelemetryData value. */
  NetworkEgressDecisions: "NetworkEgressDecisions",
}

/** Base type for telemetry endpoint configuration. Polymorphic on `kind` discriminator. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union TelemetryEndpoint {
  /** OTLP variant. */
  OTLP: TelemetryEndpointOtlpTelemetryEndpoint,

  /** ApplicationInsights variant. */
  ApplicationInsights: TelemetryEndpointApplicationInsightsTelemetryEndpoint,

  /** LogAnalytics variant. */
  LogAnalytics: TelemetryEndpointLogAnalyticsTelemetryEndpoint,

  /** LogAnalyticsLegacy variant. */
  LogAnalyticsLegacy: TelemetryEndpointLogAnalyticsLegacyTelemetryEndpoint,
}

/** Application Insights telemetry endpoint configuration. Uses the connection string to derive the ingestion and live-metrics endpoints. */
model TelemetryEndpointApplicationInsightsTelemetryEndpoint {
  /** kind value. */
  kind?: "ApplicationInsights";

  /** auth value. */
  auth: TelemetryApplicationInsightsAuth;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /** Optional custom column schema. When set, log records are projected             through this schema before being forwarded. Supported on all endpoint kinds for             `ContainerStdoutStderr` data. Per-kind semantics: OTLP — columns become log record             attributes (the `LogContent` ref also remains the OTLP body), and additionally, for an             OTLP endpoint routing `Metrics`, the `Value` columns and the resource-constant             `Ref` columns (`SandboxId`, `Region`) become OTLP metrics resource attributes             (`ResourceMetrics.Resource.Attributes`); LogAnalytics modern — columns become the DCR             stream record fields; LogAnalyticsLegacy — columns become the HTTP Data Collector API record             fields. */
  columns?: Record<LogColumnDef> | null;

  /** When true, JSON log lines are parsed and their top-level             keys are merged into the output record. Reserved keys (`message`, `time`,             `TimeGenerated`, anything starting with `adc.`) and any key already produced by             an explicit LogColumnDef are preserved (the parsed JSON does not override             them). Requires `ContainerStdoutStderr` in IReadOnlyList&lt;TelemetryData&gt; TelemetryEndpoint.Data. */
  dynamicJsonColumns?: boolean = false;
}

/** Log Analytics Legacy (Data Collector API) telemetry endpoint configuration. */
model TelemetryEndpointLogAnalyticsLegacyTelemetryEndpoint {
  /** kind value. */
  kind?: "LogAnalyticsLegacy";

  /** The Log Analytics workspace ID. */
  workspaceId: string;

  /** The custom log table name (e.g., "ContainerAppConsoleLogs"). */
  tableName: string;

  /** Polymorphic secret reference for the shared key. Resolved at runtime             from Key Vault. May be a TelemetrySecretRef (sandboxGroup-scoped legacy             secret) or a TelemetryAppSecretRef (artifactApp-local inline secret). */
  auth: TelemetrySecretReference;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /** Optional custom column schema. When set, log records are projected             through this schema before being forwarded. Supported on all endpoint kinds for             `ContainerStdoutStderr` data. Per-kind semantics: OTLP — columns become log record             attributes (the `LogContent` ref also remains the OTLP body), and additionally, for an             OTLP endpoint routing `Metrics`, the `Value` columns and the resource-constant             `Ref` columns (`SandboxId`, `Region`) become OTLP metrics resource attributes             (`ResourceMetrics.Resource.Attributes`); LogAnalytics modern — columns become the DCR             stream record fields; LogAnalyticsLegacy — columns become the HTTP Data Collector API record             fields. */
  columns?: Record<LogColumnDef> | null;

  /** When true, JSON log lines are parsed and their top-level             keys are merged into the output record. Reserved keys (`message`, `time`,             `TimeGenerated`, anything starting with `adc.`) and any key already produced by             an explicit LogColumnDef are preserved (the parsed JSON does not override             them). Requires `ContainerStdoutStderr` in IReadOnlyList&lt;TelemetryData&gt; TelemetryEndpoint.Data. */
  dynamicJsonColumns?: boolean = false;
}

/** Azure Monitor Log Analytics telemetry endpoint configuration. Uses the Logs Ingestion API via Data Collection Endpoint (DCE) and Data Collection Rule (DCR). Authentication is handled by the customer's managed identity (user-assigned or system-assigned) via Identity Proxy. */
model TelemetryEndpointLogAnalyticsTelemetryEndpoint {
  /** kind value. */
  kind?: "LogAnalytics";

  /** Data Collection Endpoint URL. */
  dceEndpoint: url;

  /** Data Collection Rule immutable ID. */
  dcrImmutableId: string;

  /** Target stream name in the DCR. */
  tableName: string;

  /** Required managed identity authentication. The identity must be assigned to the sandbox group. */
  auth: TelemetryAuth;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /** Optional custom column schema. When set, log records are projected             through this schema before being forwarded. Supported on all endpoint kinds for             `ContainerStdoutStderr` data. Per-kind semantics: OTLP — columns become log record             attributes (the `LogContent` ref also remains the OTLP body), and additionally, for an             OTLP endpoint routing `Metrics`, the `Value` columns and the resource-constant             `Ref` columns (`SandboxId`, `Region`) become OTLP metrics resource attributes             (`ResourceMetrics.Resource.Attributes`); LogAnalytics modern — columns become the DCR             stream record fields; LogAnalyticsLegacy — columns become the HTTP Data Collector API record             fields. */
  columns?: Record<LogColumnDef> | null;

  /** When true, JSON log lines are parsed and their top-level             keys are merged into the output record. Reserved keys (`message`, `time`,             `TimeGenerated`, anything starting with `adc.`) and any key already produced by             an explicit LogColumnDef are preserved (the parsed JSON does not override             them). Requires `ContainerStdoutStderr` in IReadOnlyList&lt;TelemetryData&gt; TelemetryEndpoint.Data. */
  dynamicJsonColumns?: boolean = false;
}

/** OTLP telemetry endpoint configuration. */
model TelemetryEndpointOtlpTelemetryEndpoint {
  /** kind value. */
  kind?: "OTLP";

  /** OTLP endpoint URL (e.g., "https://customer.monitor.azure.com/otlp"). */
  endpoint: url;

  /** `Grpc` or `Http`. */
  protocol: TelemetryProtocol;

  /** auth value. */
  auth?: null | TelemetryHeaderAuth;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /** Optional custom column schema. When set, log records are projected             through this schema before being forwarded. Supported on all endpoint kinds for             `ContainerStdoutStderr` data. Per-kind semantics: OTLP — columns become log record             attributes (the `LogContent` ref also remains the OTLP body), and additionally, for an             OTLP endpoint routing `Metrics`, the `Value` columns and the resource-constant             `Ref` columns (`SandboxId`, `Region`) become OTLP metrics resource attributes             (`ResourceMetrics.Resource.Attributes`); LogAnalytics modern — columns become the DCR             stream record fields; LogAnalyticsLegacy — columns become the HTTP Data Collector API record             fields. */
  columns?: Record<LogColumnDef> | null;

  /** When true, JSON log lines are parsed and their top-level             keys are merged into the output record. Reserved keys (`message`, `time`,             `TimeGenerated`, anything starting with `adc.`) and any key already produced by             an explicit LogColumnDef are preserved (the parsed JSON does not override             them). Requires `ContainerStdoutStderr` in IReadOnlyList&lt;TelemetryData&gt; TelemetryEndpoint.Data. */
  dynamicJsonColumns?: boolean = false;
}

/** Authentication configuration for an OTLP telemetry endpoint. The egress proxy injects the resolved secret value as an HTTP header. */
model TelemetryHeaderAuth {
  /** HTTP header to inject (e.g., "x-api-key", "Authorization"). */
  headerName: string;

  /** Reference to a user-managed secret containing key-value pairs. */
  secretId: SecretId;

  /** The key within the secret whose value should be used as the header value. */
  secretKey: string;
}

/** Specifies the protocol used to send telemetry data to an OTLP endpoint. */
union TelemetryProtocol {
  /** Serialized TelemetryProtocol value. */
  Grpc: "Grpc",

  /** Serialized TelemetryProtocol value. */
  Http: "Http",
}

/** Base type for telemetry endpoint secret references. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union TelemetrySecretReference {
  /** References a sandbox-group GlobalSecret by identifier and key. */
  GlobalSecret: TelemetrySecretRef,

  /** References a secret in the parent artifact app's local secret bundle. */
  AppSecret: TelemetryAppSecretRef,
}

/** Reference to a sandbox-group GlobalSecret. */
model TelemetrySecretRef {
  /** Secret-reference kind. Optional for compatibility with legacy payloads. */
  kind?: "GlobalSecret";

  /** Identifier of the sandbox-group secret. */
  secretId: SecretId;

  /** Key within the secret whose value should be used. */
  secretKey: string;
}

/** Reference to a secret in the parent artifact app. */
model TelemetryAppSecretRef {
  /** Secret-reference kind. */
  kind: "AppSecret";

  /** Name of the secret in the parent artifact app's secret bundle. */
  secretRef: string;
}

/** TenantId wire value. */
scalar TenantId extends string;

/** Controls the scope of TLS inspection for the egress proxy on a per-sandbox basis. */
union TrafficInspection {
  /** Serialized TrafficInspection value. */
  Legacy: "Legacy",

  /** Serialized TrafficInspection value. */
  Partial: "Partial",

  /** Serialized TrafficInspection value. */
  Full: "Full",

  /** Serialized TrafficInspection value. */
  None: "None",
}

/** A single L3/L4 transport egress rule. Rules are evaluated in declared order; first match wins. EgressPolicyActionType TransportEgressRule.Action must be Allow or Deny (Transform/Rewrite are HTTP-only and rejected by validation). string TransportEgressRule.Destination is an IPv4 CIDR (v1). int? TransportEgressRule.Port is a single destination port (`1..65535`) or `null` to match every port on the destination (any-port wildcard). */
model TransportEgressRule {
  /** action value. */
  action: EgressPolicyActionType;

  /** protocol value. */
  protocol: TransportProtocol;

  /** destination value. */
  destination: string;

  /** port value. */
  port: int32 | string | null;
}

/** The transport (L3/L4 TCP/UDP) section of an egress policy. Distinct from HTTP and TDS policy and enforced by NodeAgent at the network layer (`iptables`). EgressPolicyActionType TransportEgressSection.DefaultAction is the terminal action applied to raw TCP/UDP flows that match no rule; IReadOnlyList&lt;TransportEgressRule&gt; TransportEgressSection.Rules is capped at 10 entries. DNS (port 53) is always carved out and never constrained by these rules in v1. */
model TransportEgressSection {
  /** defaultAction value. */
  defaultAction: EgressPolicyActionType;

  /** rules value. */
  rules: TransportEgressRule[];
}

/** L4 transport protocol for an L3 egress rule. */
union TransportProtocol {
  /** Serialized TransportProtocol value. */
  Tcp: "Tcp",

  /** Serialized TransportProtocol value. */
  Udp: "Udp",
}

/** VmmType values. */
union VmmType {
  /** Serialized VmmType value. */
  cloudhypervisor: "cloudhypervisor",

  /** Serialized VmmType value. */
  hcs: "hcs",

  /** Serialized VmmType value. */
  firecracker: "firecracker",
}

/** VolumeName wire value. */
scalar VolumeName extends string;
