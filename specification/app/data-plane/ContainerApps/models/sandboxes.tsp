using TypeSpec.Rest;

namespace ContainerAppsSandbox;

/** Response containing the total number of sandboxes in a scope. */
model SandboxCountResponse is CountResponse;

/** Customer-facing sandbox resource returned by the service. */
@resource("sandboxes")
@parentResource(SandboxGroupScope)
model Sandbox {
  /** Sandbox identifier assigned by the service. */
  @key("id")
  @visibility(Lifecycle.Read)
  id: SandboxId;

  /** Customer-defined labels for the disk image. */
  labels?: Record<string>;

  /** Entrypoint override for the sandbox container. */
  entrypoint?: string[];

  /** Cmd override for the sandbox container. */
  cmd?: string[];

  /** Sandbox source returned by the service. */
  sourcesRef: SandboxSource;

  /** Sandbox resources returned by the service. */
  resources: SandboxResources;

  /** Creation timestamp assigned by the service. */
  createdAt?: utcDateTime;

  /** Current sandbox state. */
  state?: SandboxState;

  /** Current sandbox state details. */
  stateDetails?: SandboxStateDetails;

  /** Snapshot identifier assigned by the service. */
  snapshotId?: string;

  /** Cold-storage size assigned by the service. */
  @encodedName("application/json", "coldStorageSizeInMB")
  coldStorageSizeInMb?: int64;

  /** Ports exposed on the sandbox. */
  ports?: SandboxPort[];

  /** List of connection IDs associated with this sandbox. */
  connections?: string[];

  /** AI Gateway connections associated with this sandbox. */
  gatewayConnections?: GatewayConnection[];

  /** Sandbox-group credential names associated with this sandbox. */
  credentialRefs?: string[];

  /** Egress policy applied to the sandbox. */
  egressPolicy?: SandboxEgressPolicy;

  /** Optional sandbox group identifier. */
  sandboxGroupId?: string;

  /** The Azure region where this sandbox is running. */
  region?: string;

  /** Lifecycle policy applied to the sandbox. */
  lifecycle?: SandboxLifecyclePolicy;

  /** The apps domain URL for sandboxes with type=app label. */
  appUrl?: string;

  /** The base URL for data plane operations. */
  managementUrl?: string;

  /** Agent identity assigned to the sandbox. */
  agentIdentity?: SandboxAgentIdentityRef;

  /** Volume mounts attached to this sandbox. */
  volumes?: SandboxVolume[];

  /** Content packages downloaded to this sandbox during creation. */
  contentPackageDownloads?: SandboxContentPackageDownload[];

  /** The name of the VNet connection used by the sandbox. */
  vnetConnectionName?: string;

  /** Identity settings applied to the sandbox. */
  identitySettings?: IdentitySetting[];

  /** Static outbound IP addresses for the cluster hosting this sandbox. */
  outboundIpAddresses?: string[];

  /** Live per-container runtime statuses for pod sandboxes. */
  containerStatuses?: ContainerStatus[];
}

/** Events that can start automatic sandbox deletion. */
union AutoDeleteTrigger {
  string,

  /** Starts the deletion timer when the sandbox is suspended. */
  AfterSuspend: "AfterSuspend",

  /** Starts the deletion timer when the sandbox is created. */
  AfterCreation: "AfterCreation",
}

/** Probe configuration for checking a container's startup, liveness, or readiness state. */
model ContainerProbe {
  /** An HTTP GET probe handler. */
  httpGet?: ProbeHttpGetAction;

  /** A command probe handler. */
  exec?: ProbeExecAction;

  /** A TCP socket probe handler. */
  tcpSocket?: ProbeTcpSocketAction;

  /** The delay in seconds before the first probe. */
  initialDelaySeconds?: int32;

  /** The interval in seconds between probes. */
  periodSeconds?: int32;

  /** The number of seconds before a probe times out. */
  timeoutSeconds?: int32;

  /** Consecutive failures required for the probe to fail. */
  failureThreshold?: int32;

  /** Consecutive successes required for the probe to succeed. */
  successThreshold?: int32;

  /** The grace period in seconds before terminating the container after probe failure. */
  terminationGracePeriodSeconds?: int32;
}

/** Possible results of a container probe. */
union ContainerProbeResult {
  string,

  /** The probe succeeded. */
  Success: "Success",

  /** The probe failed. */
  Failure: "Failure",

  /** The probe result is not known. */
  Unknown: "Unknown",
}

/** Runtime status for a configured container probe. */
model ContainerProbeStatus {
  /** The most recent probe result. */
  lastResult?: ContainerProbeResult;

  /** The number of consecutive probe failures. */
  consecutiveFailures?: int32 = 0;

  /** The number of consecutive probe successes. */
  consecutiveSuccesses?: int32 = 0;

  /** The time when the probe last ran. */
  lastCheckedAt?: utcDateTime;

  /** The time when the probe result last changed. */
  lastTransitionAt?: utcDateTime;

  /** Details about the latest probe result. */
  message?: string;
}

/** Policies for restarting a stopped container. */
union ContainerRestartPolicy {
  string,

  /** Always restart a stopped container. */
  Always: "Always",

  /** Restart a container only after a failure. */
  OnFailure: "OnFailure",

  /** Do not restart a stopped container. */
  Never: "Never",
}

/** Customer-facing container runtime state. */
union ContainerRuntimeState {
  string,

  /** The container state is not known. */
  Unknown: "Unknown",

  /** The container is waiting to start. */
  Waiting: "Waiting",

  /** The container is running. */
  Running: "Running",

  /** The container has terminated. */
  Terminated: "Terminated",
}

/** Container-level security context — overrides pod-level settings where applicable. Follows Kubernetes container securityContext semantics. */
model ContainerSecurityContext {
  /** The user ID used to run the container process. */
  runAsUser?: int32;

  /** The group ID used to run the container process. */
  runAsGroup?: int32;

  /** Whether the container must run as a non-root user. */
  runAsNonRoot?: boolean;

  /** Whether the container runs in privileged mode. */
  privileged?: boolean = false;

  /** Linux capabilities to add or drop. */
  capabilities?: LinuxCapabilities;

  /** Whether the process can gain additional privileges. */
  allowPrivilegeEscalation?: boolean = true;

  /** Whether the container root filesystem is read-only. */
  readOnlyRootFilesystem?: boolean = false;

  /** The seccomp profile applied to the container. */
  seccompProfile?: SeccompProfile;
}

