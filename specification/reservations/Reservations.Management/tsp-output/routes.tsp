import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Capacity;

interface ReservationOperations {
  /**
   * List of all the revisions for the `Reservation`.
   */
  @summary("Get `Reservation` revisions.")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}/revisions")
  @get
  listRevisions is Azure.Core.Foundations.Operation<
    {
      /**
       * Order Id of the reservation
       */
      @path
      reservationOrderId: string;

      /**
       * Id of the reservation item
       */
      @path
      reservationId: string;
    },
    ResourceListResult<ReservationResponse>
  >;
}

/**
 * Get the regions and skus that are available for RI purchase for the specified Azure subscription.
 */
@summary("Get the regions and skus that are available for RI purchase for the specified Azure subscription.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/catalogs")
@get
op getCatalog is Azure.Core.Foundations.Operation<
  {
    /**
     * Id of the subscription
     */
    @path
    subscriptionId: string;

    /**
     * The type of the resource for which the skus should be provided.
     */
    @query("reservedResourceType")
    reservedResourceType?: string;

    /**
     * Filters the skus based on the location specified in this parameter. This can be an Azure region or global
     */
    @query("location")
    location?: string;

    /**
     * Publisher id used to get the third party products
     */
    @query("publisherId")
    publisherId?: string;

    /**
     * Offer id used to get the third party products
     */
    @query("offerId")
    offerId?: string;

    /**
     * Plan id used to get the third party products
     */
    @query("planId")
    planId?: string;

    /**
     * May be used to filter by Catalog properties. The filter supports 'eq', 'or', and 'and'.
     */
    @query("$filter")
    $filter?: string;

    /**
     * The number of reservations to skip from the list before returning results
     */
    @query("$skip")
    $skip?: float32;

    /**
     * To number of reservations to return
     */
    @query("$take")
    $take?: float32;
  },
  CatalogsResult
>;

/**
 * Get applicable `Reservation`s that are applied to this subscription or a resource group under this subscription.
 */
@summary("Get list of applicable `Reservation`s.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/appliedReservations")
@get
op getAppliedReservationList is Azure.Core.Foundations.Operation<
  {
    /**
     * Id of the subscription
     */
    @path
    subscriptionId: string;
  },
  AppliedReservations
>;

interface CalculateExchangeOperations {
  /**
* Calculates price for exchanging `Reservations` if there are no policy errors.

*/
  @summary("Calculates the refund amounts and price of the new purchases.")
  @route("/providers/Microsoft.Capacity/calculateExchange")
  @post
  post is Azure.Core.Foundations.Operation<
    CalculateExchangeRequest,
    CalculateExchangeOperationResultResponse | void
  >;
}

interface ExchangeOperations {
  /**
* Returns one or more `Reservations` in exchange for one or more `Reservation` purchases.

*/
  @summary("Exchange Reservation(s)")
  @route("/providers/Microsoft.Capacity/exchange")
  @post
  post is Azure.Core.Foundations.Operation<
    ExchangeRequest,
    ExchangeOperationResultResponse | void
  >;
}
