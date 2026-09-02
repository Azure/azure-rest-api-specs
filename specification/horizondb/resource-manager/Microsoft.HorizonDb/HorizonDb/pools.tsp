import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@doc("A HorizonDB pool name used before allowing one-character names.")
@pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
@minLength(1)
@maxLength(63)
scalar LegacyPoolName extends string;

@doc("A lowercase enforced name as a HorizonDB pool name.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar PoolName extends string;

@added(Versions.v2026_10_01)
@doc("A provisioned HorizonDB pool compute capacity in vCores, from 1 through 192.")
@minValue(1)
@maxValue(192)
scalar ProvisionedPoolVCores extends int32;

@added(Versions.v2026_10_01)
@doc("A serverless HorizonDB pool compute capacity in vCores, from 0.5 through 192.")
@minValue(0.5)
@maxValue(192)
scalar ServerlessPoolVCores extends float32;

@added(Versions.v2026_10_01)
@doc("A HorizonDB pool node count, from 0 through 16.")
@minValue(0)
@maxValue(16)
scalar PoolNodeCount extends int32;

@renamedFrom(Versions.v2026_10_01, "HorizonDbPool")
@doc("Represents the HorizonDB pool.")
@parentResource(Cluster)
model Pool is Azure.ResourceManager.ProxyResource<PoolProperties> {
  @doc("The name of the HorizonDB pool.")
  @key("poolName")
  @path
  @segment("pools")
  @typeChangedFrom(Versions.v2026_10_01, LegacyPoolName)
  name: PoolName;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags are valid in v2026-01-20-preview and removed in v2026-10-01"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<string> is acceptable for tags in this version"
  @removed(Versions.v2026_10_01)
  @doc("Resource tags.")
  tags?: Record<string>;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPoolProperties")
@doc("Properties of a HorizonDB pool.")
model PoolProperties {
  @removed(Versions.v2026_10_01)
  @doc("The location of the HorizonDB pool.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: azureLocation;

  @typeChangedFrom(Versions.v2026_10_01, State)
  @doc("Current state of the pool.")
  @visibility(Lifecycle.Read)
  state?: PoolState;

  @removed(Versions.v2026_10_01)
  @doc("Number of replicas in the pool.")
  @visibility(Lifecycle.Read)
  replicaCount?: int32;

  @removed(Versions.v2026_10_01)
  @doc("The version of the HorizonDB pool.")
  @visibility(Lifecycle.Read)
  version?: string;

  @removed(Versions.v2026_10_01)
  @doc("The create mode for the pool.")
  @visibility(Lifecycle.Read)
  createMode?: CreateModePool;

  @added(Versions.v2026_10_01)
  @doc("The compute model for the HorizonDB pool.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeModel?: PoolComputeModel;

  @added(Versions.v2026_10_01)
  @doc("The desired number of nodes to allocate and assign to the pool. Allowed values are 0 through 16. A value of 0 keeps the pool resource and its name, compute configuration, maintenance configuration, and parameter-group association, but allocates no nodes; it does not delete the pool. A request that would leave a pool hosting the read-write node with an effective desiredNodeCount of 0 is rejected without changing the pool.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  desiredNodeCount?: PoolNodeCount;

  @added(Versions.v2026_10_01)
  @doc("The number of nodes currently allocated and assigned to the pool, regardless of their operational state or the operational state of the pool.")
  @visibility(Lifecycle.Read)
  allocatedNodeCount: PoolNodeCount;

  @added(Versions.v2026_10_01)
  @doc("The required default or custom parameter group associated with the pool.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  parameterGroup: PoolParameterGroupReference;

  @added(Versions.v2026_10_01)
  @doc("The scheduled maintenance configuration for the pool. When maintenanceManagementType is User, dayOfWeek, startHourUtc, and startMinuteUtc are required. Those schedule properties must be absent when maintenanceManagementType is System.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  scheduledMaintenance?: ScheduledMaintenanceProperties;

  @doc("The provisioning state of the pool.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPoolPropertiesForPatchUpdate")
@doc("Properties of a HorizonDB pool for update operations.")
model PoolPropertiesForPatchUpdate {
  @added(Versions.v2026_10_01)
  @doc("The compute model properties to update. Omitted properties preserve their current values. To change the compute model type between Provisioned and Serverless, supply the complete target compute model, including type, computeProcessor, computeGeneration, and all properties required by the target type.")
  @visibility(Lifecycle.Update)
  computeModel?: PoolComputeModelForPatchUpdate;

  @added(Versions.v2026_10_01)
  @doc("The desired number of nodes to allocate and assign to the pool. Allowed values are 0 through 16. A value of 0 keeps the pool resource and its configuration but allocates no nodes; it does not delete the pool. Omission preserves the current target. A request that would leave a pool hosting the read-write node with an effective desiredNodeCount of 0 is rejected without changing the pool.")
  @visibility(Lifecycle.Update)
  desiredNodeCount?: PoolNodeCount;

  @added(Versions.v2026_10_01)
  @doc("The default or custom parameter group to associate with the pool. Omission preserves the current association.")
  @visibility(Lifecycle.Update)
  parameterGroup?: PoolParameterGroupReferenceForPatchUpdate;

  @added(Versions.v2026_10_01)
  @doc("The scheduled maintenance configuration to update for the pool. When supplied, the complete System or User configuration is required. Omission preserves the current configuration.")
  @visibility(Lifecycle.Update)
  scheduledMaintenance?: ScheduledMaintenanceProperties;
}

@added(Versions.v2026_10_01)
@doc("A reference to the default or custom parameter group associated with a HorizonDB pool.")
model PoolParameterGroupReference {
  @added(Versions.v2026_10_01)
  @doc("The Azure resource ID of the default or custom parameter group.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  parameterGroupResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/parameterGroups";
    },
    {
      type: "Microsoft.HorizonDb/locations/parameterGroups";
    }
  ]>;

  @added(Versions.v2026_10_01)
  @doc("Determines when dynamic parameter changes from the associated parameter group become effective. Static parameter changes always require a pool restart, regardless of this value.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  applyMethod: ParameterApplyMethod;

  @added(Versions.v2026_10_01)
  @doc("The synchronization status between the pool and its parameter group.")
  @visibility(Lifecycle.Read)
  syncStatus?: ParameterGroupSyncStatus;
}

@added(Versions.v2026_10_01)
@doc("A parameter group reference for updating a HorizonDB pool.")
model PoolParameterGroupReferenceForPatchUpdate {
  @added(Versions.v2026_10_01)
  @doc("The Azure resource ID of the default or custom parameter group to associate with the pool.")
  @visibility(Lifecycle.Update)
  parameterGroupResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/parameterGroups";
    },
    {
      type: "Microsoft.HorizonDb/locations/parameterGroups";
    }
  ]>;

  @added(Versions.v2026_10_01)
  @doc("Determines when dynamic parameter changes from the associated parameter group become effective. Static parameter changes always require a pool restart, regardless of this value.")
  @visibility(Lifecycle.Update)
  applyMethod: ParameterApplyMethod;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPoolForPatchUpdate")
@doc("HorizonDB pool for update operations.")
model PoolForPatchUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<string> is acceptable for tags in this version"
  @removed(Versions.v2026_10_01)
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The properties that can be updated for a HorizonDB pool.")
  properties?: PoolPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("The compute model for a HorizonDB pool.")
@discriminator("type")
model PoolComputeModel {
  @doc("The type of compute model.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  type: PoolComputeModelType;

  @doc("The processor type for the compute model.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeProcessor?: ComputeProcessorType;

  @doc("The compute generation for the compute model.")
  @minValue(1)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeGeneration?: int32;
}

@added(Versions.v2026_10_01)
@doc("A provisioned compute model for a HorizonDB pool.")
model ProvisionedHorizonDbPoolComputeModel extends PoolComputeModel {
  @doc("The type of compute model.")
  type: "Provisioned";

  @doc("The number of provisioned vCores. Allowed values are 1 through 192.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  vCores: ProvisionedPoolVCores;
}

@added(Versions.v2026_10_01)
@doc("A serverless compute model for a HorizonDB pool. minVCores must be less than or equal to maxVCores.")
model ServerlessHorizonDbPoolComputeModel extends PoolComputeModel {
  @doc("The type of compute model.")
  type: "Serverless";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "minVCores preserves the existing vCores contract term in the serverless compute model."
  @doc("The minimum number of vCores. Allowed values are 0.5 through 192. The service validates that this value is less than or equal to maxVCores.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  minVCores: ServerlessPoolVCores;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "maxVCores preserves the existing vCores contract term in the serverless compute model."
  @doc("The maximum number of vCores. Allowed values are 0.5 through 192. The service validates that this value is greater than or equal to minVCores.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  maxVCores: ServerlessPoolVCores;
}

@added(Versions.v2026_10_01)
@doc("The compute model properties of a HorizonDB pool that can be updated. The object is recursively mergeable: omitted properties preserve their current values. Properties that do not apply to the current or target compute model type are rejected. When type changes, the request must include the complete target compute model. For an effective Serverless model, the merged minVCores value must be less than or equal to the merged maxVCores value; invalid requests are rejected without changing the resource.")
model PoolComputeModelForPatchUpdate {
  @doc("The compute model type. Omit this property to retain the current type. Resubmitting the current type succeeds as an idempotent no-op. To change the type, supply all common properties and all properties required by the target type.")
  @visibility(Lifecycle.Update)
  type?: PoolComputeModelType;

  @doc("The processor type for the compute model. Omission preserves the current processor type.")
  @visibility(Lifecycle.Update)
  computeProcessor?: ComputeProcessorType;

  @doc("The compute generation for the compute model. Omission preserves the current compute generation.")
  @minValue(1)
  @visibility(Lifecycle.Update)
  computeGeneration?: int32;

  @doc("The number of provisioned vCores. Allowed values are 1 through 192. This property applies only to a Provisioned compute model. Omission preserves the current value.")
  @visibility(Lifecycle.Update)
  vCores?: ProvisionedPoolVCores;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "minVCores preserves the existing vCores contract term in the serverless compute model."
  @doc("The minimum number of vCores. Allowed values are 0.5 through 192. This property applies only to a Serverless compute model. Omission preserves the current value. The service validates that the effective value after merging is less than or equal to the effective maxVCores.")
  @visibility(Lifecycle.Update)
  minVCores?: ServerlessPoolVCores;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "maxVCores preserves the existing vCores contract term in the serverless compute model."
  @doc("The maximum number of vCores. Allowed values are 0.5 through 192. This property applies only to a Serverless compute model. Omission preserves the current value. The service validates that the effective value after merging is greater than or equal to the effective minVCores.")
  @visibility(Lifecycle.Update)
  maxVCores?: ServerlessPoolVCores;
}

@doc("The mode to create a new HorizonDB cluster.")
union CreateModePool {
  string,

  /** Create a new pool */
  Create: "Create",

  /** Update an existing pool */
  Update: "Update",
}

@added(Versions.v2026_10_01)
@doc("Current state of a HorizonDB pool.")
union PoolState {
  string,

  /** Is ready and operational */
  Ready: "Ready",

  /** Is provisioning */
  Provisioning: "Provisioning",

  /** Is being deleted */
  Deleting: "Deleting",

  /** Is inaccessible */
  Inaccessible: "Inaccessible",

  /** Is being updated */
  Updating: "Updating",

  /** Is starting up */
  Starting: "Starting",

  /** Is stopping */
  Stopping: "Stopping",

  /** Is stopped */
  Stopped: "Stopped",

  /** Is restarting */
  Restarting: "Restarting",

  /** Is shutting down */
  ShuttingDown: "ShuttingDown",

  /** Is shut down */
  Shutdown: "Shutdown",
}

@added(Versions.v2026_10_01)
@doc("The compute processor type.")
union ComputeProcessorType {
  string,

  /** Intel processor */
  Intel: "Intel",

  /** AMD processor */
  AMD: "AMD",
}

@added(Versions.v2026_10_01)
@doc("The compute model type.")
union PoolComputeModelType {
  string,

  /** Provisioned compute model */
  Provisioned: "Provisioned",

  /** Serverless compute model */
  Serverless: "Serverless",
}

@added(Versions.v2026_10_01)
@doc("The Azure resource ID of a HorizonDB pool.")
scalar PoolResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters/pools",
    }
  ]>;

@added(Versions.v2026_10_01)
@doc("Long-running operation headers returned when asynchronous HorizonDB pool creation is accepted.")
model PoolCreateLroHeaders {
  @doc("A link to the status monitor for the pool creation operation.")
  @header("Azure-AsyncOperation")
  azureAsyncOperation?: string;

  ...Azure.Core.Foundations.RetryAfterHeader;
}

@added(Versions.v2026_10_01)
@doc("The response returned when asynchronous HorizonDB pool creation is accepted.")
model PoolCreateAcceptedResponse {
  ...CreatedResponse;
  ...PoolCreateLroHeaders;

  @doc("The HorizonDB pool with a non-terminal provisioning state.")
  @bodyRoot
  body: Pool;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPools")
@armResourceOperations
interface Pools {
  @doc("Gets information about a HorizonDB pool.")
  get is ArmResourceRead<Pool>;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The AutoRest emitter infers final-state-via from polling metadata. Marking this standard ARM PUT as an LRO without polling decorators emits x-ms-long-running-operation while intentionally omitting x-ms-long-running-operation-options."
  @added(Versions.v2026_10_01)
  @doc("Creates a new HorizonDB pool or updates an existing pool, including its desired node allocation, compute model, or associated parameter group. A pool name can be the same as its parent cluster name. Creating a pool also creates exactly one service-managed Pool-scoped ReadOnly Endpoint representing that Pool and its network boundary. The Endpoint's associatedResourceId identifies the Pool, and the Endpoint cannot outlive or be deleted independently from it. When the first pool is created, the service automatically uses it to host the cluster's read-write node when an eligible node is available. This API version supports at most one pool per cluster; an attempt to create another pool is rejected with 409 Conflict. Every pool must be associated with a parameter group, so parameterGroup, parameterGroupResourceId, and applyMethod are required. applyMethod controls when dynamic parameter changes become effective; static parameter changes always require a customer-triggered restart or a restart during scheduled maintenance. For a Serverless compute model, the service validates that minVCores is less than or equal to maxVCores. A request that would leave the pool hosting the read-write node with an effective desiredNodeCount of 0 is rejected without changing the pool.")
  @sharedRoute
  @Azure.ClientGenerator.Core.Legacy.markAsLro
  @autoRoute
  @armResourceCreateOrUpdate(Pool)
  @put
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<Pool>,
    Pool,
    ArmResourceUpdatedResponse<Pool> | PoolCreateAcceptedResponse,
    ErrorResponse
  >;

  @added(Versions.v2026_10_01)
  @doc("Updates an existing HorizonDB pool, including its desired node allocation, selected compute model properties, the compute model type, or its associated parameter group. When parameterGroup is supplied, both parameterGroupResourceId and applyMethod are required. applyMethod controls when dynamic parameter changes become effective; static parameter changes always require a customer-triggered restart or a restart during scheduled maintenance. For an effective Serverless compute model, the service validates that the recursively merged minVCores value is less than or equal to the recursively merged maxVCores value. A request that would leave the pool hosting the read-write node with an effective desiredNodeCount of 0 is rejected without changing the pool.")
  update is ArmCustomPatchAsync<Pool, PoolForPatchUpdate>;

  @added(Versions.v2026_10_01)
  @doc("Deletes a HorizonDB pool together with the Pool-scoped Endpoint whose associatedResourceId identifies that Pool and all FirewallRule children of that Endpoint. The Endpoint cannot outlive or be deleted independently from its Pool.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Pool,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB pools in a cluster.")
  list is ArmResourceListByParent<Pool>;

  @added(Versions.v2026_10_01)
  @doc("Starts a stopped or shut down HorizonDB pool. Power operations are supported only at pool scope in this API version; there is no cluster-level start action. When the pool transitions from Stopped or Shutdown to Ready, completion applies pending dynamic and static parameter changes. When the pool is already Ready, the operation succeeds as a true idempotent no-op and leaves pending parameter changes pending. The operation is allowed when allocatedNodeCount is 0. After the Pool is running, its Pool-scoped ReadOnly Endpoint routes only when at least one allocated node is not currently playing the read-write role. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
  @action("start")
  start is ArmResourceActionAsyncBase<
    Pool,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Pool>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;

  @added(Versions.v2026_10_01)
  @doc("Stops a running HorizonDB pool without deallocating compute. Power operations are supported only at pool scope in this API version; there is no cluster-level stop action. The operation succeeds as an idempotent no-op when the pool is already Stopped. It is allowed when allocatedNodeCount is 0. The Pool-scoped ReadOnly Endpoint remains discoverable but has no routing destination while the Pool is Stopped. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
  @action("stop")
  stop is ArmResourceActionAsyncBase<
    Pool,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Pool>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;

  @added(Versions.v2026_10_01)
  @doc("Shuts down a running or stopped HorizonDB pool and deallocates compute. Power operations are supported only at pool scope in this API version; there is no cluster-level shutdown action. The operation succeeds as an idempotent no-op when the pool is already Shutdown. It is allowed when allocatedNodeCount is 0. The Pool-scoped ReadOnly Endpoint remains discoverable but has no routing destination while the Pool is Shutdown. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
  @action("shutdown")
  shutdown is ArmResourceActionAsyncBase<
    Pool,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Pool>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;

  @added(Versions.v2026_10_01)
  @doc("Restarts the PostgreSQL container on all allocated nodes in a ready HorizonDB pool and applies pending dynamic and static parameter changes. Power operations are supported only at pool scope in this API version; there is no cluster-level restart action. When allocatedNodeCount is 0, the operation succeeds without restarting any nodes, pending changes are considered applied, parameterGroup.syncStatus becomes InSync, and the resulting configuration applies to nodes allocated later. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
  @action("restart")
  restart is ArmResourceActionAsyncBase<
    Pool,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Pool>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;
}
