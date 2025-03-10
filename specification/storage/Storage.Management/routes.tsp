// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface Skus {
  /**
   * Lists the available SKUs supported by Microsoft.Storage for given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Skus_List")
  @autoRoute
  @get
  @action("skus")
  @tag("Skus")
  list is ArmProviderActionSync<
    Response = StorageSkuListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface StorageAccountsResourceGroup {
  /**
   * Checks that the storage account name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageAccounts_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = StorageAccountCheckNameAvailabilityParameters,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DeletedAccountsResourceGroup {
  /**
   * Lists deleted accounts under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeletedAccounts_List")
  @autoRoute
  @get
  @action("deletedAccounts")
  @tag("DeletedAccounts")
  list is ArmProviderActionSync<
    Response = ResourceListResult<DeletedAccount>,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsagesOperations {
  /**
   * Gets the current usage count and the limit for the resources of the location under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Usages_ListByLocation")
  @autoRoute
  @get
  @action("usages")
  @tag("LocationUsage")
  listByLocation is ArmProviderActionSync<
    Response = UsageListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
@@doc(StorageAccountsResourceGroup.checkNameAvailability::parameters.body,
  "The name of the storage account within the specified resource group. Storage account names must be between 3 and 24 characters in length and use numbers and lower-case letters only."
);
