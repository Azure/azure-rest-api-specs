import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ReplicationProtectionCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Recovery point.
 */
@parentResource(ReplicationProtectionCluster)
model ClusterRecoveryPoint
  is Azure.ResourceManager.ProxyResource<ClusterRecoveryPointProperties> {
  ...ResourceNameParameter<
    Resource = ClusterRecoveryPoint,
    KeyName = "recoveryPointName",
    SegmentName = "recoveryPoints",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$"
  >;
}

@armResourceOperations
interface ClusterRecoveryPoints {
  /**
   * Get the details of specified recovery point.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ClusterRecoveryPoint_Get")
  get is ArmResourceRead<ClusterRecoveryPoint>;

  /**
   * The list of cluster recovery points.
   */
  listByReplicationProtectionCluster is ArmResourceListByParent<
    ClusterRecoveryPoint,
    Response = ArmResponse<ClusterRecoveryPointCollection>
  >;
}

@@doc(ClusterRecoveryPoint.name, "The recovery point name.");
@@doc(ClusterRecoveryPoint.properties, "The recovery point properties.");
