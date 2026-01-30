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

alias ReplicationProtectionClusterOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the recovery services vault. */
    @path
    @segment("vaults")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    resourceName: string;

    /** Fabric name. */
    @path
    @segment("replicationFabrics")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    fabricName: string;

    /** Protection container name. */
    @path
    @segment("replicationProtectionContainers")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    protectionContainerName: string;
  },
  {
    /** Replication protection cluster name. */
    @path
    @segment("replicationProtectionClusters")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    replicationProtectionClusterName: string;
  }
>;

@armResourceOperations
interface ReplicationProtectionClusters {
  /**
   * Gets the details of an ASR replication protection cluster.
   */
  @summary("Gets the details of a Replication protection cluster.")
  get is ReplicationProtectionClusterOps.Read<ReplicationProtectionCluster>;

  /**
   * The operation to create an ASR replication protection cluster item.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create Replication protection Cluster.")
  create is ReplicationProtectionClusterOps.CreateOrUpdateAsync<
    ReplicationProtectionCluster,
    Response = ArmResourceUpdatedResponse<ReplicationProtectionCluster> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectionCluster> &
      ArmAsyncOperationHeader<FinalResult = ReplicationProtectionCluster> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * The operation to purge the replication protection cluster. This operation will force delete the replication protection cluster. Use the remove operation on replication protection cluster to perform a clean disable replication protection cluster.
   */
  @summary("Purge the replication protection cluster.")
  purge is ReplicationProtectionClusterOps.DeleteWithoutOkAsync<
    ReplicationProtectionCluster,
    Response = ArmDeleteAcceptedLroResponse<ArmLroLocationHeader &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Operation to apply a new cluster recovery point on the Protection cluster.
   */
  @summary("Execute the change recovery point operation for cluster.")
  applyRecoveryPoint is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    ApplyClusterRecoveryPointInput,
    ArmResponse<ReplicationProtectionCluster>,
    LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectionCluster> &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to initiate commit failover of the replication protection cluster.
   */
  @summary("Execute commit failover for cluster.")
  failoverCommit is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    void,
    ArmResponse<ReplicationProtectionCluster>,
    LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectionCluster> &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to repair replication protection cluster.
   */
  @summary("Resynchronize or repair replication of protection cluster.")
  repairReplication is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    void,
    ArmResponse<ReplicationProtectionCluster>,
    LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectionCluster> &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to initiate a failover of the replication protection cluster.
   */
  @summary("Execute test failover for cluster.")
  testFailover is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    ClusterTestFailoverInput,
    ArmResponse<ReplicationProtectionCluster>,
    LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectionCluster> &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to clean up the test failover of a replication protected cluster.
   */
  @summary("Execute test failover cleanup for cluster.")
  testFailoverCleanup is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    ClusterTestFailoverCleanupInput,
    ArmResponse<ReplicationProtectionCluster>,
    LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectionCluster> &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to initiate a failover of the replication protection cluster.
   */
  @summary("Execute unplanned cluster failover.")
  unplannedFailover is ReplicationProtectionClusterOps.ActionAsync<
    ReplicationProtectionCluster,
    ClusterUnplannedFailoverInput,
    ArmResponse<ReplicationProtectionCluster>,
    LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectionCluster> &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}
alias ReplicationProtectionClusterOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the recovery services vault. */
    @path
    @segment("vaults")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    resourceName: string;

    /** Fabric name. */
    @path
    @segment("replicationFabrics")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    fabricName: string;

    /** Protection container name. */
    @path
    @segment("replicationProtectionContainers")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    protectionContainerName: string;

    /** Replication protection cluster name. */
    @path
    @segment("replicationProtectionClusters")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    replicationProtectionClusterName: string;
  },
  {
    /** job id to track. */
    @path
    @segment("operationResults")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    jobId: string;
  }
>;

@armResourceOperations
interface ReplicationProtectionClusterOperationGroup {
  /**
   * Track the results of an asynchronous operation on the replication protection cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Tracks the Replication protection cluster async operation.")
  getOperationResults is ReplicationProtectionClusterOperationGroupOps.Read<ReplicationProtectionCluster>;

  /**
   * Gets the list of ASR replication protected clusters in the protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of Replication protection clusters in fabric, container.")
  listByReplicationProtectionContainers is ReplicationProtectionClusterOps.List<
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
