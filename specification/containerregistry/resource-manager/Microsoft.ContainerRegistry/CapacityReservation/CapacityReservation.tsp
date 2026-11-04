import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./CapacityReservation.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ContainerRegistry;

/** A reservation of request-rate, ingress, and egress capacity on a Dogfood stamp. */
@added(Versions.vLatestPreview)
model CapacityReservation is TrackedResource<CapacityReservationProperties> {
  ...ResourceNameParameter<
    Resource = CapacityReservation,
    KeyName = "capacityReservationName",
    SegmentName = "capacityReservations",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{2,62}$"
  >;
}

/** A reservation operation accepted for asynchronous completion. */
model CapacityReservationAcceptedResponse {
  ...ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = CapacityReservation> &
    ArmLroLocationHeader<FinalResult = CapacityReservation> &
    Azure.Core.Foundations.RetryAfterHeader>;

  /** The reservation while provisioning is in progress. */
  @bodyRoot
  body: CapacityReservation;
}

@armResourceOperations
interface CapacityReservations {
  /** Gets a capacity reservation. */
  get is ArmResourceRead<CapacityReservation>;

  /** Creates or idempotently replaces a capacity reservation. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The existing Dogfood POC returns 202 while provisioning; preserve its wire behavior."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The existing Dogfood POC returns the pending reservation in its 202 response."
  create is ArmResourceCreateOrReplaceAsync<
    CapacityReservation,
    Response = ArmResponse<CapacityReservation> | ArmCreatedResponse<CapacityReservation> | CapacityReservationAcceptedResponse
  >;

  /** Resizes a capacity reservation. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The existing Dogfood POC returns the pending reservation in its 202 response."
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    CapacityReservation,
    PatchModel = CapacityReservationUpdate,
    Response = ArmResponse<CapacityReservation> | CapacityReservationAcceptedResponse
  >;

  /** Deletes a capacity reservation after its minimum commitment has elapsed. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The existing Dogfood POC completes deletion synchronously with 204, never 200."
  delete is ArmResourceDeleteSync<
    CapacityReservation,
    Response = ArmNoContentResponse
  >;

  /** Lists capacity reservations in a resource group. */
  @list
  listByResourceGroup is ArmResourceListByParent<
    CapacityReservation,
    Response = ArmResponse<CapacityReservationListResult>
  >;

  /** Lists capacity reservations in a subscription. */
  @list
  listBySubscription is ArmListBySubscription<
    CapacityReservation,
    Response = ArmResponse<CapacityReservationListResult>
  >;

  /** Associates a registry with this capacity reservation. */
  associate is ArmResourceActionSync<
    CapacityReservation,
    RegistryAssociationRequest,
    ArmNoContentResponse
  >;

  /** Removes a registry association from this capacity reservation. */
  disassociate is ArmResourceActionSync<
    CapacityReservation,
    RegistryAssociationRequest,
    ArmNoContentResponse
  >;

  /** Lists registries associated with this capacity reservation. */
  @list
  listRegistries is ArmResourceActionSync<
    CapacityReservation,
    void,
    ArmResponse<ReservationRegistryAssociationListResult>
  >;
}

@armResourceOperations
interface CapacityReservationStampOperations {
  /** Onboards or re-seeds a Dogfood stamp capacity ledger. */
  @autoRoute
  @armResourceCollectionAction
  @armProviderNameValue
  @action("seedCapacityLedger")
  @post
  seedCapacityLedger(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...Foundations.DefaultProviderNamespace,
    ...LocationResourceParameter,

    /** The stamp capacity values to seed. */
    @body request: SeedCapacityLedgerRequest,
  ): ArmResponse<StampCapacityLedger>;
}

@@maxLength(CapacityReservation.name, 63);
@@minLength(CapacityReservation.name, 3);
@@doc(CapacityReservation.name, "The name of the capacity reservation.");
@@doc(CapacityReservation.properties,
  "The properties of the capacity reservation."
);
