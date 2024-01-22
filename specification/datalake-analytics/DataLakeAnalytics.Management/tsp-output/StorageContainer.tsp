import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccountInformation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeAnalytics;
/**
 * Azure Storage blob container information.
 */
@parentResource(StorageAccountInformation)
model StorageContainer is ProxyResource<StorageContainerProperties> {
  /**
   * The name of the Azure storage container to retrieve
   */
  @path
  @key("containerName")
  @segment("containers")
  name: string;
}

@armResourceOperations
interface StorageContainers {
  /**
   * Gets the specified Azure Storage container associated with the given Data Lake Analytics and Azure Storage accounts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageAccounts_GetStorageContainer")
  getStorageContainer is ArmResourceRead<StorageContainer>;

  /**
   * Lists the Azure Storage containers, if any, associated with the specified Data Lake Analytics and Azure Storage account combination. The response includes a link to the next page of results, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageAccounts_ListStorageContainers")
  listStorageContainers is ArmResourceListByParent<StorageContainer>;

  /**
   * Gets the SAS token associated with the specified Data Lake Analytics and Azure Storage account and container combination.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageAccounts_ListSasTokens")
  listSasTokens is ArmResourceActionSync<
    StorageContainer,
    void,
    SasTokenInformationListResult
  >;
}
