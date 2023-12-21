import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataLakeAnalytics;
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
interface Accounts {
  @doc("Gets details of the specified Data Lake Analytics account.")
  get is ArmResourceRead<DataLakeAnalyticsAccount>;
  @doc("Creates the specified Data Lake Analytics account. This supplies the user with computation services for Data Lake Analytics workloads.")
  create is ArmResourceCreateOrUpdateAsync<DataLakeAnalyticsAccount>;
  @doc("Updates the Data Lake Analytics account object specified by the accountName with the contents of the account object.")
  update is ArmResourcePatchAsync<
    DataLakeAnalyticsAccount,
    DataLakeAnalyticsAccountProperties
  >;
  @doc("Begins the delete process for the Data Lake Analytics account object specified by the account name.")
  delete is ArmResourceDeleteAsync<DataLakeAnalyticsAccount>;
  @doc("Gets the first page of Data Lake Analytics accounts, if any, within a specific resource group. This includes a link to the next page, if any.")
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
  @doc("Gets the first page of Data Lake Analytics accounts, if any, within the current subscription. This includes a link to the next page, if any.")
  list is ArmListBySubscription<DataLakeAnalyticsAccount>;
}
