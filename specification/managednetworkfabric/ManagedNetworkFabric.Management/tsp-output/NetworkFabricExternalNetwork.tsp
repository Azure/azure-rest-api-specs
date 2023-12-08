import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkFabricL3IsolationDomain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("Defines the External Network resource.")
@parentResource(NetworkFabricL3IsolationDomain)
model NetworkFabricExternalNetwork is ProxyResource<ExternalNetworkProperties> {
  @doc("Name of the External Network.")
  @path
  @key("externalNetworkName")
  @segment("externalNetworks")
  name: string;
}

@armResourceOperations
interface NetworkFabricExternalNetworks {
  @doc("Implements ExternalNetworks GET method.")
  get is ArmResourceRead<NetworkFabricExternalNetwork>;
  @doc("Creates ExternalNetwork PUT method.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabricExternalNetwork>;
  @doc("API to update certain properties of the ExternalNetworks resource.")
  update is ArmResourcePatchAsync<
    NetworkFabricExternalNetwork,
    ExternalNetworkProperties
  >;
  @doc("Implements ExternalNetworks DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricExternalNetwork>;
  @doc("Implements External Networks list by resource group GET method.")
  listByL3IsolationDomain is ArmResourceListByParent<NetworkFabricExternalNetwork>;
  @doc("Executes update operation to enable or disable administrative State for externalNetwork.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkFabricExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Update Static Route BFD for external Network.")
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    NetworkFabricExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}
