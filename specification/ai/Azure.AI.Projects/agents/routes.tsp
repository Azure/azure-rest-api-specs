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

@doc("A no-op model to represent an empty request.")
model NoRequest {}

alias AgentOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("""
  MESSAGES
  
  The interface is rooted at /messages.
  Each standard resource operation will produce REST endpoints
  like GET /messages/{name}, POST /messages, etc.
  The "name" or "id" parameter is inferred from Azure Core's naming patterns
  for resource operations.
  """)
interface Messages {
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  @doc("Creates (sends) a new chat message, returning the created ChatMessage.")
  sendMessage is AgentOperations.ResourceCreateWithServiceProvidedName<ChatMessage>;

  @doc("Retrieves (reads) an existing chat message.")
  getMessage is AgentOperations.ResourceRead<ChatMessage>;

  @doc("Updates an existing chat message (or creates if not found) and returns the updated message.")
  updateMessage is AgentOperations.ResourceCreateOrReplace<ChatMessage>;

  @doc("Deletes a chat message. Returns 204 on success.")
  deleteMessage is AgentOperations.ResourceDelete<ChatMessage>;

  @doc("Lists chat messages, returning a collection of ChatMessage objects.")
  listMessages is AgentOperations.ResourceList<ChatMessage>;
}

@doc("""
  THREADS
  
  Interface is rooted at /threads.
  """)
interface Threads {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Creates a new Thread and returns it.")
  @post
  @route("/threads")
  createThread is Operation<Thread, Thread>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Retrieves an existing thread by its ID.")
  @get
  @route("/threads/{threadId}")
  getThread is Operation<
    {
      @doc("The identifier of the Thread.")
      @path
      threadId: string;
    },
    Thread
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Updates or replaces a thread by its ID, returning the updated Thread.")
  @put
  @route("/threads/{threadId}")
  updateThread is Operation<
    {
      @doc("The identifier of the Thread to update.")
      @path
      threadId: string;

      @doc("The updated Thread resource data.")
      @body
      body: Thread;
    },
    Thread
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Deletes a thread, returning 204 on success.")
  @delete
  @route("/threads/{threadId}")
  deleteThread is Operation<
    {
      @doc("The ID of the thread to delete.")
      @path
      threadId: string;
    },
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Lists all threads, returning an array of Thread items.")
  @get
  @route("/threads")
  listThreads is Operation<NoRequest, Thread[]>;
}

@doc("""
  AGENTS
  
  Interface is rooted at /agents.
  Includes standard resource operations + custom collection-level
  and instance-level actions (complete, stream).
  """)
interface Agents {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Creates a new Agent resource and returns it.")
  @post
  @route("/agents")
  createAgent is Operation<
    {
      ...AgentOptions;
    },
    Agent
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Retrieves an existing Agent by its ID.")
  @get
  @route("/agents/{agentId}")
  getAgent is Operation<
    {
      @doc("The ID of the Agent to retrieve.")
      @path
      agentId: string;
    },
    Agent
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Updates or replaces an agent and returns the updated resource.")
  @put
  @route("/agents/{agentId}")
  updateAgent is Operation<
    {
      @doc("The ID of the Agent to update.")
      @path
      agentId: string;

      @doc("The updated Agent data.")
      @body
      body: Agent;
    },
    Agent
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Deletes an Agent by its ID, returning 204 on success.")
  @delete
  @route("/agents/{agentId}")
  deleteAgent is Operation<
    {
      @doc("The ID of the Agent to delete.")
      @path
      agentId: string;
    },
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Lists all Agents, returning an array of Agent objects.")
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

@doc("""
  RUNS
  
  Interface is rooted at /runs.
  Includes standard resource operations + custom collection-level
  and instance-level actions (complete, stream).
  """)
interface Runs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @post
  @route("/runs")
  @doc("Creates a new run.")
  createRun is Azure.Core.Foundations.Operation<
    {
      ...RunInputs;
    },
    Run
  >;

  @doc("""
    Retrieves an existing run by its ID.
    @route("/run/{run_id}")
    """)
  @get
  getRun is AgentOperations.ResourceRead<Run>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates and waits for a run to finish, returning the completed Run (including its outputs).")
  @post
  @route("/runs/execute")
  createAndExecuteRun is Azure.Core.Foundations.Operation<
    {
      ...RunInputs;
    },
    Run
  >;

  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  @doc("""
    Create and stream run.
    @route("/run/stream")
    """)
  @post
  createAndStreamRun is AgentOperations.ResourceCollectionAction<
    Run,
    Run,
    Streams.Stream<StreamingUpdate>
  >;

  @doc("""
    Lists all run records, each containing runInputs and runOutputs.
    @route("/runs")
    """)
  @get
  listRuns is AgentOperations.ResourceList<Run>;
}
