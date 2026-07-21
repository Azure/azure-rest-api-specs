import "../common/models.tsp";
import "../agents/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

const PromptVoiceConversationRequiredPreviews = #{
  required_previews: #[AgentDefinitionOptInKeys.voice_agents_v1_preview],
};

/**
 * Read-only, endpoint-scoped retrieval of the conversations, responses, transcript items, per-turn
 * metrics, and audio recorded by a voice agent. For a `voice` agent, the service is the sole writer of
 * responses and items, so only
 * reads plus a cascading conversation delete are exposed — there are no response/item create, update, or
 * delete routes. All persistence is governed by the definition's `store` flag: when `store = false` (the
 * default) nothing is persisted, so these routes return `404`. The merged-recording routes additionally
 * require the session to have ended and return `409` while it is still in progress.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Conversations")
interface AgentEndpointConversations {
  /**
   * Retrieves a single conversation recorded for the specified voice agent endpoint by its id.
   * Returns `404` when the conversation was not persisted (`store = false`) or does not exist.
   */
  @summary("Get a voice agent conversation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversation is FoundryDataPlanePreviewOperation<
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
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  deleteAgentConversation is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation to delete. */
      @path conversation_id: string;
    },
    VoiceDeletedConversation
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
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  listAgentConversationResponses is FoundryDataPlanePreviewOperation<
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
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationResponse is FoundryDataPlanePreviewOperation<
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
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  listAgentConversationResponseItems is FoundryDataPlanePreviewOperation<
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
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  listAgentConversationItems is FoundryDataPlanePreviewOperation<
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
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationItem is FoundryDataPlanePreviewOperation<
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
   * bring-your-own-storage (BYOS) recordings; for BYOS the response additionally includes `blob_path`, a direct
   * path into the customer's own storage (no SAS) that the customer downloads with their own credentials.
   * Requires the conversation to have persisted audio (`store = true`); returns `404` when the conversation,
   * item, or its audio was not persisted.
   */
  @summary("Get a voice agent conversation item's audio metadata")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}/audio")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationItemAudio is FoundryDataPlanePreviewOperation<
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
   * bytes are not proxied — the caller must download directly from customer storage using the `blob_path`
   * returned by the item's `/audio` metadata route — so this route returns `409 Conflict` for BYOS recordings.
   * Returns `404` when the conversation, item, or its audio was not persisted (`store = false`).
   */
  @summary("Stream a voice agent conversation item's audio")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}/audio/content")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationItemAudioContent is FoundryDataPlanePreviewOperation<
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
   * includes `blob_path`, a direct path into the customer's own storage (no SAS) that the customer downloads
   * with their own credentials. The recording is built once from the per-turn segments after the session ends;
   * a request against an in-progress session returns `409`. Requires the conversation to have persisted audio
   * (`store = true`); otherwise returns `404`.
   */
  @summary("Get a voice agent conversation's merged recording metadata")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationAudio is FoundryDataPlanePreviewOperation<
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
   * `blob_path` returned by the metadata route — so this route returns `409 Conflict` for BYOS recordings.
   * A request against an in-progress session also returns `409` (a distinct condition: session-not-ended
   * versus BYOS-download-required). A conversation without persisted audio (`store = false`) returns `404`.
   */
  @summary("Stream a voice agent conversation's merged recording")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio/content")
  @extension("x-ms-foundry-meta", PromptVoiceConversationRequiredPreviews)
  getAgentConversationAudioContent is FoundryDataPlanePreviewOperation<
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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("""
  Management of voice agents. These agents live on the dedicated `/voice_agents` path family: the text `/agents`
  surface neither accepts nor returns voice agents, and this surface accepts only voice agents. Each create or
  update produces a new immutable version.
  """)
interface VoiceAgents {
  /**
   * Creates a new voice agent, or a new version of an existing one.
   */
  @summary("Create a voice agent")
  @post
  @route("/voice_agents")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agents")
  createVoiceAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    CreateVoiceAgentRequest,
    VoiceAgentObject
  >;

  /**
   * Returns a paged collection of voice agents.
   */
  @summary("List voice agents")
  @get
  @route("/voice_agents")
  @list
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agents")
  listVoiceAgents is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VoiceAgentObject>
  >;

