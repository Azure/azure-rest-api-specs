import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DBforPostgreSQL;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The private endpoint connection status.")
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

@doc("The role of a server.")
enum ServerRole {
  Coordinator,
  Worker,
}

@doc("Data type of the configuration.")
enum ConfigurationDataType {
  Boolean,
  Numeric,
  Integer,
  Enumeration,
}

@doc("The current provisioning state.")
enum ProvisioningState {
  Succeeded,
  Canceled,
  InProgress,
  Failed,
}

@doc("The intended executor of the operation.")
enum OperationOrigin {
  NotSpecified,
  user,
  system,
}

@doc("The current provisioning state.")
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

@doc("Properties of the cluster.")
model ClusterProperties {
  @doc("The administrator's login name of the servers in the cluster.")
  @visibility("read")
  administratorLogin?: string;

  @doc("The password of the administrator login. Required for creation.")
  @visibility("create", "update")
  @secret
  administratorLoginPassword?: string;

  @doc("Provisioning state of the cluster")
  @visibility("read")
  provisioningState?: string;

  @doc("A state of a cluster/server that is visible to user.")
  @visibility("read")
  state?: string;

  @doc("The major PostgreSQL version on all cluster servers.")
  postgresqlVersion?: string;

  @doc("The Citus extension version on all cluster servers.")
  citusVersion?: string;

  @doc("Maintenance window of a cluster.")
  maintenanceWindow?: MaintenanceWindow;

  @doc("Preferred primary availability zone (AZ) for all cluster servers.")
  preferredPrimaryZone?: string;

  @doc("If distributed tables are placed on coordinator or not. Should be set to 'true' on single node clusters. Requires shard rebalancing after value is changed.")
  enableShardsOnCoordinator?: boolean;

  @doc("If high availability (HA) is enabled or not for the cluster.")
  enableHa?: boolean;

  @doc("The edition of a coordinator server (default: GeneralPurpose). Required for creation.")
  coordinatorServerEdition?: string;

  @doc("The storage of a server in MB. Required for creation. See https://learn.microsoft.com/azure/cosmos-db/postgresql/resources-compute for more information.")
  coordinatorStorageQuotaInMb?: int32;

  @doc("The vCores count of a server (max: 96). Required for creation. See https://learn.microsoft.com/azure/cosmos-db/postgresql/resources-compute for more information.")
  coordinatorVCores?: int32;

  @doc("If public access is enabled on coordinator.")
  coordinatorEnablePublicIpAccess?: boolean;

  @doc("The edition of a node server (default: MemoryOptimized).")
  nodeServerEdition?: string;

  @doc("Worker node count of the cluster. When node count is 0, it represents a single node configuration with the ability to create distributed tables on that node. 2 or more worker nodes represent multi-node configuration. Node count value cannot be 1. Required for creation.")
  nodeCount?: int32;

  @doc("The storage in MB on each worker node. See https://learn.microsoft.com/azure/cosmos-db/postgresql/resources-compute for more information.")
  nodeStorageQuotaInMb?: int32;

  @doc("The compute in vCores on each worker node (max: 104). See https://learn.microsoft.com/azure/cosmos-db/postgresql/resources-compute for more information.")
  nodeVCores?: int32;

  @doc("If public access is enabled on worker nodes.")
  nodeEnablePublicIpAccess?: boolean;

  @doc("The list of server names in the cluster")
  @visibility("read")
  serverNames?: ServerNameItem[];

  @doc("The resource id of source cluster for read replica clusters.")
  sourceResourceId?: string;

  @doc("The Azure region of source cluster for read replica clusters.")
  sourceLocation?: string;

  @doc("Date and time in UTC (ISO8601 format) for cluster restore.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pointInTimeUTC?: utcDateTime;

  @doc("The array of read replica clusters.")
  @visibility("read")
  readReplicas?: string[];

  @doc("The earliest restore point time (ISO8601 format) for the cluster.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreTime?: utcDateTime;

  @doc("The private endpoint connections for a cluster.")
  @visibility("read")
  privateEndpointConnections?: SimplePrivateEndpointConnection[];
}

@doc("Schedule settings for regular cluster updates.")
model MaintenanceWindow {
  @doc("Indicates whether custom maintenance window is enabled or not.")
  customWindow?: string;

  @doc("Start hour within preferred day of the week for maintenance window.")
  startHour?: int32;

  @doc("Start minute within the start hour for maintenance window.")
  startMinute?: int32;

  @doc("Preferred day of the week for maintenance window.")
  dayOfWeek?: int32;
}

@doc("The name object for a server.")
model ServerNameItem {
  @doc("The name of a server.")
  name?: string;

  @doc("The fully qualified domain name of a server.")
  @visibility("read")
  fullyQualifiedDomainName?: string;
}

@doc("A private endpoint connection.")
model SimplePrivateEndpointConnection extends ProxyResource {
  @doc("Properties of the private endpoint connection.")
  properties?: PrivateEndpointConnectionSimpleProperties;
}

@doc("The properties in private endpoint connection")
model PrivateEndpointConnectionSimpleProperties {
  @doc("Private endpoint which the connection belongs to.")
  privateEndpoint?: PrivateEndpointProperty;

  @doc("Group ids of the private endpoint connection.")
  groupIds?: string[];

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

@doc("Property to represent resource id of the private endpoint.")
model PrivateEndpointProperty {
  @doc("Resource id of the private endpoint.")
  id?: string;
}

@doc("A collection of information about the state of the connection between service consumer and provider.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  @visibility("read")
  id?: ResourceIdentifier;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Represents a cluster for update.")
model ClusterForUpdate {
  @doc("Properties of the cluster.")
  properties?: ClusterPropertiesForUpdate;

  @doc("Application-specific metadata in the form of key-value pairs.")
  tags?: Record<string>;
}

@doc("The properties used to update a cluster.")
model ClusterPropertiesForUpdate {
  @doc("The password of the administrator login. Each cluster is created with pre-defined administrative role called ‘citus’. ")
  @visibility("create", "update")
  @secret
  administratorLoginPassword?: string;

  @doc("The major PostgreSQL version on all cluster servers.")
  postgresqlVersion?: string;

  @doc("The Citus extension version on all cluster servers.")
  citusVersion?: string;

  @doc("If distributed tables are placed on coordinator or not. Should be set to 'true' on single node clusters. Requires shard rebalancing after value is changed.")
  enableShardsOnCoordinator?: boolean;

  @doc("If high availability (HA) is enabled or not for the cluster.")
  enableHa?: boolean;

  @doc("Preferred primary availability zone (AZ) for all cluster servers.")
  preferredPrimaryZone?: string;

  @doc("The edition of the coordinator (default: GeneralPurpose).")
  coordinatorServerEdition?: string;

  @doc("The storage of the coordinator in MB.")
  coordinatorStorageQuotaInMb?: int32;

  @doc("The vCores count of the coordinator (max: 96).")
  coordinatorVCores?: int32;

  @doc("If public access is enabled on coordinator.")
  coordinatorEnablePublicIpAccess?: boolean;

  @doc("The edition of a node (default: MemoryOptimized).")
  nodeServerEdition?: string;

  @doc("Worker node count of the cluster. When node count is 0, it represents a single node configuration with the ability to create distributed tables on that node. 2 or more worker nodes represent multi-node configuration. Node count value cannot be 1.")
  nodeCount?: int32;

  @doc("The storage in MB on each worker node.")
  nodeStorageQuotaInMb?: int32;

  @doc("The compute in vCores on each worker node (max: 104).")
  nodeVCores?: int32;

  @doc("If public access is enabled on worker nodes.")
  @visibility("read")
  nodeEnablePublicIpAccess?: boolean;

  @doc("Maintenance window of a cluster.")
  maintenanceWindow?: MaintenanceWindow;
}

@doc("The properties of a server in cluster.")
model ClusterServerProperties extends ServerProperties {
  @doc("The fully qualified domain name of a server.")
  @visibility("read")
  fullyQualifiedDomainName?: string;

  @doc("The role of server in the cluster.")
  role?: ServerRole;

  @doc("A state of a cluster/server that is visible to user.")
  @visibility("read")
  state?: string;

  @doc("A state of HA feature for the cluster.")
  @visibility("read")
  haState?: string;

  @doc("Availability Zone information of the server.")
  availabilityZone?: string;

  @doc("The major PostgreSQL version of server.")
  postgresqlVersion?: string;

  @doc("The Citus extension version of server.")
  citusVersion?: string;
}

@doc("The properties of a server.")
model ServerProperties {
  @doc("The edition of a server.")
  serverEdition?: string;

  @doc("The storage of a server in MB.")
  storageQuotaInMb?: int32;

  @doc("The vCores count of a server.")
  vCores?: int32;

  @doc("If high availability (HA) is enabled or not for the server.")
  enableHa?: boolean;

  @doc("If public access is enabled on server.")
  @visibility("read")
  enablePublicIpAccess?: boolean;

  @doc("If server database is set to read-only by system maintenance depending on high disk space usage.")
  @visibility("read")
  isReadOnly?: boolean;

  @doc("The administrator's login name of the servers in the cluster.")
  @visibility("read")
  administratorLogin?: string;
}

@doc("A list of server configurations.")
model ServerConfigurationListResult is Azure.Core.Page<ServerConfiguration>;

@doc("The properties of a configuration.")
model ServerConfigurationProperties {
  @doc("Value of the configuration.")
  value: string;

  @doc("Source of the configuration.")
  @visibility("read")
  source?: string;

  @doc("Description of the configuration.")
  @visibility("read")
  description?: string;

  @doc("Default value of the configuration.")
  @visibility("read")
  defaultValue?: string;

  @doc("Data type of the configuration.")
  @visibility("read")
  dataType?: ConfigurationDataType;

  @doc("Allowed values of the configuration.")
  @visibility("read")
  allowedValues?: string;

  @doc("If configuration change requires restart.")
  @visibility("read")
  requiresRestart?: boolean;

  @doc("Provisioning state of the configuration.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The properties of configuration.")
model ConfigurationProperties {
  @doc("Description of the configuration.")
  @visibility("read")
  description?: string;

  @doc("Data type of the configuration.")
  @visibility("read")
  dataType?: ConfigurationDataType;

  @doc("Allowed values of the configuration.")
  @visibility("read")
  allowedValues?: string;

  @doc("If configuration change requires restart.")
  requiresRestart?: boolean;

  @doc("The list of server role group configuration values.")
  serverRoleGroupConfigurations: ServerRoleGroupConfiguration[];

  @doc("Provisioning state of the configuration")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Represents server role group configuration value.")
model ServerRoleGroupConfiguration {
  @doc("The role of servers in the server role group.")
  role: ServerRole;

  @doc("Value of the configuration.")
  value: string;

  @doc("Default value of the configuration.")
  @visibility("read")
  defaultValue?: string;

  @doc("Source of the configuration.")
  @visibility("read")
  source?: string;
}

@doc("The properties of a cluster firewall rule.")
model FirewallRuleProperties {
  @doc("The start IP address of the cluster firewall rule. Must be IPv4 format.")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  startIpAddress: string;

  @doc("The end IP address of the cluster firewall rule. Must be IPv4 format.")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  endIpAddress: string;

  @doc("Provisioning state of the firewall rule.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The properties of a cluster role.")
model RoleProperties {
  @doc("The password of the cluster role.")
  @visibility("create", "update")
  @secret
  password: string;

  @doc("Provisioning state of the role")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Request from client to check cluster name availability.")
model NameAvailabilityRequest {
  @doc("Cluster name to verify.")
  name: string;

  @doc("Resource type used for verification.")
  type: "Microsoft.DBforPostgreSQL/serverGroupsv2";
}

@doc("Represents cluster name availability.")
model NameAvailability {
  @doc("Error message.")
  message?: string;

  @doc("Indicates whether the cluster name is available.")
  nameAvailable?: boolean;

  @doc("Name of the cluster.")
  name?: string;

  @doc("Type of the cluster.")
  type?: string;
}

@doc("Properties of the private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("The group ids for the private endpoint resource.")
  @visibility("read")
  groupIds?: string[];

  @doc("The private endpoint resource.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The private endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for private endpoint.")
  @visibility("read")
  id?: string;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource private link DNS zone name.")
  requiredZoneNames?: string[];
}
