import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./common.tsp";
import "./service.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.Private;
using Azure.ClientGenerator.Core;

namespace Microsoft.DocumentDB;
@doc("Represents a mongo cluster resource.")
model MongoCluster is TrackedResource<MongoClusterProperties> {
  @doc("The name of the mongo cluster.")
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
  @doc("Gets information about a mongo cluster.")
  get is ArmResourceRead<MongoCluster>;
  @doc("Create or update a mongo cluster. Update overwrites all properties for the resource. To only modify some of the properties, use PATCH.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MongoCluster>;
  @doc("Updates an existing mongo cluster. The request body can contain one to many of the properties present in the normal mongo cluster definition.")
  update is ArmResourcePatchAsync<MongoCluster, MongoClusterProperties>;
  @doc("Deletes a mongo cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<MongoCluster>;
  @doc("List all the mongo clusters in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<MongoCluster>;
  @doc("List all the mongo clusters in a given subscription.")
  list is ArmListBySubscription<MongoCluster>;
  @doc("List mongo cluster connection strings. This includes the default connection string using SCRAM-SHA-256, as well as other connection strings supported by the cluster.")
  listConnectionStrings is ArmResourceActionSync<
    MongoCluster,
    void,
    ListConnectionStringsResult
  >;
  @doc("Check if mongo cluster name is available for use.")
  @action("checkMongoClusterNameAvailability")
  checkNameAvailability is checkLocalNameAvailability;
}

@doc("The properties of a mongo cluster.")
model MongoClusterProperties {
  @doc("The mode to create a mongo cluster.")
  @visibility("create")
  createMode?: CreateMode;

  @doc("The parameters to create a point-in-time restore mongo cluster.")
  @visibility("create")
  restoreParameters?: MongoClusterRestoreParameters;

  @doc("The parameters to create a replica mongo cluster.")
  @visibility("create")
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  replicaParameters?: MongoClusterReplicaParameters;

  @doc("The administrator's login for the mongo cluster.")
  @visibility("read", "create", "update")
  administratorLogin?: string;

  @doc("The password of the administrator login.")
  @visibility("create", "update")
  @secret
  administratorLoginPassword?: string;

  @doc("The Mongo DB server version. Defaults to the latest available version if not specified.")
  serverVersion?: string;

  @doc("The default mongo connection string for the cluster.")
  @visibility("read")
  connectionString?: string;

  @doc("Earliest restore timestamp in UTC ISO8601 format.")
  @visibility("read")
  earliestRestoreTime?: string;

  @doc("The provisioning state of the mongo cluster.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The status of the mongo cluster.")
  @visibility("read")
  clusterStatus?: MongoClusterStatus;

  @doc("Whether or not public endpoint access is allowed for this mongo cluster.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The list of node group specs in the cluster.")
  @extension("x-ms-identifiers", [])
  nodeGroupSpecs?: NodeGroupSpec[];

  @doc("List of private endpoint connections.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("List of private endpoint connections.")
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  previewFeatures?: PreviewFeature[];

  @doc("The replication properties for the mongo cluster")
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  @visibility("read")
  replica?: ReplicationProperties;
}

@doc("The mode that the Mongo Cluster is created with.")
union CreateMode {
  string,

  @doc("Create a new mongo cluster.")
  "Default",

  @doc("Create a mongo cluster from a restore point-in-time.")
  "PointInTimeRestore",

  @doc("Create a replica cluster in distinct geographic region from the source cluster.")
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  "GeoReplica",

  @doc("Create a replica cluster in the same geographic region as the source cluster.")
  @added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
  "Replica"
}

@doc("The kind of the node on the cluster.")
union NodeKind {
  string,

  @doc("The node is a shard kind.")
  "Shard",
}

@doc("Parameters used for restore operations")
model MongoClusterRestoreParameters {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Capitialized acronym in the property name."
  @doc("UTC point in time to restore a mongo cluster")
  pointInTimeUTC?: utcDateTime;

  @doc("Resource ID to locate the source cluster to restore")
  sourceResourceId?: string;
}

@doc("Specification for a node group.")
model NodeGroupSpec is NodeGroupProperties {
  @doc("The node type deployed in the node group.")
  kind?: NodeKind;

  @doc("The number of nodes in the node group.")
  nodeCount?: int32;
}

@doc("The properties of the node group on a cluster.")
model NodeGroupProperties {
  @doc("The resource sku for the node group. This defines the size of CPU and memory that is provisioned for each node. Example values: 'M30', 'M40'.")
  sku?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Capitialized acronym in the property name."
  @doc("The disk storage size for the node group in GB. Example values: 128, 256, 512, 1024.")
  diskSizeGB?: int64;

  @doc("Whether high availability is enabled on the node group.")
  enableHa?: boolean;
}

@doc("The connection strings for the given mongo cluster.")
model ListConnectionStringsResult {
  @doc("An array that contains the connection strings for a mongo cluster.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  connectionStrings?: ConnectionString[];
}

@doc("Connection string for the mongo cluster")
model ConnectionString {
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" "https://github.com/Azure/typespec-azure/issues/417"
  @doc("Value of the connection string")
  @visibility("read")
  @clientName("uri", "csharp")
  connectionString?: string;

  @doc("Description of the connection string")
  @visibility("read")
  description?: string;
}

@doc("The status of the Mongo cluster resource.")
union MongoClusterStatus {
  string,

  @doc("The mongo cluster resource is ready for use.")
  "Ready",

  @doc("The mongo cluster resource is being provisioned.")
  "Provisioning",

  @doc("The mongo cluster resource is being updated.")
  "Updating",

  @doc("The mongo cluster resource is being started.")
  "Starting",

  @doc("The mongo cluster resource is being stopped.")
  "Stopping",

  @doc("The mongo cluster resource is stopped.")
  "Stopped",

  @doc("The mongo cluster resource is being dropped.")
  "Dropping",
}

@doc("Whether or not public endpoint access is allowed for this Mongo cluster.  Value is optional and default value is 'Enabled'")
union PublicNetworkAccess {
  string,

  @doc("If set, mongo cluster can be accessed through private and public methods.")
  "Enabled",

  @doc("If set, the private endpoints are the exclusive access method.")
  "Disabled",
}

@doc("Preview features that can be enabled on a mongo cluster.")
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
union PreviewFeature {
  string,
}

@doc("Parameters used for replica operations.")
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
model MongoClusterReplicaParameters {
  @doc("The id of the replication source cluster.")
  sourceResourceId: string;

  @doc("Description of the connection string")
  location: string;
}

@doc("Replica properties of the mongo cluster.")
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
model ReplicationProperties {
  @doc("The resource id the source cluster for the replica cluster.")
  @visibility("read")
  sourceResourceId?: string;

  @doc("The replication role of the cluster.")
  @visibility("read")
  role?: ReplicationRole;

  @doc("The replication link state of the replica cluster.")
  @visibility("read")
  state?: ReplicationState;
}

@doc("Replication role of the mongo cluster.")
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
union ReplicationRole {
  string,

  @doc("The cluster is a primary replica.")
  "Primary",

  @doc("The cluster is a local asynchronous replica.")
  "AsyncReplica",

  @doc("The cluster is a geo-asynchronous replica.")
  "GeoAsyncReplica",
}

@doc("The state of the replication link between the replica and source cluster.")
@added(Microsoft.DocumentDB.Versions.v2024_06_01_preview)
union ReplicationState {
  string,

  @doc("Replication link is active.")
  "Active",

  @doc("Replication link is catching-up.")
  "Catchup",

  @doc("Replication link is provisioning.")
  "Provisioning",

  @doc("Replication link is updating.")
  "Updating",

  @doc("Replication link is broken.")
  "Broken",

  @doc("Replication link is re-configuring.")
  "Reconfiguring"
}
