import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MySQLSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MySqlDiscovery;
/**
 * The Agent resource definition.
 */
@parentResource(MySQLSite)
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Agent>;

  /**
   * Patch the Agents resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<Agent, PatchModel = AgentResourcePatch>;

  /**
   * Deletes the Agents resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Agent>;

  /**
   * Lists the Agents resource in MySQLSites.
   */
  listBySite is ArmResourceListByParent<
    Agent,
    Response = ArmResponse<AgentList>
  >;

  /**
   * Trigger Refresh Refresh action
   */
  @action("refresh")
  triggerRefresh is ArmResourceActionAsync<Agent, void, void>;
}

@@maxLength(Agent.name, 63);
@@minLength(Agent.name, 3);
@@doc(Agent.name, "The name of agent");
@@doc(Agent.properties, "Resource properties.");
@@doc(Agents.createOrUpdate::parameters.resource,
  "The request body for creating or updating agent."
);
@@doc(Agents.update::parameters.properties, "Agents patch payload.");
