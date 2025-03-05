import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-azure-resource legacy"
@doc("The storage container resource definition.")
@extension("x-ms-azure-resource", true)
model StorageContainer is TrackedResource<StorageContainerProperties> {
  @doc("Name of the storage container")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("storageContainerName")
  @segment("storageContainers")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface StorageContainers {
  @doc("Gets a storage container")
  get is ArmResourceRead<StorageContainer>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("The operation to create or update a storage container. Please note some properties can be set only during storage container creation.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    StorageContainer,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("The operation to update a storage container.")
  update is ArmTagsPatchAsync<StorageContainer>;

  @doc("The operation to delete a storage container.")
  delete is ArmResourceDeleteWithoutOkAsync<StorageContainer>;

  @doc("Lists all of the storage containers in the specified resource group. Use the nextLink property in the response to get the next page of storage containers.")
  listByResourceGroup is ArmResourceListByParent<StorageContainer>;

  @doc("Lists all of the storage containers in the specified subscription. Use the nextLink property in the response to get the next page of storage containers.")
  listAll is ArmListBySubscription<StorageContainer>;
}
