import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;
/**
 * Network Fabric Properties defines the properties of the resource.
 */
model NetworkFabricProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * Supported Network Fabric SKU.Example: Compute / Aggregate racks. Once the user chooses a particular SKU, only supported racks can be added to the Network Fabric. The SKU determines whether it is a single / multi rack Network Fabric.
   */
  @visibility("read", "create")
  @minLength(1)
  networkFabricSku: string;

  /**
   * The version of Network Fabric.
   */
  @minLength(1)
  fabricVersion?: string;

  /**
   * Array of router IDs.
   */
  @visibility("read")
  routerIds?: string[];

  /**
   * Azure resource ID for the NetworkFabricController the NetworkFabric belongs.
   */
  @visibility("read", "create")
  networkFabricControllerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabricControllers";
    }
  ]>;

  /**
   * Number of compute racks associated to Network Fabric.
   */
  @maxValue(8)
  @minValue(1)
  rackCount?: int32;

  /**
   * Number of servers.Possible values are from 1-16.
   */
  @maxValue(16)
  @minValue(1)
  serverCountPerRack: int32;

  /**
   * IPv4Prefix for Management Network. Example: 10.1.0.0/19.
   */
  @minLength(1)
  ipv4Prefix: string;

  /**
   * IPv6Prefix for Management Network. Example: 3FFE:FFFF:0:CD40::/59
   */
  @minLength(1)
  ipv6Prefix?: string;

  /**
   * ASN of CE devices for CE/PE connectivity.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(4294967295)
  @minValue(1)
  fabricASN: int64;

  /**
   * Network and credentials configuration currently applied to terminal server.
   */
  terminalServerConfiguration: TerminalServerConfiguration;

  /**
   * Configuration to be used to setup the management network.
   */
  managementNetworkConfiguration: ManagementNetworkConfigurationProperties;

  /**
   * List of NetworkRack resource IDs under the Network Fabric. The number of racks allowed depends on the Network Fabric SKU.
   */
  @visibility("read")
  racks?: string[];

  /**
   * List of L2 Isolation Domain resource IDs under the Network Fabric.
   */
  @visibility("read")
  l2IsolationDomains?: string[];

  /**
   * List of L3 Isolation Domain resource IDs under the Network Fabric.
   */
  @visibility("read")
  l3IsolationDomains?: string[];

  /**
   * Configuration state of the resource.
   */
  @visibility("read")
  configurationState?: ConfigurationState;

  /**
   * Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of NFC provisioning.
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
 * Network and credentials configuration currently applied to terminal server.
 */
model TerminalServerConfiguration {
  /**
   * Username for the terminal server connection.
   */
  @minLength(1)
  username: string;

  /**
   * Password for the terminal server connection.
   */
  @secret
  @minLength(1)
  password: string;

  /**
   * Serial Number of Terminal server.
   */
  @minLength(1)
  serialNumber?: string;

  /**
   * IPv4 Address Prefix.
   */
  primaryIpv4Prefix: string;

  /**
   * IPv6 Address Prefix.
   */
  primaryIpv6Prefix?: string;

  /**
   * Secondary IPv4 Address Prefix.
   */
  secondaryIpv4Prefix: string;

  /**
   * Secondary IPv6 Address Prefix.
   */
  secondaryIpv6Prefix?: string;

  /**
   * ARM Resource ID used for the NetworkDevice.
   */
  @visibility("read")
  networkDeviceId?: string;
}

/**
 * Network and credential configuration currently applied on terminal server.
 */
