import "./../LiftrBase/main.tsp";

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.ResourceManager;
using LiftrBase;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.Reflection;
using Azure.ResourceManager.Foundations;

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
@friendlyName("Reservation")
model Reservation<TProperties extends Model = ReservationProperties>
  is TrackedResource<TProperties> {
  @doc("The name of the reservation.")
  @segment("reservations")
  @key("reservationName")
  @visibility("read")
  @path
  @pattern("^[a-zA-Z0-9_]*$")
  name: string;
}

@armResourceOperations
interface Reservations<
  TReservation extends ArmResource = Reservation,
  TReservationProperties extends Model = ReservationProperties
> {
  get is ArmResourceRead<TReservation>;
  create is ArmResourceCreateOrUpdateAsync<TReservation>;
  update is ArmResourcePatchAsync<TReservation, TReservationProperties>;
  delete is ArmResourceDeleteAsync<TReservation>;
  listByResourceGroup is ArmResourceListByParent<TReservation>;
  listBySubscription is ArmListBySubscription<TReservation>;
}

@doc("Properties of a Reservation resource.")
model ReservationProperties<TProperties extends Model = BaseResourceProperties> {

  @doc("Internal ID of Reservation.")
  @visibility("read")
  reservationInternalId?: string;

  ...TProperties;
}