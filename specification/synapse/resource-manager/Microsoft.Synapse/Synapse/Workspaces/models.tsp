import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Workspaces;

/**
 * Enable or Disable public network access to workspace
 */
union WorkspacePublicNetworkAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AzureADOnlyAuthenticationName {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * property configuration state
 */
union StateValue {
  string,

  /**
   * Consistent
   */
  Consistent: "Consistent",

  /**
   * InConsistent
   */
  InConsistent: "InConsistent",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * Resource provisioning state
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * DeleteError
   */
  DeleteError: "DeleteError",
}

/**
 * Operation status
 */
union OperationStatus {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The type of managed identity for the workspace
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  /**
   * None
   */
  None,

  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * SystemAssigned,UserAssigned
   */
  `SystemAssigned,UserAssigned`,
}

/**
 * Desired state
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DesiredState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * Actual state
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ActualState {
  /**
   * Enabling
   */
  Enabling,

  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabling
   */
  Disabling,

  /**
   * Disabled
   */
  Disabled,

  /**
   * Unknown
   */
  Unknown,
}

/**
 * Workspace properties
 */
model WorkspaceProperties {
  /**
   * Workspace default data lake storage account details
   */
  defaultDataLakeStorage?: DataLakeStorageAccountDetails;

  /**
   * SQL administrator login password
   */
  sqlAdministratorLoginPassword?: string;

  /**
   * Workspace managed resource group. The resource group name uniquely identifies the resource group within the user subscriptionId. The resource group name must be no longer than 90 characters long, and must be alphanumeric characters (Char.IsLetterOrDigit()) and '-', '_', '(', ')' and'.'. Note that the name cannot end with '.'
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedResourceGroupName?: string;

  /**
   * Resource provisioning state
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Login for workspace SQL active directory administrator
   */
  sqlAdministratorLogin?: string;

  /**
   * Virtual Network profile
   */
  virtualNetworkProfile?: VirtualNetworkProfile;

  /**
   * Connectivity endpoints
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  connectivityEndpoints?: Record<string>;

  /**
   * Setting this to 'default' will ensure that all compute for this workspace is in a virtual network managed on behalf of the user.
   */
  managedVirtualNetwork?: string;

  /**
   * Private endpoint connections to the workspace
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The encryption details of the workspace
   */
  encryption?: EncryptionDetails;

  /**
   * The workspace unique identifier
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  workspaceUID?: string;

  /**
   * Workspace level configs and feature flags
   */
  @visibility(Lifecycle.Read)
  extraProperties?: unknown;

  /**
   * Managed Virtual Network Settings
   */
  managedVirtualNetworkSettings?: ManagedVirtualNetworkSettings;

  /**
   * Git integration settings
   */
  workspaceRepositoryConfiguration?: WorkspaceRepositoryConfiguration;

  /**
   * Purview Configuration
   */
  purviewConfiguration?: PurviewConfiguration;

  /**
   * The ADLA resource ID.
   */
  @visibility(Lifecycle.Read)
  adlaResourceId?: string;

  /**
   * Enable or Disable public network access to workspace
   */
  publicNetworkAccess?: WorkspacePublicNetworkAccess = WorkspacePublicNetworkAccess.Enabled;

  /**
   * Initial workspace AAD admin properties for a CSP subscription
   */
  cspWorkspaceAdminProperties?: CspWorkspaceAdminProperties;

  /**
   * Workspace settings
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  settings?: Record<unknown>;

  /**
   * Enable or Disable AzureADOnlyAuthentication on All Workspace subresource
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  azureADOnlyAuthentication?: boolean;

  /**
   * Is trustedServiceBypassEnabled for the workspace
   */
  trustedServiceBypassEnabled?: boolean = false;
}

/**
 * Details of the data lake storage account associated with the workspace
 */
