import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ReservationOrderResponse.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Capacity;
/**
 * The definition of the reservation.
 */
@parentResource(ReservationOrderResponse)
model ReservationResponse
  is Azure.ResourceManager.ProxyResource<ReservationsProperties> {
  ...ResourceNameParameter<
    Resource = ReservationResponse,
    KeyName = "reservationId",
    SegmentName = "reservations",
    NamePattern = ""
  >;

  /**
   * The Azure region where the reserved resource lives.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: int32;

  /**
   * The sku information associated to this reservation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: SkuName;

  /**
   * Resource Provider type to be reserved.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: "Microsoft.Compute";
}

@armResourceOperations
interface ReservationResponses {
  /**
   * Get specific `Reservation` details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reservation_Get")
  get is ArmResourceRead<
    ReservationResponse,
    Parameters = {
      /**
       * Supported value of this query is renewProperties
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Updates the applied scopes of the `Reservation`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Reservation_Update")
  update is ArmCustomPatchAsync<
    ReservationResponse,
    PatchModel = Patch,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List `Reservation`s within a single `ReservationOrder`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reservation_List")
  list is ArmResourceListByParent<
    ReservationResponse,
    Response = ArmResponse<ReservationList>
  >;

  /**
   * Check whether the scopes from request is valid for `Reservation`.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reservation_AvailableScopes")
  availableScopes is ArmResourceActionAsyncBase<
    ReservationResponse,
    AvailableScopeRequest,
    ArmResponse<AvailableScopeProperties>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ReservationResponse>
  >;

  /**
   * Archiving a `Reservation` moves it to `Archived` state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reservation_Archive")
  archive is ArmResourceActionSync<ReservationResponse, void, OkResponse>;

  /**
   * Restores a `Reservation` to the state it was before archiving.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reservation_Unarchive")
  unarchive is ArmResourceActionSync<ReservationResponse, void, OkResponse>;

  /**
   * List of all the revisions for the `Reservation`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("revisions")
  @operationId("Reservation_ListRevisions")
  listRevisions is ArmResourceActionSync<
    ReservationResponse,
    void,
    ArmResponse<ReservationList>
  >;
}

@@doc(ReservationResponse.name, "Id of the reservation item");
@@doc(ReservationResponse.properties,
  "The properties associated to this reservation "
);
@@doc(ReservationResponses.update::parameters.properties,
  "Information needed to patch a reservation item"
);
@@doc(ReservationResponses.availableScopes::parameters.body,
  "Scopes to be checked for eligibility."
);
