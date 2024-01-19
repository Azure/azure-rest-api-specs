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

@doc("Provision states for FluidRelay RP")
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

@doc("Sku of the storage associated with the resource")
enum StorageSKU {
  standard,
  basic,
}

@doc("Values can be SystemAssigned or UserAssigned")
@fixed
enum CmkIdentityType {
  SystemAssigned,
  UserAssigned,
}

@doc("The identity type.")
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("The key to regenerate.")
@fixed
enum KeyName {
  key1,
  key2,
}

@doc("The properties of a Fluid Relay Service resource.")
model FluidRelayServerProperties {
  @doc("The Fluid tenantId for this server")
  @visibility("read")
  frsTenantId?: string;

  @doc("The Fluid Relay Service endpoints for this server.")
  @visibility("read")
  fluidRelayEndpoints?: FluidRelayEndpoints;

  @doc("Provision states for FluidRelay RP")
  provisioningState?: ProvisioningState;

  @doc("All encryption configuration for a resource.")
  encryption?: EncryptionProperties;

  @doc("Sku of the storage associated with the resource")
  storagesku?: StorageSKU;
}

@doc("The Fluid Relay endpoints for this server")
model FluidRelayEndpoints {
  @doc("The Fluid Relay Orderer endpoints.")
  @visibility("read")
  ordererEndpoints?: string[];

  @doc("The Fluid Relay storage endpoints.")
  @visibility("read")
  storageEndpoints?: string[];

  @doc("The Fluid Relay service endpoints.")
  @visibility("read")
  serviceEndpoints?: string[];
}

@doc("All encryption configuration for a resource.")
model EncryptionProperties {
  @doc("All Customer-managed key encryption properties for the resource.")
  customerManagedKeyEncryption?: CustomerManagedKeyEncryptionProperties;
}

@doc("All Customer-managed key encryption properties for the resource.")
model CustomerManagedKeyEncryptionProperties {
  @doc("All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.")
  keyEncryptionKeyIdentity?: CustomerManagedKeyEncryptionPropertiesKeyEncryptionKeyIdentity;

  @doc("key encryption key Url, with or without a version. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek. Key auto rotation is enabled by providing a key uri without version. Otherwise, customer is responsible for rotating the key. The keyEncryptionKeyIdentity(either SystemAssigned or UserAssigned) should have permission to access this key url.")
  keyEncryptionKeyUrl?: string;
}

@doc("All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.")
model CustomerManagedKeyEncryptionPropertiesKeyEncryptionKeyIdentity {
  @doc("Values can be SystemAssigned or UserAssigned")
  identityType?: CmkIdentityType;

  @doc("user assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity.")
  userAssignedIdentityResourceId?: string;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: ResourceIdentityType;

  @doc("The list of user identities associated with the resource.")
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

model UserAssignedIdentitiesValue {
  @doc("The principal id of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client id of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("The updatable properties of a Fluid Relay server")
model FluidRelayServerUpdate {
  @doc("The resource-specific properties that can be updated for this resource.")
  @visibility("read", "create", "update")
  properties?: FluidRelayServerUpdateProperties;

  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("The type of identity used for the resource.")
  identity?: Identity;

  @doc("The geo-location where the resource lives")
  location?: string;
}

@doc("The properties that can be provided when updating FluidRelayServer resource")
model FluidRelayServerUpdateProperties {
  @doc("All encryption configuration for a resource.")
  encryption?: EncryptionProperties;
}

@doc("Specifies which key should be generated.")
model RegenerateKeyRequest {
  @doc("The key to regenerate.")
  keyName: KeyName;
}

@doc("The set of available keys for this server.")
model FluidRelayServerKeys {
  @doc("The primary key for this server")
  @visibility("read")
  @secret
  key1?: string;

  @doc("The secondary key for this server")
  @visibility("read")
  @secret
  key2?: string;
}

@doc("The properties of a Fluid Relay Container resource.")
model FluidRelayContainerProperties {
  @doc("The Fluid tenantId for this container")
  @visibility("read")
  frsTenantId?: string;

  @doc("The frsContainerId for this container")
  @visibility("read")
  frsContainerId?: string;

  @doc("Provision states for FluidRelay RP")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The creation time of this resource")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Last time when user access this resource")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAccessTime?: utcDateTime;
}

@doc("A FluidRelay REST API operation.")
model OperationResult {
  @doc("Operation name: {provider}/{resource}/{operation}")
  name?: string;

  @doc("The object that represents the operation.")
  display?: OperationDisplay;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;
}
