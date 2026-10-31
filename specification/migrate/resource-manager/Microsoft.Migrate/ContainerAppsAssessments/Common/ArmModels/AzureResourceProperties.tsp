import "../Enums/Enums.tsp";

namespace Microsoft.Migrate;

@doc("Common properties for all azure tracked and proxy resources.")
model AzureResourceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
