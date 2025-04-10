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

namespace Microsoft.Kusto;
/**
 * Class representing a cluster principal assignment.
 */
@parentResource(Cluster)
model ClusterPrincipalAssignment
  is Azure.ResourceManager.ProxyResource<ClusterPrincipalProperties> {
  ...ResourceNameParameter<
    Resource = ClusterPrincipalAssignment,
    KeyName = "principalAssignmentName",
    SegmentName = "principalAssignments",
    NamePattern = "^.*$"
  >;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterPrincipalAssignment,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a Kusto cluster principalAssignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ClusterPrincipalAssignment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Kusto cluster principalAssignments.
   */
  list is ArmResourceListByParent<
    ClusterPrincipalAssignment,
    Response = ArmResponse<ClusterPrincipalAssignmentListResult>
  >;
}

@@doc(ClusterPrincipalAssignment.name,
  "The name of the Kusto principalAssignment."
);
@@doc(ClusterPrincipalAssignment.properties, "The cluster principal.");
@@doc(ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "The Kusto cluster principalAssignment's parameters supplied for the operation."
);
