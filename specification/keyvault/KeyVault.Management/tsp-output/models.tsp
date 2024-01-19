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

@doc("SKU family name")
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

@doc("Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.")
enum KeyVaultNetworkRuleBypassOption {
  AzureServices,
  None,
}

@doc("The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.")
enum KeyVaultNetworkRuleAction {
  Allow,
  Deny,
}

@doc("Provisioning state of the vault.")
enum KeyVaultProvisioningState {
  Succeeded,
  RegisteringDns,
}

@doc("The private endpoint connection status.")
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

@doc("A message indicating if changes on the service provider require any updates on the consumer.")
enum KeyVaultActionsRequiredMessage {
  None,
}

@doc("The current provisioning state.")
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Updating,
  Deleting,
  Failed,
  Disconnected,
}

@doc("The type of identity.")
enum IdentityType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("Provisioning state.")
enum ManagedHsmProvisioningState {
  @doc("The managed HSM Pool has been full provisioned.") Succeeded,
  @doc("The managed HSM Pool is currently being provisioned.") Provisioning,
  @doc("Provisioning of the managed HSM Pool has failed.") Failed,
  @doc("The managed HSM Pool is currently being updated.") Updating,
  @doc("The managed HSM Pool is currently being deleted.") Deleting,
  @doc("The managed HSM pool is ready for normal use.") Activated,
  @doc("The managed HSM pool is waiting for a security domain restore action.")
  SecurityDomainRestore,
  @doc("The managed HSM pool is being restored from full HSM backup.")
  Restoring,
}

@doc("Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.")
enum NetworkRuleBypassOptions {
  AzureServices,
  None,
}

@doc("The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.")
enum NetworkRuleAction {
  Allow,
  Deny,
}

@doc("The current provisioning state.")
enum GeoReplicationRegionProvisioningState {
  Preprovisioning,
  Provisioning,
  Succeeded,
  Failed,
  Deleting,
  Cleanup,
}

@doc("The private endpoint connection status.")
enum ManagedHsmPrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

@doc("A message indicating if changes on the service provider require any updates on the consumer.")
enum ActionsRequired {
  None,
}

@doc("The current provisioning state.")
enum ManagedHsmPrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Updating,
  Deleting,
  Failed,
  Disconnected,
}

