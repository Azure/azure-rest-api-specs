import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeAnalyticsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeAnalytics;
@doc("Azure Storage account information.")
@parentResource(DataLakeAnalyticsAccount)
model StorageAccountInformation
  is ProxyResource<StorageAccountInformationProperties> {
  @doc("The name of the Azure Storage account for which to retrieve the details.")
  @path
  @key("storageAccountName")
  @segment("storageAccounts")
  name: string;
}

@armResourceOperations
interface StorageAccountInformations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the specified Azure Storage account linked to the given Data Lake Analytics account.")
  @operationId("StorageAccounts_Get")
  get is ArmResourceRead<StorageAccountInformation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the specified Data Lake Analytics account to add an Azure Storage account.")
  @operationId("StorageAccounts_Add")
  add is ArmResourceCreateOrReplaceSync<StorageAccountInformation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the Data Lake Analytics account to replace Azure Storage blob account details, such as the access key and/or suffix.")
  @operationId("StorageAccounts_Update")
  update is ArmCustomPatchSync<
    StorageAccountInformation,
    UpdateStorageAccountParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the specified Data Lake Analytics account to remove an Azure Storage account.")
  @operationId("StorageAccounts_Delete")
  delete is ArmResourceDeleteSync<StorageAccountInformation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the first page of Azure Storage accounts, if any, linked to the specified Data Lake Analytics account. The response includes a link to the next page, if any.")
  @operationId("StorageAccounts_ListByAccount")
  listByAccount is ArmResourceListByParent<
    StorageAccountInformation,
    {
      ...BaseParameters<StorageAccountInformation>;

      @doc("The OData filter. Optional.")
      @query("$filter")
      $filter?: string;

      @doc("The number of items to return. Optional.")
      @minValue(1)
      @query("$top")
      $top?: int32;

      @doc("The number of items to skip over before returning elements. Optional.")
      @minValue(1)
      @query("$skip")
      $skip?: int32;

      @doc("OData Select statement. Limits the properties on each entry to just those requested, e.g. Categories?$select=CategoryName,Description. Optional.")
      @query("$select")
      $select?: string;

      @doc("OrderBy clause. One or more comma-separated expressions with an optional \"asc\" (the default) or \"desc\" depending on the order you'd like the values sorted, e.g. Categories?$orderby=CategoryName desc. Optional.")
      @query("$orderby")
      $orderby?: string;

      @doc("The Boolean value of true or false to request a count of the matching resources included with the resources in the response, e.g. Categories?$count=true. Optional.")
      @query("$count")
      $count?: boolean;
    }
  >;
}

@@projectedName(StorageAccountInformations.add::parameters.resource,
  "json",
  "parameters"
);
@@extension(StorageAccountInformations.add::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(StorageAccountInformations.add::parameters.resource,
  "The parameters containing the access key and optional suffix for the Azure Storage Account."
);
@@projectedName(StorageAccountInformations.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(StorageAccountInformations.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(StorageAccountInformations.update::parameters.properties,
  "The parameters containing the access key and suffix to update the storage account with, if any. Passing nothing results in no change."
);
