using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

/** Single egress decision entry. */
model EgressDecisionEntryView {
  /** Timestamp of the request. */
  timestamp: utcDateTime;

  /** Host header of the request. */
  host?: null | string;

  /** HTTP method (GET, POST, etc.). */
  method?: null | string;

  /** Request path. */
  path?: null | string;

  /** Scheme (http, https). */
  scheme?: null | string;

  @oneOf connectionId?: null | ConnectionId;

  /** Connection display name if this is an API Hub connector call. */
  connectionName?: null | string;

  /** Name of the egress policy rule that matched this request. */
  matchedRule?: null | string;
}

model EgressDecisionsResponseView {
  networkEgress: NetworkEgressDecisionsView;
  statefulTcp?: StatefulTcpEgressView;
  lastUpdated: utcDateTime;
}

/**
 * Per-rule override of upstream forward-proxy behavior. When a rule matches, the egress proxy either
 * egresses direct, relays through the rule's EgressForwardProxy? EgressPolicyRuleAction.ForwardProxy, or
 * inherits the sandbox-level `DefaultForward`.
 */
union EgressForwardMode {
  "default",
  "direct",
  "proxy",
}

/**
 * Upstream forward-proxy target: the proxy URL plus an optional inline PEM CA bundle that is trusted
 * (additively, on top of the system roots) when the proxy exposes an https listener. Shared by the
 * sandbox-level default forward and per-rule EgressForwardProxy? EgressPolicyRuleAction.ForwardProxy. The CA
 * is a public certificate, not secret. `Url` accepts http/https or a bare host:port (defaults to
 * http, i.e. no TLS to the proxy).
 */
model EgressForwardProxy {
  url: string;
  ca?: null | string;
}

model EgressHostRule {
  pattern: string;
  @oneOf action?: null | EgressPolicyAction;
}

union EgressPolicyAction {
  "Allow",
  "Deny",
}

/** Types of actions that an egress policy rule can take. */
union EgressPolicyActionType {
  "Allow",
  "Deny",
  "Transform",
  "Rewrite",
}

union EgressPolicyEnforcementMode {
  "Enforced",
  "Audit",
}

/** Types of header transformation operations. */
union EgressPolicyHeaderOperation {
  "Set",
  "Insert",
  "Remove",
}

/** Describes a header transformation to apply to matching requests. */
model EgressPolicyHeaderTransform {
  operation: EgressPolicyHeaderOperation;
  name: string;
  value?: null | string;
  @oneOf valueRef?: null | EgressPolicyValueRef;
}

/**
 * What the egress proxy should do when a webhook invocation fails (timeout, non-2xx,
 * invalid payload, SSRF-rejected URL, etc.).
 */
union EgressPolicyHookFailBehavior {
  "Deny",
  "Allow",
}

/**
 * Configures a webhook called at request time for rules whose static decision
 * cannot be expressed declaratively. When a rule's EgressPolicyHookRef? EgressPolicyRule.HookRef
 * is set, the egress proxy POSTs a request-context payload to string EgressPolicyHookRef.Endpoint and
 * applies the returned decision (Allow / Deny / Transform / Rewrite) in place of the
 * rule's static Action.
 *
 * EgressRuleRoutingMode EgressPolicyHookRef.RoutingMode controls how the egress proxy reaches the webhook
 * endpoint itself: EgressRuleRoutingMode.Vnet binds the outbound
 * socket to the sandbox's customer VNET IP (so the hook host can be a private
 * service reachable only from inside the VNET), EgressRuleRoutingMode.Platform
 * forces the node's platform egress (bypassing Swift SNAT), and
 * EgressRuleRoutingMode.Default uses the sandbox-level routing.
 * The webhook response itself can also carry a `routingMode` field that
 * overrides routing for the downstream upstream call when the decision is Rewrite.
 */
