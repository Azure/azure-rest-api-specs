import "../common/models.tsp";
import "../agents/models.tsp";
import "../openai-responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

const PromptVoiceConversationRequiredPreviews = #{
  required_previews: #[AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview],
};

@doc("A streamed WAV (`audio/wav`) audio response. The bytes are streamed through the service; no SAS URL is returned.")
model VoiceAudioStreamResponse {
  @doc("The content type of the streamed audio.")
  @header("Content-Type")
  contentType: "audio/wav";

  @doc("The WAV audio bytes.")
  @body
  content: bytes;
}

/**
 * Read-only, endpoint-scoped retrieval of the conversations, transcripts, and audio recorded by a
 * voice-first prompt agent. For a `prompt_voice` agent the service is the sole writer of conversation
 * items, so only reads and a cascading conversation delete are exposed here. All persistence is governed
 * by the definition's `store` flag: when `store = false` (the default) nothing is persisted, so these
 * routes return `404`. The merged-recording routes additionally require the session to have ended and
 * return `409` while it is still in progress.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Conversations")
interface AgentEndpointConversations {
  /**
   * Returns a paged collection of conversations recorded for the specified voice agent endpoint.
   * Requires the agent's definition to persist conversations (`store = true`); otherwise no conversations exist.
   */
  @summary("List conversations for a voice agent")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations")
  @list
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  listAgentConversations is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      ...UserIsolationKeyHeader;
      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<OpenAI.ConversationResource>
  >;

  /**
   * Retrieves a single conversation recorded for the specified voice agent endpoint by its id.
   * Returns `404` when the conversation was not persisted (`store = false`).
   */
  @summary("Get a voice agent conversation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversation is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation to retrieve. */
      @path conversation_id: string;

      ...UserIsolationKeyHeader;
    },
    OpenAI.ConversationResource
  >;

  /**
   * Returns a paged collection of items (transcript turns and tool events) belonging to the specified
   * conversation. Each item carries its transcript and, when audio was persisted, per-turn `voice_metrics`
   * and an audio reference. Returns `404` when the conversation was not persisted (`store = false`).
   */
  @summary("List items in a voice agent conversation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items")
  @list
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  listAgentConversationItems is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose items are listed. */
      @path conversation_id: string;

      ...UserIsolationKeyHeader;
      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<OpenAI.OutputItem>
  >;

  /**
   * Retrieves a single item from the specified conversation by its id, including its transcript and — when
   * audio was persisted — per-turn `voice_metrics` and an audio reference. Returns `404` when the conversation
   * or item was not persisted (`store = false`).
   */
  @summary("Get a voice agent conversation item")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationItem is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the item. */
      @path conversation_id: string;

      /** The id of the conversation item to retrieve. */
      @path item_id: string;

      ...UserIsolationKeyHeader;
    },
    OpenAI.OutputItem
  >;

  /**
   * Streams one turn's audio as a WAV (`audio/wav`) byte stream through the service (no SAS URL).
   * Requires the conversation to have persisted audio (`store = true`); otherwise returns `404`.
   */
  @summary("Get a voice agent conversation item's audio")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}/audio")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationItemAudio is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the item. */
      @path conversation_id: string;

      /** The id of the conversation item whose audio is streamed. */
      @path item_id: string;

      ...UserIsolationKeyHeader;
    },
    VoiceAudioStreamResponse
  >;

  /**
   * Returns metadata for the whole-call merged stereo recording (user audio on the left channel, agent audio
   * on the right), including a service-managed `blob_path` (no SAS token). The recording is built once from the
   * per-turn segments after the session ends; a request against an in-progress session returns `409`. Requires
   * the conversation to have persisted audio (`store = true`); otherwise returns `404`.
   */
  @summary("Get a voice agent conversation's merged recording metadata")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationAudio is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose merged recording metadata is retrieved. */
      @path conversation_id: string;

      ...UserIsolationKeyHeader;
    },
    VoiceRecordingResponse
  >;

  /**
   * Streams the whole-call merged stereo recording as a WAV (`audio/wav`) byte stream through the service
   * (no SAS URL). Same gating as the metadata route: the session must have ended (else `409`) and the
   * conversation must have persisted audio (`store = true`, else `404`).
   */
  @summary("Stream a voice agent conversation's merged recording")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio/content")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationAudioContent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose merged recording is streamed. */
      @path conversation_id: string;

      ...UserIsolationKeyHeader;
    },
    VoiceAudioStreamResponse
  >;

  /**
   * Deletes a conversation and all of its stored data — transcripts, per-turn `voice_metrics`, and any audio
   * blobs (cascade). This is the customer's explicit data-deletion control for voice conversations.
   */
  @summary("Delete a voice agent conversation")
  @delete
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  deleteAgentConversation is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation to delete. */
      @path conversation_id: string;

      ...UserIsolationKeyHeader;
    },
    OpenAI.DeletedConversationResource
  >;
}