/** Reasons reported for a container status. */
union ContainerStatusReason {
  string,

  /** The container completed successfully. */
  Completed: "Completed",

  /** The container terminated with an error. */
  Error: "Error",

  /** The container is repeatedly failing and restarting. */
  CrashLoopBackOff: "CrashLoopBackOff",

  /** A root filesystem reset is pending. */
  RootfsResetPending: "RootfsResetPending",

  /** A root filesystem reset failed. */
  RootfsResetFailed: "RootfsResetFailed",
}

/** Runtime status for one pod container. */
model ContainerStatus {
  /** The container name. */
  name: PodContainerName;

  /** The current runtime state. */
  state: ContainerRuntimeState;

  /** Whether the container is ready to receive traffic. */
  ready: boolean;

  /** Whether the container has started. */
  started: boolean;

  /** The number of times the container has restarted. */
  restartCount: int32;

  /** The reason for the current state. */
  reason?: ContainerStatusReason;

  /** Details about the current state. */
  message?: string;

  /** The exit code from the most recently terminated process. */
  lastExitCode?: int32;

  /** The time when the container last started. */
  lastStartedAt?: utcDateTime;

  /** The time when the container last stopped. */
  lastFinishedAt?: utcDateTime;

  /** Runtime status keyed by probe type. */
  probes?: Record<ContainerProbeStatus>;
}

/** Specifies how a content package should be delivered to the container. */
union ContentPackageAction {
  string,

  /** Downloads the package contents into the container. */
  Download: "Download",

  /** Mounts the package in the container. */
  Mount: "Mount",
}

/** A content package identifier. */
scalar ContentPackageId extends string;

/** Kubernetes-style CPU resource quantity string (e.g. "500m", "2", "0.5"). */
scalar CpuQuantity extends string;

/** A disk image identifier. */
scalar DiskImageId extends string;

/** Types of actions that an egress policy rule can take. */
union EgressPolicyActionType {
  string,

  /** Allows matching traffic. */
  Allow: "Allow",

  /** Denies matching traffic. */
  Deny: "Deny",

  /** Applies header transformations to matching traffic. */
  Transform: "Transform",

  /** Rewrites the destination of matching traffic. */
  Rewrite: "Rewrite",
}

/** Modes for enforcing an egress policy. */
union EgressPolicyEnforcementMode {
  string,

  /** Applies policy decisions to traffic. */
  Enforced: "Enforced",

  /** Records policy decisions without blocking traffic. */
  Audit: "Audit",
}

/** Types of header transformation operations. */
union EgressPolicyHeaderOperation {
  string,

  /** Replaces the header value. */
  Set: "Set",

  /** Adds another value for the header. */
  Insert: "Insert",

  /** Removes the header. */
  Remove: "Remove",
}

/** Describes a header transformation to apply to matching requests. */
model EgressPolicyHeaderTransform {
  /** The header operation to apply. */
  operation: EgressPolicyHeaderOperation;

  /** The header name. */
  name: string;

  /** A static header value. */
  value?: string;

  /** A dynamic source for the header value. */
  valueRef?: EgressPolicyValueRef;
}

/** Action to take when an egress policy webhook fails. */
union EgressPolicyHookFailBehavior {
  string,

  /** Denies the request when the webhook fails. */
  Deny: "Deny",

  /** Allows the request when the webhook fails. */
  Allow: "Allow",
}

/** A webhook that dynamically decides how matching egress traffic is handled. */
model EgressPolicyHookRef {
  /** The webhook endpoint. */
  endpoint: string;

  /** The action to take when the webhook fails. */
  failBehavior?: EgressPolicyHookFailBehavior;

  /** Request headers included in the webhook payload. */
  requestHeaders?: string[];

  /** Authentication headers added to the webhook request. */
  authHeaders?: EgressPolicyHeaderTransform[];

  /** The webhook timeout in milliseconds. */
  timeoutMs?: int32;

  /** How the webhook request is routed. */
  routingMode?: EgressRuleRoutingMode;
}

/** A managed identity token used as a dynamic header value. */
model EgressPolicyManagedIdentityRef {
  /** The token audience or resource. */
  resource: string;

  /** An optional format applied to the token value. */
  format?: string;

  /** The managed identity type. */
  type?: EgressPolicyManagedIdentityType;

  /** The resource ID of the user-assigned managed identity. */
  identityResourceId?: string;
}

/** Managed identity types supported by an egress rule. */
union EgressPolicyManagedIdentityType {
  string,

  /** Uses the sandbox group's system-assigned managed identity. */
  SystemAssigned: "SystemAssigned",

  /** Uses a user-assigned managed identity. */
  UserAssigned: "UserAssigned",
}

/** URI schemes that an egress rule can match. */
union EgressPolicyMatchScheme {
  string,

  /** Matches HTTP requests. */
  http: "http",

  /** Matches HTTPS requests. */
  https: "https",

  /** Matches HTTP or HTTPS requests. */
  any: "any",
}

/** An egress rule evaluated in order until the first match. */
model EgressPolicyRule {
  /** The rule name. */
  name: string;

  /** The request criteria matched by the rule. */
  match: EgressPolicyRuleMatch;

  /** The static action applied to matching traffic. */
  action?: EgressPolicyRuleAction;

  /** Additional proxy actions applied to matching traffic. */
  proxyActions?: string[];

  /** The source that supplied the rule. */
  source?: string;

  /** A webhook that dynamically determines the action. */
  hookRef?: EgressPolicyHookRef;
}

/** The action applied when an HTTP egress rule matches. */
model EgressPolicyRuleAction {
  /** The action type. */
  type: EgressPolicyActionType;

  /** Header transformations applied to the request. */
  headers?: EgressPolicyHeaderTransform[];

  /** The replacement URI scheme for a rewrite. */
  scheme?: string;

  /** The replacement host for a rewrite. */
  host?: string;

  /** The replacement path for a rewrite. */
  path?: string;

  /** How rewritten traffic is routed. */
  routingMode?: EgressRuleRoutingMode;

  /** Controls how matching traffic is forwarded. */
  forward?: EgressForwardMode = "default";

  /** The proxy used to forward matching traffic. */
  forwardProxy?: EgressForwardProxy;
}

/** Controls how egress traffic is forwarded. */
union EgressForwardMode {
  string,

