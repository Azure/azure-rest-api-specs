import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ReservationOrder.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Reservations;
@doc("The definition of the reservation.")
@parentResource(ReservationOrder)
model ReservationDetail is ProxyResource<ReservationsProperties> {
  @doc("Id of the reservation item")
  @path
  @key("reservationId")
  @segment("reservations")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ReservationDetails {
  @doc("Get specific `Reservation` details.")
  get is ArmResourceRead<
    ReservationDetail,
    {
      ...BaseParameters<ReservationDetail>;

      @doc("Supported value of this query is renewProperties")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Updates the applied scopes of the `Reservation`.")
  update is ArmResourcePatchAsync<ReservationDetail, ReservationsProperties>;
  @doc("List `Reservation`s within a single `ReservationOrder`.")
  list is ArmResourceListByParent<ReservationDetail>;
  @doc("List the reservations and the roll up counts of reservations group by provisioning states that the user has access to in the current tenant.")
  listAll is ArmListBySubscription<ReservationDetail>;
  @doc("""
Check whether the scopes from request is valid for `Reservation`.

""")
  availableScopes is ArmResourceActionAsync<
    ReservationDetail,
    AvailableScopeRequest,
    AvailableScopeProperties
  >;
  @doc("Archiving a `Reservation` moves it to `Archived` state.")
  archive is ArmResourceActionSync<ReservationDetail, {}, {}>;
  @doc("""
Restores a `Reservation` to the state it was before archiving.

""")
  unarchive is ArmResourceActionSync<ReservationDetail, {}, {}>;
}
