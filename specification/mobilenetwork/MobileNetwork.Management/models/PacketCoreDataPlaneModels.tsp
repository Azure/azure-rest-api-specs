import "../common/CommonModels.tsp";

namespace Microsoft.MobileNetwork;

@doc("Packet core data plane properties.")
model PacketCoreDataPlanePropertiesFormat {
  @doc("The provisioning state of the packet core data plane resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The user plane interface on the access network. For 5G networks, this is the N3 interface. For 4G networks, this is the S1-U interface.")
  userPlaneAccessInterface: InterfaceProperties;

  @doc("The virtual IP address(es) for the user plane on the access network in a High Availability (HA) system. In an HA deployment the access network router should be configured to forward traffic for this address to the control plane access interface on the active or standby node. In non-HA system this list should be omitted or empty.")
  userPlaneAccessVirtualIpv4Addresses?: Ipv4Addr[];
}
