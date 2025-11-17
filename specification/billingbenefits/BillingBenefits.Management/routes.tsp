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

namespace Microsoft.BillingBenefits;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SavingsPlanOperationGroup {
  /**
   * List savings plans.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @get
  @list
  @action("savingsPlans")
  listAll is ArmProviderActionSync<
    Response = SavingsPlanModelListResult,
    Parameters = {
      /**
       * May be used to filter by reservation properties. The filter supports 'eq', 'or', and 'and'. It does not currently support 'ne', 'gt', 'le', 'ge', or 'not'. Reservation properties include sku/name, properties/{appliedScopeType, archived, displayName, displayProvisioningState, effectiveDateTime, expiryDate, provisioningState, quantity, renew, reservedResourceType, term, userFriendlyAppliedScopeType, userFriendlyRenewState}
       */
      @query("$filter")
      $filter?: string;

      /**
       * May be used to sort order by reservation properties.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * To indicate whether to refresh the roll up counts of the savings plans group by provisioning states
       */
      @query("refreshSummary")
      refreshSummary?: string;

      /**
       * The number of savings plans to skip from the list before returning results
       */
      @query("$skiptoken")
      $skiptoken?: float32;

      /**
       * The selected provisioning state
       */
      @query("selectedState")
      selectedState?: string;

      /**
       * To number of savings plans to return
       */
      @query("take")
      take?: float32;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DiscountsOperationGroup {
  /**
   * List discounts that are applicable for a given scope. Currently supported scopes: billing accounts
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/{scope}/providers/Microsoft.BillingBenefits/applicableDiscounts")
  @get
  @list
  scopeList(
    ...ApiVersionParameter,

    /**
     * The scope at which the benefits are listed.
     */
    @path
    scope: string,
  ): ArmResponse<DiscountList> | ErrorResponse;
}

/**
 * Validate savings plan purchase.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@action("validate")
op validatePurchase is ArmProviderActionSync<
  Request = SavingsPlanPurchaseValidateRequest,
  Response = SavingsPlanValidateResponse
>;