  /** Uses the default forwarding behavior. */
  Default: "default",

  /** Forwards traffic directly. */
  Direct: "direct",

  /** Forwards traffic through a proxy. */
  Proxy: "proxy",
}

/** Proxy configuration for forwarded egress traffic. */
model EgressForwardProxy {
  /** The proxy URL. */
  url: string;

  /** The certificate authority data used to validate the proxy. */
  ca?: string;
}

/** Request criteria for an egress rule. All specified criteria must match. */
model EgressPolicyRuleMatch {
  /** The host pattern to match. */
  host: string;

  /** The path pattern to match. */
  path?: string;

  /** The HTTP methods to match. */
  methods?: string[];

  /** The URI scheme to match. */
  scheme?: EgressPolicyMatchScheme;

  /** Whether to decode and normalize the request path before matching. Defaults to true. */
  normalizePath?: boolean;
}

/** References a secret stored via the Secrets API for header value injection. */
model EgressPolicySecretRef {
  /** The secret identifier. */
  secretId: string;

  /** The key within the secret. */
  secretKey?: string;

  /** An optional format applied to the secret value. */
  format?: string;
}

/** A dynamic value reference for header transforms. Exactly one of the ref fields should be set. */
model EgressPolicyValueRef {
  /** A value loaded from a sandbox-group secret. */
  secretRef?: EgressPolicySecretRef;

  /** A value obtained from a managed identity token. */
  managedIdentityRef?: EgressPolicyManagedIdentityRef;
}

/** Controls how matching egress traffic reaches its destination. */
union EgressRuleRoutingMode {
  string,

  /** Uses the sandbox's default egress routing. */
  Default: "Default",

  /** Routes through the sandbox virtual network. */
  Vnet: "Vnet",

  /** Routes through the platform network. */
  Platform: "Platform",
}

/** Policies for changing mounted-volume ownership. */
union FsGroupChangePolicy {
  string,

  /** Changes ownership only when the root directory does not match. */
  OnRootMismatch: "OnRootMismatch",

  /** Always changes volume ownership. */
  Always: "Always",

  /** Does not change volume ownership. */
  None: "None",
}

/** The type of managed identity used for service authentication. */
union ManagedIdentityAuthenticationType {
  string,

  /** Uses the sandbox group's system-assigned managed identity. */
  SystemAssigned: "SystemAssigned",

  /** Uses a user-assigned managed identity. */
  UserAssigned: "UserAssigned",
}

/** Managed identity authentication configuration. */
model ManagedIdentityAuthentication {
  /** The type of managed identity to use. */
  type: ManagedIdentityAuthenticationType;

  /** Required for UserAssigned and omitted for SystemAssigned. */
  identityResourceId?: string;
}

/** Authentication returned for a gateway connection. */
model GatewayAuthentication {
  /** Managed identity used by the connection. */
  identity?: ManagedIdentityAuthentication;
}

/** Customer-facing AI Gateway connection associated with a sandbox. */
model GatewayConnection {
  /** Azure resource ID of an AI Gateway server configuration or connection. */
  resourceId: string;

  /** Optional user-friendly name resolved by the service. */
  @visibility(Lifecycle.Read)
  name?: string;

  /** MCP server endpoint URL resolved by the service. */
  @visibility(Lifecycle.Read)
  mcpRuntimeUrl?: string;

  /** Direct connection endpoint URL resolved by the service. */
  @visibility(Lifecycle.Read)
  connectionRuntimeUrl?: string;

  /** Authentication resolved by the service. */
  @visibility(Lifecycle.Read)
  authentication?: GatewayAuthentication;
}

/** AI Gateway connection reference used when creating a sandbox. */
model CreateSandboxGatewayConnectionContent {
  /** Azure resource ID of an AI Gateway server configuration or connection. */
  resourceId: string;
}

/** CPU, memory, and writable disk requested for a container. */
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
  /** The container name. */
  name: PodContainerName;

  /** Optional disk image used as the container source. */
  diskImage?: SandboxSourceDiskImage;

  /** Optional artifact version used as the container source. */
  artifactVersion?: SandboxSourceArtifactVersion;

  /** The command that replaces the image entrypoint. */
  command?: string[];

  /** Arguments passed to the container command. */
  args?: string[];

  /** Environment variables for the container. */
  env?: Record<string>;

  /** CPU, memory, and disk allocated to the container. */
  resources?: ContainerResources;

  /** Volumes mounted in the container. */
  volumeMounts?: ContainerVolumeMount[];

  /** Content packages downloaded into the container. */
  contentPackageDownloads?: SandboxContentPackageDownload[];

  /** Security settings for the container. */
  securityContext?: ContainerSecurityContext;

  /** Probe that determines when the container has started. */
  startupProbe?: ContainerProbe;

  /** Probe that determines whether the container should be restarted. */
  livenessProbe?: ContainerProbe;

  /** Probe that determines whether the container can receive traffic. */
  readinessProbe?: ContainerProbe;
}

/** Per-container volume mount specifying which volume to mount and where. */
model ContainerVolumeMount {
  /** The referenced pod volume name. */
  name: VolumeName;

  /** The absolute path where the volume is mounted. */
  mountPath: string;

  /** Whether the volume is mounted read-only. */
  readOnly?: boolean = false;
}

/** A host pattern and the egress action applied to matching traffic. */
model EgressHostRule {
  /** The host glob pattern to match. */
  pattern: string;

  /** The action applied to matching hosts. */
  action?: EgressPolicyAction;
}

/** Actions applied to matching egress traffic. */
union EgressPolicyAction {
  string,

  /** Allows matching traffic. */
  Allow: "Allow",

  /** Denies matching traffic. */
  Deny: "Deny",
}

/** HTTP and HTTPS egress policy settings. */
model HttpEgressSection {
  /** The default action applied when no rule matches. Required: a request that sends an `http` section must specify a default action. */
  defaultAction: EgressPolicyAction;

  /** Host-based allow and deny rules. */
  hostRules?: EgressHostRule[];

  /** Ordered egress rules for allow, deny, transform, and header actions. The first match wins. */
  rules?: EgressPolicyRule[];

  /** Controls the scope of TLS inspection for the egress proxy. Defaults to Full. */
  trafficInspection?: TrafficInspection;

  /** Whether policy decisions are enforced or only audited. */
  enforcementMode?: EgressPolicyEnforcementMode;

  /** The default proxy used to forward egress traffic. */
  defaultForward?: EgressForwardProxy;
}

