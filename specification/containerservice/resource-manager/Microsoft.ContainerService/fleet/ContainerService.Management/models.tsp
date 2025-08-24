import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum FleetProvisioningState {
  @doc("Resource has been created.") Succeeded,
  @doc("Resource creation failed.") Failed,
  @doc("Resource creation was canceled.") Canceled,
  @doc("The provisioning state of a fleet being created.") Creating,
  @doc("The provisioning state of a fleet being updated.") Updating,
  @doc("The provisioning state of a fleet being deleted.") Deleting,
}

enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum FleetMemberProvisioningState {
  @doc("Resource has been created.") Succeeded,
  @doc("Resource creation failed.") Failed,
  @doc("Resource creation was canceled.") Canceled,
  @doc("The provisioning state of a member joining a fleet.") Joining,
  @doc("The provisioning state of a member leaving a fleet.") Leaving,
  @doc("The provisioning state of a member being updated.") Updating,
}

enum UpdateRunProvisioningState {
  @doc("Resource has been created.") Succeeded,
  @doc("Resource creation failed.") Failed,
  @doc("Resource creation was canceled.") Canceled,
}

enum ManagedClusterUpgradeType {
  @doc("Full upgrades the control plane and all agent pools of the target ManagedClusters.")
  Full,
  @doc("NodeImageOnly upgrades only the node images of the target ManagedClusters.")
  NodeImageOnly,
}

enum NodeImageSelectionType {
  @doc("Use the latest image version when upgrading nodes. Clusters may use different image versions (e.g., 'AKSUbuntu-1804gen2containerd-2021.10.12' and 'AKSUbuntu-1804gen2containerd-2021.10.19') because, for example, the latest available version is different in different regions.")
  Latest,
  @doc("The image versions to upgrade nodes to are selected as described below: for each node pool in managed clusters affected by the update run, the system selects the latest image version such that it is available across all other node pools (in all other clusters) of the same image type. As a result, all node pools of the same image type will be upgraded to the same image version. For example, if the latest image version for image type 'AKSUbuntu-1804gen2containerd' is 'AKSUbuntu-1804gen2containerd-2021.10.12' for a node pool in cluster A in region X, and is 'AKSUbuntu-1804gen2containerd-2021.10.17' for a node pool in cluster B in region Y, the system will upgrade both node pools to image version 'AKSUbuntu-1804gen2containerd-2021.10.12'.")
  Consistent,
}

enum UpdateState {
  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has not been started.")
  NotStarted,
  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that is running.")
  Running,
  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that is being stopped.")
  Stopping,
  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has stopped.")
  Stopped,
  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has been skipped.")
  Skipped,
  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has failed.")
  Failed,
  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has completed.")
  Completed,
}

enum FleetUpdateStrategyProvisioningState {
  @doc("Resource has been created.") Succeeded,
  @doc("Resource creation failed.") Failed,
  @doc("Resource creation was canceled.") Canceled,
}

@doc("Fleet properties.")
model FleetProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: FleetProvisioningState;
}

@doc("User assigned identity properties")
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("The Credential results response.")
model FleetCredentialResults {
  @doc("Array of base64-encoded Kubernetes configuration files.")
  @visibility("read")
  kubeconfigs?: FleetCredentialResult[];
}

@doc("One credential result item.")
model FleetCredentialResult {
  @doc("The name of the credential.")
  @visibility("read")
  name?: string;

  @doc("Base64-encoded Kubernetes configuration file.")
  @visibility("read")
  value?: bytes;
}

@doc("A member of the Fleet. It contains a reference to an existing Kubernetes cluster on Azure.")
model FleetMemberProperties {
  @doc("The ARM resource id of the cluster that joins the Fleet. Must be a valid Azure resource id. e.g.: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{clusterName}'.")
  @visibility("read", "create")
  clusterResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters";
    }
  ]>;

  @doc("The group this member belongs to for multi-cluster update management.")
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  group?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: FleetMemberProvisioningState;
}

@doc("The properties of the UpdateRun.")
model UpdateRunProperties {
  @doc("The provisioning state of the UpdateRun resource.")
  @visibility("read")
  provisioningState?: UpdateRunProvisioningState;

  @doc("""
The resource id of the FleetUpdateStrategy resource to reference.

When creating a new run, there are three ways to define a strategy for the run:
1. Define a new strategy in place: Set the \"strategy\" field.
2. Use an existing strategy: Set the \"updateStrategyId\" field. (since 2023-08-15-preview)
3. Use the default strategy to update all the members one by one: Leave both \"updateStrategyId\" and \"strategy\" unset. (since 2023-08-15-preview)

Setting both \"updateStrategyId\" and \"strategy\" is invalid.

UpdateRuns created by \"updateStrategyId\" snapshot the referenced UpdateStrategy at the time of creation and store it in the \"strategy\" field. 
Subsequent changes to the referenced FleetUpdateStrategy resource do not propagate. 
UpdateRunStrategy changes can be made directly on the \"strategy\" field before launching the UpdateRun.
""")
  updateStrategyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/fleets/updateStrategies";
    }
  ]>;

  @doc("""
The strategy defines the order in which the clusters will be updated. 
If not set, all members will be updated sequentially. The UpdateRun status will show a single UpdateStage and a single UpdateGroup targeting all members.
The strategy of the UpdateRun can be modified until the run is started.
""")
  strategy?: UpdateRunStrategy;

  @doc("The update to be applied to all clusters in the UpdateRun. The managedClusterUpdate can be modified until the run is started.")
  managedClusterUpdate: ManagedClusterUpdate;

  @doc("The status of the UpdateRun.")
  @visibility("read")
  status?: UpdateRunStatus;
}

