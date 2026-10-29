import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

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

  @added(Versions.v2025_07_15)
  @doc("PendingAdministrativeUpdate State")
  PendingAdministrativeUpdate: "PendingAdministrativeUpdate",

  @doc("Updated configuration is pushed to the selected CE device during staged commit operation")
  @added(Versions.v2026_01_15_preview)
  CommitStaged: "CommitStaged",

  @doc("Pushing the updated configuration to the selected CE device failed during staged commit operation")
  @added(Versions.v2026_01_15_preview)
  CommitStageFailed: "CommitStageFailed",

  @doc("Rollback of configuration failed during staged commit rollback operation")
  @added(Versions.v2026_01_15_preview)
  CommitRollbackFailed: "CommitRollbackFailed",

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

  @added(Versions.v2025_07_15)
  @doc("EnabledDegraded Administrative State.")
  EnabledDegraded: "EnabledDegraded",

  string,
}

@doc("Operational State represents the current runtime condition of a networking resource. It reflects the actual health, reachability, and availability of the resource at a given point in time.")
@added(Versions.v2026_01_15_preview)
union OperationalState {
  @doc("Operational State Unknown indicates the state of the resource cannot be determined.")
  Unknown: "Unknown",

  @doc("Operational State Up indicates the resource is operational and functioning normally and all required control-plane and (where applicable) data-plane operations are healthy.")
  Up: "Up",

  @doc("Operational State Down indicates the resource is not functioning or not reachable and no meaningful operations can be performed.")
  Down: "Down",

  @doc("Operational State Degraded indicates the resource is partially functional, some capabilities may be impaired, but the resource is still operational.")
  Degraded: "Degraded",

  string,
}

@doc("Input method indicating whether configuration is provided inline or via a file URL.")
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

  @doc("Type of the operation being performed on the resource.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_07_15_preview)
  operationType?: OperationType;

  @doc("Status of the current operation.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_07_15_preview)
  status?: OperationStatus;

  @doc("Timestamp when the operation started.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_07_15_preview)
  startedAt?: utcDateTime;

  @doc("Timestamp when the operation completed. Not present if still in progress.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_07_15_preview)
  completedAt?: utcDateTime;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("URL to the detailed result blob in the customer's storage account.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_07_15_preview)
  resultBlobUrl?: url;

  @doc("Correlation ID for tracking the operation.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_07_15_preview)
  correlationId?: Azure.Core.uuid;
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
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "protocolTypes")
  protocolTypesDeprecated?: string[];

  @doc("List of the protocols that need to be matched.")
  @added(Versions.v2025_07_15)
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
model VlanMatchConditionPatch {
  @doc("List of vlans that need to be matched. Inputs can be single vlan or the range of vlans.")
  @minItems(1)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "vlans")
  vlansDeprecated?: string[];

  @doc("List of vlans that need to be matched. Inputs can be single vlan or the range of vlans.")
  @added(Versions.v2025_07_15)
  vlans?: string[];

  @doc("List of inner vlans that need to be matched.Inputs can be single vlan or the range of vlans.")
  @minItems(1)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "innerVlans")
  innerVlansDeprecated?: string[];

  @doc("List of inner vlans that need to be matched.Inputs can be single vlan or the range of vlans.")
  @added(Versions.v2025_07_15)
  innerVlans?: string[];

  @doc("List of vlan group names that need to be matched.")
  @minItems(1)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "vlanGroupNames")
  vlanGroupNamesDeprecated?: string[];

  @doc("List of vlan group names that need to be matched.")
  @added(Versions.v2025_07_15)
  vlanGroupNames?: string[];
}

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
model IpMatchConditionPatch {
  @doc("IP Address type that needs to be matched.")
  type?: SourceDestinationType;

  @doc("IP Prefix Type that needs to be matched.")
  prefixType?: PrefixType;

  @doc("The list of IP Prefixes that need to be matched.")
  @minItems(1)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "ipPrefixValues")
  ipPrefixValuesDeprecated?: string[];

  @doc("The list of IP Prefixes that need to be matched.")
  @added(Versions.v2025_07_15)
  ipPrefixValues?: string[];

  @doc("The List of IP Group Names that need to be matched.")
  @minItems(1)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "ipGroupNames")
  ipGroupNamesDeprecated?: string[];

  @doc("The List of IP Group Names that need to be matched.")
  @added(Versions.v2025_07_15)
  ipGroupNames?: string[];
}

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

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending common EnableDisableOnResources instead of spread operator"
@doc("Update administrative state on list of resources.")
model UpdateAdministrativeState extends EnableDisableOnResources {
  @doc("Administrative state.")
  state?: EnableDisableState;

  @doc("Force update of administrative state on the resources. Default value is false.")
  @added(Versions.v2026_07_15_preview)
  force?: BooleanEnumProperty;
}

