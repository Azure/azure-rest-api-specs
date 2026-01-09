import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KeyVault;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * SKU family name
 */
enum SkuFamily {
  A,
}

enum KeyPermissions {
  all,
  encrypt,
  decrypt,
  wrapKey,
  unwrapKey,
  sign,
  verify,
  get,
  list,
  create,
  update,
  `import`,
  delete,
  backup,
  restore,
  recover,
  purge,
  release,
  rotate,
  getrotationpolicy,
  setrotationpolicy,
}

enum SecretPermissions {
  all,
  get,
  list,
  set,
  delete,
  backup,
  restore,
  recover,
  purge,
}

enum CertificatePermissions {
  all,
  get,
  list,
  delete,
  create,
  `import`,
  update,
  managecontacts,
  getissuers,
  listissuers,
  setissuers,
  deleteissuers,
  manageissuers,
  recover,
  purge,
  backup,
  restore,
}

enum StoragePermissions {
  all,
  get,
  list,
  delete,
  set,
  update,
  regeneratekey,
  recover,
  purge,
  backup,
  restore,
  setsas,
  listsas,
  getsas,
  deletesas,
}

/**
 * Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.
 */
enum KeyVaultNetworkRuleBypassOption {
  AzureServices,
  None,
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
enum KeyVaultNetworkRuleAction {
  Allow,
  Deny,
}

/**
 * Provisioning state of the vault.
 */
enum KeyVaultProvisioningState {
  Succeeded,
  RegisteringDns,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * A message indicating if changes on the service provider require any updates on the consumer.
 */
enum KeyVaultActionsRequiredMessage {
  None,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Updating,
  Deleting,
  Failed,
  Disconnected,
}

/**
 * The type of identity.
 */
enum IdentityType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * Provisioning state.
 */
enum ManagedHsmProvisioningState {
  /**
   * The managed HSM Pool has been full provisioned.
   */
  Succeeded,

  /**
   * The managed HSM Pool is currently being provisioned.
   */
  Provisioning,

  /**
   * Provisioning of the managed HSM Pool has failed.
   */
  Failed,

  /**
   * The managed HSM Pool is currently being updated.
   */
  Updating,

  /**
   * The managed HSM Pool is currently being deleted.
   */
  Deleting,

  /**
   * The managed HSM pool is ready for normal use.
   */
  Activated,

  /**
   * The managed HSM pool is waiting for a security domain restore action.
   */
  SecurityDomainRestore,

  /**
   * The managed HSM pool is being restored from full HSM backup.
   */
  Restoring,
}

/**
 * Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.
 */
enum NetworkRuleBypassOptions {
  AzureServices,
  None,
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
enum NetworkRuleAction {
  Allow,
  Deny,
}

/**
 * The current provisioning state.
 */
enum GeoReplicationRegionProvisioningState {
  Preprovisioning,
  Provisioning,
  Succeeded,
  Failed,
  Deleting,
  Cleanup,
}

/**
 * The private endpoint connection status.
 */
enum ManagedHsmPrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * A message indicating if changes on the service provider require any updates on the consumer.
 */
enum ActionsRequired {
  None,
}

/**
 * The current provisioning state.
 */
enum ManagedHsmPrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Updating,
  Deleting,
  Failed,
  Disconnected,
}

/**
 * Control permission to the managed HSM from public networks.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * Activation Status
 */
enum ActivationStatus {
  /**
   * The managed HSM Pool is active.
   */
  Active,

  /**
   * The managed HSM Pool is not yet activated.
   */
  NotActivated,

  /**
   * An unknown error occurred while activating managed hsm.
   */
  Unknown,

