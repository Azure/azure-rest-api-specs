import "../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("Defines the NetworkBootstrapInterface resource.")
@parentResource(NetworkBootstrapDevice)
model NetworkBootstrapInterface
  is Azure.ResourceManager.ProxyResource<
    NetworkBootstrapInterfaceProperties,
    false
  > {
  @doc("Name of the Network Bootstrap Interface.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkBootstrapInterfaceName")
  @segment("networkBootstrapInterfaces")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(
  NetworkBootstrapInterface.properties,
  "The NetworkBootstrapInterface properties"
);
@armResourceOperations
@added(Versions.v2025_07_15)
interface NetworkBootstrapInterfaces {
  @doc("Get the Network Bootstrap Interface resource details.")
  get is ArmResourceRead<NetworkBootstrapInterface>;

  @doc("Create a Network Bootstrap Interface resource.")
  create is ArmResourceCreateOrReplaceAsync<NetworkBootstrapInterface>;

  @doc("Update certain properties of the Network Bootstrap Interface resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkBootstrapInterface,
    NetworkBootstrapInterfacePatch
  >;

  @doc("Delete the Network Bootstrap Interface resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkBootstrapInterface>;

  @doc("List all the Network Bootstrap Interface resources in a given resource group.")
  listByNetworkBootstrapDevice is ArmResourceListByParent<NetworkBootstrapInterface>;

  @doc("Update the admin state of the Network Interface.")
  @action("updateAdministrativeState")
  @sharedRoute
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkBootstrapInterface,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(
  NetworkBootstrapInterfaces.create::parameters.resource,
  "Request payload."
);
@@doc(
  NetworkBootstrapInterfaces.update::parameters.properties,
  "NetworkBootstrapInterface properties to update. Only tags are supported."
);
@@doc(
  NetworkBootstrapInterfaces.updateAdministrativeState::parameters.body,
  "Request payload."
);
