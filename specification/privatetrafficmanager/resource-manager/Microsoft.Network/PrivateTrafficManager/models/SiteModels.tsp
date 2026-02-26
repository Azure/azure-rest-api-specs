import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Network;

scalar VirtualNetworkId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks",
    }
  ]>;

scalar ProbingGatewayId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/ProbingGateways",
    }
  ]>;

@doc("Class representing the Site properties.")
model SiteProperties {
  @doc("The ARM resource ID of the probing gateway that can be used to monitor health as surrogate to the networks in the Site.")
  probingGatewayIds?: ProbingGatewayId[];

  @doc("The list of Network IDs that forms the Site.")
  virtualNetworkIds?: VirtualNetworkId[];

  @visibility(Lifecycle.Read)
  @doc("Provisioning state of the resource.")
  provisioningState?: provisioningStateProperties;
}
