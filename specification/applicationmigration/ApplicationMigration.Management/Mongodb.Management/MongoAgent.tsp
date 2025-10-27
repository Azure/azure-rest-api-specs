import "./MongoSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The Agent resource definition.
 */
@parentResource(MongoSite)
model MongoAgent
  is Azure.ResourceManager.ProxyResource<AgentProperties, false> {
  ...ResourceNameParameter<
    Resource = MongoAgent,
    KeyName = "agentName",
    SegmentName = "agents",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface MongoAgents {
  /**
   * Gets the Agents resource.
   */
  get is ArmResourceRead<MongoAgent>;

  /**
   * Puts the Agents resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MongoAgent>;

  /**
   * Patch the Agents resource.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.ClientGenerator.Core.convenientAPI(false, "!javascript, !csharp")
  update is ArmCustomPatchSync<MongoAgent, PatchModel = AgentResourcePatch>;

  /**
   * Deletes the Agents resource.
   */
  delete is ArmResourceDeleteSync<MongoAgent>;

  /**
   * Lists the Agents resource in MongoSites.
   */
  listBySite is ArmResourceListByParent<
    MongoAgent,
    Response = ArmResponse<MongoAgentList>
  >;

  /**
   * Trigger Refresh Refresh action
   */
  // #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" ""
  @action("refresh")
  triggerRefresh is ArmResourceActionNoResponseContentAsync<MongoAgent, void>;
}

@@maxLength(MongoAgent.name, 63);
@@minLength(MongoAgent.name, 3);
@@doc(MongoAgent.name, "The name of agent");
@@doc(MongoAgent.properties, "Resource properties.");
@@doc(MongoAgents.createOrUpdate::parameters.resource,
  "The request body for creating or updating agent."
);
@@doc(MongoAgents.update::parameters.properties, "Agents patch payload.");
