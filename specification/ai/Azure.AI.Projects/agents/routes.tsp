import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@typespec/streams";
import "./models.tsp"; // e.g. ChatMessage, Agent, Thread
import "./completions/completions.tsp"; // e.g. CompleteParams, AgentCompleteParams, etc.

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;
using Streams;

namespace Azure.AI.Projects.Agents;

/**
 * Bundle standard Azure behaviors into a single alias (client request IDs,
 * no conditional requests, no repeatable requests, etc.).
 */
alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

/**
 * An alias for standard Azure resource operations with our chosen traits.
 * This grants us ResourceRead, ResourceList, ResourceCreateOrReplace, etc.
 */
alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

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
  sendMessage is Operations.ResourceCreateWithServiceProvidedName<ChatMessage>;

  /**
   * Retrieves (reads) an existing chat message.
   */
  getMessage is Operations.ResourceRead<ChatMessage>;

  /**
   * Updates an existing chat message (or creates if not found) and returns the updated message.
   */
  updateMessage is Operations.ResourceCreateOrReplace<ChatMessage>;

  /**
   * Deletes a chat message. Returns 204 on success.
   */
  deleteMessage is Operations.ResourceDelete<ChatMessage>;

  /**
   * Lists chat messages, returning a collection of ChatMessage objects.
   */
  listMessages is Operations.ResourceList<ChatMessage>;
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
  createThread is Operations.ResourceCreateWithServiceProvidedName<Thread>;

  /**
   * Retrieves an existing thread by its ID.
   */
  getThread is Operations.ResourceRead<Thread>;

  /**
   * Updates or replaces a thread by its ID, returning the updated Thread.
   */
  updateThread is Operations.ResourceCreateOrReplace<Thread>;

  /**
   * Deletes a thread, returning 204 on success.
   */
  deleteThread is Operations.ResourceDelete<Thread>;

  /**
   * Lists all threads, returning an array of Thread items.
   */
  listThreads is Operations.ResourceList<Thread>;
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
  createAgent is Operations.ResourceCreateWithServiceProvidedName<Agent>;

  /**
   * Retrieves an existing Agent by its ID.
   */
  getAgent is Operations.ResourceRead<Agent>;

  /**
   * Updates or replaces an agent and returns the updated resource.
   */
  updateAgent is Operations.ResourceCreateOrReplace<Agent>;

  /**
   * Deletes an Agent by its ID, returning 204 on success.
   */
  deleteAgent is Operations.ResourceDelete<Agent>;

  /**
   * Lists all Agents, returning an array of Agent objects.
   */
  listAgents is Operations.ResourceList<Agent>;

  /**
   * Requests a completion for the entire “Agents” collection,\nusing CompleteParams as input and returning an AgentCompletion.
   */
  complete is Operations.ResourceCollectionAction<
    Agent,
    CompleteParams,
    AgentCompletion
  >;

  /**
   * Requests a streaming completion for the entire “Agents” collection,\nreturning a stream of StreamingAgentCompletionUpdate items.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  stream is Operations.ResourceCollectionAction<
    Agent,
    {
      ...CompleteParams;
    },
    Streams.Stream<StreamingAgentCompletionUpdate>
  >;

  /**
   * Requests a completion for a specific Agent, returning an AgentCompletion.
   */
  @action("complete")
  completeByAgent is Operations.ResourceAction<
    Agent,
    {
      ...AgentCompleteParams;
    },
    AgentCompletion
  >;

  /**
   * Requests a streaming completion for a specific Agent, returning a stream of updates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  @action("stream")
  streamByAgent is Operations.ResourceAction<
    Agent,
    {
      ...AgentCompleteParams;
    },
    Streams.Stream<StreamingAgentCompletionUpdate>
  >;
}