  /**
   * Failed to activate managed hsm.
   */
  Failed,
}

/**
 * SKU Family of the managed HSM Pool
 */
enum ManagedHsmSkuFamily {
  B,
}

/**
 * The reason that a managed hsm name could not be used. The reason element is only returned if NameAvailable is false.
 */
enum Reason {
  AccountNameInvalid,
  AlreadyExists,
}

/**
 * SKU name to specify whether the key vault is a standard vault or a premium vault.
 */
@fixed
enum SkuName {
  standard,
  premium,
}

/**
 * The vault's create mode to indicate whether the vault need to be recovered or not.
 */
@fixed
enum KeyVaultCreateMode {
  recover,
  default,
}

/**
 * The vault's create mode to indicate whether the vault need to be recovered or not.
 */
@fixed
enum KeyVaultPatchMode {
  recover,
  default,
}

@fixed
enum AccessPolicyUpdateKind {
  add,
  replace,
  remove,
}

/**
 * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
 */
@fixed
enum KeyVaultNameUnavailableReason {
  AccountNameInvalid,
  AlreadyExists,
}

/**
 * The create mode to indicate whether the resource is being created or is being recovered from a deleted resource.
 */
@fixed
enum CreateMode {
  /**
   * Recover the managed HSM pool from a soft-deleted resource.
   */
  recover,

