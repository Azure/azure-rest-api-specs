import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using Azure.ClientGenerator.Core;

namespace Microsoft.DocumentDB;
/** Represents a mongo cluster resource. */
model MongoCluster is TrackedResource<MongoClusterProperties> {
  /** The name of the mongo cluster. */
  @maxLength(40)
  @minLength(3)
  @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
  @key("mongoClusterName")
  @segment("mongoClusters")
  @visibility(Lifecycle.Read)
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@@added(MongoCluster.identity,
  Microsoft.DocumentDB.Versions.v2025_07_01_preview
);

@armResourceOperations
interface MongoClusters {
  /** Gets information about a mongo cluster. */
  get is ArmResourceRead<MongoCluster>;
  /** Create or update a mongo cluster. Update overwrites all properties for the resource. To only modify some of the properties, use PATCH. */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    MongoCluster,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Updates an existing mongo cluster. The request body can contain one to many of the properties present in the normal mongo cluster definition. */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    MongoCluster,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      MongoCluster,
      MongoClusterProperties
    >
  >;
  /** Deletes a mongo cluster. */
  delete is ArmResourceDeleteWithoutOkAsync<MongoCluster>;
  /** List all the mongo clusters in a given resource group. */
  listByResourceGroup is ArmResourceListByParent<MongoCluster>;
  /** List all the mongo clusters in a given subscription. */
  list is ArmListBySubscription<MongoCluster>;
  /** List mongo cluster connection strings. This includes the default connection string using SCRAM-SHA-256, as well as other connection strings supported by the cluster. */
  listConnectionStrings is ArmResourceActionSync<
    MongoCluster,
    void,
    ListConnectionStringsResult
  >;
  /** Check if mongo cluster name is available for use. */
  @action("checkMongoClusterNameAvailability")
  checkNameAvailability is checkLocalNameAvailability;
  /** Promotes a replica mongo cluster to a primary role. */
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  promote is ArmResourceActionNoResponseContentAsync<
    MongoCluster,
    PromoteReplicaRequest
  >;
}

/** Identifier for a mongo cluster resource. */
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
scalar MongoClusterResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DocumentDB/mongoClusters",
    }
  ]>;

