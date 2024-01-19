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
@doc("A Data Lake Analytics account object, containing all information associated with the named Data Lake Analytics account.")
model DataLakeAnalyticsAccount
  is ProxyResource<DataLakeAnalyticsAccountProperties> {
  @doc("The name of the Data Lake Analytics account.")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;
}

@armResourceOperations
interface DataLakeAnalyticsAccounts {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets details of the specified Data Lake Analytics account.")
  @operationId("Accounts_Get")
  get is ArmResourceRead<DataLakeAnalyticsAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the specified Data Lake Analytics account. This supplies the user with computation services for Data Lake Analytics workloads.")
  @operationId("Accounts_Create")
  create is ArmResourceCreateOrUpdateAsync<DataLakeAnalyticsAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the Data Lake Analytics account object specified by the accountName with the contents of the account object.")
  @operationId("Accounts_Update")
  update is ArmCustomPatchAsync<
    DataLakeAnalyticsAccount,
    UpdateDataLakeAnalyticsAccountParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Begins the delete process for the Data Lake Analytics account object specified by the account name.")
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteAsync<DataLakeAnalyticsAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the first page of Data Lake Analytics accounts, if any, within a specific resource group. This includes a link to the next page, if any.")
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    DataLakeAnalyticsAccount,
    {
      ...BaseParameters<DataLakeAnalyticsAccount>;

      @doc("OData filter. Optional.")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the first page of Data Lake Analytics accounts, if any, within the current subscription. This includes a link to the next page, if any.")
  @operationId("Accounts_List")
  list is ArmListBySubscription<DataLakeAnalyticsAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks whether the specified account name is available or taken.")
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
