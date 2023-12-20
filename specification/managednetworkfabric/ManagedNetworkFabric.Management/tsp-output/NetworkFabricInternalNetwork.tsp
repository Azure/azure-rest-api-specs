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
@doc("Defines the Internal Network resource.")
@parentResource(NetworkFabricL3IsolationDomain)
model NetworkFabricInternalNetwork is ProxyResource<InternalNetworkProperties> {
  @doc("Name of the Internal Network.")
  @path
  @key("internalNetworkName")
  @segment("internalNetworks")
  name: string;
}

@armResourceOperations
interface NetworkFabricInternalNetworks {
  @doc("Gets a InternalNetworks.")
  get is ArmResourceRead<NetworkFabricInternalNetwork>;
  @doc("Creates InternalNetwork PUT method.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabricInternalNetwork>;
  @doc("Updates a InternalNetworks.")
  update is ArmResourcePatchAsync<
    NetworkFabricInternalNetwork,
    InternalNetworkProperties
  >;
  @doc("Implements InternalNetworks DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricInternalNetwork>;
  @doc("Displays InternalNetworks list by resource group GET method.")
  listByL3IsolationDomain is ArmResourceListByParent<NetworkFabricInternalNetwork>;
  @doc("Update Administrative state of  InternalNetworks on resources referred by their resource ids.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkFabricInternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Update BGP state for internalNetwork. Allowed only on edge devices.")
  updateBgpAdministrativeState is ArmResourceActionAsync<
    NetworkFabricInternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Update Static Route BFD administrative state for internalNetwork.")
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    NetworkFabricInternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}
