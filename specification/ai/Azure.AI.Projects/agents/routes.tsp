import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/streams";

import "./models.tsp"; // e.g. ChatMessage, Agent, Thread
import "./completions/completions.tsp"; // e.g. CompleteParams, AgentCompleteParams, etc.

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core; // For Operation<..., ...>, etc.
using Azure.Core.Foundations;
using Azure.Core.Traits;

/**
 * A "no-op" model to represent an empty request, because Operation<TRequest, TResponse>
 * requires a Model (or union) for the first parameter.
 */
model NoRequest {}

/**
 * Single namespace for the AI Projects Agents service.
 */
namespace Azure.AI.Projects.Agents {
  /**
   * Creates (sends) a new chat message, returning the created ChatMessage.
   *
   * @param body The details of the ChatMessage to create.
   * @returns The newly created ChatMessage.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @post
  @route("/messages")
  op sendMessage is Operation<
    /**
     * The ChatMessage request body.
     */
    ChatMessage,
    /**
     * The newly created ChatMessage resource in the response.
     */
    ChatMessage
  >;

  /**
   * Retrieves (reads) an existing chat message.
   *
   * @param messageId The identifier of the ChatMessage to retrieve.
   * @returns The requested ChatMessage.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @get
  @route("/messages/{messageId}")
  op getMessage is Operation<
    {
      /**
       * The identifier of the ChatMessage to retrieve.
       */
      @doc("The identifier of the ChatMessage to retrieve.")
      @path
      messageId: string;
    },
    ChatMessage
  >;

  /**
   * Updates an existing chat message (or creates if not found) and returns the updated message.
   *
   * @param messageId The identifier of the message to update.
   * @param body The details of how to update the ChatMessage.
   * @returns The updated ChatMessage.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @put
  @route("/messages/{messageId}")
  op updateMessage is Operation<
    {
      /**
       * The identifier of the message to update.
       */
      @doc("The identifier of the message to update.")
      @path
      messageId: string;

      /**
       * The new or updated ChatMessage resource.
       */
      @doc("The new or modified ChatMessage object.")
      @body
      body: ChatMessage;
    },
    ChatMessage
  >;

  /**
   * Deletes a chat message. Returns 204 on success.
   *
   * @param messageId The ID of the message to delete.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @delete
  @route("/messages/{messageId}")
  op deleteMessage is Operation<
    {
      /**
       * The ID of the message to delete.
       */
      @doc("The ID of the message to delete.")
      @path
      messageId: string;
    },
    void
  >;

  /**
   * Lists chat messages, returning a collection of ChatMessage objects.
   *
   * @returns An array of ChatMessage items.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @get
  @route("/messages")
  op listMessages is Operation<NoRequest, ChatMessage[]>;

  //
  // -- Threads
  //

  /**
   * Creates a new Thread and returns it.
   *
   * @param body The Thread data to create.
   * @returns The newly created Thread.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @post
  @route("/threads")
  op createThread is Operation<Thread, Thread>;

  /**
   * Retrieves an existing thread by its ID.
   *
   * @param threadId The identifier of the Thread to retrieve.
   * @returns The requested Thread.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @get
  @route("/threads/{threadId}")
  op getThread is Operation<
    {
      /**
       * The identifier of the Thread.
       */
      @doc("The identifier of the Thread.")
      @path
      threadId: string;
    },
    Thread
  >;

  /**
   * Updates or replaces a thread by its ID, returning the updated Thread.
   *
   * @param threadId The identifier of the Thread to update.
   * @param body The new or revised Thread data.
   * @returns The updated Thread.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @put
  @route("/threads/{threadId}")
  op updateThread is Operation<
    {
      /**
       * The identifier of the Thread to update.
       */
      @doc("The identifier of the Thread to update.")
      @path
      threadId: string;

      /**
       * The new or updated Thread object.
       */
      @doc("The updated Thread resource data.")
      @body
      body: Thread;
    },
    Thread
  >;

  /**
   * Deletes a thread, returning 204 on success.
   *
   * @param threadId The thread to delete.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @delete
  @route("/threads/{threadId}")
  op deleteThread is Operation<
    {
      /**
       * The ID of the thread to delete.
       */
      @doc("The ID of the thread to delete.")
      @path
      threadId: string;
    },
    void
  >;

  /**
   * Lists all threads, returning an array of Thread items.
   *
   * @returns An array of Thread objects.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @get
  @route("/threads")
  op listThreads is Operation<NoRequest, Thread[]>;

  //
  // -- Agents
  //

  /**
   * Creates a new Agent resource and returns it.
   *
   * @param body The Agent data to create.
   * @returns The newly created Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @post
  @route("/agents")
  op createAgent is Operation<Agent, Agent>;

  /**
   * Retrieves an existing Agent by its ID.
   *
   * @param agentId The ID of the Agent to retrieve.
   * @returns The requested Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @get
  @route("/agents/{agentId}")
  op getAgent is Operation<
    {
      /**
       * The ID of the Agent to retrieve.
       */
      @doc("The ID of the Agent to retrieve.")
      @path
      agentId: string;
    },
    Agent
  >;

  /**
   * Updates or replaces an agent and returns the updated resource.
   *
   * @param agentId The ID of the Agent to update.
   * @param body The updated Agent details.
   * @returns The new or updated Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @put
  @route("/agents/{agentId}")
  op updateAgent is Operation<
    {
      /**
       * The ID of the Agent to update.
       */
      @doc("The ID of the Agent to update.")
      @path
      agentId: string;

      /**
       * The new or updated Agent data.
       */
      @doc("The updated Agent data.")
      @body
      body: Agent;
    },
    Agent
  >;

  /**
   * Deletes an Agent by its ID, returning 204 on success.
   *
   * @param agentId The ID of the Agent to delete.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @delete
  @route("/agents/{agentId}")
  op deleteAgent is Operation<
    {
      /**
       * The ID of the Agent to delete.
       */
      @doc("The ID of the Agent to delete.")
      @path
      agentId: string;
    },
    void
  >;

  /**
   * Lists all Agents, returning an array of Agent objects.
   *
   * @returns An array of Agent items.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @get
  @route("/agents")
  op listAgents is Operation<NoRequest, Agent[]>;

  /**
   * Requests a completion for the entire “Agents” collection,
   * using CompleteParams as input and returning an AgentCompletion.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @post
  @route("/agents/complete")
  op complete is Operation<CompleteParams, AgentCompletion>;

  /**
   * Requests a streaming completion for the entire “Agents” collection,
   * returning a stream of StreamingAgentCompletionUpdate items.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Stream is a valid response body."
  @post
  @route("/agents/stream")
  op stream is Operation<
    CompleteParams,
    Streams.Stream<StreamingAgentCompletionUpdate>
  >;

  /**
   * Requests a completion for a specific Agent, returning an AgentCompletion.
   *
   * @param agentId The ID of the Agent to operate on.
   * @param body The parameters used to complete the agent's action.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @post
  @route("/agents/{agentId}/complete")
  op completeByAgent is Operation<
    {
      /**
       * The ID of the Agent for which to request a completion.
       */
      @doc("The ID of the Agent for which to request a completion.")
      @path
      agentId: string;

      /**
       * The completion parameters for this agent.
       */
      @doc("The parameters used to generate a completion for this agent.")
      @body
      body: AgentCompleteParams;
    },
    AgentCompletion
  >;

  /**
   * Requests a streaming completion for a specific Agent, returning a stream of updates.
   *
   * @param agentId The ID of the Agent to operate on.
   * @param body The parameters used to stream the agent's result.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Stream is a valid response body."
  @post
  @route("/agents/{agentId}/stream")
  op streamByAgent is Operation<
    {
      /**
       * The ID of the Agent for which to request a streaming completion.
       */
      @doc("The ID of the Agent for which to request a streaming completion.")
      @path
      agentId: string;

      /**
       * The streaming completion parameters for this agent.
       */
      @doc("Parameters controlling how the agent's streaming completion is generated.")
      @body
      body: AgentCompleteParams;
    },
    Streams.Stream<StreamingAgentCompletionUpdate>
  >;
}
