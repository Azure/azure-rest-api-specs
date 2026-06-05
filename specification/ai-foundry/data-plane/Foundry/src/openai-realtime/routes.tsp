import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/realtime";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/realtime")
@tag("Realtime")
interface Realtime {
  @route("calls")
  @post
  @summary("""
    Create a new Realtime API call over WebRTC and receive the SDP answer needed
    to complete the peer connection.
    """)
  `create-realtime-call` is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.RealtimeCallCreateRequest;
    },
    {
      @statusCode
      statusCode: 201;

      @header
      Location?: string;

      @header
      contentType: "application/sdp";

      @body
      body: string;
    }
  >;

  @route("calls/{call_id}/accept")
  @post
  @summary("""
    Accept an incoming SIP call and configure the realtime session that will
    handle it.
    """)
  `accept-realtime-call` is OpenAIOperation<
    {
      /**The identifier for the call provided in the
  [`realtime.call.incoming`](/docs/api-reference/webhook-events/realtime/call/incoming)
  webhook.*/
      @path
      call_id: string;

      /** Session configuration to apply before the caller is bridged to the model. */
      @body
      body: OpenAI.RealtimeSessionCreateRequestGA;
    },
    TypeSpec.Http.OkResponse
  >;

  @route("calls/{call_id}/hangup")
  @post
  @summary("""
    End an active Realtime API call, whether it was initiated over SIP or
    WebRTC.
    """)
  `hangup-realtime-call` is OpenAIOperation<
    {
      /**The identifier for the call. For SIP calls, use the value provided in the
  [`realtime.call.incoming`](/docs/api-reference/webhook-events/realtime/call/incoming)
  webhook. For WebRTC sessions, reuse the call ID returned in the `Location`
  header when creating the call with
  [`POST /v1/realtime/calls`](/docs/api-reference/realtime/create-call).*/
      @path
      call_id: string;
    },
    TypeSpec.Http.OkResponse
  >;

  @route("calls/{call_id}/refer")
  @post
  @summary("Transfer an active SIP call to a new destination using the SIP REFER verb.")
  `refer-realtime-call` is OpenAIOperation<
    {
      /**The identifier for the call provided in the
  [`realtime.call.incoming`](/docs/api-reference/webhook-events/realtime/call/incoming)
  webhook.*/
      @path
      call_id: string;

      /** Destination URI for the REFER request. */
      @body
      body: OpenAI.RealtimeCallReferRequest;
    },
    TypeSpec.Http.OkResponse
  >;

  @route("calls/{call_id}/reject")
  @post
  @summary("Decline an incoming SIP call by returning a SIP status code to the caller.")
  `reject-realtime-call` is OpenAIOperation<
    {
      /**The identifier for the call provided in the
  [`realtime.call.incoming`](/docs/api-reference/webhook-events/realtime/call/incoming)
  webhook.*/
      @path
      call_id: string;

      /**Provide an optional SIP status code. When omitted the API responds with
  `603 Decline`.*/
      @body
      body: OpenAI.RealtimeCallRejectRequest;
    },
    TypeSpec.Http.OkResponse
  >;

  @route("client_secrets")
  @post
  @summary("""
    Create a Realtime client secret with an associated session configuration.
    
    Client secrets are short-lived tokens that can be passed to a client app,
    such as a web frontend or mobile client, which grants access to the Realtime API without
    leaking your main API key. You can configure a custom TTL for each client secret.
    
    You can also attach session configuration options to the client secret, which will be
    applied to any sessions created using that client secret, but these can also be overridden
    by the client connection.
    
    [Learn more about authentication with client secrets over WebRTC](/docs/guides/realtime-webrtc).
    
    Returns the created client secret and the effective session object. The client secret is a string that looks like `ek_1234`.
    
    """)
  `create-realtime-client-secret` is OpenAIOperation<
    {
      /** Create a client secret with the given session configuration. */
      @body
      body: OpenAI.RealtimeCreateClientSecretRequest;
    },
    OpenAI.RealtimeCreateClientSecretResponse
  >;

  @route("sessions")
  @post
  @summary("""
    Create an ephemeral API token for use in client-side applications with the
    Realtime API. Can be configured with the same session parameters as the
    `session.update` client event.
    
    It responds with a session object, plus a `client_secret` key which contains
    a usable ephemeral API token that can be used to authenticate browser clients
    for the Realtime API.
    
    Returns the created Realtime session object, plus an ephemeral key.
    
    """)
  `create-realtime-session` is OpenAIOperation<
    {
      /** Create an ephemeral API key with the given session configuration. */
      @body
      body: OpenAI.RealtimeSessionCreateRequest;
    },
    OpenAI.RealtimeSessionCreateResponse
  >;

  @route("transcription_sessions")
  @post
  @summary("""
    Create an ephemeral API token for use in client-side applications with the
    Realtime API specifically for realtime transcriptions.
    Can be configured with the same session parameters as the `transcription_session.update` client event.
    
    It responds with a session object, plus a `client_secret` key which contains
    a usable ephemeral API token that can be used to authenticate browser clients
    for the Realtime API.
    
    Returns the created Realtime transcription session object, plus an ephemeral key.
    
    """)
  `create-realtime-transcription-session` is OpenAIOperation<
    {
      /** Create an ephemeral API key with the given session configuration. */
      @body
      body: OpenAI.RealtimeTranscriptionSessionCreateRequest;
    },
    OpenAI.RealtimeTranscriptionSessionCreateResponse
  >;

  @route("translations/client_secrets")
  @post
  @summary("""
    Create a Realtime translation client secret with an associated translation session configuration.
    
    Client secrets are short-lived tokens that can be passed to a client app,
    such as a web frontend or mobile client, which grants access to the Realtime
    Translation API without leaking your main API key. You can configure a custom
    TTL for each client secret.
    
    Returns the created client secret and the effective translation session object.
    The client secret is a string that looks like `ek_1234`.
    
    """)
  `create-realtime-translation-client-secret` is OpenAIOperation<
    {
      /** Create a client secret with the given translation session configuration. */
      @body
      body: OpenAI.RealtimeTranslationClientSecretCreateRequest;
    },
    OpenAI.RealtimeTranslationClientSecretCreateResponse
  >;
}
