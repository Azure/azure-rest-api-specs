import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeAnalyticsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataLakeAnalytics;
@doc("Data Lake Store account information.")
@parentResource(DataLakeAnalyticsAccount)
model DataLakeStoreAccountInformation
  is ProxyResource<DataLakeStoreAccountInformationProperties> {
  @doc("The name of the Data Lake Store account to retrieve")
  @path
  @key("dataLakeStoreAccountName")
  @segment("dataLakeStoreAccounts")
  name: string;
}

@armResourceOperations
interface DataLakeStoreAccountInformations {
  @doc("Gets the specified Data Lake Store account details in the specified Data Lake Analytics account.")
  get is ArmResourceRead<DataLakeStoreAccountInformation>;
  @doc("Updates the specified Data Lake Analytics account to include the additional Data Lake Store account.")
  add is ArmResourceCreateOrReplaceSync<DataLakeStoreAccountInformation>;
  @doc("Updates the Data Lake Analytics account specified to remove the specified Data Lake Store account.")
  delete is ArmResourceDeleteSync<DataLakeStoreAccountInformation>;
  @doc("Gets the first page of Data Lake Store accounts linked to the specified Data Lake Analytics account. The response includes a link to the next page, if any.")
  listByAccount is ArmResourceListByParent<
    DataLakeStoreAccountInformation,
    {
      ...BaseParameters<DataLakeStoreAccountInformation>;

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
}
