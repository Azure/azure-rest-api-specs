import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Network Rack resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkRack extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network Rack.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkRackName")
  @segment("networkRacks")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkRack properties */
  properties: NetworkRackProperties;
}

@armResourceOperations
interface NetworkRacks {
  @doc("Get Network Rack resource details.")
  get is ArmResourceRead<NetworkRack>;

  @doc("Create Network Rack resource.")
  create is ArmResourceCreateOrReplaceAsync<NetworkRack>;

  @doc("Update certain properties of the Network Rack resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkRack, NetworkRackPatch>;

  @doc("Delete Network Rack resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkRack>;

  @doc("List all Network Rack resources in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkRack>;

  @doc("List all Network Rack resources in the given subscription")
  listBySubscription is ArmListBySubscription<NetworkRack>;
}

@@doc(NetworkRacks.create::parameters.resource, "Request payload.");
@@doc(NetworkRacks.update::parameters.properties,
  "Network Rack properties to update."
);
