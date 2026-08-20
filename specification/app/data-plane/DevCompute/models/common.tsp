using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

/** The service API version. */
model ApiVersionParameter {
  /** The API version to use for this operation. */
  @madeRequired(Versions.v2026_09_01)
  @query("api-version")
  apiVersion: Versions;
}

/** A signed integer represented as a JSON string. */
@pattern("^-?(?:0|[1-9]\\d*)$")
scalar IntegerString extends string;

/** A number represented as a JSON string. */
@pattern("^-?(?:0|[1-9]\\d*)(?:\\.\\d+)?(?:[eE][+-]?\\d+)?$")
scalar NumberString extends string;

/** A 32-bit integer accepted as either a JSON number or string. */
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "A transparent union preserves the source OpenAPI numeric-or-string schema at each usage site."
alias Int32OrString = int32 | IntegerString;

/** A 64-bit integer accepted as either a JSON number or string. */
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "A transparent union preserves the source OpenAPI numeric-or-string schema at each usage site."
alias Int64OrString = int64 | IntegerString;

/** An unsigned 16-bit integer accepted as either a JSON number or string. */
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "A transparent union preserves the source OpenAPI numeric-or-string schema at each usage site."
alias UInt16OrString = uint16 | IntegerString;

/** An unsigned 32-bit integer accepted as either a JSON number or string. */
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "A transparent union preserves the source OpenAPI numeric-or-string schema at each usage site."
alias UInt32OrString = uint32 | IntegerString;

/** An unsigned 64-bit integer accepted as either a JSON number or string. */
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "A transparent union preserves the source OpenAPI numeric-or-string schema at each usage site."
alias UInt64OrString = uint64 | IntegerString;

/** A double-precision number accepted as either a JSON number or string. */
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "A transparent union preserves the source OpenAPI numeric-or-string schema at each usage site."
alias Float64OrString = float64 | NumberString;

/** A nullable 32-bit integer accepted as either a JSON number or string. */
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "A transparent union preserves the source OpenAPI nullable numeric-or-string schema at each usage site."
alias NullableInt32OrString = null | int32 | IntegerString;

/** A nullable 64-bit integer accepted as either a JSON number or string. */
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "A transparent union preserves the source OpenAPI nullable numeric-or-string schema at each usage site."
alias NullableInt64OrString = null | int64 | IntegerString;

/** A nullable array of 32-bit integers accepted as JSON numbers or strings. */
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "A transparent union preserves the source OpenAPI nullable array schema at each usage site."
alias NullableInt32OrStringArray = null | Int32OrString[];

/** ARM resource ID for an Azure user-assigned managed identity. */
scalar ArmUserAssignedIdentityId;

union AutoDeleteTrigger {
  "AfterSuspend",
  "AfterCreation",
  null,
}

/** Represents a base64-encoded value. */
scalar Base64;

scalar Bytes;

model EntityTagHeaderValue {
  tag?: StringSegment;
  isWeak?: boolean;
}

union FsGroupChangePolicy {
  "OnRootMismatch",
  "Always",
  "None",
  null,
}

model GenerateConsentLinkRequest {
  redirectUrl?: null | string;
}

model GenerateConsentLinkResponse {
  consentLink: string;
}

union IpAccessControlAction {
  "Allow",
  "Deny",
}

/** A single IP access control rule. */
model IpAccessControlRuleView {
  name: string;
  action: IpAccessControlAction;
  priority: Int32OrString;
  sourceCidrs: unknown[];
}

/**
 * IP access control configuration for a port.
 * Rules are evaluated in priority order; first match wins.
 */
model IpAccessControlView {
  defaultAction: IpAccessControlAction;
  rules?: IpAccessControlRuleView[];
}

/** Linux capabilities to add or drop from the container's default capability set. */
model LinuxCapabilities {
  add?: null | string[];
  drop?: null | string[];
}

/** Log output format for streaming endpoints. */
scalar LogFormat extends int32;

scalar MegaBytes;

