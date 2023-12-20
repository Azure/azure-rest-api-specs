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
@doc("The storage account credential.")
@parentResource(DataBoxEdgeDevice)
model DataBoxEdgeStorageAccountCredential
  is ProxyResource<StorageAccountCredentialProperties> {
  @doc("The storage account credential name.")
  @path
  @key("name")
  @segment("storageAccountCredentials")
  name: string;
}

@armResourceOperations
interface DataBoxEdgeStorageAccountCredentials {
  @doc("Gets the properties of the specified storage account credential.")
  get is ArmResourceRead<DataBoxEdgeStorageAccountCredential>;
  @doc("Creates or updates the storage account credential.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataBoxEdgeStorageAccountCredential>;
  @doc("Deletes the storage account credential.")
  delete is ArmResourceDeleteAsync<DataBoxEdgeStorageAccountCredential>;
  @doc("Gets all the storage account credentials in a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<DataBoxEdgeStorageAccountCredential>;
}
