import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The provisioning state of the last accepted operation.
 */
enum FleetProvisioningState {
  /**
   * Resource has been created.
   */
  Succeeded,

  /**
   * Resource creation failed.
   */
  Failed,

  /**
   * Resource creation was canceled.
   */
  Canceled,

  /**
   * The provisioning state of a fleet being created.
   */
  Creating,

  /**
   * The provisioning state of a fleet being updated.
   */
  Updating,

  /**
   * The provisioning state of a fleet being deleted.
   */
  Deleting,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * The provisioning state of the last accepted operation.
 */
enum FleetMemberProvisioningState {
  /**
   * Resource has been created.
   */
  Succeeded,

  /**
   * Resource creation failed.
   */
  Failed,

  /**
   * Resource creation was canceled.
   */
  Canceled,

  /**
   * The provisioning state of a member joining a fleet.
   */
  Joining,

  /**
   * The provisioning state of a member leaving a fleet.
   */
  Leaving,

  /**
   * The provisioning state of a member being updated.
   */
  Updating,
}

/**
 * The provisioning state of the UpdateRun resource.
 */
enum UpdateRunProvisioningState {
  /**
   * Resource has been created.
   */
  Succeeded,

  /**
   * Resource creation failed.
   */
  Failed,

  /**
   * Resource creation was canceled.
   */
  Canceled,
}

/**
 * The type of upgrade to perform when targeting ManagedClusters.
 */
enum ManagedClusterUpgradeType {
  /**
   * Full upgrades the control plane and all agent pools of the target ManagedClusters.
   */
  Full,

  /**
   * NodeImageOnly upgrades only the node images of the target ManagedClusters.
   */
  NodeImageOnly,
}

/**
 * The node image upgrade type.
 */
enum NodeImageSelectionType {
  /**
   * Use the latest image version when upgrading nodes. Clusters may use different image versions (e.g., 'AKSUbuntu-1804gen2containerd-2021.10.12' and 'AKSUbuntu-1804gen2containerd-2021.10.19') because, for example, the latest available version is different in different regions.
   */
  Latest,

  /**
   * The image versions to upgrade nodes to are selected as described below: for each node pool in managed clusters affected by the update run, the system selects the latest image version such that it is available across all other node pools (in all other clusters) of the same image type. As a result, all node pools of the same image type will be upgraded to the same image version. For example, if the latest image version for image type 'AKSUbuntu-1804gen2containerd' is 'AKSUbuntu-1804gen2containerd-2021.10.12' for a node pool in cluster A in region X, and is 'AKSUbuntu-1804gen2containerd-2021.10.17' for a node pool in cluster B in region Y, the system will upgrade both node pools to image version 'AKSUbuntu-1804gen2containerd-2021.10.12'.
   */
  Consistent,
}

/**
 * The state of the UpdateRun, UpdateStage, UpdateGroup, or MemberUpdate.
 */
enum UpdateState {
  /**
   * The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has not been started.
   */
  NotStarted,

  /**
   * The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that is running.
   */
  Running,

  /**
   * The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that is being stopped.
   */
  Stopping,

  /**
   * The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has stopped.
   */
  Stopped,

  /**
   * The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has been skipped.
   */
  Skipped,

  /**
   * The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has failed.
   */
  Failed,

  /**
   * The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has completed.
   */
  Completed,
}

/**
 * The provisioning state of the UpdateStrategy resource.
 */
enum FleetUpdateStrategyProvisioningState {
  /**
   * Resource has been created.
   */
  Succeeded,

  /**
   * Resource creation failed.
   */
  Failed,

  /**
   * Resource creation was canceled.
   */
  Canceled,
}

/**
 * Fleet properties.
 */
model FleetProperties {
  /**
   * The status of the last operation.
   */
  @visibility("read")
  provisioningState?: FleetProvisioningState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Properties of a Fleet that can be patched.
 */
model FleetPatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * Managed identity.
   */
  identity?: ManagedServiceIdentity;
}

/**
 * The Credential results response.
 */
model FleetCredentialResults {
  /**
   * Array of base64-encoded Kubernetes configuration files.
   */
  @visibility("read")
  kubeconfigs?: FleetCredentialResult[];
}

/**
 * One credential result item.
 */
model FleetCredentialResult {
  /**
   * The name of the credential.
   */
  @visibility("read")
  name?: string;

  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility("read")
  value?: bytes;
}

/**
 * A member of the Fleet. It contains a reference to an existing Kubernetes cluster on Azure.
 */
model FleetMemberProperties {
  /**
   * The ARM resource id of the cluster that joins the Fleet. Must be a valid Azure resource id. e.g.: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{clusterName}'.
   */
  @visibility("read", "create")
  clusterResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters";
    }
  ]>;

  /**
   * The group this member belongs to for multi-cluster update management.
   */
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  group?: string;

  /**
   * The status of the last operation.
   */
  @visibility("read")
  provisioningState?: FleetMemberProvisioningState;
}

