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
@doc("Defines the External Network resource.")
@parentResource(L3IsolationDomain)
model ExternalNetwork is ProxyResource<ExternalNetworkProperties> {
  @doc("Name of the External Network.")
  @path
  @key("externalNetworkName")
  @segment("externalNetworks")
  name: string;
}

@armResourceOperations
interface ExternalNetworks {
  @doc("Implements ExternalNetworks GET method.")
  get is ArmResourceRead<ExternalNetwork>;
  @doc("Creates ExternalNetwork PUT method.")
  create is ArmResourceCreateOrUpdateAsync<ExternalNetwork>;
  @doc("API to update certain properties of the ExternalNetworks resource.")
  update is ArmResourcePatchAsync<ExternalNetwork, ExternalNetworkProperties>;
  @doc("Implements ExternalNetworks DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<ExternalNetwork>;
  @doc("Implements External Networks list by resource group GET method.")
  listByL3IsolationDomain is ArmResourceListByParent<ExternalNetwork>;
  @doc("Executes update operation to enable or disable administrative State for externalNetwork.")
  updateAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Update Static Route BFD for external Network.")
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}
