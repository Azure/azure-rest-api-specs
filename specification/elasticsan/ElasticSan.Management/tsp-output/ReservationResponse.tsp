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
@doc("The definition of the reservation.")
@parentResource(ReservationOrderResponse)
model ReservationResponse is ProxyResource<ReservationsProperties> {
  @doc("Id of the reservation item")
  @path
  @key("reservationId")
  @segment("reservations")
  name: string;

  etag?: int32;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ReservationResponses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get specific `Reservation` details.")
  @operationId("Reservation_Get")
  get is ArmResourceRead<
    ReservationResponse,
    {
      ...BaseParameters<ReservationResponse>;

      @doc("Supported value of this query is renewProperties")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the applied scopes of the `Reservation`.")
  @operationId("Reservation_Update")
  update is ArmCustomPatchAsync<
    ReservationResponse,
    Patch,
    BaseParameters<ReservationResponse>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List `Reservation`s within a single `ReservationOrder`.")
  @operationId("Reservation_List")
  list is ArmResourceListByParent<ReservationResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the reservations and the roll up counts of reservations group by provisioning states that the user has access to in the current tenant.")
  @operationId("Reservation_ListAll")
  listAll is ArmListBySubscription<ReservationResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("""
Check whether the scopes from request is valid for `Reservation`.

""")
  @operationId("Reservation_AvailableScopes")
  availableScopes is ArmResourceActionAsync<
    ReservationResponse,
    AvailableScopeRequest,
    AvailableScopeProperties
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Archiving a `Reservation` moves it to `Archived` state.")
  @operationId("Reservation_Archive")
  archive is ArmResourceActionSync<ReservationResponse, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("""
Restores a `Reservation` to the state it was before archiving.

""")
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