/**
 * The type used for update operations of the FleetMember.
 */
model FleetMemberUpdate {
  /**
   * The updatable properties of the FleetMember.
   */
  @extension("x-ms-client-flatten", true)
  properties?: FleetMemberUpdateProperties;
}

/**
 * The updatable properties of the FleetMember.
 */
model FleetMemberUpdateProperties {
  /**
   * The group this member belongs to for multi-cluster update management.
   */
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  group?: string;
}

/**
 * The properties of the UpdateRun.
 */
model UpdateRunProperties {
  /**
   * The provisioning state of the UpdateRun resource.
   */
  @visibility("read")
  provisioningState?: UpdateRunProvisioningState;

  /**
   * The resource id of the FleetUpdateStrategy resource to reference.
   *
   * When creating a new run, there are three ways to define a strategy for the run:
   * 1. Define a new strategy in place: Set the "strategy" field.
   * 2. Use an existing strategy: Set the "updateStrategyId" field. (since 2023-08-15-preview)
   * 3. Use the default strategy to update all the members one by one: Leave both "updateStrategyId" and "strategy" unset. (since 2023-08-15-preview)
   *
   * Setting both "updateStrategyId" and "strategy" is invalid.
   *
   * UpdateRuns created by "updateStrategyId" snapshot the referenced UpdateStrategy at the time of creation and store it in the "strategy" field.
   * Subsequent changes to the referenced FleetUpdateStrategy resource do not propagate.
   * UpdateRunStrategy changes can be made directly on the "strategy" field before launching the UpdateRun.
   */
  updateStrategyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/fleets/updateStrategies";
    }
  ]>;

  /**
   * The strategy defines the order in which the clusters will be updated.
   * If not set, all members will be updated sequentially. The UpdateRun status will show a single UpdateStage and a single UpdateGroup targeting all members.
   * The strategy of the UpdateRun can be modified until the run is started.
   */
  strategy?: UpdateRunStrategy;

  /**
   * The update to be applied to all clusters in the UpdateRun. The managedClusterUpdate can be modified until the run is started.
   */
  managedClusterUpdate: ManagedClusterUpdate;

  /**
   * The status of the UpdateRun.
   */
  @visibility("read")
  status?: UpdateRunStatus;
}

/**
 * Defines the update sequence of the clusters via stages and groups.
 *
 * Stages within a run are executed sequentially one after another.
 * Groups within a stage are executed in parallel.
 * Member clusters within a group are updated sequentially one after another.
 *
 * A valid strategy contains no duplicate groups within or across stages.
 */
model UpdateRunStrategy {
  /**
   * The list of stages that compose this update run. Min size: 1.
   */
  stages: UpdateStage[];
}

/**
 * Defines a stage which contains the groups to update and the steps to take (e.g., wait for a time period) before starting the next stage.
 */
model UpdateStage {
  /**
   * The name of the stage. Must be unique within the UpdateRun.
   */
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  name: string;

  /**
   * Defines the groups to be executed in parallel in this stage. Duplicate groups are not allowed. Min size: 1.
   */
  groups?: UpdateGroup[];

  /**
   * The time in seconds to wait at the end of this stage before starting the next one. Defaults to 0 seconds if unspecified.
   */
  afterStageWaitInSeconds?: int32;
}

/**
 * A group to be updated.
 */
model UpdateGroup {
  /**
   * Name of the group.
   * It must match a group name of an existing fleet member.
   */
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  name: string;
}

/**
 * The update to be applied to the ManagedClusters.
 */
model ManagedClusterUpdate {
  /**
   * The upgrade to apply to the ManagedClusters.
   */
  upgrade: ManagedClusterUpgradeSpec;

  /**
   * The node image upgrade to be applied to the target nodes in update run.
   */
  @visibility("read", "create")
  nodeImageSelection?: NodeImageSelection;
}

/**
 * The upgrade to apply to a ManagedCluster.
 */
