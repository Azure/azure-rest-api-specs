import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Reservations;
@doc("Details of a reservation order being returned.")
@tenantResource
model ReservationOrderResponse is ProxyResource<ReservationOrderProperties> {
  @doc("Order Id of the reservation")
  @key("reservationOrderId")
  @segment("reservationOrders")
  name: string;

  etag?: int32;
}

@armResourceOperations
interface ReservationOrder {
  @doc("Get the details of the `ReservationOrder`.")
  get is ArmResourceRead<
    ReservationOrderResponse,
    {
      ...BaseParameters<ReservationOrderResponse>;

      @doc("May be used to expand the planInformation.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Purchase `ReservationOrder` and create resource under the specified URI.")
  purchase is ArmResourceCreateOrUpdateAsync<ReservationOrderResponse>;
  @doc("List of all the `ReservationOrder`s that the user has access to in the current tenant.")
  list is ArmResourceListByParent<ReservationOrderResponse>;
  @doc("Change directory (tenant) of `ReservationOrder` and all `Reservation` under it to specified tenant id")
  changeDirectory is ArmResourceActionSync<
    ReservationOrderResponse,
    ChangeDirectoryRequest,
    ChangeDirectoryResponse
  >;
}

@armResourceOperations
interface Reservation {
  @doc("Split a `Reservation` into two `Reservation`s with specified quantity distribution.")
  split is ArmResourceActionAsync<ReservationOrderResponse, SplitRequest, void>;
  @doc("Merge the specified `Reservation`s into a new `Reservation`. The two `Reservation`s being merged must have same properties.")
  merge is ArmResourceActionAsync<ReservationOrderResponse, MergeRequest, void>;
}

@armResourceOperations
interface CalculateRefund {
  @doc("""
Calculate price for returning `Reservations` if there are no policy errors.

""")
  post is ArmResourceActionSync<
    ReservationOrderResponse,
    CalculateRefundRequest,
    CalculateRefundResponse
  >;
}

@armResourceOperations
interface Return {
  @doc("Return a reservation and get refund information.")
  post is ArmResourceActionAsync<
    ReservationOrderResponse,
    RefundRequest,
    ReservationOrderResponse
  >;
}
