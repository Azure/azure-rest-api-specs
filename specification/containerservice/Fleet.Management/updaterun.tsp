import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./helpers.tsp";

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
@doc("An UpdateRun is a multi-stage process to perform update operations across members of a Fleet.")
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
    ...ResourceProvisioningState
}

@doc("The properties of the UpdateRun.")
model UpdateRunProperties {
    @visibility("read")
    @doc("The provisioning state of the UpdateRun resource.")
    provisioningState?: UpdateRunProvisioningState;

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

@doc("The UpdateRunStrategy configures the sequence of Stages and Groups in which the clusters will be updated.")
model UpdateRunStrategy {
  @extension("x-ms-identifiers",["name"])
  @doc("The list of stages that compose this update run.")
  stages:UpdateStage[];
}

@doc("""
Contains the groups to be updated by an UpdateRun.
Update order:
- Sequential between stages: Stages run sequentially. The previous stage must complete before the next one starts.
- Parallel within a stage: Groups within a stage run in parallel.
- Sequential within a group: Clusters within a group are updated sequentially.
""")
model UpdateStage {
    @doc("The name of the stage. Must be unique within the UpdateRun.")
    @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
    @minLength(1)
    @maxLength(50)
    name: string;

    @extension("x-ms-identifiers",["name"])
    @doc("""
A list of group names that compose the stage.
The groups will be updated in parallel. Each group name can only appear once in the UpdateRun.
""")
    groups?: UpdateGroup[];

    @doc("The time in seconds to wait at the end of this stage before starting the next one. Defaults to 0 seconds if unspecified.")
    afterStageWaitInSeconds?: int32;
}

@doc("A group to be updated.")
model UpdateGroup {
    @doc("""
The name of the Fleet member group to update. 
It should match the name of an existing FleetMember group.
A group can only appear once across all UpdateStages in the UpdateRun.
""")
    @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
    @minLength(1)
    @maxLength(50)
    name: string
}

@doc("The update to be applied to the ManagedClusters.")
model ManagedClusterUpdate {
    @doc("The upgrade to apply to the ManagedClusters.")
    upgrade: ManagedClusterUpgradeSpec;
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
enum ManagedClusterUpgradeType{
    @doc("Full upgrades the control plane and all agent pools of the target ManagedClusters.")
    Full,
    @doc("NodeImageOnly upgrades only the node images of the target ManagedClusters.")
    NodeImageOnly
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("The state of the UpdateRun, UpdateStage, UpdateGroup, or MemberUpdate.")
enum UpdateState {
    NotStarted,
    Running,
    Stopping,
    Stopped,
    Failed,
    Completed
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
    error?: Azure.ResourceManager.Foundations.ErrorDetail // https://github.com/Azure/azure-rest-api-specs/blob/1de0b5315d62e1b40052bad2c9a2f2c89d84ff0f/specification/common-types/resource-management/v5/types.json#L260
}

@doc("The status of a UpdateRun.")
model UpdateRunStatus {
    @visibility("read")
    @doc("The status of the UpdateRun.")
    status?: UpdateStatus;
    
    @visibility("read")
    @extension("x-ms-identifiers",["name"])
    @doc("The stages composing an update run. Stages are run sequentially withing an UpdateRun.")
    stages?: UpdateStageStatus[];
}

@doc("The status of a UpdateStage.")
model UpdateStageStatus {
    @visibility("read")
    @doc("The status of the UpdateStage.")
    status?: UpdateStatus;

    @visibility("read")
    @doc("The name of the UpdateStage.")
    name?:string;
    
    @visibility("read")
    @extension("x-ms-identifiers",["name"])
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
    name?:string;

    @visibility("read")
    @extension("x-ms-identifiers",["name"])
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
    name?:string;
    
    @visibility("read")
    @doc("The Azure resource id of the target Kubernetes cluster.")
    clusterResourceId?:string;

    @visibility("read")
    @doc("The operation resource id of the latest attempt to perform the operation.")
    operationId?: string;
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
      "final-state-via": "location",
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
    UpdateRun, BaseParameters<UpdateRun> & IfMatchParameters<UpdateRun>
  >;

  @doc("Stops an UpdateRun.")
  stop is ArmResourceNoRequestBodyActionAsync<
    UpdateRun,
    UpdateRun, BaseParameters<UpdateRun> & IfMatchParameters<UpdateRun>
  >;
}