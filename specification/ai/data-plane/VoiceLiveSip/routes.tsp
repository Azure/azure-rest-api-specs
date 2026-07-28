import "@typespec/http";
import "./models.tsp";

using TypeSpec.Http;

namespace VoiceLiveSip;

// ============================================================================
// Shared parameters and response helpers.
// ============================================================================

/** The API version query parameter, required on every operation. */
model ApiVersionParameter {
  /** The API version to use for this operation. */
  @query("api-version")
  @minLength(1)
  apiVersion: string;
}

// ============================================================================
// Call control operations.
//
// Customer call control over the inbound SIP call identified by `call_id`.
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" // Voice Live SIP exposes OpenAI-style action endpoints (accept/reject/refer/hangup) rather than Azure.Core resource operations.
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-azure-core/bad-record-type" // Open pass-through of arbitrary Voice Live agent configuration JSON; values are not all strings.
@route("/voice-agent/realtime/sip/calls/{call_id}")
interface Calls {
  /** Accepts an inbound SIP call and starts the Voice Live agent session. */
  @summary("Accept an inbound SIP call")
  @route("accept")
  @post
  accept(
    ...ApiVersionParameter,

    /** The route-bound SIP call identifier. */
    @path
    @minLength(1)
    @maxLength(256)
    call_id: string,

    /** The Voice Live agent configuration applied to the accepted call. */
    @body configuration: SipAcceptCallRequest,
  ): SipAcceptCallResult | SipErrorResponse;

  /** Rejects an inbound SIP call with an optional SIP status code and reason. */
  @summary("Reject an inbound SIP call")
  @route("reject")
  @post
  reject(
    ...ApiVersionParameter,

    /** The route-bound SIP call identifier. */
    @path
    @minLength(1)
    @maxLength(256)
    call_id: string,

    /** The reject request. */
    @body body: SipRejectCallRequest,
  ): SipRejectCallResult | SipErrorResponse;

  /** Starts a blind transfer (REFER) of an active SIP call to another SIP target. */
  @summary("Transfer a SIP call (blind transfer)")
  @route("refer")
  @post
  refer(
    ...ApiVersionParameter,

    /** The route-bound SIP call identifier. */
    @path
    @minLength(1)
    @maxLength(256)
    call_id: string,

    /** The transfer request. */
    @body body: SipReferCallRequest,
  ):
    | {
        /** The HTTP status code. */
        @statusCode statusCode: 202;

        /** The started blind-transfer result. */
        @bodyRoot result: SipReferCallResult;
      }
    | SipErrorResponse;

  /** Terminates an active SIP call. */
  @summary("Hang up a SIP call")
  @route("hangup")
  @post
  hangup(
    ...ApiVersionParameter,

    /** The route-bound SIP call identifier. */
    @path
    @minLength(1)
    @maxLength(256)
    call_id: string,

    /** The hangup request. */
    @body body: SipHangupCallRequest,
  ): NoContentResponse | SipErrorResponse;
}

