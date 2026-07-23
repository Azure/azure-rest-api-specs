import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Management mode for the Fabric.")
@added(Versions.v2026_01_15_preview)
union ManagementMode {
  string,

  @doc("Customer manages devices.")
  unmanaged: "unmanaged",

  @doc("RP manages devices.")
  managed: "managed",
}

@doc("Controller type for device interaction.")
@added(Versions.v2026_01_15_preview)
union ControllerType {
  string,

  @doc("Cisco ACI APIC REST API.")
  ciscoAci: "ciscoAci",

  @doc("Arista CloudVision API.")
  aristaCloudVision: "aristaCloudVision",

  @doc("Direct gNMI/SSH.")
  direct: "direct",
}

@doc("Operation policy for device interaction.")
@added(Versions.v2026_01_15_preview)
union OperationPolicy {
  string,

  @doc("Read device state and report drift.")
  validateOnly: "validateOnly",

  @doc("Read, write, and remediate drift.")
  fullControl: "fullControl",
}

@doc("Infrastructure network definition.")
@added(Versions.v2026_01_15_preview)
model InfraNetwork {
  @doc("802.1Q VLAN ID.")
  @minValue(1)
  @maxValue(4094)
  vlanId: int32;

  @doc("IPv4 subnet in CIDR notation.")
  ipv4Subnet: string;

  @doc("Default gateway IP.")
  ipv4Gateway: string;

  @doc("Start of allocatable IP range.")
  ipv4StartAddr: string;

  @doc("End of allocatable IP range.")
  ipv4EndAddr: string;

  @doc("Maximum Transmission Unit.")
  mtu?: int32;
}

@doc("Infrastructure network with optional IP fields.")
@added(Versions.v2026_01_15_preview)
model InfraNetworkOptionalIp {
  @doc("802.1Q VLAN ID.")
  @minValue(1)
  @maxValue(4094)
  vlanId: int32;

  @doc("IPv4 subnet in CIDR notation.")
  ipv4Subnet?: string;

  @doc("Default gateway IP.")
  ipv4Gateway?: string;

  @doc("Start of allocatable IP range.")
  ipv4StartAddr?: string;

  @doc("End of allocatable IP range.")
  ipv4EndAddr?: string;

  @doc("Maximum Transmission Unit.")
  mtu?: int32;
}

@doc("Named infrastructure network definitions.")
@added(Versions.v2026_01_15_preview)
model InfrastructureNetworks {
  @doc("OAM management network. Typical VLAN: 39.")
  management: InfraNetwork;

  @doc("PXE boot network. Typical VLAN: 40.")
  pxe: InfraNetwork;

  @doc("BMC/iDRAC network. Typical VLAN: 41.")
  bmc: InfraNetwork;

  @doc("Storage data plane network. Typical VLAN: 42.")
  storage: InfraNetwork;

  @doc("Storage management plane network. Typical VLAN: 37.")
  storageMgmt?: InfraNetworkOptionalIp;

  @doc("PDU management network. Typical VLAN: 43.")
  pdu?: InfraNetwork;
}

@doc("Platform proxy configuration.")
@added(Versions.v2026_01_15_preview)
model PlatformProxy {
  @doc("HTTP proxy endpoint URL.")
  httpProxy: string;

  @doc("HTTPS proxy endpoint URL.")
  httpsProxy: string;

  @doc("CIDRs, hostnames, and domain suffixes that bypass the proxy.")
  noProxy: string[];
}

@doc("Infrastructure service endpoints.")
@added(Versions.v2026_01_15_preview)
model InfrastructureServices {
  @doc("Platform proxy configuration.")
  platformProxy: PlatformProxy;

  @doc("NTP server IPs or hostnames.")
  @minItems(1)
  ntpServers: string[];

  @doc("DNS server IPs.")
  @minItems(1)
  dnsServers: string[];
}

// --- Patch variants (all fields optional for PATCH operations) ---

