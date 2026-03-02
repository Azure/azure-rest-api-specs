import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;

/**
 * A network agent resource definition.
 */
@parentResource(NetworkSite)
model NetworkAgent
  is Azure.ResourceManager.ProxyResource<NetworkAgentProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkAgent,
    KeyName = "agentName",
    SegmentName = "agents",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface NetworkAgents {
  /**
   * Gets the NetworkAgent resource.
   */
  get is ArmResourceRead<NetworkAgent>;

  /**
   * Creates or updates the NetworkAgent resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NetworkAgent>;

  /**
   * Patches the NetworkAgent resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NetworkAgent, NetworkAgentPatchProperties>;

  /**
   * Deletes the NetworkAgent resource.
   */
  delete is ArmResourceDeleteSync<NetworkAgent>;

  /**
   * Lists NetworkAgent resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NetworkAgent,
    Response = ArmResponse<NetworkAgentList>
  >;
}

@@maxLength(NetworkAgent.name, 63);
@@minLength(NetworkAgent.name, 3);
@@doc(NetworkAgent.name, "The name of the network agent.");
@@doc(NetworkAgent.properties, "Resource properties.");
