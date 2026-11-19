import "./common.tsp";

using TypeSpec.Versioning;
using TypeSpec.Reflection;

namespace Microsoft.ManagedNetworkFabric;

@doc("NetworkFabricControllerProperties defines the resource properties.")
model NetworkFabricControllerProperties {
  ...AnnotationResource;
  ...NetworkFabricControllerPatchableProperties;

  @doc("InfrastructureServices IP ranges.")
  @visibility(Lifecycle.Read)
  infrastructureServices?: ControllerServices;

  @doc("WorkloadServices IP ranges.")
  @visibility(Lifecycle.Read)
  workloadServices?: ControllerServices;

  @doc("Managed Resource Group configuration properties.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("The NF-ID will be an input parameter used by the NF to link and get associated with the parent NFC Service.")
  @visibility(Lifecycle.Read)
  networkFabricIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>[];

  @doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints. This is used for the backward compatibility.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2024_06_15_preview)
  workloadManagementNetwork?: boolean = true;

  @doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.")
  isWorkloadManagementNetworkEnabled?: IsWorkloadManagementNetworkEnabled = IsWorkloadManagementNetworkEnabled.True;

  @doc("List of tenant InternetGateway resource IDs")
  @visibility(Lifecycle.Read)
  tenantInternetGatewayIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGateways";
    }
  ]>[];

  @doc("IPv4 Network Fabric Controller Address Space.")
  @minLength(1)
  ipv4AddressSpace?: string = "10.0.0.0/19";

  @doc("IPv6 Network Fabric Controller Address Space.")
  @minLength(1)
  ipv6AddressSpace?: string = "FC00::/59";

  @doc("Network Fabric Controller SKU.")
  nfcSku?: NfcSku = NfcSku.Standard;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of NFC provisioning.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Operational state of networkFabricController indicating if the resources of the controller are reachable and services are available.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_01_15_preview)
  operationalState?: OperationalState;

  @doc("The VM profile configuration for the NFC's associated compute (VM) resources.")
  @added(Versions.v2026_01_15_preview)
  vmProfile?: VmProfile;
}

