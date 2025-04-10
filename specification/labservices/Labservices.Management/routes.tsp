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

namespace Microsoft.LabServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationResultsOperationGroup {
  /**
   * Returns an azure operation result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get an azure operation result.")
  @operationId("OperationResults_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.LabServices/operationResults/{operationResultId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The operation result ID / name.
     */
    @maxLength(100)
    @minLength(1)
    @pattern("^[-\\w\\\\._\\\\(\\\\)]+$")
    @path
    operationResultId: string,
  ): ArmResponse<OperationResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SkusOperationGroup {
  /**
   * Returns a list of Azure Lab Services resource SKUs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the Azure Lab Services resource SKUs.")
  @operationId("Skus_List")
  @autoRoute
  @get
  @action("skus")
  list is ArmProviderActionSync<
    Response = PagedLabServicesSkus,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsagesOperationGroup {
  /**
   * Returns list of usage per SKU family for the specified subscription in the specified region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of usages.")
  @operationId("Usages_ListByLocation")
  @autoRoute
  @get
  @action("usages")
  listByLocation is ArmProviderActionSync<
    Response = ListUsagesResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}