model ManagedClusterUpgradeSpec {
  /**
   * The upgrade type.
   * Full requires the KubernetesVersion property to be set.
   * NodeImageOnly requires the KubernetesVersion property not to be set.
   */
  type: ManagedClusterUpgradeType;

  /**
   * The Kubernetes version to upgrade the member clusters to.
   */
  kubernetesVersion?: string;
}

/**
 * The node image upgrade to be applied to the target nodes in update run.
 */
model NodeImageSelection {
  /**
   * The node image upgrade type.
   */
  @visibility("read", "create")
  type: NodeImageSelectionType;
}

/**
 * The status of a UpdateRun.
 */
model UpdateRunStatus {
  /**
   * The status of the UpdateRun.
   */
  @visibility("read")
  status?: UpdateStatus;

  /**
   * The stages composing an update run. Stages are run sequentially withing an UpdateRun.
   */
  @visibility("read")
  stages?: UpdateStageStatus[];

  /**
   * The node image upgrade specs for the update run. It is only set in update run when `NodeImageSelection.type` is `Consistent`.
   */
  @visibility("read")
  nodeImageSelection?: NodeImageSelectionStatus;
}

/**
 * The status for an operation or group of operations.
 */
model UpdateStatus {
  /**
   * The time the operation or group was started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time the operation or group was completed.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedTime?: utcDateTime;

  /**
   * The State of the operation or group.
   */
  @visibility("read")
  state?: UpdateState;

  /**
   * The error details when a failure is encountered.
   */
  @visibility("read")
  error?: ErrorDetail;
}

/**
 * The status of a UpdateStage.
 */
model UpdateStageStatus {
  /**
   * The status of the UpdateStage.
   */
  @visibility("read")
  status?: UpdateStatus;

  /**
   * The name of the UpdateStage.
   */
  @visibility("read")
  name?: string;

  /**
   * The list of groups to be updated as part of this UpdateStage.
   */
  @visibility("read")
  groups?: UpdateGroupStatus[];

  /**
   * The status of the wait period configured on the UpdateStage.
   */
  @visibility("read")
  afterStageWaitStatus?: WaitStatus;
}

/**
 * The status of a UpdateGroup.
 */
model UpdateGroupStatus {
  /**
   * The status of the UpdateGroup.
   */
  @visibility("read")
  status?: UpdateStatus;

  /**
   * The name of the UpdateGroup.
   */
  @visibility("read")
  name?: string;

  /**
   * The list of member this UpdateGroup updates.
   */
  @visibility("read")
  members?: MemberUpdateStatus[];
}

/**
 * The status of a member update operation.
 */
model MemberUpdateStatus {
  /**
   * The status of the MemberUpdate operation.
   */
  @visibility("read")
  status?: UpdateStatus;

  /**
   * The name of the FleetMember.
   */
  @visibility("read")
  name?: string;

  /**
   * The Azure resource id of the target Kubernetes cluster.
   */
  @visibility("read")
  clusterResourceId?: string;

  /**
   * The operation resource id of the latest attempt to perform the operation.
   */
  @visibility("read")
  operationId?: string;

  /**
   * The status message after processing the member update operation.
   */
  @visibility("read")
  message?: string;
}

/**
 * The status of the wait duration.
 */
model WaitStatus {
  /**
   * The status of the wait duration.
   */
  @visibility("read")
  status?: UpdateStatus;

  /**
   * The wait duration configured in seconds.
   */
  @visibility("read")
  waitDurationInSeconds?: int32;
}

/**
 * The node image upgrade specs for the update run.
 */
model NodeImageSelectionStatus {
  /**
   * The image versions to upgrade the nodes to.
   */
  @visibility("read")
  selectedNodeImageVersions?: NodeImageVersion[];
}

/**
 * The node upgrade image version.
 */
model NodeImageVersion {
  /**
   * The image version to upgrade the nodes to (e.g., 'AKSUbuntu-1804gen2containerd-2022.12.13').
   */
  @visibility("read")
  version?: string;
}

/**
 * The properties of the UpdateStrategy.
 */
model FleetUpdateStrategyProperties {
  /**
   * The provisioning state of the UpdateStrategy resource.
   */
  @visibility("read")
  provisioningState?: FleetUpdateStrategyProvisioningState;

  /**
   * Defines the update sequence of the clusters.
   */
  @visibility("read", "create", "update")
  strategy: UpdateRunStrategy;
}
