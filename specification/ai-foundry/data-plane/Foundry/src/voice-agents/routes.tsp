import "../common/models.tsp";
import "../agents/models.tsp";
import "./models.tsp";
import "./protocol.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

const VoiceAgentConversationRequiredPreviews = #{
  required_previews: #[AgentDefinitionOptInKeys.voice_agents_v1_preview],
};

/**
 * Establishes a service-terminated WebSocket for a voice-agent session. The service applies the persisted
 * agent definition, resolves configured tools, sends the initial session configuration, and then exchanges
 * OpenAI Realtime GA JSON events and audio frames with the client.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "A WebSocket protocol upgrade does not match a standard resource operation template."
@tag("Voice Agent WebSocket")
interface VoiceAgentWebSocket {
  /**
   * Connects to a voice agent over WebSocket. The client must send an HTTP GET with `Upgrade: websocket`
   * headers. The optional `realtime` subprotocol is the only accepted subprotocol value.
   *
   * If the target agent is disabled, the HTTP WebSocket handshake fails before the `101 Switching Protocols`
   * upgrade. The service returns `409 Conflict` using the shared Foundry `ApiErrorResponse` shape with
   * `error.code = agent_disabled`. This failure is terminal until the caller enables the agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "A successful WebSocket 101 protocol switch has no HTTP entity body; messages begin as WebSocket frames after the upgrade."
  @summary("Connect to a voice agent")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice")
  connectVoiceAgent is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the voice agent. */
      @path agent_name: string;

      /** An optional identifier used to correlate the voice session. */
      @query agent_session_id?: string;

      /**
       * Whether to persist the conversation created by this WebSocket session. If omitted, the service honors the
       * persisted voice agent definition's configured `store` value. If supplied, this value overrides the
       * definition's `store` setting for this session only.
       */
      @query store?: boolean;

      /** Selects a specific version of the voice agent for this session. */
      @query("x-agent-version-override") agent_version_override?: string;

      /** The requested WebSocket subprotocol. Omit this header or request exactly `realtime`. */
      @header("Sec-WebSocket-Protocol")
      websocket_subprotocol?: VoiceAgentWebSocketSubprotocol;

      /** A JSON object that maps structured-input names to their values for this session. */
      @header("x-ms-voice-structured-inputs") structured_inputs?: string;
    },
    VoiceAgentWebSocketUpgradeResponse
  >;
}

