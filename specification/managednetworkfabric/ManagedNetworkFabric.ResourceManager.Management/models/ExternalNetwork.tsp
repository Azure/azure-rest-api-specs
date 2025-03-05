import "./common.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;

@doc("External Network Properties.")
model ExternalNetworkProperties {
  ...AnnotationResource;

  @doc("ARM Resource ID of the networkToNetworkInterconnectId of the ExternalNetwork resource.")
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

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

  @doc("Peering option list.")
  peeringOption: PeeringOption;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option B properties object")
  optionBProperties?: L3OptionBProperties;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option A properties object")
  optionAProperties?: ExternalNetworkPropertiesOptionAProperties;

  @added(Versions.v2024_06_15_preview)
  @doc("Static Route Configuration.")
  staticRouteConfiguration?: ExternalNetworkStaticRouteConfiguration;

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

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Option B configuration.")
model L3OptionBPatchProperties {
  @doc("RouteTargets to be applied. This is used for the backward compatibility.")
  importRouteTargets?: string[];

  @doc("RouteTargets to be applied. This is used for the backward compatibility.")
  exportRouteTargets?: string[];

  @doc("RouteTargets to be applied.")
  routeTargets?: RouteTargetPatchInformation;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Option B configuration.")
model L3OptionBProperties {
  @doc("RouteTargets to be applied. This is used for the backward compatibility.")
  importRouteTargets?: string[];

  @doc("RouteTargets to be applied. This is used for the backward compatibility.")
  exportRouteTargets?: string[];

  @doc("RouteTargets to be applied.")
  routeTargets?: RouteTargetInformation;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("option A properties object")
model ExternalNetworkPropertiesOptionAProperties {
  ...Layer3IpPrefixProperties;

  @doc("MTU to use for option A peering.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  @doc("Vlan identifier. Example : 501")
  @maxValue(4094)
  @minValue(501)
  vlanId: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Fabric ASN number. Example 65001")
  @visibility(Lifecycle.Read)
  @maxValue(4294967295)
  @minValue(1)
  fabricASN?: int64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Peer ASN number.Example : 28")
  @maxValue(4294967295)
  @minValue(1)
  peerASN: int64;

  @doc("BFD configuration properties")
  bfdConfiguration?: BfdConfiguration;

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

  @doc("BMP Monitor Configuration.")
  @added(Versions.v2024_06_15_preview)
  bmpConfiguration?: ExternalNetworkBmpProperties;

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

  @doc("V4OverV6 BGP Session state")
  @added(Versions.v2024_06_15_preview)
  v4OverV6BgpSession?: V4OverV6BgpSessionState = V4OverV6BgpSessionState.Disabled;

  @doc("V6OverV4 BGP Session state")
  @added(Versions.v2024_06_15_preview)
  v6OverV4BgpSession?: V6OverV4BgpSessionState = V6OverV4BgpSessionState.Disabled;

  @doc("Native IPv4 prefix limits configuration")
  @added(Versions.v2024_06_15_preview)
  nativeIpv4PrefixLimit?: NativeIpv4PrefixLimitProperties;

  @doc("Native IPv6 prefix limits configuration")
  @added(Versions.v2024_06_15_preview)
  nativeIpv6PrefixLimit?: NativeIpv6PrefixLimitProperties;
}

@doc("The ExternalNetwork patch resource definition.")
model ExternalNetworkPatch {
  @doc("External Network Patch properties.")
  properties?: ExternalNetworkPatchProperties;
}

@doc("External Network Patch properties.")
model ExternalNetworkPatchProperties {
  ...AnnotationResource;

  @doc("ARM Resource ID of the networkToNetworkInterconnectId of the ExternalNetwork resource.")
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

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
  importRoutePolicyDeprecated?: ImportRoutePolicyPatch;

  @doc("Import Route Policy either IPv4 or IPv6.")
  @added(Versions.v2024_06_15_preview)
  importRoutePolicy?: ImportRoutePolicyPatch;

  @doc("Export Route Policy either IPv4 or IPv6.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportRoutePolicy")
  exportRoutePolicyDeprecated?: ExportRoutePolicyPatch;

  @doc("Export Route Policy either IPv4 or IPv6.")
  @added(Versions.v2024_06_15_preview)
  exportRoutePolicy?: ExportRoutePolicyPatch;

  @doc("Peering option list.")
  peeringOption?: PeeringOption;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option B properties object")
  optionBProperties?: L3OptionBPatchProperties;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option A properties object")
  optionAProperties?: ExternalNetworkPatchPropertiesOptionAProperties;

  @added(Versions.v2024_06_15_preview)
  @doc("Static Route Configuration.")
  staticRouteConfiguration?: ExternalNetworkStaticRoutePatchConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("option A properties object")
model ExternalNetworkPatchPropertiesOptionAProperties {
  ...Layer3IpPrefixPatchProperties;

  @doc("MTU to use for option A peering.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  @doc("Vlan identifier. Example : 501")
  @maxValue(4094)
  @minValue(501)
  vlanId?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Fabric ASN number. Example 65001")
  @visibility(Lifecycle.Read)
  @maxValue(4294967295)
  @minValue(1)
  fabricASN?: int64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Peer ASN number.Example : 28")
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  @doc("BFD configuration properties")
  bfdConfiguration?: BfdPatchConfiguration;

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

  @doc("BMP Monitor Configuration.")
  @added(Versions.v2024_06_15_preview)
  bmpConfiguration?: ExternalNetworkBmpPatchProperties;

  @doc("V4OverV6 BGP Session state")
  @added(Versions.v2024_06_15_preview)
  v4OverV6BgpSession?: V4OverV6BgpSessionState;

  @doc("V6OverV4 BGP Session state")
  @added(Versions.v2024_06_15_preview)
  v6OverV4BgpSession?: V6OverV4BgpSessionState;

  @doc("Native IPv4 prefix limit configuration")
  @added(Versions.v2024_06_15_preview)
  nativeIpv4PrefixLimit?: NativeIpv4PrefixLimitPatchProperties;

  @doc("Native IPv6 prefix limit configuration")
  @added(Versions.v2024_06_15_preview)
  nativeIpv6PrefixLimit?: NativeIpv6PrefixLimitPatchProperties;
}

@doc("External Network Administrative State request")
@added(Versions.v2024_06_15_preview)
model ExternalNetworkBfdAdministrativeStateRequest {
  @doc("Route Type that helps to know which bfd we are updating.")
  routeType?: ExternalNetworkRouteType;

  @doc("Administrative state.")
  administrativeState?: BfdAdministrativeState;
}

@doc("External Network Administrative State response")
@added(Versions.v2024_06_15_preview)
model ExternalNetworkBfdAdministrativeStateResponse {
  @doc("Route Type that helps to know which bfd we are updating.")
  routeType?: ExternalNetworkRouteType;

  @doc("Administrative state.")
  administrativeState?: BfdAdministrativeState;

  ...ErrorResponse;
}

@doc("External Network RouteType.")
@added(Versions.v2024_06_15_preview)
union ExternalNetworkRouteType {
  @doc("ExternalNetwork Static.")
  Static: "Static",

  @doc("ExternalNetwork OptionA.")
  OptionA: "OptionA",

  string,
}

@doc("Static Route Configuration properties for ExternalNetwork.")
@added(Versions.v2024_06_15_preview)
model ExternalNetworkStaticRouteConfiguration {
  @doc("BFD configuration properties")
  bfdConfiguration?: BfdConfiguration;

  @doc("List of IPv4 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: StaticRouteProperties[];

  @doc("List of IPv6 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRouteProperties[];
}

@doc("Static Route Configuration properties for External Network.")
@added(Versions.v2024_06_15_preview)
model ExternalNetworkStaticRoutePatchConfiguration {
  @doc("BFD configuration properties")
  bfdConfiguration?: BfdPatchConfiguration;

  @doc("List of IPv4 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: StaticRoutePatchProperties[];

  @doc("List of IPv6 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRoutePatchProperties[];
}

@doc("BGP Monitoring Protocol (BMP) Configuration properties.")
@added(Versions.v2024_06_15_preview)
model ExternalNetworkBmpProperties {
  @doc("BMP Configuration State.")
  configurationState?: BmpConfigurationState = BmpConfigurationState.Disabled;
}

@doc("BMP Monitoring Configuration patch properties.")
@added(Versions.v2024_06_15_preview)
model ExternalNetworkBmpPatchProperties {
  @doc("BMP Configuration State.")
  configurationState?: BmpConfigurationState;
}
