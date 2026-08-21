import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ServiceFabric;

/**
 * The observable state of a migration.
 */
union ClusterMigrationAgentStatus {
  string,

  /**
   * The migration is provisioned but has not started executing yet.
   */
  NotStarted: "NotStarted",

  /**
   * The migration is executing its stages.
   */
  InProgress: "InProgress",

  /**
   * All migration stages completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The migration stopped because a stage failed.
   */
  Failed: "Failed",

  /**
   * The migration is undoing the stages that already ran.
   */
  RollingBack: "RollingBack",

  /**
   * The migration finished undoing the stages that already ran.
   */
  RolledBack: "RolledBack",
}

/**
 * The direction in which the migration stages are currently executing.
 */
union ClusterMigrationAgentMode {
  string,

  /**
   * Stages are executing in roll forward order.
   */
  Forward: "Forward",

  /**
   * Stages are executing in rollback order.
   */
  RollingBack: "RollingBack",
}

/**
 * Controls how a migration transitions from NotStarted to InProgress once provisioning completes.
 */
union ClusterMigrationAgentStartMode {
  string,

  /**
   * The migration starts automatically once provisioning succeeds.
   */
  Auto: "Auto",

  /**
   * The migration stays in NotStarted until the start action is invoked.
   */
  Manual: "Manual",
}

/**
 * The execution state of a migration stage in a single direction.
 */
union ClusterMigrationAgentStageStatus {
  string,

  /**
   * The stage has not run in this direction.
   */
  None: "None",

  /**
   * The stage is currently running.
   */
  InProgress: "InProgress",

  /**
   * The stage finished running.
   */
  Completed: "Completed",
}

/**
 * The outcome of a migration stage that finished running.
 */
union ClusterMigrationAgentStageResult {
  string,

  /**
   * The stage completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The stage failed.
   */
  Failed: "Failed",
}

/**
 * Describes a node type that participates in the migration.
 */
model ClusterMigrationAgentNodeTypeDescription {
  /**
   * The name of the node type. The name cannot be changed, added, or removed after the migration is created.
   */
  @minLength(1)
  @maxLength(1024)
  name: string;

  /**
   * Indicates whether the node type hosts the system services of the cluster. This value cannot be
   * changed after the migration is created.
   */
  isPrimary: boolean;

  /**
   * The number of virtual machine instances to provision for this node type on the target managed cluster.
   */
  @minValue(1)
  vmInstanceCount: int32;
}

/**
 * Describes how a failed migration stage is retried before the migration is considered failed.
 */
model ClusterMigrationAgentRetryPolicy {
  /**
   * The maximum number of times a stage is retried before the migration fails.
   */
  @minValue(0)
  maxRetry?: int32 = 10;

  /**
   * The initial interval waited between two attempts of the same stage, in ISO 8601 duration format.
   */
  retryInterval?: duration = duration.fromISO("PT1M");

  /**
   * The upper bound applied to the retry interval as it backs off, in ISO 8601 duration format.
   */
  maxRetryInterval?: duration = duration.fromISO("PT1H");
}

/**
 * The progress of a migration stage in one direction.
 */
model ClusterMigrationAgentStageProgress {
  /**
   * The execution state of the stage in this direction.
   */
  @visibility(Lifecycle.Read)
  status: ClusterMigrationAgentStageStatus;

  /**
   * The outcome of the stage. Reported only once the stage finished running.
   */
  @visibility(Lifecycle.Read)
  result?: ClusterMigrationAgentStageResult;

  /**
   * The reason the stage failed. Reported only when the stage failed.
   */
  @visibility(Lifecycle.Read)
  failureReason?: string;

  /**
   * The time at which the stage started running, in UTC.
   */
  @visibility(Lifecycle.Read)
  startedTime?: utcDateTime;

  /**
   * The time at which the stage finished running, in UTC.
   */
  @visibility(Lifecycle.Read)
  completedTime?: utcDateTime;

  /**
   * The number of times the stage has been retried.
   */
  @visibility(Lifecycle.Read)
  retryCount?: int32;

  /**
   * The time of the most recent attempt of the stage, in UTC.
   */
  @visibility(Lifecycle.Read)
  lastAttemptTime?: utcDateTime;

  /**
   * The time at which the stage is retried next, in UTC.
   */
  @visibility(Lifecycle.Read)
  nextRetryTime?: utcDateTime;
}

