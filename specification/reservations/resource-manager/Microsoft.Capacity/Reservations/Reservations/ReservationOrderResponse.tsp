import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Reservations;
/**
 * Details of a reservation order being returned.
 */
@tenantResource
model ReservationOrderResponse
  is Azure.ResourceManager.ProxyResource<ReservationOrderProperties> {
  ...ResourceNameParameter<
    Resource = ReservationOrderResponse,
    KeyName = "reservationOrderId",
    SegmentName = "reservationOrders",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: int32;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" ""
@armResourceOperations(#{ omitTags: true })
interface ReservationOrderResponses {
  /**
   * Get the details of the `ReservationOrder`.
   */
  @summary("Get a specific `ReservationOrder`.")
  @tag("Reservation")
  get is ArmResourceRead<
    ReservationOrderResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * May be used to expand the planInformation.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = Error
  >;

  /**
   * Purchase `ReservationOrder` and create resource under the specified URI.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @tag("Reservation, Purchase")
  @summary("Purchase `ReservationOrder`")
  purchase is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ReservationOrderResponse,
    Request = PurchaseRequest,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResourceUpdatedResponse<ReservationOrderResponse> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ReservationOrderResponse> &
      Azure.Core.Foundations.RetryAfterHeader> &
      Body<ReservationOrderResponse>),
    Error = Error
  >;

  /**
   * List of all the `ReservationOrder`s that the user has access to in the current tenant.
   */
  @summary("Get all `ReservationOrder`s.")
  @tag("Reservation")
  list is ArmResourceListByParent<
    ReservationOrderResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<ReservationOrderList>,
    Error = Error
  >;

  /**
   * Split a `Reservation` into two `Reservation`s with specified quantity distribution.
   */
  @summary("Split the `Reservation`.")
  @tag("Reservation, Split")
  split is ArmResourceActionAsyncBase<
    ReservationOrderResponse,
    SplitRequest,
    ArmResponse<ReservationResponse[]> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ReservationResponse[]> &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = Error
  >;

  /**
   * Merge the specified `Reservation`s into a new `Reservation`. The two `Reservation`s being merged must have same properties.
   */
  @summary("Merges two `Reservation`s.")
  @tag("Reservation, Merge")
  merge is ArmResourceActionAsyncBase<
    ReservationOrderResponse,
    MergeRequest,
    ArmResponse<ReservationResponse[]> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ReservationResponse[]> &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = Error
  >;

  /**
   * Change directory (tenant) of `ReservationOrder` and all `Reservation` under it to specified tenant id
   */
  @summary("Change directory of `ReservationOrder`.")
  @tag("ReservationOrder, ChangeDirectory")
  changeDirectory is ArmResourceActionSync<
    ReservationOrderResponse,
    ChangeDirectoryRequest,
    ArmResponse<ChangeDirectoryResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = Error
  >;

  /**
   * Calculate price for returning `Reservations` if there are no policy errors.
   *
   */
  @summary("Calculate the refund amount of a reservation order.")
  @tag("CalculateRefund")
  @action("calculateRefund")
  post is ArmResourceActionSync<
    ReservationOrderResponse,
    CalculateRefundRequest,
    ArmResponse<CalculateRefundResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = Error
  >;

  /**
   * Return a reservation and get refund information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" ""
  @summary("Return a reservation.")
  @tag("Return")
  @action("return")
  returnPost is ArmResourceActionAsyncBase<
    ReservationOrderResponse,
    RefundRequest,
    ArmResponse<ReservationOrderResponse> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ReservationOrderResponse> &
      Azure.Core.Foundations.RetryAfterHeader> &
      Body<RefundResponse>),
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = Error
  >;
}

@@doc(ReservationOrderResponse.name, "Order Id of the reservation");
@@doc(ReservationOrderResponse.properties,
  "Properties of a reservation order."
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
@@doc(ReservationOrderResponses.returnPost::parameters.body,
  "Information needed for returning reservation."
);
