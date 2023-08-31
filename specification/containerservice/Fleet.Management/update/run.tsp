import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./../helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using OpenAPI;

namespace Microsoft.ContainerService;

@resource("updateRuns")
@parentResource(Fleet)
@doc("A multi-stage process to perform update operations across members of a Fleet.")
model UpdateRun is ProxyResource<UpdateRunProperties> {
  @doc("The name of the UpdateRun resource.")
  @key("updateRunName")
  @segment("updateRuns")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  @path
  @visibility("create", "read")
  name: string;

  ...EntityTag;
}

@doc("The provisioning state of the UpdateRun resource.")
enum UpdateRunProvisioningState {
  ...ResourceProvisioningState,
}

scalar FleetUpdateStrategyResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/fleets/updateStrategies",
    }
  ]>;

@doc("The properties of the UpdateRun.")
model UpdateRunProperties {
  @visibility("read")
  @doc("The provisioning state of the UpdateRun resource.")
  provisioningState?: UpdateRunProvisioningState;

  @doc("""
    The resource id of the FleetUpdateStrategy resource to reference.

    When creating a new run, there are three ways to define a strategy for the run:
    1. Define a new strategy in place: Set the "strategy" field.
    2. Use an existing strategy: Set the "updateStrategyId" field. (since 2023-08-15-preview)
    3. Use the default strategy to update all the members one by one: Leave both "updateStrategyId" and "strategy" unset. (since 2023-08-15-preview)

    Setting both "updateStrategyId" and "strategy" is invalid.

    UpdateRuns created by "updateStrategyId" snapshot the referenced UpdateStrategy at the time of creation and store it in the "strategy" field. 
    Subsequent changes to the referenced FleetUpdateStrategy resource do not propagate. 
    UpdateRunStrategy changes can be made directly on the "strategy" field before launching the UpdateRun.
    """)
  @added(Versions.v2023_08_15_preview)
  updateStrategyId?: FleetUpdateStrategyResourceId;

  @doc("""
The strategy defines the order in which the clusters will be updated. 
If not set, all members will be updated sequentially. The UpdateRun status will show a single UpdateStage and a single UpdateGroup targeting all members.
The strategy of the UpdateRun can be modified until the run is started.
""")
  strategy?: UpdateRunStrategy;

  @doc("The update to be applied to all clusters in the UpdateRun. The managedClusterUpdate can be modified until the run is started.")
  managedClusterUpdate: ManagedClusterUpdate;

  @visibility("read")
  @doc("The status of the UpdateRun.")
  status?: UpdateRunStatus;
}

@doc("The update to be applied to the ManagedClusters.")
model ManagedClusterUpdate {
  @doc("The upgrade to apply to the ManagedClusters.")
  upgrade: ManagedClusterUpgradeSpec;

  @visibility("create", "read")
  @doc("The node image upgrade to be applied to the target nodes in update run.")
  @added(Versions.v2023_06_15_preview)
  nodeImageSelection?: NodeImageSelection;
}

@doc("The node image upgrade to be applied to the target nodes in update run.")
@added(Versions.v2023_06_15_preview)
model NodeImageSelection {
  @visibility("create", "read")
  @doc("The node image upgrade type.")
  type: NodeImageSelectionType;
}

@doc("The node image upgrade type.")
@added(Versions.v2023_06_15_preview)
enum NodeImageSelectionType {
  @doc("Use the latest image version when upgrading nodes. Clusters may use different image versions (e.g., 'AKSUbuntu-1804gen2containerd-2021.10.12' and 'AKSUbuntu-1804gen2containerd-2021.10.19') because, for example, the latest available version is different in different regions.")
  Latest,

  @doc("The image versions to upgrade nodes to are selected as described below: for each node pool in managed clusters affected by the update run, the system selects the latest image version such that it is available across all other node pools (in all other clusters) of the same image type. As a result, all node pools of the same image type will be upgraded to the same image version. For example, if the latest image version for image type 'AKSUbuntu-1804gen2containerd' is 'AKSUbuntu-1804gen2containerd-2021.10.12' for a node pool in cluster A in region X, and is 'AKSUbuntu-1804gen2containerd-2021.10.17' for a node pool in cluster B in region Y, the system will upgrade both node pools to image version 'AKSUbuntu-1804gen2containerd-2021.10.12'.")
  Consistent,
}

scalar KubernetesVersion extends string;

@doc("The upgrade to apply to a ManagedCluster.")
model ManagedClusterUpgradeSpec {
  @doc("""
The upgrade type.
Full requires the KubernetesVersion property to be set.
NodeImageOnly requires the KubernetesVersion property not to be set.
""")
  type: ManagedClusterUpgradeType;

  @doc("The Kubernetes version to upgrade the member clusters to.")
  kubernetesVersion?: KubernetesVersion;
}

@doc("The type of upgrade to perform when targeting ManagedClusters.")
enum ManagedClusterUpgradeType {
  @doc("Full upgrades the control plane and all agent pools of the target ManagedClusters.")
  Full,

  @doc("NodeImageOnly upgrades only the node images of the target ManagedClusters.")
  NodeImageOnly,
}

@doc("The state of the UpdateRun, UpdateStage, UpdateGroup, or MemberUpdate.")
enum UpdateState {
  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has not been started.")
  NotStarted,

  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that is running.")
  Running,

  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that is being stopped.")
  Stopping,

  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has stopped.")
  Stopped,

