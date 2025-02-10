using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20241031)
@doc("The properties of landing zone account resource type.")
model LandingZoneAccountResourceProperties {
  @visibility("read")
  @doc("The status of a user-initiated, control-plane operation on the landing zone account.")
  provisioningState?: provisioningState;

  @doc("The storage account that will host the generated slz code.")
  storageAccount: armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;
}