model DataLakeStorageAccountDetails {
  /**
   * Account URL
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  accountUrl?: string;

  /**
   * Filesystem name
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  filesystem?: string;

  /**
   * ARM resource Id of this storage account
   */
  resourceId?: string;

  /**
   * Create managed private endpoint to this storage account or not
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  createManagedPrivateEndpoint?: boolean;
}

/**
 * Virtual Network Profile
 */
model VirtualNetworkProfile {
  /**
   * Subnet ID used for computes in workspace
   */
  computeSubnetId?: string;
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The private endpoint which the connection belongs to.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Connection state of the private endpoint connection.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * Provisioning state of the private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Private endpoint details
 */
model PrivateEndpoint {
  /**
   * Resource id of the private endpoint.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Connection state details of the private endpoint
 */
model PrivateLinkServiceConnectionState {
  /**
   * The private link service connection status.
   */
  status?: string;

  /**
   * The private link service connection description.
   */
  description?: string;

  /**
   * The actions required for private link service connection.
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
}

/**
 * Details of the encryption associated with the workspace
 */
model EncryptionDetails {
  /**
   * Double Encryption enabled
   */
  @visibility(Lifecycle.Read)
  doubleEncryptionEnabled?: boolean;

  /**
   * Customer Managed Key Details
   */
  cmk?: CustomerManagedKeyDetails;
}

/**
 * Details of the customer managed key associated with the workspace
 */
model CustomerManagedKeyDetails {
  /**
   * The customer managed key status on the workspace
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The key object of the workspace
   */
  key?: WorkspaceKeyDetails;

  /**
   * Key encryption key
   */
  kekIdentity?: KekIdentityProperties;
}

/**
 * Details of the customer managed key associated with the workspace
 */
model WorkspaceKeyDetails {
  /**
   * Workspace Key sub-resource name
   */
  name?: string;

  /**
   * Workspace Key sub-resource key vault url
   */
  keyVaultUrl?: string;
}

/**
 * Key encryption key properties
 */
model KekIdentityProperties {
  /**
   * User assigned identity resource Id
   */
  userAssignedIdentity?: string;

  /**
   * Boolean specifying whether to use system assigned identity or not
   */
  useSystemAssignedIdentity?: unknown;
}

/**
 * Managed Virtual Network Settings
 */
model ManagedVirtualNetworkSettings {
  /**
   * Prevent Data Exfiltration
   */
  preventDataExfiltration?: boolean;

  /**
   * Linked Access Check On Target Resource
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  linkedAccessCheckOnTargetResource?: boolean;

  /**
   * Allowed Aad Tenant Ids For Linking
   */
  allowedAadTenantIdsForLinking?: string[];
}

/**
 * Git integration settings
 */
model WorkspaceRepositoryConfiguration {
  /**
   * Type of workspace repositoryID configuration. Example WorkspaceVSTSConfiguration, WorkspaceGitHubConfiguration
   */
  type?: string;

  /**
   * GitHub Enterprise host name. For example: `https://github.mydomain.com`
   */
  hostName?: string;

  /**
   * Account name
   */
  accountName?: string;

  /**
   * VSTS project name
   */
  projectName?: string;

  /**
   * Repository name
   */
  repositoryName?: string;

  /**
   * Collaboration branch
   */
  collaborationBranch?: string;

  /**
   * Root folder to use in the repository
   */
  rootFolder?: string;

  /**
   * The last commit ID
   */
  lastCommitId?: string;

  /**
   * The VSTS tenant ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId?: string;
}

/**
 * Purview Configuration
 */
model PurviewConfiguration {
  /**
   * Purview Resource ID
   */
  purviewResourceId?: string;
}

/**
 * Initial workspace AAD admin properties for a CSP subscription
 */
model CspWorkspaceAdminProperties {
  /**
   * AAD object ID of initial workspace admin
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  initialWorkspaceAdminObjectId?: string;
}

/**
 * The workspace managed identity
 */
model ManagedIdentity {
  /**
   * The principal ID of the workspace managed identity
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of the workspace managed identity
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * The type of managed identity for the workspace
   */
  type?: ResourceIdentityType;

  /**
   * The user assigned managed identities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedManagedIdentity>;
}

/**
 * User Assigned Managed Identity
 */
model UserAssignedManagedIdentity {
  /**
   * The client ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  clientId?: string;

  /**
   * The principal ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;
}

/**
 * Workspace patch details
 */
model WorkspacePatchInfo {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The identity of the workspace
   */
  identity?: ManagedIdentity;

  /**
   * Workspace patch properties
   */
  properties?: WorkspacePatchProperties;
}

/**
 * Workspace patch properties
 */
model WorkspacePatchProperties {
  /**
   * SQL administrator login password
   */
  sqlAdministratorLoginPassword?: string;

  /**
   * Managed Virtual Network Settings
   */
  managedVirtualNetworkSettings?: ManagedVirtualNetworkSettings;

  /**
   * Git integration settings
   */
  workspaceRepositoryConfiguration?: WorkspaceRepositoryConfiguration;

  /**
   * Purview Configuration
   */
  purviewConfiguration?: PurviewConfiguration;

  /**
   * Resource provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The encryption details of the workspace
   */
  encryption?: EncryptionDetails;

  /**
   * Enable or Disable public network access to workspace
   */
  publicNetworkAccess?: WorkspacePublicNetworkAccess;
}

/**
 * Workspace active directory administrator properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AadAdminProperties {
  /**
   * Tenant ID of the workspace active directory administrator
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tenantId?: string;

  /**
   * Login of the workspace active directory administrator
   */
  login?: string;

  /**
   * Workspace active directory administrator type
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorType?: string;

  /**
   * Object ID of the workspace active directory administrator
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sid?: string;
}

/**
 * Sql Control Settings for workspace managed identity
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ManagedIdentitySqlControlSettingsModelProperties {
  /**
   * Grant sql control to managed identity
   */
  grantSqlControlToManagedIdentity?: ManagedIdentitySqlControlSettingsModelPropertiesGrantSqlControlToManagedIdentity;
}

/**
 * Grant sql control to managed identity
 */
model ManagedIdentitySqlControlSettingsModelPropertiesGrantSqlControlToManagedIdentity {
  /**
   * Desired state
   */
  desiredState?: DesiredState;

  /**
   * Actual state
   */
  @visibility(Lifecycle.Read)
  actualState?: ActualState;
}

/**
 * The properties of a restorable dropped Sql pool
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RestorableDroppedSqlPoolProperties {
  /**
   * The name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * The edition of the database
   */
  @visibility(Lifecycle.Read)
  edition?: string;

  /**
   * The max size in bytes of the database
   */
  @visibility(Lifecycle.Read)
  maxSizeBytes?: string;

  /**
   * The service level objective name of the database
   */
  @visibility(Lifecycle.Read)
  serviceLevelObjective?: string;

  /**
   * The elastic pool name of the database
   */
  @visibility(Lifecycle.Read)
  elasticPoolName?: string;

  /**
   * The creation date of the database (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The deletion date of the database (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The earliest restore date of the database (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

/**
 * The response to a list restorable dropped Sql pools request
 */
model RestorableDroppedSqlPoolListResult {
  /**
   * A list of restorable dropped Sql pools
   */
  @pageItems
  value: RestorableDroppedSqlPool[];
}

/**
 * Properties of a active directory only authentication.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AzureADOnlyAuthenticationProperties {
  /**
   * Azure Active Directory only Authentication enabled.
   */
  azureADOnlyAuthentication: boolean;

  /**
   * property configuration state
   */
  @visibility(Lifecycle.Read)
  state?: StateValue;

  /**
   * property configuration date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;
}

/**
 * A request about whether a workspace name is available
 */
model CheckNameAvailabilityRequest {
  /**
   * Workspace name
   */
  name?: string;

  /**
   * Type: workspace
   */
  type?: string;
}

/**
 * A response saying whether the workspace name is available
 */
model CheckNameAvailabilityResponse {
  /**
   * Validation message
   */
  message?: string;

  /**
   * Whether the workspace name is available
   */
  available?: boolean;

  /**
   * Reason the workspace name is or is not available
   */
  reason?: string;

  /**
   * Workspace name
   */
  name?: string;
}

/**
 * IP firewall rule properties
 */
model IpFirewallRuleProperties {
  /**
   * The end IP address of the firewall rule. Must be IPv4 format. Must be greater than or equal to startIpAddress
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  endIpAddress?: string;

  /**
   * Resource provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The start IP address of the firewall rule. Must be IPv4 format
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  startIpAddress?: string;
}

/**
 * Replace all IP firewall rules request
 */
model ReplaceAllIpFirewallRulesRequest {
  /**
   * IP firewall rule properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  ipFirewallRules?: Record<IpFirewallRuleProperties>;
}

/**
 * An existing operation for replacing the firewall rules
 */
model ReplaceAllFirewallRulesOperationResponse {
  /**
   * The operation ID
   */
  operationId?: string;
}

/**
 * Key properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model KeyProperties {
  /**
   * Used to activate the workspace after a customer managed key is provided.
   */
  isActiveCMK?: boolean;

  /**
   * The Key Vault Url of the workspace key.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyVaultUrl?: string;
}

/**
 * An operation that is available in this resource provider
 */
model AvailableRpOperation {
  /**
   * Display properties of the operation
   */
  display?: AvailableRpOperationDisplayInfo;

  /**
   * Whether this operation is a data action
   */
  isDataAction?: string;

  /**
   * Operation name
   */
  name?: string;

  /**
   * Operation properties
   */
  properties?: OperationMetaPropertyInfo;

  /**
   * Operation origin
   */
  origin?: string;
}

/**
 * Description of an available operation
 */
model AvailableRpOperationDisplayInfo {
  /**
   * Operation description
   */
  description?: string;

  /**
   * Resource type
   */
  resource?: string;

  /**
   * Resource provider name
   */
  provider?: string;

  /**
   * Operation name
   */
  operation?: string;
}

/**
 * What is this?
 */
model OperationMetaPropertyInfo {
  /**
   * Operation service specification
   */
  serviceSpecification?: OperationMetaServiceSpecification;
}

/**
 * What is this?
 */
model OperationMetaServiceSpecification {
  /**
   * Service metric specifications
   */
  metricSpecifications?: OperationMetaMetricSpecification[];

  /**
   * Service log specifications
   */
  logSpecifications?: OperationMetaLogSpecification[];
}

/**
 * What is this?
 */
model OperationMetaMetricSpecification {
  /**
   * The source MDM namespace
   */
  sourceMdmNamespace?: string;

  /**
   * Metric display name
   */
  displayName?: string;

  /**
   * Metric unique name
   */
  name?: string;

  /**
   * Metric aggregation type
   */
  aggregationType?: string;

  /**
   * Metric description
   */
  displayDescription?: string;

  /**
   * The source MDM account
   */
  sourceMdmAccount?: string;

  /**
   * Whether the regional MDM account is enabled
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * Metric units
   */
  unit?: string;

  /**
   * Metric dimensions
   */
  dimensions?: OperationMetaMetricDimensionSpecification[];

  /**
   * Whether the metric supports instance-level aggregation
   */
  supportsInstanceLevelAggregation?: boolean;

  /**
   * Metric filter
   */
  metricFilterPattern?: string;
}

/**
 * What is this?
 */
model OperationMetaMetricDimensionSpecification {
  /**
   * Dimension display name
   */
  displayName?: string;

  /**
   * Dimension unique name
   */
  name?: string;

  /**
   * Whether this metric should be exported for Shoebox
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * What is this?
 */
model OperationMetaLogSpecification {
  /**
   * Log display name
   */
  displayName?: string;

  /**
   * Time range the log covers
   */
  blobDuration?: string;

  /**
   * Log unique name
   */
  name?: string;
}

/**
 * An operation
 */
model OperationResource {
  /**
   * Operation ID
   */
  id?: string;

  /**
   * Operation name
   */
  name?: string;

  /**
   * Operation status
   */
  status?: OperationStatus;

  /**
   * Operation properties
   */
  properties?: unknown;

  /**
   * Errors from the operation
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  /**
   * Operation start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Operation start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Completion percentage of the operation
   */
  percentComplete?: float32;
}

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionList
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * Required DNS zone names of the the private link resource.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * PrivateLinkHub properties
 */
model PrivateLinkHubProperties {
  /**
   * PrivateLinkHub provisioning state
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  provisioningState?: string;

  /**
   * List of private endpoint connections
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnectionForPrivateLinkHubBasic[];
}

/**
 * Private Endpoint Connection For Private Link Hub - Basic
 */
model PrivateEndpointConnectionForPrivateLinkHubBasic {
  /**
   * identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Properties of private endpoint connection for private link hub
   */
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * PrivateLinkHub patch details
 */
model PrivateLinkHubPatchInfo {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PrivateEndpointConnectionForPrivateLinkHubResourceCollectionResponse
  is Azure.Core.Page<PrivateEndpointConnectionForPrivateLinkHub>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PrivateEndpointConnectionForPrivateLinkHubBasicAutoGenerated {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  id?: string;

  /**
   * Properties of a private endpoint connection.
   */
  properties?: PrivateEndpointConnectionProperties;
}
