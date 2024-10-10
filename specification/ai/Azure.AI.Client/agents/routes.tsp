import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Client.Agents;

/**
 * Creates a new agent.
 *
 * @returns The new agent instance.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/assistants")
op createAgent is Azure.Core.Foundations.Operation<
  {
    ...CreateAgentOptions;
  },
  Agent
>;

/**
 * Gets a list of agents that were previously created.
 *
 * @returns The requested list of agents.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/assistants")
op listAgents is Azure.Core.Foundations.Operation<
  {
    ...OpenAIListRequestOptions;
  },
  OpenAIPageableListOf<Agent>
>;

/**
 * Retrieves an existing agent.
 *
 * @param assistantId The ID of the agent to retrieve.
 * @returns The requested agent instance.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/assistants/{assistantId}")
op getAgent is Azure.Core.Foundations.Operation<
  {
    @doc("Identifier of the agent.")
    @path
    assistantId: string;
  },
  Agent
>;

/**
 * Modifies an existing agent.
 *
 * @param updateAgentOptions The details of the modification to perform on a specified agent.
 * @returns The updated agent instance.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/assistants/{assistantId}")
op updateAgent is Azure.Core.Foundations.Operation<
  {
    /**
     * The request details to use when modifying an existing agent.
     */
    ...UpdateAgentOptions;
  },
  Agent
>;

/**
 * Deletes an agent.
 *
 * @param assistantId The ID of the agent to delete.
 * @returns Status information about the requested deletion operation.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@route("/assistants/{assistantId}")
op deleteAgent is Azure.Core.Foundations.Operation<
  {
    @doc("Identifier of the agent.")
    @path
    assistantId: string;
  },
  AgentDeletionStatus
>;
