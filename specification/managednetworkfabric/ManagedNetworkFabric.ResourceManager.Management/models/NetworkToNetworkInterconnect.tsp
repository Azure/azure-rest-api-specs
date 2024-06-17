import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;
/**
 * Configuration used to setup CE-PE connectivity.
 */
model NetworkToNetworkInterconnectProperties {
  /**
   * Type of NNI used. Example: CE | NPB
   */
  nniType?: NniType = NniType.CE;

  /**
   * Configuration to use NNI for Infrastructure Management. Example: True/False.
   */
  isManagementType?: IsManagementType = IsManagementType.True;

  /**
   * Based on this option layer3 parameters are mandatory. Example: True/False
   */
  useOptionB: BooleanEnumProperty;

  /**
   * Common properties for Layer2 Configuration.
   */
  layer2Configuration?: Layer2Configuration;

  /**
   * Common properties for Layer3Configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  optionBLayer3Configuration?: OptionBLayer3Configuration;

  /**
   * NPB Static Route Configuration properties.
   */
  npbStaticRouteConfiguration?: NpbStaticRouteConfiguration;

  /**
   * Import Route Policy configuration.
   */
  importRoutePolicy?: ImportRoutePolicyInformation;

  /**
   * Export Route Policy configuration.
   */
  exportRoutePolicy?: ExportRoutePolicyInformation;

  /**
   * Egress Acl. ARM resource ID of Access Control Lists.
   */
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * Ingress Acl. ARM resource ID of Access Control Lists.
   */
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

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
 * Common properties for Layer2 Configuration.
 */
model Layer2Configuration {
  /**
   * MTU of the packets between PE & CE.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * List of network device interfaces resource IDs.
   */
  @minItems(1)
  interfaces?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];
}

/**
 * Common properties for Layer2 Configuration.
 */
model Layer2ConfigurationPatch {
  /**
   * MTU of the packets between PE & CE.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  /**
   * List of network device interfaces resource IDs.
   */
  @minItems(1)
  interfaces?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];
}

/**
 * The Network To Network Interconnect resource patch definition.
 */
model NetworkToNetworkInterconnectPatch {
  ...ProxyResourceBase;

  /**
   * Resource properties.
   */
  properties?: NetworkToNetworkInterconnectPatchProperties;
}

/**
 * Network Tap Rule Patch properties.
 */
model NetworkToNetworkInterconnectPatchProperties {
  /**
   * Common properties for Layer2Configuration.
   */
  layer2Configuration?: Layer2ConfigurationPatch;

  /**
   * Common properties for Layer3Configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  optionBLayer3Configuration?: OptionBLayer3ConfigurationPatchProperties;

  /**
   * NPB Static Route Configuration properties.
   */
  npbStaticRouteConfiguration?: NpbStaticRouteConfigurationPatch;

  /**
   * Import Route Policy information.
   */
  importRoutePolicy?: ImportRoutePolicyInformationPatch;

  /**
   * Export Route Policy information
   */
  exportRoutePolicy?: ExportRoutePolicyInformationPatch;

  /**
   * Egress Acl. ARM resource ID of Access Control Lists.
   */
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * Ingress Acl. ARM resource ID of Access Control Lists.
   */
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;
}

/**
 * Common properties for Layer3Configuration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@withOptionalProperties
model OptionBLayer3ConfigurationPatchProperties is OptionBLayer3Configuration;

/**
 * OptionB Layer3 Configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
model OptionBLayer3Configuration {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...Layer3IpPrefixProperties;

  /**
   * ASN of PE devices for CE/PE connectivity.Example : 28
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(4294967295)
  @minValue(1)
  peerASN: int64;

  /**
   * VLAN for CE/PE Layer 3 connectivity.Example : 501
   */
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  /**
   * ASN of CE devices for CE/PE connectivity.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @visibility("read")
  fabricASN?: int64;
}

/**
 * NPB Static Route Configuration properties.
 */
model NpbStaticRouteConfiguration {
  /**
   * BFD Configuration properties.
   */
  bfdConfiguration?: BfdConfiguration;

  /**
   * List of IPv4 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  ipv4Routes?: StaticRouteProperties[];

  /**
   * List of IPv6 Routes.
   */
  @minItems(1)
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  ipv6Routes?: StaticRouteProperties[];
}

/**
 * NPB Static Route Configuration properties.
 */
model NpbStaticRouteConfigurationPatch {
  /**
   * BFD Configuration properties.
   */
  bfdConfiguration?: BfdPatchConfiguration;

  /**
   * List of IPv4 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  ipv4Routes?: StaticRoutePatchProperties[];

  /**
   * List of IPv6 Routes.
   */
  @minItems(1)
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  ipv6Routes?: StaticRoutePatchProperties[];
}

/**
 * Type of NNI used. Example: CE | NPB
 */
union NniType {
  @doc("NniType-CE(Customer Edge).")
  CE: "CE",

  @doc("NniType-NPB(Network Packet Broker).")
  NPB: "NPB",

  string,
}

/**
 * Configuration to use NNI for Infrastructure Management. Example: True/False.
 */
union IsManagementType {
  @doc("IsManagementType-True")
  True: "True",

  @doc("IsManagementType-False")
  False: "False",

  string,
}