/** A single IP access control rule. */
model IpAccessControlRule {
  /** The rule name. */
  name: string;

  /** The action applied to matching source addresses. */
  action: IpAccessControlAction;

  /** The rule priority. Lower values are evaluated first. */
  @minValue(0)
  @maxValue(1000)
  priority: int32;

  /** The source CIDR ranges matched by the rule. */
  sourceCidrs: string[];
}

/** IP access control configuration for a port. Rules are evaluated in priority order; first match wins. */
model IpAccessControl {
  /** The action applied when no access-control rule matches. */
  defaultAction: IpAccessControlAction;

  /** IP access-control rules evaluated by priority. */
  rules?: IpAccessControlRule[];
}

/** Declares a content package available to containers in the pod. */
model PodContentPackage {
  /** The referenced content package identifier. */
  contentPackageId: ContentPackageId;
}

/** A named pod volume that containers can mount. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The existing API requires this polymorphic volume union."
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union PodVolume {
  /** A service-managed Azure Blob volume. */
  AzureBlob: AzureBlobPodVolume,

  /** A customer-owned Azure Blob container volume. */
  AzureBlobByo: AzureBlobByoPodVolume,

  /** A local sandbox volume. */
  Local: LocalPodVolume,

  /** A persistent data disk volume. */
  DataDisk: DataDiskPodVolume,
}

/** Bring-your-own (BYO) Azure Blob container volume source, backed by blobfuse2. */
model AzureBlobByoPodVolume {
  /** The pod volume type. */
  kind?: "AzureBlobByo";

  /** The maximum local file cache size. */
  fileCacheSizeLimit: StorageQuantity;

  /** Whether the blob volume is read-only. */
  readOnly?: boolean = false;

  /** The pod volume name. */
  name: VolumeName;
}

/** Azure Blob Storage volume source, backed by blobfuse2. */
model AzureBlobPodVolume {
  /** The pod volume type. */
  kind?: "AzureBlob";

  /** The maximum local file cache size. */
  fileCacheSizeLimit: StorageQuantity;

  /** Whether the blob volume is read-only. */
  readOnly?: boolean = false;

  /** The pod volume name. */
  name: VolumeName;
}

/** Data disk volume source backed by a persistent ext4 block device in cluster storage. */
model DataDiskPodVolume {
  /** The pod volume type. */
  kind?: "DataDisk";

  /** The referenced data disk volume name. */
  name: VolumeName;
}

/** Local volume source backed by rootfs space. */
model LocalPodVolume {
  /** The pod volume type. */
  kind?: "Local";

  /** The requested local volume size. */
  size: StorageQuantity;

  /** The pod volume name. */
  name: VolumeName;
}

/** Entra ID-specific auth configuration for a port. */
model PortAuthConfigEntraId {
  /** Whether Entra ID authentication is enabled. */
  enabled?: boolean;

  /** Allowed email addresses. A maximum of 100 identity filters can be configured. */
  emails?: string[];

  /** Allowed email domain suffixes. A maximum of 100 identity filters can be configured. */
  emailSuffixes?: string[];

  /** Allowed Microsoft Entra user or group object IDs. A maximum of 100 identity filters can be configured. */
  objectIds?: string[];

  /** Allowed Microsoft Entra tenant IDs. A maximum of 100 identity filters can be configured. */
  tenantIds?: string[];
}

/** GitHub-specific auth configuration for a port. Permits users whose verified email ends with @microsoft.com or @github.com. */
model PortAuthConfigGithub {
  /** Whether GitHub authentication is enabled. */
  enabled?: boolean;

  /** Allowed email addresses. A maximum of 100 identity filters can be configured. */
  emails?: string[];

  /** Allowed email domain suffixes. A maximum of 100 identity filters can be configured. */
  emailSuffixes?: string[];

  /** Allowed GitHub usernames. A maximum of 100 identity filters can be configured. */
  usernames?: string[];

  /** Allowed GitHub username suffixes. A maximum of 100 identity filters can be configured. */
  usernameSuffixes?: string[];
}

/** Auth configuration for a port. Each provider can be independently enabled/disabled without removing configuration. */
model PortAuthConfig {
  /** Whether unauthenticated access is allowed. */
  anonymous?: boolean;

  /** GitHub authentication settings. */
  github?: PortAuthConfigGithub;

  /** Microsoft Entra ID authentication settings. */
  entraId?: PortAuthConfigEntraId;
}

/** CORS configuration for a sandbox port. */
model PortCorsConfig {
  /** Origins allowed to access the port. */
  allowOrigins?: string[];

  /** HTTP methods allowed in cross-origin requests. */
  allowMethods?: string[];

  /** Request headers allowed in cross-origin requests. */
  allowHeaders?: string[];

  /** Whether cross-origin requests may include credentials. */
  allowCredentials?: boolean;

  /** The preflight response cache duration in seconds. */
  maxAge?: int32;
}

/** Represents a content package to be downloaded onto a sandbox during creation. */
model SandboxContentPackageDownload {
  /** The content package ID to download. */
  contentPackageId: ContentPackageId;

  /** The target path in the sandbox where the content package will be downloaded. Must be an absolute path. Parent directories will be created if they don't exist. */
  targetPath: string;

  /** How to deliver the package. Mount exposes a zip package as a read-only file system. */
  action?: ContentPackageAction;
}

/** Egress policy applied to a sandbox. */
model SandboxEgressPolicy {
  /** HTTP and HTTPS egress policy. */
  http?: HttpEgressSection;

  /** The default HTTP egress action. */
  defaultAction?: EgressPolicyAction;

  /** Host-based HTTP egress rules. */
  hostRules?: EgressHostRule[];

  /** Ordered egress rules for allow, deny, transform, and header actions. The first match wins. */
  rules?: EgressPolicyRule[];

  /** TDS database egress policy. */
  tds?: TdsEgressSection;

  /** Raw TCP and UDP egress policy. */
  transportRules?: TransportEgressSection;

  /** Controls TLS inspection and handling of non-HTTP traffic. Defaults to Full. */
  trafficInspection?: TrafficInspection;

  /** Whether policy decisions are enforced or only audited. */
  enforcementMode?: EgressPolicyEnforcementMode;

  /** Warnings found while validating the policy. */
  validationWarnings?: ValidationWarning[];
}

