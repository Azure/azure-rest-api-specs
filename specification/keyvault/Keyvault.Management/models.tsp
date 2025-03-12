import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.KeyVault;

/**
 * SKU family name
 */
union SkuFamily {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  A: "A",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union KeyPermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  all: "all",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  encrypt: "encrypt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  decrypt: "decrypt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  wrapKey: "wrapKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  unwrapKey: "unwrapKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sign: "sign",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  verify: "verify",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  get: "get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  list: "list",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  create: "create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  update: "update",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `import`: "import",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  backup: "backup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  restore: "restore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  recover: "recover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  purge: "purge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  release: "release",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  rotate: "rotate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  getrotationpolicy: "getrotationpolicy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  setrotationpolicy: "setrotationpolicy",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SecretPermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  all: "all",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  get: "get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  list: "list",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  set: "set",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  backup: "backup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  restore: "restore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  recover: "recover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  purge: "purge",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union CertificatePermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  all: "all",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  get: "get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  list: "list",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  create: "create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `import`: "import",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  update: "update",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  managecontacts: "managecontacts",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  getissuers: "getissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  listissuers: "listissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  setissuers: "setissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  deleteissuers: "deleteissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  manageissuers: "manageissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  recover: "recover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  purge: "purge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  backup: "backup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  restore: "restore",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union StoragePermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  all: "all",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  get: "get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  list: "list",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  set: "set",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  update: "update",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  regeneratekey: "regeneratekey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  recover: "recover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  purge: "purge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  backup: "backup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  restore: "restore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  setsas: "setsas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  listsas: "listsas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  getsas: "getsas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  deletesas: "deletesas",
}

/**
 * Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.
 */
union NetworkRuleBypassOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureServices: "AzureServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
union NetworkRuleAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
}

/**
 * Provisioning state of the vault.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union VaultProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RegisteringDns: "RegisteringDns",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
}

/**
 * A message indicating if changes on the service provider require any updates on the consumer.
 */
union ActionsRequired {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
}

/**
 * The type of identity.
 */
union IdentityType {
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

/**
 * Provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,

  /**
   * The managed HSM Pool has been full provisioned.
   */
  Succeeded: "Succeeded",

  /**
   * The managed HSM Pool is currently being provisioned.
   */
  Provisioning: "Provisioning",

  /**
   * Provisioning of the managed HSM Pool has failed.
   */
  Failed: "Failed",

  /**
   * The managed HSM Pool is currently being updated.
   */
  Updating: "Updating",

  /**
   * The managed HSM Pool is currently being deleted.
   */
  Deleting: "Deleting",

  /**
   * The managed HSM pool is ready for normal use.
   */
  Activated: "Activated",

  /**
   * The managed HSM pool is waiting for a security domain restore action.
   */
  SecurityDomainRestore: "SecurityDomainRestore",

  /**
   * The managed HSM pool is being restored from full HSM backup.
   */
  Restoring: "Restoring",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union GeoReplicationRegionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Preprovisioning: "Preprovisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cleanup: "Cleanup",
}

/**
 * Control permission to the managed HSM from public networks.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Activation Status
 */
union ActivationStatus {
  string,

  /**
   * The managed HSM Pool is active.
   */
  Active: "Active",

  /**
   * The managed HSM Pool is not yet activated.
   */
  NotActivated: "NotActivated",

  /**
   * An unknown error occurred while activating managed hsm.
   */
  Unknown: "Unknown",

  /**
   * Failed to activate managed hsm.
   */
  Failed: "Failed",
}

/**
 * SKU Family of the managed HSM Pool
 */
union ManagedHsmSkuFamily {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  B: "B",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  C: "C",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * The deletion recovery level currently in effect for the object. If it contains 'Purgeable', then the object can be permanently deleted by a privileged user; otherwise, only the system can purge the object at the end of the retention interval.
 */
union DeletionRecoveryLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Purgeable: "Purgeable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Recoverable+Purgeable`: "Recoverable+Purgeable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Recoverable: "Recoverable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Recoverable+ProtectedSubscription`: "Recoverable+ProtectedSubscription",
}

/**
 * The type of the key. For valid values, see JsonWebKeyType.
 */
union JsonWebKeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EC: "EC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `EC-HSM`: "EC-HSM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RSA: "RSA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `RSA-HSM`: "RSA-HSM",
}

/**
 * The permitted JSON web key operations of the key. For more information, see JsonWebKeyOperation.
 */
union JsonWebKeyOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  encrypt: "encrypt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  decrypt: "decrypt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sign: "sign",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  verify: "verify",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  wrapKey: "wrapKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  unwrapKey: "unwrapKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `import`: "import",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  release: "release",
}

/**
 * The elliptic curve name. For valid values, see JsonWebKeyCurveName. Default for EC and EC-HSM keys is P-256
 */
union JsonWebKeyCurveName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `P-256`: "P-256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `P-384`: "P-384",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `P-521`: "P-521",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `P-256K`: "P-256K",
}

/**
 * SKU name to specify whether the key vault is a standard vault or a premium vault.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SkuName {
  standard,
  premium,
}

/**
 * The vault's create mode to indicate whether the vault need to be recovered or not.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum CreateMode {
  recover,
  default,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum AccessPolicyUpdateKind {
  add,
  replace,
  remove,
}

/**
 * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Reason {
  AccountNameInvalid,
  AlreadyExists,
}

/**
 * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
 */
/*
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ManagedHsmNameUnavailableReason {
  AccountNameInvalid,
  AlreadyExists,
}
*/
/**
 * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
 */
/*
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum KeyVaultNameUnavailableReason {
  AccountNameInvalid,
  AlreadyExists,
}
*/
/**
 * SKU of the managed HSM Pool
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ManagedHsmSkuName {
  Standard_B1,
  Custom_B32,
  Custom_B6,
  Custom_C42,
  Custom_C10,
}

/**
 * The type of action.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum KeyRotationPolicyActionType {
  rotate,
  notify,
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["tenantId", "objectId", "permissions"]
  )
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
  createMode?: CreateMode;

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
  provisioningState?: VaultProvisioningState;

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
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId: string;

  /**
   * The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.
   */
  objectId: string;

  /**
   *  Application ID of the client making request on behalf of a principal
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
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
  bypass?: NetworkRuleBypassOptions;

  /**
   * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
   */
  defaultAction?: NetworkRuleAction;

  /**
   * The list of IP address rules.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipRules?: IPRule[];

  /**
   * The list of virtual network rules.
   */
  @OpenAPI.extension("x-ms-identifiers", ["id"])
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  actionsRequired?: ActionsRequired;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["tenantId", "objectId", "permissions"]
  )
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
  createMode?: CreateMode;

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
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["tenantId", "objectId", "permissions"]
  )
  accessPolicies: AccessPolicyEntry[];
}

/**
 * Properties of the deleted vault.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility("read")
  tags?: Record<string>;

  /**
   * Purge protection status of the original vault.
   */
  @visibility("read")
  purgeProtectionEnabled?: boolean;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility("read")
  tags?: Record<string>;
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
  reason?: Reason;

  /**
   * An error message explaining the Reason value in more detail.
   */
  @visibility("read")
  message?: string;
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  provisioningState?: ProvisioningState;

  /**
   * Rules governing the accessibility of the key vault from specific network locations.
   */
  networkAcls?: MhsmNetworkRuleSet;

  /**
   * List of all regions associated with the managed hsm pool.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
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
  @OpenAPI.extension("x-ms-identifiers", ["value"])
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  provisioningState?: PrivateEndpointConnectionProvisioningState;
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
  status?: PrivateEndpointServiceConnectionStatus;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the key vault resource.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: ManagedServiceIdentity;
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
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
   */
  type: ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
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
  @encodedName("application/json", "innererror")
  innerError?: Error;
}

/**
 * Properties of the deleted managed HSM.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MhsmPrivateLinkResource extends ManagedHsmResource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  logSpecifications?: LogSpecification[];

  /**
   * Metric specifications of operation.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
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
  @OpenAPI.extension("x-ms-identifiers", ["name"])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Properties of the secret
   */
  properties: SecretProperties;
}

/**
 * Properties of the secret
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
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
  @encode("unixTimestamp", int32)
  notBefore?: utcDateTime;

  /**
   * Expiry date in seconds since 1970-01-01T00:00:00Z.
   */
  @encode("unixTimestamp", int32)
  expires?: utcDateTime;

  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @encode("unixTimestamp", int32)
  @visibility("read")
  created?: utcDateTime;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @encode("unixTimestamp", int32)
  @visibility("read")
  updated?: utcDateTime;
}

/**
 * Parameters for patching a secret
 */
