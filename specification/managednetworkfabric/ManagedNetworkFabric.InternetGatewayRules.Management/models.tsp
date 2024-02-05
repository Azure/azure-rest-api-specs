import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedNetworkFabric;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Specify action.
 */
enum Action {
  @doc("This will allow the HTTP requests")
  Allow,

  @doc("This will not allow the HTTP requests")
  Deny,
}

/**
 * Specify condition.
 */
enum Condition {
  @doc("and condition for all proxy rules")
  and,

  @doc("or condition for all proxy rules")
  or,
}

/**
 * The current provisioning state.
 */
enum ProvisioningState {
  @doc("Requested provisioing state has been accepted")
  Accepted,

  @doc("Requested provisioing state has been successfully applied")
  Succeeded,

  @doc("Requested provisioing state is being applied")
  Updating,

  @doc("Requested provisioing state is deleting a resource")
  Deleting,

  @doc("Requested provisioing state could not be applied")
  Failed,

  @doc("Requested provisioing state has been has been canceled")
  Canceled,
}

/**
 * Administrative state.
 */
enum EnableDisableState {
  @doc("Administrative state has been enabled")
  Enable,

  @doc("Administrative state has been disabled")
  Disable,
}

/**
 * Configuration state for the resource.
 */
enum ConfigurationState {
  @doc("Requested Configuration state for the resource has been applied")
  Succeeded,

  @doc("Requested Configuration state for the resource could not be applied")
  Failed,

  @doc("Requested Configuration state for the resource has been rejected")
  Rejected,

  @doc("Requested Configuration state for the resource has been accepted")
  Accepted,

  @doc("Requested Configuration state for the resource has been provisioned")
  Provisioned,

  @doc("Error in provisioning requested Configuration state for the resource")
  ErrorProvisioning,

  @doc("Requested Configuration state for the resource is Deprovisioning")
  Deprovisioning,

  @doc("Requested Configuration state for the resource has been Deprovisioned")
  Deprovisioned,

  @doc("Error in Deprovisioning requested Configuration state for the resource")
  ErrorDeprovisioning,

  @doc("Requested Configuration state for the resource has been deferred")
  DeferredControl,

  @doc("Requested Configuration state for the resource is Provisioning")
  Provisioning,

  @doc("Requested Configuration state for the resource is waiting for a commit")
  PendingCommit,
}

/**
 * Administrative state of the BfdConfiguration. Example: Enabled | Disabled.
 */
enum BfdAdministrativeState {
  @doc("Administrative state of the BfdConfiguration is enabled")
  Enabled,

  @doc("Administrative state of the BfdConfiguration is disabled")
  Disabled,

  @doc("Administrative state of the BfdConfiguration is MAT")
  MAT,

  @doc("Administrative state of the BfdConfiguration is RMA")
  RMA,
}

/**
 * IP Address type that needs to be matched.
 */
enum SourceDestinationType {
  @doc("IP Address that needs to be matched is from source")
  SourceIP,

  @doc("Destination IP Address that needs to be matched")
  DestinationIP,
}

/**
 * IP Prefix Type that needs to be matched.
 */
enum PrefixType {
  @doc("Need to match only the prefix of IP address")
  Prefix,

  @doc("Need to match the longest prefix of IP address")
  LongestPrefix,
}

/**
 * Port type that needs to be matched.
 */
enum PortType {
  @doc("Need to match with source port")
  SourcePort,

  @doc("Destination port needs to be match")
  DestinationPort,
}

/**
 * Layer4 protocol type that needs to be matched.
 */
enum Layer4Protocol {
  @doc("TCP protocol needs to be matched for Layer4")
  TCP,

  @doc("UDP protocol needs to be matched for Layer4")
  UDP,
}

/**
 * IP Address type.
 */
enum IPAddressType {
  @doc("IPv4 type IP address has been used")
  IPv4,

  @doc("IPv6 type IP address has been used")
  IPv6,
}

/**
 * State defined to represent administrative actions or post actions on a particular resource.
 */
enum AdministrativeState {
  @doc("administrative actions on a particular resource is enabled")
  Enabled,

  @doc("administrative actions on a particular resource is disabled")
  Disabled,

