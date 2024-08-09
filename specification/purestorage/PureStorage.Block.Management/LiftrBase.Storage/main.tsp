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

@versioned(LiftrBase.Storage.Versions)
@armLibraryNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace LiftrBase.Storage;

@doc("Supported versions for LiftrBase.Storage resource model")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1 and LiftrBase.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v1_preview: "2023-06-01-preview",
}

@doc("Reservation resource type.")
@friendlyName("Reservation")
model Reservation<TProperties extends Model = ReservationProperties>
  is Azure.ResourceManager.TrackedResource<TProperties> {
  @doc("The name of the reservation.")
  @segment("reservations")
  @key("reservationName")
  @visibility("read")
  @path
  @minLength(1)
  @maxLength(127)
  @pattern("^[a-zA-Z0-9\\-_]{1,127}$")
  name: string;
}

@armResourceOperations
interface Reservations<
  TReservation extends Foundations.Resource = Reservation,
  TReservationProperties extends Model = ReservationProperties
> {
  get is ArmResourceRead<TReservation>;
  create is ArmResourceCreateOrUpdateAsync<TReservation>;
  update is ArmCustomPatchAsync<
    TReservation,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      TReservation,
      TReservationProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<TReservation>;
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
