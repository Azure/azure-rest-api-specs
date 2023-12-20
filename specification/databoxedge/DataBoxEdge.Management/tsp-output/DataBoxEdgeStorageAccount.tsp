import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
@doc("Represents a Storage Account on the  Data Box Edge/Gateway device.")
@parentResource(DataBoxEdgeDevice)
model DataBoxEdgeStorageAccount is ProxyResource<StorageAccountProperties> {
  @doc("The storage account name.")
  @path
  @key("storageAccountName")
  @segment("storageAccounts")
  name: string;
}

@armResourceOperations
interface DataBoxEdgeStorageAccounts {
  @doc("Gets a StorageAccount by name.")
  get is ArmResourceRead<DataBoxEdgeStorageAccount>;
  @doc("Creates a new StorageAccount or updates an existing StorageAccount on the device.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataBoxEdgeStorageAccount>;
  @doc("Deletes the StorageAccount on the Data Box Edge/Data Box Gateway device.")
  delete is ArmResourceDeleteWithoutOkAsync<DataBoxEdgeStorageAccount>;
  @doc("Lists all the StorageAccounts in a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<DataBoxEdgeStorageAccount>;
}
