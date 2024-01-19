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
@doc("Represents a Storage Account on the  Data Box Edge/Gateway device.")
@parentResource(DataBoxEdgeDevice)
model StorageAccount is ProxyResource<StorageAccountProperties> {
  @doc("The storage account name.")
  @path
  @key("storageAccountName")
  @segment("storageAccounts")
  name: string;
}

@armResourceOperations
interface StorageAccounts {
  @doc("Gets a StorageAccount by name.")
  get is ArmResourceRead<StorageAccount>;

  @doc("Creates a new StorageAccount or updates an existing StorageAccount on the device.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageAccount>;

  @doc("Deletes the StorageAccount on the Data Box Edge/Data Box Gateway device.")
  delete is ArmResourceDeleteWithoutOkAsync<StorageAccount>;

  @doc("Lists all the StorageAccounts in a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<StorageAccount>;
}

@@projectedName(StorageAccounts.createOrUpdate::parameters.resource,
  "json",
  "storageAccount"
);
@@extension(StorageAccounts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "storageAccount"
);
@@doc(StorageAccounts.createOrUpdate::parameters.resource,
  "The StorageAccount properties."
);
