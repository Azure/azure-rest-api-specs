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
/**
 * Details of a reservation order being returned.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(ReservationOrderProperties)
@includeInapplicableMetadataInPayload(false)
model ReservationOrderResponse extends ProxyResourceBase {
  /**
   * Order Id of the reservation
   */
  @path
  @key("reservationOrderId")
  @segment("reservationOrders")
  name: string;

  etag?: int32;

  /**
   * Properties of a reservation order.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ReservationOrderProperties;
}

@armResourceOperations
interface ReservationOrderResponses {
  /**
   * Get the details of the `ReservationOrder`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReservationOrder_Get")
  get is ArmResourceRead<
    ReservationOrderResponse,
    {
      ...BaseParameters<ReservationOrderResponse>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReservationOrder_Purchase")
  purchase is ArmResourceCreateOrReplaceAsync<
    ReservationOrderResponse,
    BaseParameters<ReservationOrderResponse>,
    ArmLroLocationHeader
  >;

  /**
   * List of all the `ReservationOrder`s that the user has access to in the current tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReservationOrder_List")
  list is ArmResourceListByParent<ReservationOrderResponse>;

  /**
   * Split a `Reservation` into two `Reservation`s with specified quantity distribution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reservation_Split")
  split is ArmResourceActionAsync<
    ReservationOrderResponse,
    SplitRequest,
    void,
    BaseParameters<ReservationOrderResponse>,
    ArmLroLocationHeader
  >;

  /**
   * Merge the specified `Reservation`s into a new `Reservation`. The two `Reservation`s being merged must have same properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reservation_Merge")
  merge is ArmResourceActionAsync<
    ReservationOrderResponse,
    MergeRequest,
    void,
    BaseParameters<ReservationOrderResponse>,
    ArmLroLocationHeader
  >;

  /**
   * Change directory (tenant) of `ReservationOrder` and all `Reservation` under it to specified tenant id
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReservationOrder_ChangeDirectory")
  changeDirectory is ArmResourceActionSync<
    ReservationOrderResponse,
    ChangeDirectoryRequest,
    ChangeDirectoryResponse
  >;

  /**
   * Calculate price for returning `Reservations` if there are no policy errors.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CalculateRefund_Post")
  post is ArmResourceActionSync<
    ReservationOrderResponse,
    CalculateRefundRequest,
    CalculateRefundResponse
  >;

  /**
   * Return a reservation and get refund information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
