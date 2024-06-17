using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedNetworkFabric;
interface Operations extends Azure.ResourceManager.Operations {}

@doc("Configuration state for the resource.")
union ConfigurationState {
  @doc("Success Configuration State")
  Succeeded: "Succeeded",

  @doc("Failed Configuration State")
  Failed: "Failed",

  @doc("Rejected Configuration State")
  Rejected: "Rejected",

  @doc("Accepted Configuration State")
  Accepted: "Accepted",

  @doc("Provisioned Configuration State")
  Provisioned: "Provisioned",

  @doc("ErrorProvisioning Configuration State")
  ErrorProvisioning: "ErrorProvisioning",

  @doc("Deprovisioning Configuration State")
  Deprovisioning: "Deprovisioning",

  @doc("Deprovisioned Configuration State")
  Deprovisioned: "Deprovisioned",

  @doc("ErrorDeprovisioning Configuration State")
  ErrorDeprovisioning: "ErrorDeprovisioning",

  @doc("DeferredControl Configuration State")
  DeferredControl: "DeferredControl",

  @doc("Provisioning Configuration State")
  Provisioning: "Provisioning",

  @doc("PendingCommit Configuration State")
  PendingCommit: "PendingCommit",

  string,
}

@doc("The current provisioning state.")
union ProvisioningState {
  @doc("Accepted Provisioning State")
  Accepted: "Accepted",

  @doc("Succeeded Provisioning State")
  Succeeded: "Succeeded",

  @doc("Updating Provisioning State")
  Updating: "Updating",

  @doc("Deleting Provisioning State")
  Deleting: "Deleting",

  @doc("Failed Provisioning State")
  Failed: "Failed",

  @doc("Canceled Provisioning State")
  Canceled: "Canceled",

  string,
}

@doc("State defined to represent administrative actions or post actions on a particular resource.")
union AdministrativeState {
  @doc("Enabled Administrative State")
  Enabled: "Enabled",

  @doc("Disabled Administrative State")
  Disabled: "Disabled",

  @doc("MAT(Manual Action Taken) Administrative State")
  MAT: "MAT",

  @doc("RMA(Return Material Authorization) Administrative State")
  RMA: "RMA",

  @doc("UnderMaintenance Administrative State")
  UnderMaintenance: "UnderMaintenance",

  string,
}

@doc("Input method to configure Access Control List.")
union ConfigurationType {
  @doc("File Configuration Type")
  File: "File",

  @doc("Inline Configuration Type")
  Inline: "Inline",

  string,
}

@doc("Community action types. Example: Permit | Deny.")
union CommunityActionTypes {
  @doc("Permit Community Action Types")
  Permit: "Permit",

  @doc("Deny Community Action Types")
  Deny: "Deny",

  string,
}

@doc("IP Address type.")
union IPAddressType {
  @doc("IPv4 IP address")
  IPv4: "IPv4",

  @doc("IPv6 IP address")
  IPv6: "IPv6",

  string,
}

@doc("Port type that needs to be matched.")
union PortType {
  @doc("PortType SourcePort")
  SourcePort: "SourcePort",

  @doc("PortType DestinationPort")
  DestinationPort: "DestinationPort",

  string,
}

@doc("Layer4 protocol type that needs to be matched.")
union Layer4Protocol {
  @doc("TCP(Transmission Control Protocol) Protocol")
  TCP: "TCP",

  @doc("UDP(User Datagram Protocol) Protocol")
  UDP: "UDP",

  string,
}

@doc("IP Address type that needs to be matched.")
union SourceDestinationType {
  @doc("SourceDestinationType SourceIP")
  SourceIP: "SourceIP",

  @doc("SourceDestinationType DestinationIP")
  DestinationIP: "DestinationIP",

  string,
}

@doc("IP Prefix Type that needs to be matched.")
union PrefixType {
  @doc("PrefixType Prefix")
  Prefix: "Prefix",

  @doc("PrefixType LongestPrefix")
  LongestPrefix: "LongestPrefix",

  string,
}

@doc("Administrative state.")
union EnableDisableState {
  @doc("AdministrativeState Enable")
  Enable: "Enable",

