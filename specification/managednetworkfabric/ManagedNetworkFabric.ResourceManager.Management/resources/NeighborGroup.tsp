import "../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("Defines the Neighbor Group.")
model NeighborGroup
  is Azure.ResourceManager.TrackedResource<NeighborGroupProperties, false> {
  @doc("Name of the Neighbor Group.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("neighborGroupName")
  @segment("neighborGroups")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@@doc(NeighborGroup.properties, "The NeighborGroup Properties");
@armResourceOperations
interface NeighborGroups {
  @doc("Gets the Neighbor Group.")
  get is ArmResourceRead<NeighborGroup>;

  @doc("Implements the Neighbor Group PUT method.")
  create is ArmResourceCreateOrReplaceAsync<NeighborGroup>;

  @doc("Updates the Neighbor Group.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NeighborGroup, NeighborGroupPatch>;

  @doc("Implements Neighbor Group DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NeighborGroup>;

  @doc("Displays NeighborGroups list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<
    NeighborGroup,
    Response = NeighborGroupsListResult
  >;

  @doc("Displays NeighborGroups list by subscription GET method.")
  listBySubscription is ArmListBySubscription<
    NeighborGroup,
    Response = NeighborGroupsListResult
  >;

  @doc("Resync the Neighbor Group after a configuration change.")
  @added(Versions.v2025_07_15)
  resync is ArmResourceActionAsync<
    NeighborGroup,
    void,
    NeighborGroupResyncResponse
  >;
}

@@doc(NeighborGroups.create::parameters.resource, "Request payload.");
@@doc(
  NeighborGroups.update::parameters.properties,
  "Neighbor Group properties to update. Only annotations are supported."
);
