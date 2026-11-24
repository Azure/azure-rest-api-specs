import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../agents/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

const SessionComputeRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.session_compute_v1_preview],
};

// ---------------------------------------------------------------------------
// Request parameter models
// ---------------------------------------------------------------------------

// Path parameters identifying a compute of a hosted agent session.
alias SessionComputePathParams = {
  /** The name of the hosted agent. */
  @path agent_name: string;

  /** The session ID, as returned by the session create operation. */
  @path session_id: string;

  /**
   * The compute ID. Only `default` exists today; any other value returns `404 compute_not_found`.
   * Kept as an open string so that clients keep working when sessions support more than one compute.
   */
  @path compute_id: string;
};

// Path parameters identifying an exposed port on a session compute.
alias SessionComputePortPathParams = {
  ...SessionComputePathParams;

  /** The port number inside the compute, between 1024 and 65535. Port 8088 is reserved. */
  @path
  @minValue(1024)
  @maxValue(65535)
  port: int32;
};

// ---------------------------------------------------------------------------
// Session compute resource
// ---------------------------------------------------------------------------

@doc("""
  The provider that backs a session compute. Open string: new providers can be added without a version bump.
  Clients must treat unknown values as an unknown provider and rely on `capabilities` instead of `provider`.
  """)
@removed(Versions.v1)
union SessionComputeProvider {
  string,

  @doc("Azure Container Apps sandboxes.")
  aca_sandboxes: "aca_sandboxes",

  @doc("Customer-managed AKS. No compute capabilities are supported today.")
  byo_aks: "byo_aks",
}

@doc("The state of a session compute. Extensible; clients must tolerate unknown values.")
@removed(Versions.v1)
union SessionComputeState {
  string,
  provisioning: "provisioning",
  running: "running",
  stopped: "stopped",
  suspended: "suspended",
  failed: "failed",
  deleted: "deleted",
}

@doc("""
  The operations available on a session compute. Combines provider support with the agent version opt-in
  (`definition.compute_primitives`) for `exec` and `ports`.
  Clients should branch on these values rather than on `provider`.
  """)
@removed(Versions.v1)
model SessionComputeCapabilities {
  @doc("Whether command execution (`:exec` and `exec/stream`) is available.")
  exec: boolean;

  @doc("Whether ports can be exposed and proxied.")
  ports: boolean;
}

@doc("""
  The type of a session compute volume. `data_disk` is a provider block volume (ext4) that is POSIX and
  exclusively attached. `blob` is a platform-created blob container mounted with blobfuse2; it is not a POSIX
  filesystem and writes are committed on close or flush through a local cache. New types may be added.
  """)
@removed(Versions.v1)
union SessionComputeVolumeType {
  string,

  @doc("A provider block volume (ext4).")
  data_disk: "data_disk",

  @doc("A platform-created blob container mounted with blobfuse2.")
  blob: "blob",
}

@doc("A volume mounted into a session compute.")
@removed(Versions.v1)
model SessionComputeVolume {
  @doc("The volume name.")
  @pattern("^[a-z0-9]([-a-z0-9]{0,30}[a-z0-9])?$")
  @example("work")
  name: string;

  @doc("The volume type.")
  type: SessionComputeVolumeType;

  @doc("The absolute mount path inside the compute.")
  @example("/work")
  mount_path: string;

  @doc("Whether the volume is mounted read-only.")
  read_only: boolean;

  @doc("For `data_disk` only: the disk capacity as a Kubernetes quantity (for example, `20Gi`).")
  @example("20Gi")
  size?: string | null;

  @doc("""
    Whether the backing store is re-attached to the next instance with the data it held when the previous
    instance stopped. For `blob`, this applies to the container, not the local cache: writes still in the cache
    at a forced stop or platform eviction may be lost. Stopping the session stops the instance gracefully first.
    """)
  persists_across_restart: boolean;
}

