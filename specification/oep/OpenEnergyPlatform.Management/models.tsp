import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.OpenEnergyPlatform;

@doc("The provisioning state of the resource.")
union ProvisioningState {
  string,

  @doc("Resource has been created successfully.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("Resource is being created.")
  Creating: "Creating",

  @doc("Resource is being deleted.")
  Deleting: "Deleting",

  @doc("Resource is being updated.")
  Updating: "Updating",

  @doc("Resource state is unknown.")
  Unknown: "Unknown",
}

// ============================================================================
// Identity Models (added in 2022-04-04-preview)
// ============================================================================

@doc("The type of managed identity used by the resource.")
@added(Versions.v2022_04_04_preview)
union ManagedIdentityType {
  string,

  @doc("System assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User assigned managed identity.")
  UserAssigned: "UserAssigned",

  @doc("Both system and user assigned managed identities.")
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",

  @doc("Both user and system assigned managed identities (alternate ordering).")
  `UserAssigned,SystemAssigned`: "UserAssigned,SystemAssigned",
}

@doc("User assigned identity properties.")
@added(Versions.v2022_04_04_preview)
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility(Lifecycle.Read)
  principalId?: string;

  @doc("The client ID of the assigned identity.")
  @visibility(Lifecycle.Read)
  clientId?: string;
}

@doc("Managed service identity (system assigned and/or user assigned identities).")
@added(Versions.v2022_04_04_preview)
model ManagedServiceIdentity {
  @doc("The type of managed identity assigned to the resource.")
  type: ManagedIdentityType;

  @doc("The service principal ID of the system assigned identity.")
  @visibility(Lifecycle.Read)
  principalId?: string;

  @doc("The tenant ID of the system assigned identity.")
  @visibility(Lifecycle.Read)
  tenantId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User assigned identities use Record type per ARM convention"
  @doc("The set of user assigned identities associated with the resource.")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

// ============================================================================
// Encryption Models (added in 2022-04-04-preview)
// ============================================================================

@doc("Key Vault properties for encryption.")
@added(Versions.v2022_04_04_preview)
model KeyVaultProperties {
  @doc("The name of the Key Vault key.")
  keyName?: string;

  @doc("The URI of the Key Vault.")
  keyVaultUri?: string;

  @doc("The user assigned identity resource ID to use for Key Vault access.")
  userIdentity?: string;
}

@doc("Customer-managed key encryption settings.")
@added(Versions.v2022_04_04_preview)
model EncryptionProperties {
  @doc("Key Vault properties for customer-managed keys.")
  keyVaultProperties?: KeyVaultProperties;
}

// ============================================================================
// SKU Model (added in 2022-04-04-preview)
// ============================================================================

@doc("The SKU of the energy service resource.")
@added(Versions.v2022_04_04_preview)
model EnergyServiceSku {
  @doc("The SKU name.")
  name: string;
}

@doc("The properties of an Energy service resource.")
model EnergyServiceProperties {
  @doc("The DNS name of the energy service resource.")
  @visibility(Lifecycle.Read)
  dnsName?: string;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The authentication application ID.")
  authAppId?: string;

  @doc("The list of data partition names.")
  dataPartitionNames?: DataPartitionNames[];

  @doc("Encryption settings for the resource.")
  @added(Versions.v2022_04_04_preview)
  encryption?: EncryptionProperties;

  @doc("The SKU of the resource.")
  @added(Versions.v2022_04_04_preview)
  sku?: EnergyServiceSku;
}

@doc("The data partition name.")
model DataPartitionNames {
  @doc("The name of the data partition.")
  name: string;
}

@doc("The resource model definition used for updating a tracked ARM resource.")
model EnergyResourceUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags use Record type per ARM convention"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Managed identity settings.")
  @added(Versions.v2022_04_04_preview)
  identity?: ManagedServiceIdentity;

  @doc("Resource properties to patch.")
  @added(Versions.v2022_04_04_preview)
  properties?: EnergyServicePropertiesPatch;
}

@doc("Patchable properties for EnergyService.")
@added(Versions.v2022_04_04_preview)
model EnergyServicePropertiesPatch {
  @doc("Encryption settings to patch.")
  encryption?: EncryptionProperties;
}

@doc("Defines the partition add or remove action properties.")
model DataPartitionAddOrRemoveRequest {
  @doc("The data partition name.")
  name: DataPartitionNames;
}

@doc("Defines the properties of an individual data partition.")
model DataPartitionProperties {
  @doc("Name of the data partition.")
  name?: string;

  @doc("Provisioning state of the data partition.")
  provisioningState?: string;
}

@doc("List of data partitions.")
model DataPartitionsListResult {
  @doc("List of data partitions along with their properties in a given OEP resource.")
  dataPartitionInfo?: DataPartitionProperties[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Existing API requires empty body for listPartitions"
@doc("Empty request body for list partitions action.")
model ListPartitionsRequest {}
