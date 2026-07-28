import "@typespec/http";

using TypeSpec.Http;

namespace VoiceLiveSip;

// ============================================================================
// Shared enumerations (string extensible enums).
//
// These mirror the SIP lifecycle enums published as `realtime.call.*` WebSocket
// server events in the VoiceLive realtime data-plane spec, so the HTTP
// control-plane contract and the WebSocket event contract stay in sync.
// ============================================================================

/** The lifecycle state of a SIP call. */
union SipCallState {
  string,

  /** The inbound INVITE has arrived and the call is awaiting a customer decision. */
  waiting_for_customer: "WaitingForCustomer",

  /** The customer accepted the call and runtime setup is in progress. */
  accepting: "Accepting",

  /** The SDP answer has been received but the call is not fully connected yet. */
  accepted: "Accepted",

  /** The Voice Live runtime is configured and the call is active. */
  connected: "Connected",

  /** The customer rejected a waiting call and rejection is in progress. */
  rejecting: "Rejecting",

  /** A blind transfer is in progress. */
  transferring: "Transferring",

  /** Call termination and cleanup are in progress. */
  terminating: "Terminating",

  /** The call ended normally or by an explicit hangup, reject, or transfer completion. */
  disconnected: "Disconnected",

  /** The call failed because setup or runtime control could not complete. */
  failed: "Failed",

  /** The waiting call expired before the customer made a decision. */
  expired: "Expired",
}

/** The terminal reason recorded when a SIP call leaves the active state machine. */
union SipCallTerminalReason {
  string,

  /** The customer rejected the inbound call. */
  rejected: "Rejected",

  /** The customer requested hangup. */
  customer_hangup: "CustomerHangup",

  /** The caller-side SIP leg ended. */
  sip_proxy_terminate: "SipProxyTerminate",

  /** The inbound decision timeout expired. */
  decision_timeout: "DecisionTimeout",

  /** Runtime setup failed before the call connected. */
  setup_failure: "SetupFailure",

  /** A blind transfer completed successfully. */
  transfer_succeeded: "TransferSucceeded",

  /** A fatal runtime error ended the call. */
  runtime_error: "RuntimeError",
}

// ============================================================================
// Error model.
//
// SIP control-plane operations return an RFC 7807 problem-details object (served as
// `application/json`) extended with Voice Live SIP diagnostic members. Validation failures
// (HTTP 400) additionally populate `errors` with per-field messages.
// ============================================================================

/** An error response returned by a Voice Live SIP control-plane operation. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Problem-details extension members (trace_id, sub_code, call_id) are snake_case to match the service wire contract.
#suppress "@azure-tools/typespec-azure-core/bad-record-type" // `errors` is an open per-field validation map keyed by request field name.
@error
model SipErrorResponse {
  /** A URI reference identifying the problem type, for example `https://aka.ms/voicelive/sip/errors/call_not_found`. */
  type?: string;

  /** A short, human-readable summary of the problem type. */
  title?: string;

  /** The HTTP status code generated for this occurrence of the problem. */
  status?: int32;

  /** A human-readable explanation specific to this occurrence of the problem. */
  detail?: string;

  /** A URI reference identifying the specific occurrence of the problem (typically the request path). */
  instance?: string;

  /** A machine-readable error code, for example `call_not_found` or `invalid_request`. */
  code?: string;

  /** Whether retrying the request may succeed. */
  retryable?: boolean;

  /** The request correlation identifier, echoed for support diagnostics. */
  trace_id?: string;

  /** An optional finer-grained error sub-code. */
  sub_code?: string;

  /** The SIP call identifier the error relates to, when applicable. */
  call_id?: string;

  /** The SIP call state at the time of the error, when applicable. */
  state?: string;

  /** Per-field validation messages, present on `400` validation errors. */
  errors?: Record<string[]>;
}

// ============================================================================
// Call control models.
// ============================================================================

/**
 * The request body for accepting an inbound SIP call. The body is an open Voice Live agent
 * configuration object (the same shape accepted by the realtime `session.update` event); all
 * properties are passed through to the accepted call's Voice Live session.
 */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" // Open pass-through of arbitrary Voice Live agent configuration JSON; values are not all strings.
model SipAcceptCallRequest {
  ...Record<unknown>;
}

/** The result of accepting an inbound SIP call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipAcceptCallResult {
  /** The accepted SIP call identifier. */
  call_id: string;

  /** The current call state. */
  state: SipCallState;

  /** The Voice Live session identifier, present once runtime setup has created one. */
  voice_live_session_id?: string;
}

/** The request body for rejecting an inbound SIP call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipRejectCallRequest {
  /**
   * The SIP status code to use for rejection. Defaults to `486` (Busy Here). The service does not
   * constrain the range; any SIP response code the caller wants to return may be supplied.
   */
  status_code?: int32 = 486;

  /** The optional customer-visible rejection reason. */
  reason?: string;
}

/** The result of rejecting an inbound SIP call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipRejectCallResult {
  /** The rejected SIP call identifier. */
  call_id: string;

  /** The resulting call state. */
  state: SipCallState;

  /** The terminal reason for the call. */
  terminal_reason: SipCallTerminalReason;
}

/** The request body for a blind transfer (REFER) of a SIP call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipReferCallRequest {
  /** The transfer target SIP URI, for example `sip:+15551234567@pstn.example.com`. */
  target_uri: string;
}

