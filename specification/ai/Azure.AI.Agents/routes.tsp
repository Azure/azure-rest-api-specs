import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Agents;

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
@added(Versions.v2025_05_01)
op createAgent is AgentOperation<
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
@list
@added(Versions.v2025_05_01)
op listAgents(...ApiVersionParameter, ...AgentsListOptions): {
  ...AgentsPagedResult<Agent>;
} | AgentV1Error;

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
@added(Versions.v2025_05_01)
op getAgent is AgentOperation<
  {
    /**
     * The request details to use when retrieving an agent.
     */
    ...GetAgentOptions;
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
@added(Versions.v2025_05_01)
op updateAgent is AgentOperation<
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
@added(Versions.v2025_05_01)
op deleteAgent is AgentOperation<
  {
    /**
     * The request details to use when deleting an agent.
     */
    ...DeleteAgentOptions;
  },
  AgentDeletionStatus
>;