@doc("Network Fabric Controller updatable properties")
model NetworkFabricControllerPatchableProperties {
  @doc("As part of an update, the Infrastructure ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Infrastructure services. (This is a Mandatory attribute)")
  @Azure.ResourceManager.identifiers(#["expressRouteCircuitId"])
  infrastructureExpressRouteConnections?: ExpressRouteConnectionInformation[];

  @doc("As part of an update, the workload ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Workload services. (This is a Mandatory attribute).")
  @Azure.ResourceManager.identifiers(#["expressRouteCircuitId"])
  workloadExpressRouteConnections?: ExpressRouteConnectionInformation[];

  @doc("Public connectivity configuration. including VPN Gateway SKU input and the read-only VPN Gateway information provisioned by the platform.")
  @added(Versions.v2026_07_15_preview)
  publicConnectivity?: PublicConnectivity;
}

@doc("Network Fabric Controller services.")
model ControllerServices {
  @doc("The IPv4 Address space is optional, if the value is not defined at the time of NFC creation, then the default value 10.0.0.0/19 is considered. The IPV4 address subnet is an optional attribute.")
  ipv4AddressSpaces?: string[];

  @doc("The IPv6 is not supported right now.")
  ipv6AddressSpaces?: string[];
}

@doc("Managed Resource Group configuration properties.")
model ManagedResourceGroupConfiguration {
  @doc("The NFC service will be hosted in a Managed resource group.")
  name?: string;

  @doc("Managed resource group location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@doc("The ExpressRoute circuit ID and the Auth Key are required for you to successfully deploy NFC service.")
model ExpressRouteConnectionInformation {
  @doc("The express route circuit Azure resource ID, must be of type Microsoft.Network/expressRouteCircuits/circuitName. The ExpressRoute Circuit is a mandatory attribute.")
  expressRouteCircuitId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/expressRouteCircuits";
    }
  ]>;

  @doc("Authorization key for the circuit, must be of type Microsoft.Network/expressRouteCircuits/authorizations. The Auth Key is a mandatory attribute.")
  @secret
  expressRouteAuthorizationKey: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending instead of spread to avoid breaking changes in patch models"
@doc("The Network Fabric Controller Patch payload definition.")
model NetworkFabricControllerPatch extends TagsUpdate {
  @doc("Network Fabric Controller patch properties.")
  properties?: NetworkFabricControllerPatchProperties;

  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentityPatch;
}

@doc("Network Fabric Controller patch properties.")
model NetworkFabricControllerPatchProperties {
  @doc("As part of an update, the Infrastructure ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Infrastructure services. (This is a Mandatory attribute)")
  @Azure.ResourceManager.identifiers(#["expressRouteCircuitId"])
  infrastructureExpressRouteConnections?: ExpressRouteConnectionInformation[];

  @doc("As part of an update, the workload ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Workload services. (This is a Mandatory attribute).")
  @Azure.ResourceManager.identifiers(#["expressRouteCircuitId"])
  workloadExpressRouteConnections?: ExpressRouteConnectionInformation[];
}

@doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.")
union IsWorkloadManagementNetworkEnabled {
  @doc("IsWorkloadManagementNetworkEnabled-True")
  True: "True",

  @doc("IsWorkloadManagementNetworkEnabled-False")
  False: "False",

  string,
}

@doc("Network Fabric Controller SKU.")
union NfcSku {
  @doc("NfcSku-Basic")
  Basic: "Basic",

  @doc("NfcSku-Standard")
  Standard: "Standard",

  @doc("NfcSku-HighPerformance")
  HighPerformance: "HighPerformance",

  string,
}

@doc("The VM profile configuration for the NFC's associated compute (VM) resources.")
@added(Versions.v2026_01_15_preview)
model VmProfile {
  @doc("The SKU that will be used for creating the VMS for AKS cluster.")
  vmSkuName: string;
}

@doc("Public connectivity configuration for the Network Fabric Controller.")
@added(Versions.v2026_07_15_preview)
model PublicConnectivity {
  @doc("Infrastructure VPN Gateway SKU. Specified by the user at Create and Update time.")
  infrastructureVpnGatewaySku: VpnGatewaySku;

  @doc("Tenant VPN Gateway SKU. Specified by the user at Create and Update time.")
  tenantVpnGatewaySku: VpnGatewaySku;

  @doc("Infrastructure VPN Gateway information provisioned for public connectivity. This is read-only and populated by the platform.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["vpnGatewayId"])
  infrastructureVpnGateways?: VpnGateway[];

  @doc("Tenant VPN Gateway information provisioned for public connectivity. This is read-only and populated by the platform.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["vpnGatewayId"])
  tenantVpnGateways?: VpnGateway[];
}

@doc("VPN Gateway SKU for the Network Fabric Controller public connectivity.")
@added(Versions.v2026_07_15_preview)
union VpnGatewaySku {
  @doc("VpnGatewaySku-VpnGw2AZ")
  VpnGw2AZ: "VpnGw2AZ",

  @doc("VpnGatewaySku-VpnGw3AZ")
  VpnGw3AZ: "VpnGw3AZ",

  @doc("VpnGatewaySku-VpnGw4AZ")
  VpnGw4AZ: "VpnGw4AZ",

  @doc("VpnGatewaySku-VpnGw5AZ")
  VpnGw5AZ: "VpnGw5AZ",

  string,
}

@doc("The type of VPN gateway.")
@added(Versions.v2026_07_15_preview)
union VpnGatewayType {
  string,

  @doc("Site-to-site VPN gateway.")
  vpn: "Vpn",

  @doc("ExpressRoute gateway.")
  expressRoute: "ExpressRoute",

  @doc("Local network gateway.")
  localGateway: "LocalGateway",
}

@doc("VPN Gateway instance information including ASN and IP addresses.")
@added(Versions.v2026_07_15_preview)
model VpnGateway {
  @doc("VPN Gateway instance resource ID.")
  @visibility(Lifecycle.Read)
  vpnGatewayId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworkGateways";
    }
  ]>;

  @doc("VPN Gateway Type.")
  @visibility(Lifecycle.Read)
  vpnGatewayType?: VpnGatewayType;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("VPN Gateway ASN. Example: 65000.")
  @maxValue(4294967295)
  @minValue(1)
  vpnGatewayAsn?: int64;

  @doc("VPN Gateway IP address. Example: 10.248.224.8.")
  vpnGatewayIpV4Address?: Azure.Core.ipV4Address;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("VPN Gateway eBGP primary IP address. Example: 169.254.21.1.")
  vpnGatewayBgpPrimaryIpV4Address?: Azure.Core.ipV4Address;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("VPN Gateway eBGP secondary IP address. Example: 169.254.21.5.")
  vpnGatewayBgpSecondaryIpV4Address?: Azure.Core.ipV4Address;
}