/** The properties of a mongo cluster. */
model MongoClusterProperties {
  /** The mode to create a mongo cluster. */
  @visibility(Lifecycle.Create)
  @removed(Versions.v2025_04_01_preview)
  @renamedFrom(Versions.v2025_04_01_preview, "createMode")
  oldCreateMode?: CreateMode;

  /** The parameters to create a point-in-time restore mongo cluster. */
  @visibility(Lifecycle.Create)
  @removed(Versions.v2025_04_01_preview)
  @renamedFrom(Versions.v2025_04_01_preview, "restoreParameters")
  oldRestoreParameters?: MongoClusterRestoreParameters;

  /** The parameters to create a replica mongo cluster. */
  @visibility(Lifecycle.Create)
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  @removed(Versions.v2025_04_01_preview)
  @renamedFrom(Versions.v2025_04_01_preview, "replicaParameters")
  oldReplicaParameters?: MongoClusterReplicaParameters;

  /** The mode to create a mongo cluster. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_04_01_preview)
  createMode?: CreateMode;

  /** The parameters to create a point-in-time restore mongo cluster. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_04_01_preview)
  restoreParameters?: MongoClusterRestoreParameters;

  /** The parameters to create a replica mongo cluster. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_04_01_preview)
  replicaParameters?: MongoClusterReplicaParameters;

  /** The administrator's login for the mongo cluster. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @removed(Versions.v2024_07_01)
  administratorLogin?: string;

  /** The password of the administrator login. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @removed(Versions.v2024_07_01)
  @secret
  administratorLoginPassword?: string;

  /** The local administrator properties for the mongo cluster. */
  @added(Versions.v2024_07_01)
  administrator?: AdministratorProperties;

  /** The Mongo DB server version. Defaults to the latest available version if not specified. */
  serverVersion?: string;

  /** The default mongo connection string for the cluster. */
  @visibility(Lifecycle.Read)
  connectionString?: string;

  /** Earliest restore timestamp in UTC ISO8601 format. */
  @visibility(Lifecycle.Read)
  @removed(Versions.v2024_07_01)
  earliestRestoreTime?: string;

  /** The provisioning state of the mongo cluster. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The status of the mongo cluster. */
  @visibility(Lifecycle.Read)
  clusterStatus?: MongoClusterStatus;

  /** Whether or not public endpoint access is allowed for this mongo cluster. */
  publicNetworkAccess?: PublicNetworkAccess;

  /** The list of node group specs in the cluster. */
  @identifiers(#[])
  @removed(Versions.v2024_07_01)
  nodeGroupSpecs?: NodeGroupSpec[];

  /** The high availability properties of the mongo cluster. */
  @added(Versions.v2024_07_01)
  highAvailability?: HighAvailabilityProperties;

  /** The storage properties of the mongo cluster. */
  @added(Versions.v2024_07_01)
  storage?: StorageProperties;

  /** The sharding properties of the mongo cluster. */
  @added(Versions.v2024_07_01)
  sharding?: ShardingProperties;

  /** The compute properties of the mongo cluster. */
  @added(Versions.v2024_07_01)
  compute?: ComputeProperties;

  /** The backup properties of the mongo cluster. */
  @added(Versions.v2024_07_01)
  backup?: BackupProperties;

  /** The Data API properties of the mongo cluster. */
  @added(Versions.v2024_10_01_preview)
  dataApi?: DataApiProperties;

  /** List of private endpoint connections. */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /** List of private endpoint connections. */
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  previewFeatures?: PreviewFeature[];

  /** The replication properties for the mongo cluster */
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  @visibility(Lifecycle.Read)
  replica?: ReplicationProperties;

  /** The infrastructure version the cluster is provisioned on. */
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  @visibility(Lifecycle.Read)
  infrastructureVersion?: string;

  /** The authentication configuration for the cluster. */
  @added(Versions.v2025_04_01_preview)
  authConfig?: AuthConfigProperties;

  /** The encryption configuration for the cluster. Depends on identity being configured. */
  @added(Versions.v2025_07_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  encryption?: EncryptionProperties;
}

/** The mode that the Mongo Cluster is created with. */
union CreateMode {
  string,

  /** Create a new mongo cluster. */
  "Default",

  /** Create a mongo cluster from a restore point-in-time. */
  "PointInTimeRestore",

  /** Create a replica cluster in distinct geographic region from the source cluster. */
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  "GeoReplica",

  /** Create a replica cluster in the same geographic region as the source cluster. */
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  "Replica",
}

/** Parameters used for restore operations */
model MongoClusterRestoreParameters {
  /** UTC point in time to restore a mongo cluster */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Capitalized acronym in the property name."
  pointInTimeUTC?: utcDateTime;

  /** Resource ID to locate the source cluster to restore */
  @typeChangedFrom(Microsoft.DocumentDB.Versions.v2024_06_01_preview, string)
  sourceResourceId?: MongoClusterResourceId;
}

/** The compute properties of the cluster. This includes the virtual-cores/memory and scaling options applied to servers in the cluster. */
@added(Versions.v2024_07_01)
model ComputeProperties {
  /** The compute tier to assign to the cluster, where each tier maps to a virtual-core and memory size. Example values: 'M30', 'M40'. */
  tier?: string;
}

/** The storage properties of the cluster. This includes the data storage size and scaling applied to servers in the cluster. */
@added(Versions.v2024_07_01)
model StorageProperties {
  /** The size of the data disk assigned to each server. */
  sizeGb?: int64;

  /** The type of storage to provision the cluster servers with. */
  @added(Versions.v2025_04_01_preview)
  type?: StorageType;

  /** The IOPs of the storage assigned to each server. Only applicable if the type is 'PremiumSSDv2'. */
  @added(Versions.v2025_04_01_preview)
  iops?: int64;

  /** The throughput of the storage assigned to each server. Only applicable if the type is 'PremiumSSDv2'. */
  @added(Versions.v2025_04_01_preview)
  throughput?: int64;
}

/** The type of storage that a mongo cluster can be provisioned with. */
@added(Versions.v2025_04_01_preview)
union StorageType {
  string,

  /** Premium SSD for high performance workloads. */
  "PremiumSSD",

  /** Premium SSD v2 for very IO-intensive workloads. This is a preview option and has additional limitations. */
  "PremiumSSDv2",
}

/** The sharding properties of the cluster. This includes the shard count and scaling options for the cluster. */
@added(Versions.v2024_07_01)
model ShardingProperties {
  /** Number of shards to provision on the cluster. */
  shardCount?: int32;
}

/** The high availability modes for a cluster. */
@added(Versions.v2024_07_01)
union HighAvailabilityMode {
  string,

  /** High availability mode is disabled. This mode is can see availability impact during faults or maintenance and is not recommended for production. */
  "Disabled",

  /** High availability mode is enabled, where each server in a shard is placed in the same availability zone. */
  "SameZone",

  /** High availability mode is enabled and preferences ZoneRedundant if availability zones capacity is available in the region, otherwise falls-back to provisioning with SameZone. */
  "ZoneRedundantPreferred",
}

/** The backup properties of the cluster. This includes the earliest restore time and retention settings. */
@added(Versions.v2024_07_01)
model BackupProperties {
  /** Earliest restore timestamp in UTC ISO8601 format. */
  @visibility(Lifecycle.Read)
  earliestRestoreTime?: string;
}

/** The connection strings for the given mongo cluster. */
model ListConnectionStringsResult {
  /** An array that contains the connection strings for a mongo cluster. */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  connectionStrings?: ConnectionString[];
}

/** Connection string for the mongo cluster */
model ConnectionString {
  /** Value of the connection string */
  @visibility(Lifecycle.Read)
  @clientName("uri", "csharp")
  connectionString?: string;

  /** Description of the connection string */
  @visibility(Lifecycle.Read)
  description?: string;

  /** Name of the connection string. */
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_07_01)
  name?: string;
}

/** The status of the Mongo cluster resource. */
@clientName("MongoClusterStatus", "go")
union MongoClusterStatus {
  string,

  /** The mongo cluster resource is ready for use. */
  "Ready",

  /** The mongo cluster resource is being provisioned. */
  "Provisioning",

  /** The mongo cluster resource is being updated. */
  "Updating",

  /** The mongo cluster resource is being started. */
  "Starting",

  /** The mongo cluster resource is being stopped. */
  "Stopping",

  /** The mongo cluster resource is stopped. */
  "Stopped",

  /** The mongo cluster resource is being dropped. */
  "Dropping",
}

/** Whether or not public endpoint access is allowed for this Mongo cluster.  Value is optional and default value is 'Enabled' */
union PublicNetworkAccess {
  string,

  /** If set, mongo cluster can be accessed through private and public methods. */
  "Enabled",

  /** If set, the private endpoints are the exclusive access method. */
  "Disabled",
}

/** Preview features that can be enabled on a mongo cluster. */
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
union PreviewFeature {
  string,

  /** Enables geo replicas preview feature. The feature must be set at create-time on new cluster to enable linking a geo-replica cluster to it. */
  "GeoReplicas",
}

/** Parameters used for replica operations. */
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
model MongoClusterReplicaParameters {
  /** The id of the replication source cluster. */
  sourceResourceId: MongoClusterResourceId;

  /** The location of the source cluster */
  sourceLocation: Azure.Core.azureLocation;
}

/** Promote replica request properties. */
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
model PromoteReplicaRequest {
  /** The promote option to apply to the operation. */
  promoteOption: PromoteOption;

  /** The mode to apply to the promote operation. Value is optional and default value is 'Switchover'. */
  mode?: PromoteMode;
}

/** The option to apply to a promote operation. */
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
union PromoteOption {
  string,

  /** Promote option forces the promotion without waiting for the replica to be caught up to the primary. This can result in data-loss so should only be used during disaster recovery scenarios. */
  "Forced",
}

/** The mode to apply to a promote operation. */
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
union PromoteMode {
  string,

  /** Promotion will switch the current replica cluster to the primary role and the original primary will be switched to a replica role, maintaining the replication link. */
  "Switchover",
}

/** Replica properties of the mongo cluster. */
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
model ReplicationProperties {
  /** The resource id the source cluster for the replica cluster. */
  @visibility(Lifecycle.Read)
  sourceResourceId?: MongoClusterResourceId;

  /** The replication role of the cluster */
  @visibility(Lifecycle.Read)
  role?: ReplicationRole;

  /** The replication link state of the replica cluster. */
  @visibility(Lifecycle.Read)
  replicationState?: ReplicationState;
}

/** Replication role of the mongo cluster. */
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
union ReplicationRole {
  string,

  /** The cluster is a primary replica. */
  "Primary",

  /** The cluster is a local asynchronous replica. */
  "AsyncReplica",

  /** The cluster is a geo-asynchronous replica. */
  "GeoAsyncReplica",
}

/** The state of the replication link between the replica and source cluster. */
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
union ReplicationState {
  string,

  /** Replication link is active. */
  "Active",

  /** Replica is catching-up with the primary. This can occur after the replica is created or after a promotion is triggered. */
  "Catchup",

  /** Replica and replication link to the primary is being created. */
  "Provisioning",

  /** Replication link is being updated due to a change on the replica or an upgrade. */
  "Updating",

  /** Replication link is broken and the replica may need to be recreated. */
  "Broken",

  /** Replication link is re-configuring due to a promotion event. */
  "Reconfiguring",
}

/** Specification for a node group. */
@removed(Versions.v2024_07_01)
model NodeGroupSpec is NodeGroupProperties {
  /** The node type deployed in the node group. */
  kind?: NodeKind;

  /** The number of nodes in the node group. */
  nodeCount?: int32;
}

/** The properties of the node group on a cluster. */
@removed(Versions.v2024_07_01)
model NodeGroupProperties {
  /** The resource sku for the node group. This defines the size of CPU and memory that is provisioned for each node. Example values: 'M30', 'M40'. */
  sku?: string;

  /** The disk storage size for the node group in GB. Example values: 128, 256, 512, 1024. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Capitalized acronym in the property name."
  diskSizeGB?: int64;

  /** Whether high availability is enabled on the node group. */
  enableHa?: boolean;
}

/** The high availability properties of the cluster. */
@added(Versions.v2024_07_01)
model HighAvailabilityProperties {
  /** The target high availability mode requested for the cluster. */
  targetMode?: HighAvailabilityMode;
}

/** The kind of the node on the cluster. */
@removed(Versions.v2024_07_01)
union NodeKind {
  string,

  /** The node is a shard kind. */
  "Shard",
}

/** The local administrator login properties. */
@added(Versions.v2024_07_01)
model AdministratorProperties {
  /** The administrator user name. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  userName?: string;

  /** The administrator password. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  password?: string;
}

/** Data API properties. */
@added(Microsoft.DocumentDB.Versions.v2024_10_01_preview)
model DataApiProperties {
  /** The mode to indicate whether the Mongo Data API is enabled for a cluster. */
  mode?: DataApiMode;
}

/** The mode to apply to the Mongo Data API. */
@added(Microsoft.DocumentDB.Versions.v2024_10_01_preview)
union DataApiMode {
  string,

  /** Mongo Data API is enabled for the cluster. */
  "Enabled",

  /** Mongo Data API is disabled for the cluster. */
  "Disabled",
}

/** The authentication configuration for the Mongo cluster. */
@added(Versions.v2025_04_01_preview)
model AuthConfigProperties {
  /** Allowed authentication modes for data access on the cluster. */
  allowedModes?: AuthenticationMode[];
}

/** The authentication modes supporting on the Mongo cluster. */
@added(Versions.v2025_04_01_preview)
union AuthenticationMode {
  string,

  /** Native mongo authentication mode using username and password with auth mechanism 'SCRAM-SHA-256'. */
  "NativeAuth",

  /** Microsoft Entra ID authentication mode using Entra users assigned to the cluster and auth mechanism 'MONGODB-OIDC'. */
  "MicrosoftEntraID",
}

/** The type of identity for key encryption key. */
@added(Versions.v2025_07_01_preview)
union KeyEncryptionKeyIdentityType {
  string,

  /** User assigned identity. */
  UserAssignedIdentity: "UserAssignedIdentity",
}

/** The encryption configuration for the mongo cluster. */
@added(Versions.v2025_07_01_preview)
model EncryptionProperties {
  /** Customer managed key encryption settings. */
  customerManagedKeyEncryption?: CustomerManagedKeyEncryptionProperties;
}

/** Customer managed key encryption settings. */
@added(Versions.v2025_07_01_preview)
model CustomerManagedKeyEncryptionProperties {
  /** The identity used to access the key encryption key. */
  keyEncryptionKeyIdentity: KeyEncryptionKeyIdentity;

  /** The URI of the key vault key used for encryption. */
  keyEncryptionKeyUrl: string;
}

/** The identity used for key encryption key. */
@added(Versions.v2025_07_01_preview)
model KeyEncryptionKeyIdentity {
  /** The type of identity. Only 'UserAssignedIdentity' is supported. */
  identityType: KeyEncryptionKeyIdentityType;

  /** The user assigned identity resource id. */
  userAssignedIdentityResourceId: string;
}