@doc("Update administrative state on list of resources.")
model EnableDisableOnResources {
  @doc("Network Fabrics or Network Rack resource Id.")
  resourceIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending common error response"
@doc("Common response for the state updates.")
model CommonPostActionResponseForStateUpdate extends CommonErrorResponse {
  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending common error response"
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("The response of the action validate configuration.")
model ValidateConfigurationResponse extends CommonErrorResponse {
  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("URL for the details of the response.")
  url?: string;
}

@doc("The response of the action validate configuration.")
@added(Versions.v2026_01_15_preview)
model ValidateConfigurationResponseV2 {
  ...OperationStatusResult;

  @doc("Network Device Run Rw Command Response properties.")
  properties?: ValidateConfigurationResponseProperties;
}

@added(Versions.v2026_01_15_preview)
@doc("The response of the action validate configuration.")
model ValidateConfigurationResponseProperties {
  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("URL for the details of the response.")
  url?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending common error response instead of spread"
@doc("Common response for device updates.")
model CommonPostActionResponseForDeviceUpdate extends CommonErrorResponse {
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending common error response"
@doc("The current status of an async operation.")
model CommonPostActionResponseForDeviceROCommandsOperationStatusResult
  extends CommonErrorResponse {
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending common error response"
@doc("Common response for device Ro Commands.")
@removed(Versions.v2024_06_15_preview)
@renamedFrom(
  Versions.v2024_06_15_preview,
  "CommonPostActionResponseForDeviceROCommands"
)
model CommonPostActionResponseForDeviceROCommandsDeprecated
  extends CommonErrorResponse {
  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("Predefined link containing Device RO Command output.")
  outputUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Common response for device Ro Commands.")
model CommonPostActionResponseForDeviceROCommands {
  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
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

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("Specify the commands file URL.")
  @added(Versions.v2025_07_15)
  commandUrl?: url;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending common error response instead of spread"
@doc("Common response for device Rw Commands.")
model CommonPostActionResponseForDeviceRWCommands extends CommonErrorResponse {
  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
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
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "prefixLimits")
  prefixLimitsDeprecated?: PrefixLimitPatchProperties[];

  @doc("Prefix limits")
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2025_07_15)
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
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "prefixLimits")
  prefixLimitsDeprecated?: PrefixLimitPatchProperties[];

  @doc("Prefix limits")
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2025_07_15)
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

// Note: This model is intended to be consistent with status reporting in the Network Cloud API
@doc("Status of a secret rotation for a device (Network Device or Terminal Server).")
@added(Versions.v2025_07_15)
model SecretRotationStatus {
  @doc("The date and time when the secret was last changed.")
  @visibility(Lifecycle.Read)
  lastRotationTime?: utcDateTime;

  @doc("Whether the device has been configured with the latest version of the secret.")
  @visibility(Lifecycle.Read)
  synchronizationStatus?: SynchronizationStatus;

  @doc("Reference to the currently configured version of the secret in a key vault.")
  @visibility(Lifecycle.Read)
  secretArchiveReference?: SecretArchiveReference;

  @doc("Identifies the secret according to its purpose.")
  @visibility(Lifecycle.Read)
  secretType?: string;
}

@doc("Synchronization status of a secret or certificate for a device (Network Device or Terminal Server). Whether the device has been configured with the latest version of the secret or certificate.")
@added(Versions.v2025_07_15)
union SynchronizationStatus {
  /**
   * The device has been configured with the latest version of the secret.
   */
  InSync: "InSync",

  /**
   * The device is being reconfigured with the latest version of the secret.
   *
   * While in this state, the secret archive reference may not match the secret configured on the device.
   */
  Synchronizing: "Synchronizing",

  /**
   * The device has not been configured with the latest version of the secret.
   */
  OutOfSync: "OutOfSync",

  string,
}

@doc("A reference to a version of a secret in a key vault.")
model SecretArchiveReference {
  @doc("A Uniform Resource Identifier (URI) for the secret in the key vault.")
  @visibility(Lifecycle.Read)
  keyVaultUri?: url;

  @doc("The resource ID of the key vault containing the secret.")
  @visibility(Lifecycle.Read)
  keyVaultId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  @doc("The name of the secret in the key vault.")
  @visibility(Lifecycle.Read)
  secretName?: string;

  @doc("The version of the secret in the key vault.")
  @visibility(Lifecycle.Read)
  secretVersion?: string;
}

@doc("Status of a certificate rotation for a device (Network Device or Terminal Server).")
@added(Versions.v2025_07_15)
model CertificateRotationStatus {
  @doc("Time at which the certificate will expire, for certificates with a limited validity period.")
  @visibility(Lifecycle.Read)
  expireTime?: utcDateTime;

  @doc("The date and time when the certificate was last changed.")
  @visibility(Lifecycle.Read)
  lastRotationTime?: utcDateTime;

  @doc("Whether the device has been configured with the latest version of the certificate.")
  @visibility(Lifecycle.Read)
  synchronizationStatus?: SynchronizationStatus;

  @doc("Reference to the currently configured version of the certificate in a key vault.")
  @visibility(Lifecycle.Read)
  certificateArchiveReference?: CertificateArchiveReference;

  @doc("Identifies the certificate according to its purpose.")
  @visibility(Lifecycle.Read)
  certificateType?: string;
}

@doc("A reference to a version of a certificate in a key vault.")
model CertificateArchiveReference {
  @doc("A Uniform Resource Identifier (URI) for the certificate in the key vault.")
  @visibility(Lifecycle.Read)
  keyVaultUri?: url;

  @doc("The resource ID of the key vault containing the certificate.")
  @visibility(Lifecycle.Read)
  keyVaultId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  @doc("The name of the certificate in the key vault.")
  @visibility(Lifecycle.Read)
  certificateName?: string;

  @doc("The version of the certificate in the key vault.")
  @visibility(Lifecycle.Read)
  certificateVersion?: string;
}

@doc("Export Policy for the BGP Monitoring Protocol (BMP) Configuration.")
union BmpExportPolicy {
  @doc("BMP ExportPolicy Pre-Policy")
  PrePolicy: "Pre-Policy",

  @doc("BMP ExportPolicy Post-Policy")
  PostPolicy: "Post-Policy",

  @doc("BMP ExportPolicy All")
  All: "All",

  @doc("BMP ExportPolicy LocalRib")
  @added(Versions.v2025_07_15)
  LocalRib: "LocalRib",

  string,
}

@doc("BMP Export Policy Configuration properties.")
@added(Versions.v2025_07_15)
model BmpExportPolicyProperties {
  @doc("Export Policy for the BGP Monitoring Protocol (BMP) Configuration.")
  @minItems(1)
  exportPolicies?: BmpExportPolicy[];
}

@doc("BMP Export Policy Configuration properties.")
@added(Versions.v2025_07_15)
model BmpExportPolicyPatchProperties {
  @doc("Export Policy for the BGP Monitoring Protocol (BMP) Configuration.")
  exportPolicies?: BmpExportPolicy[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Update Administrative State Response.")
@added(Versions.v2025_07_15)
model UpdateAdministrativeStateResponse {
  ...OperationStatusResult;

  @doc("Response properties in case of successful administrative state update.")
  properties?: UpdateAdministrativeStateResponseProperties;
}

@doc("Update Administrative State Response Properties.")
@added(Versions.v2025_07_15)
model UpdateAdministrativeStateResponseProperties {
  @doc("List of ARM Resource IDs for which the given action applied successfully.")
  successfulResources?: Azure.Core.armResourceIdentifier<[]>[];

  @doc("List of ARM Resource IDs for which the given action failed to apply.")
  failedResources?: Azure.Core.armResourceIdentifier<[]>[];
}

@doc("Configuration Regeneration Type used for refresh configuration")
@added(Versions.v2026_01_15_preview)
union ConfigurationRegenerationType {
  @doc("Partial configuration regeneration indicates that the last known good configuration will be reapplied.")
  Partial: "Partial",

  string,
}

@doc("NetworkDeviceRole is the device role: Example: CE | ToR.")
union NetworkDeviceRole {
  @doc("NetworkDeviceRole-CE(Customer Edge)")
  CE: "CE",

  @doc("NetworkDeviceRole-ToR(top of rack)")
  ToR: "ToR",

  @doc("NetworkDeviceRole-NPB(Network Packet Broker)")
  NPB: "NPB",

  @doc("NetworkDeviceRole-TS(Terminal Server)")
  TS: "TS",

  @doc("NetworkDeviceRole-Management")
  Management: "Management",

  string,
}

@doc("Device types for which the refresh configuration action will be applied: Example: CE | ToR | NPB | ManagementSwitch.")
union NetworkFabricRefreshDeviceTypes {
  @doc("DeviceType-CE(Customer Edge)")
  CE: "CE",

  @doc("DeviceType-ToR(top of rack)")
  ToR: "ToR",

  @doc("DeviceType-NPB(Network Packet Broker)")
  NPB: "NPB",

  @doc("DeviceType-ManagementSwitch")
  ManagementSwitch: "ManagementSwitch",

  string,
}

@doc("Allowed types for generate base configuration during network fabric refresh")
union GenerateBaseConfiguration {
  @doc("Disabled indicates that base configuration should not be generated during network fabric refresh")
  Disabled: "Disabled",

  @doc("Enabled indicates that base configuration should be generated during network fabric refresh")
  Enabled: "Enabled",

  string,
}

@doc("Type of validation to perform.")
@added(Versions.v2026_07_15_preview)
union ValidationType {
  /** Upgrade precheck validation */
  UpgradePrecheck: "UpgradePrecheck",

  /** Upgrade stage-gate validation between device upgrade batches */
  UpgradeStageGate: "UpgradeStageGate",

  /** Upgrade postcheck validation */
  UpgradePostcheck: "UpgradePostcheck",

  string,
}

@doc("Result of a validation check.")
@added(Versions.v2026_07_15_preview)
union ValidationResult {
  /** Validation check passed */
  Passed: "Passed",

  /** Validation check failed */
  Failed: "Failed",

  /** Validation check passed with warnings */
  Warning: "Warning",

  string,
}

@doc("Type of operation being performed on the resource. Superset of ValidationType with additional operation-specific values.")
@added(Versions.v2026_07_15_preview)
union OperationType {
  /** Upgrade operation */
  Upgrade: "Upgrade",

  /** Provision operation */
  Provision: "Provision",

  /** Commit configuration operation */
  CommitConfiguration: "CommitConfiguration",

  /** Validate configuration operation */
  ValidateConfiguration: "ValidateConfiguration",

  /** Run validation operation */
  RunValidation: "RunValidation",

  /** Refresh configuration operation */
  RefreshConfiguration: "RefreshConfiguration",

  /** Deprovision operation */
  Deprovision: "Deprovision",

  /** Reboot operation */
  Reboot: "Reboot",

  /** Update administrative state operation */
  UpdateAdministrativeState: "UpdateAdministrativeState",

  /** Update BFD configuration operation */
  UpdateBfdConfiguration: "UpdateBfdConfiguration",

  /** Commit batch status operation */
  CommitBatchStatus: "CommitBatchStatus",

  /** Discard commit batch operation */
  DiscardCommitBatch: "DiscardCommitBatch",

  /** Lock fabric operation */
  LockFabric: "LockFabric",

  /** Rotate passwords operation */
  RotatePasswords: "RotatePasswords",

  string,
}

@doc("Status of the current operation.")
@added(Versions.v2026_07_15_preview)
union OperationStatus {
  /** Operation is currently running */
  Running: "Running",

  /** Operation has succeeded */
  Succeeded: "Succeeded",

  /** Operation has failed */
  Failed: "Failed",

  string,
}

@doc("Category of a validation check.")
@added(Versions.v2026_07_15_preview)
union ValidationCheckCategory {
  /** Implicit baseline checks performed automatically by the service */
  ImplicitBaseline: "ImplicitBaseline",

  /** Checks derived from custom device commands provided by the user */
  CustomCommandSet: "CustomCommandSet",

  /** Checks derived from custom metric validation rules provided by the user */
  CustomMetric: "CustomMetric",

  string,
}

@doc("A validation check to waive during a validation run, with an optional operator-provided justification captured for audit.")
@added(Versions.v2026_07_15_preview)
model ValidationCheckOverride {
  @doc("Name of the validation check to waive. Must match a checkName produced by the validation run.")
  checkName: string;

  @doc("Operator-provided justification for waiving this check. Captured for audit and included in the detailed validation report.")
  justification?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request properties for the runValidation action.")
@added(Versions.v2026_07_15_preview)
model RunValidationRequest {
  @doc("Type of validation to perform.")
  validationType: ValidationType;

  @doc("Target version for upgrade validation in semantic versioning format (e.g., '4.1.0'). Required for upgrade-related validation types.")
  targetVersion?: string;

  @doc("Device command configuration specifying how validation commands are provided.")
  deviceCommandConfiguration?: DeviceCommandConfiguration;

  @doc("Custom metric validation rules to evaluate device metrics as part of validation.")
  @identifiers(#["checkName"])
  metricsConfiguration?: MetricValidationRule[];

  @doc("List of validation checks to waive for this run even if they fail or warn, each with an optional operator-provided justification captured for audit. Waived checks are recorded in the detailed validation report.")
  @identifiers(#["checkName"])
  overrideChecks?: ValidationCheckOverride[];
}

@doc("Base model for device command configuration, discriminated by configurationType.")
@discriminator("configurationType")
@added(Versions.v2026_07_15_preview)
model DeviceCommandConfiguration {
  @doc("Configuration type indicating how commands are provided.")
  configurationType: ConfigurationType;
}

@doc("Inline device command configuration specifying commands directly.")
@added(Versions.v2026_07_15_preview)
model InlineDeviceCommandConfiguration extends DeviceCommandConfiguration {
  @doc("Configuration type discriminator.")
  configurationType: ConfigurationType.Inline;

  @doc("List of device commands to execute as part of validation, each with optional validation rules.")
  @identifiers(#["checkName"])
  commands: DeviceCommand[];
}

@doc("A device command with optional validation rules for verifying the command output.")
@added(Versions.v2026_07_15_preview)
model DeviceCommand {
  @doc("Unique check name that identifies this command in the validation results. Maps to checkName in checkResults response.")
  checkName: string;

  @doc("Description of what this command validates.")
  description?: string;

  @doc("The Arista CLI command to execute on the device.")
  command: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "validationRules is intentionally a free-form JSON object so callers can define their own arbitrary validation rule structure."
  @doc("Optional free-form JSON object defining user-specified validation rules to apply to the command output. When omitted (only `command` is provided), the service returns the complete raw command output without applying rule-based pass/fail validation.")
  validationRules?: Record<unknown>;
}

@doc("Comparison operators for validation rules.")
@added(Versions.v2026_07_15_preview)
union ValidationOperator {
  string,

  @doc("The extracted value must equal the expected value.")
  Equals: "Equals",

  @doc("The extracted value must not equal the expected value.")
  NotEquals: "NotEquals",

  @doc("The extracted value must contain the expected value.")
  Contains: "Contains",

  @doc("The extracted value must be greater than the expected value.")
  GreaterThan: "GreaterThan",

  @doc("The extracted value must be less than the expected value.")
  LessThan: "LessThan",
}

@doc("Aggregation applied to metric values within each sampling bucket.")
@added(Versions.v2026_07_15_preview)
union MetricBucketAggregation {
  string,

  @doc("Arithmetic mean of the samples in the bucket.")
  average: "Average",

  @doc("Smallest sample value in the bucket.")
  min: "Min",

  @doc("Largest sample value in the bucket.")
  max: "Max",

  @doc("Sum of the sample values in the bucket.")
  sum: "Sum",

  @doc("Number of samples in the bucket.")
  count: "Count",
}

@doc("The sampling type used to evaluate the bucketed metric values.")
@added(Versions.v2026_07_15_preview)
union MetricSamplingType {
  string,

  @doc("Arithmetic mean of the bucketed values.")
  average: "Average",

  @doc("Number of bucketed values.")
  count: "Count",

  @doc("Largest bucketed value.")
  max: "Max",

  @doc("Smallest bucketed value.")
  min: "Min",

  @doc("Rate of change across the bucketed values.")
  rate: "Rate",

  @doc("Sum of the bucketed values.")
  sum: "Sum",
}

@doc("A dimension filter used to scope a custom metric query.")
@added(Versions.v2026_07_15_preview)
model MetricDimensionFilter {
  @doc("The metric dimension name to filter.")
  dimensionName: string;

  @doc("The metric dimension value to filter on.")
  value: string;
}

@doc("A custom metric validation rule that defines a metric-based check to evaluate during validation.")
@added(Versions.v2026_07_15_preview)
model MetricValidationRule {
  @doc("Unique check name that identifies this metric check in the validation results. Maps to checkName in checkResults response.")
  checkName: string;

  @doc("Description of what this metric check validates.")
  description?: string;

  @doc("The name of the metric to query (e.g., 'CpuUtilizationMax', 'MemoryUtilization').")
  metricName: string;

  @doc("The metrics namespace containing the metric.")
  `namespace`: string;

  @doc("Optional dimension filters used to scope the metric query.")
  @identifiers(#["dimensionName"])
  dimensionFilters?: MetricDimensionFilter[];

  @doc("Time window in minutes to look back for metric data.")
  timeWindowMinutes: int32;

  @doc("Optional interval in minutes used to group metric samples into buckets.")
  samplingIntervalMinutes?: int32;

  @doc("Optional aggregation applied to metric values within each sampling bucket (e.g., 'Average').")
  bucketAggregation?: MetricBucketAggregation;

  @doc("The sampling type used to evaluate the bucketed metric values (e.g., 'Max').")
  samplingType: MetricSamplingType;

  @doc("The metric dimension used to produce an individual validation result per dimension value (e.g., 'DeviceId').")
  perResultDimensionName: string;

  @doc("The comparison operator to use for evaluating the metric value.")
  operator: ValidationOperator;

  @doc("The expected value to compare against the metric value.")
  expectedValue: float64;

  @doc("Maximum number of metric samples allowed to fail before the check is considered failed. Default is 0 (any failure fails the check).")
  @minValue(0)
  maxAllowedFailures?: int32 = 0;
}

@doc("File-based device command configuration using a URL to a custom commands file.")
@added(Versions.v2026_07_15_preview)
model FileDeviceCommandConfiguration extends DeviceCommandConfiguration {
  @doc("Configuration type discriminator.")
  configurationType: ConfigurationType.File;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("URL to a file containing device commands.")
  commandsUrl: url;
}

@doc("Response properties for the runValidation action.")
@added(Versions.v2026_07_15_preview)
model RunValidationResponseProperties {
  @doc("Unique identifier (GUID) for this validation run, generated by the service.")
  @visibility(Lifecycle.Read)
  validationId: Azure.Core.uuid;

  @doc("Timestamp when the validation was performed.")
  @visibility(Lifecycle.Read)
  validationTime?: utcDateTime;

  @doc("Timestamp when this validation result expires.")
  @visibility(Lifecycle.Read)
  expiresAt?: utcDateTime;

  @doc("Overall result of the validation.")
  @visibility(Lifecycle.Read)
  validationResult?: ValidationResult;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("Blob URL to the detailed validation report in the customer's storage account. Accessed using the resource's user-assigned managed identity.")
  @visibility(Lifecycle.Read)
  resultUrl?: url;

  @doc("Current firmware/software version of the resource in semantic versioning format (e.g., '4.0.2').")
  @visibility(Lifecycle.Read)
  currentVersion?: string;

  @doc("Target version for upgrade validation in semantic versioning format (e.g., '4.1.0').")
  @visibility(Lifecycle.Read)
  targetVersion?: string;

  @doc("Individual validation check results.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  checkResults?: ValidationCheckResult[];
}

@doc("Result of an individual validation check.")
@added(Versions.v2026_07_15_preview)
model ValidationCheckResult {
  @doc("Name of the validation check.")
  @visibility(Lifecycle.Read)
  checkName: string;

  @doc("Category of the validation check.")
  @visibility(Lifecycle.Read)
  category?: ValidationCheckCategory;

  @doc("Result of the validation check. Omitted for command-only checks (no validationRules provided), where the complete raw command output is returned instead via commandOutput.")
  @visibility(Lifecycle.Read)
  result?: ValidationResult;

  @doc("Descriptive message about the check result.")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("Complete raw command output for this check, limited to 4000 characters. Populated for command-only checks where no validationRules were provided.")
  @visibility(Lifecycle.Read)
  commandOutput?: string;

  @doc("List of resource IDs impacted by this check result.")
  @visibility(Lifecycle.Read)
  impactedResources?: Azure.Core.armResourceIdentifier[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request properties for the Network Fabric runValidation action. Extends the common request with fabric-only device scoping.")
@added(Versions.v2026_07_15_preview)
model NetworkFabricRunValidationRequest {
  ...RunValidationRequest;

  @doc("List of device resource IDs to filter validation to specific devices. When omitted, all devices in the fabric are validated.")
  deviceFilter?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("The response of the Network Fabric runValidation action.")
@added(Versions.v2026_07_15_preview)
model NetworkFabricRunValidationResponse {
  ...OperationStatusResult;

  @doc("Network Fabric run validation response properties.")
  properties?: NetworkFabricRunValidationResponseProperties;
}

@doc("Response properties for the Network Fabric runValidation action. Extends the common response with fabric-only per-device results.")
@added(Versions.v2026_07_15_preview)
model NetworkFabricRunValidationResponseProperties {
  ...RunValidationResponseProperties;

  @doc("List of device resource IDs that passed validation.")
  @visibility(Lifecycle.Read)
  successfulDevices?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];

  @doc("List of device resource IDs that failed validation.")
  @visibility(Lifecycle.Read)
  failedDevices?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request properties for the Network Device runValidation action. Kept as a distinct type so device runValidation can evolve independently of the fabric.")
@added(Versions.v2026_07_15_preview)
model NetworkDeviceRunValidationRequest is RunValidationRequest;

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("The response of the Network Device runValidation action.")
@added(Versions.v2026_07_15_preview)
model NetworkDeviceRunValidationResponse {
  ...OperationStatusResult;

  @doc("Network Device run validation response properties.")
  properties?: NetworkDeviceRunValidationResponseProperties;
}

@doc("Response properties for the Network Device runValidation action. Kept as a distinct type so device runValidation can evolve independently of the fabric.")
@added(Versions.v2026_07_15_preview)
model NetworkDeviceRunValidationResponseProperties
  is RunValidationResponseProperties;

/**
 * The error message.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Extending Resource Manager error response"
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@Azure.ResourceManager.CommonTypes.Private.armCommonDefinition(
  "ErrorResponse",
  Azure.ResourceManager.CommonTypes.Versions.v5
)
model CommonErrorResponse {
  ...Azure.ResourceManager.ErrorResponse;
}