  @doc("administrative actions on a particular resource is MAT")
  MAT,

  @doc("administrative actions on a particular resource is RMA")
  RMA,
}

/**
 * Boolean Enum. Example- True/False
 */
enum BooleanEnumProperty {
  @doc("Represent true for boolean enum")
  True,

  @doc("Represent false for boolean enum")
  False,
}

/**
 * Peering option list.
 */
enum PeeringOption {
  @doc("Peering option is chosen from OptionA")
  OptionA,

  @doc("Peering option is chosen from OptionB")
  OptionB,
}

/**
 * community action types. Example: Permit | Deny.
 */
enum CommunityActionTypes {
  @doc("Represent community action is permitted")
  Permit,

  @doc("Represent community action is permitted")
  Deny,
}

/**
 * Internet Gateway Rule Properties defines the resource properties.
 */
model InternetGatewayRuleProperties is AnnotationResource {
  /**
   * Rules for the InternetGateways
   */
  ruleProperties: RuleProperties;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * List of Internet Gateway resource Id.
   */
  @visibility("read")
  internetGatewayIds?: string[];
}

/**
 * Rules for the InternetGateways
 */
model RuleProperties {
  /**
   * Specify action.
   */
  action: Action;

  /**
   * Specify condition.
   */
  condition?: Condition;

  /**
   * List of Addresses to be allowed or denied.
   */
  addressList: string[];

  /**
   * List of source remote ip to be allowed or denied.
   */
  sourceAddressList?: string[];
}

/**
 * Switch configuration entries require a description to discern between configuration groups.
 */
