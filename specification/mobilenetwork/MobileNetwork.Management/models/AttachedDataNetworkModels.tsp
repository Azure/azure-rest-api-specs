import "@typespec/openapi";
import "@typespec/versioning";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@doc("Whether network address and port translation is enabled.")
union NaptEnabled {
  @doc("NAPT is enabled")
  Enabled: "Enabled",

  @doc("NAPT is disabled")
  Disabled: "Disabled",

  string,
}

@doc("Data network properties.")
model AttachedDataNetworkPropertiesFormat {
  @doc("The provisioning state of the attached data network resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The user plane interface on the data network. For 5G networks, this is the N6 interface. For 4G networks, this is the SGi interface.")
  userPlaneDataInterface: InterfaceProperties;

  @doc("The DNS servers to signal to UEs to use for this attached data network. This configuration is mandatory - if you don't want DNS servers, you must provide an empty array.")
  dnsAddresses: Ipv4Addr[];

  @doc("The network address and port translation (NAPT) configuration.\nIf this is not specified, the attached data network will use a default NAPT configuration with NAPT enabled.")
  naptConfiguration?: NaptConfiguration;

  @doc("The user equipment (UE) address pool prefixes for the attached data network from which the packet core instance will dynamically assign IP addresses to UEs.\nThe packet core instance assigns an IP address to a UE when the UE sets up a PDU session.\n You must define at least one of userEquipmentAddressPoolPrefix and userEquipmentStaticAddressPoolPrefix. If you define both, they must be of the same size.")
  @minItems(1)
  userEquipmentAddressPoolPrefix?: Ipv4AddrMask[];

  @doc("The user equipment (UE) address pool prefixes for the attached data network from which the packet core instance will assign static IP addresses to UEs.\nThe packet core instance assigns an IP address to a UE when the UE sets up a PDU session. The static IP address for a specific UE is set in StaticIPConfiguration on the corresponding SIM resource.\nAt least one of userEquipmentAddressPoolPrefix and userEquipmentStaticAddressPoolPrefix must be defined. If both are defined, they must be of the same size.")
  @minItems(1)
  userEquipmentStaticAddressPoolPrefix?: Ipv4AddrMask[];

  @removed(Versions.v2024_06_01)
  @doc("The user equipment (UE) address pool prefixes for the attached data network from which the packet core instance will assign IP addresses to UEs. Can contain either static or dynamic UE IP Pools.\nThe packet core instance assigns an IP address to a UE when the UE sets up a PDU session. For a static UE IP Pool, the static IP address for a specific UE is set in StaticIPConfiguration on the corresponding SIM resource.\nYou must define either userEquipmentAddressPools, or at least one of userEquipmentAddressPoolPrefix or userEquipmentStaticAddressPoolPrefix. If you define more than one, they must be of the same size.")
  @minItems(1)
  @extension("x-ms-identifiers", [])
  userEquipmentAddressPools?: UserEquipmentAddressPool[];
}

@doc("The network address and port translation settings to use for the attached data network.")
model NaptConfiguration {
  @doc("Whether NAPT is enabled for connections to this attached data network.")
  enabled?: NaptEnabled = NaptEnabled.Enabled;

  @doc("Range of port numbers to use as translated ports on each translated address.\nIf not specified and NAPT is enabled, this range defaults to 1,024 - 49,999.\n(Ports under 1,024 should not be used because these are special purpose ports reserved by IANA. Ports 50,000 and above are reserved for non-NAPT use.)")
  portRange?: PortRange;

  @doc("The minimum time (in seconds) that will pass before a port that was used by a closed pinhole can be recycled for use by another pinhole. All hold times must be at least 1 second.")
  portReuseHoldTime?: PortReuseHoldTimes;

  @doc("Maximum number of UDP and TCP pinholes that can be open simultaneously on the core interface. For 5G networks, this is the N6 interface. For 4G networks, this is the SGi interface.")
  @maxValue(65536)
  @minValue(1)
  pinholeLimits?: int32 = 65536;

  @doc("Expiry times of inactive NAPT pinholes, in seconds. All timers must be at least 1 second.")
  pinholeTimeouts?: PinholeTimeouts;
}

@doc("Range of port numbers to use as translated ports on each translated address.\nIf not specified and NAPT is enabled, this range defaults to 1,024 - 49,999.\n(Ports under 1,024 should not be used because these are special purpose ports reserved by IANA. Ports 50,000 and above are reserved for non-NAPT use.)")
model PortRange {
  @doc("The minimum port number")
  @maxValue(65535)
  @minValue(1024)
  minPort?: int32 = 1024;

  @doc("The maximum port number")
  @maxValue(65535)
  @minValue(1024)
  maxPort?: int32 = 49999;
}

@doc("The minimum time (in seconds) that will pass before a port that was used by a closed pinhole can be recycled for use by another pinhole. All hold times must be minimum 1 second.")
model PortReuseHoldTimes {
  @doc("Minimum time in seconds that will pass before a TCP port that was used by a closed pinhole can be reused. Default for TCP is 2 minutes.")
  @minValue(1)
  tcp?: int32 = 120;

  @doc("Minimum time in seconds that will pass before a UDP port that was used by a closed pinhole can be reused. Default for UDP is 1 minute.")
  @minValue(1)
  udp?: int32 = 60;
}

@doc("Expiry times of inactive NAPT pinholes, in seconds. All timers must be at least 1 second.")
model PinholeTimeouts {
  @doc("Pinhole timeout for TCP pinholes in seconds. Default for TCP is 3 minutes.")
  @minValue(1)
  tcp?: int32 = 180;

  @doc("Pinhole timeout for UDP pinholes in seconds. Default for UDP is 30 seconds.")
  @minValue(1)
  udp?: int32 = 30;

  @doc("Pinhole timeout for ICMP pinholes in seconds. Default for ICMP Echo is 30 seconds.")
  @minValue(1)
  icmp?: int32 = 30;
}
