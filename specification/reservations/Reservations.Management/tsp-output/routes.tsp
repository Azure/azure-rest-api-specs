import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.Reservations;

interface ReservationOperations {
  @summary("Get `Reservation` revisions.")
  @doc("List of all the revisions for the `Reservation`.")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}/revisions")
  @get
  ListRevisions is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Id of the reservation item")
      @path
      reservationId: string;
    },
    ResourceListResult<ReservationResponse>
  >;
}

@summary("Get the regions and skus that are available for RI purchase for the specified Azure subscription.")
@doc("Get the regions and skus that are available for RI purchase for the specified Azure subscription.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/catalogs")
@get
op GetCatalog is Azure.Core.Foundations.Operation<
  {
    @doc("Id of the subscription")
    @path
    subscriptionId: string;

    @doc("The type of the resource for which the skus should be provided.")
    @query("reservedResourceType")
    reservedResourceType?: string;

    @doc("Filters the skus based on the location specified in this parameter. This can be an Azure region or global")
    @query("location")
    location?: string;

    @doc("Publisher id used to get the third party products")
    @query("publisherId")
    publisherId?: string;

    @doc("Offer id used to get the third party products")
    @query("offerId")
    offerId?: string;

    @doc("Plan id used to get the third party products")
    @query("planId")
    planId?: string;

    @doc("May be used to filter by Catalog properties. The filter supports 'eq', 'or', and 'and'.")
    @query("$filter")
    $filter?: string;

    @doc("The number of reservations to skip from the list before returning results")
    @query("$skip")
    $skip?: float32;

    @doc("To number of reservations to return")
    @query("$take")
    $take?: float32;
  },
  CatalogsResult
>;

@summary("Get list of applicable `Reservation`s.")
@doc("Get applicable `Reservation`s that are applied to this subscription or a resource group under this subscription.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/appliedReservations")
@get
op GetAppliedReservationList is Azure.Core.Foundations.Operation<
  {
    @doc("Id of the subscription")
    @path
    subscriptionId: string;
  },
  AppliedReservations
>;

interface CalculateExchangeOperations {
  @summary("Calculates the refund amounts and price of the new purchases.")
  @doc("""
Calculates price for exchanging `Reservations` if there are no policy errors.

""")
  @route("/providers/Microsoft.Capacity/calculateExchange")
  @post
  Post is Azure.Core.Foundations.Operation<
    CalculateExchangeRequest,
    CalculateExchangeOperationResultResponse | void
  >;
}

interface ExchangeOperations {
  @summary("Exchange Reservation(s)")
  @doc("""
Returns one or more `Reservations` in exchange for one or more `Reservation` purchases.

""")
  @route("/providers/Microsoft.Capacity/exchange")
  @post
  Post is Azure.Core.Foundations.Operation<
    ExchangeRequest,
    ExchangeOperationResultResponse | void
  >;
}