// ============================================================================
// Customer WebSocket attach operation.
//
// Upgrades an HTTP GET to a WebSocket (`wss`) attached to an existing SIP call
// runtime. After the upgrade the connection carries the realtime `realtime.call.*`
// server events and reused `ClientEvent` messages defined by the VoiceLive realtime
// data-plane contract; when `audio=true`, the agent's output audio is additionally
// streamed as `response.audio.delta` (base64 PCM16, 24 kHz, mono).
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" // Voice Live SIP exposes an OpenAI-style WebSocket-attach endpoint rather than an Azure.Core resource operation.
#suppress "@azure-tools/typespec-azure-core/use-standard-names" // The 'attach' verb reflects the WebSocket-upgrade semantics rather than an Azure.Core 'get'.
#suppress "@azure-tools/typespec-azure-core/casing-style" // Query parameters (call_id, audio) are snake_case to match the service wire contract.
@route("/voice-agent/realtime/sip/calls")
interface CallWebSocket {
  /**
   * Attaches a WebSocket connection to an existing SIP call runtime so a customer can observe the
   * realtime conversation and inject mid-call commands. The request must carry the standard WebSocket
   * upgrade headers (`Upgrade: websocket`, `Connection: Upgrade`, `Sec-WebSocket-Key`,
   * `Sec-WebSocket-Version`); on success the server responds with `101 Switching Protocols` and the
   * connection is upgraded to `wss`. The call is identified by the `call_id` from the
   * `realtime.call.incoming` event.
   */
  @summary("Attach a WebSocket to a SIP call")
  @get
  attach(
    ...ApiVersionParameter,

    /** The identifier of the SIP call to attach to, from the `realtime.call.incoming` event. */
    @query
    @minLength(1)
    @maxLength(256)
    call_id: string,

    /**
     * When `true`, the agent's output audio is also streamed to this connection as
     * `response.audio.delta` events (base64 PCM16, 24 kHz, mono). Defaults to `false`, in which case
     * only control and conversation events are delivered.
     */
    @query audio?: boolean = false,
  ): SipCallAttachResponse | SipErrorResponse;
}

// ============================================================================
// Webhook management operations.
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" // Voice Live SIP exposes OpenAI-style action endpoints (create/list/get/update/delete/rotate_secret) rather than Azure.Core resource operations.
#suppress "@azure-tools/typespec-azure-core/use-standard-names" // The 'list' name and list-envelope response follow the OpenAI-compatible Voice Live contract.
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@route("/voice-agent/realtime/sip/webhooks")
interface Webhooks {
  /** Creates a webhook registration for receiving SIP call lifecycle events. */
  @summary("Create a webhook registration")
  @post
  create(
    ...ApiVersionParameter,

    /** The create-webhook request. */
    @body body: SipCreateWebhookRequest,
  ): SipWebhookEndpoint | SipErrorResponse;

  /** Lists all webhook registrations for the authenticated resource. */
  @summary("List webhook registrations")
  @get
  list(...ApiVersionParameter): SipWebhookList | SipErrorResponse;

  /** Gets a single webhook registration by identifier. */
  @summary("Get a webhook registration")
  @route("{webhook_id}")
  @get
  get(
    ...ApiVersionParameter,

    /** The webhook registration identifier. */
    @path webhook_id: string,
  ): SipWebhookEndpoint | SipErrorResponse;

  /** Updates an existing webhook registration. Omitted fields retain their stored values. */
  @summary("Update a webhook registration")
  @route("{webhook_id}")
  @post
  update(
    ...ApiVersionParameter,

    /** The webhook registration identifier. */
    @path webhook_id: string,

    /** The update-webhook request. */
    @body body: SipUpdateWebhookRequest,
  ): SipWebhookEndpoint | SipErrorResponse;

  /** Deletes a webhook registration. */
  @summary("Delete a webhook registration")
  @route("{webhook_id}")
  @delete
  delete(
    ...ApiVersionParameter,

    /** The webhook registration identifier. */
    @path webhook_id: string,
  ): NoContentResponse | SipErrorResponse;

  /** Rotates the webhook signing secret. The previous secret remains valid for a grace period. */
  @summary("Rotate a webhook signing secret")
  @route("{webhook_id}/rotate_secret")
  @post
  rotateSecret(
    ...ApiVersionParameter,

    /** The webhook registration identifier. */
    @path webhook_id: string,
  ): SipWebhookEndpoint | SipErrorResponse;
}

// ============================================================================
// Resource SIP configuration operations.
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" // Voice Live SIP exposes an OpenAI-style upsert action endpoint rather than an Azure.Core resource operation.
@route("/voice-agent/realtime/sip/configurations")
interface Configurations {
  /** Creates or partially updates the authenticated resource's SIP configuration. */
  @summary("Create or update the resource SIP configuration")
  @post
  createOrUpdate(
    ...ApiVersionParameter,

    /** The upsert-configuration request. */
    @body body: SipUpsertConfigurationRequest,
  ): SipConfiguration | SipErrorResponse;
}
