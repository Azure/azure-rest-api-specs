import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internal: "Internal",
}

/**
 * Indicates whether the cluster was created using AAD authentication.
 */
union AadEnabledEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  disabled: "disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DataEncryptionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureKeyVault: "AzureKeyVault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
}

/**
 * Indicates whether the cluster was created with a password or using AAD authentication.
 */
union PasswordEnabledEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  disabled: "disabled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ActiveDirectoryAuth {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  disabled: "disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union PasswordAuth {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  disabled: "disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
}

/**
 * Data type of the configuration.
 */
union ConfigurationDataType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Boolean: "Boolean",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Numeric: "Numeric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Integer: "Integer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enumeration: "Enumeration",
}

/**
 * The role of a server.
 */
union ServerRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Coordinator: "Coordinator",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Worker: "Worker",
}

/**
 * The current provisioning state.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union RoleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  admin: "admin",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union PrincipalType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  servicePrincipal: "servicePrincipal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  group: "group",
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
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
  type: CheckNameAvailabilityResourceType;
}

/**
 * Resource type used for name availability verification.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Expect exact one value, as original Swagger defines modelAsString: false"
enum CheckNameAvailabilityResourceType {
  MICROSOFT_DB_FOR_POSTGRESQL_SERVER_GROUPSV2: "Microsoft.DBforPostgreSQL/serverGroupsv2",
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
 * Properties of the cluster.
 */
model ClusterProperties {
  /**
   * Indicates whether the cluster was created using AAD authentication.
   */
  @visibility(Lifecycle.Read)
  aadAuthEnabled?: AadEnabledEnum;

  /**
   * The administrator's login name of the servers in the cluster.
   */
  @visibility(Lifecycle.Read)
  administratorLogin?: string;

  /**
   * The password of the administrator login. Required for creation.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * The data encryption properties of a cluster.
   */
  dataEncryption?: DataEncryption;

  /**
   * Provisioning state of the cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * A state of a cluster/server that is visible to user.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "coordinatorVCores is the original name in the API"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "nodeVCores is the original name in the API"
  nodeVCores?: int32;

  /**
   * If public access is enabled on worker nodes.
   */
  nodeEnablePublicIpAccess?: boolean;

  /**
   * The list of server names in the cluster
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  @uniqueItems
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
   * Indicates whether the cluster was created with a password or using AAD authentication.
   */
  @visibility(Lifecycle.Read)
  passwordEnabled?: PasswordEnabledEnum;

  /**
   * Date and time in UTC (ISO8601 format) for cluster restore.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "pointInTimeUTC is the original name in the API"
  pointInTimeUTC?: utcDateTime;

  /**
   * The array of read replica clusters.
   */
  @visibility(Lifecycle.Read)
  @uniqueItems
  readReplicas?: string[];

  /**
   * The earliest restore point time (ISO8601 format) for the cluster.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreTime?: utcDateTime;

  /**
   * The private endpoint connections for a cluster.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: SimplePrivateEndpointConnection[];

  /**
   * The database name of the cluster. Only one database per cluster is supported.
   */
  databaseName?: string;

  /**
   * If cluster backup is stored in another Azure region in addition to the copy of the backup stored in the cluster's region. Enabled only at the time of cluster creation.
   */
  enableGeoBackup?: boolean;

  /**
   * Authentication configuration of a cluster.
   */
  authConfig?: AuthConfig;
}

/**
 * The data encryption properties of a cluster.
 */
model DataEncryption {
  /**
   * URI for the key in keyvault for data encryption of the primary server.
   */
  primaryKeyUri?: string;

  /**
   * Resource Id for the User assigned identity to be used for data encryption of the primary server.
   */
  primaryUserAssignedIdentityId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  type?: DataEncryptionType;
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
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;
}

/**
 * A private endpoint connection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SimplePrivateEndpointConnection
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Properties of the private endpoint connection.
   */
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
  privateLinkServiceConnectionState?: Azure.ResourceManager.CommonTypes.PrivateLinkServiceConnectionState;
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
 * Authentication configuration of a cluster.
 */