@doc("Control permission to the managed HSM from public networks.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("Activation Status")
enum ActivationStatus {
  @doc("The managed HSM Pool is active.") Active,
  @doc("The managed HSM Pool is not yet activated.") NotActivated,
  @doc("An unknown error occurred while activating managed hsm.") Unknown,
  @doc("Failed to activate managed hsm.") Failed,
}

@doc("SKU Family of the managed HSM Pool")
enum ManagedHsmSkuFamily {
  B,
}

@doc("The reason that a managed hsm name could not be used. The reason element is only returned if NameAvailable is false.")
enum Reason {
  AccountNameInvalid,
  AlreadyExists,
}

@doc("SKU name to specify whether the key vault is a standard vault or a premium vault.")
@fixed
enum SkuName {
  standard,
  premium,
}

@doc("The vault's create mode to indicate whether the vault need to be recovered or not.")
@fixed
enum KeyVaultCreateMode {
  recover,
  default,
}

@doc("The vault's create mode to indicate whether the vault need to be recovered or not.")
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

@doc("The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.")
@fixed
enum KeyVaultNameUnavailableReason {
  AccountNameInvalid,
  AlreadyExists,
}

@doc("The create mode to indicate whether the resource is being created or is being recovered from a deleted resource.")
@fixed
enum CreateMode {
  @doc("Recover the managed HSM pool from a soft-deleted resource.") recover,
  @doc("Create a new managed HSM pool. This is the default option.") default,
}

@doc("SKU of the managed HSM Pool")
@fixed
enum ManagedHsmSkuName {
  Standard_B1,
  Custom_B32,
  Custom_B6,
}

@doc("Parameters for creating or updating a vault")
model VaultCreateOrUpdateParameters {
  @doc("The supported Azure location where the key vault should be created.")
  location: string;

  @doc("The tags that will be assigned to the key vault.")
  tags?: Record<string>;

  @doc("Properties of the vault")
  properties: VaultProperties;
}

@doc("Properties of the vault")
model VaultProperties {
  @doc("The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.")
  tenantId: string;

  @doc("SKU details")
  sku: Sku;

  @doc("An array of 0 to 1024 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID. When `createMode` is set to `recover`, access policies are not required. Otherwise, access policies are required.")
  accessPolicies?: AccessPolicyEntry[];

  @doc("The URI of the vault for performing operations on keys and secrets.")
  vaultUri?: string;

  @doc("The resource id of HSM Pool.")
  @visibility("read")
  hsmPoolResourceId?: string;

  @doc("Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.")
  enabledForDeployment?: boolean;

  @doc("Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.")
  enabledForDiskEncryption?: boolean;

  @doc("Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault.")
  enabledForTemplateDeployment?: boolean;

  @doc("Property to specify whether the 'soft delete' functionality is enabled for this key vault. If it's not set to any value(true or false) when creating new key vault, it will be set to true by default. Once set to true, it cannot be reverted to false.")
  enableSoftDelete?: boolean;

  @doc("softDelete data retention days. It accepts >=7 and <=90.")
  softDeleteRetentionInDays?: int32;

  @doc("Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions, and the access policies specified in vault properties will be  ignored. When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the vault is created with the default value of false. Note that management actions are always authorized with RBAC.")
  enableRbacAuthorization?: boolean;

  @doc("The vault's create mode to indicate whether the vault need to be recovered or not.")
  @visibility("create", "update")
  createMode?: KeyVaultCreateMode;

  @doc("Property specifying whether protection against purge is enabled for this vault. Setting this property to true activates protection against purge for this vault and its content - only the Key Vault service may initiate a hard, irrecoverable deletion. The setting is effective only if soft delete is also enabled. Enabling this functionality is irreversible - that is, the property does not accept false as its value.")
  enablePurgeProtection?: boolean;

  @doc("Rules governing the accessibility of the key vault from specific network locations.")
  networkAcls?: NetworkRuleSet;

  @doc("Provisioning state of the vault.")
  provisioningState?: KeyVaultProvisioningState;

  @doc("List of private endpoint connections associated with the key vault.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionItem[];

  @doc("Property to specify whether the vault will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked. This will override the set firewall rules, meaning that even if the firewall rules are present we will not honor the rules.")
  publicNetworkAccess?: string;
}

@doc("SKU details")
model Sku {
  @doc("SKU family name")
  family: SkuFamily;

  @doc("SKU name to specify whether the key vault is a standard vault or a premium vault.")
  name: SkuName;
}

@doc("An identity that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID.")
model AccessPolicyEntry {
  @doc("The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.")
  tenantId: string;

  @doc("The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.")
  objectId: string;

  @doc(" Application ID of the client making request on behalf of a principal")
  applicationId?: string;

  @doc("Permissions the identity has for keys, secrets and certificates.")
  permissions: Permissions;
}

@doc("Permissions the identity has for keys, secrets, certificates and storage.")
model Permissions {
  @doc("Permissions to keys")
  keys?: KeyPermissions[];

  @doc("Permissions to secrets")
  secrets?: SecretPermissions[];

  @doc("Permissions to certificates")
  certificates?: CertificatePermissions[];

  @doc("Permissions to storage accounts")
  storage?: StoragePermissions[];
}

@doc("A set of rules governing the network accessibility of a vault.")
model NetworkRuleSet {
  @doc("Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.")
  bypass?: KeyVaultNetworkRuleBypassOption;

  @doc("The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.")
  defaultAction?: KeyVaultNetworkRuleAction;

  @doc("The list of IP address rules.")
  ipRules?: IPRule[];

  @doc("The list of virtual network rules.")
  virtualNetworkRules?: VirtualNetworkRule[];
}

@doc("A rule governing the accessibility of a vault from a specific ip address or ip range.")
model IPRule {
  @doc("An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78).")
  value: string;
}

@doc("A rule governing the accessibility of a vault from a specific virtual network.")
model VirtualNetworkRule {
  @doc("Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'.")
  id: string;

  @doc("Property to specify whether NRP will ignore the check if parent subnet has serviceEndpoints configured.")
  ignoreMissingVnetServiceEndpoint?: boolean;
}

@doc("Private endpoint connection item.")
model PrivateEndpointConnectionItem {
  @doc("Id of private endpoint connection.")
  id?: string;

  @doc("Modified whenever there is a change in the state of private endpoint connection.")
  etag?: string;

  @doc("Private endpoint connection properties.")
  properties?: PrivateEndpointConnectionProperties;
}

@doc("Properties of the private endpoint connection resource.")
model PrivateEndpointConnectionProperties {
  @doc("Properties of the private endpoint object.")
  privateEndpoint?: PrivateEndpoint;

  @doc("Approval state of the private link connection.")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  @doc("Provisioning state of the private endpoint connection.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("Private endpoint object properties.")
model PrivateEndpoint {
  @doc("Full identifier of the private endpoint resource.")
  @visibility("read")
  id?: string;
}

@doc("An object that represents the approval state of the private link connection.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been approved, rejected or removed by the key vault owner.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval or rejection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: KeyVaultActionsRequiredMessage;
}

@doc("An error response from Key Vault resource provider")
@error
model CloudError {
  @doc("An error response from Key Vault resource provider")
  error?: CloudErrorBody;
}

@doc("An error response from Key Vault resource provider")
model CloudErrorBody {
  @doc("Error code. This is a mnemonic that can be consumed programmatically.")
  code?: string;

  @doc("User friendly error message. The message is typically localized and may vary with service version.")
  message?: string;
}

@doc("Parameters for creating or updating a vault")
model VaultPatchParameters {
  @doc("The tags that will be assigned to the key vault. ")
  tags?: Record<string>;

  @doc("Properties of the vault")
  properties?: VaultPatchProperties;
}

@doc("Properties of the vault")
model VaultPatchProperties {
  @doc("The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.")
  tenantId?: string;

  @doc("SKU details")
  sku?: Sku;

  @doc("An array of 0 to 16 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID.")
  accessPolicies?: AccessPolicyEntry[];

  @doc("Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.")
  enabledForDeployment?: boolean;

  @doc("Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.")
  enabledForDiskEncryption?: boolean;

  @doc("Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault.")
  enabledForTemplateDeployment?: boolean;

  @doc("Property to specify whether the 'soft delete' functionality is enabled for this key vault. Once set to true, it cannot be reverted to false.")
  enableSoftDelete?: boolean;

  @doc("Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions, and the access policies specified in vault properties will be  ignored. When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the value of this property will not change.")
  enableRbacAuthorization?: boolean;

  @doc("softDelete data retention days. It accepts >=7 and <=90.")
  softDeleteRetentionInDays?: int32;

  @doc("The vault's create mode to indicate whether the vault need to be recovered or not.")
  createMode?: KeyVaultPatchMode;

  @doc("Property specifying whether protection against purge is enabled for this vault. Setting this property to true activates protection against purge for this vault and its content - only the Key Vault service may initiate a hard, irrecoverable deletion. The setting is effective only if soft delete is also enabled. Enabling this functionality is irreversible - that is, the property does not accept false as its value.")
  enablePurgeProtection?: boolean;

  @doc("A collection of rules governing the accessibility of the vault from specific network locations.")
  networkAcls?: NetworkRuleSet;

  @doc("Property to specify whether the vault will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked. This will override the set firewall rules, meaning that even if the firewall rules are present we will not honor the rules.")
  publicNetworkAccess?: string;
}

@doc("Parameters for updating the access policy in a vault")
model VaultAccessPolicyParameters {
  @doc("The resource id of the access policy.")
  @visibility("read")
  id?: string;

  @doc("The resource name of the access policy.")
  @visibility("read")
  name?: string;

  @doc("The resource name of the access policy.")
  @visibility("read")
  type?: string;

  @doc("The resource type of the access policy.")
  @visibility("read")
  location?: string;

  @doc("Properties of the access policy")
  properties: VaultAccessPolicyProperties;
}

@doc("Properties of the vault access policy")
model VaultAccessPolicyProperties {
  @doc("An array of 0 to 16 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID.")
  accessPolicies: AccessPolicyEntry[];
}

@doc("List of vaults")
model DeletedVaultListResult is Azure.Core.Page<DeletedVault>;

@doc("Properties of the deleted vault.")
model DeletedVaultProperties {
  @doc("The resource id of the original vault.")
  @visibility("read")
  vaultId?: string;

  @doc("The location of the original vault.")
  @visibility("read")
  location?: string;

  @doc("The deleted date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  @doc("The scheduled purged date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  @doc("Tags of the original vault.")
  @visibility("read")
  tags?: Record<string>;

  @doc("Purge protection status of the original vault.")
  @visibility("read")
  purgeProtectionEnabled?: boolean;
}

@doc("The parameters used to check the availability of the vault name.")
model VaultCheckNameAvailabilityParameters {
  @doc("The vault name.")
  name: string;

  @doc("The type of resource, Microsoft.KeyVault/vaults")
  type: "Microsoft.KeyVault/vaults";
}

@doc("The CheckNameAvailability operation response.")
model CheckNameAvailabilityResult {
  @doc("A boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or is invalid and cannot be used.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.")
  @visibility("read")
  reason?: KeyVaultNameUnavailableReason;

  @doc("An error message explaining the Reason value in more detail.")
  @visibility("read")
  message?: string;
}

@doc("Key Vault resource")
model Resource {
  @doc("Fully qualified identifier of the key vault resource.")
  @visibility("read")
  id?: string;

  @doc("Name of the key vault resource.")
  @visibility("read")
  name?: string;

  @doc("Resource type of the key vault resource.")
  @visibility("read")
  type?: string;

  @doc("Azure location of the key vault resource.")
  @visibility("read")
  location?: string;

  @doc("Tags assigned to the key vault resource.")
  @visibility("read")
  tags?: Record<string>;
}

@doc("A list of private link resources")
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  value?: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource extends Resource {
  @doc("Resource properties.")
  properties?: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("Group identifier of private link resource.")
  @visibility("read")
  groupId?: string;

  @doc("Required member names of private link resource.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("Required DNS zone names of the the private link resource.")
  requiredZoneNames?: string[];
}

@doc("Properties of the managed HSM Pool")
model ManagedHsmProperties {
  @doc("The Azure Active Directory tenant ID that should be used for authenticating requests to the managed HSM pool.")
  tenantId?: string;

  @doc("Array of initial administrators object ids for this managed hsm pool.")
  initialAdminObjectIds?: string[];

  @doc("The URI of the managed hsm pool for performing operations on keys.")
  @visibility("read")
  hsmUri?: string;

  @doc("Property to specify whether the 'soft delete' functionality is enabled for this managed HSM pool. Soft delete is enabled by default for all managed HSMs and is immutable.")
  enableSoftDelete?: boolean;

  @doc("Soft deleted data retention days. When you delete an HSM or a key, it will remain recoverable for the configured retention period or for a default period of 90 days. It accepts values between 7 and 90.")
  softDeleteRetentionInDays?: int32;

  @doc("Property specifying whether protection against purge is enabled for this managed HSM pool. Setting this property to true activates protection against purge for this managed HSM pool and its content - only the Managed HSM service may initiate a hard, irrecoverable deletion. Enabling this functionality is irreversible.")
  enablePurgeProtection?: boolean;

  @doc("The create mode to indicate whether the resource is being created or is being recovered from a deleted resource.")
  @visibility("create", "update")
  createMode?: CreateMode;

  @doc("Resource Status Message.")
  @visibility("read")
  statusMessage?: string;

  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ManagedHsmProvisioningState;

  @doc("Rules governing the accessibility of the key vault from specific network locations.")
  networkAcls?: MhsmNetworkRuleSet;

  @doc("List of all regions associated with the managed hsm pool.")
  regions?: MhsmGeoReplicatedRegion[];

  @doc("List of private endpoint connections associated with the managed hsm pool.")
  @visibility("read")
  privateEndpointConnections?: MhsmPrivateEndpointConnectionItem[];

  @doc("Control permission to the managed HSM from public networks.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The scheduled purge date in UTC.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  @doc("Managed HSM security domain properties.")
  @visibility("read")
  securityDomainProperties?: ManagedHSMSecurityDomainProperties;
}

@doc("A set of rules governing the network accessibility of a managed hsm pool.")
model MhsmNetworkRuleSet {
  @doc("Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.")
  bypass?: NetworkRuleBypassOptions;

  @doc("The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.")
  defaultAction?: NetworkRuleAction;

  @doc("The list of IP address rules.")
  ipRules?: MhsmipRule[];

  @doc("The list of virtual network rules.")
  virtualNetworkRules?: MhsmVirtualNetworkRule[];
}

@doc("A rule governing the accessibility of a managed HSM pool from a specific IP address or IP range.")
model MhsmipRule {
  @doc("An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78).")
  value: string;
}

@doc("A rule governing the accessibility of a managed hsm pool from a specific virtual network.")
model MhsmVirtualNetworkRule {
  @doc("Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'.")
  id: string;
}

@doc("A region that this managed HSM Pool has been extended to.")
model MhsmGeoReplicatedRegion {
  @doc("Name of the geo replicated region.")
  name?: string;

  @doc("Provisioning state of the geo replicated region.")
  @visibility("read")
  provisioningState?: GeoReplicationRegionProvisioningState;

  @doc("A boolean value that indicates whether the region is the primary region or a secondary region.")
  isPrimary?: boolean;
}

@doc("Private endpoint connection item.")
model MhsmPrivateEndpointConnectionItem {
  @doc("Id of private endpoint connection.")
  id?: string;

  @doc("Modified whenever there is a change in the state of private endpoint connection.")
  etag?: string;

  @doc("Private endpoint connection properties.")
  properties?: MhsmPrivateEndpointConnectionProperties;
}

@doc("Properties of the private endpoint connection resource.")
model MhsmPrivateEndpointConnectionProperties {
  @doc("Properties of the private endpoint object.")
  privateEndpoint?: MhsmPrivateEndpoint;

  @doc("Approval state of the private link connection.")
  privateLinkServiceConnectionState?: MhsmPrivateLinkServiceConnectionState;

  @doc("Provisioning state of the private endpoint connection.")
  @visibility("read")
  provisioningState?: ManagedHsmPrivateEndpointConnectionProvisioningState;
}

@doc("Private endpoint object properties.")
model MhsmPrivateEndpoint {
  @doc("Full identifier of the private endpoint resource.")
  @visibility("read")
  id?: string;
}

@doc("An object that represents the approval state of the private link connection.")
model MhsmPrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been approved, rejected or removed by the key vault owner.")
  status?: ManagedHsmPrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval or rejection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: ActionsRequired;
}

@doc("The security domain properties of the managed hsm.")
model ManagedHSMSecurityDomainProperties {
  @doc("Activation Status")
  @visibility("read")
  activationStatus?: ActivationStatus;

  @doc("Activation Status Message.")
  @visibility("read")
  activationStatusMessage?: string;
}

@doc("Managed HSM resource")
model ManagedHsmResource {
  @doc("The Azure Resource Manager resource ID for the managed HSM Pool.")
  @visibility("read")
  id?: string;

  @doc("The name of the managed HSM Pool.")
  @visibility("read")
  name?: string;

  @doc("The resource type of the managed HSM Pool.")
  @visibility("read")
  type?: string;

  @doc("The supported Azure location where the managed HSM Pool should be created.")
  @visibility("read", "create")
  location?: string;

  @doc("SKU details")
  sku?: ManagedHsmSku;

  @doc("Resource tags")
  tags?: Record<string>;

  @doc("Metadata pertaining to creation and last modification of the key vault resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("SKU details")
model ManagedHsmSku {
  @doc("SKU Family of the managed HSM Pool")
  family: ManagedHsmSkuFamily;

  @doc("SKU of the managed HSM Pool")
  name: ManagedHsmSkuName;
}

@doc("The error exception.")
@error
model ManagedHsmError {
  @doc("The server error.")
  @visibility("read")
  error?: Error;
}

@doc("The server error.")
model Error {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The inner error, contains a more specific error code.")
  @visibility("read")
  @projectedName("json", "innererror")
  innerError?: Error;
}

@doc("List of deleted managed HSM Pools")
model DeletedManagedHsmListResult is Azure.Core.Page<DeletedManagedHsm>;

@doc("Properties of the deleted managed HSM.")
model DeletedManagedHsmProperties {
  @doc("The resource id of the original managed HSM.")
  @visibility("read")
  mhsmId?: string;

  @doc("The location of the original managed HSM.")
  @visibility("read")
  location?: string;

  @doc("The deleted date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  @doc("The scheduled purged date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  @doc("Purge protection status of the original managed HSM.")
  @visibility("read")
  purgeProtectionEnabled?: boolean;

  @doc("Tags of the original managed HSM.")
  @visibility("read")
  tags?: Record<string>;
}

@doc("A list of private link resources")
model MhsmPrivateLinkResourceListResult {
  @doc("Array of private link resources")
  value?: MhsmPrivateLinkResource[];
}

@doc("A private link resource")
model MhsmPrivateLinkResource extends ManagedHsmResource {
  @doc("Resource properties.")
  properties?: MhsmPrivateLinkResourceProperties;
}

@doc("Properties of a private link resource.")
model MhsmPrivateLinkResourceProperties {
  @doc("Group identifier of private link resource.")
  @visibility("read")
  groupId?: string;

  @doc("Required member names of private link resource.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("Required DNS zone names of the the private link resource.")
  requiredZoneNames?: string[];
}

@doc("List of regions associated with a managed HSM Pools")
model MhsmRegionsListResult is Azure.Core.Page<MhsmGeoReplicatedRegion>;

@doc("The parameters used to check the availability of the managed hsm name.")
model CheckMhsmNameAvailabilityParameters {
  @doc("The managed hsm name.")
  name: string;
}

@doc("The CheckMhsmNameAvailability operation response.")
model CheckMhsmNameAvailabilityResult {
  @doc("A boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or is invalid and cannot be used.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason that a managed hsm name could not be used. The reason element is only returned if NameAvailable is false.")
  @visibility("read")
  reason?: Reason;

  @doc("An error message explaining the Reason value in more detail.")
  @visibility("read")
  message?: string;
}

@doc("Properties of operation, include metric specifications.")
model OperationProperties {
  @doc("One property of operation, include metric specifications.")
  serviceSpecification?: ServiceSpecification;
}

@doc("One property of operation, include log specifications.")
model ServiceSpecification {
  @doc("Log specifications of operation.")
  logSpecifications?: LogSpecification[];

  @doc("Metric specifications of operation.")
  metricSpecifications?: MetricSpecification[];
}

@doc("Log specification of operation.")
model LogSpecification {
  @doc("Name of log specification.")
  name?: string;

  @doc("Display name of log specification.")
  displayName?: string;

  @doc("Blob duration of specification.")
  blobDuration?: string;
}

@doc("Metric specification of operation.")
model MetricSpecification {
  @doc("Name of metric specification.")
  name?: string;

  @doc("Display name of metric specification.")
  displayName?: string;

  @doc("Display description of metric specification.")
  displayDescription?: string;

  @doc("The metric unit. Possible values include: 'Bytes', 'Count', 'Milliseconds'.")
  unit?: string;

  @doc("The metric aggregation type. Possible values include: 'Average', 'Count', 'Total'.")
  aggregationType?: string;

  @doc("The supported aggregation types for the metrics.")
  supportedAggregationTypes?: string[];

  @doc("The supported time grain types for the metrics.")
  supportedTimeGrainTypes?: string[];

  @doc("The metric lock aggregation type.")
  lockAggregationType?: string;

  @doc("The dimensions of metric")
  dimensions?: DimensionProperties[];

  @doc("Property to specify whether to fill gap with zero.")
  fillGapWithZero?: boolean;

  @doc("The internal metric name.")
  internalMetricName?: string;
}

@doc("Type of operation: get, read, delete, etc.")
model DimensionProperties {
  @doc("Name of dimension.")
  name?: string;

  @doc("Display name of dimension.")
  displayName?: string;

  @doc("Property to specify whether the dimension should be exported for Shoebox.")
  toBeExportedForShoebox?: boolean;
}

@doc("Parameters for creating or updating a secret")
model SecretCreateOrUpdateParameters {
  @doc("The tags that will be assigned to the secret. ")
  tags?: Record<string>;

  @doc("Properties of the secret")
  properties: SecretProperties;
}

@doc("Properties of the secret")
model SecretProperties {
  @doc("The value of the secret. NOTE: 'value' will never be returned from the service, as APIs using this model are is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.")
  value?: string;

  @doc("The content type of the secret.")
  contentType?: string;

  @doc("The attributes of the secret.")
  attributes?: SecretAttributes;

  @doc("The URI to retrieve the current version of the secret.")
  @visibility("read")
  secretUri?: string;

  @doc("The URI to retrieve the specific version of the secret.")
  @visibility("read")
  secretUriWithVersion?: string;
}

@doc("The secret management attributes.")
model SecretAttributes extends Attributes {}

@doc("The object attributes managed by the KeyVault service.")
model Attributes {
  @doc("Determines whether the object is enabled.")
  enabled?: boolean;

  @doc("Not before date in seconds since 1970-01-01T00:00:00Z.")
  @projectedName("json", "nbf")
  notBefore?: plainTime;

  @doc("Expiry date in seconds since 1970-01-01T00:00:00Z.")
  @projectedName("json", "exp")
  expires?: plainTime;

  @doc("Creation time in seconds since 1970-01-01T00:00:00Z.")
  @visibility("read")
  created?: plainTime;

  @doc("Last updated time in seconds since 1970-01-01T00:00:00Z.")
  @visibility("read")
  updated?: plainTime;
}

@doc("Parameters for patching a secret")
model SecretPatchParameters {
  @doc("The tags that will be assigned to the secret. ")
  tags?: Record<string>;

  @doc("Properties of the secret")
  properties?: SecretPatchProperties;
}

@doc("Properties of the secret")
model SecretPatchProperties {
  @doc("The value of the secret.")
  value?: string;

  @doc("The content type of the secret.")
  contentType?: string;

  @doc("The attributes of the secret.")
  attributes?: SecretAttributes;
}

@doc("List of vault resources.")
model ResourceListResult {
  @doc("The list of vault resources.")
  value?: Resource[];

  @doc("The URL to get the next set of vault resources.")
  nextLink?: string;
}
