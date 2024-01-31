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
  Allow,
  Deny,
}

/**
 * Specify condition.
 */
enum Condition {
  and,
  or,
}

/**
 * The current provisioning state.
 */
enum ProvisioningState {
  Accepted,
  Succeeded,
  Updating,
  Deleting,
  Failed,
  Canceled,
}

/**
 * Administrative state.
 */
enum EnableDisableState {
  Enable,
  Disable,
}

/**
 * Configuration state for the resource.
 */
enum ConfigurationState {
  Succeeded,
  Failed,
  Rejected,
  Accepted,
  Provisioned,
  ErrorProvisioning,
  Deprovisioning,
  Deprovisioned,
  ErrorDeprovisioning,
  DeferredControl,
  Provisioning,
  PendingCommit,
}

/**
 * Administrative state of the BfdConfiguration. Example: Enabled | Disabled.
 */
enum BfdAdministrativeState {
  Enabled,
  Disabled,
  MAT,
  RMA,
}

/**
 * IP Address type that needs to be matched.
 */
enum SourceDestinationType {
  SourceIP,
  DestinationIP,
}

/**
 * IP Prefix Type that needs to be matched.
 */
enum PrefixType {
  Prefix,
  LongestPrefix,
}

/**
 * Port type that needs to be matched.
 */
enum PortType {
  SourcePort,
  DestinationPort,
}

/**
 * Layer4 protocol type that needs to be matched.
 */
enum Layer4Protocol {
  TCP,
  UDP,
}

/**
 * IP Address type.
 */
enum IPAddressType {
  IPv4,
  IPv6,
}

/**
 * State defined to represent administrative actions or post actions on a particular resource.
 */
enum AdministrativeState {
  Enabled,
  Disabled,
  MAT,
  RMA,
}

/**
 * Boolean Enum. Example- True/False
 */
enum BooleanEnumProperty {
  True,
  False,
}

/**
 * Peering option list.
 */
enum PeeringOption {
  OptionA,
  OptionB,
}

/**
 * community action types. Example: Permit | Deny.
 */
enum CommunityActionTypes {
  Permit,
  Deny,
}

/**
 * Internet Gateway Rule Properties defines the resource properties.
 */
model InternetGatewayRuleProperties extends AnnotationResource {
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
model InternetGatewayRulePatch extends TagsUpdate {}

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
model UpdateAdministrativeState extends EnableDisableOnResources {
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
model CommonPostActionResponseForDeviceUpdate extends ErrorResponse {
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
model CommonPostActionResponseForStateUpdate extends ErrorResponse {
  /**
   * Gets the configuration state.
   */
  @visibility("read")
  configurationState?: ConfigurationState;
}

/**
 * The response of the action validate configuration.
 */
model ValidateConfigurationResponse extends ErrorResponse {
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
