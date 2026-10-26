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

namespace Reservations;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReservationOperationGroup {
  /**
   * List the reservations and the roll up counts of reservations group by provisioning states that the user has access to in the current tenant.
   */
  @autoRoute
  @get
  @list
  @action("reservations")
  listAll is ArmProviderActionSync<
    Response = ArmResponse<ReservationsListResult>,
    Parameters = {
      /**
       * May be used to filter by reservation properties. The filter supports 'eq', 'or', and 'and'. It does not currently support 'ne', 'gt', 'le', 'ge', or 'not'. Reservation properties include sku/name, properties/{appliedScopeType, archived, displayName, displayProvisioningState, effectiveDateTime, expiryDate, expiryDateTime, provisioningState, quantity, renew, reservedResourceType, term, userFriendlyAppliedScopeType, userFriendlyRenewState}
       */
      @query("$filter")
      $filter?: string;

      /**
       * May be used to sort order by reservation properties.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listAll.$orderby retains the $orderby query parameter; preserve wire compatibility."
      @query("$orderby")
      $orderby?: string;

      /**
       * To indicate whether to refresh the roll up counts of the reservations group by provisioning states
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listAll.refreshSummary retains the refreshSummary query parameter; preserve wire compatibility."
      @query("refreshSummary")
      refreshSummary?: string;

      /**
       * The number of reservations to skip from the list before returning results
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listAll.$skiptoken retains the $skiptoken query parameter; preserve wire compatibility."
      @query("$skiptoken")
      $skiptoken?: float32;

      /**
       * The selected provisioning state
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listAll.selectedState retains the selectedState query parameter; preserve wire compatibility."
      @query("selectedState")
      selectedState?: string;

      /**
       * To number of reservations to return
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listAll.take retains the take query parameter; preserve wire compatibility."
      @query("take")
      take?: float32;
    },
    Error = ErrorResponse
  >;
}

/**
 * Get the regions and skus that are available for RI purchase for the specified Azure subscription.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" ""
@summary("Get the regions and skus that are available for RI purchase for the specified Azure subscription.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/catalogs")
@get
@list
@tag("Catalog")
op getCatalog(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  /** The type of the resource for which the skus should be provided. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getCatalog.reservedResourceType retains the reservedResourceType query parameter; preserve wire compatibility."
  @query("reservedResourceType")
  reservedResourceType?: string,

  /** Filters the skus based on the location specified in this parameter. This can be an azure region or global */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getCatalog.location retains the location query parameter; preserve wire compatibility."
  @query
  location?: string,

  /** Publisher id used to get the third party products */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getCatalog.publisherId retains the publisherId query parameter; preserve wire compatibility."
  @query("publisherId")
  publisherId?: string,

  /** Offer id used to get the third party products */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getCatalog.offerId retains the offerId query parameter; preserve wire compatibility."
  @query("offerId")
  offerId?: string,

  /** Plan id used to get the third party products */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getCatalog.planId retains the planId query parameter; preserve wire compatibility."
  @query("planId")
  planId?: string,

  /** May be used to filter by Catalog properties. The filter supports 'eq', 'or', and 'and'. */
  @query("$filter")
  $filter?: string,

  /** The number of reservations to skip from the list before returning results */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getCatalog.$skip retains the $skip query parameter; preserve wire compatibility."
  @query("$skip")
  $skip?: float32,

  /** To number of reservations to return */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getCatalog.$take retains the $take query parameter; preserve wire compatibility."
  @query("$take")
  $take?: float32,
): ArmResponse<CatalogsResult> | Error;

/**
 * Get applicable `Reservation`s that are applied to this subscription or a resource group under this subscription.
 */
@summary("Get list of applicable `Reservation`s.")
@autoRoute
@get
@action("appliedReservations")
@tag("AppliedReservation")
op getAppliedReservationList is ArmProviderActionSync<
  Response = AppliedReservations,
  Scope = SubscriptionActionScope,
  Error = Error
>;

@armResourceOperations(#{ omitTags: true })
interface ReservationOrderOperationGroup {
  /**
   * Calculate price for placing a `ReservationOrder`.
   */
  @summary("Calculate price for a `ReservationOrder`.")
  @autoRoute
  @action("calculatePrice")
  @tag("Reservation, Calculate")
  calculate is ArmProviderActionSync<
    Request = PurchaseRequest,
    Response = CalculatePriceResponse,
    Error = Error
  >;
}

@armResourceOperations(#{ omitTags: true })
interface CalculateExchangeOperationGroup {
  /**
   * Calculates price for exchanging `Reservations` if there are no policy errors.
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @summary("Calculates the refund amounts and price of the new purchases.")
  @autoRoute
  @action("calculateExchange")
  @tag("Exchange")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  post is ArmProviderActionAsync<
    Request = CalculateExchangeRequest,
    Response = CalculateExchangeOperationResultResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = CalculateExchangeOperationResultResponse> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = Error
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ExchangeOperationGroup {
  /**
   * Returns one or more `Reservations` in exchange for one or more `Reservation` purchases.
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @summary("Exchange Reservation(s)")
  @autoRoute
  @action("exchange")
  @tag("Exchange")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  post is ArmProviderActionAsync<
    Request = ExchangeRequest,
    Response = ExchangeOperationResultResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ExchangeOperationResultResponse> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = Error
  >;
}