/** Represents a port exposed on a sandbox. */
model SandboxPort {
  /** Optional name for the port (must be unique per sandbox if provided). */
  name?: string;

  /** The port number exposed on the sandbox (required, must be unique per sandbox). */
  port: SandboxPortNumber;

  /** The URL to access the port on the sandbox (required). */
  @visibility(Lifecycle.Read)
  url: url;

  /** Authentication required to access the port. */
  auth?: PortAuthConfig;

  /** When the port becomes active. */
  activationMode?: PortActivationMode;

  /** The HTTP protocol version to use when forwarding requests to this port. Defaults to Http (HTTP/1.1). */
  protocol?: PortProtocol;

  /** Source IP access-control settings. */
  ipAccessControl?: IpAccessControl;

  /** Cross-origin request settings. */
  cors?: PortCorsConfig;
}

/** Port configuration used when creating a sandbox. */
model CreateSandboxPortContent {
  /** Optional name for the port. */
  name?: string;

  /** The port number to expose on the sandbox. */
  port: SandboxPortNumber;

  /** Authentication configuration for the port. */
  auth?: PortAuthConfig;

  /** Port activation mode. */
  activationMode?: PortActivationMode;

  /** HTTP protocol version used when forwarding requests to this port. */
  protocol?: PortProtocol;

  /** IP access control configuration for the port. */
  ipAccessControl?: IpAccessControl;

  /** CORS configuration for the port. */
  cors?: PortCorsConfig;
}

/** Preset-specific properties for sandbox creation. These properties configure optional features for specific preset types. */
model SandboxPresetProperties {
  /** Whether to enable the WorkIQ connection for the GitHubCopilot preset. When true, the WorkIQ managed API must be available in the region. */
  isWorkIqConnectionEnabled?: boolean;
}

/** Request body for creating a sandbox. */
model CreateSandboxContent {
  /** Customer-defined labels for the sandbox. */
  labels?: Record<string>;

  /** Entrypoint override for the sandbox container. */
  entrypoint?: string[];

  /** Cmd override for the sandbox container. */
  cmd?: string[];

  /** Optional environment variables set when creating the sandbox. */
  environment?: Record<string>;

  /** Sandbox source. This may be omitted when the service can resolve a default. */
  sourcesRef?: SandboxSource;

  /** Sandbox resources. This may be omitted when the service can resolve defaults. */
  resources?: SandboxResources;

  /** Ports to expose when creating the sandbox. */
  ports?: CreateSandboxPortContent[];

  /** List of connection IDs to associate with the sandbox. */
  connections?: string[];

  /** AI Gateway connections to associate with the sandbox. */
  gatewayConnections?: CreateSandboxGatewayConnectionContent[];

  /** Sandbox-group credential names to associate with the sandbox. */
  credentialRefs?: string[];

  /** Egress policy to apply to the sandbox. */
  egressPolicy?: SandboxEgressPolicy;

  /** Optional reference to a named egress policy. */
  egressPolicyId?: string;

  /** Optional sandbox group identifier. */
  sandboxGroupId?: string;

  /** Optional preset used when creating the sandbox. */
  presetSandboxType?: PresetSandboxType;

  /** Sensitive Anthropic API key used by the Claude preset. */
  @secret
  anthropicApiKey?: string;

  /** Preset-specific creation properties. */
  presetProperties?: SandboxPresetProperties;

  /** Lifecycle policy for the sandbox. */
  lifecycle?: SandboxLifecyclePolicy;

  /** Agent identity to assign to the sandbox. */
  agentIdentity?: SandboxAgentIdentityRef;

  /** Volume mounts to attach to the sandbox. */
  volumes?: SandboxVolume[];

  /** Content packages to download during sandbox creation. */
  contentPackageDownloads?: SandboxContentPackageDownload[];

  /** The name of the VNet connection to use. */
  vnetConnectionName?: string;

  /** Identity settings to apply to the sandbox. */
  identitySettings?: IdentitySetting[];

  /** Telemetry configuration to apply to the sandbox. */
  telemetryConfig?: TelemetryConfig;

  /** Optional project associated with the sandbox. */
  projectId?: ProjectId;
}

/** CPU, memory, and disk allocated to a sandbox. */
model SandboxResources {
  /** The CPU allocation. */
  cpu: CpuQuantity;

  /** The memory allocation. */
  memory: MemoryQuantity;

  /** The disk allocation. */
  disk?: StorageQuantity;
}

/** A disk image used to create a sandbox. */
model SandboxSourceDiskImage {
  /** The identifier of a sandbox-group disk image. */
  id?: DiskImageId;

  /** Disk image name for public disk images (e.g., "nginx", "python3.12"). Mutually exclusive with Id. */
  name?: string;

  /** Indicates whether this references a public disk image. Must be true when using Name, must be false when using Id. */
  isPublic?: boolean;
}

/** Pod source for sandbox creation. */
model SandboxSourcePod {
  /** The containers in the pod. */
  containers: ContainerSpec[];

  /** Pod-level volume definitions. */
  volumes?: PodVolume[];

  /** Content packages available to the pod. */
  contentPackages?: PodContentPackage[];

  /** Security settings shared by all pod containers. */
  securityContext?: PodSecurityContext;

  /** The container restart policy. */
  restartPolicy?: ContainerRestartPolicy;
}

/** A snapshot used to restore a sandbox. */
model SandboxSourceSnapshot {
  /** The snapshot identifier. */
  id: string;
}

/** The source configuration used to create a sandbox. */
model SandboxSource {
  /** A disk image source. */
  diskImage?: SandboxSourceDiskImage;

  /** A snapshot source. */
  snapshot?: SandboxSourceSnapshot;

  /** An inline pod definition. */
  pod?: SandboxSourcePod;

  /** The artifact version used as the sandbox source. */
  artifactVersion?: SandboxSourceArtifactVersion;
}

/** An artifact version used as a sandbox source. */
model SandboxSourceArtifactVersion {
  /** The artifact version identifier. */
  id: string;

  /** Authentication configuration used to access the artifact version. */
  auth: SandboxSourceAuth;
}

/** Authentication configuration for a sandbox source. */
model SandboxSourceAuth {
  /** The identity used to access the sandbox source. */
  identity: string;
}

