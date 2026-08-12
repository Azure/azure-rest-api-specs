import "@azure-tools/typespec-azure-resource-manager";
import "./SiteModels.tsp";

using Azure.ResourceManager;

namespace Microsoft.Network;

@doc("Properties of a probing gateway association with a Private Traffic Manager profile.")
model ProfileProbingGatewayProperties {
  @doc("The ARM resource ID of the probing gateway.")
  probingGatewayId: ProbingGatewayId;

  @visibility(Lifecycle.Read)
  @doc("Provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
