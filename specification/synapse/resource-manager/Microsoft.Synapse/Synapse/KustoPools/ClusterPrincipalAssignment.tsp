import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./KustoPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace KustoPools;
/**
 * Class representing a cluster principal assignment.
 */
model ClusterPrincipalAssignment
  is Azure.ResourceManager.ProxyResource<ClusterPrincipalProperties> {
  ...ResourceNameParameter<
    Resource = ClusterPrincipalAssignment,
    KeyName = "principalAssignmentName",
    SegmentName = "principalAssignments",
    NamePattern = ""
  >;
}

alias ClusterPrincipalAssignmentOps = Azure.ResourceManager.Legacy.LegacyOperations<
  KustoPoolParentParameters,
  {
    /** The name of the Kusto principalAssignment. */
    @segment("principalAssignments")
    @key
    @path
    principalAssignmentName: string;
  }
>;

@armResourceOperations
interface ClusterPrincipalAssignments {
  /**
   * Gets a Kusto pool principalAssignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolPrincipalAssignments_Get")
  get is ClusterPrincipalAssignmentOps.Read<ClusterPrincipalAssignment>;

  /**
   * Create a Kusto pool principalAssignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolPrincipalAssignments_CreateOrUpdate")
  createOrUpdate is ClusterPrincipalAssignmentOps.CreateOrUpdateAsync<
    ClusterPrincipalAssignment,
    LroHeaders = ArmLroLocationHeader<FinalResult = ClusterPrincipalAssignment> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a Kusto pool principalAssignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("KustoPoolPrincipalAssignments_Delete")
  delete is ClusterPrincipalAssignmentOps.DeleteWithoutOkAsync<
    ClusterPrincipalAssignment,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Kusto pool principalAssignments.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolPrincipalAssignments_List")
  list is ClusterPrincipalAssignmentOps.List<
    ClusterPrincipalAssignment,
    Response = ArmResponse<ClusterPrincipalAssignmentListResult>
  >;
}

@@doc(
  ClusterPrincipalAssignment.name,
  "The name of the Kusto principalAssignment."
);
@@doc(ClusterPrincipalAssignment.properties, "The cluster principal.");
@@doc(
  ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "The Kusto pool principalAssignment's parameters supplied for the operation."
);
