import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./L3IsolationDomain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
@doc("Defines the Internal Network resource.")
@parentResource(L3IsolationDomain)
model InternalNetwork is ProxyResource<InternalNetworkProperties> {
  @doc("Name of the Internal Network.")
  @path
  @key("internalNetworkName")
  @segment("internalNetworks")
  name: string;
}

@armResourceOperations
interface InternalNetworks {
  @doc("Gets a InternalNetworks.")
  get is ArmResourceRead<InternalNetwork>;
  @doc("Creates InternalNetwork PUT method.")
  create is ArmResourceCreateOrUpdateAsync<InternalNetwork>;
  @doc("Updates a InternalNetworks.")
  update is ArmResourcePatchAsync<InternalNetwork, InternalNetworkProperties>;
  @doc("Implements InternalNetworks DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<InternalNetwork>;
  @doc("Displays InternalNetworks list by resource group GET method.")
  listByL3IsolationDomain is ArmResourceListByParent<InternalNetwork>;
  @doc("Update Administrative state of  InternalNetworks on resources referred by their resource ids.")
  updateAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Update BGP state for internalNetwork. Allowed only on edge devices.")
  updateBgpAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Update Static Route BFD administrative state for internalNetwork.")
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}
