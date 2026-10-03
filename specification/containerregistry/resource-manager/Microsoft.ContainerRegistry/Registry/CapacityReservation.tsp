import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./CapacityReservation.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ContainerRegistry;

/**
 * A reservation of request-rate, ingress, and egress capacity on a Dogfood stamp.
 */
@added(Versions.vLatestPreview)
model CapacityReservation is Azure.ResourceManager.TrackedResource<CapacityReservationProperties> {
  ...ResourceNameParameter<
    Resource = CapacityReservation,
    KeyName = "capacityReservationName",
    SegmentName = "capacityReservations",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{2,62}$"
  >;
}

@added(Versions.vLatestPreview)
@armResourceOperations
interface CapacityReservations {
  /**
   * Gets a capacity reservation.
   */
  get is ArmResourceRead<CapacityReservation>;

  /**
   * Creates or replaces a capacity reservation.
   */
  create is ArmResourceCreateOrReplaceAsync<CapacityReservation>;

  /**
   * Resizes a capacity reservation.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    CapacityReservation,
    PatchModel = CapacityReservationUpdate,
    Response = ArmResponse<CapacityReservation> | ArmResourceCreatedResponse<
      CapacityReservation,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = CapacityReservation> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a capacity reservation.
   */
  delete is ArmResourceDeleteWithoutOkAsync<CapacityReservation>;

  /**
   * Lists capacity reservations in a resource group.
   */
  @list
  listByResourceGroup is ArmResourceListByParent<
    CapacityReservation,
    Response = ArmResponse<CapacityReservationListResult>
  >;

  /**
   * Lists capacity reservations in a subscription.
   */
  @list
  listBySubscription is ArmListBySubscription<
    CapacityReservation,
    Response = ArmResponse<CapacityReservationListResult>
  >;

  /**
   * Associates a registry with this capacity reservation.
   */
  associate is ArmResourceActionSync<
    CapacityReservation,
    RegistryAssociationRequest,
    ArmNoContentResponse
  >;

  /**
   * Removes a registry association from this capacity reservation.
   */
  disassociate is ArmResourceActionSync<
    CapacityReservation,
    RegistryAssociationRequest,
    ArmNoContentResponse
  >;

  /**
   * Lists registries associated with this capacity reservation.
   */
  @list
  listRegistries is ArmResourceActionSync<
    CapacityReservation,
    void,
    ArmResponse<ReservationRegistryAssociationListResult>
  >;
}

@@maxLength(CapacityReservation.name, 63);
@@minLength(CapacityReservation.name, 3);
@@doc(CapacityReservation.name, "The name of the capacity reservation.");
@@doc(CapacityReservation.properties, "The properties of the capacity reservation.");