model AnnotationResource {
  /**
   * Switch configuration description.
   */
  annotation?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The Internet Gateway Rules patch resource definition.
 */
model InternetGatewayRulePatch is TagsUpdate;

/**
 * Base tracked resource type for PATCH updates.
 */
model TagsUpdate {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * The extended location.
 */
model ExtendedLocation {
  /**
   * The extended location type.
   */
  type?: string;

  /**
   * The extended location name.
   */
  name?: string;
}

/**
 * Update administrative state on list of resources.
 */
model UpdateAdministrativeState is EnableDisableOnResources {
  /**
   * Administrative state.
   */
  state?: EnableDisableState;
}

/**
 * Update administrative state on list of resources.
 */
model EnableDisableOnResources {
  /**
   * Network Fabrics or Network Rack resource Id.
   */
  resourceIds?: string[];
}

/**
 * Update version properties.
 */
model UpdateVersion {
  /**
   * Specify the version.
   */
  version?: string;
}

/**
 * Common response for device updates.
 */
model CommonPostActionResponseForDeviceUpdate is ErrorResponse {
  /**
   * Gets the configuration state.
   */
  @visibility("read")
  configurationState?: ConfigurationState;

  /**
   * List of ARM Resource IDs for which the given action applied successfully.
   */
  successfulDevices?: string[];

  /**
   * List of ARM Resource IDs for which the given action failed to apply.
   */
  failedDevices?: string[];
}

/**
 * Common response for the state updates.
 */
model CommonPostActionResponseForStateUpdate is ErrorResponse {
  /**
   * Gets the configuration state.
   */
  @visibility("read")
  configurationState?: ConfigurationState;
}

/**
 * The response of the action validate configuration.
 */
model ValidateConfigurationResponse is ErrorResponse {
  /**
   * Gets the configuration state.
   */
  @visibility("read")
  configurationState?: ConfigurationState;

  /**
   * URL for the details of the response.
   */
  url?: string;
}

/**
 * BFD configuration properties
 */
model BfdConfiguration {
  /**
   * Administrative state of the BfdConfiguration. Example: Enabled | Disabled.
   */
  @visibility("read")
  administrativeState?: BfdAdministrativeState = BfdAdministrativeState.Disabled;

  /**
   * Interval in milliseconds. Example: 300.
   */
  intervalInMilliSeconds?: int32 = 300;

  /**
   * Multiplier for the Bfd Configuration. Example: 5.
   */
  multiplier?: int32 = 5;
}

/**
 * Route Properties.
 */
model StaticRouteProperties {
  /**
   * Prefix of the route.
   */
  @minLength(1)
  prefix: string;

  /**
   * List of next hop addresses.
   */
  nextHop: string[];
}

/**
 * Layer 3 primary and secondary IP Address prefixes.
 */
model Layer3IpPrefixProperties {
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
 * Route Target Configuration.
 */
model RouteTargetInformation {
  /**
   * Route Targets to be applied for incoming routes into CE.
   */
  importIpv4RouteTargets?: string[];

  /**
   * Route Targets to be applied for incoming routes from CE.
   */
  importIpv6RouteTargets?: string[];

  /**
   * Route Targets to be applied for outgoing routes into CE.
   */
  exportIpv4RouteTargets?: string[];

  /**
   * Route Targets to be applied for outgoing routes from CE.
   */
  exportIpv6RouteTargets?: string[];
}

/**
 * Import Route Policy Configuration.
 */
model ImportRoutePolicyInformation {
  /**
   * Import IPv4 Route Policy Id.
   */
  importIpv4RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Import IPv6 Route Policy Id.
   */
  importIpv6RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

/**
 * Export Route Policy Configuration.
 */
model ExportRoutePolicyInformation {
  /**
   * Export IPv4 Route Policy Id.
   */
  exportIpv4RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Export IPv6 Route Policy Id.
   */
  exportIpv6RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

/**
 * Defines the common match conditions of the ACL and Network Tap Rule.
 */
model CommonMatchConditions {
  /**
   * List of the protocols that need to be matched.
   */
  protocolTypes?: string[];

  /**
   * Vlan match condition that needs to be matched.
   */
  vlanMatchCondition?: VlanMatchCondition;

  /**
   * IP condition that needs to be matched.
   */
  ipCondition?: IpMatchCondition;
}

/**
 * The vlan match conditions that need to be matched.
 */
model VlanMatchCondition {
  /**
   * List of vlans that need to be matched.
   */
  vlans?: string[];

  /**
   * List of inner vlans that need to be matched.
   */
  innerVlans?: string[];

  /**
   * List of vlan group names that need to be matched.
   */
  vlanGroupNames?: string[];
}

/**
 * Defines the condition that can be filtered using the selected IPs.
 */
model IpMatchCondition {
  /**
   * IP Address type that needs to be matched.
   */
  type?: SourceDestinationType;

  /**
   * IP Prefix Type that needs to be matched.
   */
  prefixType?: PrefixType;

  /**
   * The list of IP Prefixes that need to be matched.
   */
  ipPrefixValues?: string[];

  /**
   * The List of IP Group Names that need to be matched.
   */
  ipGroupNames?: string[];
}

/**
 * Port condition that needs to be matched.
 */
model PortCondition {
  /**
   * Port type that needs to be matched.
   */
  portType?: PortType;

  /**
   * Layer4 protocol type that needs to be matched.
   */
  layer4Protocol: Layer4Protocol;

  /**
   * List of the Ports that need to be matched.
   */
  ports?: string[];

  /**
   * List of the port Group Names that need to be matched.
   */
  portGroupNames?: string[];
}

/**
 * Dynamic match configuration object.
 */
model CommonDynamicMatchConfiguration {
  /**
   * List of IP Groups.
   */
  ipGroups?: IpGroupProperties[];

  /**
   * List of vlan groups.
   */
  vlanGroups?: VlanGroupProperties[];

  /**
   * List of the port groups.
   */
  portGroups?: PortGroupProperties[];
}

/**
 * IP Group properties.
 */
model IpGroupProperties {
  /**
   * IP Group name.
   */
  @minLength(1)
  name?: string;

  /**
   * IP Address type.
   */
  ipAddressType?: IPAddressType;

  /**
   * List of IP Prefixes.
   */
  ipPrefixes?: string[];
}

/**
 * Vlan group properties.
 */
model VlanGroupProperties {
  /**
   * Vlan group name.
   */
  @minLength(1)
  name?: string;

  /**
   * List of vlans.
   */
  vlans?: string[];
}

/**
 * Port Group properties.
 */
model PortGroupProperties {
  /**
   * The name of the port group.
   */
  @minLength(1)
  name?: string;

  /**
   * List of the ports that need to be matched.
   */
  ports?: string[];
}
