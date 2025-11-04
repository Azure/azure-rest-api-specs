import "../Models/ResourceManager.tsp";
import "../Models/ServerAssociation.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;

namespace Microsoft.AszLabHardware;

@doc("A physical computer which can be reserved for use by a user")
model Reservation is TrackedResource<ReservationProperties> {
  @doc("The name of the reservation")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("reservationName")
  @segment("reservations")
  @path
  name: string;
}

@doc("Details of the AszLabHw Reservation.")
model ReservationProperties {
  @visibility(Lifecycle.Read)
  @doc("The current status of the GoalState")
  resourceManager?: ResourceManager;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The set of Servers to create the reservation.")
  @identifiers(#["server"])
  serverAssociations?: ServerAssociation[];

  @doc("List of reserved pool servers")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  servers: PoolServerResourceId[];
}

@armResourceOperations
interface Reservations {
  get is ArmResourceRead<Reservation>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Reservation>;
  update is ArmCustomPatchAsync<
    Reservation,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Reservation,
      ReservationProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Reservation>;
  listByResourceGroup is ArmResourceListByParent<Reservation>;
  listBySubscription is ArmListBySubscription<Reservation>;
}
