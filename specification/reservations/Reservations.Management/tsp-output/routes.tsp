import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureReservationAPI;

interface ReservationOperations {
  @summary("Get Available Scopes for `Reservation`.")
  @doc("""
Check whether the scopes from request is valid for `Reservation`.

""")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}/availableScopes")
  @post
  AvailableScopes is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Id of the reservation item")
      @path
      reservationId: string;

      @doc("Scopes to be checked for eligibility.")
      @body
      body: AvailableScopeRequest;
    },
    AvailableScopeProperties
  >;

  @summary("Split the `Reservation`.")
  @doc("""
Split a `Reservation` into two `Reservation`s with specified quantity
distribution.
""")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/split")
  @post
  Split is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Information needed to Split a reservation item")
      @body
      body: SplitRequest;
    },
    void
  >;

  @summary("Merges two `Reservation`s.")
  @doc("""
Merge the specified `Reservation`s into a new `Reservation`. The two
`Reservation`s being merged must have same properties.
""")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/merge")
  @post
  Merge is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Information needed for commercial request for a reservation")
      @body
      body: MergeRequest;
    },
    void
  >;

  @summary("Get `Reservation`s in a given reservation Order")
  @doc("List `Reservation`s within a single `ReservationOrder`.")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;
    },
    ReservationList
  >;

  @summary("Get `Reservation` details.")
  @doc("Get specific `Reservation` details.")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Id of the reservation item")
      @path
      reservationId: string;

      @doc("Supported value of this query is renewProperties")
      @query
      $expand: string;
    },
    ReservationResponse
  >;

  @summary("Updates a `Reservation`.")
  @doc("Updates the applied scopes of the `Reservation`.")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Id of the reservation item")
      @path
      reservationId: string;

      @doc("Information needed to patch a reservation item")
      @body
      parameters: Patch;
    },
    ReservationResponse | void
  >;

  @summary("Archive a `Reservation`.")
  @doc("Archiving a `Reservation` moves it to `Archived` state.")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}/archive")
  @post
  Archive is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Id of the reservation item")
      @path
      reservationId: string;
    },
    void
  >;

  @summary("Unarchive a `Reservation`.")
  @doc("""
Restores a `Reservation` to the state it was before archiving.

""")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}/unarchive")
  @post
  Unarchive is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Id of the reservation item")
      @path
      reservationId: string;
    },
    void
  >;

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
    ReservationList
  >;

  @doc("""
List the reservations and the roll up counts of reservations group by
provisioning states that the user has access to in the current tenant.
""")
  @route("/providers/Microsoft.Capacity/reservations")
  @get
  ListAll is Azure.Core.Foundations.Operation<
    {
      @doc("""
May be used to filter by reservation properties. The filter supports 'eq',
'or', and 'and'. It does not currently support 'ne', 'gt', 'le', 'ge', or
'not'. Reservation properties include sku/name, properties/{appliedScopeType,
archived, displayName, displayProvisioningState, effectiveDateTime, expiryDate,
expiryDateTime, provisioningState, quantity, renew, reservedResourceType, term,
userFriendlyAppliedScopeType, userFriendlyRenewState}
""")
      @query
      $filter: string;

      @doc("May be used to sort order by reservation properties.")
      @query
      $orderby: string;

      @doc("""
To indicate whether to refresh the roll up counts of the reservations group by
provisioning states
""")
      @query
      refreshSummary: string;

      @doc("The number of reservations to skip from the list before returning results")
      @query
      $skiptoken: float32;

      @doc("The selected provisioning state")
      @query
      selectedState: string;

      @doc("To number of reservations to return")
      @query
      take: float32;
    },
    ReservationsListResult
  >;
}

@summary("""
Get the regions and skus that are available for RI purchase for the specified
Azure subscription.
""")
@doc("""
Get the regions and skus that are available for RI purchase for the specified
Azure subscription.
""")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/catalogs")
@get
op GetCatalog is Azure.Core.Foundations.Operation<
  {
    @doc("Id of the subscription")
    @path
    subscriptionId: string;

    @doc("The type of the resource for which the skus should be provided.")
    @query
    reservedResourceType: string;

    @doc("""
Filters the skus based on the location specified in this parameter. This can be
an Azure region or global
""")
    @query
    location: string;

    @doc("Publisher id used to get the third party products")
    @query
    publisherId: string;

    @doc("Offer id used to get the third party products")
    @query
    offerId: string;

    @doc("Plan id used to get the third party products")
    @query
    planId: string;

    @doc("""
May be used to filter by Catalog properties. The filter supports 'eq', 'or',
and 'and'.
""")
    @query
    $filter: string;

    @doc("The number of reservations to skip from the list before returning results")
    @query
    $skip: float32;

    @doc("To number of reservations to return")
    @query
    $take: float32;
  },
  CatalogsResult
