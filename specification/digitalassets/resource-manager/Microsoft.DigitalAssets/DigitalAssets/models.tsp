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

@doc("Represents the operational status of the resource.")
model OperationalStatus {
  @doc("The current state of the operational status.")
  status: string;

  @doc("The timestamp of the last status evaluation.")
  evaluatedAt: utcDateTime;

  @doc("The timestamp until which the current status is considered valid.")
  validUntil: utcDateTime;
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