@doc("Infrastructure network definition for PATCH. All fields optional.")
@added(Versions.v2026_01_15_preview)
model PatchInfraNetwork {
  @doc("802.1Q VLAN ID.")
  @minValue(1)
  @maxValue(4094)
  vlanId?: int32;

  @doc("IPv4 subnet in CIDR notation.")
  ipv4Subnet?: string;

  @doc("Default gateway IP.")
  ipv4Gateway?: string;

  @doc("Start of allocatable IP range.")
  ipv4StartAddr?: string;

  @doc("End of allocatable IP range.")
  ipv4EndAddr?: string;

  @doc("Maximum Transmission Unit.")
  mtu?: int32;
}

@doc("Infrastructure network definitions for PATCH. No networks required.")
@added(Versions.v2026_01_15_preview)
model PatchInfrastructureNetworks {
  @doc("OAM management network.")
  management?: PatchInfraNetwork;

  @doc("PXE boot network.")
  pxe?: PatchInfraNetwork;

  @doc("BMC/iDRAC network.")
  bmc?: PatchInfraNetwork;

  @doc("Storage data plane network.")
  storage?: PatchInfraNetwork;

  @doc("Storage management plane network.")
  storageMgmt?: PatchInfraNetwork;

  @doc("PDU management network.")
  pdu?: PatchInfraNetwork;
}

@doc("Platform proxy configuration for PATCH. All fields optional.")
@added(Versions.v2026_01_15_preview)
model PatchPlatformProxy {
  @doc("HTTP proxy endpoint URL.")
  httpProxy?: string;

  @doc("HTTPS proxy endpoint URL.")
  httpsProxy?: string;

  @doc("CIDRs, hostnames, and domain suffixes that bypass the proxy.")
  noProxy?: string[];
}

@doc("Infrastructure service endpoints for PATCH. All fields optional.")
@added(Versions.v2026_01_15_preview)
model PatchInfrastructureServices {
  @doc("Platform proxy configuration.")
  platformProxy?: PatchPlatformProxy;

  @doc("NTP server IPs or hostnames.")
  ntpServers?: string[];

  @doc("DNS server IPs.")
  dnsServers?: string[];
}

@doc("Fabric patchable properties.")
@added(Versions.v2026_01_15_preview)
model FabricPatchableProperties {
  @doc("Infrastructure network definitions.")
  infrastructureNetworks?: PatchInfrastructureNetworks;

  @doc("Infrastructure service endpoints.")
  infrastructureServices?: PatchInfrastructureServices;

  @doc("Operation policy for device interaction.")
  operationPolicy?: OperationPolicy;

  @doc("URL of the SDN controller API endpoint.")
  controllerEndpoint?: string;

  @doc("ARM resource ID of the Key Vault secret for controller credentials.")
  controllerCredentialRef?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults/secrets";
    }
  ]>;
}

@doc("Fabric patch body.")
@added(Versions.v2026_01_15_preview)
model FabricPatch {
  ...TagsUpdate;

  @doc("Resource properties.")
  properties?: FabricPatchableProperties;
}

@doc("FabricProperties defines the resource properties.")
@added(Versions.v2026_01_15_preview)
model FabricProperties {
  @doc("Infrastructure network definitions.")
  infrastructureNetworks?: InfrastructureNetworks;

  @doc("Infrastructure service endpoints.")
  infrastructureServices?: InfrastructureServices;

  @doc("Operation policy for device interaction.")
  operationPolicy?: OperationPolicy;

  @doc("URL of the SDN controller API endpoint.")
  controllerEndpoint?: string;

  @doc("ARM resource ID of the Key Vault secret for controller credentials.")
  controllerCredentialRef?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults/secrets";
    }
  ]>;

  @doc("ARM resource ID of the EdgeConnector.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  edgeConnectorId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/edgeConnectors";
    }
  ]>;

  @doc("Management mode.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managementMode: ManagementMode;

  @doc("Controller type for device interaction.")
  controllerType?: ControllerType;

  @doc("Number of physical racks.")
  rackCount?: int32;

  @doc("Predefined topology identifier.")
  fabricSku?: string;

  @doc("ARM ID of the customer's Azure VNet.")
  customerVnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  @doc("ARM ID of the customer's subnet.")
  customerSubnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
