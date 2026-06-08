import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

model CapacityReservationGroup
  is Azure.ResourceManager.TrackedResource<
    CapacityReservationGroupProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = CapacityReservationGroup,
    KeyName = "groupId",
    SegmentName = "capacityReserverationGroups",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface CapacityReservationGroups {
  /**
   * Get CapacityReservationGroup
   */
  get is ArmResourceRead<CapacityReservationGroup>;

  /**
   * Create or update CapacityReservationGroup
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<CapacityReservationGroup>;

  /**
   * Update CapacityReservationGroup
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    CapacityReservationGroup,
    PatchModel = PartialMinimalTrackedResourceWithSkuAndIdentity
  >;

  /**
   * Delete CapacityReservationGroup
   */
  delete is ArmResourceDeleteSync<CapacityReservationGroup>;

  /**
   * Lists CapacityReservationGroups
   */
  list is ArmResourceListByParent<
    CapacityReservationGroup,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<CapacityReservationGroupTrackedResourceArmPaginatedResult>
  >;

  /**
   * List CapacityReservationGroups by subscription
   */
  listBySubscription is ArmListBySubscription<
    CapacityReservationGroup,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<CapacityReservationGroupTrackedResourceArmPaginatedResult>
  >;
}

@@doc(CapacityReservationGroup.name, "Group ID");
@@doc(
  CapacityReservationGroup.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  CapacityReservationGroups.createOrUpdate::parameters.resource,
  "Capacity Reservation Group payload to create"
);
@@doc(
  CapacityReservationGroups.update::parameters.properties,
  "Capacity Reservation Group payload to update"
);
