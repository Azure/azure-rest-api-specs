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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the specified Data Lake Store account details in the specified Data Lake Analytics account.")
  @operationId("DataLakeStoreAccounts_Get")
  get is ArmResourceRead<DataLakeStoreAccountInformation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the specified Data Lake Analytics account to include the additional Data Lake Store account.")
  @operationId("DataLakeStoreAccounts_Add")
  add is ArmResourceCreateOrReplaceSync<DataLakeStoreAccountInformation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the Data Lake Analytics account specified to remove the specified Data Lake Store account.")
  @operationId("DataLakeStoreAccounts_Delete")
  delete is ArmResourceDeleteSync<DataLakeStoreAccountInformation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the first page of Data Lake Store accounts linked to the specified Data Lake Analytics account. The response includes a link to the next page, if any.")
  @operationId("DataLakeStoreAccounts_ListByAccount")
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