  @doc("AdministrativeState Disable")
  Disable: "Disable",

  @doc("AdministrativeState UnderMaintenance")
  UnderMaintenance: "UnderMaintenance",

  string,
}

@doc("Administrative state of the BfdConfiguration. Example: Enabled | Disabled.")
union BfdAdministrativeState {
  @doc("Represents the enabled state of BFD administrative state.")
  Enabled: "Enabled",

  @doc("Represents the disabled state of BFD administrative state.")
  Disabled: "Disabled",

  @doc("Represents the MAT(Manual Action Taken) state of BFD administrative state.")
  MAT: "MAT",

  @doc("Represents the RMA(Return Material Authorization) state of BFD administrative state.")
  RMA: "RMA",

  string,
}

@doc("Boolean union. Example- True/False")
union BooleanEnumProperty {
  @doc("EnumProperty-True")
  True: "True",

  @doc("EnumProperty-False")
  False: "False",

  string,
}

@doc("Peering option list.")
union PeeringOption {
  @doc("PeeringOption-OptionA")
  OptionA: "OptionA",

  @doc("PeeringOption-OptionB")
  OptionB: "OptionB",

  string,
}

@doc("AddressFamilyType. This parameter decides whether the given ipv4 or ipv6 route policy.")
union AddressFamilyType {
  @doc("AddressType-IPv4")
  IPv4: "IPv4",

  @doc("AddressType-IPv6")
  IPv6: "IPv6",

  string,
}

@doc("Switch configuration entries require a description to discern between configuration group")
model AnnotationResource {
  @doc("Switch configuration description.")
  annotation?: string;
}

@doc("Port condition that needs to be matched.")
model PortCondition {
  @doc("Port type that needs to be matched.")
  portType?: PortType;

  @doc("Layer4 protocol type that needs to be matched.")
  layer4Protocol: Layer4Protocol;

  @doc("List of the Ports that need to be matched.")
  ports?: string[];

  @doc("List of the port Group Names that need to be matched.")
  portGroupNames?: string[];
}

@doc("Port condition that needs to be matched.")
model PortConditionPatch {
  @doc("Port type that needs to be matched.")
  portType?: PortType;

  @doc("Layer4 protocol type that needs to be matched.")
  layer4Protocol?: Layer4Protocol;

  @doc("List of the Ports that need to be matched.")
  ports?: string[];

  @doc("List of the port Group Names that need to be matched.")
  portGroupNames?: string[];
}

@doc("Defines the common match conditions of the ACL and Network Tap Rule.")
model CommonMatchConditions {
  @doc("List of the protocols that need to be matched.")
  @minItems(1)
  protocolTypes?: string[];

  @doc("Vlan match condition that needs to be matched.")
  vlanMatchCondition?: VlanMatchCondition;

  @doc("IP condition that needs to be matched.")
  ipCondition?: IpMatchCondition;
}

@doc("Defines the common match conditions of the ACL and Network Tap Rule.")
model CommonMatchConditionsPatch {
  @doc("List of the protocols that need to be matched.")
  @minItems(1)
  protocolTypes?: string[];

  @doc("Vlan match condition that needs to be matched.")
  vlanMatchCondition?: VlanMatchConditionPatch;

  @doc("IP condition that needs to be matched.")
  ipCondition?: IpMatchConditionPatch;
}

@doc("The vlan match conditions that need to be matched.")
model VlanMatchCondition {
  @doc("List of vlans that need to be matched. Inputs can be single vlan or the range of vlans.")
  @minItems(1)
  vlans?: string[];

  @doc("List of inner vlans that need to be matched.Inputs can be single vlan or the range of vlans.")
  @minItems(1)
  innerVlans?: string[];

  @doc("List of vlan group names that need to be matched.")
  @minItems(1)
  vlanGroupNames?: string[];
}

@doc("The vlan match conditions that need to be matched.")
model VlanMatchConditionPatch is VlanMatchCondition;

