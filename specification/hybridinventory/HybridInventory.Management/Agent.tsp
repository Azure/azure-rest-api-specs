import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PgsqlSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridInventory;
/**
 * The Agent resource definition.
 */
@parentResource(PgsqlSite)
model Agent is Azure.ResourceManager.ProxyResource<AgentProperties, false> {
  ...ResourceNameParameter<
    Resource = Agent,
    KeyName = "agentName",
    SegmentName = "agents",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface Agents {
  /**
   * Gets the Agents resource.
   */
  get is ArmResourceRead<Agent>;

  /**
   * Puts the Agents resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Agent>;

  /**
   * Patch the Agents resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Agent, PatchModel = AgentResourcePatch>;

  /**
   * Deletes the Agents resource.
   */
  delete is ArmResourceDeleteSync<Agent>;

  /**
   * Lists the Agents resource in PGSQLSites.
   */
  listBySite is ArmResourceListByParent<
    Agent,
    Response = ArmResponse<AgentList>
  >;

  /**
   * Trigger Refresh Refresh action
   */
  // #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" ""
  @action("refresh")
  triggerRefresh is ArmResourceActionNoResponseContentAsync<Agent, void>;
}

@@maxLength(Agent.name, 63);
@@minLength(Agent.name, 3);
@@doc(Agent.name, "The name of agent");
@@doc(Agent.properties, "Resource properties.");
@@doc(Agents.createOrUpdate::parameters.resource,
  "The request body for creating or updating agent."
);
@@doc(Agents.update::parameters.properties, "Agents patch payload.");
