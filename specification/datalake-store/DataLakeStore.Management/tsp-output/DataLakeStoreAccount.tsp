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

namespace Microsoft.DataLakeStore;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the specified Data Lake Store account.")
  @operationId("Accounts_Get")
  get is ArmResourceRead<DataLakeStoreAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the specified Data Lake Store account.")
  @operationId("Accounts_Create")
  create is ArmResourceCreateOrUpdateAsync<DataLakeStoreAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the specified Data Lake Store account information.")
  @operationId("Accounts_Update")
  update is ArmCustomPatchAsync<
    DataLakeStoreAccount,
    UpdateDataLakeStoreAccountParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the specified Data Lake Store account.")
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteAsync<DataLakeStoreAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the Data Lake Store accounts within a specific resource group. The response includes a link to the next page of results, if any.")
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    DataLakeStoreAccount,
    {
      ...BaseParameters<DataLakeStoreAccount>;

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
      orderBy?: string;

      @doc("A Boolean value of true or false to request a count of the matching resources included with the resources in the response, e.g. Categories?$count=true. Optional.")
      @query("$count")
      $count?: boolean;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the Data Lake Store accounts within the subscription. The response includes a link to the next page of results, if any.")
  @operationId("Accounts_List")
  list is ArmListBySubscription<DataLakeStoreAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Attempts to enable a user managed Key Vault for encryption of the specified Data Lake Store account.")
  @operationId("Accounts_EnableKeyVault")
  enableKeyVault is ArmResourceActionSync<DataLakeStoreAccount, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks whether the specified account name is available or taken.")
  @operationId("Accounts_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    CheckNameAvailabilityParameters,
    NameAvailabilityInformation
  >;
}

@@projectedName(DataLakeStoreAccounts.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(DataLakeStoreAccounts.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataLakeStoreAccounts.create::parameters.resource,
  "Parameters supplied to create the Data Lake Store account."
);
@@projectedName(DataLakeStoreAccounts.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(DataLakeStoreAccounts.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataLakeStoreAccounts.update::parameters.properties,
  "Parameters supplied to update the Data Lake Store account."
);
