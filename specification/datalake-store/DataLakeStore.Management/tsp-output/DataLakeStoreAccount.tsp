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
/**
 * Data Lake Store account information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(DataLakeStoreAccountPropertiesBasic)
model DataLakeStoreAccount extends TrackedResourceBase {
  /**
   * The name of the Data Lake Store account.
   */
  @path
  @key("accountName")
  @segment("accounts")
  @visibility("read")
  name: string;

  /**
   * The Key Vault encryption identity, if any.
   */
  @visibility("read")
  identity?: EncryptionIdentity;

  /**
   * The Data Lake Store account properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DataLakeStoreAccountProperties;
}

@armResourceOperations
interface DataLakeStoreAccounts {
  /**
   * Gets the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Get")
  get is ArmResourceRead<DataLakeStoreAccount>;

  /**
   * Creates the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Create")
  create is ArmResourceCreateOrReplaceAsync<DataLakeStoreAccount>;

  /**
   * Updates the specified Data Lake Store account information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Accounts_Update")
  update is ArmCustomPatchAsync<
    DataLakeStoreAccount,
    UpdateDataLakeStoreAccountParameters
  >;

  /**
   * Deletes the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteAsync<DataLakeStoreAccount>;

  /**
   * Lists the Data Lake Store accounts within a specific resource group. The response includes a link to the next page of results, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    DataLakeStoreAccount,
    {
      ...BaseParameters<DataLakeStoreAccount>;

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
      orderBy?: string;

      /**
       * A Boolean value of true or false to request a count of the matching resources included with the resources in the response, e.g. Categories?$count=true. Optional.
       */
      @query("$count")
      $count?: boolean;
    }
  >;

  /**
   * Lists the Data Lake Store accounts within the subscription. The response includes a link to the next page of results, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_List")
  list is ArmListBySubscription<DataLakeStoreAccount>;

  /**
   * Attempts to enable a user managed Key Vault for encryption of the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_EnableKeyVault")
  enableKeyVault is ArmResourceActionSync<DataLakeStoreAccount, void, void>;

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
