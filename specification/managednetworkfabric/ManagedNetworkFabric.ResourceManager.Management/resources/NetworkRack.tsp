import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Rack resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model NetworkRack extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Network Rack.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkRackName")
  @segment("networkRacks")
  @visibility("read")
  name: string;

  /** The NetworkRack properties */
  properties: NetworkRackProperties;
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
  @parameterVisibility
  update is ArmCustomPatchAsync<NetworkRack, NetworkRackPatch>;

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

@@doc(NetworkRacks.create::parameters.resource, "Request payload.");
@@doc(NetworkRacks.update::parameters.properties,
  "Network Rack properties to update."
);
