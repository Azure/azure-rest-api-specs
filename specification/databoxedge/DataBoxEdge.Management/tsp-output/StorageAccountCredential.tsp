import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
@doc("The storage account credential.")
@parentResource(DataBoxEdgeDevice)
model StorageAccountCredential
  is ProxyResource<StorageAccountCredentialProperties> {
  @doc("The storage account credential name.")
  @path
  @key("name")
  @segment("storageAccountCredentials")
  name: string;
}

@armResourceOperations
interface StorageAccountCredentials {
  @doc("Gets the properties of the specified storage account credential.")
  get is ArmResourceRead<StorageAccountCredential>;

  @doc("Creates or updates the storage account credential.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageAccountCredential>;

  @doc("Deletes the storage account credential.")
  delete is ArmResourceDeleteAsync<StorageAccountCredential>;

  @doc("Gets all the storage account credentials in a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<StorageAccountCredential>;
}

@@projectedName(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "json",
  "storageAccountCredential"
);
@@extension(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "storageAccountCredential"
);
@@doc(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "The storage account credential."
);
