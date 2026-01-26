import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KeyVault;

/**
 * The deletion recovery level currently in effect for the object. If it contains 'Purgeable', then the object can be permanently deleted by a privileged user; otherwise, only the system can purge the object at the end of the retention interval.
 */
union DeletionRecoveryLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Purgeable: "Purgeable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Recoverable+Purgeable`: "Recoverable+Purgeable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Recoverable: "Recoverable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Recoverable+ProtectedSubscription`: "Recoverable+ProtectedSubscription",
}

/**
 * The type of the key. For valid values, see JsonWebKeyType.
 */
union JsonWebKeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EC: "EC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `EC-HSM`: "EC-HSM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RSA: "RSA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `RSA-HSM`: "RSA-HSM",
}

/**
 * The permitted JSON web key operations of the key. For more information, see JsonWebKeyOperation.
 */
union JsonWebKeyOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encrypt: "encrypt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  decrypt: "decrypt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sign: "sign",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  verify: "verify",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wrapKey: "wrapKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  unwrapKey: "unwrapKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `import`: "import",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  release: "release",
}

/**
 * The elliptic curve name. For valid values, see JsonWebKeyCurveName. Default for EC and EC-HSM keys is P-256
 */
union JsonWebKeyCurveName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `P-256`: "P-256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `P-384`: "P-384",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `P-521`: "P-521",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `P-256K`: "P-256K",
}

/**
 * SKU family name
 */
union SkuFamily {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  A: "A",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KeyPermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  all: "all",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  encrypt: "encrypt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  decrypt: "decrypt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wrapKey: "wrapKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  unwrapKey: "unwrapKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sign: "sign",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  verify: "verify",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get: "get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list: "list",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create: "create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  update: "update",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `import`: "import",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backup: "backup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restore: "restore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recover: "recover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  purge: "purge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  release: "release",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rotate: "rotate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getrotationpolicy: "getrotationpolicy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  setrotationpolicy: "setrotationpolicy",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SecretPermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  all: "all",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get: "get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list: "list",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  set: "set",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backup: "backup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restore: "restore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recover: "recover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  purge: "purge",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union CertificatePermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  all: "all",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get: "get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list: "list",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create: "create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `import`: "import",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  update: "update",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  managecontacts: "managecontacts",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getissuers: "getissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listissuers: "listissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  setissuers: "setissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteissuers: "deleteissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  manageissuers: "manageissuers",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recover: "recover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  purge: "purge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backup: "backup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restore: "restore",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union StoragePermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  all: "all",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get: "get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list: "list",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  set: "set",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  update: "update",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  regeneratekey: "regeneratekey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recover: "recover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  purge: "purge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backup: "backup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restore: "restore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  setsas: "setsas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listsas: "listsas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getsas: "getsas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deletesas: "deletesas",
}

/**
 * Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.
 */
union NetworkRuleBypassOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureServices: "AzureServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.
 */
union KeyVaultNetworkRuleBypassOption {
  NetworkRuleBypassOptions,
}

/**
 * Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'.
 */
