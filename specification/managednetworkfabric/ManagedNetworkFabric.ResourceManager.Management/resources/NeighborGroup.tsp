import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * Defines the Neighbor Group.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model NeighborGroup extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Neighbor Group.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("neighborGroupName")
  @segment("neighborGroups")
  @visibility("read")
  name: string;

  /** The NeighborGroup Properties */
  properties: NeighborGroupProperties;
}

@armResourceOperations
interface NeighborGroups {
  /**
   * Gets the Neighbor Group.
   */
  get is ArmResourceRead<NeighborGroup>;

  /**
   * Implements the Neighbor Group PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<NeighborGroup>;

  /**
   * Updates the Neighbor Group.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<NeighborGroup, NeighborGroupPatch>;

  /**
   * Implements Neighbor Group DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NeighborGroup>;

  /**
   * Displays NeighborGroups list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<NeighborGroup>;

  /**
   * Displays NeighborGroups list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<NeighborGroup>;
}

@@doc(NeighborGroups.create::parameters.resource, "Request payload.");
@@doc(NeighborGroups.update::parameters.properties,
  "Neighbor Group properties to update. Only annotations are supported."
);