  @added(Versions.v2023_06_15_preview)
  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has been skipped.")
  Skipped,

  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has failed.")
  Failed,

  @doc("The state of an UpdateRun/UpdateStage/UpdateGroup/MemberUpdate that has completed.")
  Completed,
}

@doc("The status for an operation or group of operations.")
model UpdateStatus {
  @visibility("read")
  @doc("The time the operation or group was started.")
  startTime?: utcDateTime;

  @visibility("read")
  @doc("The time the operation or group was completed.")
  completedTime?: utcDateTime;

  @visibility("read")
  @doc("The State of the operation or group.")
  state?: UpdateState;

  @visibility("read")
  @doc("The error details when a failure is encountered.")
  error?: Azure.ResourceManager.Foundations.ErrorDetail; // https://github.com/Azure/azure-rest-api-specs/blob/1de0b5315d62e1b40052bad2c9a2f2c89d84ff0f/specification/common-types/resource-management/v5/types.json#L260
}

@doc("The status of a UpdateRun.")
model UpdateRunStatus {
  @visibility("read")
  @doc("The status of the UpdateRun.")
  status?: UpdateStatus;

  @visibility("read")
  @extension("x-ms-identifiers", ["name"])
  @doc("The stages composing an update run. Stages are run sequentially withing an UpdateRun.")
  stages?: UpdateStageStatus[];

  @visibility("read")
  @doc("The node image upgrade specs for the update run. It is only set in update run when `NodeImageSelection.type` is `Consistent`.")
  @added(Versions.v2023_06_15_preview)
  nodeImageSelection?: NodeImageSelectionStatus;
}

@doc("The node image upgrade specs for the update run.")
@added(Versions.v2023_06_15_preview)
model NodeImageSelectionStatus {
  @extension("x-ms-identifiers", ["version"])
  @visibility("read")
  @doc("The image versions to upgrade the nodes to.")
  selectedNodeImageVersions?: NodeImageVersion[];
}

@doc("The node upgrade image version.")
@added(Versions.v2023_06_15_preview)
model NodeImageVersion {
  @visibility("read")
  @doc("The image version to upgrade the nodes to (e.g., 'AKSUbuntu-1804gen2containerd-2022.12.13').")
  version?: string;
}

@doc("The status of a UpdateStage.")
model UpdateStageStatus {
  @visibility("read")
  @doc("The status of the UpdateStage.")
  status?: UpdateStatus;

  @visibility("read")
  @doc("The name of the UpdateStage.")
  name?: string;

  @visibility("read")
  @extension("x-ms-identifiers", ["name"])
  @doc("The list of groups to be updated as part of this UpdateStage.")
  groups?: UpdateGroupStatus[];

  @visibility("read")
  @doc("The status of the wait period configured on the UpdateStage.")
  afterStageWaitStatus?: WaitStatus;
}

@doc("The status of a UpdateGroup.")
model UpdateGroupStatus {
  @visibility("read")
  @doc("The status of the UpdateGroup.")
  status?: UpdateStatus;

  @visibility("read")
  @doc("The name of the UpdateGroup.")
  name?: string;

  @visibility("read")
  @extension("x-ms-identifiers", ["name"])
  @doc("The list of member this UpdateGroup updates.")
  members?: MemberUpdateStatus[];
}

@doc("The status of the wait duration.")
model WaitStatus {
  @visibility("read")
  @doc("The status of the wait duration.")
  status?: UpdateStatus;

  @visibility("read")
  @doc("The wait duration configured in seconds.")
  waitDurationInSeconds?: int32;
}

@doc("The status of a member update operation.")
model MemberUpdateStatus {
  @visibility("read")
  @doc("The status of the MemberUpdate operation.")
  status?: UpdateStatus;

  @visibility("read")
  @doc("The name of the FleetMember.")
  name?: string;

  @visibility("read")
  @doc("The Azure resource id of the target Kubernetes cluster.")
  clusterResourceId?: string;

  @visibility("read")
  @doc("The operation resource id of the latest attempt to perform the operation.")
  operationId?: string;

  @visibility("read")
  @doc("The status message after processing the member update operation.")
  @added(Versions.v2023_06_15_preview)
  message?: string;
}

@added(Versions.v2023_03_15_preview)
@armResourceOperations
interface UpdateRuns {
  get is ArmResourceRead<UpdateRun>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    UpdateRun,
    BaseParameters<UpdateRun> &
      IfMatchParameters<UpdateRun> &
      IfNoneMatchParameters<UpdateRun>
  >;

  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  delete is FleetArmResourceDeleteAsync<
    UpdateRun,
    BaseParameters<UpdateRun> & IfMatchParameters<UpdateRun>
  >;

  listByParent is ArmResourceListByParent<UpdateRun>;

  @doc("Starts an UpdateRun.")
  start is ArmResourceNoRequestBodyActionAsync<
    UpdateRun,
    UpdateRun,
    BaseParameters<UpdateRun> & IfMatchParameters<UpdateRun>
  >;

  @doc("Stops an UpdateRun.")
  stop is ArmResourceNoRequestBodyActionAsync<
    UpdateRun,
    UpdateRun,
    BaseParameters<UpdateRun> & IfMatchParameters<UpdateRun>
  >;
}
