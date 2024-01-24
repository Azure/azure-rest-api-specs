import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ReservationOrderResponse.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Capacity;
/**
 * The definition of the reservation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ReservationOrderResponse)
@Azure.ResourceManager.Private.armResourceInternal(ReservationsProperties)
@includeInapplicableMetadataInPayload(false)
model ReservationResponse extends ProxyResourceBase {
  /**
   * Id of the reservation item
   */
  @path
  @key("reservationId")
  @segment("reservations")
  name: string;

  etag?: int32;

  /**
   * Resource Provider type to be reserved.
   */
  kind?: "Microsoft.Compute";

  /**
   * The properties associated to this reservation
   */
  @extension("x-ms-client-flatten", true)
  properties?: ReservationsProperties;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ReservationResponses {
  /**
   * Get specific `Reservation` details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reservation_Get")
  get is ArmResourceRead<
    ReservationResponse,
    {
      ...BaseParameters<ReservationResponse>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Reservation_Update")
  update is ArmCustomPatchAsync<
    ReservationResponse,
    Patch,
    BaseParameters<ReservationResponse>,
    ArmAsyncOperationHeader
  >;

  /**
   * List `Reservation`s within a single `ReservationOrder`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reservation_List")
  list is ArmResourceListByParent<ReservationResponse>;

  /**
   * List the reservations and the roll up counts of reservations group by provisioning states that the user has access to in the current tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reservation_ListAll")
  listAll is ArmListBySubscription<ReservationResponse>;

  /**
   * Check whether the scopes from request is valid for `Reservation`.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reservation_AvailableScopes")
  availableScopes is ArmResourceActionAsync<
    ReservationResponse,
    AvailableScopeRequest,
    AvailableScopeProperties
  >;

  /**
   * Archiving a `Reservation` moves it to `Archived` state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reservation_Archive")
  archive is ArmResourceActionSync<ReservationResponse, void, void>;

  /**
   * Restores a `Reservation` to the state it was before archiving.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reservation_Unarchive")
  unarchive is ArmResourceActionSync<ReservationResponse, void, void>;
}

@@projectedName(ReservationResponses.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ReservationResponses.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ReservationResponses.update::parameters.properties,
  "Information needed to patch a reservation item"
);
@@doc(ReservationResponses.availableScopes::parameters.body,
  "Scopes to be checked for eligibility."
);