model SecretPatchParameters {
  /**
   * The tags that will be assigned to the secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
 * The properties of the key.
 */
model KeyProperties {
  /**
   * The attributes of the key.
   */
  attributes?: KeyAttributes;

  /**
   * The type of the key. For valid values, see JsonWebKeyType.
   */
  kty?: JsonWebKeyType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  keyOps?: JsonWebKeyOperation[];

  /**
   * The key size in bits. For example: 2048, 3072, or 4096 for RSA. Default for RSA and RSA-HSM keys is 2048. Exception made for bring your own key (BYOK), key exchange keys default to 4096.
   */
  keySize?: int32;

  /**
   * The elliptic curve name. For valid values, see JsonWebKeyCurveName. Default for EC and EC-HSM keys is P-256
   */
  curveName?: JsonWebKeyCurveName;

  /**
   * The URI to retrieve the current version of the key.
   */
  @visibility("read")
  keyUri?: string;

  /**
   * The URI to retrieve the specific version of the key.
   */
  @visibility("read")
  keyUriWithVersion?: string;

  /**
   * Key rotation policy in response. It will be used for both output and input. Omitted if empty
   */
  rotationPolicy?: RotationPolicy;

  /**
   * Key release policy in response. It will be used for both output and input. Omitted if empty
   */
  @encodedName("application/json", "release_policy")
  releasePolicy?: KeyReleasePolicy;
}

/**
 * The object attributes managed by the Azure Key Vault service.
 */
model KeyAttributes {
  /**
   * Determines whether or not the object is enabled.
   */
  enabled?: boolean;

  /**
   * Not before date in seconds since 1970-01-01T00:00:00Z.
   */
  @encodedName("application/json", "nbf")
  notBefore?: int64;

  /**
   * Expiry date in seconds since 1970-01-01T00:00:00Z.
   */
  @encodedName("application/json", "exp")
  expires?: int64;

  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  created?: int64;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  updated?: int64;

  /**
   * The deletion recovery level currently in effect for the object. If it contains 'Purgeable', then the object can be permanently deleted by a privileged user; otherwise, only the system can purge the object at the end of the retention interval.
   */
  @visibility("read")
  recoveryLevel?: DeletionRecoveryLevel;

  /**
   * Indicates if the private key can be exported.
   */
  exportable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RotationPolicy {
  /**
   * The attributes of key rotation policy.
   */
  attributes?: KeyRotationPolicyAttributes;

  /**
   * The lifetimeActions for key rotation action.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  lifetimeActions?: LifetimeAction[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KeyRotationPolicyAttributes {
  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  created?: int64;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  updated?: int64;

  /**
   * The expiration time for the new key version. It should be in ISO8601 format. Eg: 'P90D', 'P1Y'.
   */
  expiryTime?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LifetimeAction {
  /**
   * The trigger of key rotation policy lifetimeAction.
   */
  trigger?: Trigger;

  /**
   * The action of key rotation policy lifetimeAction.
   */
  action?: Action;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Trigger {
  /**
   * The time duration after key creation to rotate the key. It only applies to rotate. It will be in ISO 8601 duration format. Eg: 'P90D', 'P1Y'.
   */
  timeAfterCreate?: string;

  /**
   * The time duration before key expiring to rotate or notify. It will be in ISO 8601 duration format. Eg: 'P90D', 'P1Y'.
   */
  timeBeforeExpiry?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Action {
  /**
   * The type of action.
   */
  type?: KeyRotationPolicyActionType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KeyReleasePolicy {
  /**
   * Content type and version of key release policy
   */
  contentType?: string = "application/json; charset=utf-8";

  /**
   * Blob encoding the policy rules under which the key can be released.
   */
  data?: bytes;
}

/**
 * The parameters used to create a key.
 */
model KeyCreateParameters {
  /**
   * The tags that will be assigned to the key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The properties of the key to be created.
   */
  properties: KeyProperties;
}

/**
 * The key resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Key extends Resource {
  /**
   * The properties of the key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: KeyProperties;
}

/**
 * The page of keys.
 */
model KeyListResult {
  /**
   * The key resources.
   */
  value?: Key[];

  /**
   * The URL to get the next page of keys.
   */
  nextLink?: string;
}

/**
 * The properties of the key.
 */
model ManagedHsmKeyProperties {
  /**
   * The attributes of the key.
   */
  attributes?: ManagedHsmKeyAttributes;

  /**
   * The type of the key. For valid values, see JsonWebKeyType.
   */
  kty?: JsonWebKeyType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  keyOps?: JsonWebKeyOperation[];

  /**
   * The key size in bits. For example: 2048, 3072, or 4096 for RSA. Default for RSA and RSA-HSM keys is 2048. Exception made for bring your own key (BYOK), key exchange keys default to 4096.
   */
  keySize?: int32;

  /**
   * The elliptic curve name. For valid values, see JsonWebKeyCurveName. Default for EC and EC-HSM keys is P-256
   */
  curveName?: JsonWebKeyCurveName;

  /**
   * The URI to retrieve the current version of the key.
   */
  @visibility("read")
  keyUri?: string;

  /**
   * The URI to retrieve the specific version of the key.
   */
  @visibility("read")
  keyUriWithVersion?: string;

  /**
   * Key rotation policy in response. It will be used for both output and input. Omitted if empty
   */
  rotationPolicy?: ManagedHsmRotationPolicy;

  /**
   * Key release policy in response. It will be used for both output and input. Omitted if empty
   */
  @encodedName("application/json", "release_policy")
  releasePolicy?: ManagedHsmKeyReleasePolicy;
}

/**
 * The object attributes managed by the Azure Key Vault service.
 */
model ManagedHsmKeyAttributes {
  /**
   * Determines whether or not the object is enabled.
   */
  enabled?: boolean;

  /**
   * Not before date in seconds since 1970-01-01T00:00:00Z.
   */
  @encodedName("application/json", "nbf")
  notBefore?: int64;

  /**
   * Expiry date in seconds since 1970-01-01T00:00:00Z.
   */
  @encodedName("application/json", "exp")
  expires?: int64;

  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  created?: int64;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  updated?: int64;

  /**
   * The deletion recovery level currently in effect for the object. If it contains 'Purgeable', then the object can be permanently deleted by a privileged user; otherwise, only the system can purge the object at the end of the retention interval.
   */
  @visibility("read")
  recoveryLevel?: DeletionRecoveryLevel;

  /**
   * Indicates if the private key can be exported.
   */
  exportable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManagedHsmRotationPolicy {
  /**
   * The attributes of key rotation policy.
   */
  attributes?: ManagedHsmKeyRotationPolicyAttributes;

  /**
   * The lifetimeActions for key rotation action.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  lifetimeActions?: ManagedHsmLifetimeAction[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManagedHsmKeyRotationPolicyAttributes {
  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  created?: int64;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility("read")
  updated?: int64;

  /**
   * The expiration time for the new key version. It should be in ISO8601 format. Eg: 'P90D', 'P1Y'.
   */
  expiryTime?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManagedHsmLifetimeAction {
  /**
   * The trigger of key rotation policy lifetimeAction.
   */
  trigger?: ManagedHsmTrigger;

  /**
   * The action of key rotation policy lifetimeAction.
   */
  action?: ManagedHsmAction;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManagedHsmTrigger {
  /**
   * The time duration after key creation to rotate the key. It only applies to rotate. It will be in ISO 8601 duration format. Eg: 'P90D', 'P1Y'.
   */
  timeAfterCreate?: string;

  /**
   * The time duration before key expiring to rotate or notify. It will be in ISO 8601 duration format. Eg: 'P90D', 'P1Y'.
   */
  timeBeforeExpiry?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManagedHsmAction {
  /**
   * The type of action.
   */
  type?: KeyRotationPolicyActionType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManagedHsmKeyReleasePolicy {
  /**
   * Content type and version of key release policy
   */
  contentType?: string = "application/json; charset=utf-8";

  /**
   * Blob encoding the policy rules under which the key can be released.
   */
  data?: bytes;
}

/**
 * The parameters used to create a key.
 */
model ManagedHsmKeyCreateParameters {
  /**
   * The tags that will be assigned to the key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The properties of the key to be created.
   */
  properties: ManagedHsmKeyProperties;
}

/**
 * The key resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ManagedHsmKey extends ProxyResourceWithoutSystemData {
  /**
   * The properties of the key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: ManagedHsmKeyProperties;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model ProxyResourceWithoutSystemData {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

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
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * The page of keys.
 */
model ManagedHsmKeyListResult {
  /**
   * The key resources.
   */
  value?: ManagedHsmKey[];

  /**
   * The URL to get the next page of keys.
   */
  nextLink?: string;
}
/**
 * Describes a page of resource object.
 * @template Resource The resource type.
 */
@pagedResult
@doc("Paged collection of {name} items", Resource)
model ResourceListResult {
  @doc("The {name} items on this page", Resource)
  @items
  value: Resource[];

  @doc("The link to the next page of items")
  @TypeSpec.nextLink
  nextLink?: ResourceLocation<Resource>;
}
