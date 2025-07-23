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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SkusOperationGroup {
  /**
   * Lists the available SKUs supported by Microsoft.Storage for given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Skus_List")
  @autoRoute
  @get
  @action("skus")
  list is ArmProviderActionSync<
    Response = StorageSkuListResult,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DeletedAccountsOperationGroup {
  /**
   * Lists deleted accounts under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DeletedAccounts_List")
  @autoRoute
  @get
  @action("deletedAccounts")
  list is ArmProviderActionSync<
    Response = ResourceListResult<DeletedAccount>,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface UsagesOperationGroup {
  /**
   * Gets the current usage count and the limit for the resources of the location under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Usages_ListByLocation")
  @autoRoute
  @get
  @action("usages")
  listByLocation is ArmProviderActionSync<
    Response = UsageListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
}