model EgressPolicyHookRef {
  endpoint: string;
  failBehavior?: EgressPolicyHookFailBehavior;
  requestHeaders?: null | string[];
  authHeaders?: null | EgressPolicyHeaderTransform[];
  timeoutMs?: NullableInt32OrString;
  routingMode?: EgressRuleRoutingMode;
}

/**
 * References a managed identity token to be fetched and injected as a header value.
 * EgressPolicyManagedIdentityType? EgressPolicyManagedIdentityRef.Type must be set to specify which identity to use.
 */
model EgressPolicyManagedIdentityRef {
  resource: string;
  format?: null | string;
  @oneOf type?: null | EgressPolicyManagedIdentityType;
  identityResourceId?: null | string;
}

union EgressPolicyManagedIdentityType {
  "SystemAssigned",
  "UserAssigned",
  null,
}

union EgressPolicyMatchScheme {
  "http",
  "https",
  "any",
  null,
}

/**
 * A single egress policy rule. Rules are evaluated in order; first match wins.
 * A rule has either a static EgressPolicyRuleAction? EgressPolicyRule.Action or a dynamic EgressPolicyHookRef? EgressPolicyRule.HookRef, never both.
 * When EgressPolicyHookRef? EgressPolicyRule.HookRef is set, the proxy calls the configured webhook at request time
 * and applies the returned decision in place of EgressPolicyRuleAction? EgressPolicyRule.Action.
 */
model EgressPolicyRule {
  name: null | string;
  match: EgressPolicyRuleMatch;
  @oneOf action?: null | EgressPolicyRuleAction;
  proxyActions?: null | string[];
  source?: null | string;
  @oneOf hookRef?: null | EgressPolicyHookRef;
}

/**
 * The action to take when a rule matches.
 * For Rewrite actions, Scheme/Host/Path specify the destination to rewrite the request to,
 * and EgressRuleRoutingMode EgressPolicyRuleAction.RoutingMode optionally overrides the sandbox-level egress routing for
 * this rule.
 */
model EgressPolicyRuleAction {
  type: EgressPolicyActionType;
  headers?: null | EgressPolicyHeaderTransform[];
  scheme?: null | string;
  host?: null | string;
  path?: null | string;
  routingMode?: EgressRuleRoutingMode;
  forward?: EgressForwardMode;
  @oneOf forwardProxy?: null | EgressForwardProxy;
}

/**
 * Request matching criteria for an egress policy rule.
 * All specified conditions must match (AND logic).
 * EgressPolicyMatchScheme? EgressPolicyRuleMatch.Scheme is nullable; null means the author did not specify a scheme and the
 * effective default is resolved per rule polarity at evaluation time. A static Deny defaults to
 * EgressPolicyMatchScheme.Any so a block is not silently scoped to HTTPS and bypassed
 * over HTTP. Every other rule — including positive rules (Allow / Transform / Rewrite) and dynamic
 * EgressPolicyHookRef? EgressPolicyRule.HookRef rules (whose outcome can be Allow/Transform/Rewrite or fail
 * open) — defaults to EgressPolicyMatchScheme.Https: on plaintext HTTP there is no SNI,
 * so matching uses the sandbox-controlled Host header with no certificate validation, and a positive
 * or hook match there would let a sandbox reach a non-allowlisted IP while spoofing an allowlisted
 * Host. Set EgressPolicyMatchScheme.Any explicitly to match both schemes, or
 * EgressPolicyMatchScheme.Http / EgressPolicyMatchScheme.Https to pin a
 * single scheme. For IP-based match hosts, scheme matching is ignored (no TLS certificate validation
 * applies to IPs anyway).bool? EgressPolicyRuleMatch.NormalizePath controls whether the request path is decoded and normalized
 * (encoded-slash decode, slash merging, and ./.. dot-segment removal) before it is
 * matched against string? EgressPolicyRuleMatch.Path. It defaults to enabled (null is treated as true)
 * to prevent path-confusion bypasses where an encoded path such as /allowed%2F.. matches an
 * allow rule but the upstream server resolves it to a different path. Set to false only for
 * upstreams that require the raw, un-normalized path.
 */
