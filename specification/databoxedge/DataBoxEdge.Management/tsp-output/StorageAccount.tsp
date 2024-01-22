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
/**
 * Represents a Storage Account on the  Data Box Edge/Gateway device.
 */
@parentResource(DataBoxEdgeDevice)
model StorageAccount is ProxyResource<StorageAccountProperties> {
  /**
   * The storage account name.
   */
  @path
  @key("storageAccountName")
  @segment("storageAccounts")
  name: string;
}

@armResourceOperations
interface StorageAccounts {
  /**
   * Gets a StorageAccount by name.
   */
  get is ArmResourceRead<StorageAccount>;

  /**
   * Creates a new StorageAccount or updates an existing StorageAccount on the device.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageAccount>;

  /**
   * Deletes the StorageAccount on the Data Box Edge/Data Box Gateway device.
   */
  delete is ArmResourceDeleteWithoutOkAsync<StorageAccount>;

  /**
   * Lists all the StorageAccounts in a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageAccounts_ListByDataBoxEdgeDevice")
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
