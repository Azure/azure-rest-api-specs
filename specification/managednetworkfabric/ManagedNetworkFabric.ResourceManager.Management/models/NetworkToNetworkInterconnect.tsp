import "./common.tsp";

using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.ManagedNetworkFabric;

@doc("Configuration used to setup CE-PE connectivity.")
model NetworkToNetworkInterconnectProperties {
  @doc("Type of NNI used. Example: CE | NPB")
  nniType?: NniType = NniType.CE;

  @doc("Configuration to use NNI for Infrastructure Management. Example: True/False.")
  isManagementType?: IsManagementType = IsManagementType.True;

  @doc("Based on this option layer3 parameters are mandatory. Example: True/False")
  useOptionB: BooleanEnumProperty;

  @doc("Common properties for Layer2 Configuration.")
  layer2Configuration?: Layer2Configuration;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Common properties for Layer3Configuration.")
  optionBLayer3Configuration?: OptionBLayer3Configuration;

  @doc("NPB Static Route Configuration properties.")
  npbStaticRouteConfiguration?: NpbStaticRouteConfiguration;

  @added(Versions.v2024_06_15_preview)
  @doc("Static Route Configuration.")
  staticRouteConfiguration?: NniStaticRouteConfiguration;

  @doc("Import Route Policy information.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "importRoutePolicy")
  importRoutePolicyDeprecated?: ImportRoutePolicyInformation;

  @doc("Import Route Policy information.")
  @added(Versions.v2024_06_15_preview)
  importRoutePolicy?: ImportRoutePolicyInformation;

  @doc("Export Route Policy information")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportRoutePolicy")
  exportRoutePolicyDeprecated?: ExportRoutePolicyInformation;

  @doc("Export Route Policy information")
  @added(Versions.v2024_06_15_preview)
  exportRoutePolicy?: ExportRoutePolicyInformation;

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

  @doc("Micro Bidirectional Forwarding Detection (BFD) enabled/disabled state.")
  @added(Versions.v2024_06_15_preview)
  microBfdState?: MicroBfdState;

  @doc("Conditional Default Route Configuration properties.")
  @added(Versions.v2024_06_15_preview)
  conditionalDefaultRouteConfiguration?: ConditionalDefaultRouteProperties;

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

@doc("Common properties for Layer2 Configuration.")
model Layer2Configuration {
  @doc("MTU of the packets between PE & CE.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  @doc("List of network device interfaces resource IDs.")
  @minItems(1)
  interfaces?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];
}

@doc("Common properties for Layer2 Configuration.")
model Layer2ConfigurationPatch {
  @doc("MTU of the packets between PE & CE.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  @doc("List of network device interfaces resource IDs.")
  @minItems(1)
  interfaces?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];
}

@doc("The Network To Network Interconnect resource patch definition.")
model NetworkToNetworkInterconnectPatch {
  ...ProxyResourceBase;

  @doc("Resource properties.")
  properties?: NetworkToNetworkInterconnectPatchProperties;
}

@doc("Network Tap Rule Patch properties.")
model NetworkToNetworkInterconnectPatchProperties {
  @doc("Common properties for Layer2Configuration.")
  layer2Configuration?: Layer2ConfigurationPatch;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Common properties for Layer3Configuration.")
  optionBLayer3Configuration?: OptionBLayer3ConfigurationPatchProperties;

  @doc("NPB Static Route Configuration properties.")
  npbStaticRouteConfiguration?: NpbStaticRouteConfigurationPatch;

  @added(Versions.v2024_06_15_preview)
  @doc("Static Route Configuration.")
  staticRouteConfiguration?: NniStaticRoutePatchConfiguration;

  @doc("Import Route Policy information.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "importRoutePolicy")
  importRoutePolicyDeprecated?: ImportRoutePolicyInformationPatch;

  @doc("Import Route Policy information.")
  @added(Versions.v2024_06_15_preview)
  importRoutePolicy?: ImportRoutePolicyInformationPatch;

  @doc("Export Route Policy information")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportRoutePolicy")
  exportRoutePolicyDeprecated?: ExportRoutePolicyInformationPatch;

  @doc("Export Route Policy information")
  @added(Versions.v2024_06_15_preview)
  exportRoutePolicy?: ExportRoutePolicyInformationPatch;

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

  @doc("Micro BFD enabled/disabled state.")
  @added(Versions.v2024_06_15_preview)
  microBfdState?: MicroBfdState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Common properties for Layer3Configuration.")
@withOptionalProperties
model OptionBLayer3ConfigurationPatchProperties {
  ...Layer3IpPrefixPatchProperties;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("ASN of PE devices for CE/PE connectivity.Example : 28")
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  @doc("VLAN for CE/PE Layer 3 connectivity.Example : 501")
  @maxValue(4094)
  @minValue(100)
  vlanId?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("ASN of CE devices for CE/PE connectivity.")
  @visibility(Lifecycle.Read)
  fabricASN?: int64;

  @doc("Provider Edge (PE) Loopback IP Address.")
  @added(Versions.v2024_06_15_preview)
  peLoopbackIpAddress?: string[];

  @doc("BGP Monitoring Protocol (BMP) Configuration.")
  @added(Versions.v2024_06_15_preview)
  bmpConfiguration?: NniBmpPatchProperties;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("OptionB Layer3 prefix limit configuration.")
  @added(Versions.v2024_06_15_preview)
  @minItems(1)
  @Azure.ResourceManager.identifiers(#[])
  prefixLimits?: OptionBLayer3PrefixLimitPatchProperties[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("OptionB Layer3 Configuration properties.")
model OptionBLayer3Configuration {
  ...Layer3IpPrefixProperties;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("ASN of PE devices for CE/PE connectivity.Example : 28")
  @maxValue(4294967295)
  @minValue(1)
  peerASN: int64;

  @doc("VLAN for CE/PE Layer 3 connectivity.Example : 501")
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("ASN of CE devices for CE/PE connectivity.")
  @visibility(Lifecycle.Read)
  fabricASN?: int64;

  @doc("Provider Edge (PE) Loopback IP Address.")
  @added(Versions.v2024_06_15_preview)
  peLoopbackIpAddress?: string[];

  @doc("BGP Monitoring Protocol (BMP) Configuration.")
  @added(Versions.v2024_06_15_preview)
  bmpConfiguration?: NniBmpProperties;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("OptionB Layer3 prefix limit configuration.")
  @added(Versions.v2024_06_15_preview)
  @minItems(1)
  @Azure.ResourceManager.identifiers(#[])
  prefixLimits?: OptionBLayer3PrefixLimitProperties[];
}

@doc("NPB Static Route Configuration properties.")
model NpbStaticRouteConfiguration {
  @doc("BFD Configuration properties.")
  bfdConfiguration?: BfdConfiguration;

  @doc("List of IPv4 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  ipv4Routes?: StaticRouteProperties[];

  @doc("List of IPv6 Routes.")
  @minItems(1)
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRouteProperties[];
}

@doc("NPB Static Route Configuration properties.")
model NpbStaticRouteConfigurationPatch {
  @doc("BFD Configuration properties.")
  bfdConfiguration?: BfdPatchConfiguration;

  @doc("List of IPv4 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  ipv4Routes?: StaticRoutePatchProperties[];

  @doc("List of IPv6 Routes.")
  @minItems(1)
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRoutePatchProperties[];
}

@doc("Type of NNI used. Example: CE | NPB")
union NniType {
  @doc("NniType-CE(Customer Edge).")
  CE: "CE",

  @doc("NniType-NPB(Network Packet Broker).")
  NPB: "NPB",

  string,
}

@doc("Configuration to use NNI for Infrastructure Management. Example: True/False.")
union IsManagementType {
  @doc("IsManagementType-True")
  True: "True",

  @doc("IsManagementType-False")
  False: "False",

  string,
}

@doc("NNI Bidirectional Forwarding Detection (BFD) Administrative State request.")
@added(Versions.v2024_06_15_preview)
model NniBfdAdministrativeStateRequest {
  @doc("Route Type. Choose either Static or OptionA.")
  routeType?: RouteType;

  @doc("State. Select either enable or disable.")
  administrativeState?: BfdAdministrativeState;
}

@doc("NNI Bidirectional Forwarding Detection (BFD) Administrative State response.")
@added(Versions.v2024_06_15_preview)
model NniBfdAdministrativeStateResponse {
  @doc("Route Type. Choose either Static or OptionA.")
  routeType?: RouteType;

  @doc("State. Select either enable or disable.")
  administrativeState?: BfdAdministrativeState;

  ...ErrorResponse;
}

@added(Versions.v2024_06_15_preview)
@doc("Route type to be used.")
union RouteType {
  @doc("RouteType-Static")
  Static: "Static",

  @doc("RouteType-OptionA")
  OptionA: "OptionA",

  string,
}

@doc("Static Route Configuration properties for NNI.")
@added(Versions.v2024_06_15_preview)
model NniStaticRouteConfiguration {
  @doc("BFD configuration properties")
  bfdConfiguration?: BfdConfiguration;

  @doc("List of IPv4 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: StaticRouteProperties[];

  @doc("List of IPv6 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRouteProperties[];
}

@doc("Static Route Configuration properties for NNI.")
@added(Versions.v2024_06_15_preview)
model NniStaticRoutePatchConfiguration {
  @doc("Bidirectional Forwarding Detection (BFD) configuration properties")
  bfdConfiguration?: BfdPatchConfiguration;

  @doc("List of IPv4 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: StaticRoutePatchProperties[];

  @doc("List of IPv6 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRoutePatchProperties[];
}

@doc("Micro Bidirectional Forwarding Detection (BFD) enabled/disabled state.")
@added(Versions.v2024_06_15_preview)
union MicroBfdState {
  @doc("MicroBfdState-Enabled")
  Enabled: "Enabled",

  @doc("MicroBfdState-Disabled")
  Disabled: "Disabled",

  string,
}

@doc("Conditional Default Route Configuration properties.")
@added(Versions.v2024_06_15_preview)
model ConditionalDefaultRouteProperties {
  @doc("List of IPv4 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: StaticRouteProperties[];

  @doc("List of IPv6 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRouteProperties[];
}

@doc("BGP Monitoring Protocol (BMP) properties.")
@added(Versions.v2024_06_15_preview)
model NniBmpProperties {
  @doc("BGP Monitoring Protocol (BMP) Configuration State.")
  configurationState: BmpConfigurationState = BmpConfigurationState.Disabled;
}

@doc("BGP Monitoring Protocol (BMP) patch properties.")
@added(Versions.v2024_06_15_preview)
model NniBmpPatchProperties {
  @doc("(BGP Monitoring Protocol (BMP) configuration state.")
  configurationState?: BmpConfigurationState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("OptionB Layer3 prefix limit properties.")
@added(Versions.v2024_06_15_preview)
model OptionBLayer3PrefixLimitProperties {
  @doc("Maximum number of routes allowed.")
  @added(Versions.v2024_06_15_preview)
  maximumRoutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("OptionB Layer3 prefix limit patch properties.")
@added(Versions.v2024_06_15_preview)
model OptionBLayer3PrefixLimitPatchProperties
  is OptionBLayer3PrefixLimitProperties;
