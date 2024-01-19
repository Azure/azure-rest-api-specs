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

namespace Microsoft.Capacity;
@doc("Details of a reservation order being returned.")
@tenantResource
model ReservationOrderResponse is ProxyResource<ReservationOrderProperties> {
  @doc("Order Id of the reservation")
  @path
  @key("reservationOrderId")
  @segment("reservationOrders")
  name: string;

  etag?: int32;
}

@armResourceOperations
interface ReservationOrderResponses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the details of the `ReservationOrder`.")
  @operationId("ReservationOrder_Get")
  get is ArmResourceRead<
    ReservationOrderResponse,
    {
      ...BaseParameters<ReservationOrderResponse>;

      @doc("May be used to expand the planInformation.")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Purchase `ReservationOrder` and create resource under the specified URI.")
  @operationId("ReservationOrder_Purchase")
  purchase is ArmResourceCreateOrUpdateAsync<
    ReservationOrderResponse,
    BaseParameters<ReservationOrderResponse>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of all the `ReservationOrder`s that the user has access to in the current tenant.")
  @operationId("ReservationOrder_List")
  list is ArmResourceListByParent<ReservationOrderResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Split a `Reservation` into two `Reservation`s with specified quantity distribution.")
  @operationId("Reservation_Split")
  split is ArmResourceActionAsync<
    ReservationOrderResponse,
    SplitRequest,
    void,
    BaseParameters<ReservationOrderResponse>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Merge the specified `Reservation`s into a new `Reservation`. The two `Reservation`s being merged must have same properties.")
  @operationId("Reservation_Merge")
  merge is ArmResourceActionAsync<
    ReservationOrderResponse,
    MergeRequest,
    void,
    BaseParameters<ReservationOrderResponse>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Change directory (tenant) of `ReservationOrder` and all `Reservation` under it to specified tenant id")
  @operationId("ReservationOrder_ChangeDirectory")
  changeDirectory is ArmResourceActionSync<
    ReservationOrderResponse,
    ChangeDirectoryRequest,
    ChangeDirectoryResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("""
Calculate price for returning `Reservations` if there are no policy errors.

""")
  @operationId("CalculateRefund_Post")
  post is ArmResourceActionSync<
    ReservationOrderResponse,
    CalculateRefundRequest,
    CalculateRefundResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Return a reservation and get refund information.")
  @operationId("Return_Post")
  post is ArmResourceActionAsync<
    ReservationOrderResponse,
    RefundRequest,
    ReservationOrderResponse,
    BaseParameters<ReservationOrderResponse>,
    ArmLroLocationHeader
  >;
}

@@projectedName(ReservationOrderResponses.purchase::parameters.resource,
  "json",
  "body"
);
@@extension(ReservationOrderResponses.purchase::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(ReservationOrderResponses.purchase::parameters.resource,
  "Information needed for calculate or purchase reservation"
);
@@doc(ReservationOrderResponses.split::parameters.body,
  "Information needed to Split a reservation item"
);
@@doc(ReservationOrderResponses.merge::parameters.body,
  "Information needed for commercial request for a reservation"
);
@@doc(ReservationOrderResponses.changeDirectory::parameters.body,
  "Information needed to change directory of reservation order"
);
@@doc(ReservationOrderResponses.post::parameters.body,
  "Information needed for calculating refund of a reservation."
);
@@doc(ReservationOrderResponses.post::parameters.body,
  "Information needed for returning reservation."
);
