import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * External Network Properties.
 */
model ExternalNetworkProperties {
  ...AnnotationResource;

  /**
   * ARM Resource ID of the networkToNetworkInterconnectId of the ExternalNetwork resource.
   */
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  /**
   * ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.
   */
  importRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.
   */
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Import Route Policy either IPv4 or IPv6.
   */
  importRoutePolicy?: ImportRoutePolicy;

  /**
   * Export Route Policy either IPv4 or IPv6.
   */
  exportRoutePolicy?: ExportRoutePolicy;

  /**
   * Peering option list.
   */
  peeringOption: PeeringOption;

  /**
   * option B properties object
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  optionBProperties?: L3OptionBProperties;

  /**
   * option A properties object
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  optionAProperties?: ExternalNetworkPropertiesOptionAProperties;

  /**
   * Configuration state of the resource.
   */
  @visibility("read")
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility("read")
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

/**
 * option A properties object
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
model ExternalNetworkPropertiesOptionAProperties {
  ...Layer3IpPrefixProperties;

  /**
   * MTU to use for option A peering.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * Vlan identifier. Example : 501
   */
  @maxValue(4094)
  @minValue(501)
  vlanId: int32;

  /**
   * Fabric ASN number. Example 65001
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @visibility("read")
  @maxValue(4294967295)
  @minValue(1)
  fabricASN?: int64;

  /**
   * Peer ASN number.Example : 28
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(4294967295)
  @minValue(1)
  peerASN: int64;

  /**
   * BFD configuration properties
   */
  bfdConfiguration?: BfdConfiguration;

  /**
   * Ingress Acl. ARM resource ID of Access Control Lists.
   */
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;
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
  importRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.")
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import Route Policy either IPv4 or IPv6.")
  importRoutePolicy?: ImportRoutePolicyPatch;

  @doc("Export Route Policy either IPv4 or IPv6.")
  exportRoutePolicy?: ExportRoutePolicyPatch;

  @doc("Peering option list.")
  peeringOption?: PeeringOption;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option B properties object")
  optionBProperties?: L3OptionBPatchProperties;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option A properties object")
  optionAProperties?: ExternalNetworkPatchPropertiesOptionAProperties;
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
  @visibility("read")
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
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;
}
