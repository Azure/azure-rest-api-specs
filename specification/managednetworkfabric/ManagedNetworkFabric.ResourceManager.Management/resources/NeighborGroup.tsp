import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the Neighbor Group.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model NeighborGroup extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Neighbor Group.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("neighborGroupName")
  @segment("neighborGroups")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NeighborGroup Properties */
  properties: NeighborGroupProperties;
}

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
  listByResourceGroup is ArmResourceListByParent<NeighborGroup>;

  @doc("Displays NeighborGroups list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NeighborGroup>;
}

@@doc(NeighborGroups.create::parameters.resource, "Request payload.");
@@doc(NeighborGroups.update::parameters.properties,
  "Neighbor Group properties to update. Only annotations are supported."
);
