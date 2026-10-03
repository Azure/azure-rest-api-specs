import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Network;

scalar VirtualNetworkId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks",
    }
  ]>;

scalar SiteId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/topologyMaps/sites",
    }
  ]>;

@doc("An IP address or address range used to identify a network. Provide first alone for a single IP, first and scope for a CIDR range, or first and last for an explicit range. Last and scope are mutually exclusive.")
model IpAddressRange {
  @doc("The first IP address in the range.")
  first?: string;

  @doc("The last IP address in the range. Specify either last or scope, but not both. When omitted with scope, the range contains only the first IP address.")
  last?: string;

  @doc("The number of leading bits in the subnet mask. Specify either scope or last, but not both.")
  scope?: int32;
}

// NOTE: `Microsoft.Network/probingGateways` is a separate resource provider owned
// by a sister team and shipped independently. This scalar references that cross-RP
// resource type; do not confuse it with the `ProfileProbingGateway` child resource
// (`Microsoft.Network/privateTrafficManagerProfiles/probingGateways`), which is an
// association between a Private Traffic Manager profile and a probing gateway.
scalar ProbingGatewayId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/probingGateways",
    }
  ]>;

@doc("Class representing the Site properties.")
model SiteProperties {
  @doc("The ARM resource ID of the probing gateway that can be used to monitor health as surrogate to the networks in the Site.")
  probingGatewayIds?: ProbingGatewayId[];

  @doc("The list of Network IDs that forms the Site.")
  virtualNetworkIds?: VirtualNetworkId[];

  @doc("The IP address ranges that form the Site. Each item represents either a single IP address, a CIDR range using first and scope, or an address range using first and last. A Site can contain either virtual networks or subnet ranges, but not both.")
  @identifiers(#[])
  subnets?: IpAddressRange[];

  @visibility(Lifecycle.Read)
  @doc("Provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
