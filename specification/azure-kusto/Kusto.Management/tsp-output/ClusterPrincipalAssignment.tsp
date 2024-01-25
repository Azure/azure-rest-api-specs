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

namespace Microsoft.Kusto;
/**
 * Class representing a cluster principal assignment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ClusterPrincipalProperties)
model ClusterPrincipalAssignment extends ProxyResourceBase {
  /**
   * The name of the Kusto principalAssignment.
   */
  @pattern("^.*$")
  @path
  @key("principalAssignmentName")
  @segment("principalAssignments")
  @visibility("read")
  name: string;

  /**
   * The cluster principal.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterPrincipalProperties;
}

@armResourceOperations
interface ClusterPrincipalAssignments {
  /**
   * Gets a Kusto cluster principalAssignment.
   */
  get is ArmResourceRead<ClusterPrincipalAssignment>;

  /**
   * Create a Kusto cluster principalAssignment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ClusterPrincipalAssignment>;

  /**
   * Deletes a Kusto cluster principalAssignment.
   */
  delete is ArmResourceDeleteAsync<ClusterPrincipalAssignment>;

  /**
   * Lists all Kusto cluster principalAssignments.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ClusterPrincipalAssignments_List")
  list is ArmResourceListByParent<ClusterPrincipalAssignment>;
}

@@projectedName(ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "The Kusto cluster principalAssignment's parameters supplied for the operation."
);