/** The result of starting a blind transfer (REFER) of a SIP call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipReferCallResult {
  /** The transferred SIP call identifier. */
  call_id: string;

  /** The transfer identifier used to correlate asynchronous REFER status updates. */
  transfer_id: string;

  /** The current call state. */
  state: SipCallState;
}

/** The request body for hanging up a SIP call. */
model SipHangupCallRequest {
  /** The optional customer-visible hangup reason. */
  reason?: string;
}

// ============================================================================
// Webhook management models.
//
// The serialized shape mirrors the Azure OpenAI `webhook.endpoint` object: a flat object with an
// `object` discriminator, Unix-seconds timestamps, and a one-time `signing_secret` returned only on
// create and rotate.
// ============================================================================

/** Customer-provided support metadata for a webhook registration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipWebhookSupportInfo {
  /** The support contact display name. */
  @maxLength(128)
  display_name?: string;

  /** The support contact email address. */
  @maxLength(320)
  contact_email?: string;

  /** A free-form description of the webhook or its support contact. */
  @maxLength(1024)
  description?: string;
}

/** The request body for creating a webhook registration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipCreateWebhookRequest {
  /** The human-readable webhook name. */
  @maxLength(128)
  name?: string;

  /** The HTTPS endpoint URL that receives webhook deliveries. */
  url: url;

  /** The event types to subscribe to. Defaults to `["*"]` (all supported event types). */
  event_types?: string[] = #["*"];

  /** The optional support metadata for the webhook. */
  support_info?: SipWebhookSupportInfo;
}

/** The request body for updating a webhook registration. Omitted fields retain their stored values. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipUpdateWebhookRequest {
  /** The updated webhook name. */
  @maxLength(128)
  name?: string;

  /** The updated HTTPS endpoint URL. */
  url?: url;

  /** The updated event types to subscribe to. */
  event_types?: string[];

  /** Whether the webhook is enabled for delivery. */
  enabled?: boolean;

  /** The updated support metadata for the webhook. */
  support_info?: SipWebhookSupportInfo;
}

/** A customer webhook registration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipWebhookEndpoint {
  /** The object type. Always `webhook.endpoint`. */
  object: "webhook.endpoint";

  /** The webhook registration identifier (prefixed `wh_`). */
  id: string;

  /** The human-readable webhook name. */
  @maxLength(128)
  name?: string;

  /** The HTTPS endpoint URL that receives webhook deliveries. */
  url: url;

  /** The event types the webhook is subscribed to. */
  event_types: string[];

  /** The support metadata for the webhook. */
  support_info: SipWebhookSupportInfo;

  /** Whether the webhook is enabled for delivery. */
  enabled: boolean;

  /** The creation time, as Unix epoch seconds. */
  created_at: int64;

  /** The last update time, as Unix epoch seconds. */
  updated_at: int64;

  /** The full signing secret. Returned only when the endpoint is created or its secret is rotated. */
  signing_secret?: string;

  /** A non-sensitive hint of the stored signing secret. */
  signing_secret_hint?: string;
}

/** A list of webhook registrations. */
model SipWebhookList {
  /** The object type. Always `list`. */
  object: "list";

  /** The webhook registrations. */
  data: SipWebhookEndpoint[];
}

// ============================================================================
// Resource SIP configuration models.
// ============================================================================

/** The APIM-authenticated resource identity captured for downstream SIP calls. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model SipCallIdentity {
  /** The resource internal identifier (32-character hex GUID). */
  internal_id: string;

  /** The full ARM resource identifier. */
  resource_id: string;

  /** The Azure subscription identifier. */
  subscription_id: string;

  /** The Azure tenant identifier. */
  tenant_id: string;

  /** The optional APIM product identifier associated with the call. */
  product_id?: string;
}

/**
 * The request body for creating or partially updating the resource-level SIP configuration. At least
 * one field is required; omitted fields retain their stored values.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-azure-core/bad-record-type" // Open pass-through of arbitrary Voice Live agent configuration JSON; values are not all strings.
model SipUpsertConfigurationRequest {
  /** The SIP digest password to create or replace. */
  @maxLength(512)
  password?: string;

  /** The signaling source IP addresses or CIDRs to replace. An empty array clears the allowlist. */
  @maxItems(64)
  allowed_source_cidrs?: string[];

  /**
   * The default Voice Live agent configuration to create or replace. Uses the same open model and
   * session configuration shape accepted by the SIP call accept API.
   */
  voice_live_agent_configuration?: Record<unknown>;
}

/** The customer-facing resource-level SIP configuration. The digest password is never returned. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-azure-core/bad-record-type" // Open pass-through of arbitrary Voice Live agent configuration JSON; values are not all strings.
model SipConfiguration {
  /** The configuration identifier. Always `sip_configuration`. */
  id: "sip_configuration";

  /** The object type. Always `sip.configuration`. */
  object: "sip.configuration";

  /** Whether a digest password is configured. */
  password_set: boolean;

  /** The normalized signaling source allowlist. */
  allowed_source_cidrs: string[];

  /** The APIM-authenticated resource identity captured for downstream SIP calls. */
  call_identity?: SipCallIdentity;

  /** The stored default Voice Live agent configuration. */
  voice_live_agent_configuration?: Record<unknown>;

  /** The configuration creation time, as Unix epoch seconds. */
  created_at: int64;

  /** The most recent configuration update time, as Unix epoch seconds. */
  updated_at: int64;
}
