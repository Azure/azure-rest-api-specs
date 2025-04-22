import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@typespec/streams";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp"; // e.g. ChatMessage, Agent, Conversation
import "./runs/runs.tsp"; // e.g. RunInputs etc.
import "./streaming/streaming.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;
using Azure.ClientGenerator.Core;
using Streams;

namespace Azure.AI.Projects;

@doc("A no-op model to represent an empty request.")
model NoRequest {}

alias AgentOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("""
  MESSAGES
  
  The interface is rooted at /conversations/{conversationId}/messages.
  """)
interface Messages {
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Creates (sends) a new chat message, returning the created ChatMessage.")
  @post
  @route("/conversations/{conversationId}/messages")
  sendMessage is Operation<
    {
      @doc("The ID of the conversation.")
      @path
      conversationId: string;

      @doc("The message to create.")
      @body
      body: ChatMessage;
    },
    ChatMessage
  >;

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
  CONVERSATIONS
  
  Interface is rooted at /conversations.
  """)
interface Conversations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Creates a new Conversation and returns it.")
  @post
  @route("/conversations")
  createConversation is Operation<Conversation, Conversation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Retrieves an existing conversation by its ID.")
  @get
  @route("/conversations/{conversationId}")
  getConversation is Operation<
    {
      @doc("The identifier of the Conversation.")
      @path
      conversationId: string;
    },
    Conversation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Updates or replaces a conversation by its ID, returning the updated Conversation.")
  @put
  @route("/conversations/{conversationId}")
  updateConversation is Operation<
    {
      @doc("The identifier of the Conversation to update.")
      @path
      conversationId: string;

      @doc("The updated Conversation resource data.")
      @body
      body: Conversation;
    },
    Conversation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Deletes a conversation, returning 204 on success.")
  @delete
  @route("/conversations/{conversationId}")
  deleteConversation is Operation<
    {
      @doc("The ID of the conversation to delete.")
      @path
      conversationId: string;
    },
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Lists all conversations, returning an array of Conversation items.")
  @get
  @route("/conversations")
  listConversations is Operation<NoRequest, Conversation[]>;
}

@doc("""
  AGENTS
  
  Interface is rooted at /agents.
  Includes standard resource operations + custom collection-level
  and instance-level actions (complete, stream).
  """)
@clientName("AgentsClient", "csharp")
interface Agents {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Creates a new Agent resource and returns it.")
  @post
  @route("/agents")
  createAgent is Operation<
    {
      ...AgentConfigurationOptions;
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates and waits for a run to finish, returning the completed Run (including its outputs).")
  @post
  @route("/conversations/runs")
  run is Azure.Core.Foundations.Operation<
    {
      ...RunInputs;
    },
    Run
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  @Rest.action("stream")
  @post
  @route("/conversations/runs/stream")
  stream is Azure.Core.Foundations.Operation<
    {
      ...RunInputs;
    },
    Streams.Stream<StreamingUpdate>
  >;

  @doc("""
    Retrieves an existing run by its ID.
    @route("/conversations/runs/{run_id}")
    """)
  @get
  getRun is AgentOperations.ResourceRead<Run>;

  @doc("""
    Lists all run records, each containing runInputs and runOutputs.
    @route("/agents/runs")
    """)
  @get
  listRuns is AgentOperations.ResourceList<Run>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We want a custom operation name/shape."
  @doc("Lists the inputs for a specific run by its ID.")
  @get
  @route("/conversations/runs/{runId}/listInputs")
  listRunInputs is Operation<
    {
      @doc("The ID of the run.")
      @path
      runId: string;
    },
    RunInputs
  >;
}
