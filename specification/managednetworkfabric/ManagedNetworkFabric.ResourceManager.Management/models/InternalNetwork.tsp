import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Internal Network Properties defines the properties of the resource.
 */
model InternalNetworkProperties {
  ...AnnotationResource;

  /**
   * Maximum transmission unit. Default value is 1500.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * List of Connected IPv4 Subnets.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  connectedIPv4Subnets?: ConnectedSubnet[];

  /**
   * List of connected IPv6 Subnets.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  connectedIPv6Subnets?: ConnectedSubnet[];

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
   * Ingress Acl. ARM resource ID of Access Control Lists.
   */
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * Egress Acl. ARM resource ID of Access Control Lists.
   */
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * To check whether monitoring of internal network is enabled or not.
   */
  isMonitoringEnabled?: IsMonitoringEnabled = IsMonitoringEnabled.False;

  @doc("Extension. Example: NoExtension | NPB.")
  extension?: Extension = Extension.NoExtension;

  /**
   * Vlan identifier. Example: 1001.
   */
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  /**
   * BGP configuration properties.
   */
  bgpConfiguration?: BgpConfiguration;

  /**
   * Static Route Configuration properties.
   */
  staticRouteConfiguration?: StaticRouteConfiguration;

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

/**
 * BGP configuration properties
 */
model BgpConfiguration {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * BFD configuration properties
   */
  bfdConfiguration?: BfdConfiguration;

  /**
   * Originate a defaultRoute. Ex: "True" | "False".
   */
  defaultRouteOriginate?: BooleanEnumProperty;

  /**
   * Allows for routes to be received and processed even if the router detects its own ASN in the AS-Path. 0 is disable, Possible values are 1-10, default is 2.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(10)
  @minValue(0)
  allowAS?: int32 = 2;

  /**
   * Enable Or Disable state.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  allowASOverride?: AllowASOverride;

  /**
   * ASN of Network Fabric. Example: 65048.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @visibility("read")
  fabricASN?: int64;

  /**
   * Peer ASN. Example: 65047.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(4294967295)
  @minValue(1)
  peerASN: int64;

  /**
   * List of BGP IPv4 Listen Range prefixes.
   */
  ipv4ListenRangePrefixes?: string[];

  /**
   * List of BGP IPv6 Listen Ranges prefixes.
   */
  ipv6ListenRangePrefixes?: string[];

  /**
   * List with stringified IPv4 Neighbor Addresses.
   */
  @OpenAPI.extension("x-ms-identifiers", ["address"])
  ipv4NeighborAddress?: NeighborAddress[];

  /**
   * List with stringified IPv6 Neighbor Address.
   */
  @OpenAPI.extension("x-ms-identifiers", ["address"])
  ipv6NeighborAddress?: NeighborAddress[];
}

/**
 * BGP configuration properties.
 */
model BgpPatchConfiguration {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * BFD configuration properties
   */
  bfdConfiguration?: BfdPatchConfiguration;

  /**
   * Originate a defaultRoute. Ex: "True" | "False".
   */
  defaultRouteOriginate?: BooleanEnumProperty;

  /**
   * Allows for routes to be received and processed even if the router detects its own ASN in the AS-Path. 0 is disable, Possible values are 1-10, default is 2.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(10)
  @minValue(0)
  allowAS?: int32;

  /**
   * Enable Or Disable state.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  allowASOverride?: AllowASOverride;

  /**
   * ASN of Network Fabric. Example: 65048.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @visibility("read")
  fabricASN?: int64;

  /**
   * Peer ASN. Example: 65047.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  /**
   * List of BGP IPv4 Listen Range prefixes.
   */
  ipv4ListenRangePrefixes?: string[];

  /**
   * List of BGP IPv6 Listen Ranges prefixes.
   */
  ipv6ListenRangePrefixes?: string[];

  /**
   * List with stringified IPv4 Neighbor Addresses.
   */
  @OpenAPI.extension("x-ms-identifiers", ["address"])
  ipv4NeighborAddress?: NeighborAddressPatch[];

  /**
   * List with stringified IPv6 Neighbor Address.
   */
  @OpenAPI.extension("x-ms-identifiers", ["address"])
  ipv6NeighborAddress?: NeighborAddressPatch[];
}

/**
 * Neighbor Address properties.
 */
model NeighborAddress {
  /**
   * IP Address.
   */
  @minLength(1)
  address?: string;

  /**
   * Configuration state of the resource.
   */
  @visibility("read")
  configurationState?: ConfigurationState;
}

@doc("Neighbor Address properties.")
model NeighborAddressPatch is NeighborAddress;

/**
 * Static Route Configuration properties.
 */
model StaticRouteConfiguration {
  /**
   * BFD configuration properties
   */
  bfdConfiguration?: BfdConfiguration;

  /**
   * List of IPv4 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  ipv4Routes?: StaticRouteProperties[];

  /**
   * List of IPv6 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  ipv6Routes?: StaticRouteProperties[];

  @doc("Extension. Example: NoExtension | NPB.")
  extension?: Extension = Extension.NoExtension;
}

/**
 * Static Route Configuration properties.
 */
model StaticRoutePatchConfiguration {
  /**
   * BFD configuration properties
   */
  bfdConfiguration?: BfdPatchConfiguration;

  /**
   * List of IPv4 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  ipv4Routes?: StaticRoutePatchProperties[];

  /**
   * List of IPv6 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  ipv6Routes?: StaticRoutePatchProperties[];
}

/**
 * Connected Subnet properties.
 */
model ConnectedSubnet {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * Prefix of the Connected Subnet.
   */
  @minLength(1)
  prefix: string;
}

@doc("Connected Subnet properties.")
model ConnectedSubnetPatch is ConnectedSubnet;

/**
 * The InternalNetwork patch resource definition.
 */
model InternalNetworkPatch {
  /**
   * InternalNetwork Patch properties.
   */
  properties?: InternalNetworkPatchProperties;
}

/**
 * InternalNetwork Patch properties.
 */
model InternalNetworkPatchProperties {
  ...AnnotationResource;

  /**
   * Maximum transmission unit. Default value is 1500.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  /**
   * List of Connected IPv4 Subnets.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  connectedIPv4Subnets?: ConnectedSubnetPatch[];

  /**
   * List of connected IPv6 Subnets.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  connectedIPv6Subnets?: ConnectedSubnetPatch[];

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
   * Ingress Acl. ARM resource ID of Access Control Lists.
   */
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * Egress Acl. ARM resource ID of Access Control Lists.
   */
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * To check whether monitoring of internal network is enabled or not.
   */
  isMonitoringEnabled?: IsMonitoringEnabled;

  /**
   * BGP configuration properties.
   */
  bgpConfiguration?: BgpPatchConfiguration;

  /**
   * Static Route Configuration properties.
   */
  staticRouteConfiguration?: StaticRoutePatchConfiguration;
}

/**
 * Extension. Example: NoExtension | NPB.
 */
union Extension {
  @doc("Extension-NoExtension")
  NoExtension: "NoExtension",

  @doc("Extension-NPB")
  NPB: "NPB",

  string,
}

/**
 * Enable Or Disable state.
 */
union AllowASOverride {
  @doc("AllowASOverride-Enable")
  Enable: "Enable",

  @doc("AllowASOverride-Disable")
  Disable: "Disable",

  string,
}

/**
 * To check whether monitoring of internal network is enabled or not.
 */
union IsMonitoringEnabled {
  @doc("IsMonitoringEnabled-True")
  True: "True",

  @doc("IsMonitoringEnabled-False")
  False: "False",

  string,
}
