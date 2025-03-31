import "./../LiftrBase/main.tsp";
import "./../main.tsp";
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
  v1_preview: "2024-10-01-preview",
}

#suppress "@azure-tools/typespec-azure-core/friendly-name" "Legacy"
@doc("Pure Storage cloud service resource type, also called reservation")
@friendlyName("Reservation")
model Reservation<TProperties extends Model = ReservationProperties>
  is Azure.ResourceManager.TrackedResource<TProperties> {
  @doc("Name of the reservation.")
  @segment("reservations")
  @key("reservationName")
  @visibility(Lifecycle.Read)
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
  @doc("Get a reservation")
  get is ArmResourceRead<TReservation>;
  @doc("Create a reservation")
  create is ArmResourceCreateOrUpdateAsync<TReservation>;
  @doc("Update a reservation")
  update is ArmCustomPatchAsync<
    TReservation,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      TReservation,
      TReservationProperties
    >
  >;
  @doc("Delete a reservation")
  delete is ArmResourceDeleteWithoutOkAsync<TReservation>;
  @doc("List reservations by resource group")
  listByResourceGroup is ArmResourceListByParent<TReservation>;
  @doc("List reservations by Azure subscription ID")
  listBySubscription is ArmListBySubscription<TReservation>;
}

@doc("Properties of a Reservation resource.")
model ReservationProperties<TProperties extends Model = BaseResourceProperties> {
  @doc("Pure Storage's internal ID for the reservation")
  @visibility(Lifecycle.Read)
  reservationInternalId?: string;

  ...TProperties;
}
