import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DocumentDB;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum CreateMode {
  Default,
  PointInTimeRestore,
}

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  InProgress,
  Updating,
  Dropping,
}

enum MongoClusterStatus {
  Ready,
  Provisioning,
  Updating,
  Starting,
  Stopping,
  Stopped,
  Dropping,
}

enum NodeKind {
  Shard,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum CheckNameAvailabilityReason {
  Invalid,
  AlreadyExists,
}

@doc("The properties of a mongo cluster.")
model MongoClusterProperties {
  @doc("The mode to create a mongo cluster.")
  @visibility("create")
  createMode?: CreateMode;

  @doc("Parameters used for restore operations")
  @visibility("create")
  restoreParameters?: MongoClusterRestoreParameters;

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

  @doc("A provisioning state of the mongo cluster.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A status of the mongo cluster.")
  @visibility("read")
  clusterStatus?: MongoClusterStatus;

  @doc("The list of node group specs in the cluster.")
  nodeGroupSpecs?: NodeGroupSpec[];
}

@doc("Parameters used for restore operations")
model MongoClusterRestoreParameters {
  @doc("UTC point in time to restore a mongo cluster")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pointInTimeUTC?: utcDateTime;

  @doc("Resource ID to locate the source cluster to restore")
  sourceResourceId?: string;
}

@doc("Specification for a node group.")
model NodeGroupSpec {
  ...NodeGroupProperties;

  @doc("The node type deployed in the node group.")
  kind?: NodeKind;

  @doc("The number of nodes in the node group.")
  nodeCount?: int32;
}

@doc("The properties of the node group on a cluster.")
model NodeGroupProperties {
  @doc("The resource sku for the node group. This defines the size of CPU and memory that is provisioned for each node. Example values: 'M30', 'M40'.")
  sku?: string;

  @doc("The disk storage size for the node group in GB. Example values: 128, 256, 512, 1024.")
  diskSizeGB?: int32;

  @doc("Whether high availability is enabled on the node group.")
  enableHa?: boolean;
}

@doc("The properties of a mongo cluster firewall rule.")
model FirewallRuleProperties {
  @doc("The provisioning state of the firewall rule.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The start IP address of the mongo cluster firewall rule. Must be IPv4 format.")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  startIpAddress: string;

  @doc("The end IP address of the mongo cluster firewall rule. Must be IPv4 format.")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  endIpAddress: string;
}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is available.")
  message?: string;
}

@doc("The connection strings for the given mongo cluster.")
model ListConnectionStringsResult {
  @doc("An array that contains the connection strings for a mongo cluster.")
  @visibility("read")
  connectionStrings?: ConnectionString[];
}

@doc("Connection string for the mongo cluster")
model ConnectionString {
  @doc("Value of the connection string")
  @visibility("read")
  connectionString?: string;

  @doc("Description of the connection string")
  @visibility("read")
  description?: string;
}