/**
 * Read-only, endpoint-scoped retrieval of the conversations, responses, transcript items, per-turn
 * metrics, and audio recorded by a voice agent. For a `voice` agent, the service is the sole writer of
 * responses and items, so only
 * reads plus a cascading conversation delete are exposed — there are no response/item create, update, or
 * delete routes. All persistence is governed by the definition's `store` flag: when `store = false` (the
 * default) nothing is persisted, so these routes return `404`. The merged-recording routes additionally
 * require the session to have ended and return `409` while it is still in progress.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The endpoint-scoped, read-only voice conversation projection and its nested response, item, and audio routes do not match a standard resource operation template."
@tag("Agent Conversations")
interface AgentEndpointConversations {
  /**
   * Returns the conversations persisted for the specified voice agent endpoint.
   * Conversations are present only when the agent definition has `store = true`.
   */
  @summary("List voice agent conversations")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations")
  @list
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  listAgentConversations is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VoiceConversation>
  >;

  /**
   * Retrieves a single conversation recorded for the specified voice agent endpoint by its id.
   * Returns `404` when the conversation was not persisted (`store = false`) or does not exist.
   */
  @summary("Get a voice agent conversation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversation is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation to retrieve. */
      @path conversation_id: string;
    },
    VoiceConversation
  >;

  /**
   * Deletes a conversation and all of its stored data — responses, items, and any audio (cascade). This is
   * the customer's explicit data-deletion control for voice conversations.
   */
  @summary("Delete a voice agent conversation")
  @delete
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  deleteAgentConversation is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation to delete. */
      @path conversation_id: string;
    },
    NoContentResponse
  >;

  /**
   * Returns a paged collection of the responses (model inference turns) recorded for the specified
   * conversation. The per-response `output` projection may be omitted here; use the response-items route
   * for the canonical paged output. Returns `404` when the conversation was not persisted (`store = false`).
   */
  @summary("List responses in a voice agent conversation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/responses")
  @list
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  listAgentConversationResponses is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose responses are listed. */
      @path conversation_id: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VoiceResponse>
  >;

  /**
   * Retrieves a single response from the specified conversation by its id, including its `output` items,
   * `usage`, and status. Returns `404` when the conversation or response was not persisted (`store = false`).
   */
  @summary("Get a voice agent conversation response")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/responses/{response_id}")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationResponse is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the response. */
      @path conversation_id: string;

      /** The id of the response to retrieve. */
      @path response_id: string;
    },
    VoiceResponse
  >;

  /**
   * Returns a paged collection of the output items produced by a specific response (the response's output
   * projection). For the complete ordered conversation history — including user input and client-created
   * tool outputs — use the conversation items route instead. Returns `404` when the conversation or
   * response was not persisted (`store = false`).
   */
  @summary("List items produced by a voice agent conversation response")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/responses/{response_id}/items")
  @list
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  listAgentConversationResponseItems is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the response. */
      @path conversation_id: string;

      /** The id of the response whose output items are listed. */
      @path response_id: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VoiceConversationItem>
  >;

  /**
   * Returns a paged collection of items — the complete ordered conversation history, including user input,
   * assistant output, and client-created tool outputs (transcripts + tool events). Returns `404` when the
   * conversation was not persisted (`store = false`).
   */
  @summary("List items in a voice agent conversation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items")
  @list
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  listAgentConversationItems is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose items are listed. */
      @path conversation_id: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VoiceConversationItem>
  >;

  /**
   * Retrieves a single item from the specified conversation by its id, including its transcript. An
   * `input_audio`/`output_audio` content part indicates that audio is available for the item; the canonical per-item
   * audio metadata is the `/items/{item_id}/audio` resource, and the bytes are streamed by
   * `/items/{item_id}/audio/content`. Returns `404` when the conversation or item was not persisted
   * (`store = false`).
   */
  @summary("Get a voice agent conversation item")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationItem is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the item. */
      @path conversation_id: string;

      /** The id of the conversation item to retrieve. */
      @path item_id: string;
    },
    VoiceConversationItem
  >;

  /**
   * Returns metadata for a single conversation item's audio segment, including the common playback facts
   * (role, format/codec, sample rate, channels, offset, duration) for both Foundry-managed and
   * bring-your-own-storage (BYOS) recordings; for BYOS the response additionally includes `blob_uri`, the URI
   * of the recording in the customer's own storage (no SAS) that the customer downloads with their own credentials.
   * Requires the conversation to have persisted audio (`store = true`); returns `404` when the conversation,
   * item, or its audio was not persisted.
   */
  @summary("Get a voice agent conversation item's audio metadata")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}/audio")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationItemAudio is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the item. */
      @path conversation_id: string;

      /** The id of the conversation item whose audio metadata is retrieved. */
      @path item_id: string;
    },
    VoiceItemAudioResponse
  >;

  /**
   * Streams a single conversation item's audio as a WAV (`audio/wav`) byte stream through the service (no SAS
   * URL). This route serves Foundry-managed storage only. For bring-your-own-storage (BYOS) recordings the
   * bytes are not proxied — the caller must download directly from customer storage using the `blob_uri`
   * returned by the item's `/audio` metadata route — so this route returns `409 Conflict` for BYOS recordings.
   * Returns `404` when the conversation, item, or its audio was not persisted (`store = false`).
   */
  @summary("Stream a voice agent conversation item's audio")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}/audio/content")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationItemAudioContent is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the item. */
      @path conversation_id: string;

      /** The id of the conversation item whose audio is streamed. */
      @path item_id: string;
    },
    VoiceAudioStreamResponse
  >;

  /**
   * Returns metadata for the whole-call merged stereo recording (user audio on the left channel, agent audio
   * on the right). The common metadata (format, sample rate, channels, channel layout, duration) is returned
   * for both Foundry-managed and bring-your-own-storage (BYOS) recordings; for BYOS the response additionally
   * includes `blob_uri`, the URI of the recording in the customer's own storage (no SAS) that the customer downloads
   * with their own credentials. The recording is built once from the per-turn segments after the session ends;
   * a request against an in-progress session returns `409`. Requires the conversation to have persisted audio
   * (`store = true`); otherwise returns `404`.
   */
  @summary("Get a voice agent conversation's merged recording metadata")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationAudio is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose merged recording metadata is retrieved. */
      @path conversation_id: string;
    },
    VoiceRecordingResponse
  >;

  /**
   * Streams the whole-call merged stereo recording as a WAV (`audio/wav`) byte stream through the service
   * (no SAS URL). This route serves Foundry-managed storage only. For bring-your-own-storage (BYOS)
   * recordings the bytes are not proxied — the caller must download directly from customer storage using the
   * `blob_uri` returned by the metadata route — so this route returns `409 Conflict` for BYOS recordings.
   * A request against an in-progress session also returns `409` (a distinct condition: session-not-ended
   * versus BYOS-download-required). A conversation without persisted audio (`store = false`) returns `404`.
   */
  @summary("Stream a voice agent conversation's merged recording")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio/content")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationAudioContent is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose merged recording is streamed. */
      @path conversation_id: string;
    },
    VoiceAudioStreamResponse
  >;
}
