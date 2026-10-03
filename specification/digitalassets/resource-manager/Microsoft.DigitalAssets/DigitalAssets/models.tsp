using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Microsoft.DigitalAssets;

@doc("Reference to an Azure Key Vault resource.")
model KeyVaultReference {
  @doc("The ARM resource ID of the Key Vault.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}