/**
 * The status of a single stage of the migration plan.
 */
model ClusterMigrationAgentStage {
  /**
   * The name of the stage.
   */
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * The execution order group of the stage, starting at 1. Stages are returned in ascending order and
   * stages that share an index execute in parallel. The index is a grouping hint rather than a stable
   * identifier across service versions.
   */
  @visibility(Lifecycle.Read)
  @minValue(1)
  index: int32;

  /**
   * The progress of the roll forward execution of the stage. Not reported until the stage runs.
   */
  @visibility(Lifecycle.Read)
  forward?: ClusterMigrationAgentStageProgress;

  /**
   * The progress of the rollback execution of the stage. Not reported until the stage is rolled back.
   */
  @visibility(Lifecycle.Read)
  rollback?: ClusterMigrationAgentStageProgress;
}

/**
 * The properties of a cluster migration agent resource.
 */
model ClusterMigrationAgentProperties {
  /**
   * The service generated identifier of the migration.
   */
  @visibility(Lifecycle.Read)
  migrationId?: string;

  /**
   * The resource identifier of the classic Service Fabric cluster to migrate from. The source and the
   * target cluster must belong to the same subscription. This value cannot be changed after the
   * migration is created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceClusterResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ServiceFabric/clusters";
    }
  ]>;

  /**
   * The resource identifier of the Service Fabric managed cluster to migrate to. The source and the
   * target cluster must belong to the same subscription. This value cannot be changed after the
   * migration is created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  targetClusterResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ServiceFabric/managedClusters";
    }
  ]>;

  /**
   * The node types that are migrated to the target managed cluster. At least one node type is required.
   * Node types cannot be added or removed after the migration is created.
   */
  @identifiers(#["name"])
  @minItems(1)
  nodeTypes: ClusterMigrationAgentNodeTypeDescription[];

  /**
   * The policy applied when a migration stage fails.
   */
  retryPolicy?: ClusterMigrationAgentRetryPolicy;

  /**
   * Indicates whether the migration automatically rolls back when a stage fails.
   */
  rollbackOnFailure?: boolean = false;

  /**
   * Controls how the migration is started once provisioning completes.
   */
  startMode?: ClusterMigrationAgentStartMode = ClusterMigrationAgentStartMode.Auto;

  /**
   * The provisioning state of the cluster migration agent resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterMigrationAgentProvisioningState;

  /**
   * The current state of the migration.
   */
  @visibility(Lifecycle.Read)
  status?: ClusterMigrationAgentStatus;

  /**
   * The direction in which the migration stages are currently executing.
   */
  @visibility(Lifecycle.Read)
  migrationMode?: ClusterMigrationAgentMode;

  /**
   * The status of every stage of the migration plan, ordered from the first stage to the last.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  stages?: ClusterMigrationAgentStage[];

  /**
   * The time at which the cluster migration agent resource was created, in UTC.
   */
  @visibility(Lifecycle.Read)
  createdTime?: utcDateTime;

  /**
   * The time at which the cluster migration agent resource was last updated, in UTC.
   */
  @visibility(Lifecycle.Read)
  lastUpdatedTime?: utcDateTime;
}

/**
 * The provisioning state of the cluster migration agent resource.
 */
union ClusterMigrationAgentProvisioningState {
  string,

  /**
   * The resource is being created.
   */
  Creating: "Creating",

  /**
   * The resource is being updated.
   */
  Updating: "Updating",

  /**
   * The resource is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The resource has been provisioned successfully.
   */
  Succeeded: "Succeeded",

  /**
   * Provisioning of the resource failed.
   */
  Failed: "Failed",

  /**
   * Provisioning of the resource was canceled.
   */
  Canceled: "Canceled",
}
