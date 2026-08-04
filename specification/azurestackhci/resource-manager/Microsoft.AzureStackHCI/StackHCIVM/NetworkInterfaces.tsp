import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-azure-resource legacy"
@doc("The network interface resource definition.")
@extension("x-ms-azure-resource", true)
model NetworkInterface is TrackedResource<NetworkInterfaceProperties> {
  @doc("Name of the network interface")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface NetworkInterfaces {
  @doc("Gets a network interface")
  get is ArmResourceRead<NetworkInterface>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("The operation to create or update a network interface. Please note some properties can be set only during network interface creation.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkInterface,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("The operation to update a network interface.")
  @patch(#{ implicitOptionality: false })
  @removed(Versions.v2025_02_01_preview)
  @sharedRoute
  @renamedFrom(Versions.v2025_02_01_preview, "update")
  updateOld is ArmCustomPatchAsync<NetworkInterface>;

  @doc("The operation to update a network interface.")
  @patch(#{ implicitOptionality: false })
  @added(Versions.v2025_02_01_preview)
  @sharedRoute
  update is ArmCustomPatchAsync<
    NetworkInterface,
    NetworkInterfacesUpdateRequest
  >;

  @doc("The operation to delete a network interface.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkInterface>;

  @doc("Lists all of the network interfaces in the specified resource group. Use the nextLink property in the response to get the next page of network interfaces.")
  listByResourceGroup is ArmResourceListByParent<NetworkInterface>;

  @doc("Lists all of the network interfaces in the specified subscription. Use the nextLink property in the response to get the next page of network interfaces.")
  listAll is ArmListBySubscription<NetworkInterface>;
}