/** Volume configuration for a sandbox. */
model SandboxVolume {
  /** The volume name. */
  volumeName: VolumeName;

  /** The path where the volume is mounted. */
  mountpoint: string;

  /** Whether the mount is read-only. */
  readOnly?: boolean = false;
}

/** A non-fatal policy validation warning. */
model ValidationWarning {
  /** A machine-readable warning code. */
  code: string;

  /** A human-readable warning message. */
  message: string;
}

/** Per-identity availability setting on a sandbox. Allows explicit control over which identities from the group are served to the sandbox. */
model IdentitySetting {
  /** Managed identity resource ID, system-assigned identity marker, or client ID. */
  identity: string;

  /** Lifecycle phase gating for this identity. */
  lifecycle?: IdentitySettingLifecycle;
}

/** Controls which identity lifecycle phases a specific identity is available in. */
union IdentitySettingLifecycle {
  string,

  /** The identity is not available to the sandbox. */
  None: "None",

  /** The identity is available only during the main sandbox lifecycle. */
  Main: "Main",

  /** The identity is available throughout the sandbox lifecycle. */
  All: "All",
}

/** Actions applied to matching source addresses. */
union IpAccessControlAction {
  string,

  /** Allows traffic from matching addresses. */
  Allow: "Allow",

  /** Denies traffic from matching addresses. */
  Deny: "Deny",
}

/** Linux capabilities to add or drop from the container's default capability set. */
model LinuxCapabilities {
  /** Linux capabilities added to the container. */
  add?: string[];

  /** Linux capabilities removed from the container. */
  drop?: string[];
}

/** Defines a single column in a custom log output schema. Polymorphic on `kind` discriminator: `"Value"` or `"Ref"`. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The existing API requires this polymorphic log-column union."
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union LogColumnDef {
  /** A column containing a static value. */
  Value: ValueLogColumnDef,

  /** A column resolved from a sandbox attribute. */
  Ref: RefLogColumnDef,
}

/** A column whose value is resolved from a well-known Azure Container Apps Sandbox attribute at runtime. */
model RefLogColumnDef {
  /** Identifies this as a referenced log column. */
  kind?: "Ref";

  /** The Azure Container Apps Sandbox attribute to resolve. */
  refName: LogColumnRef;
}

/** A column whose value is a literal string provided by the partner. */
model ValueLogColumnDef {
  /** Identifies this as a static-value log column. */
  kind?: "Value";

  /** The static value injected into every log record. */
  value: string;
}

/** Well-known Azure Container Apps Sandbox attributes that can be referenced by custom columns. */
union LogColumnRef {
  string,

  /** Inserts the log message content. */
  LogContent: "LogContent",

  /** Inserts the log stream name. */
  LogStream: "LogStream",

  /** Inserts the sandbox identifier. */
  SandboxId: "SandboxId",

  /** Inserts the Azure region. */
  Region: "Region",

  /** Inserts the container name. */
  ContainerName: "ContainerName",
}

/** Kubernetes-style memory resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
scalar MemoryQuantity extends string;

/** User-provided container name within a pod. DNS label format: lowercase alphanumeric + hyphens, 1-63 chars, must start and end with alphanumeric. */
scalar PodContainerName extends string;

/** Pod-level security context — applies to all containers unless overridden at the container level. Follows Kubernetes pod securityContext semantics. */
model PodSecurityContext {
  /** The default user ID for pod containers. */
  runAsUser?: int32;

  /** The default group ID for pod containers. */
  runAsGroup?: int32;

  /** Whether pod containers must run as non-root users. */
  runAsNonRoot?: boolean;

  /** Supplemental group IDs assigned to pod processes. */
  supplementalGroups?: int32[];

  /** The group ID applied to mounted volumes. */
  fsGroup?: int32;

  /** When ownership is changed on mounted volumes. */
  fsGroupChangePolicy?: FsGroupChangePolicy;
}

/** Ways a sandbox port can be activated. */
union PortActivationMode {
  string,

  /** The port is activated explicitly. */
  Manual: "Manual",

  /** The port activates when traffic arrives. */
  OnDemand: "OnDemand",
}

/** Specifies the HTTP protocol version to use when forwarding requests to a port. */
union PortProtocol {
  string,

  /** Forwards traffic using HTTP/1.1. */
  Http: "Http",

  /** Forwards traffic using HTTP/2. */
  Http2: "Http2",
}

/** Preset configurations available for a sandbox. */
union PresetSandboxType {
  string,

  /** Does not apply a preset sandbox configuration. */
  None: "None",

  /** Applies the GitHub Copilot sandbox preset. */
  GitHubCopilot: "GitHubCopilot",

  /** Applies the Claude sandbox preset. */
  Claude: "Claude",
}

/** Exec probe handler that runs a command in the container. */
model ProbeExecAction {
  /** The command and arguments executed by the probe. */
  command: string[];
}

/** HTTP GET probe handler executed from inside the container VM. */
model ProbeHttpGetAction {
  /** The port used by the HTTP probe. */
  port: SandboxPortNumber;

  /** The HTTP request path. */
  path?: string;

  /** The host header sent by the probe. */
  host?: string;

  /** The URI scheme used by the probe. */
  scheme?: string;

  /** Additional HTTP headers sent by the probe. */
  httpHeaders?: ProbeHttpHeader[];
}

/** HTTP header sent with a probe HTTP GET request. */
model ProbeHttpHeader {
  /** The HTTP header name. */
  name: string;

  /** The HTTP header value. */
  value: string;
}

/** TCP socket probe handler that checks whether a port accepts connections. */
model ProbeTcpSocketAction {
  /** The port checked by the TCP probe. */
  port: SandboxPortNumber;

  /** The host checked by the TCP probe. */
  host?: string;
}

/** A project identifier. */
scalar ProjectId extends string;

/** Reference to an agent identity for assigning to a sandbox. */
model SandboxAgentIdentityRef {
  /** Tenant ID where the agent identity is registered. */
  tenantId: TenantId;

  /** Unique identifier for the agent identity. */
  agentId: string;
}

/** Automatic deletion settings for a sandbox. */
model SandboxAutoDeletePolicy {
  /** Whether automatic deletion is enabled. */
  enabled: boolean;

  /** The deletion delay in days. */
  deleteIntervalInDays?: int32;

  /** The deletion delay in seconds. */
  deleteIntervalInSeconds?: int64;

  /** The event that starts the deletion timer. */
  trigger?: AutoDeleteTrigger;
}

