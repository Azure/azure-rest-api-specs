import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ServiceFabric;

/**
 * Describes an agent that migrates a classic Service Fabric cluster to a Service Fabric managed cluster.
 */
model ClusterMigrationAgent
  is Azure.ResourceManager.TrackedResource<ClusterMigrationAgentProperties> {
  ...ResourceNameParameter<
    Resource = ClusterMigrationAgent,
    KeyName = "clusterMigrationAgentName",
    SegmentName = "clusterMigrationAgents",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9-_]{0,62}[a-zA-Z0-9])?$"
  >;
}

@armResourceOperations
interface ClusterMigrationAgents {
  /**
   * Get a Service Fabric cluster migration agent resource.
   */
  get is ArmResourceRead<ClusterMigrationAgent>;

  /**
   * Create or update a Service Fabric cluster migration agent resource. The source cluster, the target
   * cluster, and the set of node types cannot be changed after the resource is created.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ClusterMigrationAgent>;

  /**
   * Update the tags of a Service Fabric cluster migration agent resource.
   */
  update is ArmTagsPatchAsync<ClusterMigrationAgent>;

  /**
   * Delete a Service Fabric cluster migration agent resource. The migration must be in the NotStarted,
   * Succeeded, or RolledBack state.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ClusterMigrationAgent>;

  /**
   * Gets all Service Fabric cluster migration agent resources in the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ClusterMigrationAgent>;

  /**
   * Gets all Service Fabric cluster migration agent resources in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<ClusterMigrationAgent>;

  /**
   * Start a migration that was created with the Manual start mode. The migration must be in the
   * NotStarted state and provisioning must have succeeded.
   */
  start is ArmResourceActionAsync<
    ClusterMigrationAgent,
    void,
    ClusterMigrationAgent,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ClusterMigrationAgent>
  >;

  /**
   * Roll back a migration, undoing the stages that already ran. The migration must be in the
   * InProgress, Failed, or RollingBack state.
   */
  rollback is ArmResourceActionAsync<
    ClusterMigrationAgent,
    void,
    ClusterMigrationAgent,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ClusterMigrationAgent>
  >;
}