  /**
   * Create a new managed HSM pool. This is the default option.
   */
  default,
}

/**
 * SKU of the managed HSM Pool
 */
@fixed
enum ManagedHsmSkuName {
  Standard_B1,
  Custom_B32,
  Custom_B6,
}

/**
 * Parameters for creating or updating a vault
 */
model VaultCreateOrUpdateParameters {
  /**
   * The supported Azure location where the key vault should be created.
   */
  location: string;

  /**
   * The tags that will be assigned to the key vault.
   */
  tags?: Record<string>;

  /**
   * Properties of the vault
   */
  properties: VaultProperties;
}

/**
 * Properties of the vault
 */
model VaultProperties {
  /**
   * The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.
   */
  tenantId: string;

  /**
   * SKU details
   */
  sku: Sku;

  /**
   * An array of 0 to 1024 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID. When `createMode` is set to `recover`, access policies are not required. Otherwise, access policies are required.
   */
  accessPolicies?: AccessPolicyEntry[];

  /**
   * The URI of the vault for performing operations on keys and secrets.
   */
  vaultUri?: string;

  /**
   * The resource id of HSM Pool.
   */
  @visibility("read")
  hsmPoolResourceId?: string;

  /**
   * Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.
   */
  enabledForDeployment?: boolean;

  /**
   * Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.
   */
  enabledForDiskEncryption?: boolean;

  /**
   * Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault.
   */
  enabledForTemplateDeployment?: boolean;

  /**
   * Property to specify whether the 'soft delete' functionality is enabled for this key vault. If it's not set to any value(true or false) when creating new key vault, it will be set to true by default. Once set to true, it cannot be reverted to false.
   */
  enableSoftDelete?: boolean = true;

  /**
   * softDelete data retention days. It accepts >=7 and <=90.
   */
  softDeleteRetentionInDays?: int32 = 90;

  /**
   * Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions, and the access policies specified in vault properties will be  ignored. When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the vault is created with the default value of false. Note that management actions are always authorized with RBAC.
   */
  enableRbacAuthorization?: boolean;

  /**
   * The vault's create mode to indicate whether the vault need to be recovered or not.
   */
  @visibility("create", "update")
  createMode?: KeyVaultCreateMode;

  /**
   * Property specifying whether protection against purge is enabled for this vault. Setting this property to true activates protection against purge for this vault and its content - only the Key Vault service may initiate a hard, irrecoverable deletion. The setting is effective only if soft delete is also enabled. Enabling this functionality is irreversible - that is, the property does not accept false as its value.
   */
  enablePurgeProtection?: boolean;

  /**
   * Rules governing the accessibility of the key vault from specific network locations.
   */
  networkAcls?: NetworkRuleSet;

  /**
   * Provisioning state of the vault.
   */
  provisioningState?: KeyVaultProvisioningState;

  /**
   * List of private endpoint connections associated with the key vault.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionItem[];

  /**
   * Property to specify whether the vault will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked. This will override the set firewall rules, meaning that even if the firewall rules are present we will not honor the rules.
   */
  publicNetworkAccess?: string = "enabled";
}

/**
 * SKU details
 */
model Sku {
  /**
   * SKU family name
   */
  family: SkuFamily;

  /**
   * SKU name to specify whether the key vault is a standard vault or a premium vault.
   */
  name: SkuName;
}

/**
 * An identity that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID.
 */
model AccessPolicyEntry {
  /**
   * The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.
   */
  tenantId: string;

  /**
   * The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.
   */
  objectId: string;

  /**
   *  Application ID of the client making request on behalf of a principal
   */
  applicationId?: string;

  /**
   * Permissions the identity has for keys, secrets and certificates.
   */
  permissions: Permissions;
}

/**
 * Permissions the identity has for keys, secrets, certificates and storage.
 */
model Permissions {
  /**
   * Permissions to keys
   */
  keys?: KeyPermissions[];

  /**
   * Permissions to secrets
   */
  secrets?: SecretPermissions[];

  /**
   * Permissions to certificates
   */
  certificates?: CertificatePermissions[];

  /**
   * Permissions to storage accounts
   */
  storage?: StoragePermissions[];
}

/**
 * A set of rules governing the network accessibility of a vault.
 */
model NetworkRuleSet {
  /**
   * Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.
   */
  bypass?: KeyVaultNetworkRuleBypassOption;

  /**
   * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
   */
  defaultAction?: KeyVaultNetworkRuleAction;

  /**
   * The list of IP address rules.
   */
  ipRules?: IPRule[];

  /**
   * The list of virtual network rules.
   */
  virtualNetworkRules?: VirtualNetworkRule[];
}

/**
 * A rule governing the accessibility of a vault from a specific ip address or ip range.
 */
model IPRule {
  /**
   * An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78).
   */
  value: string;
}

/**
 * A rule governing the accessibility of a vault from a specific virtual network.
 */
model VirtualNetworkRule {
  /**
   * Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'.
   */
  id: string;

  /**
   * Property to specify whether NRP will ignore the check if parent subnet has serviceEndpoints configured.
   */
  ignoreMissingVnetServiceEndpoint?: boolean;
}

/**
 * Private endpoint connection item.
 */
model PrivateEndpointConnectionItem {
  /**
   * Id of private endpoint connection.
   */
  id?: string;

  /**
   * Modified whenever there is a change in the state of private endpoint connection.
   */
  etag?: string;

  /**
   * Private endpoint connection properties.
   */
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of the private endpoint connection resource.
 */
model PrivateEndpointConnectionProperties {
  /**
   * Properties of the private endpoint object.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Approval state of the private link connection.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * Provisioning state of the private endpoint connection.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * Private endpoint object properties.
 */
model PrivateEndpoint {
  /**
   * Full identifier of the private endpoint resource.
   */
  @visibility("read")
  id?: string;
}

/**
 * An object that represents the approval state of the private link connection.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been approved, rejected or removed by the key vault owner.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval or rejection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: KeyVaultActionsRequiredMessage;
}

/**
 * An error response from Key Vault resource provider
 */
@error
model CloudError {
  /**
   * An error response from Key Vault resource provider
   */
  error?: CloudErrorBody;
}

/**
 * An error response from Key Vault resource provider
 */
model CloudErrorBody {
  /**
   * Error code. This is a mnemonic that can be consumed programmatically.
   */
  code?: string;

  /**
   * User friendly error message. The message is typically localized and may vary with service version.
   */
  message?: string;
}

/**
 * Parameters for creating or updating a vault
 */
model VaultPatchParameters {
  /**
   * The tags that will be assigned to the key vault.
   */
  tags?: Record<string>;

  /**
   * Properties of the vault
   */
  properties?: VaultPatchProperties;
}

/**
 * Properties of the vault
 */
model VaultPatchProperties {
  /**
   * The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.
   */
  tenantId?: string;

  /**
   * SKU details
   */
  sku?: Sku;

  /**
   * An array of 0 to 16 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID.
   */
  accessPolicies?: AccessPolicyEntry[];

  /**
   * Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.
   */
  enabledForDeployment?: boolean;

  /**
   * Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.
   */
  enabledForDiskEncryption?: boolean;

  /**
   * Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault.
   */
  enabledForTemplateDeployment?: boolean;

  /**
   * Property to specify whether the 'soft delete' functionality is enabled for this key vault. Once set to true, it cannot be reverted to false.
   */
  enableSoftDelete?: boolean;

  /**
   * Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions, and the access policies specified in vault properties will be  ignored. When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the value of this property will not change.
   */
  enableRbacAuthorization?: boolean;

  /**
   * softDelete data retention days. It accepts >=7 and <=90.
   */
  softDeleteRetentionInDays?: int32;

  /**
   * The vault's create mode to indicate whether the vault need to be recovered or not.
   */
  createMode?: KeyVaultPatchMode;

  /**
   * Property specifying whether protection against purge is enabled for this vault. Setting this property to true activates protection against purge for this vault and its content - only the Key Vault service may initiate a hard, irrecoverable deletion. The setting is effective only if soft delete is also enabled. Enabling this functionality is irreversible - that is, the property does not accept false as its value.
   */
  enablePurgeProtection?: boolean;

  /**
   * A collection of rules governing the accessibility of the vault from specific network locations.
   */
  networkAcls?: NetworkRuleSet;

  /**
   * Property to specify whether the vault will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked. This will override the set firewall rules, meaning that even if the firewall rules are present we will not honor the rules.
   */
  publicNetworkAccess?: string;
}

/**
 * Parameters for updating the access policy in a vault
 */
model VaultAccessPolicyParameters {
  /**
   * The resource id of the access policy.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name of the access policy.
   */
  @visibility("read")
  name?: string;

  /**
   * The resource name of the access policy.
   */
  @visibility("read")
  type?: string;

  /**
   * The resource type of the access policy.
   */
  @visibility("read")
  location?: string;

  /**
   * Properties of the access policy
   */
  properties: VaultAccessPolicyProperties;
}

/**
 * Properties of the vault access policy
 */
model VaultAccessPolicyProperties {
  /**
   * An array of 0 to 16 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID.
   */
  accessPolicies: AccessPolicyEntry[];
}

/**
 * List of vaults
 */
model DeletedVaultListResult is Azure.Core.Page<DeletedVault>;

/**
 * Properties of the deleted vault.
 */
model DeletedVaultProperties {
  /**
   * The resource id of the original vault.
   */
  @visibility("read")
  vaultId?: string;

  /**
   * The location of the original vault.
   */
  @visibility("read")
  location?: string;

  /**
   * The deleted date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The scheduled purged date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  /**
   * Tags of the original vault.
   */
  @visibility("read")
  tags?: Record<string>;

  /**
   * Purge protection status of the original vault.
   */
  @visibility("read")
  purgeProtectionEnabled?: boolean;
}

/**
 * The parameters used to check the availability of the vault name.
 */
model VaultCheckNameAvailabilityParameters {
  /**
   * The vault name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.KeyVault/vaults
   */
  type: "Microsoft.KeyVault/vaults";
}

/**
 * The CheckNameAvailability operation response.
 */
model CheckNameAvailabilityResult {
  /**
   * A boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or is invalid and cannot be used.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
   */
  @visibility("read")
  reason?: KeyVaultNameUnavailableReason;

  /**
   * An error message explaining the Reason value in more detail.
   */
  @visibility("read")
  message?: string;
}

/**
 * Key Vault resource
 */
model Resource {
  /**
   * Fully qualified identifier of the key vault resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Name of the key vault resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type of the key vault resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Azure location of the key vault resource.
   */
  @visibility("read")
  location?: string;

  /**
   * Tags assigned to the key vault resource.
   */
  @visibility("read")
  tags?: Record<string>;
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  value?: PrivateLinkResource[];
}

/**
 * A private link resource
 */
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * Group identifier of private link resource.
   */
  @visibility("read")
  groupId?: string;

  /**
   * Required member names of private link resource.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * Required DNS zone names of the the private link resource.
   */
  requiredZoneNames?: string[];
}

/**
 * Properties of the managed HSM Pool
 */
model ManagedHsmProperties {
  /**
   * The Azure Active Directory tenant ID that should be used for authenticating requests to the managed HSM pool.
   */
  tenantId?: string;

  /**
   * Array of initial administrators object ids for this managed hsm pool.
   */
  initialAdminObjectIds?: string[];

  /**
   * The URI of the managed hsm pool for performing operations on keys.
   */
  @visibility("read")
  hsmUri?: string;

  /**
   * Property to specify whether the 'soft delete' functionality is enabled for this managed HSM pool. Soft delete is enabled by default for all managed HSMs and is immutable.
   */
  enableSoftDelete?: boolean = true;

  /**
   * Soft deleted data retention days. When you delete an HSM or a key, it will remain recoverable for the configured retention period or for a default period of 90 days. It accepts values between 7 and 90.
   */
  softDeleteRetentionInDays?: int32 = 90;

  /**
   * Property specifying whether protection against purge is enabled for this managed HSM pool. Setting this property to true activates protection against purge for this managed HSM pool and its content - only the Managed HSM service may initiate a hard, irrecoverable deletion. Enabling this functionality is irreversible.
   */
  enablePurgeProtection?: boolean = true;

  /**
   * The create mode to indicate whether the resource is being created or is being recovered from a deleted resource.
   */
  @visibility("create", "update")
  createMode?: CreateMode;

  /**
   * Resource Status Message.
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ManagedHsmProvisioningState;

  /**
   * Rules governing the accessibility of the key vault from specific network locations.
   */
  networkAcls?: MhsmNetworkRuleSet;

  /**
   * List of all regions associated with the managed hsm pool.
   */
  regions?: MhsmGeoReplicatedRegion[];

  /**
   * List of private endpoint connections associated with the managed hsm pool.
   */
  @visibility("read")
  privateEndpointConnections?: MhsmPrivateEndpointConnectionItem[];

  /**
   * Control permission to the managed HSM from public networks.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * The scheduled purge date in UTC.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  /**
   * Managed HSM security domain properties.
   */
  @visibility("read")
  securityDomainProperties?: ManagedHSMSecurityDomainProperties;
}

/**
 * A set of rules governing the network accessibility of a managed hsm pool.
 */
model MhsmNetworkRuleSet {
  /**
   * Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.
   */
  bypass?: NetworkRuleBypassOptions;

  /**
   * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
   */
  defaultAction?: NetworkRuleAction;

  /**
   * The list of IP address rules.
   */
  ipRules?: MhsmipRule[];

  /**
   * The list of virtual network rules.
   */
  virtualNetworkRules?: MhsmVirtualNetworkRule[];
}

/**
 * A rule governing the accessibility of a managed HSM pool from a specific IP address or IP range.
 */
model MhsmipRule {
  /**
   * An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78).
   */
  value: string;
}

/**
 * A rule governing the accessibility of a managed hsm pool from a specific virtual network.
 */
model MhsmVirtualNetworkRule {
  /**
   * Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'.
   */
  id: string;
}

/**
 * A region that this managed HSM Pool has been extended to.
 */
model MhsmGeoReplicatedRegion {
  /**
   * Name of the geo replicated region.
   */
  name?: string;

  /**
   * Provisioning state of the geo replicated region.
   */
  @visibility("read")
  provisioningState?: GeoReplicationRegionProvisioningState;

  /**
   * A boolean value that indicates whether the region is the primary region or a secondary region.
   */
  isPrimary?: boolean;
}

/**
 * Private endpoint connection item.
 */
model MhsmPrivateEndpointConnectionItem {
  /**
   * Id of private endpoint connection.
   */
  id?: string;

  /**
   * Modified whenever there is a change in the state of private endpoint connection.
   */
  etag?: string;

  /**
   * Private endpoint connection properties.
   */
  properties?: MhsmPrivateEndpointConnectionProperties;
}

/**
 * Properties of the private endpoint connection resource.
 */
model MhsmPrivateEndpointConnectionProperties {
  /**
   * Properties of the private endpoint object.
   */
  privateEndpoint?: MhsmPrivateEndpoint;

  /**
   * Approval state of the private link connection.
   */
  privateLinkServiceConnectionState?: MhsmPrivateLinkServiceConnectionState;

  /**
   * Provisioning state of the private endpoint connection.
   */
  @visibility("read")
  provisioningState?: ManagedHsmPrivateEndpointConnectionProvisioningState;
}

/**
 * Private endpoint object properties.
 */
model MhsmPrivateEndpoint {
  /**
   * Full identifier of the private endpoint resource.
   */
  @visibility("read")
  id?: string;
}

/**
 * An object that represents the approval state of the private link connection.
 */
model MhsmPrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been approved, rejected or removed by the key vault owner.
   */
  status?: ManagedHsmPrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval or rejection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: ActionsRequired;
}

/**
 * The security domain properties of the managed hsm.
 */
model ManagedHSMSecurityDomainProperties {
  /**
   * Activation Status
   */
  @visibility("read")
  activationStatus?: ActivationStatus;

  /**
   * Activation Status Message.
   */
  @visibility("read")
  activationStatusMessage?: string;
}

/**
 * Managed HSM resource
 */
model ManagedHsmResource {
  /**
   * The Azure Resource Manager resource ID for the managed HSM Pool.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the managed HSM Pool.
   */
  @visibility("read")
  name?: string;

  /**
   * The resource type of the managed HSM Pool.
   */
  @visibility("read")
  type?: string;

  /**
   * The supported Azure location where the managed HSM Pool should be created.
   */
  @visibility("read", "create")
  location?: string;

  /**
   * SKU details
   */
  sku?: ManagedHsmSku;

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the key vault resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * SKU details
 */
model ManagedHsmSku {
  /**
   * SKU Family of the managed HSM Pool
   */
  family: ManagedHsmSkuFamily;

  /**
   * SKU of the managed HSM Pool
   */
  name: ManagedHsmSkuName;
}

/**
 * The error exception.
 */
@error
model ManagedHsmError {
  /**
   * The server error.
   */
  @visibility("read")
  error?: Error;
}

/**
 * The server error.
 */
model Error {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The inner error, contains a more specific error code.
   */
  @visibility("read")
  @projectedName("json", "innererror")
  innerError?: Error;
}

/**
 * List of deleted managed HSM Pools
 */
model DeletedManagedHsmListResult is Azure.Core.Page<DeletedManagedHsm>;

/**
 * Properties of the deleted managed HSM.
 */
model DeletedManagedHsmProperties {
  /**
   * The resource id of the original managed HSM.
   */
  @visibility("read")
  mhsmId?: string;

  /**
   * The location of the original managed HSM.
   */
  @visibility("read")
  location?: string;

  /**
   * The deleted date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The scheduled purged date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  /**
   * Purge protection status of the original managed HSM.
   */
  @visibility("read")
  purgeProtectionEnabled?: boolean;

  /**
   * Tags of the original managed HSM.
   */
  @visibility("read")
  tags?: Record<string>;
}

/**
 * A list of private link resources
 */
model MhsmPrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  value?: MhsmPrivateLinkResource[];
}

/**
 * A private link resource
 */
model MhsmPrivateLinkResource extends ManagedHsmResource {
  /**
   * Resource properties.
   */
  properties?: MhsmPrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model MhsmPrivateLinkResourceProperties {
  /**
   * Group identifier of private link resource.
   */
  @visibility("read")
  groupId?: string;

  /**
   * Required member names of private link resource.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * Required DNS zone names of the the private link resource.
   */
  requiredZoneNames?: string[];
}

/**
 * List of regions associated with a managed HSM Pools
 */
model MhsmRegionsListResult is Azure.Core.Page<MhsmGeoReplicatedRegion>;

/**
 * The parameters used to check the availability of the managed hsm name.
 */
model CheckMhsmNameAvailabilityParameters {
  /**
   * The managed hsm name.
   */
  name: string;
}

/**
 * The CheckMhsmNameAvailability operation response.
 */
model CheckMhsmNameAvailabilityResult {
  /**
   * A boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or is invalid and cannot be used.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * The reason that a managed hsm name could not be used. The reason element is only returned if NameAvailable is false.
   */
  @visibility("read")
  reason?: Reason;

  /**
   * An error message explaining the Reason value in more detail.
   */
  @visibility("read")
  message?: string;
}

/**
 * Properties of operation, include metric specifications.
 */
model OperationProperties {
  /**
   * One property of operation, include metric specifications.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * One property of operation, include log specifications.
 */
model ServiceSpecification {
  /**
   * Log specifications of operation.
   */
  logSpecifications?: LogSpecification[];

  /**
   * Metric specifications of operation.
   */
  metricSpecifications?: MetricSpecification[];
}

/**
 * Log specification of operation.
 */
model LogSpecification {
  /**
   * Name of log specification.
   */
  name?: string;

  /**
   * Display name of log specification.
   */
  displayName?: string;

  /**
   * Blob duration of specification.
   */
  blobDuration?: string;
}

/**
 * Metric specification of operation.
 */
model MetricSpecification {
  /**
   * Name of metric specification.
   */
  name?: string;

  /**
   * Display name of metric specification.
   */
  displayName?: string;

  /**
   * Display description of metric specification.
   */
  displayDescription?: string;

  /**
   * The metric unit. Possible values include: 'Bytes', 'Count', 'Milliseconds'.
   */
  unit?: string;

  /**
   * The metric aggregation type. Possible values include: 'Average', 'Count', 'Total'.
   */
  aggregationType?: string;

  /**
   * The supported aggregation types for the metrics.
   */
  supportedAggregationTypes?: string[];

  /**
   * The supported time grain types for the metrics.
   */
  supportedTimeGrainTypes?: string[];

  /**
   * The metric lock aggregation type.
   */
  lockAggregationType?: string;

  /**
   * The dimensions of metric
   */
  dimensions?: DimensionProperties[];

  /**
   * Property to specify whether to fill gap with zero.
   */
  fillGapWithZero?: boolean;

  /**
   * The internal metric name.
   */
  internalMetricName?: string;
}

/**
 * Type of operation: get, read, delete, etc.
 */
model DimensionProperties {
  /**
   * Name of dimension.
   */
  name?: string;

  /**
   * Display name of dimension.
   */
  displayName?: string;

  /**
   * Property to specify whether the dimension should be exported for Shoebox.
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * Parameters for creating or updating a secret
 */
model SecretCreateOrUpdateParameters {
  /**
   * The tags that will be assigned to the secret.
   */
  tags?: Record<string>;

  /**
   * Properties of the secret
   */
  properties: SecretProperties;
}

/**
 * Properties of the secret
 */
model SecretProperties {
  /**
   * The value of the secret. NOTE: 'value' will never be returned from the service, as APIs using this model are is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.
   */
  value?: string;

  /**
   * The content type of the secret.
   */
  contentType?: string;

  /**
   * The attributes of the secret.
   */
  attributes?: SecretAttributes;

  /**
   * The URI to retrieve the current version of the secret.
   */
  @visibility("read")
  secretUri?: string;

  /**
   * The URI to retrieve the specific version of the secret.
   */
  @visibility("read")
  secretUriWithVersion?: string;
}

/**
 * The secret management attributes.
 */
model SecretAttributes extends Attributes {}

/**
 * The object attributes managed by the KeyVault service.
 */
model Attributes {
  /**
   * Determines whether the object is enabled.
   */
  enabled?: boolean;

  /**
   * Not before date in seconds since 1970-01-01T00:00:00Z.
   */
  @projectedName("json", "nbf")
  notBefore?: plainTime;

  /**
   * Expiry date in seconds since 1970-01-01T00:00:00Z.
   */
  @projectedName("json", "exp")
  expires?: plainTime;

  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  created?: plainTime;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  updated?: plainTime;
}

/**
 * Parameters for patching a secret
 */
model SecretPatchParameters {
  /**
   * The tags that will be assigned to the secret.
   */
  tags?: Record<string>;

  /**
   * Properties of the secret
   */
  properties?: SecretPatchProperties;
}

/**
 * Properties of the secret
 */
model SecretPatchProperties {
  /**
   * The value of the secret.
   */
  value?: string;

  /**
   * The content type of the secret.
   */
  contentType?: string;

  /**
   * The attributes of the secret.
   */
  attributes?: SecretAttributes;
}

/**
 * List of vault resources.
 */
model ResourceListResult {
  /**
   * The list of vault resources.
   */
  value?: Resource[];

  /**
   * The URL to get the next set of vault resources.
   */
  nextLink?: string;
}