@doc("A compute attached to a hosted agent session.")
@extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
@removed(Versions.v1)
model SessionCompute {
  @doc("The object type, which is always `session.compute`.")
  object: "session.compute";

  @doc("The compute identifier.")
  @example("default")
  id: string;

  @doc("The identifier of the owning session.")
  agent_session_id: string;

  @doc("The provider that backs the compute.")
  provider: SessionComputeProvider;

  @doc("The current state of the compute.")
  state: SessionComputeState;

  @doc("The operations available on the compute.")
  capabilities: SessionComputeCapabilities;

  @doc("""
    The resolved volume layout of this compute, including the implicit `home` data disk. Bound to the agent
    version at session create; not writable through this API.
    """)
  @visibility(Lifecycle.Read)
  @maxItems(4)
  volumes: SessionComputeVolume[];

  @doc("The Unix timestamp (in seconds) when the compute was created.")
  @encode("unixTimestamp", int64)
  created_at: utcDateTime;

  @doc("The Unix timestamp (in seconds) when the compute was last accessed.")
  @encode("unixTimestamp", int64)
  last_accessed_at: utcDateTime;

  @doc("The Unix timestamp (in seconds) when the compute stopped. Present only when the compute is stopped.")
  @encode("unixTimestamp", int64)
  stopped_at?: utcDateTime | null;
}

// ---------------------------------------------------------------------------
// Exec
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "C# name is set in sdk-csharp-azure-ai-projects-agents/client.tsp"
@doc("""
  A flat bag of provider-specific options. At most 16 keys, each 1–64 characters. Keys are validated
  fail-closed against the provider's known-key set before any provider call; an unknown key returns
  `400 compute_invalid_provider_options`. Every known-key set is empty today. Values are never echoed in errors.
  """)
