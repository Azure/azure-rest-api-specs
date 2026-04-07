import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./OracleSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The Agent resource definition.
 */
@parentResource(OracleSite)
model OracleAgent
  is Azure.ResourceManager.ProxyResource<AgentProperties, false> {
  ...ResourceNameParameter<
    Resource = OracleAgent,
    KeyName = "agentName",
    SegmentName = "agents",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface OracleAgents {
  /**
   * Gets the Agents resource.
   */
  get is ArmResourceRead<OracleAgent>;
  /**
   * Puts the Agents resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<OracleAgent>;
  /**
   * Patch the Agents resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<OracleAgent, PatchModel = AgentResourcePatch>;

  /**
   * Deletes the Agents resource.
   */
  delete is ArmResourceDeleteSync<OracleAgent>;

  /**
   * Lists the Agents resource in OracleSites.
   */
  listBySite is ArmResourceListByParent<
    OracleAgent,
    Response = ArmResponse<OracleAgentList>
  >;

  /**
   * Trigger Refresh action to refresh the OracleAgent resource.
   */
  @action("refresh")
  triggerRefresh is ArmResourceActionNoResponseContentAsync<OracleAgent, void>;
}

@@maxLength(OracleAgent.name, 63);
@@minLength(OracleAgent.name, 3);
@@doc(OracleAgent.name, "The name of agent");
@@doc(OracleAgent.properties, "Resource properties.");
@@doc(OracleAgents.createOrUpdate::parameters.resource,
  "The request body for creating or updating agent."
);
@@doc(OracleAgents.update::parameters.properties, "Agents patch payload.");