@doc("Defines the condition that can be filtered using the selected IPs.")
model IpMatchCondition {
  @doc("IP Address type that needs to be matched.")
  type?: SourceDestinationType;

  @doc("IP Prefix Type that needs to be matched.")
  prefixType?: PrefixType;

  @doc("The list of IP Prefixes that need to be matched.")
  @minItems(1)
  ipPrefixValues?: string[];

  @doc("The List of IP Group Names that need to be matched.")
  @minItems(1)
  ipGroupNames?: string[];
}

@doc("Defines the condition that can be filtered using the selected IPs.")
model IpMatchConditionPatch is IpMatchCondition;

@doc("Dynamic match configuration object.")
model CommonDynamicMatchConfiguration {
  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of IP Groups.")
  ipGroups?: IpGroupProperties[];

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of vlan groups.")
  vlanGroups?: VlanGroupProperties[];

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of the port groups.")
  portGroups?: PortGroupProperties[];
}

@doc("Dynamic match configuration object.")
model CommonDynamicMatchConfigurationPatch {
  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of IP Groups.")
  ipGroups?: IpGroupPatchProperties[];

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of vlan groups.")
  vlanGroups?: VlanGroupPatchProperties[];

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of the port groups.")
  portGroups?: PortGroupPatchProperties[];
}

@doc("IP Group properties.")
model IpGroupProperties {
  @doc("IP Group name.")
  @minLength(1)
  name?: string;

  @doc("IP Address type.")
  ipAddressType?: IPAddressType;

  @doc("List of IP Prefixes.")
  ipPrefixes?: string[];
}

@doc("IP Group properties.")
model IpGroupPatchProperties is IpGroupProperties;

@doc("Vlan group properties.")
model VlanGroupProperties {
  @doc("Vlan group name.")
  @minLength(1)
  name?: string;

  @doc("List of vlans.")
  vlans?: string[];
}

@doc("Vlan group properties.")
model VlanGroupPatchProperties is VlanGroupProperties;

@doc("Port Group properties.")
model PortGroupProperties {
  @doc("The name of the port group.")
  @minLength(1)
  name?: string;

  @doc("List of the ports that need to be matched.")
  ports?: string[];
}

@doc("Port Group Properties")
model PortGroupPatchProperties is PortGroupProperties;

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}'")
  @visibility("read")
  id?: Azure.Core.armResourceIdentifier;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. 'Microsoft.Compute/virtualMachines' or 'Microsoft.Storage/storageAccounts'")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Update administrative state on list of resources.")
model UpdateAdministrativeState {
  ...EnableDisableOnResources;

  @doc("Administrative state.")
  state?: EnableDisableState;
}

@doc("Update administrative state on list of resources.")
model EnableDisableOnResources {
  @doc("Network Fabrics or Network Rack resource Id.")
  resourceIds?: string[];
}

@doc("Common response for the state updates.")
model CommonPostActionResponseForStateUpdate {
  ...ErrorResponse;

  @doc("Gets the configuration state.")
  @visibility("read")
  configurationState?: ConfigurationState;
}

