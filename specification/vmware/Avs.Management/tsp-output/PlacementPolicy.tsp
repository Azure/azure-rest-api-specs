import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A vSphere Distributed Resource Scheduler (DRS) placement policy
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(PlacementPolicyProperties)
model PlacementPolicy extends ProxyResourceBase {
  /**
   * Name of the VMware vSphere Distributed Resource Scheduler (DRS) placement policy
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("placementPolicyName")
  @segment("placementPolicies")
  @visibility("read")
  name: string;

  /**
   * placement policy properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: PlacementPolicyProperties;
}

@armResourceOperations
interface PlacementPolicies {
  /**
   * Get a placement policy by name in a private cloud cluster
   */
  get is ArmResourceRead<PlacementPolicy>;

  /**
   * Create or update a placement policy in a private cloud cluster
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PlacementPolicy>;

  /**
   * Update a placement policy in a private cloud cluster
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<PlacementPolicy, PlacementPolicyUpdate>;

  /**
   * Delete a placement policy in a private cloud cluster
   */
  delete is ArmResourceDeleteAsync<PlacementPolicy>;

  /**
   * List placement policies in a private cloud cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PlacementPolicies_List")
  list is ArmResourceListByParent<PlacementPolicy>;
}

@@projectedName(PlacementPolicies.createOrUpdate::parameters.resource,
  "json",
  "placementPolicy"
);
@@extension(PlacementPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "placementPolicy"
);
@@doc(PlacementPolicies.createOrUpdate::parameters.resource,
  "A placement policy in the private cloud cluster"
);
@@projectedName(PlacementPolicies.update::parameters.properties,
  "json",
  "placementPolicyUpdate"
);
@@extension(PlacementPolicies.update::parameters.properties,
  "x-ms-client-name",
  "placementPolicyUpdate"
);
@@doc(PlacementPolicies.update::parameters.properties,
  "The placement policy properties that may be updated"
);
