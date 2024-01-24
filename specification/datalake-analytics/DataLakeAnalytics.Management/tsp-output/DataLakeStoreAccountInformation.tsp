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
/**
 * Data Lake Store account information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataLakeAnalyticsAccount)
@Azure.ResourceManager.Private.armResourceInternal(
  DataLakeStoreAccountInformationProperties
)
@includeInapplicableMetadataInPayload(false)
model DataLakeStoreAccountInformation extends ProxyResourceBase {
  /**
   * The name of the Data Lake Store account to retrieve
   */
  @path
  @key("dataLakeStoreAccountName")
  @segment("dataLakeStoreAccounts")
  name: string;

  /**
   * The Data Lake Store account properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DataLakeStoreAccountInformationProperties;
}

@armResourceOperations
interface DataLakeStoreAccountInformations {
  /**
   * Gets the specified Data Lake Store account details in the specified Data Lake Analytics account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataLakeStoreAccounts_Get")
  get is ArmResourceRead<DataLakeStoreAccountInformation>;

  /**
   * Updates the specified Data Lake Analytics account to include the additional Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataLakeStoreAccounts_Add")
  add is ArmResourceCreateOrReplaceSync<DataLakeStoreAccountInformation>;

  /**
   * Updates the Data Lake Analytics account specified to remove the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataLakeStoreAccounts_Delete")
  delete is ArmResourceDeleteSync<DataLakeStoreAccountInformation>;

  /**
   * Gets the first page of Data Lake Store accounts linked to the specified Data Lake Analytics account. The response includes a link to the next page, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataLakeStoreAccounts_ListByAccount")
  listByAccount is ArmResourceListByParent<
    DataLakeStoreAccountInformation,
    {
      ...BaseParameters<DataLakeStoreAccountInformation>;

      /**
       * OData filter. Optional.
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

@@projectedName(DataLakeStoreAccountInformations.add::parameters.resource,
  "json",
  "parameters"
);
@@extension(DataLakeStoreAccountInformations.add::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataLakeStoreAccountInformations.add::parameters.resource,
  "The details of the Data Lake Store account."
);
