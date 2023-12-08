import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataLakeStore;
@doc("Data Lake Store account information.")
model DataLakeStoreAccount is ProxyResource<DataLakeStoreAccountProperties> {
  @doc("The name of the Data Lake Store account.")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DataLakeStoreAccounts {
  @doc("Gets the specified Data Lake Store account.")
  get is ArmResourceRead<DataLakeStoreAccount>;
  @doc("Creates the specified Data Lake Store account.")
  create is ArmResourceCreateOrUpdateAsync<DataLakeStoreAccount>;
  @doc("Updates the specified Data Lake Store account information.")
  update is ArmResourcePatchAsync<
    DataLakeStoreAccount,
    DataLakeStoreAccountProperties
  >;
  @doc("Deletes the specified Data Lake Store account.")
  delete is ArmResourceDeleteAsync<DataLakeStoreAccount>;
  @doc("Lists the Data Lake Store accounts within a specific resource group. The response includes a link to the next page of results, if any.")
  listByResourceGroup is ArmResourceListByParent<
    DataLakeStoreAccount,
    {
      ...BaseParameters<DataLakeStoreAccount>;

      @doc("OData filter. Optional.")
      @query("$filter")
      $filter?: string;

      @doc("The number of items to return. Optional.")
      @query("$top")
      $top?: int32;

      @doc("The number of items to skip over before returning elements. Optional.")
      @query("$skip")
      $skip?: int32;

      @doc("OData Select statement. Limits the properties on each entry to just those requested, e.g. Categories?$select=CategoryName,Description. Optional.")
      @query("$select")
      $select?: string;

      @doc("OrderBy clause. One or more comma-separated expressions with an optional \"asc\" (the default) or \"desc\" depending on the order you'd like the values sorted, e.g. Categories?$orderby=CategoryName desc. Optional.")
      @query("$orderby")
      orderBy?: string;

      @doc("A Boolean value of true or false to request a count of the matching resources included with the resources in the response, e.g. Categories?$count=true. Optional.")
      @query("$count")
      $count?: boolean;
    }
  >;
  @doc("Lists the Data Lake Store accounts within the subscription. The response includes a link to the next page of results, if any.")
  list is ArmListBySubscription<DataLakeStoreAccount>;
  @doc("Attempts to enable a user managed Key Vault for encryption of the specified Data Lake Store account.")
  enableKeyVault is ArmResourceActionSync<DataLakeStoreAccount, {}, {}>;
}
