import "../common/CommonModels.tsp";

namespace Microsoft.MobileNetwork;

@doc("SIM group properties.")
model SimGroupPropertiesFormat {
  @doc("The provisioning state of the SIM group resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A key to encrypt the SIM data that belongs to this SIM group.")
  encryptionKey?: KeyVaultKey;

  @doc("Mobile network that this SIM group belongs to. The mobile network must be in the same location as the SIM group.")
  mobileNetwork?: MobileNetworkResourceId;
}

@doc("An Azure key vault key.")
model KeyVaultKey {
  @doc("The key URL, unversioned. For example: https://contosovault.vault.azure.net/keys/azureKey.")
  keyUrl?: string;
}
