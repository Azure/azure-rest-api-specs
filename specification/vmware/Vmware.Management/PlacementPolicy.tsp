import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A vSphere Distributed Resource Scheduler (DRS) placement policy
 */
@parentResource(Cluster)
model PlacementPolicy
  is Azure.ResourceManager.ProxyResource<PlacementPolicyProperties> {
  ...ResourceNameParameter<
    Resource = PlacementPolicy,
    KeyName = "placementPolicyName",
    SegmentName = "placementPolicies",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface PlacementPolicies {
  /**
   * Get a PlacementPolicy
   */
  get is ArmResourceRead<PlacementPolicy>;

  /**
   * Create a PlacementPolicy
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PlacementPolicy>;

  /**
   * Update a PlacementPolicy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PlacementPolicy,
    PatchModel = PlacementPolicyUpdate,
    Response = ArmResponse<PlacementPolicy> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: PlacementPolicy;
    })
  >;

  /**
   * Delete a PlacementPolicy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PlacementPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List PlacementPolicy resources by Cluster
   */
  list is ArmResourceListByParent<
    PlacementPolicy,
    Response = ArmResponse<PlacementPoliciesList>
  >;
}

@@doc(PlacementPolicy.name, "Name of the placement policy.");
@@doc(PlacementPolicy.properties,
  "The resource-specific properties for this resource."
);
@@doc(PlacementPolicies.update::parameters.properties,
  "The placement policy properties to be updated."
);