@doc("""
Defines the update sequence of the clusters via stages and groups.

Stages within a run are executed sequentially one after another.
Groups within a stage are executed in parallel.
Member clusters within a group are updated sequentially one after another.

A valid strategy contains no duplicate groups within or across stages.
""")
model UpdateRunStrategy {
  @doc("The list of stages that compose this update run. Min size: 1.")
  stages: UpdateStage[];
}

@doc("Defines a stage which contains the groups to update and the steps to take (e.g., wait for a time period) before starting the next stage.")
model UpdateStage {
  @doc("The name of the stage. Must be unique within the UpdateRun.")
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  name: string;

  @doc("Defines the groups to be executed in parallel in this stage. Duplicate groups are not allowed. Min size: 1.")
  groups?: UpdateGroup[];

  @doc("The time in seconds to wait at the end of this stage before starting the next one. Defaults to 0 seconds if unspecified.")
  afterStageWaitInSeconds?: int32;
}

@doc("A group to be updated.")
model UpdateGroup {
  @doc("""
Name of the group.
It must match a group name of an existing fleet member. 
""")
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  name: string;
}

@doc("The update to be applied to the ManagedClusters.")
model ManagedClusterUpdate {
  @doc("The upgrade to apply to the ManagedClusters.")
  upgrade: ManagedClusterUpgradeSpec;

  @doc("The node image upgrade to be applied to the target nodes in update run.")
  @visibility("read", "create")
  nodeImageSelection?: NodeImageSelection;
}

@doc("The upgrade to apply to a ManagedCluster.")
model ManagedClusterUpgradeSpec {
  @doc("""
The upgrade type.
Full requires the KubernetesVersion property to be set.
NodeImageOnly requires the KubernetesVersion property not to be set.
""")
  type: ManagedClusterUpgradeType;

  @doc("The Kubernetes version to upgrade the member clusters to.")
  kubernetesVersion?: string;
}

@doc("The node image upgrade to be applied to the target nodes in update run.")
model NodeImageSelection {
  @doc("The node image upgrade type.")
  @visibility("read", "create")
  type: NodeImageSelectionType;
}

@doc("The status of a UpdateRun.")
model UpdateRunStatus {
  @doc("The status of the UpdateRun.")
  @visibility("read")
  status?: UpdateStatus;

  @doc("The stages composing an update run. Stages are run sequentially withing an UpdateRun.")
  @visibility("read")
  stages?: UpdateStageStatus[];

  @doc("The node image upgrade specs for the update run. It is only set in update run when `NodeImageSelection.type` is `Consistent`.")
  @visibility("read")
  nodeImageSelection?: NodeImageSelectionStatus;
}

@doc("The status for an operation or group of operations.")
model UpdateStatus {
  @doc("The time the operation or group was started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The time the operation or group was completed.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedTime?: utcDateTime;

  @doc("The State of the operation or group.")
  @visibility("read")
  state?: UpdateState;

  @doc("The error details when a failure is encountered.")
  @visibility("read")
  error?: ErrorDetail;
}

@doc("The status of a UpdateStage.")
model UpdateStageStatus {
  @doc("The status of the UpdateStage.")
  @visibility("read")
  status?: UpdateStatus;

  @doc("The name of the UpdateStage.")
  @visibility("read")
  name?: string;

  @doc("The list of groups to be updated as part of this UpdateStage.")
  @visibility("read")
  groups?: UpdateGroupStatus[];

  @doc("The status of the wait period configured on the UpdateStage.")
  @visibility("read")
  afterStageWaitStatus?: WaitStatus;
}

@doc("The status of a UpdateGroup.")
model UpdateGroupStatus {
  @doc("The status of the UpdateGroup.")
  @visibility("read")
  status?: UpdateStatus;

  @doc("The name of the UpdateGroup.")
  @visibility("read")
  name?: string;

  @doc("The list of member this UpdateGroup updates.")
  @visibility("read")
  members?: MemberUpdateStatus[];
}

@doc("The status of a member update operation.")
model MemberUpdateStatus {
  @doc("The status of the MemberUpdate operation.")
  @visibility("read")
  status?: UpdateStatus;

  @doc("The name of the FleetMember.")
  @visibility("read")
  name?: string;

  @doc("The Azure resource id of the target Kubernetes cluster.")
  @visibility("read")
  clusterResourceId?: string;

  @doc("The operation resource id of the latest attempt to perform the operation.")
  @visibility("read")
  operationId?: string;

  @doc("The status message after processing the member update operation.")
  @visibility("read")
  message?: string;
}

@doc("The status of the wait duration.")
model WaitStatus {
  @doc("The status of the wait duration.")
  @visibility("read")
  status?: UpdateStatus;

  @doc("The wait duration configured in seconds.")
  @visibility("read")
  waitDurationInSeconds?: int32;
}

@doc("The node image upgrade specs for the update run.")
model NodeImageSelectionStatus {
  @doc("The image versions to upgrade the nodes to.")
  @visibility("read")
  selectedNodeImageVersions?: NodeImageVersion[];
}

@doc("The node upgrade image version.")
model NodeImageVersion {
  @doc("The image version to upgrade the nodes to (e.g., 'AKSUbuntu-1804gen2containerd-2022.12.13').")
  @visibility("read")
  version?: string;
}

@doc("The properties of the UpdateStrategy.")
model FleetUpdateStrategyProperties {
  @doc("The provisioning state of the UpdateStrategy resource.")
  @visibility("read")
  provisioningState?: FleetUpdateStrategyProvisioningState;

  @doc("Defines the update sequence of the clusters.")
  @visibility("read", "create", "update")
  strategy: UpdateRunStrategy;
}
