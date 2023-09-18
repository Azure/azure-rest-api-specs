import "./../LiftrBase/main.tsp";

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.ResourceManager;
using LiftrBase;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@versioned(LiftrBase.Storage.Versions)
@armLibraryNamespace
namespace LiftrBase.Storage;

@doc("Supported versions for LiftrBase.Storage resource model")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1 and LiftrBase.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  v1_preview: "2023-06-01-preview",
}

@doc("Reservation resource type.")
model Reservation is TrackedResource<ReservationProperties> {
  @doc("The name of the reservation.")
  @segment("reservations")
  @key("reservationName")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations
interface Reservations {
  get is ArmResourceRead<Reservation>;
  create is ArmResourceCreateOrUpdateAsync<Reservation>;
  update is ArmResourcePatchAsync<Reservation, ReservationProperties>;
  delete is ArmResourceDeleteAsync<Reservation>;
  listByResourceGroup is ArmResourceListByParent<Reservation>;
  listBySubscription is ArmListBySubscription<Reservation>;
}

@doc("Properties of a Reservation resource.")
model ReservationProperties is BaseResourceProperties;

@doc("Describes parameters for Virtual Network to deploy to (VNet injection).")
model VnetInjection {
  @doc("Full Azure Resource ID of the Virtual Network subnet to make the Pool visible in.")
  subnetId: string;
}