>;

@summary("Get list of applicable `Reservation`s.")
@doc("""
Get applicable `Reservation`s that are applied to this subscription or a
resource group under this subscription.
""")
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

interface ReservationOrderOperations {
  @summary("Calculate price for a `ReservationOrder`.")
  @doc("Calculate price for placing a `ReservationOrder`.")
  @route("/providers/Microsoft.Capacity/calculatePrice")
  @post
  Calculate is Azure.Core.Foundations.Operation<
    {
      @doc("Information needed for calculate or purchase reservation")
      @body
      body: PurchaseRequest;
    },
    CalculatePriceResponse
  >;

  @summary("Get all `ReservationOrder`s.")
  @doc("""
List of all the `ReservationOrder`s that the user has access to in the current
tenant.
""")
  @route("/providers/Microsoft.Capacity/reservationOrders")
  @get
  List is Azure.Core.Foundations.Operation<{}, ReservationOrderList>;

  @summary("Purchase `ReservationOrder`")
  @doc("Purchase `ReservationOrder` and create resource under the specified URI.")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}")
  @put
  Purchase is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Information needed for calculate or purchase reservation")
      @body
      body: PurchaseRequest;
    },
    ReservationOrderResponse
  >;

  @summary("Get a specific `ReservationOrder`.")
  @doc("Get the details of the `ReservationOrder`.")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("May be used to expand the planInformation.")
      @query
      $expand: string;
    },
    ReservationOrderResponse
  >;

  @summary("Change directory of `ReservationOrder`.")
  @doc("""
Change directory (tenant) of `ReservationOrder` and all `Reservation` under it
to specified tenant id
""")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/changeDirectory")
  @post
  ChangeDirectory is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Information needed to change directory of reservation order")
      @body
      body: ChangeDirectoryRequest;
    },
    ChangeDirectoryResponse
  >;
}

interface OperationOperations {
  @summary("Get operations.")
  @doc("List all the operations.")
  @route("/providers/Microsoft.Capacity/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationList>;
}

interface CalculateRefundOperations {
  @summary("Calculate the refund amount of a reservation order.")
  @doc("""
Calculate price for returning `Reservations` if there are no policy errors.

""")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/calculateRefund")
  @post
  Post is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Information needed for calculating refund of a reservation.")
      @body
      body: CalculateRefundRequest;
    },
    CalculateRefundResponse
  >;
}

interface ReturnOperations {
  @summary("Return a reservation.")
  @doc("Return a reservation and get refund information.")
  @route("/providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/return")
  @post
  Post is Azure.Core.Foundations.Operation<
    {
      @doc("Order Id of the reservation")
      @path
      reservationOrderId: string;

      @doc("Information needed for returning reservation.")
      @body
      body: RefundRequest;
    },
    ReservationOrderResponse | RefundResponse
  >;
}

interface CalculateExchangeOperations {
  @summary("Calculates the refund amounts and price of the new purchases.")
  @doc("""
Calculates price for exchanging `Reservations` if there are no policy errors.

""")
  @route("/providers/Microsoft.Capacity/calculateExchange")
  @post
  Post is Azure.Core.Foundations.Operation<
    {
      @doc("Request containing purchases and refunds that need to be executed.")
      @body
      body: CalculateExchangeRequest;
    },
    CalculateExchangeOperationResultResponse | void
  >;
}

interface ExchangeOperations {
  @summary("Exchange Reservation(s)")
  @doc("""
Returns one or more `Reservations` in exchange for one or more `Reservation`
purchases.

""")
  @route("/providers/Microsoft.Capacity/exchange")
  @post
  Post is Azure.Core.Foundations.Operation<
    {
      @doc("Request containing the refunds and purchases that need to be executed.")
      @body
      body: ExchangeRequest;
    },
    ExchangeOperationResultResponse | void
  >;
}

