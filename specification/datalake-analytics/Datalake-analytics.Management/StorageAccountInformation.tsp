import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeAnalyticsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeAnalytics;
/**
 * Azure Storage account information.
 */
@parentResource(DataLakeAnalyticsAccount)
model StorageAccountInformation
  is Azure.ResourceManager.ProxyResource<StorageAccountInformationProperties> {
  ...ResourceNameParameter<
    Resource = StorageAccountInformation,
    KeyName = "storageAccountName",
    SegmentName = "storageAccounts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface StorageAccountInformations {
  /**
   * Gets the specified Azure Storage account linked to the given Data Lake Analytics account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageAccounts_Get")
  get is ArmResourceRead<StorageAccountInformation>;

  /**
   * Updates the specified Data Lake Analytics account to add an Azure Storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("StorageAccounts_Add")
  add is ArmResourceCreateOrReplaceSync<
    StorageAccountInformation,
    Response = OkResponse
  >;

  /**
   * Updates the Data Lake Analytics account to replace Azure Storage blob account details, such as the access key and/or suffix.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("StorageAccounts_Update")
  update is ArmCustomPatchSync<
    StorageAccountInformation,
    PatchModel = UpdateStorageAccountParameters,
    Response = OkResponse
  >;

  /**
   * Updates the specified Data Lake Analytics account to remove an Azure Storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("StorageAccounts_Delete")
  delete is ArmResourceDeleteSync<
    StorageAccountInformation,
    Response = ArmDeletedResponse
  >;

  /**
   * Gets the first page of Azure Storage accounts, if any, linked to the specified Data Lake Analytics account. The response includes a link to the next page, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageAccounts_ListByAccount")
  listByAccount is ArmResourceListByParent<
    StorageAccountInformation,
    Parameters = {
      /**
       * The OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of items to return. Optional.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * The number of items to skip over before returning elements. Optional.
       */
      @minValue(1)
      @query("$skip")
      $skip?: int32;

      /**
       * OData Select statement. Limits the properties on each entry to just those requested, e.g. Categories?$select=CategoryName,Description. Optional.
       */
      @query("$select")
      $select?: string;

      /**
       * OrderBy clause. One or more comma-separated expressions with an optional "asc" (the default) or "desc" depending on the order you'd like the values sorted, e.g. Categories?$orderby=CategoryName desc. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * The Boolean value of true or false to request a count of the matching resources included with the resources in the response, e.g. Categories?$count=true. Optional.
       */
      @query("$count")
      $count?: boolean;
    }
  >;
}

@@doc(StorageAccountInformation.name,
  "The name of the Azure Storage account for which to retrieve the details."
);
@@doc(StorageAccountInformation.properties,
  "The Azure Storage account properties."
);
@@doc(StorageAccountInformations.add::parameters.resource,
  "The parameters containing the access key and optional suffix for the Azure Storage Account."
);
@@doc(StorageAccountInformations.update::parameters.properties,
  "The parameters containing the access key and suffix to update the storage account with, if any. Passing nothing results in no change."
);
