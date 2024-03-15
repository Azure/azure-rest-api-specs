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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("The storage container resource definition.")
@includeInapplicableMetadataInPayload(false)
model StorageContainer is TrackedResource<VirtualHardDiskProperties> {
  @doc("Name of the storage container")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  @path
  @key("storageContainerName")
  @segment("storageContainers")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@projectedName("client", "StorageContainers")
interface StorageContainers {
  @doc("Gets a storage container")
  get is ArmResourceRead<StorageContainer>;

  @doc("The operation to create or update a storage container. Please note some properties can be set only during storage container creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    StorageContainer,
    LroHeaders = ArmAsyncOperationHeader
  >;

  @doc("The operation to update a storage container.")
  @parameterVisibility("read")
  update is ArmTagsPatchAsync<
    StorageContainer,
    LroHeaders = ArmAsyncOperationHeader
  >;

  @doc("The operation to delete a storage container.")
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageContainer,
    LroHeaders = ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the storage containers in the specified resource group. Use the nextLink property in the response to get the next page of storage containers.")
  @operationId("StorageContainers_List")
  list is ArmResourceListByParent<StorageContainer>;

  @doc("Lists all of the storage containers in the specified subscription. Use the nextLink property in the response to get the next page of storage containers.")
  listAll is ArmListBySubscription<StorageContainer>;
}