interface QuotaOperations {
  @doc("""
Get the current quota (service limit) and usage of a resource. You can use the
response from the GET operation to submit quota update request.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/resourceProviders/{providerId}/locations/{location}/serviceLimits/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure resource provider ID.")
      @path
      providerId: string;

      @doc("Azure region.")
      @path
      location: string;

      @doc("""
The resource name for a resource provider, such as SKU name for
Microsoft.Compute, Sku or TotalLowPriorityCores for
Microsoft.MachineLearningServices
""")
      @path
      resourceName: string;
    },
    CurrentQuotaLimitBase
  >;

  @doc("""
Create or update the quota (service limits) of a resource to the requested
value.
 Steps:
  1. Make the Get request to get the quota information for
specific resource.
  2. To increase the quota, update the limit field in the
response from Get request to new value.
  3. Submit the JSON to the quota
request API to update the quota.
  The Create quota request may be constructed
as follows. The PUT operation can be used to update the quota.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/resourceProviders/{providerId}/locations/{location}/serviceLimits/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure resource provider ID.")
      @path
      providerId: string;

      @doc("Azure region.")
      @path
      location: string;

      @doc("""
The resource name for a resource provider, such as SKU name for
Microsoft.Compute, Sku or TotalLowPriorityCores for
Microsoft.MachineLearningServices
""")
      @path
      resourceName: string;

      @doc("Quota requests payload.")
      @body
      createQuotaRequest: CurrentQuotaLimitBase;
    },
    CurrentQuotaLimitBase | QuotaRequestSubmitResponse201
  >;

  @doc("""
Update the quota (service limits) of this resource to the requested value.
  •
To get the quota information for specific resource, send a GET request.
  • To
increase the quota, update the limit field from the GET response to a new
value.
  • To update the quota value, submit the JSON response to the quota
request API to update the quota.
  • To update the quota. use the PATCH
operation.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/resourceProviders/{providerId}/locations/{location}/serviceLimits/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure resource provider ID.")
      @path
      providerId: string;

      @doc("Azure region.")
      @path
      location: string;

      @doc("""
The resource name for a resource provider, such as SKU name for
Microsoft.Compute, Sku or TotalLowPriorityCores for
Microsoft.MachineLearningServices
""")
      @path
      resourceName: string;

      @doc("Payload for the quota request.")
      @body
      createQuotaRequest: CurrentQuotaLimitBase;
    },
    CurrentQuotaLimitBase | QuotaRequestSubmitResponse201
  >;

  @doc("""
Gets a list of current quotas (service limits) and usage for all resources. The
response from the list quota operation can be leveraged to request quota
updates.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/resourceProviders/{providerId}/locations/{location}/serviceLimits")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure resource provider ID.")
      @path
      providerId: string;

      @doc("Azure region.")
      @path
      location: string;
    },
    QuotaLimits
  >;
}

interface QuotaRequestStatusOperations {
  @doc("""
For the specified Azure region (location), get the details and status of the
quota request by the quota request ID for the resources of the resource
provider. The PUT request for the quota (service limit) returns a response with
the requestId parameter.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/resourceProviders/{providerId}/locations/{location}/serviceLimitsRequests/{id}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure resource provider ID.")
      @path
      providerId: string;

      @doc("Azure region.")
      @path
      location: string;

      @doc("Quota Request ID.")
      @path
      id: string;
    },
    QuotaRequestDetails
  >;

  @doc("""
For the specified Azure region (location), subscription, and resource provider,
get the history of the quota requests for the past year. To select specific
quota requests, use the oData filter.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Capacity/resourceProviders/{providerId}/locations/{location}/serviceLimitsRequests")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure resource provider ID.")
      @path
      providerId: string;

      @doc("Azure region.")
      @path
      location: string;

      @doc("""
| Field | Supported operators
|
|---------------------|------------------------|
|requestSubmitTime | ge, le,
eq, gt, lt |
""")
      @query
      $filter: string;

      @doc("Number of records to return.")
      @query
      $top: int32;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element includes a skiptoken parameter that specifies a starting point to use
for subsequent calls.
""")
      @query
      $skiptoken: string;
    },
    QuotaRequestDetailsList
  >;
}
