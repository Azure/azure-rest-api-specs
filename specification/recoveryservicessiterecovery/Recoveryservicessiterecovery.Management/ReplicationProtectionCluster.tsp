import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectionContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Replication protection Cluster.
 */
@parentResource(ProtectionContainer)
model ReplicationProtectionCluster
  is Azure.ResourceManager.ProxyResource<ReplicationProtectionClusterProperties> {
  ...ResourceNameParameter<
    Resource = ReplicationProtectionCluster,
    KeyName = "replicationProtectionClusterName",
    SegmentName = "replicationProtectionClusters",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$"
  >;
}

@armResourceOperations
interface ReplicationProtectionClusterOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") resourceName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = Fabric,
          KeyName = "fabricName",
          SegmentName = "replicationFabrics",
          NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ProtectionContainer,
          KeyName = "protectionContainerName",
          SegmentName = "replicationProtectionContainers",
          NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ReplicationProtectionCluster,
        KeyName = "replicationProtectionClusterName",
        SegmentName = "replicationProtectionClusters",
        NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$"
      >>
    > {}

@armResourceOperations
interface ReplicationProtectionClusters {
  /**
   * Gets the details of an ASR replication protection cluster.
   */
  get is ReplicationProtectionClusterOps.Read<ReplicationProtectionCluster>;

  /**
   * The operation to create an ASR replication protection cluster item.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ReplicationProtectionClusterOps.CreateOrUpdateAsync<
    ReplicationProtectionCluster,
    Response = ArmResourceUpdatedResponse<ReplicationProtectionCluster> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to purge the replication protection cluster. This operation will force delete the replication protection cluster. Use the remove operation on replication protection cluster to perform a clean disable replication protection cluster.
   */
  purge is ReplicationProtectionClusterOps.DeleteWithoutOkAsync<ReplicationProtectionCluster>;

  /**
   * Operation to apply a new cluster recovery point on the Protection cluster.
   */
  applyRecoveryPoint is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    ApplyClusterRecoveryPointInput,
    ArmResponse<ReplicationProtectionCluster>
  >;

  /**
   * Operation to initiate commit failover of the replication protection cluster.
   */
  failoverCommit is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    void,
    ArmResponse<ReplicationProtectionCluster>
  >;

  /**
   * The operation to repair replication protection cluster.
   */
  repairReplication is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    void,
    ArmResponse<ReplicationProtectionCluster>
  >;

  /**
   * Operation to initiate a failover of the replication protection cluster.
   */
  testFailover is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    ClusterTestFailoverInput,
    ArmResponse<ReplicationProtectionCluster>
  >;

  /**
   * Operation to clean up the test failover of a replication protected cluster.
   */
  testFailoverCleanup is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    ClusterTestFailoverCleanupInput,
    ArmResponse<ReplicationProtectionCluster>
  >;

  /**
   * Operation to initiate a failover of the replication protection cluster.
   */
  unplannedFailover is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    ClusterUnplannedFailoverInput,
    ArmResponse<ReplicationProtectionCluster>
  >;
}
@armResourceOperations
interface ReplicationProtectionClusterOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") resourceName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = Fabric,
          KeyName = "fabricName",
          SegmentName = "replicationFabrics",
          NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ProtectionContainer,
          KeyName = "protectionContainerName",
          SegmentName = "replicationProtectionContainers",
          NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ReplicationProtectionCluster,
          KeyName = "replicationProtectionClusterName",
          SegmentName = "replicationProtectionClusters",
          NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ReplicationProtectionCluster,
        KeyName = "jobId",
        SegmentName = "operationResults",
        NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$"
      >>
    > {}

@armResourceOperations
interface ReplicationProtectionClusterOperationGroup {
  /**
   * Track the results of an asynchronous operation on the replication protection cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectionClusters_GetOperationResults")
  getOperationResults is ReplicationProtectionClusterOperationGroupOps.Read<ReplicationProtectionCluster>;

  /**
   * Gets the list of ASR replication protected clusters in the protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectionClusters_ListByReplicationProtectionContainers")
  listByReplicationProtectionContainers is ReplicationProtectionClusterOperationGroupOps.List<
    ReplicationProtectionCluster,
    Response = ArmResponse<ReplicationProtectionClusterCollection>
  >;
}

@@doc(ReplicationProtectionCluster.name,
  "Replication protection cluster name."
);
@@doc(ReplicationProtectionCluster.properties, "The custom data.");
@@doc(ReplicationProtectionClusters.create::parameters.resource,
  "Create replication protection cluster Input."
);
@@doc(ReplicationProtectionClusters.applyRecoveryPoint::parameters.body,
  "Apply recovery point input."
);
@@doc(ReplicationProtectionClusters.testFailover::parameters.body,
  "Cluster test failover input body."
);
@@doc(ReplicationProtectionClusters.testFailoverCleanup::parameters.body,
  "Test failover cleanup input."
);
@@doc(ReplicationProtectionClusters.unplannedFailover::parameters.body,
  "Failover input."
);
