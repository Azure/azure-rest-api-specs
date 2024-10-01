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
@added(ServiceApiVersions.v2024_02_15_preview)
@route("/agents")
op createAgent is Azure.Core.RpcOperation<
  {
    ...CreateAgentOptions
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
@added(ServiceApiVersions.v2024_02_15_preview)
@route("/agents")
op listAgents is Azure.Core.RpcOperation<
  {
    ...OpenAIListRequestOptions
  },
  OpenAIPageableListOf<Agent>
>;