/** Represents a performance span for waterfall visualization. */
model PerfTrace {
  /** Base64-encoded span ID (12-char). */
  id: Base64;

  @oneOf parentId: null | Base64;

  /** Unix timestamp in milliseconds when the span started. */
  startMs: Int64OrString;

  /** Span duration in milliseconds. */
  durationMs: Int64OrString;

  /** Descriptive name (e.g., "NodeAgent.InjectVmm"). */
  name: string;
}

model ProblemDetails {
  type?: null | string;
  title?: null | string;
  status?: NullableInt32OrString;
  detail?: null | string;
  instance?: null | string;
}

/** An error response with an HTTP status code and problem details body. */
@error
model ErrorResponse<Status extends int32> {
  /** HTTP response status code. */
  @statusCode statusCode: Status;

  /** Error response content type. */
  @header contentType: "text/plain" | "application/json" | "text/json";

  /** Error response body. */
  @body body: ProblemDetails;
}

/** Response with a 500 status code and no guaranteed response body. */
@error
@doc("Server error")
model InternalServerErrorNoBody {
  /** HTTP response status code. */
  @statusCode statusCode: 500;
}

/** Response with a 503 status code and no guaranteed response body. */
@error
@doc("Service unavailable.")
@removed(Versions.v2026_09_01)
model ServiceUnavailableNoBody {
  /** HTTP response status code. */
  @statusCode statusCode: 503;
}

/** Seccomp profile configuration for a container. */
model SeccompProfile {
  type: SeccompProfileType;
}

/** Seccomp profile type for container syscall filtering. */
union SeccompProfileType {
  "RuntimeDefault",
  "Unconfined",
}

/** Single stateful-TCP (TDS) connection audit entry (one lifecycle phase of a connection). */
model StatefulTcpEntryView {
  /** When this phase event was emitted. */
  timestamp: utcDateTime;

  /** Lifecycle phase: "Established" or "Closed". */
  phase?: null | string;

  /** Connection outcome (Connected, PolicyDenied, LoginFailed, ...). */
  outcome?: null | string;

  /** Connector type (e.g. "AzureSql"). */
  connectorType?: null | string;

  /** Target backend hostname. */
  server?: null | string;

  /** Target backend port. */
  port?: NullableInt32OrString;

  /** Target database (informational). */
  database?: null | string;

  /**
   * SQL login used after proxy injection, masked to a prefix before it reaches this
   *             customer-facing view (never the connector's full username).
   */
  proxyLoginName?: null | string;

  /** Live client source IP of the sandbox connection. */
  sourceIp?: null | string;

  /** Short per-connection correlation id; identical across a connection's two phase entries. */
  correlationId?: null | string;

  /** Bytes received from the sandbox (final only on the Closed phase). */
  bytesIn?: Int64OrString;

  /** Bytes sent to the backend (final only on the Closed phase). */
  bytesOut?: Int64OrString;

  /** Elapsed time from accept to this phase, in milliseconds. */
  durationMs?: Int64OrString;

  /** Optional failure detail when the outcome is not Connected. */
  failureReason?: null | string;

  /** When the connection was accepted (identical across both phases). */
  startedAt?: utcDateTime;
}

/**
 * Reason a sandbox is in SandboxState.Stopped. Carried inside
 * SandboxStateDetails. Distinguishes operator policy (StoppedReason.Disabled) from
 * system-driven idle suspends (StoppedReason.Idle) and user-initiated stops
 * (StoppedReason.UserStopped). Used by the OnDemand auto-resume gate: only StoppedReason.Disabled
 * blocks auto-resume.
 */
union StoppedReason {
  "Idle",
  "Disabled",
  "UserStopped",
}

scalar Stream extends bytes;

scalar TenantId;

/** Controls the scope of TLS inspection for the egress proxy on a per-sandbox basis. */
union TrafficInspection {
  "Legacy",
  "Partial",
  "Full",
  "None",
}

/** L4 transport protocol for an L3 egress rule. */
union TransportProtocol {
  "Tcp",
  "Udp",
}

model UpdatePolicyRulesRequest {
  policyRules: McpPolicyRule[];
  enabledToolGroups?: null | string[];
}

model ValidationWarningView {
  code: string;
  message: string;
}