/** Automatic suspension settings for a sandbox. */
model SandboxAutoSuspendPolicy {
  /** Whether automatic suspension is enabled. */
  enabled: boolean;

  /** The idle interval before suspension. */
  interval?: int32;

  /** How sandbox state is preserved during suspension. */
  mode?: SandboxSuspendMode;
}

/** Automatic suspension and deletion settings for a sandbox. */
model SandboxLifecyclePolicy {
  /** Automatic suspension settings. */
  autoSuspendPolicy: SandboxAutoSuspendPolicy;

  /** Automatic deletion settings. */
  autoDeletePolicy: SandboxAutoDeletePolicy;
}

/** Represents a valid TCP/UDP port number on an instance (inside the VM). */
@minValue(1)
@maxValue(65535)
scalar SandboxPortNumber extends int32;

/** Possible runtime states of a sandbox. */
union SandboxState {
  string,

  /** The sandbox is running. */
  Running: "Running",

  /** The sandbox is stopped. */
  Stopped: "Stopped",

  /** The sandbox is idle. */
  Idle: "Idle",

  /** The sandbox is being created. */
  Creating: "Creating",

  /** The sandbox is stopping. */
  Stopping: "Stopping",

  /** The sandbox could not be stopped. */
  StopFailed: "StopFailed",
}

/** Details recorded when a sandbox enters the stopped state. */
model SandboxStateDetails {
  /** Why the sandbox is stopped. */
  stoppedReason: StoppedReason;

  /** Wall-clock time the stop transition was recorded. */
  stoppedAt: utcDateTime;
}

/** Ways to preserve a suspended sandbox. */
union SandboxSuspendMode {
  string,

  /** Preserves the sandbox in memory. */
  Memory: "Memory",

  /** Persists the sandbox state to disk. */
  Disk: "Disk",

  /** Does not preserve sandbox state. */
  None: "None",
}

/** Seccomp profile configuration for a container. */
model SeccompProfile {
  /** The seccomp profile type. */
  type: SeccompProfileType;
}

/** Seccomp profile type for container syscall filtering. */
union SeccompProfileType {
  string,

  /** Uses the container runtime's default seccomp profile. */
  RuntimeDefault: "RuntimeDefault",

  /** Disables seccomp filtering. */
  Unconfined: "Unconfined",
}

/** Reason a sandbox entered the stopped state. */
union StoppedReason {
  string,

  /** The sandbox stopped after becoming idle. */
  Idle: "Idle",

  /** The sandbox was administratively disabled. */
  Disabled: "Disabled",

  /** The sandbox was stopped by a user request. */
  UserStopped: "UserStopped",
}

/** Kubernetes-style storage/disk resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
scalar StorageQuantity extends string;

/** Authentication method for a TDS egress connection. */
union TdsAuthKind {
  string,

  /** Uses a SQL username and password. */
  SqlPassword: "SqlPassword",

  /** Uses a Microsoft Entra access token. */
  EntraToken: "EntraToken",
}

/** A named credential used by TDS egress rules. */
model TdsCredential {
  /** The credential name referenced by rules. */
  name: string;

  /** The authentication method. */
  kind: TdsAuthKind;

  /** The SQL username. */
  username?: string;

  /** A reference to the stored password or token. */
  secretRef?: EgressPolicySecretRef;
}

/** The allow or deny action applied by a TDS rule. */
model TdsEgressAction {
  /** The action type. */
  type: EgressPolicyActionType;

  /** The credential used for an allowed connection. */
  credential?: string;
}

/** Match criteria for a TDS egress rule. All specified criteria must match. */
model TdsEgressMatch {
  /** The database server host pattern. */
  host: string;

  /** The database names to match. */
  databases?: string[];
}

/** A TDS egress rule evaluated in order until the first match. */
model TdsEgressRule {
  /** The rule name. */
  name: string;

  /** The database traffic matched by the rule. */
  match: TdsEgressMatch;

  /** The static action applied to matching traffic. */
  action?: TdsEgressAction;

  /** A webhook that dynamically determines the action. */
  hookRef?: EgressPolicyHookRef;
}

/** TDS database egress rules and credentials. */
model TdsEgressSection {
  /** The action applied when no TDS rule matches. */
  defaultAction: EgressPolicyActionType;

  /** Named credentials referenced by TDS rules. */
  credentials: TdsCredential[];

  /** TDS rules evaluated in order. */
  rules: TdsEgressRule[];
}

/** Secret-based authentication for an Application Insights endpoint. */
model TelemetryApplicationInsightsAuth {
  /** Reference to a user-managed secret containing key-value pairs. */
  secretId: string;

  /** The key within the secret whose value is the Application Insights connection string. */
  secretKey: string;
}

/** Managed identity authentication for a telemetry endpoint. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The existing API requires this polymorphic telemetry-authentication union."
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union TelemetryAuth {
  /** User-assigned managed identity authentication. */
  ManagedIdentity: TelemetryManagedIdentityAuth,

  /** System-assigned managed identity authentication. */
  SystemAssignedManagedIdentity: TelemetrySystemAssignedManagedIdentityAuth,
}

/** User-assigned managed identity authentication for Log Analytics. */
model TelemetryManagedIdentityAuth {
  /** Identifies managed identity authentication. */
  kind?: "ManagedIdentity";

  /** Azure resource ID of a user-assigned managed identity. */
  identity: string;
}

/** System-assigned managed identity authentication for Log Analytics. */
model TelemetrySystemAssignedManagedIdentityAuth {
  /** Identifies system-assigned managed identity authentication. */
  kind?: "SystemAssignedManagedIdentity";
}

/** Configures telemetry collection for a sandbox. Passed in sandbox creation requests. */
model TelemetryConfig {
  /** One or more telemetry endpoints to route data to. */
  endpoints: TelemetryEndpoint[];

  /** Optional metrics collection interval in seconds. Must be &gt;= 2. Defaults to 15 if not specified. */
  @minValue(2)
  metricsIntervalSeconds?: int32;
}

/** Specifies which category of telemetry data to route to an endpoint. */
union TelemetryData {
  string,

  /** Routes container standard output and standard error logs. */
  ContainerStdoutStderr: "ContainerStdoutStderr",

  /** Routes OpenTelemetry data emitted by containers. */
  ContainerOtel: "ContainerOtel",