@removed(Versions.v1)
model SessionComputeProviderOptions {
  ...Record<unknown>;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "C# name is set in sdk-csharp-azure-ai-projects-agents/client.tsp"
@doc("Request to run a one-shot shell command inside a session compute.")
@removed(Versions.v1)
model SessionComputeExecRequest {
  @doc("The shell command line executed inside the compute. Maximum 32 KiB.")
  @maxLength(32768)
  @example("ls -la /home")
  command: string;

  @doc("""
    The wall-clock budget in seconds. On expiry the call returns `200` with `timed_out: true`; the command may
    still be running inside the compute and side effects are not rolled back.
    """)
  @minValue(1)
  @maxValue(120)
  timeout_seconds?: int32 = 60;

  @doc("Optional provider-specific options.")
  provider_options?: SessionComputeProviderOptions;
}

@doc("The result of a one-shot command run inside a session compute.")
@extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
@removed(Versions.v1)
model SessionComputeExecResult {
  @doc("The object type, which is always `session.compute.exec_result`.")
  object: "session.compute.exec_result";

  @doc("The process exit code; `null` only when `timed_out` is `true`.")
  exit_code: int32 | null;

  @doc("""
    Whether the command did not finish within `timeout_seconds`. The command may still be running inside the
    compute, and `stdout` and `stderr` are omitted. Callers must not blindly retry.
    """)
  timed_out: boolean;

  @doc("The standard output of the command, capped at 262144 UTF-16 characters.")
  stdout?: string | null;

  @doc("The standard error of the command, capped at 262144 UTF-16 characters.")
  stderr?: string | null;

  @doc("The command duration in milliseconds.")
  duration_ms: int64;

  @doc("Whether `stdout` was truncated.")
  stdout_truncated: boolean;

  @doc("Whether `stderr` was truncated.")
  stderr_truncated: boolean;
}

// ---------------------------------------------------------------------------
// Ports
// ---------------------------------------------------------------------------

@doc("The application protocol of an exposed port.")
@removed(Versions.v1)
union SessionComputePortProtocol {
  string,

  @doc("HTTP/1.1.")
  http: "http",

  @doc("HTTP/2.")
  http2: "http2",
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "C# name is set in sdk-csharp-azure-ai-projects-agents/client.tsp"
@doc("Request to expose a port of a session compute through the Foundry proxy. The port number is taken from the path.")
@removed(Versions.v1)
model SessionComputePortRequest {
  @doc("The port name. Defaults to `port-<n>` when omitted. Must be unique per compute.")
  @maxLength(32)
  @pattern("^[a-z0-9]([a-z0-9-]{0,30}[a-z0-9])?$")
  name?: string;

  @doc("The application protocol.")
  protocol?: SessionComputePortProtocol = SessionComputePortProtocol.http;

  @doc("Optional provider-specific options.")
  provider_options?: SessionComputeProviderOptions;
}

@doc("A port exposed from a session compute through the Foundry proxy.")
@extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
@removed(Versions.v1)
model SessionComputePort {
  @doc("The object type, which is always `session.compute.port`.")
  object: "session.compute.port";

  @doc("The port number inside the compute.")
  port: int32;

  @doc("The port name.")
  name: string;

  @doc("The application protocol.")
  protocol: SessionComputePortProtocol;

  @doc("""
    The Foundry proxy base URL, ending in `/ports/{port}/proxy/`, on the same endpoint (host and path prefix)
    the caller used. Append application paths and query strings. Never a provider URL.
    Call it directly with a Foundry bearer token and the `Foundry-Features` header; it takes no `api-version`.
    Every HTTP method, WebSocket upgrades and SSE are forwarded to the application unchanged, except that
    the caller's `Authorization` header is removed. Applications must honor `X-Forwarded-Prefix`,
    `X-Forwarded-Host` and `X-Forwarded-Proto`.
    """)
  url: url;
}

// ---------------------------------------------------------------------------
// Egress policy
// ---------------------------------------------------------------------------

@doc("""
  The egress policy mode of a session compute.
  * `open`: no egress restriction is configured.
  * `inspected`: traffic is inspected (TLS termination) but not blocked.
  * `audit`: rules are evaluated and violations are logged; nothing is blocked.
  * `enforced`: rules are evaluated and violations are blocked.
  * `unknown`: the provider returned an unrecognized or pre-policy configuration. Treat as no information, not as open.
  """)
@removed(Versions.v1)
union SessionComputeEgressMode {
  string,
  open: "open",
  inspected: "inspected",
  audit: "audit",
  enforced: "enforced",
  `unknown`: "unknown",
}

@doc("The default action for egress traffic that matches no rule.")
@removed(Versions.v1)
union SessionComputeEgressAction {
  string,
  allow: "allow",
  deny: "deny",
}

@doc("How much egress traffic is inspected.")
@removed(Versions.v1)
union SessionComputeTrafficInspection {
  string,
  partial: "partial",
  full: "full",
}

@doc("Who manages the egress policy.")
@removed(Versions.v1)
union SessionComputeEgressManagedBy {
  string,
  platform: "platform",
  agent_definition: "agent_definition",
}

@doc("A summary of the egress policy in force for a session compute. Rule patterns are never returned.")
@extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
@removed(Versions.v1)
model SessionComputeEgressPolicy {
  @doc("The object type, which is always `session.compute.egress_policy`.")
  object: "session.compute.egress_policy";

  @doc("The compute identifier.")
  compute_id: string;

  @doc("The egress policy mode.")
  mode: SessionComputeEgressMode;

  @doc("The default action for egress traffic that matches no rule.")
  default_action?: SessionComputeEgressAction | null;

  @doc("How much egress traffic is inspected. Omitted when the provider value is unrecognized.")
  traffic_inspection?: SessionComputeTrafficInspection | null;

  @doc("The number of egress rules.")
  rule_count: int32;

  @doc("Who manages the egress policy.")
  managed_by: SessionComputeEgressManagedBy;
}

// ---------------------------------------------------------------------------
// Log stream
// ---------------------------------------------------------------------------

@doc("A single Server-Sent Event frame emitted by the session compute log stream.")
@removed(Versions.v1)
model SessionComputeLogEvent {
  @doc("The SSE event type. Currently `log`; clients should ignore unrecognized event types.")
  @example("log")
  event: SessionLogEventType;

  @doc("A single log line.")
  @example("[10:12:04] harness: starting agent")
  data: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "C# name is set in sdk-csharp-azure-ai-projects-agents/client.tsp"
@doc("The response that switches the HTTP connection to the `exec.v1` WebSocket protocol.")
@removed(Versions.v1)
model SessionComputeExecStreamUpgradeResponse {
  @doc("Switches the HTTP connection to the WebSocket protocol.")
  @statusCode
  status_code: 101;

  @doc("The negotiated WebSocket subprotocol.")
  @header("Sec-WebSocket-Protocol")
  protocol: "exec.v1";

  @doc("The response body (101 Switching Protocols). The `exec.v1` messages flow over the upgraded connection.")
  @body
  response: unknown;
}