model AuthConfig {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  activeDirectoryAuth?: ActiveDirectoryAuth;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  passwordAuth?: PasswordAuth;
}

/**
 * Describes the identity of the cluster.
 */
model IdentityProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  type?: IdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Represents a cluster for update.
 */
model ClusterForUpdate {
  /**
   * Properties of the cluster.
   */
  properties?: ClusterPropertiesForUpdate;

  /**
   * Describes the identity of the cluster.
   */
  identity?: IdentityProperties;

  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The properties used to update a cluster.
 */
model ClusterPropertiesForUpdate {
  /**
   * The password of the administrator login. Each cluster is created with pre-defined administrative role called ‘citus’.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "coordinatorVCores is the original name in the API"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "nodeVCores is the original name in the API"
  nodeVCores?: int32;

  /**
   * If public access is enabled on worker nodes.
   */
  @visibility(Lifecycle.Read)
  nodeEnablePublicIpAccess?: boolean;

  /**
   * Maintenance window of a cluster.
   */
  maintenanceWindow?: MaintenanceWindow;
}

/**
 * The properties of configuration.
 */
model ConfigurationProperties {
  /**
   * Description of the configuration.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Data type of the configuration.
   */
  @visibility(Lifecycle.Read)
  dataType?: ConfigurationDataType;

  /**
   * Allowed values of the configuration.
   */
  @visibility(Lifecycle.Read)
  allowedValues?: string;

  /**
   * If configuration change requires restart.
   */
  requiresRestart?: boolean;

  /**
   * The list of server role group configuration values.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  @uniqueItems
  serverRoleGroupConfigurations: ServerRoleGroupConfiguration[];

  /**
   * Provisioning state of the configuration
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  defaultValue?: string;

  /**
   * Source of the configuration.
   */
  @visibility(Lifecycle.Read)
  source?: string;
}

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
  @visibility(Lifecycle.Read)
  source?: string;

  /**
   * Description of the configuration.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Default value of the configuration.
   */
  @visibility(Lifecycle.Read)
  defaultValue?: string;

  /**
   * Data type of the configuration.
   */
  @visibility(Lifecycle.Read)
  dataType?: ConfigurationDataType;

  /**
   * Allowed values of the configuration.
   */
  @visibility(Lifecycle.Read)
  allowedValues?: string;

  /**
   * If configuration change requires restart.
   */
  @visibility(Lifecycle.Read)
  requiresRestart?: boolean;

  /**
   * Provisioning state of the configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Request from client to promote geo-redundant replica
 */
model PromoteRequest {
  /**
   * Boolean property to enable geo-redundant replica promotion.
   */
  enableGeoBackup?: boolean;
}

/**
 * The properties of a cluster role.
 */
model RoleProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  roleType?: RoleType = RoleType.user;

  /**
   * The password of the cluster role. If an identity is used, password will not be required.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  password?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  externalIdentity?: RolePropertiesExternalIdentity;

  /**
   * Provisioning state of the role
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RolePropertiesExternalIdentity {
  /**
   * A type definition that refers the id to an Azure Resource Manager resource.
   */
  objectId: Azure.Core.armResourceIdentifier;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  principalType: PrincipalType;

  /**
   * A type definition that refers the id to an Azure Resource Manager resource.
   */
  tenantId?: Azure.Core.armResourceIdentifier;
}

/**
 * The properties of a server in cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ClusterServerProperties extends ServerProperties {
  /**
   * The fully qualified domain name of a server.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  /**
   * The role of server in the cluster.
   */
  role?: ServerRole;

  /**
   * A state of a cluster/server that is visible to user.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * A state of HA feature for the cluster.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  enablePublicIpAccess?: boolean;

  /**
   * If server database is set to read-only by system maintenance depending on high disk space usage.
   */
  @visibility(Lifecycle.Read)
  isReadOnly?: boolean;

  /**
   * The administrator's login name of the servers in the cluster.
   */
  @visibility(Lifecycle.Read)
  administratorLogin?: string;
}
