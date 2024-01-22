import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeAnalytics;
/**
 * A Data Lake Analytics account object, containing all information associated with the named Data Lake Analytics account.
 */
model DataLakeAnalyticsAccount
  is ProxyResource<DataLakeAnalyticsAccountProperties> {
  /**
   * The name of the Data Lake Analytics account.
   */
  @path
  @key("accountName")
  @segment("accounts")
  name: string;
}

@armResourceOperations
interface DataLakeAnalyticsAccounts {
  /**
   * Gets details of the specified Data Lake Analytics account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Get")
  get is ArmResourceRead<DataLakeAnalyticsAccount>;

  /**
   * Creates the specified Data Lake Analytics account. This supplies the user with computation services for Data Lake Analytics workloads.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Create")
  create is ArmResourceCreateOrReplaceAsync<DataLakeAnalyticsAccount>;

  /**
   * Updates the Data Lake Analytics account object specified by the accountName with the contents of the account object.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Accounts_Update")
  update is ArmCustomPatchAsync<
    DataLakeAnalyticsAccount,
    UpdateDataLakeAnalyticsAccountParameters
  >;

  /**
   * Begins the delete process for the Data Lake Analytics account object specified by the account name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteAsync<DataLakeAnalyticsAccount>;

  /**
   * Gets the first page of Data Lake Analytics accounts, if any, within a specific resource group. This includes a link to the next page, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    DataLakeAnalyticsAccount,
    {
      ...BaseParameters<DataLakeAnalyticsAccount>;

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

  /**
   * Gets the first page of Data Lake Analytics accounts, if any, within the current subscription. This includes a link to the next page, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_List")
  list is ArmListBySubscription<DataLakeAnalyticsAccount>;

  /**
   * Checks whether the specified account name is available or taken.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    CheckNameAvailabilityParameters,
    NameAvailabilityInformation
  >;
}

@@projectedName(DataLakeAnalyticsAccounts.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(DataLakeAnalyticsAccounts.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataLakeAnalyticsAccounts.create::parameters.resource,
  "Parameters supplied to create a new Data Lake Analytics account."
);
@@projectedName(DataLakeAnalyticsAccounts.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(DataLakeAnalyticsAccounts.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataLakeAnalyticsAccounts.update::parameters.properties,
  "Parameters supplied to the update Data Lake Analytics account operation."
);
