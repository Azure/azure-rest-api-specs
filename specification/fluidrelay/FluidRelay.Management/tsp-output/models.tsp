import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.FluidRelay;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provision states for FluidRelay RP
 */
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

/**
 * Sku of the storage associated with the resource
 */
enum StorageSKU {
  standard,
  basic,
}

/**
 * Values can be SystemAssigned or UserAssigned
 */
@fixed
enum CmkIdentityType {
  SystemAssigned,
  UserAssigned,
}

/**
 * The identity type.
 */
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The key to regenerate.
 */
@fixed
enum KeyName {
  key1,
  key2,
}

/**
 * The properties of a Fluid Relay Service resource.
 */
model FluidRelayServerProperties {
  /**
   * The Fluid tenantId for this server
   */
  @visibility("read")
  frsTenantId?: string;

  /**
   * The Fluid Relay Service endpoints for this server.
   */
  @visibility("read")
  fluidRelayEndpoints?: FluidRelayEndpoints;

  /**
   * Provision states for FluidRelay RP
   */
  provisioningState?: ProvisioningState;

  /**
   * All encryption configuration for a resource.
   */
  encryption?: EncryptionProperties;

  /**
   * Sku of the storage associated with the resource
   */
  storagesku?: StorageSKU;
}

/**
 * The Fluid Relay endpoints for this server
 */
model FluidRelayEndpoints {
  /**
   * The Fluid Relay Orderer endpoints.
   */
  @visibility("read")
  ordererEndpoints?: string[];

  /**
   * The Fluid Relay storage endpoints.
   */
  @visibility("read")
  storageEndpoints?: string[];

  /**
   * The Fluid Relay service endpoints.
   */
  @visibility("read")
  serviceEndpoints?: string[];
}

/**
 * All encryption configuration for a resource.
 */
model EncryptionProperties {
  /**
   * All Customer-managed key encryption properties for the resource.
   */
  customerManagedKeyEncryption?: CustomerManagedKeyEncryptionProperties;
}

/**
 * All Customer-managed key encryption properties for the resource.
 */
model CustomerManagedKeyEncryptionProperties {
  /**
   * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
   */
  keyEncryptionKeyIdentity?: CustomerManagedKeyEncryptionPropertiesKeyEncryptionKeyIdentity;

  /**
   * key encryption key Url, with or without a version. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek. Key auto rotation is enabled by providing a key uri without version. Otherwise, customer is responsible for rotating the key. The keyEncryptionKeyIdentity(either SystemAssigned or UserAssigned) should have permission to access this key url.
   */
  keyEncryptionKeyUrl?: string;
}

/**
 * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
 */
model CustomerManagedKeyEncryptionPropertiesKeyEncryptionKeyIdentity {
  /**
   * Values can be SystemAssigned or UserAssigned
   */
  identityType?: CmkIdentityType;

  /**
   * user assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity.
   */
  userAssignedIdentityResourceId?: string;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the resource.
   */
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
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
}

/**
 * The updatable properties of a Fluid Relay server
 */
model FluidRelayServerUpdate {
  /**
   * The resource-specific properties that can be updated for this resource.
   */
  @visibility("read", "create", "update")
  properties?: FluidRelayServerUpdateProperties;

  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * The type of identity used for the resource.
   */
  identity?: Identity;

  /**
   * The geo-location where the resource lives
   */
  location?: string;
}

/**
 * The properties that can be provided when updating FluidRelayServer resource
 */
model FluidRelayServerUpdateProperties {
  /**
   * All encryption configuration for a resource.
   */
  encryption?: EncryptionProperties;
}

/**
 * Specifies which key should be generated.
 */
model RegenerateKeyRequest {
  /**
   * The key to regenerate.
   */
  keyName: KeyName;
}

/**
 * The set of available keys for this server.
 */
model FluidRelayServerKeys {
  /**
   * The primary key for this server
   */
  @visibility("read")
  @secret
  key1?: string;

  /**
   * The secondary key for this server
   */
  @visibility("read")
  @secret
  key2?: string;
}

/**
 * The properties of a Fluid Relay Container resource.
 */
model FluidRelayContainerProperties {
  /**
   * The Fluid tenantId for this container
   */
  @visibility("read")
  frsTenantId?: string;

  /**
   * The frsContainerId for this container
   */
  @visibility("read")
  frsContainerId?: string;

  /**
   * Provision states for FluidRelay RP
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The creation time of this resource
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Last time when user access this resource
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAccessTime?: utcDateTime;
}

/**
 * A FluidRelay REST API operation.
 */
model OperationResult {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;
}
