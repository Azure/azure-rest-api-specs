import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Capacity;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: int32;
}

@armResourceOperations
interface ReservationOrderResponses {
  /**
   * Get the details of the `ReservationOrder`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReservationOrder_Get")
  get is ArmResourceRead<
    ReservationOrderResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * May be used to expand the planInformation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Purchase `ReservationOrder` and create resource under the specified URI.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("ReservationOrder_Purchase")
  purchase is ArmResourceCreateOrReplaceAsync<
    ReservationOrderResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResourceUpdatedResponse<ReservationOrderResponse> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ReservationOrderResponse;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List of all the `ReservationOrder`s that the user has access to in the current tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReservationOrder_List")
  list is ArmResourceListByParent<
    ReservationOrderResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<ReservationOrderList>
  >;

  /**
   * Split a `Reservation` into two `Reservation`s with specified quantity distribution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reservation_Split")
  split is ArmResourceActionAsync<
    ReservationOrderResponse,
    SplitRequest,
    ArmResponse<ReservationResponse[]>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Merge the specified `Reservation`s into a new `Reservation`. The two `Reservation`s being merged must have same properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reservation_Merge")
  merge is ArmResourceActionAsync<
    ReservationOrderResponse,
    MergeRequest,
    ArmResponse<ReservationResponse[]>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Change directory (tenant) of `ReservationOrder` and all `Reservation` under it to specified tenant id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReservationOrder_ChangeDirectory")
  changeDirectory is ArmResourceActionSync<
    ReservationOrderResponse,
    ChangeDirectoryRequest,
    ArmResponse<ChangeDirectoryResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Calculate price for returning `Reservations` if there are no policy errors.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("calculateRefund")
  @operationId("CalculateRefund_Post")
  post is ArmResourceActionSync<
    ReservationOrderResponse,
    CalculateRefundRequest,
    ArmResponse<CalculateRefundResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Return a reservation and get refund information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("return")
  @operationId("Return_Post")
  returnPost is ArmResourceActionAsync<
    ReservationOrderResponse,
    RefundRequest,
    ArmResponse<ReservationOrderResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
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
