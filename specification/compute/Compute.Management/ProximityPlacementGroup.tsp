import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the proximity placement group.
 */
model ProximityPlacementGroup
  is Azure.ResourceManager.TrackedResource<ProximityPlacementGroupProperties> {
  ...ResourceNameParameter<
    Resource = ProximityPlacementGroup,
    KeyName = "proximityPlacementGroupName",
    SegmentName = "proximityPlacementGroups",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

@armResourceOperations
interface ProximityPlacementGroups {
  /**
   * Retrieves information about a proximity placement group .
   */
  get is ComputeResourceRead<
    ProximityPlacementGroup,
    Parameters = {
      /**
       * includeColocationStatus=true enables fetching the colocation status of all the resources in the proximity placement group.
       */
      @query("includeColocationStatus")
      includeColocationStatus?: string;
    }
  >;

  /**
   * Create or update a proximity placement group.
   */
  createOrUpdate is ComputeResourceCreateOrReplaceSync<ProximityPlacementGroup>;

  /**
   * Update a proximity placement group.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchSync<
    ProximityPlacementGroup,
    ProximityPlacementGroupUpdate
  >;

  /**
   * Delete a proximity placement group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ComputeResourceDeleteSync<
    ProximityPlacementGroup,
    Response = ArmDeletedResponse
  >;

  /**
   * Lists all proximity placement groups in a resource group.
   */
  listByResourceGroup is ComputeResourceListByParent<
    ProximityPlacementGroup,
    Response = ProximityPlacementGroupListResult
  >;

  /**
   * Lists all proximity placement groups in a subscription.
   */
  listBySubscription is ComputeListBySubscription<
    ProximityPlacementGroup,
    Response = ProximityPlacementGroupListResult
  >;
}

@@doc(ProximityPlacementGroup.name,
  "The name of the proximity placement group."
);
@@doc(ProximityPlacementGroup.properties,
  "Describes the properties of a Proximity Placement Group."
);
@@doc(ProximityPlacementGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Proximity Placement Group operation."
);
@@doc(ProximityPlacementGroups.update::parameters.properties,
  "Parameters supplied to the Update Proximity Placement Group operation."
);
