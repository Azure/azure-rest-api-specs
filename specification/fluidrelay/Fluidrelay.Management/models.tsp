import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.FluidRelay;

/**
 * Provision states for FluidRelay RP
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Sku of the storage associated with the resource
 */
union StorageSKU {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  standard: "standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  basic: "basic",
}

/**
 * Values can be SystemAssigned or UserAssigned
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum CmkIdentityType {
  SystemAssigned,
  UserAssigned,
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The key to regenerate.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum KeyName {
  key1,
  key2,
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

/**
 * The properties of a Fluid Relay Service resource.
 */
model FluidRelayServerProperties {
  /**
   * The Fluid tenantId for this server
   */
  @visibility(Lifecycle.Read)
  frsTenantId?: string;

  /**
   * The Fluid Relay Service endpoints for this server.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  ordererEndpoints?: string[];

  /**
   * The Fluid Relay storage endpoints.
   */
  @visibility(Lifecycle.Read)
  storageEndpoints?: string[];

  /**
   * The Fluid Relay service endpoints.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
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
}

/**
 * The updatable properties of a Fluid Relay server
 */
model FluidRelayServerUpdate {
  /**
   * The resource-specific properties that can be updated for this resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: FluidRelayServerUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
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
  @visibility(Lifecycle.Read)
  @secret
  key1?: string;

  /**
   * The secondary key for this server
   */
  @visibility(Lifecycle.Read)
  @secret
  key2?: string;
}

/**
 * Paged response
 */
model FluidRelayServerList is Azure.Core.Page<FluidRelayServer>;

/**
 * The properties of a Fluid Relay Container resource.
 */
model FluidRelayContainerProperties {
  /**
   * The Fluid tenantId for this container
   */
  @visibility(Lifecycle.Read)
  frsTenantId?: string;

  /**
   * The frsContainerId for this container
   */
  @visibility(Lifecycle.Read)
  frsContainerId?: string;

  /**
   * Provision states for FluidRelay RP
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The creation time of this resource
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Last time when user access this resource
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAccessTime?: utcDateTime;
}

/**
 * Paged response
 */
model FluidRelayContainerList is Azure.Core.Page<FluidRelayContainer>;