union ManagedHsmNetworkRuleBypassOption {
  NetworkRuleBypassOptions,
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
union NetworkRuleAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deny: "Deny",
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
union KeyVaultNetworkRuleAction {
  NetworkRuleAction,
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
union ManagedHsmNetworkRuleAction {
  NetworkRuleAction,
}
/**
 * Provisioning state of the vault.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union VaultProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RegisteringDns: "RegisteringDns",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * The private endpoint connection status.
 */
union ManagedHsmPrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * A message indicating if changes on the service provider require any updates on the consumer.
 */
union ActionsRequired {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * A message indicating if changes on the service provider require any updates on the consumer.
 */
union KeyVaultActionsRequiredMessage {
  ActionsRequired,
}

/**
 * A message indicating if changes on the service provider require any updates on the consumer.
 */
union ManagedHsmActionsRequiredMessage {
  ActionsRequired,
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}
/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedHsmPrivateEndpointConnectionProvisioningState {
  PrivateEndpointConnectionProvisioningState,
}

/**
 * Provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union GeoReplicationRegionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preprovisioning: "Preprovisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cleanup: "Cleanup",
}

/**
 * Control permission to the managed HSM from public networks.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  B: "B",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  C: "C",
}

/**
 * The type of action.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyRotationPolicyActionType {
  rotate,
  notify,
}

/**
 * SKU name to specify whether the key vault is a standard vault or a premium vault.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SkuName {
  standard,
  premium,
}

/**
 * The vault's create mode to indicate whether the vault need to be recovered or not.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CreateMode {
  recover,
  default,
}

/**
 * The vault's create mode to indicate whether the vault need to be recovered or not.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyVaultCreateMode {
  recover,
  default,
}

/**
 * The vault's create mode to indicate whether the vault need to be recovered or not.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyVaultPatchMode {
  recover,
  default,
}

/**
 * The create mode to indicate whether the resource is being created or is being recovered from a deleted resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ManagedHsmCreateMode {
  recover,
  default,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AccessPolicyUpdateKind {
  add,
  replace,
  remove,
}

/**
 * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Reason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AccountNameInvalid: "AccountNameInvalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlreadyExists: "AlreadyExists",
}

/**
 * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedHsmNameUnavailableReason {
  Reason,
}

/**
 * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyVaultNameUnavailableReason {
  AccountNameInvalid,
  AlreadyExists,
}

/**
 * SKU of the managed HSM Pool
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ManagedHsmSkuName {
  Standard_B1,
  Custom_B32,
  Custom_B6,
  Custom_C42,
  Custom_C10,
}

/**
 * The parameters used to create a key.
 */
model KeyCreateParameters {
  /**
   * The tags that will be assigned to the key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The properties of the key to be created.
   */
  properties: KeyProperties;
}

/**
 * The properties of the key.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KeyProperties {
  /**
   * The attributes of the key.
   */
  attributes?: KeyAttributes;

  /**
   * The type of the key. For valid values, see JsonWebKeyType.
   */
  @minLength(1)
  kty?: JsonWebKeyType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  keyUri?: string;

  /**
   * The URI to retrieve the specific version of the key.
   */
  @visibility(Lifecycle.Read)
  keyUriWithVersion?: string;

  /**
   * Key rotation policy in response. It will be used for both output and input. Omitted if empty
   */
  rotationPolicy?: RotationPolicy;

  /**
   * Key release policy in response. It will be used for both output and input. Omitted if empty
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  release_policy?: KeyReleasePolicy;
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
  nbf?: int64;

  /**
   * Expiry date in seconds since 1970-01-01T00:00:00Z.
   */
  exp?: int64;

  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility(Lifecycle.Read)
  created?: int64;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility(Lifecycle.Read)
  updated?: int64;

  /**
   * The deletion recovery level currently in effect for the object. If it contains 'Purgeable', then the object can be permanently deleted by a privileged user; otherwise, only the system can purge the object at the end of the retention interval.
   */
  @visibility(Lifecycle.Read)
  recoveryLevel?: DeletionRecoveryLevel;

