import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Represents a Storage Account on the  Data Box Edge/Gateway device.
 */
@parentResource(DataBoxEdgeDevice)
model StorageAccount
  is Azure.ResourceManager.ProxyResource<StorageAccountProperties, false> {
  ...ResourceNameParameter<
    Resource = StorageAccount,
    KeyName = "storageAccountName",
    SegmentName = "storageAccounts",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    StorageAccount,
    Response = ArmResourceUpdatedResponse<StorageAccount> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = StorageAccount> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the StorageAccount on the Data Box Edge/Data Box Gateway device.
   */
  delete is ArmResourceDeleteWithoutOkAsync<StorageAccount>;

  /**
   * Lists all the StorageAccounts in a Data Box Edge/Data Box Gateway device.
   */
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    StorageAccount,
    Response = ArmResponse<StorageAccountList>
  >;
}

@@doc(StorageAccount.name, "The storage account name.");
@@doc(StorageAccount.properties, "The Storage Account properties.");
@@doc(StorageAccounts.createOrUpdate::parameters.resource,
  "The StorageAccount properties."
);
