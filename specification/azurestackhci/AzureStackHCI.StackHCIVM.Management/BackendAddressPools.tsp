import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@added(Versions.v2025_09_01_preview)
@doc("BackendAddressPool resource.")
@parentResource(LoadBalancer)
model BackendAddressPool is ProxyResource<BackendAddressPoolProperties> {
  @doc("Name of the backend address pool.")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("backendAddressPoolName")
  @segment("backendAddressPools")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface BackendAddressPools {
  @doc("Gets the specified backendAddressPool.")
  get is ArmResourceRead<BackendAddressPool>;

  @doc("Creates or updates a backendAddressPool in the specified resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BackendAddressPool>;

  @doc("Deletes the specified backendAddressPool.")
  delete is ArmResourceDeleteWithoutOkAsync<BackendAddressPool>;

  @doc("Gets all backendAddressPools in a LoadBalancer.")
  listByNetworkSecurityGroup is ArmResourceListByParent<BackendAddressPool>;
}
