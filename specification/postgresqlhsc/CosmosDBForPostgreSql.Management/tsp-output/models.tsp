import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DBforPostgreSQL;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

/**
 * The role of a server.
 */
enum ServerRole {
  Coordinator,
  Worker,
}

/**
 * Data type of the configuration.
 */
enum ConfigurationDataType {
  Boolean,
  Numeric,
  Integer,
  Enumeration,
}

/**
 * The current provisioning state.
 */
enum ProvisioningState {
  Succeeded,
  Canceled,
  InProgress,
  Failed,
}

/**
 * The intended executor of the operation.
 */
enum OperationOrigin {
  NotSpecified,
  user,
  system,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * Properties of the cluster.
 */
model ClusterProperties {
  /**
   * The administrator's login name of the servers in the cluster.
   */
  @visibility("read")
  administratorLogin?: string;

  /**
   * The password of the administrator login. Required for creation.
   */
  @visibility("create", "update")
  @secret
  administratorLoginPassword?: string;

  /**
   * Provisioning state of the cluster
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * A state of a cluster/server that is visible to user.
   */
  @visibility("read")
  state?: string;

  /**
   * The major PostgreSQL version on all cluster servers.
   */
  postgresqlVersion?: string;

  /**
   * The Citus extension version on all cluster servers.
   */
  citusVersion?: string;

  /**
   * Maintenance window of a cluster.
   */
  maintenanceWindow?: MaintenanceWindow;

  /**
   * Preferred primary availability zone (AZ) for all cluster servers.
   */
  preferredPrimaryZone?: string;

  /**
   * If distributed tables are placed on coordinator or not. Should be set to 'true' on single node clusters. Requires shard rebalancing after value is changed.
   */
  enableShardsOnCoordinator?: boolean;

  /**
   * If high availability (HA) is enabled or not for the cluster.
   */
  enableHa?: boolean;

  /**
   * The edition of a coordinator server (default: GeneralPurpose). Required for creation.
   */
  coordinatorServerEdition?: string;

  /**
   * The storage of a server in MB. Required for creation. See https://learn.microsoft.com/azure/cosmos-db/postgresql/resources-compute for more information.
   */
  coordinatorStorageQuotaInMb?: int32;

  /**
   * The vCores count of a server (max: 96). Required for creation. See https://learn.microsoft.com/azure/cosmos-db/postgresql/resources-compute for more information.
   */
  coordinatorVCores?: int32;

  /**
   * If public access is enabled on coordinator.
   */
  coordinatorEnablePublicIpAccess?: boolean;

  /**
   * The edition of a node server (default: MemoryOptimized).
   */
  nodeServerEdition?: string;

  /**
   * Worker node count of the cluster. When node count is 0, it represents a single node configuration with the ability to create distributed tables on that node. 2 or more worker nodes represent multi-node configuration. Node count value cannot be 1. Required for creation.
   */
  nodeCount?: int32;

  /**
   * The storage in MB on each worker node. See https://learn.microsoft.com/azure/cosmos-db/postgresql/resources-compute for more information.
   */
  nodeStorageQuotaInMb?: int32;

  /**
   * The compute in vCores on each worker node (max: 104). See https://learn.microsoft.com/azure/cosmos-db/postgresql/resources-compute for more information.
   */
  nodeVCores?: int32;

  /**
   * If public access is enabled on worker nodes.
   */
  nodeEnablePublicIpAccess?: boolean;

  /**
   * The list of server names in the cluster
   */
  @visibility("read")
  serverNames?: ServerNameItem[];

  /**
   * The resource id of source cluster for read replica clusters.
   */
  sourceResourceId?: string;

  /**
   * The Azure region of source cluster for read replica clusters.
   */
  sourceLocation?: string;

  /**
   * Date and time in UTC (ISO8601 format) for cluster restore.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pointInTimeUTC?: utcDateTime;

  /**
   * The array of read replica clusters.
   */
  @visibility("read")
  readReplicas?: string[];

  /**
   * The earliest restore point time (ISO8601 format) for the cluster.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreTime?: utcDateTime;

  /**
   * The private endpoint connections for a cluster.
   */
  @visibility("read")
  privateEndpointConnections?: SimplePrivateEndpointConnection[];
}

/**
 * Schedule settings for regular cluster updates.
 */
model MaintenanceWindow {
  /**
   * Indicates whether custom maintenance window is enabled or not.
   */
  customWindow?: string;

  /**
   * Start hour within preferred day of the week for maintenance window.
   */
  startHour?: int32;

  /**
   * Start minute within the start hour for maintenance window.
   */
  startMinute?: int32;

  /**
   * Preferred day of the week for maintenance window.
   */
  dayOfWeek?: int32;
}

/**
 * The name object for a server.
 */
model ServerNameItem {
  /**
   * The name of a server.
   */
  name?: string;

  /**
   * The fully qualified domain name of a server.
   */
  @visibility("read")
  fullyQualifiedDomainName?: string;
}

/**
 * A private endpoint connection.
 */
model SimplePrivateEndpointConnection extends ProxyResource {
  /**
   * Properties of the private endpoint connection.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateEndpointConnectionSimpleProperties;
}

/**
 * The properties in private endpoint connection
 */
model PrivateEndpointConnectionSimpleProperties {
  /**
   * Private endpoint which the connection belongs to.
   */
  privateEndpoint?: PrivateEndpointProperty;

  /**
   * Group ids of the private endpoint connection.
   */
  groupIds?: string[];

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

/**
 * Property to represent resource id of the private endpoint.
 */
model PrivateEndpointProperty {
  /**
   * Resource id of the private endpoint.
   */
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Represents a cluster for update.
 */
model ClusterForUpdate {
  /**
   * Properties of the cluster.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterPropertiesForUpdate;

  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;
}

/**
 * The properties used to update a cluster.
 */
model ClusterPropertiesForUpdate {
  /**
   * The password of the administrator login. Each cluster is created with pre-defined administrative role called ‘citus’.
   */
  @visibility("create", "update")
  @secret
  administratorLoginPassword?: string;

  /**
   * The major PostgreSQL version on all cluster servers.
   */
  postgresqlVersion?: string;

  /**
   * The Citus extension version on all cluster servers.
   */
  citusVersion?: string;

  /**
   * If distributed tables are placed on coordinator or not. Should be set to 'true' on single node clusters. Requires shard rebalancing after value is changed.
   */
  enableShardsOnCoordinator?: boolean;

  /**
   * If high availability (HA) is enabled or not for the cluster.
   */
  enableHa?: boolean;

  /**
   * Preferred primary availability zone (AZ) for all cluster servers.
   */
  preferredPrimaryZone?: string;

  /**
   * The edition of the coordinator (default: GeneralPurpose).
   */
  coordinatorServerEdition?: string;

  /**
   * The storage of the coordinator in MB.
   */
  coordinatorStorageQuotaInMb?: int32;

  /**
   * The vCores count of the coordinator (max: 96).
   */
  coordinatorVCores?: int32;

  /**
   * If public access is enabled on coordinator.
   */
  coordinatorEnablePublicIpAccess?: boolean;

  /**
   * The edition of a node (default: MemoryOptimized).
   */
  nodeServerEdition?: string;

  /**
   * Worker node count of the cluster. When node count is 0, it represents a single node configuration with the ability to create distributed tables on that node. 2 or more worker nodes represent multi-node configuration. Node count value cannot be 1.
   */
  nodeCount?: int32;

  /**
   * The storage in MB on each worker node.
   */
  nodeStorageQuotaInMb?: int32;

  /**
   * The compute in vCores on each worker node (max: 104).
   */
  nodeVCores?: int32;

  /**
   * If public access is enabled on worker nodes.
   */
  @visibility("read")
  nodeEnablePublicIpAccess?: boolean;

  /**
   * Maintenance window of a cluster.
   */
  maintenanceWindow?: MaintenanceWindow;
}

/**
 * The properties of a server in cluster.
 */
model ClusterServerProperties extends ServerProperties {
  /**
   * The fully qualified domain name of a server.
   */
  @visibility("read")
  fullyQualifiedDomainName?: string;

  /**
   * The role of server in the cluster.
   */
  role?: ServerRole;

  /**
   * A state of a cluster/server that is visible to user.
   */
  @visibility("read")
  state?: string;

  /**
   * A state of HA feature for the cluster.
   */
  @visibility("read")
  haState?: string;

  /**
   * Availability Zone information of the server.
   */
  availabilityZone?: string;

  /**
   * The major PostgreSQL version of server.
   */
  postgresqlVersion?: string;

  /**
   * The Citus extension version of server.
   */
  citusVersion?: string;
}

/**
 * The properties of a server.
 */
model ServerProperties {
  /**
   * The edition of a server.
   */
  serverEdition?: string;

  /**
   * The storage of a server in MB.
   */
  storageQuotaInMb?: int32;

  /**
   * The vCores count of a server.
   */
  vCores?: int32;

  /**
   * If high availability (HA) is enabled or not for the server.
   */
  enableHa?: boolean;

  /**
   * If public access is enabled on server.
   */
  @visibility("read")
  enablePublicIpAccess?: boolean;

  /**
   * If server database is set to read-only by system maintenance depending on high disk space usage.
   */
  @visibility("read")
  isReadOnly?: boolean;

  /**
   * The administrator's login name of the servers in the cluster.
   */
  @visibility("read")
  administratorLogin?: string;
}

/**
 * A list of server configurations.
 */
model ServerConfigurationListResult is Azure.Core.Page<ServerConfiguration>;

/**
 * The properties of a configuration.
 */
model ServerConfigurationProperties {
  /**
   * Value of the configuration.
   */
  value: string;

  /**
   * Source of the configuration.
   */
  @visibility("read")
  source?: string;

  /**
   * Description of the configuration.
   */
  @visibility("read")
  description?: string;

  /**
   * Default value of the configuration.
   */
  @visibility("read")
  defaultValue?: string;

  /**
   * Data type of the configuration.
   */
  @visibility("read")
  dataType?: ConfigurationDataType;

  /**
   * Allowed values of the configuration.
   */
  @visibility("read")
  allowedValues?: string;

  /**
   * If configuration change requires restart.
   */
  @visibility("read")
  requiresRestart?: boolean;

  /**
   * Provisioning state of the configuration.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The properties of configuration.
 */
model ConfigurationProperties {
  /**
   * Description of the configuration.
   */
  @visibility("read")
  description?: string;

  /**
   * Data type of the configuration.
   */
  @visibility("read")
  dataType?: ConfigurationDataType;

  /**
   * Allowed values of the configuration.
   */
  @visibility("read")
  allowedValues?: string;

  /**
   * If configuration change requires restart.
   */
  requiresRestart?: boolean;

  /**
   * The list of server role group configuration values.
   */
  serverRoleGroupConfigurations: ServerRoleGroupConfiguration[];

  /**
   * Provisioning state of the configuration
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Represents server role group configuration value.
 */
model ServerRoleGroupConfiguration {
  /**
   * The role of servers in the server role group.
   */
  role: ServerRole;

  /**
   * Value of the configuration.
   */
  value: string;

  /**
   * Default value of the configuration.
   */
  @visibility("read")
  defaultValue?: string;

  /**
   * Source of the configuration.
   */
  @visibility("read")
  source?: string;
}

/**
 * The properties of a cluster firewall rule.
 */
model FirewallRuleProperties {
  /**
   * The start IP address of the cluster firewall rule. Must be IPv4 format.
   */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  startIpAddress: string;

  /**
   * The end IP address of the cluster firewall rule. Must be IPv4 format.
   */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  endIpAddress: string;

  /**
   * Provisioning state of the firewall rule.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The properties of a cluster role.
 */
model RoleProperties {
  /**
   * The password of the cluster role.
   */
  @visibility("create", "update")
  @secret
  password: string;

  /**
   * Provisioning state of the role
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Request from client to check cluster name availability.
 */
model NameAvailabilityRequest {
  /**
   * Cluster name to verify.
   */
  name: string;

  /**
   * Resource type used for verification.
   */
  type: "Microsoft.DBforPostgreSQL/serverGroupsv2";
}

/**
 * Represents cluster name availability.
 */
model NameAvailability {
  /**
   * Error message.
   */
  message?: string;

  /**
   * Indicates whether the cluster name is available.
   */
  nameAvailable?: boolean;

  /**
   * Name of the cluster.
   */
  name?: string;

  /**
   * Type of the cluster.
   */
  type?: string;
}

/**
 * Properties of the private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The group ids for the private endpoint resource.
   */
  @visibility("read")
  groupIds?: string[];

  /**
   * The private endpoint resource.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The private endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for private endpoint.
   */
  @visibility("read")
  id?: string;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource private link DNS zone name.
   */
  requiredZoneNames?: string[];
}
