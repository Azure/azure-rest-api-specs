import "./common.tsp";

using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.ManagedNetworkFabric;

@doc("Internal Network Properties defines the properties of the resource.")
model InternalNetworkProperties {
  ...AnnotationResource;

  @doc("Maximum transmission unit. Default value is 1500.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("List of Connected IPv4 Subnets.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  connectedIPv4Subnets?: ConnectedSubnet[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("List of connected IPv6 Subnets.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  connectedIPv6Subnets?: ConnectedSubnet[];

  @doc("ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.")
  @removed(Versions.v2024_06_15_preview)
  importRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.")
  @removed(Versions.v2024_06_15_preview)
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import Route Policy either IPv4 or IPv6.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "importRoutePolicy")
  importRoutePolicyDeprecated?: ImportRoutePolicy;

  @doc("Import Route Policy either IPv4 or IPv6.")
  @added(Versions.v2024_06_15_preview)
  importRoutePolicy?: ImportRoutePolicy;

  @doc("Export Route Policy either IPv4 or IPv6.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportRoutePolicy")
  exportRoutePolicyDeprecated?: ExportRoutePolicy;

  @doc("Export Route Policy either IPv4 or IPv6.")
  @added(Versions.v2024_06_15_preview)
  exportRoutePolicy?: ExportRoutePolicy;

  @doc("Ingress Acl. ARM resource ID of Access Control Lists.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "ingressAclId")
  ingressAclIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Ingress Acl. ARM resource ID of Access Control Lists.")
  @added(Versions.v2024_06_15_preview)
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "egressAclId")
  egressAclIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  @added(Versions.v2024_06_15_preview)
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("To check whether monitoring of internal network is enabled or not.")
  isMonitoringEnabled?: IsMonitoringEnabled = IsMonitoringEnabled.False;

  @doc("Extension. Example: NoExtension | NPB.")
  extension?: Extension = Extension.NoExtension;

  @doc("Vlan identifier. Example: 1001.")
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  @doc("BGP configuration properties.")
  bgpConfiguration?: BgpConfiguration;

  @doc("Static Route Configuration properties.")
  staticRouteConfiguration?: StaticRouteConfiguration;

  @doc("Native IPv4 Prefix Limit Configuration properties.")
  @added(Versions.v2024_06_15_preview)
  nativeIpv4PrefixLimit?: NativeIpv4PrefixLimitProperties;

  @doc("Native IPv6 Prefix Limit Configuration properties.")
  @added(Versions.v2024_06_15_preview)
  nativeIpv6PrefixLimit?: NativeIpv6PrefixLimitProperties;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

@doc("BGP configuration properties")
model BgpConfiguration {
  ...AnnotationResource;

  @doc("BFD configuration properties")
  bfdConfiguration?: BfdConfiguration;

  @doc("Originate a defaultRoute. Ex: \"True\" | \"False\".")
  defaultRouteOriginate?: BooleanEnumProperty;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Allows for routes to be received and processed even if the router detects its own ASN in the AS-Path. 0 is disable, Possible values are 1-10, default is 2.")
  @maxValue(10)
  @minValue(0)
  allowAS?: int32 = 2;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Enable Or Disable state.")
  allowASOverride?: AllowASOverride;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("ASN of Network Fabric. Example: 65048.")
  @visibility(Lifecycle.Read)
  fabricASN?: int64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Peer ASN. Example: 65047.")
  @maxValue(4294967295)
  @minValue(1)
  peerASN: int64;

  @doc("List of BGP IPv4 Listen Range prefixes.")
  ipv4ListenRangePrefixes?: string[];

  @doc("List of BGP IPv6 Listen Ranges prefixes.")
  ipv6ListenRangePrefixes?: string[];

  @doc("List with stringified IPv4 Neighbor Addresses.")
  @Azure.ResourceManager.identifiers(#["address"])
  ipv4NeighborAddress?: NeighborAddress[];

  @doc("List with stringified IPv6 Neighbor Address.")
  @Azure.ResourceManager.identifiers(#["address"])
  ipv6NeighborAddress?: NeighborAddress[];

  @doc("InternalNetwork BMP Configuration")
  @added(Versions.v2024_06_15_preview)
  bmpConfiguration?: InternalNetworkBmpProperties;

  @added(Versions.v2024_06_15_preview)
  @doc("V4 over V6 bgp session.")
  v4OverV6BgpSession?: V4OverV6BgpSessionState = V4OverV6BgpSessionState.Disabled;

  @doc("v6 over v4 bgp session.")
  @added(Versions.v2024_06_15_preview)
  v6OverV4BgpSession?: V6OverV4BgpSessionState = V6OverV4BgpSessionState.Disabled;
}

@doc("BGP configuration properties.")
model BgpPatchConfiguration {
  ...AnnotationResource;

  @doc("BFD configuration properties")
  bfdConfiguration?: BfdPatchConfiguration;

  @doc("Originate a defaultRoute. Ex: \"True\" | \"False\".")
  defaultRouteOriginate?: BooleanEnumProperty;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Allows for routes to be received and processed even if the router detects its own ASN in the AS-Path. 0 is disable, Possible values are 1-10, default is 2.")
  @maxValue(10)
  @minValue(0)
  allowAS?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Enable Or Disable state.")
  allowASOverride?: AllowASOverride;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("ASN of Network Fabric. Example: 65048.")
  @visibility(Lifecycle.Read)
  fabricASN?: int64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Peer ASN. Example: 65047.")
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  @doc("List of BGP IPv4 Listen Range prefixes.")
  ipv4ListenRangePrefixes?: string[];

  @doc("List of BGP IPv6 Listen Ranges prefixes.")
  ipv6ListenRangePrefixes?: string[];

  @doc("List with stringified IPv4 Neighbor Addresses.")
  @Azure.ResourceManager.identifiers(#["address"])
  ipv4NeighborAddress?: NeighborAddressPatch[];

  @doc("List with stringified IPv6 Neighbor Address.")
  @Azure.ResourceManager.identifiers(#["address"])
  ipv6NeighborAddress?: NeighborAddressPatch[];

  @doc("InternalNetwork BMP Configuration")
  @added(Versions.v2024_06_15_preview)
  bmpConfiguration?: InternalNetworkBmpPatchProperties;

  @added(Versions.v2024_06_15_preview)
  @doc("V4 over V6 bgp session.")
  v4OverV6BgpSession?: V4OverV6BgpSessionState;

  @doc("v6 over v4 bgp session.")
  @added(Versions.v2024_06_15_preview)
  v6OverV4BgpSession?: V6OverV4BgpSessionState;
}

@doc("Neighbor Address properties.")
model NeighborAddress {
  @doc("IP Address.")
  @minLength(1)
  address?: string;

  @doc("BFD Administrative State for each Neighbor Address. Example: Enabled | Disabled.")
  @added(Versions.v2024_06_15_preview)
  @visibility(Lifecycle.Read)
  bfdAdministrativeState?: BfdAdministrativeState;

  @doc("BGP Administrative State for each Neighbor Address. Example: Enabled | Disabled.")
  @added(Versions.v2024_06_15_preview)
  @visibility(Lifecycle.Read)
  bgpAdministrativeState?: BgpAdministrativeState;

  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;
}

@doc("Neighbor Address properties.")
model NeighborAddressPatch is NeighborAddress;

@doc("Connected Subnet properties.")
model ConnectedSubnet {
  ...AnnotationResource;

  @doc("Prefix of the Connected Subnet.")
  @minLength(1)
  prefix: string;
}

@doc("Connected Subnet properties.")
model ConnectedSubnetPatch is ConnectedSubnet;

@doc("The InternalNetwork patch resource definition.")
model InternalNetworkPatch {
  @doc("InternalNetwork Patch properties.")
  properties?: InternalNetworkPatchProperties;
}

@doc("InternalNetwork Patch properties.")
model InternalNetworkPatchProperties {
  ...AnnotationResource;

  @doc("Maximum transmission unit. Default value is 1500.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("List of Connected IPv4 Subnets.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  connectedIPv4Subnets?: ConnectedSubnetPatch[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("List of connected IPv6 Subnets.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  connectedIPv6Subnets?: ConnectedSubnetPatch[];

  @doc("ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.")
  @removed(Versions.v2024_06_15_preview)
  importRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.")
  @removed(Versions.v2024_06_15_preview)
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import Route Policy either IPv4 or IPv6.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "importRoutePolicy")
  importRoutePolicyDeprecated?: ImportRoutePolicy;

  @doc("Import Route Policy either IPv4 or IPv6.")
  @added(Versions.v2024_06_15_preview)
  importRoutePolicy?: ImportRoutePolicy;

  @doc("Export Route Policy either IPv4 or IPv6.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportRoutePolicy")
  exportRoutePolicyDeprecated?: ExportRoutePolicy;

  @doc("Export Route Policy either IPv4 or IPv6.")
  @added(Versions.v2024_06_15_preview)
  exportRoutePolicy?: ExportRoutePolicy;

  @doc("Ingress Acl. ARM resource ID of Access Control Lists.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "ingressAclId")
  ingressAclIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Ingress Acl. ARM resource ID of Access Control Lists.")
  @added(Versions.v2024_06_15_preview)
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "egressAclId")
  egressAclIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  @added(Versions.v2024_06_15_preview)
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("To check whether monitoring of internal network is enabled or not.")
  isMonitoringEnabled?: IsMonitoringEnabled;

  @doc("BGP configuration properties.")
  bgpConfiguration?: BgpPatchConfiguration;

  @doc("Static Route Configuration properties.")
  staticRouteConfiguration?: StaticRoutePatchConfiguration;

  @doc("Native IPv4 Prefix Limit Configuration properties.")
  @added(Versions.v2024_06_15_preview)
  nativeIpv4PrefixLimit?: NativeIpv4PrefixLimitPatchProperties;

  @doc("Native IPv6 Prefix Limit Configuration properties.")
  @added(Versions.v2024_06_15_preview)
  nativeIpv6PrefixLimit?: NativeIpv6PrefixLimitPatchProperties;
}

@doc("Extension. Example: NoExtension | NPB.")
union Extension {
  @doc("Extension-NoExtension")
  NoExtension: "NoExtension",

  @doc("Extension-NPB")
  NPB: "NPB",

  string,
}

@doc("Enable Or Disable state.")
union AllowASOverride {
  @doc("AllowASOverride-Enable")
  Enable: "Enable",

  @doc("AllowASOverride-Disable")
  Disable: "Disable",

  string,
}

@doc("To check whether monitoring of internal network is enabled or not.")
union IsMonitoringEnabled {
  @doc("IsMonitoringEnabled-True")
  True: "True",

  @doc("IsMonitoringEnabled-False")
  False: "False",

  string,
}

@doc("Internal Network Administrative State Request")
@added(Versions.v2024_06_15_preview)
model InternalNetworkBgpAdministrativeStateRequest {
  @doc("NeighborAddress - Input should be either All or Specific Ipv4 Address or Specific Ipv6 Address.")
  neighborAddress?: string;

  @doc("BGP Administrative state.")
  administrativeState?: BgpAdministrativeState;
}

@doc("Internal Network Administrative State Response")
@added(Versions.v2024_06_15_preview)
model InternalNetworkBgpAdministrativeStateResponse {
  // The response contains an array of objects. Each object contains the neighbor address and the state.
  // The response is an array of objects because the request can contain multiple neighbor addresses.
  @doc("NeighborAddress administrative status")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  neighborAddressAdministrativeStatus?: NeighborAddressBgpAdministrativeStatus[];

  ...ErrorResponse;
}

@doc("Internal Network BFD Administrative State request")
@added(Versions.v2024_06_15_preview)
model InternalNetworkBfdAdministrativeStateRequest {
  @doc("Route Type that helps to know which bfd we are updating.")
  routeType?: InternalNetworkRouteType;

  @doc("NeighborAddress - Input should be either All or Specific Ipv4 Address or Specific Ipv6 Address.")
  neighborAddress?: string;

  @doc("BFD Administrative state.")
  administrativeState?: BfdAdministrativeState;
}

@doc("Internal Network BFD Administrative State response")
@added(Versions.v2024_06_15_preview)
model InternalNetworkBfdAdministrativeStateResponse {
  // The response contains an array of objects. Each object contains the neighbor address and the state.
  // The response is an array of objects because the request can contain multiple neighbor addresses.
  @doc("NeighborAddress administrative status")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  neighborAddressAdministrativeStatus?: NeighborAddressBfdAdministrativeStatus[];

  ...ErrorResponse;
}

@doc("Internal Network RouteType.")
@added(Versions.v2024_06_15_preview)
union InternalNetworkRouteType {
  @doc("InternalNetwork Static.")
  Static: "Static",

  @doc("InternalNetwork Bgp.")
  Bgp: "Bgp",

  string,
}

@doc("Internal Network BMP Configuration")
@added(Versions.v2024_06_15_preview)
model InternalNetworkBmpProperties {
  @doc("BMP Collector Address.")
  @added(Versions.v2024_06_15_preview)
  @minItems(1)
  neighborIpExclusions?: string[];

  @doc("BMP Monitoring configuration state.")
  @added(Versions.v2024_06_15_preview)
  bmpConfigurationState?: BmpConfigurationState;
}

@doc("Internal Network BMP Configuration")
@added(Versions.v2024_06_15_preview)
model InternalNetworkBmpPatchProperties is InternalNetworkBmpProperties;

@doc("Neighbor Address BGP Administrative Status")
@added(Versions.v2024_06_15_preview)
model NeighborAddressBgpAdministrativeStatus {
  @doc("NeighborAddress - Input should be either All or Specific Ipv4 Address or Specific Ipv6 Address.")
  neighborAddress?: string;

  @doc("BGP Administrative state.")
  administrativeState?: BgpAdministrativeState;

  @doc("Error message.")
  error?: string;
}

@doc("Neighbor Address Bidirectional Forwarding Detection (BFD) Administrative Status")
@added(Versions.v2024_06_15_preview)
model NeighborAddressBfdAdministrativeStatus {
  @doc("NeighborAddress - Input should be either All or Specific Ipv4 Address or Specific Ipv6 Address.")
  neighborAddress?: string;

  @doc("BFD Administrative state.")
  administrativeState?: BfdAdministrativeState;

  @doc("Error message.")
  error?: string;
}
