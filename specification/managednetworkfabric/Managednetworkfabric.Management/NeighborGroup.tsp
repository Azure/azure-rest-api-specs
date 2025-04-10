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
 * Defines the Neighbor Group.
 */
model NeighborGroup
  is Azure.ResourceManager.TrackedResource<NeighborGroupProperties, false> {
  ...ResourceNameParameter<
    Resource = NeighborGroup,
    KeyName = "neighborGroupName",
    SegmentName = "neighborGroups",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NeighborGroup, PatchModel = NeighborGroupPatch>;

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

@@doc(NeighborGroup.name, "Name of the Neighbor Group.");
@@doc(NeighborGroup.properties, "Resource properties.");
@@doc(NeighborGroups.create::parameters.resource, "Request payload.");
@@doc(NeighborGroups.update::parameters.properties,
  "Neighbor Group properties to update. Only annotations are supported."
);
