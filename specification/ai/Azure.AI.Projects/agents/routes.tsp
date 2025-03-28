import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@typespec/streams";
import "./models.tsp"; // e.g. ChatMessage, Agent, Thread
import "./runs/runs.tsp"; // e.g. RunInputs etc.
import "./streaming/streaming.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;
using Streams;

namespace Azure.AI.Projects;

/**
 * A "no-op" model to represent an empty request, because Operation<TRequest, TResponse>
 * requires a Model (or union) for the first parameter.
 */
model NoRequest {}

/**
 * An alias for standard Azure resource operations with our chosen traits.
 * This grants us ResourceRead, ResourceList, ResourceCreateOrReplace, etc.
 */
alias AgentOperations = Azure.Core.ResourceOperations<ServiceTraits>;

/**
 * MESSAGES
 *
 * The interface is rooted at /messages.
 * Each standard resource operation will produce REST endpoints
 * like GET /messages/{name}, POST /messages, etc.
 * The "name" or "id" parameter is inferred from Azure Core’s naming patterns
 * for resource operations.
 */
interface Messages {
  /**
   * Creates (sends) a new chat message, returning the created ChatMessage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  sendMessage is AgentOperations.ResourceCreateWithServiceProvidedName<ChatMessage>;

  /**
   * Retrieves (reads) an existing chat message.
   */
  getMessage is AgentOperations.ResourceRead<ChatMessage>;

  /**
   * Updates an existing chat message (or creates if not found) and returns the updated message.
   */
  updateMessage is AgentOperations.ResourceCreateOrReplace<ChatMessage>;

  /**
   * Deletes a chat message. Returns 204 on success.
   */
  deleteMessage is AgentOperations.ResourceDelete<ChatMessage>;

  /**
   * Lists chat messages, returning a collection of ChatMessage objects.
   */
  listMessages is AgentOperations.ResourceList<ChatMessage>;
}

/**
 * THREADS
 *
 * Interface is rooted at /threads.
 */
interface Threads {
  /**
   * Creates a new Thread and returns it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  createThread is AgentOperations.ResourceCreateWithServiceProvidedName<Thread>;

  /**
   * Retrieves an existing thread by its ID.
   */
  getThread is AgentOperations.ResourceRead<Thread>;

  /**
   * Updates or replaces a thread by its ID, returning the updated Thread.
   */
  updateThread is AgentOperations.ResourceCreateOrReplace<Thread>;

  /**
   * Deletes a thread, returning 204 on success.
   */
  deleteThread is AgentOperations.ResourceDelete<Thread>;

  /**
   * Lists all threads, returning an array of Thread items.
   */
  listThreads is AgentOperations.ResourceList<Thread>;
}

/**
 * AGENTS
 *
 * Interface is rooted at /agents.
 * Includes standard resource operations + custom collection-level
 * and instance-level actions (complete, stream).
 */
interface Agents {
  /**
   * Creates a new Agent resource and returns it.
   *
   * @param body The Agent data to create.
   * @returns The newly created Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @post
  @route("/agents")
  createAgent is Operation<
    {
      ...AgentOptions;
    },
    Agent
  >;

  /**
   * Retrieves an existing Agent by its ID.
   *
   * @param agentId The ID of the Agent to retrieve.
   * @returns The requested Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @get
  @route("/agents/{agentId}")
  getAgent is Operation<
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
  updateAgent is Operation<
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
  deleteAgent is Operation<
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
  listAgents is Operation<NoRequest, Agent[]>;

  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  @Rest.action("stream")
  streamByAgent is AgentOperations.ResourceAction<
    Agent,
    {
      ...RunInputs;
    },
    Streams.Stream<StreamingUpdate>
  >;
}

/**
 * RUNS
 *
 * Interface is rooted at /runs.
 * Includes standard resource operations + custom collection-level
 * and instance-level actions (complete, stream).
 */
interface Runs {
  /**
   * Creates a run.
   * @route("/run")
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  createRun is AgentOperations.ResourceCreateWithServiceProvidedName<{
    ...RunInputs;
  }>;

  /**
   * Retrieves an existing run by its ID.
   * @route("/run/{run_id}")
   */
  @get
  getRun is AgentOperations.ResourceRead<Run>;

  /**
   * Create and stream run.
   * @route("/run/stream")
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  @post
  createAndStreamRun is AgentOperations.ResourceCollectionAction<
    Run,
    Run,
    Streams.Stream<StreamingUpdate>
  >;

  /**
   * Lists run inputs.
   * @route("/run/{run_id}")
   */
  @get
  listRunInputs is AgentOperations.ResourceList<RunInputs>;
}
