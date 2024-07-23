import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
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
}

/** The properties of a mongo cluster. */
model MongoClusterProperties {
  /** The mode to create a mongo cluster. */
  @visibility("create")
  createMode?: CreateMode;

  /** The parameters to create a point-in-time restore mongo cluster. */
  @visibility("create")
  restoreParameters?: MongoClusterRestoreParameters;

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
}

/** The mode that the Mongo Cluster is created with. */
union CreateMode {
  string,

  /** Create a new mongo cluster. */
  "Default",

  /** Create a mongo cluster from a restore point-in-time. */
  "PointInTimeRestore",
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
  sourceResourceId?: string;
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
