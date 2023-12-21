import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ReservationOrderResponse.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Reservations;
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
interface Reservation {
  @doc("Get specific `Reservation` details.")
  get is ArmResourceRead<
    ReservationResponse,
    {
      ...BaseParameters<ReservationResponse>;

      @doc("Supported value of this query is renewProperties")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Updates the applied scopes of the `Reservation`.")
  update is ArmResourcePatchAsync<ReservationResponse, ReservationsProperties>;
  @doc("List `Reservation`s within a single `ReservationOrder`.")
  list is ArmResourceListByParent<ReservationResponse>;
  @doc("List the reservations and the roll up counts of reservations group by provisioning states that the user has access to in the current tenant.")
  listAll is ArmListBySubscription<ReservationResponse>;
  @doc("""
Check whether the scopes from request is valid for `Reservation`.

""")
  availableScopes is ArmResourceActionAsync<
    ReservationResponse,
    AvailableScopeRequest,
    AvailableScopeProperties
  >;
  @doc("Archiving a `Reservation` moves it to `Archived` state.")
  archive is ArmResourceActionSync<ReservationResponse, void, void>;
  @doc("""
Restores a `Reservation` to the state it was before archiving.

""")
  unarchive is ArmResourceActionSync<ReservationResponse, void, void>;
}
