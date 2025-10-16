using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

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

  @added(Versions.v2024_06_15_preview)
  @doc("PortType Bidirectional")
  Bidirectional: "Bidirectional",

  string,
}

@doc("Layer4 protocol type that needs to be matched.")
union Layer4Protocol {
  @doc("TCP(Transmission Control Protocol) Protocol")
  TCP: "TCP",

  @doc("UDP(User Datagram Protocol) Protocol")
  UDP: "UDP",

  @doc("SCTP(Streaming Control Transmission Protocol) Protocol")
  @added(Versions.v2024_06_15_preview)
  SCTP: "SCTP",

  string,
}

@doc("IP Address type that needs to be matched.")
union SourceDestinationType {
  @doc("SourceDestinationType SourceIP")
  SourceIP: "SourceIP",

  @doc("SourceDestinationType DestinationIP")
  DestinationIP: "DestinationIP",

  @added(Versions.v2024_06_15_preview)
  @doc("SourceDestinationType Bidirectional")
  Bidirectional: "Bidirectional",

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

@doc("Details of the last operations performed on the resource")
@added(Versions.v2024_06_15_preview)
model LastOperationProperties {
  @doc("Details status of the last operation performed on the resource.")
  @visibility(Lifecycle.Read)
  details?: string;
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
  @Azure.ResourceManager.identifiers(#[])
  @doc("List of IP Groups.")
  ipGroups?: IpGroupProperties[];

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of vlan groups.")
  vlanGroups?: VlanGroupProperties[];

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of the port groups.")
  portGroups?: PortGroupProperties[];
}

@doc("Dynamic match configuration object.")
model CommonDynamicMatchConfigurationPatch {
  @Azure.ResourceManager.identifiers(#[])
  @doc("List of IP Groups.")
  ipGroups?: IpGroupPatchProperties[];

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of vlan groups.")
  vlanGroups?: VlanGroupPatchProperties[];

  @Azure.ResourceManager.identifiers(#[])
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
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  @doc("The name of the resource")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The type of the resource. E.g. 'Microsoft.Compute/virtualMachines' or 'Microsoft.Storage/storageAccounts'")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;
}

@doc("The response of the action validate configuration.")
model ValidateConfigurationResponse {
  ...ErrorResponse;

  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("URL for the details of the response.")
  url?: string;
}

@doc("Common response for device updates.")
model CommonPostActionResponseForDeviceUpdate {
  ...ErrorResponse;

  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
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
@doc("The current status of an async operation.")
model CommonPostActionResponseForDeviceROCommandsOperationStatusResult {
  ...ErrorResponse;

  @doc("The end time of the operation.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("Fully qualified ID for the async operation.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("Name of the async operation.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The additional properties of the operation status result.")
  properties?: CommonPostActionResponseForDeviceROCommands;

  @doc("Fully qualified ID of the resource against which the original async operation was started.")
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>;

  @doc("The start time of the operation.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("Operation status.")
  status: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Common response for device Ro Commands.")
@removed(Versions.v2024_06_15_preview)
@renamedFrom(
  Versions.v2024_06_15_preview,
  "CommonPostActionResponseForDeviceROCommands"
)
model CommonPostActionResponseForDeviceROCommandsDeprecated {
  ...ErrorResponse;

  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Predefined link containing Device RO Command output.")
  outputUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Common response for device Ro Commands.")
model CommonPostActionResponseForDeviceROCommands {
  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Predefined link containing Device RO Command output.")
  outputUrl?: string;

  @doc("Device RO command Response limited to 4000 characters.")
  deviceConfigurationPreview?: string;
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
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Predefined link containing Device Rw Command output.")
  outputUrl?: string;
}

@doc("Import Route Policy Configuration.")
model ImportRoutePolicyInformation {
  @doc("Import IPv4 Route Policy Id.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "importIpv4RoutePolicyId")
  importIpv4RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import IPv4 Route Policy Id.")
  @added(Versions.v2024_06_15_preview)
  importIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import IPv6 Route Policy Id.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "importIpv6RoutePolicyId")
  importIpv6RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import IPv6 Route Policy Id.")
  @added(Versions.v2024_06_15_preview)
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
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportIpv4RoutePolicyId")
  exportIpv4RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Export IPv4 Route Policy Id.")
  @added(Versions.v2024_06_15_preview)
  exportIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Export IPv6 Route Policy Id.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportIpv6RoutePolicyId")
  exportIpv6RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Export IPv6 Route Policy Id.")
  @added(Versions.v2024_06_15_preview)
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
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  @doc("The type of the resource. E.g. 'Microsoft.Compute/virtualMachines' or 'Microsoft.Storage/storageAccounts'")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
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
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "primaryIpv6Prefix")
  primaryIpv6PrefixPreview?: string;

  @doc("IPv6 Address Prefix.")
  @added(Versions.v2024_06_15_preview)
  primaryIpv6Prefix?: string;

  @doc("Secondary IPv4 Address Prefix.")
  secondaryIpv4Prefix?: string;

  @doc("Secondary IPv6 Address Prefix.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "secondaryIpv6Prefix")
  secondaryIpv6PrefixPreview?: string;

  @doc("Secondary IPv6 Address Prefix.")
  @added(Versions.v2024_06_15_preview)
  secondaryIpv6Prefix?: string;
}

@doc("BFD configuration properties")
model BfdConfiguration {
  @doc("Administrative state of the BfdConfiguration. Example: Enabled | Disabled.")
  @visibility(Lifecycle.Read)
  administrativeState?: BfdAdministrativeState = BfdAdministrativeState.Disabled;

  @doc("Interval in milliseconds. Example: 300.")
  intervalInMilliSeconds?: int32 = 300;

  @doc("Multiplier for the Bfd Configuration. Example: 5.")
  multiplier?: int32 = 5;
}

@doc("BFD configuration properties")
model BfdPatchConfiguration {
  @doc("Administrative state of the BfdConfiguration. Example: Enabled | Disabled.")
  @visibility(Lifecycle.Read)
  administrativeState?: BfdAdministrativeState;

  @doc("Interval in milliseconds. Example: 300.")
  intervalInMilliSeconds?: int32;

  @doc("Multiplier for the Bfd Configuration. Example: 5.")
  multiplier?: int32;
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

@doc("Import Route Policy either IPv4 or IPv6.")
model ImportRoutePolicy {
  @doc("ARM resource ID of RoutePolicy.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "importIpv4RoutePolicyId")
  importIpv4RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM resource ID of RoutePolicy.")
  @added(Versions.v2024_06_15_preview)
  importIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM resource ID of RoutePolicy.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "importIpv6RoutePolicyId")
  importIpv6RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM resource ID of RoutePolicy.")
  @added(Versions.v2024_06_15_preview)
  importIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Import Route Policy either IPv4 or IPv6.")
model ImportRoutePolicyPatch is ImportRoutePolicy;

@doc("Export Route Policy either IPv4 or IPv6.")
model ExportRoutePolicy {
  @doc("ARM resource ID of RoutePolicy.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportIpv4RoutePolicyId")
  exportIpv4RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM resource ID of RoutePolicy.")
  @added(Versions.v2024_06_15_preview)
  exportIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM resource ID of RoutePolicy.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportIpv6RoutePolicyId")
  exportIpv6RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM resource ID of RoutePolicy.")
  @added(Versions.v2024_06_15_preview)
  exportIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Export Route Policy either IPv4 or IPv6.")
model ExportRoutePolicyPatch is ExportRoutePolicy;

@doc("Static Route Configuration properties.")
model StaticRouteConfiguration {
  @doc("BFD configuration properties")
  bfdConfiguration?: BfdConfiguration;

  @doc("List of IPv4 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: StaticRouteProperties[];

  @doc("List of IPv6 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRouteProperties[];

  @doc("Extension. Example: NoExtension | NPB.")
  extension?: Extension = Extension.NoExtension;
}

@doc("Static Route Configuration properties.")
model StaticRoutePatchConfiguration {
  @doc("BFD configuration properties")
  bfdConfiguration?: BfdPatchConfiguration;

  @doc("List of IPv4 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv4Routes?: StaticRoutePatchProperties[];

  @doc("List of IPv6 Routes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  ipv6Routes?: StaticRoutePatchProperties[];
}

@added(Versions.v2024_06_15_preview)
@doc("The managed service identities assigned to this resource.")
model ManagedServiceIdentityPatch
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.Foundations.ManagedServiceIdentity>>;

@added(Versions.v2024_06_15_preview)
@doc("IdentitySelector represents the selection of a managed identity for use.")
model IdentitySelector {
  @doc("The type of managed identity that is being selected.")
  identityType: ManagedServiceIdentitySelectorType;

  @doc("The user assigned managed identity resource ID to use. Mutually exclusive with a system assigned identity type.")
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@added(Versions.v2024_06_15_preview)
@doc("IdentitySelector represents the selection of a managed identity for use.")
model IdentitySelectorPatch {
  @doc("The type of managed identity that is being selected.")
  identityType?: ManagedServiceIdentitySelectorType;

  @doc("The user assigned managed identity resource ID to use. Mutually exclusive with a system assigned identity type.")
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("The type of managed identity.")
@added(Versions.v2024_06_15_preview)
union ManagedServiceIdentitySelectorType {
  @doc("System Assigned Identity.")
  SystemAssignedIdentity: "SystemAssignedIdentity",

  @doc("User Assigned Identity.")
  UserAssignedIdentity: "UserAssignedIdentity",

  string,
}

@doc("Unique Route Distinguisher Configuration State.")
@added(Versions.v2024_06_15_preview)
union UniqueRouteDistinguisherConfigurationState {
  @doc("UniqueRouteDistinguisherConfigurationState Enabled")
  Enabled: "Enabled",

  @doc("UniqueRouteDistinguisherConfigurationState Disabled")
  Disabled: "Disabled",

  string,
}

@doc("NNI Derived Unique Route Distinguisher Configuration State.")
@added(Versions.v2024_06_15_preview)
union NNIDerivedUniqueRouteDistinguisherConfigurationState {
  @doc("NNI derived unique route distinguisher configuration state Enabled")
  Enabled: "Enabled",

  @doc("NNI derived unique route distinguisher configuration state Disabled")
  Disabled: "Disabled",

  string,
}

@doc("BGP Monitoring Protocol (BMP) configuration state.")
@added(Versions.v2024_06_15_preview)
union BmpConfigurationState {
  @doc("BGP Monitoring Protocol (BMP) ConfigurationState - Enabled")
  Enabled: "Enabled",

  @doc("BGP Monitoring Protocol (BMP) ConfigurationState - Disabled")
  Disabled: "Disabled",

  string,
}

@doc("Border Gateway Protocol (BGP) Administrative State values")
@added(Versions.v2024_06_15_preview)
union BgpAdministrativeState {
  @doc("BgpAdministrativeState-Enabled")
  Enabled: "Enabled",

  @doc("BgpAdministrativeState-Disabled")
  Disabled: "Disabled",

  string,
}

@doc("External Network native IPv4 prefix limit properties")
@added(Versions.v2024_06_15_preview)
model NativeIpv4PrefixLimitProperties {
  @doc("Prefix limits")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  prefixLimits?: PrefixLimitProperties[];
}

@doc("External Network native IPv4 prefix limits patch properties")
@added(Versions.v2024_06_15_preview)
model NativeIpv4PrefixLimitPatchProperties {
  @doc("Prefix limits")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  prefixLimits?: PrefixLimitPatchProperties[];
}

@doc("External Network native IPv6 prefix limit properties")
@added(Versions.v2024_06_15_preview)
model NativeIpv6PrefixLimitProperties {
  @doc("Prefix limits")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  prefixLimits?: PrefixLimitProperties[];
}

@doc("External Network native IPv6 prefix limits patch properties")
@added(Versions.v2024_06_15_preview)
model NativeIpv6PrefixLimitPatchProperties {
  @doc("Prefix limits")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  prefixLimits?: PrefixLimitPatchProperties[];
}

@doc("Prefix Limit properties.")
@added(Versions.v2024_06_15_preview)
model PrefixLimitProperties {
  @doc("Maximum routes allowed.")
  maximumRoutes?: int32;

  @doc("Limit at which route prefixes a warning is generate.")
  threshold?: int32;

  @doc("Idle Time Expiry in seconds, default is 60.")
  idleTimeExpiry?: int32 = 60;
}

@doc("Prefix Limit Patch properties.")
@added(Versions.v2024_06_15_preview)
model PrefixLimitPatchProperties {
  @doc("Maximum routes allowed.")
  maximumRoutes?: int32;

  @doc("Limit at which route prefixes a warning is generate.")
  threshold?: int32;

  @doc("Idle time expiry in seconds.")
  idleTimeExpiry?: int32;
}

@doc("V4 over V6 BGP session state")
@added(Versions.v2024_06_15_preview)
union V4OverV6BgpSessionState {
  @doc("V4OverV6BgpSessionState-Enabled")
  Enabled: "Enabled",

  @doc("V4OverV6BgpSessionState-Disabled")
  Disabled: "Disabled",

  string,
}

@doc("V6 over V4 BGP session state")
@added(Versions.v2024_06_15_preview)
union V6OverV4BgpSessionState {
  @doc("V6OverV4BgpSessionState-Enabled")
  Enabled: "Enabled",

  @doc("V6OverV4BgpSessionState-Disabled")
  Disabled: "Disabled",

  string,
}