  /**
   * Indicates if the private key can be exported.
   */
  exportable?: boolean = false;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RotationPolicy {
  /**
   * The attributes of key rotation policy.
   */
  attributes?: KeyRotationPolicyAttributes;

  /**
   * The lifetimeActions for key rotation action.
   */
  @identifiers(#[])
  lifetimeActions?: LifetimeAction[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KeyRotationPolicyAttributes {
  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility(Lifecycle.Read)
  created?: int64;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility(Lifecycle.Read)
  updated?: int64;

  /**
   * The expiration time for the new key version. It should be in ISO8601 format. Eg: 'P90D', 'P1Y'.
   */
  expiryTime?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Action {
  /**
   * The type of action.
   */
  type?: KeyRotationPolicyActionType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KeyReleasePolicy {
  /**
   * Content type and version of key release policy
   */
  contentType?: string = "application/json; charset=utf-8";

  /**
   * Blob encoding the policy rules under which the key can be released.
   */
  @encode("base64url")
  data?: bytes;
}

/**
 * The parameters used to create a key.
 */
model ManagedHsmKeyCreateParameters {
  /**
   * The tags that will be assigned to the key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The properties of the key to be created.
   */
  properties: ManagedHsmKeyProperties;
}

/**
 * The properties of the key.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedHsmKeyProperties {
  /**
   * The attributes of the key.
   */
  attributes?: ManagedHsmKeyAttributes;

  /**
   * The type of the key. For valid values, see JsonWebKeyType.
   */
  @minLength(1)
  kty?: JsonWebKeyType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  keyUri?: string;

  /**
   * The URI to retrieve the specific version of the key.
   */
  @visibility(Lifecycle.Read)
  keyUriWithVersion?: string;

  /**
   * Key rotation policy in response. It will be used for both output and input. Omitted if empty
   */
  rotationPolicy?: ManagedHsmRotationPolicy;

  /**
   * Key release policy in response. It will be used for both output and input. Omitted if empty
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  release_policy?: ManagedHsmKeyReleasePolicy;
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
  nbf?: int64;

  /**
   * Expiry date in seconds since 1970-01-01T00:00:00Z.
   */
  exp?: int64;

  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility(Lifecycle.Read)
  created?: int64;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility(Lifecycle.Read)
  updated?: int64;

  /**
   * The deletion recovery level currently in effect for the object. If it contains 'Purgeable', then the object can be permanently deleted by a privileged user; otherwise, only the system can purge the object at the end of the retention interval.
   */
  @visibility(Lifecycle.Read)
  recoveryLevel?: DeletionRecoveryLevel;

  /**
   * Indicates if the private key can be exported.
   */
  exportable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedHsmRotationPolicy {
  /**
   * The attributes of key rotation policy.
   */
  attributes?: ManagedHsmKeyRotationPolicyAttributes;

  /**
   * The lifetimeActions for key rotation action.
   */
  @identifiers(#[])
  lifetimeActions?: ManagedHsmLifetimeAction[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedHsmKeyRotationPolicyAttributes {
  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility(Lifecycle.Read)
  created?: int64;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @visibility(Lifecycle.Read)
  updated?: int64;

  /**
   * The expiration time for the new key version. It should be in ISO8601 format. Eg: 'P90D', 'P1Y'.
   */
  expiryTime?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedHsmAction {
  /**
   * The type of action.
   */
  type?: KeyRotationPolicyActionType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedHsmKeyReleasePolicy {
  /**
   * Content type and version of key release policy
   */
  contentType?: string = "application/json; charset=utf-8";

  /**
   * Blob encoding the policy rules under which the key can be released.
   */
  @encode("base64url")
  data?: bytes;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  tenantId: Azure.Core.uuid;

  /**
   * SKU details
   */
  sku: Sku;

  /**
   * An array of 0 to 1024 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID. When `createMode` is set to `recover`, access policies are not required. Otherwise, access policies are required.
   */
  @identifiers(#["tenantId", "objectId", "permissions"])
  accessPolicies?: AccessPolicyEntry[];

  /**
   * The URI of the vault for performing operations on keys and secrets.
   */
  vaultUri?: string;

  /**
   * The resource id of HSM Pool.
   */
  @visibility(Lifecycle.Read)
  hsmPoolResourceId?: string;

  /**
   * Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.
   */
  enabledForDeployment?: boolean = false;

  /**
   * Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.
   */
  enabledForDiskEncryption?: boolean = false;

  /**
   * Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault.
   */
  enabledForTemplateDeployment?: boolean = false;

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
  enableRbacAuthorization?: boolean = false;

  /**
   * The vault's create mode to indicate whether the vault need to be recovered or not.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: VaultProvisioningState;

  /**
   * List of private endpoint connections associated with the key vault.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnectionItem[];

  /**
   * Property to specify whether the vault will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked. This will override the set firewall rules, meaning that even if the firewall rules are present we will not honor the rules.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
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
  tenantId: Azure.Core.uuid;

  /**
   * The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.
   */
  objectId: string;

  /**
   *  Application ID of the client making request on behalf of a principal
   */
  applicationId?: Azure.Core.uuid;

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
  @identifiers(#[])
  ipRules?: IPRule[];

  /**
   * The list of virtual network rules.
   */
  @identifiers(#["id"])
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
  etag?: Azure.Core.eTag;

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
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * Private endpoint object properties.
 */
model PrivateEndpoint {
  /**
   * Full identifier of the private endpoint resource.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * An error response from Key Vault resource provider
   */
  error?: CloudErrorBody;
}

/**
 * An error response from Key Vault resource provider
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  tenantId?: Azure.Core.uuid;

  /**
   * SKU details
   */
  sku?: Sku;

  /**
   * An array of 0 to 16 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID.
   */
  @identifiers(#["tenantId", "objectId", "permissions"])
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name of the access policy.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource name of the access policy.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The resource type of the access policy.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["tenantId", "objectId", "permissions"])
  accessPolicies: AccessPolicyEntry[];
}

/**
 * Properties of the deleted vault.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeletedVaultProperties {
  /**
   * The resource id of the original vault.
   */
  @visibility(Lifecycle.Read)
  vaultId?: string;

  /**
   * The location of the original vault.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The deleted date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The scheduled purged date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  /**
   * Tags of the original vault.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  /**
   * Purge protection status of the original vault.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
   */
  @visibility(Lifecycle.Read)
  reason?: Reason;

  /**
   * An error message explaining the Reason value in more detail.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResource
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;

  /**
   * Azure location of the key vault resource.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Tags assigned to the key vault resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * Group identifier of private link resource.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * Required member names of private link resource.
   */
  @visibility(Lifecycle.Read)
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
  tenantId?: Azure.Core.uuid;

  /**
   * Array of initial administrators object ids for this managed hsm pool.
   */
  initialAdminObjectIds?: string[];

  /**
   * The URI of the managed hsm pool for performing operations on keys.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  createMode?: CreateMode;

  /**
   * Resource Status Message.
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Rules governing the accessibility of the key vault from specific network locations.
   */
  networkAcls?: MhsmNetworkRuleSet;

  /**
   * List of all regions associated with the managed hsm pool.
   */
  @identifiers(#["name"])
  regions?: MhsmGeoReplicatedRegion[];

  /**
   * List of private endpoint connections associated with the managed hsm pool.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: MhsmPrivateEndpointConnectionItem[];

  /**
   * Control permission to the managed HSM from public networks.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * The scheduled purge date in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  /**
   * Managed HSM security domain properties.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["value"])
  ipRules?: MhsmipRule[];

  /**
   * The list of service tags.
   */
  @identifiers(#["tag"])
  serviceTags?: MhsmServiceTagRule[];

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
 * A rule governing the accessibility of a managed hsm pool from a specific service tags.
 */
model MhsmServiceTagRule {
  /**
   * Name of the service tag.
   */
  tag: string;
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
  @visibility(Lifecycle.Read)
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
  etag?: Azure.Core.eTag;

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
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * Private endpoint object properties.
 */
model MhsmPrivateEndpoint {
  /**
   * Full identifier of the private endpoint resource.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedHSMSecurityDomainProperties {
  /**
   * Activation Status
   */
  @visibility(Lifecycle.Read)
  activationStatus?: ActivationStatus;

  /**
   * Activation Status Message.
   */
  @visibility(Lifecycle.Read)
  activationStatusMessage?: string;
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
  @visibility(Lifecycle.Read)
  error?: Error;
}

/**
 * The server error.
 */
model Error {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The inner error, contains a more specific error code.
   */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "innererror")
  innererror?: Error;
}

/**
 * Properties of the deleted managed HSM.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeletedManagedHsmProperties {
  /**
   * The resource id of the original managed HSM.
   */
  @visibility(Lifecycle.Read)
  mhsmId?: string;

  /**
   * The location of the original managed HSM.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The deleted date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The scheduled purged date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  /**
   * Purge protection status of the original managed HSM.
   */
  @visibility(Lifecycle.Read)
  purgeProtectionEnabled?: boolean;

  /**
   * Tags of the original managed HSM.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MhsmPrivateLinkResource
  extends Azure.ResourceManager.CommonTypes.TrackedResource {
  /**
   * Resource properties.
   */
  properties?: MhsmPrivateLinkResourceProperties;

  /**
   * SKU details
   */
  sku?: ManagedHsmSku;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: CommonTypes.ManagedServiceIdentity;
}

/**
 * Properties of a private link resource.
 */
model MhsmPrivateLinkResourceProperties {
  /**
   * Group identifier of private link resource.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * Required member names of private link resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * The reason that a managed hsm name could not be used. The reason element is only returned if NameAvailable is false.
   */
  @visibility(Lifecycle.Read)
  reason?: Reason;

  /**
   * An error message explaining the Reason value in more detail.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["name"])
  logSpecifications?: LogSpecification[];

  /**
   * Metric specifications of operation.
   */
  @identifiers(#["name"])
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
  @identifiers(#["name"])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the secret
   */
  properties: SecretProperties;
}

/**
 * Properties of the secret
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  secretUri?: string;

  /**
   * The URI to retrieve the specific version of the secret.
   */
  @visibility(Lifecycle.Read)
  secretUriWithVersion?: string;
}

/**
 * The secret management attributes.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nbf?: utcDateTime;

  /**
   * Expiry date in seconds since 1970-01-01T00:00:00Z.
   */
  @encode("unixTimestamp", int32)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  exp?: utcDateTime;

  /**
   * Creation time in seconds since 1970-01-01T00:00:00Z.
   */
  @encode("unixTimestamp", int32)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @visibility(Lifecycle.Read)
  created?: utcDateTime;

  /**
   * Last updated time in seconds since 1970-01-01T00:00:00Z.
   */
  @encode("unixTimestamp", int32)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @visibility(Lifecycle.Read)
  updated?: utcDateTime;
}

/**
 * Parameters for patching a secret
 */
model SecretPatchParameters {
  /**
   * The tags that will be assigned to the secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model ProxyResourceWithoutSystemData {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft Key Vault.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed etc.
   */
  resource?: string;

  /**
   * Type of operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Description of operation.
   */
  description?: string;
}

/**
 * Key Vault REST API operation definition.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Display metadata associated with the operation.
   */
  display?: OperationDisplay;

  /**
   * The origin of operations.
   */
  origin?: string;

  /**
   * Properties of operation, include metric specifications.
   */
  properties?: OperationProperties;

  /**
   * Property to specify whether the action is a data action.
   */
  isDataAction?: boolean;
}
/**
 * Result of the request to list Storage operations. It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /**
   * List of Storage operations supported by the Storage resource provider.
   */
  @pageItems
  @identifiers(#[])
  value: Operation[];

  /**
   * The URL to get the next set of operations.
   */
  @nextLink
  nextLink?: string;
}
/**
 * List of private endpoint connections associated with a managed HSM Pools
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MHSMPrivateEndpointConnectionsListResult
  is Azure.Core.Page<MhsmPrivateEndpointConnection>;

/**
 * The list of vault resources.
 */
model VaultListResult
  is Azure.Core.Page<Azure.ResourceManager.Foundations.TrackedResource>;
@@doc(VaultListResult.nextLink,
  "The URL to get the next set of vault resources."
);
@@doc(VaultListResult.value, "The list of vault resources.");