  /**
   * Retrieves a voice agent by its unique name.
   */
  @summary("Get a voice agent")
  @get
  @route("/voice_agents/{agent_name}")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agents")
  getVoiceAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the voice agent to retrieve. */
      @path agent_name: string;
    },
    VoiceAgentObject
  >;

  /**
   * Updates a voice agent by adding a new version if there are any changes to the agent definition.
   * If no changes, returns the existing agent version.
   */
  @summary("Update a voice agent")
  @post
  @route("/voice_agents/{agent_name}")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agents")
  updateVoiceAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the voice agent to update. */
      @maxLength(63)
      @path
      agent_name: string;

      ...UpdateVoiceAgentRequest;
    },
    VoiceAgentObject
  >;

  /**
   * Deletes a voice agent and all of its versions.
   */
  @summary("Delete a voice agent")
  @delete
  @route("/voice_agents/{agent_name}")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agents")
  deleteVoiceAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the voice agent to delete. */
      @path agent_name: string;
    },
    DeleteAgentResponse
  >;

  /**
   * Enables the specified voice agent, allowing it to accept new requests.
   * This operation is idempotent — enabling an already-enabled voice agent returns success with no side effects.
   */
  @summary("Enable a voice agent")
  @post
  @route("/voice_agents/{agent_name}:enable")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agents")
  enableVoiceAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      @doc("The name of the voice agent to enable.")
      @path
      agent_name: string;
    },
    NoContentResponse
  >;

  /**
   * Disables the specified voice agent, preventing it from accepting new requests.
   * This operation is idempotent — disabling an already-disabled voice agent returns success with no side effects.
   */
  @summary("Disable a voice agent")
  @post
  @route("/voice_agents/{agent_name}:disable")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agents")
  disableVoiceAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      @doc("The name of the voice agent to disable.")
      @path
      agent_name: string;
    },
    NoContentResponse
  >;

  /**
   * Generates and creates a voice agent from high-level inputs plus a natural-language goal.
   * The operation expands the goal into a full, editable definition, creates the agent through the standard
   * voice create path, and returns the created `VoiceAgentObject`. The caller can edit or override the
   * generated fields afterward through normal versioning.
   */
  @summary("Generate a voice agent")
  @post
  @route("/voice_agents:generate")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agents")
  generateVoiceAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    GenerateVoiceAgentRequest,
    VoiceAgentObject
  >;

  /**
   * Creates a new version for the specified voice agent and returns the created version resource.
   */
  @summary("Create a voice agent version")
  @post
  @route("/voice_agents/{agent_name}/versions")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agent Versions")
  createVoiceAgentVersion is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the voice agent. */
      @maxLength(63)
      @path
      agent_name: string;

      ...CreateVoiceAgentVersionRequest;
    },
    VoiceAgentVersionObject
  >;

  /**
   * Returns a paged collection of versions for the specified voice agent.
   */
  @summary("List voice agent versions")
  @get
  @route("/voice_agents/{agent_name}/versions")
  @list
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agent Versions")
  listVoiceAgentVersions is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the voice agent to retrieve versions for. */
      @path agent_name: string;

      ...CommonPageQueryParameters;

      /** (Preview) Whether to include draft versions in the listing. The service defaults to `false` if a value is not specified by the caller (only non-draft versions are returned). */
      @extension(
        "x-ms-foundry-meta",
        #{
          conditional_previews: #[
            AgentDefinitionOptInKeys.draft_agents_v1_preview
          ],
        }
      )
      @query
      include_drafts?: boolean = false;
    },
    AgentsPagedResult<VoiceAgentVersionObject>
  >;

  /**
   * Retrieves the specified version of a voice agent by its agent name and version identifier.
   */
  @summary("Get a voice agent version")
  @get
  @route("/voice_agents/{agent_name}/versions/{agent_version}")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agent Versions")
  getVoiceAgentVersion is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the voice agent to retrieve. */
      @path agent_name: string;

      /** The version of the voice agent to retrieve. */
      @path agent_version: string;
    },
    VoiceAgentVersionObject
  >;

  /**
   * Deletes a specific version of a voice agent.
   */
  @summary("Delete a voice agent version")
  @delete
  @route("/voice_agents/{agent_name}/versions/{agent_version}")
  @extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
  @tag("Voice Agent Versions")
  deleteVoiceAgentVersion is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the voice agent to delete. */
      @path agent_name: string;

      /** The version of the voice agent to delete. */
      @path agent_version: string;
    },
    DeleteAgentVersionResponse
  >;
}
