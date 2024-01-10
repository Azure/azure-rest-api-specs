import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccountInformation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataLakeAnalytics;
@doc("Azure Storage blob container information.")
@parentResource(StorageAccountInformation)
model StorageContainer is ProxyResource<StorageContainerProperties> {
  @doc("The name of the Azure storage container to retrieve")
  @key("containerName")
  @segment("containers")
  name: string;
}

@armResourceOperations
@projectedName("client", "StorageAccounts")
interface StorageContainers_StorageAccounts {
  @doc("Gets the specified Azure Storage container associated with the given Data Lake Analytics and Azure Storage accounts.")
  getStorageContainer is ArmResourceRead<StorageContainer>;

  @doc("Lists the Azure Storage containers, if any, associated with the specified Data Lake Analytics and Azure Storage account combination. The response includes a link to the next page of results, if any.")
  listStorageContainers is ArmResourceListByParent<StorageContainer>;

  @doc("Gets the SAS token associated with the specified Data Lake Analytics and Azure Storage account and container combination.")
  listSasTokens is ArmResourceActionSync<
    StorageContainer,
    void,
    SasTokenInformationListResult
  >;
}
