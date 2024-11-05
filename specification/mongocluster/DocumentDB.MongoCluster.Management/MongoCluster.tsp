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
  @visibility("read")
  @path
  name: string;
}

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
  @visibility("create")
  createMode?: CreateMode;

  /** The parameters to create a point-in-time restore mongo cluster. */
  @visibility("create")
  restoreParameters?: MongoClusterRestoreParameters;

  /** The parameters to create a replica mongo cluster. */
  @visibility("create")
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  replicaParameters?: MongoClusterReplicaParameters;

  /** The administrator's login for the mongo cluster. */
  @visibility("read", "create", "update")
  administratorLogin?: string;

  /** The password of the administrator login. */
  @visibility("create", "update")
  @secret
  administratorLoginPassword?: string;

  /** The Mongo DB server version. Defaults to the latest available version if not specified. */
  serverVersion?: string;

  /** The default mongo connection string for the cluster. */
  @visibility("read")
  connectionString?: string;

  /** Earliest restore timestamp in UTC ISO8601 format. */
  @visibility("read")
  earliestRestoreTime?: string;

  /** The provisioning state of the mongo cluster. */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /** The status of the mongo cluster. */
  @visibility("read")
  clusterStatus?: MongoClusterStatus;

  /** Whether or not public endpoint access is allowed for this mongo cluster. */
  publicNetworkAccess?: PublicNetworkAccess;

  /** The list of node group specs in the cluster. */
  @extension("x-ms-identifiers", [])
  nodeGroupSpecs?: NodeGroupSpec[];

  /** List of private endpoint connections. */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /** List of private endpoint connections. */
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  previewFeatures?: PreviewFeature[];

  /** The replication properties for the mongo cluster */
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  @visibility("read")
  replica?: ReplicationProperties;

  /** The infrastructure version the cluster is provisioned on. */
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  @visibility("read")
  infrastructureVersion?: string;
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

/** The kind of the node on the cluster. */
union NodeKind {
  string,

  /** The node is a shard kind. */
  "Shard",
}

/** Parameters used for restore operations */
model MongoClusterRestoreParameters {
  /** UTC point in time to restore a mongo cluster */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Capitialized acronym in the property name."
  pointInTimeUTC?: utcDateTime;

  /** Resource ID to locate the source cluster to restore */
  @typeChangedFrom(Microsoft.DocumentDB.Versions.v2024_06_01_preview, string)
  sourceResourceId?: MongoClusterResourceId;
}

/** Specification for a node group. */
model NodeGroupSpec is NodeGroupProperties {
  /** The node type deployed in the node group. */
  kind?: NodeKind;

  /** The number of nodes in the node group. */
  nodeCount?: int32;
}

/** The properties of the node group on a cluster. */
model NodeGroupProperties {
  /** The resource sku for the node group. This defines the size of CPU and memory that is provisioned for each node. Example values: 'M30', 'M40'. */
  sku?: string;

  /** The disk storage size for the node group in GB. Example values: 128, 256, 512, 1024. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Capitialized acronym in the property name."
  diskSizeGB?: int64;

  /** Whether high availability is enabled on the node group. */
  enableHa?: boolean;
}

/** The connection strings for the given mongo cluster. */
model ListConnectionStringsResult {
  /** An array that contains the connection strings for a mongo cluster. */
  @visibility("read")
  @extension("x-ms-identifiers", [])
  connectionStrings?: ConnectionString[];
}

/** Connection string for the mongo cluster */
model ConnectionString {
  /** Value of the connection string */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" "https://github.com/Azure/typespec-azure/issues/417"
  @visibility("read")
  @clientName("uri", "csharp")
  connectionString?: string;

  /** Description of the connection string */
  @visibility("read")
  description?: string;
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
  @visibility("read")
  sourceResourceId?: MongoClusterResourceId;

  /** The replication role of the cluster */
  @visibility("read")
  role?: ReplicationRole;

  /** The replication link state of the replica cluster. */
  @visibility("read")
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