  /** Routes sandbox metrics. */
  Metrics: "Metrics",

  /** Routes network egress decision logs. */
  NetworkEgressDecisions: "NetworkEgressDecisions",
}

/** Base type for telemetry endpoint configuration. Polymorphic on `kind` discriminator. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The existing API requires this polymorphic telemetry-endpoint union."
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union TelemetryEndpoint {
  /** An OpenTelemetry Protocol endpoint. */
  OTLP: OtlpTelemetryEndpoint,

  /** An Application Insights endpoint. */
  ApplicationInsights: ApplicationInsightsTelemetryEndpoint,

  /** A Log Analytics endpoint using the Logs Ingestion API. */
  LogAnalytics: LogAnalyticsTelemetryEndpoint,

  /** A Log Analytics endpoint using the Data Collector API. */
  LogAnalyticsLegacy: LogAnalyticsLegacyTelemetryEndpoint,
}

/** Application Insights telemetry endpoint configuration. Uses the connection string to derive the ingestion and live-metrics endpoints. */
model ApplicationInsightsTelemetryEndpoint {
  /** Identifies an Application Insights endpoint. */
  kind?: "ApplicationInsights";

  /** Authentication used for Application Insights. */
  auth: TelemetryApplicationInsightsAuth;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /** Custom columns added to forwarded log records. */
  columns?: Record<LogColumnDef>;

  /** Whether to add top-level JSON fields from container logs as columns. */
  dynamicJsonColumns?: boolean = false;
}

/** Log Analytics Legacy (Data Collector API) telemetry endpoint configuration. */
model LogAnalyticsLegacyTelemetryEndpoint {
  /** Identifies a legacy Log Analytics endpoint. */
  kind?: "LogAnalyticsLegacy";

  /** The Log Analytics workspace ID. */
  workspaceId: string;

  /** The custom log table name (e.g., "ContainerAppConsoleLogs"). */
  tableName: string;

  /** Secret containing the Log Analytics shared key. */
  auth: TelemetrySecretReference;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /** Custom columns added to forwarded log records. */
  columns?: Record<LogColumnDef>;

  /** Whether to add top-level JSON fields from container logs as columns. */
  dynamicJsonColumns?: boolean = false;
}

/** Azure Monitor Log Analytics endpoint configuration. */
model LogAnalyticsTelemetryEndpoint {
  /** Identifies a Log Analytics endpoint. */
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

  /** Custom columns added to forwarded log records. */
  columns?: Record<LogColumnDef>;

  /** Whether to add top-level JSON fields from container logs as columns. */
  dynamicJsonColumns?: boolean = false;
}

/** OTLP telemetry endpoint configuration. */
model OtlpTelemetryEndpoint {
  /** Identifies an OTLP endpoint. */
  kind?: "OTLP";

  /** OTLP endpoint URL (e.g., "https://customer.monitor.azure.com/otlp"). */
  endpoint: url;

  /** `Grpc` or `Http`. */
  protocol: TelemetryProtocol;

  /** Optional headers used to authenticate to the endpoint. */
  auth?: TelemetryHeaderAuth;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /** Custom columns added to forwarded log records. */
  columns?: Record<LogColumnDef>;

  /** Whether to add top-level JSON fields from container logs as columns. */
  dynamicJsonColumns?: boolean = false;
}

/** HTTP header authentication for an OTLP telemetry endpoint. */
model TelemetryHeaderAuth {
  /** HTTP header to inject (e.g., "x-api-key", "Authorization"). */
  headerName: string;

  /** Reference to a user-managed secret containing key-value pairs. */
  secretId: string;

  /** The key within the secret whose value should be used as the header value. */
  secretKey: string;
}

/** Specifies the protocol used to send telemetry data to an OTLP endpoint. */
union TelemetryProtocol {
  string,

  /** Sends telemetry using OTLP over gRPC. */
  Grpc: "Grpc",

  /** Sends telemetry using OTLP over HTTP. */
  Http: "Http",
}

/** Base type for telemetry endpoint secret references. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The existing API requires this polymorphic telemetry-secret union."
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union TelemetrySecretReference {
  /** References a sandbox-group GlobalSecret by identifier and key. */
  GlobalSecret: TelemetrySandboxGroupSecretRef,

  /** References a secret in the parent artifact app's local secret bundle. */
  AppSecret: TelemetryAppSecretRef,
}

/** Reference to a sandbox-group GlobalSecret. */
model TelemetrySandboxGroupSecretRef {
  /**
   * Secret-reference kind. Optional for compatibility with legacy payloads, which predate the
   * discriminator and are always interpreted as this shape.
   *
   * The value stays "GlobalSecret" while the model is named for its scope: the server matches on
   * this exact literal (Adc.Contracts TelemetrySecretReferenceConverter), so changing it would be
   * a wire break. The model name and the discriminator diverging here is deliberate.
   */
  kind?: "GlobalSecret";

  /** Identifier of the sandbox-group secret. */
  secretId: string;

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

/** A Microsoft Entra tenant identifier. */
scalar TenantId extends string;

/** Controls the scope of TLS inspection for the egress proxy on a per-sandbox basis. */
union TrafficInspection {
  string,

  /** Uses the legacy inspection behavior. */
  Legacy: "Legacy",

  /** Inspects supported HTTP traffic. */
  Partial: "Partial",

  /** Inspects all supported egress traffic. */
  Full: "Full",

  /** Disables traffic inspection. */
  None: "None",
}

/** A TCP or UDP egress rule evaluated in order until the first match. */
model TransportEgressRule {
  /** The allow or deny action. */
  action: EgressPolicyActionType;

  /** The transport protocol to match. */
  protocol: TransportProtocol;

  /** The destination IPv4 CIDR to match. */
  destination: string;

  /** The destination port to match. */
  port: int32;
}

/** TCP and UDP egress rules for a sandbox. */
model TransportEgressSection {
  /** The action applied when no transport rule matches. */
  defaultAction: EgressPolicyActionType;

  /** Transport rules evaluated in order. */
  rules: TransportEgressRule[];
}

/** L4 transport protocol for an L3 egress rule. */
union TransportProtocol {
  string,

  /** Matches TCP traffic. */
  Tcp: "Tcp",

  /** Matches UDP traffic. */
  Udp: "Udp",
}

/** A volume name. */
scalar VolumeName extends string;
