import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
@doc("The network interface resource definition.")
model NetworkInterfaces is TrackedResource<NetworkInterfaceProperties> {
  @doc("Name of the network interface")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@projectedName("client", "NetworkInterfaces")
interface NetworkInterfacesOperationGroup {
  @doc("Gets a network interface")
  get is ArmResourceRead<NetworkInterfaces>;

  @doc("The operation to create or update a network interface. Please note some properties can be set only during network interface creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NetworkInterfaces,
    BaseParameters<NetworkInterfaces>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to update a network interface.")
  update is ArmCustomPatchAsync<
    NetworkInterfaces,
    NetworkInterfacesUpdateRequest,
    BaseParameters<NetworkInterfaces>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to delete a network interface.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkInterfaces,
    BaseParameters<NetworkInterfaces>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists all of the network interfaces in the specified resource group. Use the nextLink property in the response to get the next page of network interfaces.")
  list is ArmResourceListByParent<NetworkInterfaces>;

  @doc("Lists all of the network interfaces in the specified subscription. Use the nextLink property in the response to get the next page of network interfaces.")
  listAll is ArmListBySubscription<NetworkInterfaces>;
}

@@projectedName(NetworkInterfacesOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "networkInterfaces"
);
@@extension(NetworkInterfacesOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "networkInterfaces"
);
@@doc(NetworkInterfacesOperationGroup.createOrUpdate::parameters.resource, "");
@@projectedName(NetworkInterfacesOperationGroup.update::parameters.properties,
  "json",
  "networkInterfaces"
);
@@extension(NetworkInterfacesOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "networkInterfaces"
);
@@doc(NetworkInterfacesOperationGroup.update::parameters.properties, "");
