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

@doc("A HorizonDB cluster name used before enforcing lowercase names.")
@pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
@minLength(1)
@maxLength(63)
scalar LegacyClusterName extends string;

@doc("A lowercase enforced name as a HorizonDB cluster name.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar ClusterName extends string;

@renamedFrom(Versions.v2026_10_01, "HorizonDbCluster")
@doc("Represents the HorizonDB cluster.")
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  @doc("The name of the HorizonDB cluster.")
  @key("clusterName")
  @path
  @segment("clusters")
  @typeChangedFrom(Versions.v2026_10_01, LegacyClusterName)
  name: ClusterName;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbClusterProperties")
@doc("Properties of a HorizonDB cluster.")
model ClusterProperties {
  @removed(Versions.v2026_10_01)
  @doc("The administrator login name.")
  @minLength(1)
  @maxLength(63)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  administratorLogin: string;

  @removed(Versions.v2026_10_01)
  @doc("The administrator login password.")
  @secret
  @minLength(8)
  @maxLength(128)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  administratorLoginPassword?: string;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "version")
  @doc("The version of PostgreSQL used by the HorizonDB cluster.")
  legacyPgVersion?: string;

  @added(Versions.v2026_10_01)
  @doc("The PostgreSQL major version used by the HorizonDB cluster. API version 2026-10-01 accepts only 17. This property is required on every PUT and is immutable after creation. On replacement, resubmitting the existing value is accepted and changing it is rejected. For point-in-time restore, PostgreSQL version is the only new-cluster property inherited from the source backup metadata, and the value in the request must match that version. All other new-cluster configuration comes from the request or service defaults. Future API versions may add supported values without changing this property type.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  postgreSqlVersion: PostgreSqlVersion;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "createMode")
  @doc("The mode to create a new HorizonDB cluster.")
  legacyCreateMode?: CreateModeCluster;

  @added(Versions.v2026_10_01)
  @doc("The mode used to create the cluster. When this property is omitted while creating a new cluster, the service records Create. PointInTimeRestore creates a new cluster from an available backup; pointInTimeUtc and creationSourceClusterResourceId are then required, postgreSqlVersion must match the source backup's major version, and the target cluster location must match the source cluster location until cross-region point-in-time restore is supported. This property is immutable and is returned as creation provenance. On replacement, omission preserves the recorded value, resubmitting the same value is accepted, and changing it is rejected.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  creationMode?: ClusterCreateMode;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "pointInTimeUTC")
  @doc("Restore point creation time specifying the time to restore from.")
  legacyPointInTime?: utcDateTime;

  @added(Versions.v2026_10_01)
  @doc("The requested point in time, in UTC, to restore from. This property is required when creationMode is PointInTimeRestore and must be absent for other creation modes or when creationMode is omitted. The service honors this value for same-region restore. Until cross-region point-in-time restore is supported, the target cluster location must match the source cluster location; a cross-region request is rejected synchronously with 400 CrossRegionPointInTimeRestoreNotSupported and does not create or modify a resource. This property can only be specified during resource creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  pointInTimeUtc?: utcDateTime;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "sourceClusterResourceId")
  @doc("The source cluster resource ID for restore or node creation.")
  legacySourceClusterResourceId?: armResourceIdentifier;

  @added(Versions.v2026_10_01)
  @doc("The Azure resource ID of the source HorizonDB cluster used by the selected creation mode. This property is required for PointInTimeRestore and other source-based creation modes, and must be absent when creationMode is Create or omitted. Until cross-region point-in-time restore is supported, PointInTimeRestore requires the target and source clusters to be in the same Azure region. A source cluster does not need to have a pool to be restored, provided an available backup exists. This immutable creation-provenance value does not change after creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  creationSourceClusterResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters";
    }
  ]>;

  @added(Versions.v2027_03_01_preview)
  @doc("The replication-set metadata for this cluster. This property is present on every cluster that belongs to a replication set, including the current root cluster and replicas created with creationMode AsyncReplica.")
  @visibility(Lifecycle.Read)
  replication?: ClusterReplicationProperties;

  @removed(Versions.v2026_10_01)
  @doc("The pool name for restore or node operations.")
  poolName?: string;

  @removed(Versions.v2026_10_01)
  @doc("Number of replicas.")
  @minValue(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  replicaCount?: int32;

  @removed(Versions.v2026_10_01)
  @doc("Number of vCores.")
  @minValue(1)
  @maxValue(96)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  vCores?: int32;

  @removed(Versions.v2026_10_01)
  @doc("The processor type for the HorizonDB cluster.")
  processorType?: string;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "network")
  @doc("The network related info.")
  legacyNetwork?: Network;

  @added(Versions.v2026_10_01)
  @doc("The network configuration for the cluster. When this object is omitted, the service defaults it to publicAccess Disabled.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  network?: Network = #{ publicAccess: "Disabled" };

  @added(Versions.v2026_10_01)
  @doc("The backup configuration for the cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  backup?: BackupProperties;

  @added(Versions.v2027_03_01_preview)
  @doc("The deletion configuration and current deletion-blocking status for the cluster. When this object is omitted while creating a new cluster, the service records policy Immediate. When it is omitted from a replacement PUT, the existing policy is preserved.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  deletion?: ClusterDeletionProperties;

  @typeChangedFrom(Versions.v2026_10_01, State)
  @madeRequired(Versions.v2026_10_01)
  @doc("Current state of the cluster.")
  @visibility(Lifecycle.Read)
  state: ClusterState;

  @removed(Versions.v2026_10_01)
  @doc("The fully qualified domain name of the cluster.")
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  @removed(Versions.v2026_10_01)
  @doc("The fully qualified domain name used for readonly endpoint for the cluster.")
  @visibility(Lifecycle.Read)
  readonlyEndpoint?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "API version 2026-10-01 guarantees provisioningState in every Cluster response; the 2026-01-20-preview projection remains optional."
  @madeRequired(Versions.v2026_10_01)
  @doc("The provisioning state of the cluster.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @added(Versions.v2027_03_01_preview)
  @doc("The current designated read-write pool and read-write status for the cluster.")
  @visibility(Lifecycle.Read)
  readWritePool: ReadWritePoolProperties;

  @removed(Versions.v2026_10_01)
  @doc("Defines how replicas are placed across availability zones.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  zonePlacementPolicy?: ZonePlacementEnforcement;

  @removed(Versions.v2026_10_01)
  @doc("Defines connection to a parameter group.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  parameterGroup?: HorizonDbClusterParameterGroupConnectionProperties;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Authentication configuration for the HorizonDB cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  authConfig?: HorizonDbClusterAuthConfig;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("The compute model for the cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeModel?: HorizonDbComputeModel;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Mirroring configuration for the HorizonDB cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  mirroring?: HorizonDbClusterMirroring;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("Mirroring configuration for a HorizonDB cluster.")
model HorizonDbClusterMirroring {
  @doc("The names of the databases to mirror.")
  databaseNames?: string[];

  @doc("The resource ID of the user-assigned managed identity used for mirroring.")
  userAssignedIdentityId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("Authentication configuration for a HorizonDB cluster.")
model HorizonDbClusterAuthConfig {
  @doc("Indicates whether Microsoft Entra ID authentication is enabled or disabled.")
  entraIdAuth?: AuthenticationState;

  @doc("The Microsoft Entra tenant ID.")
  tenantId?: string;

  @doc("Indicates whether password authentication is enabled or disabled.")
  passwordAuth?: AuthenticationState;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("The compute model for a HorizonDB cluster.")
model HorizonDbComputeModel {
  @doc("The compute model type. Supported values: 'Provisioned', 'Serverless'.")
  type?: HorizonDbComputeModelType;

  @doc("The fixed vCore count for Provisioned compute.")
  vCores?: int32;

  @doc("The minimum vCores for Serverless compute. Defines the lower autoscaling bound.")
  minvCores?: float64;

  @doc("The maximum vCores for Serverless compute. Defines the upper autoscaling bound.")
  maxvCores?: float64;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("The compute model type.")
union HorizonDbComputeModelType {
  string,

  @doc("Provisioned compute.")
  Provisioned: "Provisioned",

  @doc("Serverless compute.")
  Serverless: "Serverless",
}

@added(Versions.v2027_03_01_preview)
@doc("The current automatic and requested failover eligibility for a cluster.")
model FailoverProperties {
  @doc("The current readiness state for both automatic failover and a caller-requested failover operation.")
  @visibility(Lifecycle.Read)
  state: FailoverState;

  @doc("The reason failover is not ready. This property is present only when state is NotReady and absent when state is Ready. Valid reasons are that no read-write pool is designated, the designated read-write pool has fewer than two nodes, the designated read-write pool is stopped or shut down, or its read-only nodes are not functional.")
  @visibility(Lifecycle.Read)
  unavailableReason?: string;
}

@added(Versions.v2027_03_01_preview)
@doc("The current zone redundancy status for the read-write node.")
model ReadWritePoolZoneRedundancyProperties {
  @doc("The current zone-redundancy readiness state for the read-write node. The state is NotReady when no read-write pool is designated.")
  @visibility(Lifecycle.Read)
  state: ZoneRedundancyState;

  @doc("The reason zone redundancy is not ready. This property is present only when state is NotReady and absent when state is Ready. Valid reasons are that no read-write pool is designated, the designated read-write pool has fewer than two nodes, all nodes in the designated read-write pool are deployed in a single availability zone, or the region does not support availability zones.")
  @visibility(Lifecycle.Read)
  unavailableReason?: string;
}

@added(Versions.v2027_03_01_preview)
@doc("The current designated read-write pool and read-write status for a HorizonDB cluster. When a pool is created while the cluster currently has no pools, the service automatically designates the new pool as the read-write pool. This behavior also applies after all pools that existed earlier in the cluster's lifetime have been deleted.")
model ReadWritePoolProperties {
  @doc("The Azure resource ID of the pool designated to host the cluster's read-write node. The pool is a child resource of this cluster. When a pool is created while the cluster currently has no pools, the service automatically sets this property to the new pool's resource ID, including when all pools that existed earlier in the cluster's lifetime were deleted. This property is absent when no pool is designated, such as after clearReadWritePool succeeds.")
  @visibility(Lifecycle.Read)
  designatedPoolResourceId?: PoolResourceId;

  @added(Versions.v2027_03_01_preview)
  @doc("The current failover status for the read-write node. This object is always returned on reads. When failover is not ready, state is NotReady and unavailableReason explains why.")
  @visibility(Lifecycle.Read)
  failover: FailoverProperties;

  @added(Versions.v2027_03_01_preview)
  @doc("The current zone redundancy status for the read-write node. This object is always returned on reads. When zone redundancy is not ready, state is NotReady and unavailableReason explains why.")
  @visibility(Lifecycle.Read)
  zoneRedundancy: ReadWritePoolZoneRedundancyProperties;
}

@added(Versions.v2026_10_01)
@doc("An Azure resource ID that identifies a HorizonDB cluster.")
scalar HorizonDbClusterResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters",
    }
  ]>;

@added(Versions.v2027_03_01_preview)
@doc("The readiness state for automatic and caller-requested failover.")
union FailoverState {
  string,

  @doc("Failover is ready.")
  Ready: "Ready",

  @doc("Failover is not ready. Inspect unavailableReason for details.")
  NotReady: "NotReady",
}

@added(Versions.v2027_03_01_preview)
@doc("The readiness state for zone redundancy of the read-write node.")
union ZoneRedundancyState {
  string,

  @doc("Zone redundancy is ready.")
  Ready: "Ready",

  @doc("Zone redundancy is not ready. Inspect unavailableReason for details.")
  NotReady: "NotReady",
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbClusterPropertiesForPatchUpdate")
@doc("Properties of a HorizonDB cluster for update operations.")
model ClusterPropertiesForPatchUpdate {
  @removed(Versions.v2026_10_01)
  @secret
  @minLength(8)
  @maxLength(128)
  @doc("The administrator login password.")
  @visibility(Lifecycle.Update)
  administratorLoginPassword?: string;

  @added(Versions.v2026_10_01)
  @doc("The network configuration to update for the cluster.")
  @visibility(Lifecycle.Update)
  network?: NetworkForPatchUpdate;

  @removed(Versions.v2026_10_01)
  @doc("Number of vCores.")
  @minValue(1)
  @maxValue(96)
  @visibility(Lifecycle.Update)
  vCores?: int32;

  @removed(Versions.v2026_10_01)
  @doc("Defines connection to a parameter group.")
  parameterGroup?: HorizonDbClusterParameterGroupConnectionProperties;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Authentication configuration for the HorizonDB cluster.")
  @visibility(Lifecycle.Update)
  authConfig?: HorizonDbClusterAuthConfig;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("The compute model for the cluster.")
  @visibility(Lifecycle.Update)
  computeModel?: HorizonDbComputeModel;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Mirroring configuration for the HorizonDB cluster.")
  @visibility(Lifecycle.Update)
  mirroring?: HorizonDbClusterMirroring;

  @added(Versions.v2026_10_01)
  @doc("The backup configuration for the cluster.")
  @visibility(Lifecycle.Update)
  backup?: BackupPropertiesForPatchUpdate;

  @added(Versions.v2027_03_01_preview)
  @doc("The deletion configuration to update for the cluster.")
  @visibility(Lifecycle.Update)
  deletion?: ClusterDeletionPropertiesForPatchUpdate;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbClusterForPatchUpdate")
@doc("HorizonDB cluster for update operations.")
model ClusterForPatchUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  @doc("The properties that can be updated for a HorizonDB cluster.")
  properties?: ClusterPropertiesForPatchUpdate;
}

@@added(Cluster.identity, Versions.v2026_05_01_preview);
@@added(ClusterForPatchUpdate.identity, Versions.v2026_05_01_preview);

@added(Versions.v2027_03_01_preview)
@doc("The deletion configuration and current deletion-blocking status for a HorizonDB cluster.")
model ClusterDeletionProperties {
  @doc("Determines when the cluster is permanently deleted. When this property is omitted while creating a new cluster, the service records Immediate. When it is omitted from a replacement PUT, the existing policy is preserved. With RetainUntilNoBackupsRemain, a delete request removes all pools, stops creation of automatic backups, transitions the cluster to DeletionBlockedByBackups, and returns 409 Conflict while automatic or user-created backups remain. In that state, reads remain available, but mutating operations other than deletion of user-created backups and another cluster delete request are rejected. Once no backups remain, retrying the cluster delete request starts physical deletion. The policy can be changed from Immediate to RetainUntilNoBackupsRemain, but cannot be changed back to Immediate. Resubmitting the current value succeeds as an idempotent no-op.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  policy?: ClusterDeletionPolicy;

  @doc("The date and time, in UTC, when the cluster becomes eligible for physical deletion based on its remaining automatic backups. This property is present only when state is DeletionBlockedByBackups, blockingReason is AutomaticBackups, and a real eligibility time can be calculated. It is absent while user-created backups block deletion.")
  @visibility(Lifecycle.Read)
  deletionEligibleAtUtc?: utcDateTime;

  @doc("The current reason that physical deletion is blocked. This property is present only when state is DeletionBlockedByBackups.")
  @visibility(Lifecycle.Read)
  blockingReason?: ClusterDeletionBlockingReason;
}

@added(Versions.v2027_03_01_preview)
@doc("The deletion configuration for updating a HorizonDB cluster.")
model ClusterDeletionPropertiesForPatchUpdate {
  @doc("Determines when the cluster is permanently deleted. With RetainUntilNoBackupsRemain, a delete request removes all pools, stops creation of automatic backups, and retains the cluster in DeletionBlockedByBackups until all backups are removed or expire. The policy can be changed from Immediate to RetainUntilNoBackupsRemain, but cannot be changed back to Immediate. Resubmitting the current value succeeds as an idempotent no-op.")
  @visibility(Lifecycle.Update)
  policy?: ClusterDeletionPolicy;
}

@added(Versions.v2027_03_01_preview)
@doc("Parameters for designating a pool to host the cluster's read-write node.")
model DesignateReadWritePoolRequest {
  @doc("The Azure resource ID of the existing pool to designate as the read-write pool. The pool must be a child resource of the cluster on which this action is invoked. A resource ID for a pool in another cluster is rejected.")
  poolResourceId: PoolResourceId;

  @doc("Indicates whether the operation can succeed when the named target pool has no active or running compute, leaving the cluster without an active or running read-write node. The default is false.")
  allowNoActiveReadWriteNode?: boolean = false;
}

@doc("Network properties.")
model Network {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicNetworkAccess is a configuration flag, not sensitive data"
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "publicNetworkAccess")
  @doc("The flag indicating whether public ip is requested.")
  @visibility(Lifecycle.Read)
  legacyPublicNetworkAccess?: PublicNetworkAccessState;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicAccess is a configuration flag, not sensitive data"
  @added(Versions.v2026_10_01)
  @doc("Specifies whether public access is enabled for the cluster. The service defaults to Disabled when this property is omitted.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  publicAccess?: PublicNetworkAccessState = PublicNetworkAccessState.Disabled;
}

@added(Versions.v2026_10_01)
@doc("Network properties for updating a HorizonDB cluster.")
model NetworkForPatchUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicAccess is a configuration flag, not sensitive data"
  @doc("Specifies whether public access is enabled for the cluster. Omission preserves the current value.")
  @visibility(Lifecycle.Update)
  publicAccess?: PublicNetworkAccessState;
}

@doc("The mode to create a new HorizonDB cluster.")
union CreateModeCluster {
  string,

  /** Create a new cluster */
  Create: "Create",

  /** Update an existing cluster */
  @removed(Versions.v2026_10_01)
  Update: "Update",

  /** Create cluster from point-in-time restore */
  PointInTimeRestore: "PointInTimeRestore",
}

@added(Versions.v2026_10_01)
@doc("Controls how a HorizonDB cluster PUT request is processed.")
union ClusterCreateMode {
  string,

  /** Process the request as a normal cluster creation. */
  Create: "Create",

  /** Create the cluster from a point-in-time restore. */
  PointInTimeRestore: "PointInTimeRestore",

  /** Create the cluster as an asynchronous replica and add it to the source cluster's existing replication set. */
  @added(Versions.v2027_03_01_preview)
  AsyncReplica: "AsyncReplica",
}

@renamedFrom(Versions.v2026_10_01, "ZonePlacementPolicy")
@doc("The zone placement enforcement option.")
union ZonePlacementEnforcement {
  string,

  /** Enforce zonal redundancy */
  Strict: "Strict",

  /** Best-effort placement (default) */
  BestEffort: "BestEffort",
}

@added(Versions.v2026_10_01)
@doc("Current state of a HorizonDB cluster.")
union ClusterState {
  string,

  /** Is ready and operational */
  Ready: "Ready",

  /** Is provisioning */
  Provisioning: "Provisioning",

  /** Is being deleted */
  Deleting: "Deleting",

  /** A delete request removed all pools and stopped new automatic backups, but physical deletion is blocked until all remaining backups are removed or expire */
  @added(Versions.v2027_03_01_preview)
  DeletionBlockedByBackups: "DeletionBlockedByBackups",

  /** Is inaccessible */
  Inaccessible: "Inaccessible",

  /** Is being updated */
  Updating: "Updating",
}

@added(Versions.v2027_03_01_preview)
@doc("Determines when a HorizonDB cluster is permanently deleted after a delete request.")
union ClusterDeletionPolicy {
  string,

  /** Permanently deletes the cluster as soon as the delete request is processed */
  Immediate: "Immediate",

  /** Removes all pools, stops new automatic backups, and retains the cluster until all remaining backups are removed or expire */
  RetainUntilNoBackupsRemain: "RetainUntilNoBackupsRemain",
}

@added(Versions.v2027_03_01_preview)
@doc("The reason that physical deletion of a HorizonDB cluster is blocked.")
union ClusterDeletionBlockingReason {
  string,

  /** Physical deletion is blocked until all remaining automatic backups expire. */
  AutomaticBackups: "AutomaticBackups",

  /** Physical deletion is blocked until all user-created backups are deleted. */
  UserCreatedBackups: "UserCreatedBackups",
}

@doc("Long-running operation headers returned when a HorizonDB cluster update is accepted.")
model ClusterUpdateAcceptedHeaders is ArmLroLocationHeader<
  Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
  Cluster,
  string
> {
  @added(Versions.v2026_10_01)
  @doc("A link to the status monitor for the cluster update operation.")
  @Azure.Core.pollingLocation(
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>
  )
  @header("Azure-AsyncOperation")
  azureAsyncOperation?: string;
}

@added(Versions.v2026_10_01)
@doc("Long-running operation headers returned when an asynchronous HorizonDB cluster create or replacement is accepted.")
model ClusterCreateOrReplaceLroHeaders {
  @doc("A link to the status monitor for the cluster create or replacement operation.")
  @header("Azure-AsyncOperation")
  azureAsyncOperation?: string;

  ...Azure.Core.Foundations.RetryAfterHeader;
}

@added(Versions.v2026_10_01)
@doc("The response returned when an asynchronous HorizonDB cluster replacement is accepted.")
model ClusterReplaceAcceptedResponse {
  ...OkResponse;
  ...ClusterCreateOrReplaceLroHeaders;

  @doc("The HorizonDB cluster with a non-terminal provisioning state.")
  @bodyRoot
  body: Cluster;
}

@added(Versions.v2026_10_01)
@doc("The response returned when asynchronous HorizonDB cluster creation is accepted.")
model ClusterCreateAcceptedResponse {
  ...CreatedResponse;
  ...ClusterCreateOrReplaceLroHeaders;

  @doc("The HorizonDB cluster with a non-terminal provisioning state.")
  @bodyRoot
  body: Cluster;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbClusters")
@armResourceOperations
interface Clusters {
  @doc("Gets information about a HorizonDB cluster.")
  get is ArmResourceRead<Cluster>;

  @doc("Creates a new HorizonDB cluster or updates an existing cluster.")
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "createOrUpdate")
  @sharedRoute
  createOrUpdateLegacy is ArmResourceCreateOrReplaceAsync<Cluster>;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The AutoRest emitter infers final-state-via from polling metadata. Marking this standard ARM PUT as an LRO without polling decorators emits x-ms-long-running-operation while intentionally omitting x-ms-long-running-operation-options."
  @added(Versions.v2026_10_01)
  @doc("Creates a new HorizonDB cluster or replaces an existing cluster. PointInTimeRestore creates the new Cluster resource and hydrates its service-owned database storage from an available source backup. It does not clone source pools, Pool-scoped endpoints, firewall rules, parameter-group associations, or other child resources. The new Cluster receives its service-generated Cluster-scoped Endpoint named cluster. PostgreSQL version is inherited from backup metadata; all other new-cluster configuration comes from the request or service defaults. Until cross-region point-in-time restore is supported, the target cluster location must match the source cluster location; a cross-region request is rejected synchronously with 400 CrossRegionPointInTimeRestoreNotSupported and does not create or modify a resource.")
  @sharedRoute
  @Azure.ClientGenerator.Core.Legacy.markAsLro
  @autoRoute
  @armResourceCreateOrUpdate(Cluster)
  @put
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<Cluster>,
    Cluster,
    ClusterReplaceAcceptedResponse | ClusterCreateAcceptedResponse,
    ErrorResponse
  >;

  @doc("Updates an existing HorizonDB cluster.")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterForPatchUpdate,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    ClusterUpdateAcceptedHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Deletes a HorizonDB cluster.")
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "delete")
  @sharedRoute
  deleteLegacy is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @added(Versions.v2026_10_01)
  @doc("Deletes a HorizonDB cluster, its Cluster-scoped Endpoint, and all remaining child resources. For an accepted deletion, the long-running operation remains nonterminal until physical deletion completes and point GET returns 404 Not Found.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  @doc("Lists all HorizonDB clusters in a subscription.")
  listBySubscription is ArmListBySubscription<Cluster>;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Starts a stopped HorizonDB cluster.")
  start is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Stops a running HorizonDB cluster.")
  stop is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Restarts a HorizonDB cluster.")
  restart is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2027_03_01_preview)
  @doc("Lists the direct asynchronous replicas of this cluster. Each item identifies a cluster that has the Target role and uses this cluster as its immediate source, and reports the state of that replication link. Descendant replicas whose immediate source is another replica are not returned.")
  @get
  @list
  @action("replicas")
  listReplicas is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListCustomResult<ClusterReplicaLink>>
  >;

  @added(Versions.v2027_03_01_preview)
  @doc("Lists virtual endpoints whose writer or reader endpoint target belongs to this cluster. Each item identifies the virtual endpoint and the Writer or Reader role through which it references the cluster. Callers can use this operation to discover dependencies that block cluster deletion or replication topology changes.")
  @get
  @list
  @action("virtualEndpointReferences")
  listVirtualEndpointReferences is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListCustomResult<ClusterVirtualEndpointReference>>
  >;

  @added(Versions.v2027_03_01_preview)
  @doc("Promotes this replica cluster by detaching it and all of its descendant replicas from the current replication set, creating an isolated replication set rooted at this cluster while preserving its descendant relationships. The operation is valid only when the cluster has the Target role. Current root clusters, clusters outside a replication set, and clusters in an incompatible operational or replication state are rejected. The service also rejects promotion with 409 ClusterReferencedByVirtualEndpoint when the topology change would invalidate a virtual endpoint reader relationship; callers must retarget or delete the virtual endpoint first.")
  @action("promote")
  promote is ArmResourceActionAsyncBase<
    Cluster,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  @added(Versions.v2027_03_01_preview)
  @doc("Switches this replica cluster with its immediate source while preserving the replication set and descendant relationships. The operation is valid only when the cluster has the Target role. Before starting, a virtual endpoint must exist whose writer targets the Cluster-scoped Endpoint named cluster in the immediate source Cluster and whose reader targets the Cluster-scoped Endpoint named cluster in this direct replica; otherwise the service rejects the request with 409 VirtualEndpointSwitchoverPreconditionFailed. On success, the service atomically swaps the replication topology, changes the invoked replica's Cluster-scoped Endpoint role to ReadWrite, changes the former source's Cluster-scoped Endpoint role to ReadOnly, and swaps the virtual endpoint writer and reader resource IDs and DNS CNAME destinations. The virtual endpoint resource ID and stable writer and reader FQDNs do not change. If the topology, role, or endpoint retarget cannot commit, the service rolls back all changes and reports a failed operation.")
  @action("switchover")
  switchover is ArmResourceActionAsyncBase<
    Cluster,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  @added(Versions.v2027_03_01_preview)
  @doc("Designates an existing pool to host the cluster's read-write node. This POST action can be authorized separately from general cluster write permissions. The pool resource ID must identify a child resource of this cluster; a pool in another cluster is rejected. On success, the service sets readWritePool.designatedPoolResourceId to the requested resource ID. Endpoint scopes, roles, FQDNs, aliases, and firewall rules do not change during designation.")
  @action("designateReadWritePool")
  designateReadWritePool is ArmResourceActionAsyncBase<
    Cluster,
    DesignateReadWritePoolRequest,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  @added(Versions.v2027_03_01_preview)
  @doc("Clears the cluster's read-write pool designation so that no pool hosts the cluster's read-write node. This POST action can be authorized separately from general cluster write permissions. On success, the service removes readWritePool.designatedPoolResourceId. Endpoint scopes, roles, FQDNs, aliases, and firewall rules do not change; the Cluster-scoped ReadWrite Endpoint remains discoverable but has no routing destination.")
  @action("clearReadWritePool")
  clearReadWritePool is ArmResourceActionAsyncBase<
    Cluster,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  @added(Versions.v2026_10_01)
  @doc("Triggers a failover operation for the HorizonDB cluster. The service selects the new read-write node using the same mechanics as automatic failover.")
  @action("failover")
  failover is ArmResourceActionAsyncBase<
    Cluster,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;
}
