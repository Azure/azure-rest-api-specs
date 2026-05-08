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

namespace Reservations;
/**
 * The definition of the reservation.
 */
@tenantResource
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
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

@armResourceOperations(#{ omitTags: true })
interface ReservationResponses {
  /**
   * Get specific `Reservation` details.
   */
  @summary("Get `Reservation` details.")
  @tag("Reservation")
  get is ArmResourceRead<
    ReservationResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * Supported value of this query is renewProperties
       */
      @query("$expand")
      $expand?: string;
    },
    Error = Error
  >;

  /**
   * Updates the applied scopes of the `Reservation`.
   */
  @summary("Updates a `Reservation`.")
  @tag("Reservation")
  @tag("ApplyScope")
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    ReservationResponse,
    PatchModel = Patch,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ReservationResponse> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = Error
  >;

  /**
   * List `Reservation`s within a single `ReservationOrder`.
   */
  @summary("Get `Reservation`s in a given reservation Order")
  @tag("Reservation")
  list is ArmResourceListByParent<
    ReservationResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<ReservationList>,
    Error = Error
  >;

  /**
   * Check whether the scopes from request is valid for `Reservation`.
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" ""
  @summary("Get Available Scopes for `Reservation`.")
  @tag("Reservation, AvailableScopes")
  availableScopes is ArmResourceActionAsyncBase<
    ReservationResponse,
    AvailableScopeRequest,
    ArmResponse<AvailableScopeProperties> & {
      ...ArmLroLocationHeader<FinalResult = AvailableScopeProperties>;
      ...Azure.Core.Foundations.RetryAfterHeader;
    },
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = Error
  >;

  /**
   * Archiving a `Reservation` moves it to `Archived` state.
   */
  @summary("Archive a `Reservation`.")
  @tag("Reservation, Archive")
  archive is ArmResourceActionSync<
    ReservationResponse,
    void,
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = Error
  >;

  /**
   * Restores a `Reservation` to the state it was before archiving.
   *
   */
  @summary("Unarchive a `Reservation`.")
  @tag("Reservation, Unarchive")
  unarchive is ArmResourceActionSync<
    ReservationResponse,
    void,
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = Error
  >;

  /**
   * List of all the revisions for the `Reservation`.
   */
  @summary("Get `Reservation` revisions.")
  @tag("Reservation")
  @list
  @get
  @action("revisions")
  listRevisions is ArmResourceActionSync<
    ReservationResponse,
    void,
    ArmResponse<ReservationList>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = Error
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