@doc("The response of the action validate configuration.")
model ValidateConfigurationResponse {
  ...ErrorResponse;

  @doc("Gets the configuration state.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("URL for the details of the response.")
  url?: string;
}

@doc("Common response for device updates.")
model CommonPostActionResponseForDeviceUpdate {
  ...ErrorResponse;

  @doc("Gets the configuration state.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("List of ARM Resource IDs for which the given action applied successfully.")
  successfulDevices?: string[];

  @doc("List of ARM Resource IDs for which the given action failed to apply.")
  failedDevices?: string[];
}

@doc("Update version properties.")
model UpdateVersion {
  @doc("Specify the version.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Provide the RO command")
model DeviceRoCommand {
  @doc("Specify the command.")
  command?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Common response for device Ro Commands.")
model CommonPostActionResponseForDeviceROCommands {
  ...ErrorResponse;

  @doc("Gets the configuration state.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Predefined link containing Device RO Command output.")
  outputUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Provide the Rw command")
model DeviceRwCommand {
  @doc("Specify the command.")
  command?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Common response for device Rw Commands.")
model CommonPostActionResponseForDeviceRWCommands {
  ...ErrorResponse;

  @doc("Gets the configuration state.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Predefined link containing Device Rw Command output.")
  outputUrl?: string;
}

@doc("Import Route Policy Configuration.")
model ImportRoutePolicyInformation {
  @doc("Import IPv4 Route Policy Id.")
  importIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import IPv6 Route Policy Id.")
  importIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Import Route Policy Configuration.")
model ImportRoutePolicyInformationPatch is ImportRoutePolicyInformation;

@doc("Export Route Policy Configuration.")
model ExportRoutePolicyInformation {
  @doc("Export IPv4 Route Policy Id.")
  exportIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Export IPv6 Route Policy Id.")
  exportIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Export Route Policy Configuration.")
model ExportRoutePolicyInformationPatch is ExportRoutePolicyInformation;

@doc("ProxyResourceBase with no property bag")
model ProxyResourceBase {
  @doc("Fully qualified resource ID for the resource. E.g. '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}'")
  @visibility("read")
  id?: Azure.Core.armResourceIdentifier;

  @doc("The type of the resource. E.g. 'Microsoft.Compute/virtualMachines' or 'Microsoft.Storage/storageAccounts'")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Base tracked resource type for PATCH updates.")
model TagsUpdate {
  ...ArmTagsProperty;
}

@doc("Layer 3 primary and secondary IP Address prefixes.")
model Layer3IpPrefixPatchProperties is Layer3IpPrefixProperties;

@doc("Layer 3 primary and secondary IP Address prefixes.")
model Layer3IpPrefixProperties {
  @doc("IPv4 Address Prefix.")
  primaryIpv4Prefix?: string;

  @doc("IPv6 Address Prefix.")
  primaryIpv6Prefix?: string;

  @doc("Secondary IPv4 Address Prefix.")
  secondaryIpv4Prefix?: string;

  @doc("Secondary IPv6 Address Prefix.")
  secondaryIpv6Prefix?: string;
}

@doc("BFD configuration properties")
@withoutDefaultValues
model BfdPatchConfiguration is BfdConfiguration;

@doc("BFD configuration properties")
model BfdConfiguration {
  @doc("Administrative state of the BfdConfiguration. Example: Enabled | Disabled.")
  @visibility("read")
  administrativeState?: BfdAdministrativeState = BfdAdministrativeState.Disabled;

  @doc("Interval in milliseconds. Example: 300.")
  intervalInMilliSeconds?: int32 = 300;

  @doc("Multiplier for the Bfd Configuration. Example: 5.")
  multiplier?: int32 = 5;
}

@doc("Route Properties.")
model StaticRouteProperties {
  @doc("Prefix of the route.")
  @minLength(1)
  prefix: string;

  @doc("List of next hop addresses.")
  @minItems(1)
  nextHop: string[];
}

@doc("Route Properties.")
model StaticRoutePatchProperties is StaticRouteProperties;

@doc("Route Target Configuration.")
model RouteTargetInformation {
  @doc("Route Targets to be applied for incoming routes into CE.")
  importIpv4RouteTargets?: string[];

  @doc("Route Targets to be applied for incoming routes from CE.")
  importIpv6RouteTargets?: string[];

  @doc("Route Targets to be applied for outgoing routes into CE.")
  exportIpv4RouteTargets?: string[];

  @doc("Route Targets to be applied for outgoing routes from CE.")
  exportIpv6RouteTargets?: string[];
}

@doc("Route Target Configuration.")
model RouteTargetPatchInformation is RouteTargetInformation;

/**
 * Import Route Policy either IPv4 or IPv6.
 */
model ImportRoutePolicy {
  /**
   * ARM resource ID of RoutePolicy.
   */
  importIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * ARM resource ID of RoutePolicy.
   */
  importIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Import Route Policy either IPv4 or IPv6.")
model ImportRoutePolicyPatch is ImportRoutePolicy;

/**
 * Export Route Policy either IPv4 or IPv6.
 */
model ExportRoutePolicy {
  /**
   * ARM resource ID of RoutePolicy.
   */
  exportIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * ARM resource ID of RoutePolicy.
   */
  exportIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Export Route Policy either IPv4 or IPv6.")
model ExportRoutePolicyPatch is ExportRoutePolicy;
