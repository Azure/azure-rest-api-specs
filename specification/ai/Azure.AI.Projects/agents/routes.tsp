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
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  createAgent is AgentOperations.ResourceCreateWithServiceProvidedName<Agent>;

  /**
   * Retrieves an existing Agent by its ID.
   */
  getAgent is AgentOperations.ResourceRead<Agent>;

  /**
   * Updates or replaces an agent and returns the updated resource.
   */
  updateAgent is AgentOperations.ResourceCreateOrReplace<Agent>;

  /**
   * Deletes an Agent by its ID, returning 204 on success.
   */
  deleteAgent is AgentOperations.ResourceDelete<Agent>;

  /**
   * Lists all Agents, returning an array of Agent objects.
   */
  listAgents is AgentOperations.ResourceList<Agent>;

  @Rest.action("run")
  runByAgent is AgentOperations.ResourceAction<
    Agent,
    { ... RunInputs },
    Run
  >;

  @Rest.action("stream")
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  streamByAgent is AgentOperations.ResourceAction<
    Agent,
    { ... RunInputs },
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
  @route("/run")
     */
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  createRun is AgentOperations.ResourceCreateWithServiceProvidedName<Run>;

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
  @post
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
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