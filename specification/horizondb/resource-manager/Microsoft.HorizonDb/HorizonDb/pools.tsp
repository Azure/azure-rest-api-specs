import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@doc("A lowercase enforced name as a HorizonDB pool name. The name must differ from the name of the parent cluster because endpoint names are derived from cluster and pool names.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar PoolName extends string;

@doc("A provisioned HorizonDB pool compute capacity in vCores, from 1 through 192.")
@minValue(1)
@maxValue(192)
scalar PoolVCores extends int32;

@doc("A HorizonDB pool node count, from 1 through 16.")
@minValue(1)
@maxValue(16)
scalar PoolNodeCount extends int32;

@doc("Represents the HorizonDB pool.")
@parentResource(Cluster)
model Pool is Azure.ResourceManager.ProxyResource<PoolProperties> {
  @doc("The name of the HorizonDB pool.")
  @key("poolName")
  @path
  @segment("pools")
  name: PoolName;
}

@doc("The response returned when asynchronous HorizonDB pool creation is accepted.")
model PoolCreateAcceptedResponse {
  ...CreatedResponse;
  ...HorizonDbResourceLroHeaders<Pool>;

  @doc("The HorizonDB pool with a non-terminal provisioning state.")
  @bodyRoot
  body: Pool;
}

@doc("Properties of a HorizonDB pool.")
model PoolProperties {
  @doc("Current state of the pool.")
  @visibility(Lifecycle.Read)
  state?: PoolState;

  @doc("The required compute model for the HorizonDB pool.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeModel: PoolComputeModel;

  @doc("The required number of nodes to allocate and assign to the pool. Allowed values are 1 through 16. To deallocate runtime compute without changing the configured node count, stop the pool.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  nodeCount: PoolNodeCount;

  @doc("The required high-availability configuration for the pool. mode must be Disabled when nodeCount is 1, and must be AnyZone or ZoneRedundant when nodeCount is 2 through 16.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  highAvailability: PoolHighAvailability;

  @doc("The required parameter group associated with the pool. When creating a new pool in this API version, the caller must supply the corresponding default parameter group; customer-created parameter groups are not accepted during creation. For an existing pool, PUT or PATCH can associate either the corresponding default parameter group or a customer-created parameter group. The create-visible shape intentionally supports both resource ID forms so a future API version can allow customer-created parameter groups during creation without a breaking schema change.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  parameterGroup: PoolParameterGroupReference;

  @doc("The scheduled maintenance configuration for the pool. The properties available depend on the selected maintenance management type.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  scheduledMaintenance?: ScheduledMaintenanceProperties;

  @doc("The provisioning state of the pool.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of a HorizonDB pool for update operations.")
model PoolPropertiesForPatchUpdate {
  @doc("The compute model properties to update. Omitted properties preserve their current values. To change the compute model type, supply the complete target compute model, including type, computeProcessor, computeGeneration, and all properties required by the target type.")
  @visibility(Lifecycle.Update)
  computeModel?: PoolComputeModelForPatchUpdate;

  @doc("The number of nodes to allocate and assign to the pool. Allowed values are 1 through 16. Omission preserves the current configured value. To deallocate runtime compute without changing the configured node count, stop the pool.")
  @visibility(Lifecycle.Update)
  nodeCount?: PoolNodeCount;

  @doc("The high-availability configuration to update. Omission preserves the current mode. The service recursively merges omitted PATCH properties with the existing resource before validating the effective nodeCount and mode together.")
  @visibility(Lifecycle.Update)
  highAvailability?: PoolHighAvailabilityPatch;

  @doc("The corresponding default or a customer-created parameter group to associate with the existing pool. Customers can switch in either direction between these group types. Omission preserves the current association.")
  @visibility(Lifecycle.Update)
  parameterGroup?: PoolParameterGroupReferenceForPatchUpdate;

  @doc("The scheduled maintenance configuration to update for the pool. When supplied, the complete configuration for the selected maintenance management type is required. Omission preserves the current configuration.")
  @visibility(Lifecycle.Update)
  scheduledMaintenance?: ScheduledMaintenancePropertiesForPatchUpdate;
}

@doc("The high-availability configuration for a HorizonDB pool.")
model PoolHighAvailability {
  @doc("The high-availability mode. Disabled is required when nodeCount is 1. AnyZone or ZoneRedundant is required when nodeCount is 2 through 16.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  mode: PoolHighAvailabilityMode;
}

@doc("The high-availability configuration for a HorizonDB pool update.")
model PoolHighAvailabilityPatch {
  @doc("The high-availability mode. Omission preserves the current mode before the service validates it with the effective nodeCount.")
  @visibility(Lifecycle.Update)
  mode?: PoolHighAvailabilityMode;
}

@doc("The high-availability mode requested for a HorizonDB pool.")
union PoolHighAvailabilityMode {
  string,

  @doc("High availability is disabled. This mode is valid only when nodeCount is 1.")
  Disabled: "Disabled",

  @doc("The service may allocate nodes in the same availability zone or across availability zones. This mode is valid only when nodeCount is 2 through 16.")
  AnyZone: "AnyZone",

  @doc("The service must allocate nodes across availability zones. This mode is valid only when nodeCount is 2 through 16.")
  ZoneRedundant: "ZoneRedundant",
}

@doc("A reference to the parameter group associated with a HorizonDB pool. The schema represents both default and customer-created parameter groups for create and update compatibility. In this API version, initial pool creation accepts only the corresponding default parameter group; PUT updates to an existing pool can associate either group type.")
model PoolParameterGroupReference {
  @doc("The Azure resource ID of the associated parameter group. Initial pool creation in this API version requires the corresponding Microsoft.HorizonDb/locations/parameterGroups resource. For an existing pool, PUT can specify either the corresponding default group or a customer-created Microsoft.HorizonDb/parameterGroups resource.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  parameterGroupResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/parameterGroups";
    },
    {
      type: "Microsoft.HorizonDb/locations/parameterGroups";
    }
  ]>;

  @doc("Determines when dynamic parameter changes from the associated parameter group become effective. Static parameter changes always require a customer-initiated pool Restart, regardless of this value. Stop followed by Start and scheduled maintenance do not apply pending parameter changes.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  applyMethod: ParameterApplyMethod;

  @doc("The synchronization status between the pool and its parameter group. PendingReboot changes remain pending across Stop, Start, and scheduled maintenance and become effective only after a customer-initiated Restart.")
  @visibility(Lifecycle.Read)
  syncStatus?: ParameterGroupSyncStatus;
}

@doc("A parameter group reference for updating an existing HorizonDB pool. The pool can switch in either direction between its corresponding default parameter group and a customer-created parameter group.")
model PoolParameterGroupReferenceForPatchUpdate {
  @doc("The Azure resource ID of the corresponding default or customer-created parameter group to associate with the existing pool.")
  @visibility(Lifecycle.Update)
  parameterGroupResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/parameterGroups";
    },
    {
      type: "Microsoft.HorizonDb/locations/parameterGroups";
    }
  ]>;

  @doc("Determines when dynamic parameter changes from the associated parameter group become effective. Static parameter changes always require a customer-initiated pool Restart, regardless of this value. Stop followed by Start and scheduled maintenance do not apply pending parameter changes.")
  @visibility(Lifecycle.Update)
  applyMethod?: ParameterApplyMethod;
}

@doc("HorizonDB pool for update operations.")
model PoolForPatchUpdate {
  @doc("The properties that can be updated for a HorizonDB pool.")
  properties?: PoolPropertiesForPatchUpdate;
}

@doc("The compute model for a HorizonDB pool.")
model PoolComputeModel {
  @doc("The type of compute model.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  type: PoolComputeModelType;

  @doc("The processor type for the compute model.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeProcessor: ComputeProcessorType;

  @doc("The compute generation for the compute model.")
  @minValue(1)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeGeneration: int32;

  @doc("The number of vCores. Allowed values are 1 through 192.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  vCores: PoolVCores;
}

@doc("The compute model properties of a HorizonDB pool that can be updated. The object is recursively mergeable: omitted properties preserve their current values. Properties that do not apply to the current or target compute model type are rejected. When type changes, the request must include the complete target compute model. Subtype-specific constraints are validated against the effective merged configuration; invalid requests are rejected without changing the resource.")
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
  vCores?: PoolVCores;
}

@doc("The compute model type.")
union PoolComputeModelType {
  string,

  /** Provisioned compute model */
  Provisioned: "Provisioned",
}

@doc("The compute processor type.")
union ComputeProcessorType {
  string,

  /** Intel processor */
  Intel: "Intel",

  /** AMD processor */
  AMD: "AMD",
}

@doc("The mode to create a new HorizonDB cluster.")
union CreateModePool {
  string,

  /** Create a new pool */
  Create: "Create",

  /** Update an existing pool */
  Update: "Update",
}

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

  /** Is restarting */
  Restarting: "Restarting",

  /** Is stopping */
  Stopping: "Stopping",

  /** Is stopped */
  Stopped: "Stopped",
}

@doc("The zone redundancy option for the cluster.")
union ZonePlacementEnforcement {
  string,

  /** Enforce zonal redundancy */
  Strict: "Strict",

  /** Best-effort placement (default) */
  BestEffort: "BestEffort",
}

@armResourceOperations
interface Pools {
  @doc("Gets information about a HorizonDB pool.")
  get is ArmResourceRead<Pool>;

  @doc("Creates a new HorizonDB pool or replaces an existing pool, including its node allocation, compute model, high-availability configuration, or associated parameter group. nodeCount and highAvailability.mode are required and have no service defaults. nodeCount must be 1 through 16. Disabled is valid only when nodeCount is 1. AnyZone and ZoneRedundant are valid only when nodeCount is 2 through 16. AnyZone permits same-zone or cross-zone placement, while ZoneRedundant requires nodes to be allocated across availability zones. Node allocation and high-availability reconfiguration are atomic: if all requested nodes or the required zonal topology cannot be provisioned, the long-running operation fails and the previous resource state is preserved. A pool name must differ from its parent cluster name because the Cluster-scoped ReadWrite Endpoint is named after the Cluster and the Pool-scoped ReadOnly Endpoint is named after the Pool; the service rejects a request whose names would collide. Creating a pool also creates exactly one service-managed Pool-scoped ReadOnly Endpoint representing that Pool and its network boundary. The Endpoint's associatedResourceId identifies the Pool, and the Endpoint cannot outlive or be deleted independently from it. When the first pool is created, the service automatically designates it to host the cluster's read-write node when an eligible node is available. A Cluster must contain at least one Pool before a private endpoint connection can be created or approved. This API version supports at most one pool per cluster; an attempt to create another pool is rejected with 409 Conflict. parameterGroup, parameterGroupResourceId, and applyMethod are required. When creating a new pool in this API version, parameterGroupResourceId must identify the corresponding default parameter group; a customer-created parameter group is rejected. When replacing an existing pool, the request can switch its association in either direction between the corresponding default parameter group and a customer-created parameter group. applyMethod controls when dynamic parameter changes become effective. Static parameter changes always require a customer-initiated Restart; Stop followed by Start and scheduled maintenance do not apply pending changes. Subtype-specific compute constraints are validated before the resource is changed.")
  @sharedRoute
  @autoRoute
  @armResourceCreateOrUpdate(Pool)
  @put
  createOrReplace is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<Pool>,
    Pool,
    HorizonDbResourceUpdatedLroResponse<Pool> | PoolCreateAcceptedResponse,
    ErrorResponse
  >;

  @doc("Updates an existing HorizonDB pool, including its node allocation, selected compute model properties, compute model type, high-availability configuration, or associated parameter group. Omitted nodeCount and highAvailability.mode values preserve their existing values; the service recursively merges the PATCH before atomically validating the effective tuple. nodeCount, when supplied, must be 1 through 16. Disabled is valid only when the effective nodeCount is 1. AnyZone and ZoneRedundant are valid only when the effective nodeCount is 2 through 16. Therefore, crossing between those node-count ranges requires nodeCount and highAvailability.mode to be changed together. AnyZone permits same-zone or cross-zone placement. Changing from AnyZone to ZoneRedundant may allocate a replacement node in another availability zone and replace a read-only node, disconnecting connections to the replaced node. If all requested nodes or the required zonal topology cannot be provisioned, the long-running operation fails and the previous resource state is preserved. To deallocate runtime compute without changing the configured nodeCount, use the Pool stop action. When parameterGroup is supplied, both parameterGroupResourceId and applyMethod are required. The pool can switch its association in either direction between the corresponding default parameter group and a customer-created parameter group. applyMethod controls when dynamic parameter changes become effective. Static parameter changes always require a customer-initiated Restart; Stop followed by Start and scheduled maintenance do not apply pending changes. Subtype-specific compute constraints are validated against the recursively merged configuration.")
  update is ArmCustomPatchAsync<
    Pool,
    PoolForPatchUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Pool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Deletes a HorizonDB pool together with the Pool-scoped Endpoint whose associatedResourceId identifies that Pool and all FirewallRule children of that Endpoint. The Endpoint cannot outlive or be deleted independently from its Pool. When this is the Cluster's last surviving Pool, the service also disconnects every existing private endpoint connection associated with the Cluster by setting its privateLinkServiceConnectionState.status to Rejected and providing a description that the last Pool was deleted. The HorizonDB private endpoint connection resources remain available for inspection and cleanup, and customer-owned Microsoft.Network/privateEndpoints resources are not deleted. The delete long-running operation completes only after all required private endpoint disconnections have completed.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Pool,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB pools in a cluster.")
  list is ArmResourceListByParent<Pool>;

  @doc("Starts a stopped HorizonDB pool. Power operations are supported only at pool scope in this API version; there is no cluster-level start action. Start does not apply pending dynamic or static parameter changes; parameterGroup.syncStatus remains PendingReboot until a customer-initiated Restart. When the pool is already Ready, the operation succeeds as a true idempotent no-op and likewise leaves pending parameter changes pending. The operation is allowed when the pool has no allocated nodes. After the Pool is running, its Pool-scoped ReadOnly Endpoint routes only when at least one allocated node is not currently playing the read-write role. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
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

  @doc("Stops a running HorizonDB pool and deallocates compute. Power operations are supported only at pool scope in this API version; there is no cluster-level stop action. Stop does not apply pending dynamic or static parameter changes; parameterGroup.syncStatus remains PendingReboot. A subsequent Start also preserves those pending changes. The operation succeeds as an idempotent no-op when the pool is already Stopped. It is allowed when the pool has no allocated nodes. The Pool-scoped ReadOnly Endpoint remains discoverable but has no routing destination while the Pool is Stopped. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
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

  @doc("Restarts the PostgreSQL container on all allocated nodes in a ready HorizonDB pool and applies pending dynamic and static parameter changes. This customer-initiated Restart is the only operation that applies static parameter changes or dynamic parameter changes requested with PendingReboot; Stop followed by Start and scheduled maintenance do not apply them. Power operations are supported only at pool scope in this API version; there is no cluster-level restart action. When the pool has no allocated nodes, the operation succeeds without restarting any nodes, pending changes are considered applied, parameterGroup.syncStatus becomes InSync, and the resulting configuration applies to nodes allocated later. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
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
