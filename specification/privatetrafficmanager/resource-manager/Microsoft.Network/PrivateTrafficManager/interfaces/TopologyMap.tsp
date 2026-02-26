import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using Azure.ResourceManager;

namespace Microsoft.Network;

@@doc(TopologyMap.name, "The name of the Topology Map.");
@@doc(TopologyMap.properties, "The properties of the Topology Map.");
@doc("Class representing a Topology Map.")
model TopologyMap is TrackedResource<TopologyMapProperties> {
  ...ResourceNameParameter<TopologyMap>;
}

@@doc(TopologyMaps.createOrUpdate::parameters.resource,
  "The Topology Map parameters supplied to the CreateOrUpdate operation."
);
@armResourceOperations
interface TopologyMaps {
  @doc("Gets a Topology Map.")
  get is ArmResourceRead<TopologyMap>;

  @doc("Create or update a Topology Map.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TopologyMap>;

  @doc("Updates a Topology Map.")
  update is ArmResourcePatchAsync<TopologyMap, TopologyMapProperties>;

  @doc("Deletes a Topology Map.")
  delete is ArmResourceDeleteWithoutOkAsync<TopologyMap>;

  @doc("Lists all Topology Maps within a resource group.")
  listByResourceGroup is ArmResourceListByParent<TopologyMap>;

  @doc("Lists all Topology Maps within a subscription.")
  listBySubscription is ArmListBySubscription<TopologyMap>;
}
