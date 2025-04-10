import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Rack resource definition.
 */
model NetworkRack
  is Azure.ResourceManager.TrackedResource<NetworkRackProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkRack,
    KeyName = "networkRackName",
    SegmentName = "networkRacks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NetworkRacks {
  /**
   * Get Network Rack resource details.
   */
  get is ArmResourceRead<NetworkRack>;

  /**
   * Create Network Rack resource.
   */
  create is ArmResourceCreateOrReplaceAsync<NetworkRack>;

  /**
   * Update certain properties of the Network Rack resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkRack, PatchModel = TagsUpdate>;

  /**
   * Delete Network Rack resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkRack>;

  /**
   * List all Network Rack resources in the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<NetworkRack>;

  /**
   * List all Network Rack resources in the given subscription
   */
  listBySubscription is ArmListBySubscription<NetworkRack>;
}

@@doc(NetworkRack.name, "Name of the Network Rack.");
@@doc(NetworkRack.properties, "Resource properties.");
@@doc(NetworkRacks.create::parameters.resource, "Request payload.");
@@doc(NetworkRacks.update::parameters.properties,
  "Network Rack properties to update."
);
