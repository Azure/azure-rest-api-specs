using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20250227)
@doc("The properties of landing zone account resource type.")
model LandingZoneAccountResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The state that reflects the current stage in the creation, updating, or deletion process of the landing zone account.")
  provisioningState?: provisioningState;

  @doc("The storage account that will host the generated infrastructure as code (IaC) for a landing zone deployment.")
  storageAccount: armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;
}
