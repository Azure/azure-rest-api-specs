import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * Details of a reservation order being returned.
 */
@tenantResource
@parentResource(BillingAccount)
model ReservationOrder
  is Azure.ResourceManager.ProxyResource<ReservationOrderProperty> {
  ...ResourceNameParameter<
    Resource = ReservationOrder,
    KeyName = "reservationOrderId",
    SegmentName = "reservationOrders",
    NamePattern = ""
  >;

  /** The ETag of the reservation order. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation for back compat."
  etag?: int32;

  /**
   * Tags for this reservation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface ReservationOrders {
  /**
   * Get the details of the ReservationOrder in the billing account.
   */
  @summary("Get a specific ReservationOrder in the billing account.")
  @tag("ReservationOrder")
  getByBillingAccount is ArmResourceRead<
    ReservationOrder,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * May be used to expand the detail information of some properties.
       */
      @query("expand")
      expand?: string;
    }
  >;

  /**
   * List all the ReservationOrders in the billing account.
   */
  @summary("Get all `ReservationOrders in the billing account.")
  @tag("ReservationOrders")
  listByBillingAccount is ArmResourceListByParent<
    ReservationOrder,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      @query("orderBy")
      orderBy?: string;

      /**
       * The number of reservations to skip from the list before returning results
       */
      @query("skiptoken")
      skiptoken?: float32;
    },
    Response = ArmResponse<ReservationOrderList>
  >;
}

@@doc(ReservationOrder.name, "Order Id of the reservation");
@@doc(
  ReservationOrder.properties,
  "The properties associated to this reservation order"
);