model EgressPolicyRuleMatch {
  host: string;
  path?: null | string;
  methods?: null | string[];
  @oneOf scheme?: null | EgressPolicyMatchScheme;
  normalizePath?: null | boolean;
}

/** References a secret stored via the Secrets API for header value injection. */
model EgressPolicySecretRef {
  secretId: string;
  secretKey?: null | string;
  format?: null | string;
}

/** A dynamic value reference for header transforms. Exactly one of the ref fields should be set. */
model EgressPolicyValueRef {
  @oneOf secretRef?: null | EgressPolicySecretRef;
  @oneOf managedIdentityRef?: null | EgressPolicyManagedIdentityRef;
}

/**
 * Per-rule override of how the egress proxy creates the upstream socket.
 * Today only honored on EgressPolicyActionType.Rewrite rules.
 */
union EgressRuleRoutingMode {
  "Default",
  "Vnet",
  "Platform",
}

model HttpEgressSection {
  defaultAction: EgressPolicyAction;
  hostRules?: EgressHostRule[];
  rules?: null | EgressPolicyRule[];
  trafficInspection?: TrafficInspection;
  enforcementMode?: EgressPolicyEnforcementMode;
  @oneOf defaultForward?: null | EgressForwardProxy;
}

/**
 * Defines a single column in a custom log output schema.
 * Polymorphic on `kind` discriminator: `"Value"` or `"Ref"`.
 */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union LogColumnDef {
  Value: LogColumnDefValueLogColumnDef,
  Ref: LogColumnDefRefLogColumnDef,
}

/** A column whose value is resolved from a well-known ADC attribute at runtime. */
model LogColumnDefRefLogColumnDef {
  kind?: "Ref";

  /** The ADC attribute to resolve. */
  refName: LogColumnRef;
}

/** A column whose value is a literal string provided by the partner. */
model LogColumnDefValueLogColumnDef {
  kind?: "Value";

  /** The static value injected into every log record. */
  value: string;
}

/** Well-known ADC attributes that can be referenced by custom columns. */
union LogColumnRef {
  "LogContent",
  "LogStream",
  "SandboxId",
  "Region",
  "ContainerName",
}

model NamedEgressPolicyListResponse {
  egressPolicies: NamedEgressPolicyResponseView[];
}

model NamedEgressPolicyResponseView {
  id: string;
  name: string;
  description?: null | string;
  defaultAction: EgressPolicyAction;
  enforcementMode?: EgressPolicyEnforcementMode;
  rules?: null | EgressPolicyRule[];
  createdAt?: utcDateTime;
  updatedAt?: utcDateTime;
}

model NamedEgressPolicyUpsertView {
  name: string;
  description?: null | string;
  defaultAction: EgressPolicyAction;
  enforcementMode?: EgressPolicyEnforcementMode;
  rules?: null | EgressPolicyRule[];
}

/** Network egress decisions (allowed and denied). */
model NetworkEgressDecisionsView {
  /** Last 50 allowed egress requests (most recent first). */
  allowed: EgressDecisionEntryView[];

  /** Last 50 denied egress requests (most recent first). */
  denied: EgressDecisionEntryView[];
}

model SandboxEgressPolicyView {
  @oneOf http?: null | HttpEgressSection;
  @oneOf defaultAction?: null | EgressPolicyAction;
  hostRules?: EgressHostRule[];
  rules?: null | EgressPolicyRule[];
  @oneOf tds?: null | TdsEgressSection;
  @oneOf transportRules?: null | TransportEgressSection;
  trafficInspection?: TrafficInspection;
  enforcementMode?: EgressPolicyEnforcementMode;
  validationWarnings?: null | ValidationWarningView[];
}

/**
 * Stateful-TCP (TDS) egress connection audit entries. A single recent-connections list carries both
 * lifecycle phases (Established, Closed); consumers pair them by string? DataPlaneStatefulTcpEntryView.CorrelationId.
 */