model VpnConfigurationProperties {
  /**
   * ARM Resource ID of the Network To Network Interconnect.
   */
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  /**
   * Administrative state of the resource.
   */
  @visibility("read")
  administrativeState?: AdministrativeState;

  /**
   * Peering option list.
   */
  peeringOption: PeeringOption;

  /**
   * option B properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  optionBProperties?: VpnOptionBProperties;

  /**
   * option A properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  optionAProperties?: VpnOptionAProperties;
}

/**
 * Configuration to be used to setup the management network.
 */
model ManagementNetworkConfigurationProperties {
  /**
   * VPN Configuration properties.
   */
  infrastructureVpnConfiguration: VpnConfigurationProperties;

  /**
   * VPN Configuration properties.
   */
  workloadVpnConfiguration: VpnConfigurationProperties;
}

/**
 * Network and credential configuration currently applied on terminal server.
 */
model VpnConfigurationPatchableProperties {
  /**
   * ARM Resource ID of the Network To Network Interconnect.
   */
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  /**
   * Peering option list.
   */
  peeringOption?: PeeringOption;

  /**
   * option B properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  optionBProperties?: VpnOptionBPatchProperties;

  /**
   * option A properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  optionAProperties?: VpnOptionAPatchProperties;
}

/**
 * The Network Fabric resource definition.
 */
model NetworkFabricPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * Network Fabric Patch properties.
   */
  properties?: NetworkFabricPatchProperties;
}

/**
 * Network Fabric Patch properties.
 */
model NetworkFabricPatchProperties {
  ...AnnotationResource;

  /**
   * Number of compute racks associated to Network Fabric.
   */
  @maxValue(8)
  @minValue(1)
  rackCount?: int32;

  /**
   * Number of servers.Possible values are from 1-16.
   */
  @maxValue(16)
  @minValue(1)
  serverCountPerRack?: int32;

  /**
   * IPv4Prefix for Management Network. Example: 10.1.0.0/19.
   */
  @minLength(1)
  ipv4Prefix?: string;

  /**
   * IPv6Prefix for Management Network. Example: 3FFE:FFFF:0:CD40::/59.
   */
  @minLength(1)
  ipv6Prefix?: string;

  /**
   * ASN of CE devices for CE/PE connectivity.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(4294967295)
  @minValue(1)
  fabricASN?: int64;

  /**
   * Network and credentials configuration already applied to terminal server.
   */
  terminalServerConfiguration?: TerminalServerPatchConfiguration;

  /**
   * Configuration to be used to setup the management network.
   */
  managementNetworkConfiguration?: ManagementNetworkPatchConfiguration;
}

/**
 * Network and credentials configuration already applied to terminal server.
 */
model TerminalServerPatchConfiguration {
  /**
   * Username for the terminal server connection.
   */
  @minLength(1)
  username?: string;

  /**
   * Password for the terminal server connection.
   */
  @secret
  @minLength(1)
  password?: string;

  /**
   * Serial Number of Terminal server.
   */
  @minLength(1)
  serialNumber?: string;

  /**
   * IPv4 Address Prefix.
   */
  primaryIpv4Prefix?: string;

  /**
   * IPv6 Address Prefix.
   */
  primaryIpv6Prefix?: string;

  /**
   * Secondary IPv4 Address Prefix.
   */
  secondaryIpv4Prefix?: string;

  /**
   * Secondary IPv6 Address Prefix.
   */
  secondaryIpv6Prefix?: string;
}

/**
 * Configuration to be used to setup the management network.
 */
model ManagementNetworkPatchConfiguration {
  /**
   * VPN Configuration properties.
   */
  infrastructureVpnConfiguration?: VpnConfigurationPatchableProperties;

  /**
   * VPN Configuration properties.
   */
  workloadVpnConfiguration?: VpnConfigurationPatchableProperties;
}

@doc("Model used for Upgrade Network Fabric Properties")
model UpgradeNetworkFabricProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...UpdateVersion;

  /**
   * Action to be performed while upgrading the fabric.
   */
  action?: NetworkFabricUpgradeAction;
}

/**
 * Validation configuration properties.
 */
model ValidateConfigurationProperties {
  /**
   * Validate action that to be performed
   */
  validateAction?: ValidateAction;
}

/**
 * option A properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
model VpnOptionAProperties {
  /**
   * MTU to use for option A peering.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * Vlan Id.Example : 501
   */
  @maxValue(4094)
  @minValue(501)
  vlanId: int32;

  /**
   * Peer ASN number.Example : 28
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(4294967295)
  @minValue(1)
  peerASN: int64;

  /**
   * BFD Configuration properties.
   */
  bfdConfiguration?: BfdConfiguration;

  ...Layer3IpPrefixProperties;
}

/**
 * Peering optionA properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
model VpnOptionAPatchProperties {
  /**
   * MTU to use for option A peering.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  /**
   * Vlan Id.Example : 501
   */
  @maxValue(4094)
  @minValue(501)
  vlanId?: int32;

  /**
   * Peer ASN number.Example : 28
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  /**
   * BFD Configuration properties.
   */
  bfdConfiguration?: BfdPatchConfiguration;

  ...Layer3IpPrefixPatchProperties;
}

/**
 * Option B configuration to be used for Management VPN.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
model VpnOptionBProperties {
  /**
   * Route Targets to be applied for incoming routes into CE. This is for backward compatibility.
   */
  importRouteTargets?: string[];

  /**
   * Route Targets to be applied for outgoing routes from CE. This is for backward compatibility.
   */
  exportRouteTargets?: string[];

  /**
   * Route Targets to be applied.
   */
  routeTargets?: RouteTargetInformation;
}

/**
 * Option B configuration to be used for Management VPN.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
model VpnOptionBPatchProperties {
  /**
   * Route Targets to be applied for incoming routes into CE. This is for backward compatibility.
   */
  importRouteTargets?: string[];

  /**
   * Route Targets to be applied for outgoing routes from CE. This is for backward compatibility.
   */
  exportRouteTargets?: string[];

  /**
   * Route Targets to be applied.
   */
  routeTargets?: RouteTargetPatchInformation;
}
/**
 * Validate action that to be performed
 */
union ValidateAction {
  @doc("ValidateAction-Cabling")
  Cabling: "Cabling",

  @doc("ValidateAction-Configuration")
  Configuration: "Configuration",

  @doc("ValidateAction-Connectivity")
  Connectivity: "Connectivity",

  string,
}

/**
 * Action to be performed while upgrading the fabric.
 */
union NetworkFabricUpgradeAction {
  @doc("UpgradeAction-Start")
  Start: "Start",

  @doc("UpgradeAction -Complete")
  Complete: "Complete",

  string,
}