model StatefulTcpEgressView {
  /** Last 50 stateful-TCP connection audit entries (most recent first). */
  connections?: StatefulTcpEntryView[];
}

/** Credential kind for a TDS egress connection. Managed identity is deferred (v1). */
union TdsAuthKind {
  "SqlPassword",
  "EntraToken",
}

/**
 * A declared TDS credential. string TdsCredential.Name uniquely identifies the credential within its
 * TdsEgressSection and is what rules (string? TdsEgressAction.Credential) and webhook
 * responses reference. On the API/contract path EgressPolicySecretRef? TdsCredential.SecretRef is set and string? TdsCredential.Secret is
 * null. On the runtime path (after Global API resolution) string? TdsCredential.Secret holds the resolved material
 * and flows (encrypted) to NodeAgent.
 */
model TdsCredential {
  name: string;
  kind: TdsAuthKind;
  username?: null | string;
  @oneOf secretRef?: null | EgressPolicySecretRef;

  @secret
  secret?: null | string;
}

/**
 * Static action for a TDS rule. EgressPolicyActionType TdsEgressAction.Type must be Allow or Deny (Transform/Rewrite are HTTP-only
 * and rejected by validation). string? TdsEgressAction.Credential names a declared credential and is only valid on Allow.
 */
model TdsEgressAction {
  type: EgressPolicyActionType;
  credential?: null | string;
}

/** Match criteria for a TDS egress rule (AND logic). Host is a glob over the SNI / original-dst server. */
model TdsEgressMatch {
  host: string;
  databases?: null | string[];
}

/**
 * A single TDS egress rule. Rules are evaluated in order; first match wins. A rule has exactly one of
 * TdsEgressAction? TdsEgressRule.Action (static) or EgressPolicyHookRef? TdsEgressRule.HookRef (dynamic webhook), never both — same XOR as HTTP.
 */
model TdsEgressRule {
  name: null | string;
  match: TdsEgressMatch;
  @oneOf action?: null | TdsEgressAction;
  @oneOf hookRef?: null | EgressPolicyHookRef;
}

/**
 * The TDS section of an egress policy. IReadOnlyList&lt;TdsCredential&gt; TdsEgressSection.Credentials is a list of named credentials (each
 * string TdsCredential.Name unique within the section), declared once and referenced by name from
 * static rules and webhook responses. The array-of-named-objects shape matches the rest of the ADC API
 * (for example Connections); the runtime resolves it into a by-name map. On the runtime path each
 * credential's string? TdsCredential.Secret is resolved.
 */
model TdsEgressSection {
  defaultAction: EgressPolicyActionType;
  credentials: TdsCredential[];
  rules: TdsEgressRule[];
}

/**
 * A single L3/L4 transport egress rule. Rules are evaluated in declared order; first match wins.
 * EgressPolicyActionType TransportEgressRule.Action must be Allow or Deny (Transform/Rewrite are HTTP-only and rejected by validation).
 * string TransportEgressRule.Destination is an IPv4 CIDR (v1). int? TransportEgressRule.Port is a single destination port
 * (`1..65535`) or `null` to match every port on the destination (any-port wildcard).
 */
model TransportEgressRule {
  action: EgressPolicyActionType;
  protocol: TransportProtocol;
  destination: string;
  port: NullableInt32OrString;
}

/**
 * The transport (L3/L4 TCP/UDP) section of an egress policy. Distinct from HTTP and TDS policy and
 * enforced by NodeAgent at the network layer (`iptables`). EgressPolicyActionType TransportEgressSection.DefaultAction is the terminal
 * action applied to raw TCP/UDP flows that match no rule; IReadOnlyList&lt;TransportEgressRule&gt; TransportEgressSection.Rules is capped at 10 entries. DNS
 * (port 53) is always carved out and never constrained by these rules in v1.
 */
model TransportEgressSection {
  defaultAction: EgressPolicyActionType;
  rules: TransportEgressRule[];
}
