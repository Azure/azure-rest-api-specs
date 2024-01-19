import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedNetworkFabric;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Configuration state for the resource.")
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
}

@doc("The current provisioning state.")
enum ProvisioningState {
  Accepted,
  Succeeded,
  Updating,
  Deleting,
  Failed,
  Canceled,
}

@doc("State defined to represent administrative actions or post actions on a particular resource.")
enum AdministrativeState {
  Enabled,
  Disabled,
  MAT,
  RMA,
}

@doc("Input method to configure Access Control List.")
enum ConfigurationType {
  File,
  Inline,
}

@doc("community action types. Example: Permit | Deny.")
enum CommunityActionTypes {
  Permit,
  Deny,
}

@doc("IP Address type.")
enum IPAddressType {
  IPv4,
  IPv6,
}

@doc("Port type that needs to be matched.")
enum PortType {
  SourcePort,
  DestinationPort,
}

@doc("Layer4 protocol type that needs to be matched.")
enum Layer4Protocol {
  TCP,
  UDP,
}

@doc("IP Address type that needs to be matched.")
enum SourceDestinationType {
  SourceIP,
  DestinationIP,
}

@doc("IP Prefix Type that needs to be matched.")
enum PrefixType {
  Prefix,
  LongestPrefix,
}

@doc("Type of actions that can be performed.")
enum AclActionType {
  Drop,
  Count,
  Log,
}

@doc("Administrative state.")
enum EnableDisableState {
  Enable,
  Disable,
}

@doc("Gateway Type of the resource.")
enum GatewayType {
  Infrastructure,
  Workload,
}

@doc("Specify action.")
enum Action {
  Allow,
  Deny,
}

@doc("""

`Internet` - Advertise routes to internet community.
 `LocalAS` - Advertise routes to only localAS peers.
 `NoAdvertise` - Don't advertise routes to any peer.
`NoExport` - Don't export to next AS.
`GShut` - Graceful Shutdown (GSHUT) withdraw routes before terminating BGP connection.

""")
enum WellKnownCommunities {
  Internet,
  LocalAS,
  NoAdvertise,
  NoExport,
  GShut,
}

@doc("Specify prefix-list bounds.")
enum Condition {
  EqualTo,
  GreaterThanOrEqualTo,
  LesserThanOrEqualTo,
  Range,
}

@doc("Advertise Connected Subnets. Ex: \"True\" | \"False\".")
enum RedistributeConnectedSubnets {
  True,
  False,
}

@doc("Advertise Static Routes. Ex: \"True\" | \"False\".")
enum RedistributeStaticRoutes {
  True,
  False,
}

@doc("Administrative state of the BfdConfiguration. Example: Enabled | Disabled.")
enum BfdAdministrativeState {
  Enabled,
  Disabled,
  MAT,
  RMA,
}

@doc("Boolean Enum. Example- True/False")
enum BooleanEnumProperty {
  True,
  False,
}

@doc("Enable Or Disable state.")
enum AllowASOverride {
  Enable,
  Disable,
}

@doc("Extension. Example: NoExtension | NPB.")
enum Extension {
  NoExtension,
  NPB,
}

@doc("To check whether monitoring of internal network is enabled or not.")
enum IsMonitoringEnabled {
  True,
  False,
}

@doc("Peering option list.")
enum PeeringOption {
  OptionA,
  OptionB,
}

@doc("Available roles for the network device.")
enum NetworkDeviceRoleName {
  CE,
  ToR,
  NPB,
  TS,
  Management,
}

@doc("NetworkDeviceRole is the device role: Example: CE | ToR.")
enum NetworkDeviceRole {
  CE,
  ToR,
  NPB,
  TS,
  Management,
}

@doc("The Interface Type. Example: Management/Data")
enum InterfaceType {
  Management,
  Data,
}

@doc("Type of reboot to be performed. Example: GracefulRebootWithZTP")
enum RebootType {
  GracefulRebootWithZTP,
  GracefulRebootWithoutZTP,
  UngracefulRebootWithZTP,
  UngracefulRebootWithoutZTP,
}

@doc("Administrative state.")
enum DeviceAdministrativeState {
  RMA,
  Resync,
  GracefulQuarantine,
  Quarantine,
}

@doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.")
enum IsWorkloadManagementNetworkEnabled {
  True,
  False,
}

@doc("Network Fabric Controller SKU.")
enum NfcSku {
  Basic,
  Standard,
  HighPerformance,
}

@doc("Type of Network Fabric SKU.")
enum FabricSkuType {
  SingleRack,
  MultiRack,
}

@doc("Validate action that to be performed")
enum ValidateAction {
  Cabling,
  Configuration,
  Connectivity,
}

@doc("Type of NNI used. Example: CE | NPB")
enum NniType {
  CE,
  NPB,
}

@doc("Configuration to use NNI for Infrastructure Management. Example: True/False.")
enum IsManagementType {
  True,
  False,
}

@doc("Network Rack SKU name.")
enum NetworkRackType {
  Aggregate,
  Compute,
  Combined,
}

@doc("Polling interval in seconds.")
enum PollingIntervalInSeconds {
  `30`: 30,
  `60`: 60,
  `90`: 90,
  `120`: 120,
}

@doc("Encapsulation Type that needs to be matched.")
enum EncapsulationType {
  None,
  GTPv1,
}

@doc("Type of actions that can be performed.")
enum TapRuleActionType {
  Drop,
  Count,
  Log,
  Replicate,
  Goto,
  Redirect,
  Mirror,
}

@doc("Type of destination. Input can be IsolationDomain or Direct.")
enum DestinationType {
  IsolationDomain,
  Direct,
}

@doc("Type of encapsulation.")
enum Encapsulation {
  None,
  GRE,
}

@doc("Polling type.")
enum PollingType {
  Pull,
  Push,
}

@doc("AddressFamilyType. This parameter decides whether the given ipv4 or ipv6 route policy.")
enum AddressFamilyType {
  IPv4,
  IPv6,
}

@doc("Type of the condition used.")
enum RoutePolicyConditionType {
  Or,
  And,
}

@doc("Action type. Example: Permit | Deny | Continue.")
enum RoutePolicyActionType {
  Permit,
  Deny,
  Continue,
}

@doc("Access Control List Properties defines the resource properties.")
model AccessControlListProperties {
  ...AnnotationResource;
  ...AccessControlListPatchableProperties;

  @doc("The last synced timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncedTime?: utcDateTime;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("Switch configuration entries require a description to discern between configuration groups.")
model AnnotationResource {
  @doc("Switch configuration description.")
  annotation?: string;
}

@doc("Access Control List Patch Properties defines the patchable resource properties.")
model AccessControlListPatchableProperties {
  @doc("Input method to configure Access Control List.")
  configurationType?: ConfigurationType;

  @doc("Access Control List file URL.")
  aclsUrl?: string;

  @doc("Default action that needs to be applied when no condition is matched. Example: Permit | Deny.")
  defaultAction?: CommunityActionTypes;

  @doc("List of match configurations.")
  matchConfigurations?: AccessControlListMatchConfiguration[];

  @doc("List of dynamic match configurations.")
  dynamicMatchConfigurations?: CommonDynamicMatchConfiguration[];
}

@doc("Defines the match configuration that are supported to filter the traffic.")
model AccessControlListMatchConfiguration {
  @doc("The name of the match configuration.")
  @minLength(1)
  matchConfigurationName?: string;

  @doc("Sequence Number of the match configuration.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int32;

  @doc("Type of IP Address. IPv4 or IPv6")
  ipAddressType?: IPAddressType;

  @doc("List of the match conditions.")
  matchConditions?: AccessControlListMatchCondition[];

  @doc("List of actions that need to be performed for the matched conditions.")
  actions?: AccessControlListAction[];
}

@doc("Defines the match condition that is supported to filter the traffic.")
model AccessControlListMatchCondition extends CommonMatchConditions {
  @doc("List of ether type values that need to be matched.")
  etherTypes?: string[];

  @doc("List of IP fragment packets that need to be matched.")
  fragments?: string[];

  @doc("List of IP Lengths that need to be matched.")
  ipLengths?: string[];

  @doc("List of TTL [Time To Live] values that need to be matched.")
  ttlValues?: string[];

  @doc("List of DSCP Markings that need to be matched.")
  dscpMarkings?: string[];

  @doc("Defines the port condition that needs to be matched.")
  portCondition?: AccessControlListPortCondition;
}

@doc("Defines the port condition that needs to be matched.")
model AccessControlListPortCondition extends PortCondition {
  @doc("List of protocol flags that need to be matched.")
  flags?: string[];
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

@doc("Defines the common match conditions of the ACL and Network Tap Rule.")
model CommonMatchConditions {
  @doc("List of the protocols that need to be matched.")
  protocolTypes?: string[];

  @doc("Vlan match condition that needs to be matched.")
  vlanMatchCondition?: VlanMatchCondition;

  @doc("IP condition that needs to be matched.")
  ipCondition?: IpMatchCondition;
}

@doc("The vlan match conditions that need to be matched.")
model VlanMatchCondition {
  @doc("List of vlans that need to be matched.")
  vlans?: string[];

  @doc("List of inner vlans that need to be matched.")
  innerVlans?: string[];

  @doc("List of vlan group names that need to be matched.")
  vlanGroupNames?: string[];
}

@doc("Defines the condition that can be filtered using the selected IPs.")
model IpMatchCondition {
  @doc("IP Address type that needs to be matched.")
  type?: SourceDestinationType;

  @doc("IP Prefix Type that needs to be matched.")
  prefixType?: PrefixType;

  @doc("The list of IP Prefixes that need to be matched.")
  ipPrefixValues?: string[];

  @doc("The List of IP Group Names that need to be matched.")
  ipGroupNames?: string[];
}

@doc("Action that need to performed.")
model AccessControlListAction {
  @doc("Type of actions that can be performed.")
  type?: AclActionType;

  @doc("Name of the counter block to get match count information.")
  @minLength(1)
  counterName?: string;
}

@doc("Dynamic match configuration object.")
model CommonDynamicMatchConfiguration {
  @doc("List of IP Groups.")
  ipGroups?: IpGroupProperties[];

  @doc("List of vlan groups.")
  vlanGroups?: VlanGroupProperties[];

  @doc("List of the port groups.")
  portGroups?: PortGroupProperties[];
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

@doc("Vlan group properties.")
model VlanGroupProperties {
  @doc("Vlan group name.")
  @minLength(1)
  name?: string;

  @doc("List of vlans.")
  vlans?: string[];
}

@doc("Port Group properties.")
model PortGroupProperties {
  @doc("The name of the port group.")
  @minLength(1)
  name?: string;

  @doc("List of the ports that need to be matched.")
  ports?: string[];
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  @visibility("read")
  id?: ResourceIdentifier;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The Access Control Lists patch resource definition.")
model AccessControlListPatch extends TagsUpdate {
  @doc("Access Control Lists patch properties.")
  properties?: AccessControlListPatchProperties;
}

@doc("Access Control Lists patch properties.")
model AccessControlListPatchProperties {
  ...AccessControlListPatchableProperties;
  ...AnnotationResource;
}

@doc("Base tracked resource type for PATCH updates.")
model TagsUpdate {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Update administrative state on list of resources.")
model UpdateAdministrativeState extends EnableDisableOnResources {
  @doc("Administrative state.")
  state?: EnableDisableState;
}

@doc("Update administrative state on list of resources.")
model EnableDisableOnResources {
  @doc("Network Fabrics or Network Rack resource Id.")
  resourceIds?: string[];
}

@doc("Common response for the state updates.")
model CommonPostActionResponseForStateUpdate extends ErrorResponse {
  @doc("Gets the configuration state.")
  @visibility("read")
  configurationState?: ConfigurationState;
}

@doc("The response of the action validate configuration.")
model ValidateConfigurationResponse extends ErrorResponse {
  @doc("Gets the configuration state.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("URL for the details of the response.")
  url?: string;
}

@doc("Internet Gateway Properties defines the properties of the resource.")
model InternetGatewayProperties {
  ...AnnotationResource;
  ...InternetGatewayPatchableProperties;

  @doc("IPv4 Address of Internet Gateway.")
  @visibility("read")
  ipv4Address?: string;

  @doc("Port number of Internet Gateway.")
  @visibility("read")
  port?: int32;

  @doc("Gateway Type of the resource.")
  type: GatewayType;

  @doc("ARM Resource ID of the Network Fabric Controller.")
  networkFabricControllerId: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabricControllers";
    }
  ]>;

  @doc("Provisioning state of resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Internet Gateway Patchable Properties defines the patchable properties of the resource.")
model InternetGatewayPatchableProperties {
  @doc("ARM Resource ID of the Internet Gateway Rule.")
  internetGatewayRuleId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGatewayRules";
    }
  ]>;
}

@doc("The Internet Gateway patch resource definition.")
model InternetGatewayPatch extends TagsUpdate {
  @doc("Resource properties.")
  properties?: InternetGatewayPatchableProperties;
}

@doc("Internet Gateway Rule Properties defines the resource properties.")
model InternetGatewayRuleProperties extends AnnotationResource {
  @doc("Rules for the InternetGateways")
  ruleProperties: RuleProperties;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("List of Internet Gateway resource Id.")
  @visibility("read")
  internetGatewayIds?: string[];
}

@doc("Rules for the InternetGateways")
model RuleProperties {
  @doc("Specify action.")
  action: Action;

  @doc("List of Addresses to be allowed or denied.")
  addressList: string[];
}

@doc("The Internet Gateway Rules patch resource definition.")
model InternetGatewayRulePatch extends TagsUpdate {}

@doc("IP Community Properties defines the resource properties.")
model IpCommunityProperties {
  ...AnnotationResource;
  ...IpCommunityPatchableProperties;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("IP Community patchable properties.")
model IpCommunityPatchableProperties {
  @doc("List of IP Community Rules.")
  ipCommunityRules?: IpCommunityRule[];
}

@doc("IP Community patchable properties.")
model IpCommunityRule {
  @doc("Action to be taken on the configuration. Example: Permit | Deny.")
  action: CommunityActionTypes;

  @doc("Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int32;

  @doc("Supported well known Community List.")
  wellKnownCommunities?: WellKnownCommunities[];

  @doc("List the community members of IP Community.")
  communityMembers: string[];
}

@doc("The IP Community patch resource definition.")
model IpCommunityPatch extends TagsUpdate {
  @doc("IP Community patchable properties.")
  properties?: IpCommunityPatchableProperties;
}

@doc("IP Extended Community Properties defines the resource properties.")
model IpExtendedCommunityProperties {
  ...AnnotationResource;
  ...IpExtendedCommunityPatchableProperties;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("IP Extended Community patchable properties.")
model IpExtendedCommunityPatchableProperties {
  @doc("List of IP Extended Community Rules.")
  ipExtendedCommunityRules: IpExtendedCommunityRule[];
}

@doc("List of IP Extended Community Rules.")
model IpExtendedCommunityRule {
  @doc("Action to be taken on the configuration. Example: Permit | Deny.")
  action: CommunityActionTypes;

  @doc("Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int32;

  @doc("Route Target List.The expected formats are ASN(plain):NN >> example 4294967294:50, ASN.ASN:NN >> example 65533.65333:40, IP-address:NN >> example 10.10.10.10:65535. The possible values of ASN,NN are in range of 0-65535, ASN(plain) is in range of 0-4294967295.")
  routeTargets: string[];
}

@doc("The IP Extended Communities patch resource definition.")
model IpExtendedCommunityPatch extends TagsUpdate {
  @doc("IP Extended Community patchable properties.")
  properties?: IpExtendedCommunityPatchProperties;
}

@doc("IP Extended Community patchable properties.")
model IpExtendedCommunityPatchProperties {
  ...IpExtendedCommunityPatchableProperties;
  ...AnnotationResource;
}

@doc("IP Prefix Properties defines the properties of the resource.")
model IpPrefixProperties {
  ...AnnotationResource;
  ...IpPrefixPatchableProperties;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("IP Prefix patchable properties.")
model IpPrefixPatchableProperties {
  @doc("The list of IP Prefix Rules.")
  ipPrefixRules?: IpPrefixRule[];
}

@doc("IP Prefix Rule properties.")
model IpPrefixRule {
  @doc("Action to be taken on the configuration. Example: Permit | Deny.")
  action: CommunityActionTypes;

  @doc("Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int32;

  @doc("Network Prefix specifying IPv4/IPv6 packets to be permitted or denied. Example: 1.1.1.0/24 | 3FFE:FFFF:0:CD30::/126 ")
  networkPrefix: string;

  @doc("Specify prefix-list bounds.")
  condition?: Condition;

  @doc("SubnetMaskLength gives the minimum NetworkPrefix length to be matched. Possible values for IPv4 are 1 - 32 . Possible values of IPv6 are 1 - 128.")
  subnetMaskLength?: string;
}

@doc("The IP Prefix patch resource definition.")
model IpPrefixPatch extends TagsUpdate {
  @doc("IP Prefix patchable properties.")
  properties?: IpPrefixPatchProperties;
}

@doc("IP Prefix patchable properties.")
model IpPrefixPatchProperties {
  ...AnnotationResource;
  ...IpPrefixPatchableProperties;
}

@doc("L2Isolation Domain Properties defines the properties of the resource.")
model L2IsolationDomainProperties extends AnnotationResource {
  @doc("ARM Resource ID of the Network Fabric.")
  networkFabricId: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Vlan Identifier of the Network Fabric. Example: 501.")
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  @doc("Maximum transmission unit. Default value is 1500.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("The L2 Isolation Domain patch resource definition.")
model L2IsolationDomainPatch extends TagsUpdate {
  @doc("Resource properties.")
  properties?: L2IsolationDomainPatchProperties;
}

@doc("L2 Isolation Domain Patch Properties defines the patchable properties of the resource.")
model L2IsolationDomainPatchProperties extends AnnotationResource {
  @doc("Maximum transmission unit. Default value is 1500.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;
}

@doc("Common response for device updates.")
model CommonPostActionResponseForDeviceUpdate extends ErrorResponse {
  @doc("Gets the configuration state.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("List of ARM Resource IDs for which the given action applied successfully.")
  successfulDevices?: string[];

  @doc("List of ARM Resource IDs for which the given action failed to apply.")
  failedDevices?: string[];
}

@doc("L3 Isolation Domain Properties defines the properties of the resource.")
model L3IsolationDomainProperties {
  ...AnnotationResource;
  ...L3IsolationDomainPatchableProperties;

  @doc("ARM Resource ID of the Network Fabric.")
  @visibility("read", "create")
  networkFabricId: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("L3 Isolation Domain Patch Properties defines the patchable properties of the resource.")
model L3IsolationDomainPatchableProperties {
  @doc("Advertise Connected Subnets. Ex: \"True\" | \"False\".")
  redistributeConnectedSubnets?: RedistributeConnectedSubnets;

  @doc("Advertise Static Routes. Ex: \"True\" | \"False\".")
  redistributeStaticRoutes?: RedistributeStaticRoutes;

  @doc("Aggregate route configurations.")
  aggregateRouteConfiguration?: AggregateRouteConfiguration;

  @doc("Connected Subnet RoutePolicy")
  connectedSubnetRoutePolicy?: ConnectedSubnetRoutePolicy;
}

@doc("List of IPv4 and IPv6 aggregate routes.")
model AggregateRouteConfiguration {
  @doc("List of IPv4 Route prefixes.")
  ipv4Routes?: AggregateRoute[];

  @doc("List of Ipv6Routes prefixes.")
  ipv6Routes?: AggregateRoute[];
}

@doc("aggregateIpv4Route model.")
model AggregateRoute {
  @doc("IPv4 Prefix of the aggregate Ipv4Route.")
  @minLength(1)
  prefix: string;
}

@doc("Connected Subnet Route Policy properties.")
model ConnectedSubnetRoutePolicy {
  @doc("ARM Resource ID of the Route Policy. This is used for the backward compatibility.")
  exportRoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Array of ARM Resource ID of the RoutePolicies.")
  exportRoutePolicy?: L3ExportRoutePolicy;
}

@doc("Array of ARM Resource ID of the RoutePolicies.")
model L3ExportRoutePolicy {
  @doc("ARM Resource ID of the RoutePolicy.")
  exportIpv4RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM Resource ID of the RoutePolicy.")
  exportIpv6RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("The L3 Isolation Domain patch resource definition.")
model L3IsolationDomainPatch extends TagsUpdate {
  @doc("Resource properties.")
  properties?: L3IsolationDomainPatchProperties;
}

@doc("Resource properties.")
model L3IsolationDomainPatchProperties {
  ...AnnotationResource;
  ...L3IsolationDomainPatchableProperties;
}

@doc("Internal Network Properties defines the properties of the resource.")
model InternalNetworkProperties {
  ...AnnotationResource;
  ...InternalNetworkPatchableProperties;
  ...ExtensionEnumProperty;

  @doc("Vlan identifier. Example: 1001.")
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  @doc("BGP configuration properties.")
  bgpConfiguration?: InternalNetworkPropertiesBgpConfiguration;

  @doc("Static Route Configuration properties.")
  staticRouteConfiguration?: InternalNetworkPropertiesStaticRouteConfiguration;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("BGP configuration properties.")
model InternalNetworkPropertiesBgpConfiguration extends BgpConfiguration {}

@doc("BGP configuration properties")
model BgpConfiguration extends AnnotationResource {
  @doc("BFD configuration properties")
  bfdConfiguration?: BfdConfiguration;

  @doc("Originate a defaultRoute. Ex: \"True\" | \"False\".")
  defaultRouteOriginate?: BooleanEnumProperty;

  @doc("Allows for routes to be received and processed even if the router detects its own ASN in the AS-Path. 0 is disable, Possible values are 1-10, default is 2.")
  @maxValue(10)
  allowAS?: int32;

  @doc("Enable Or Disable state.")
  allowASOverride?: AllowASOverride;

  @doc("ASN of Network Fabric. Example: 65048.")
  @visibility("read")
  fabricASN?: int32;

  @doc("Peer ASN. Example: 65047.")
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int32;

  @doc("List of BGP IPv4 Listen Range prefixes.")
  ipv4ListenRangePrefixes?: string[];

  @doc("List of BGP IPv6 Listen Ranges prefixes.")
  ipv6ListenRangePrefixes?: string[];

  @doc("List with stringified IPv4 Neighbor Addresses.")
  ipv4NeighborAddress?: NeighborAddress[];

  @doc("List with stringified IPv6 Neighbor Address.")
  ipv6NeighborAddress?: NeighborAddress[];
}

@doc("BFD configuration properties")
model BfdConfiguration {
  @doc("Administrative state of the BfdConfiguration. Example: Enabled | Disabled.")
  @visibility("read")
  administrativeState?: BfdAdministrativeState;

  @doc("Interval in milliseconds. Example: 300.")
  intervalInMilliSeconds?: int32;

  @doc("Multiplier for the Bfd Configuration. Example: 5.")
  multiplier?: int32;
}

@doc("Neighbor Address properties.")
model NeighborAddress {
  @doc("IP Address.")
  @minLength(1)
  address?: string;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;
}

@doc("Static Route Configuration properties.")
model InternalNetworkPropertiesStaticRouteConfiguration {
  ...StaticRouteConfiguration;
  ...ExtensionEnumProperty;
}

@doc("Static Route Configuration properties.")
model StaticRouteConfiguration {
  @doc("BFD configuration properties")
  bfdConfiguration?: BfdConfiguration;

  @doc("List of IPv4 Routes.")
  ipv4Routes?: StaticRouteProperties[];

  @doc("List of IPv6 Routes.")
  ipv6Routes?: StaticRouteProperties[];
}

@doc("Route Properties.")
model StaticRouteProperties {
  @doc("Prefix of the route.")
  @minLength(1)
  prefix: string;

  @doc("List of next hop addresses.")
  nextHop: string[];
}

@doc("Extension property.")
model ExtensionEnumProperty {
  @doc("Extension. Example: NoExtension | NPB.")
  extension?: Extension;
}

@doc("The InternalNetwork patchable properties.")
model InternalNetworkPatchableProperties {
  @doc("Maximum transmission unit. Default value is 1500.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  @doc("List of Connected IPv4 Subnets.")
  connectedIPv4Subnets?: ConnectedSubnet[];

  @doc("List of connected IPv6 Subnets.")
  connectedIPv6Subnets?: ConnectedSubnet[];

  @doc("ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.")
  importRoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.")
  exportRoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import Route Policy either IPv4 or IPv6.")
  importRoutePolicy?: ImportRoutePolicy;

  @doc("Export Route Policy either IPv4 or IPv6.")
  exportRoutePolicy?: ExportRoutePolicy;

  @doc("Ingress Acl. ARM resource ID of Access Control Lists.")
  ingressAclId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  egressAclId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("To check whether monitoring of internal network is enabled or not.")
  isMonitoringEnabled?: IsMonitoringEnabled;
}

@doc("Connected Subnet properties.")
model ConnectedSubnet extends AnnotationResource {
  @doc("Prefix of the Connected Subnet.")
  @minLength(1)
  prefix: string;
}

@doc("Import Route Policy either IPv4 or IPv6.")
model ImportRoutePolicy {
  @doc("ARM resource ID of RoutePolicy.")
  importIpv4RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM resource ID of RoutePolicy.")
  importIpv6RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Export Route Policy either IPv4 or IPv6.")
model ExportRoutePolicy {
  @doc("ARM resource ID of RoutePolicy.")
  exportIpv4RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM resource ID of RoutePolicy.")
  exportIpv6RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("The InternalNetwork patch resource definition.")
model InternalNetworkPatch {
  @doc("InternalNetwork Patch properties.")
  properties?: InternalNetworkPatchProperties;
}

@doc("InternalNetwork Patch properties.")
model InternalNetworkPatchProperties {
  ...AnnotationResource;
  ...InternalNetworkPatchableProperties;

  @doc("BGP configuration properties.")
  bgpConfiguration?: BgpConfiguration;

  @doc("Static Route Configuration properties.")
  staticRouteConfiguration?: StaticRouteConfiguration;
}

@doc("External Network Properties.")
model ExternalNetworkProperties {
  ...AnnotationResource;
  ...ExternalNetworkPatchableProperties;

  @doc("Gets the networkToNetworkInterconnectId of the resource.")
  @visibility("read")
  networkToNetworkInterconnectId?: string;

  @doc("Peering option list.")
  peeringOption: PeeringOption;

  @doc("option B properties object")
  optionBProperties?: L3OptionBProperties;

  @doc("option A properties object")
  optionAProperties?: ExternalNetworkPropertiesOptionAProperties;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("Option B configuration.")
model L3OptionBProperties {
  @doc("RouteTargets to be applied. This is used for the backward compatibility.")
  importRouteTargets?: string[];

  @doc("RouteTargets to be applied. This is used for the backward compatibility.")
  exportRouteTargets?: string[];

  @doc("RouteTargets to be applied.")
  routeTargets?: RouteTargetInformation;
}

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

@doc("option A properties object")
model ExternalNetworkPropertiesOptionAProperties {
  ...Layer3IpPrefixProperties;
  ...L3OptionAProperties;
}

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

@doc("Peering optionA properties")
model L3OptionAProperties {
  @doc("MTU to use for option A peering.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  @doc("Vlan identifier. Example : 501")
  @maxValue(4094)
  @minValue(501)
  vlanId?: int32;

  @doc("Fabric ASN number. Example 65001 ")
  @visibility("read")
  @maxValue(4294967295)
  @minValue(1)
  fabricASN?: int32;

  @doc("Peer ASN number.Example : 28")
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int32;

  @doc("BFD configuration properties")
  bfdConfiguration?: BfdConfiguration;

  @doc("Ingress Acl. ARM resource ID of Access Control Lists.")
  ingressAclId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  egressAclId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;
}

@doc("The ExternalNetwork patchable properties.")
model ExternalNetworkPatchableProperties {
  @doc("ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.")
  importRoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.")
  exportRoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import Route Policy either IPv4 or IPv6.")
  importRoutePolicy?: ImportRoutePolicy;

  @doc("Export Route Policy either IPv4 or IPv6.")
  exportRoutePolicy?: ExportRoutePolicy;
}

@doc("The ExternalNetwork patch resource definition.")
model ExternalNetworkPatch {
  @doc("External Network Patch properties.")
  properties?: ExternalNetworkPatchProperties;
}

@doc("External Network Patch properties.")
model ExternalNetworkPatchProperties {
  ...AnnotationResource;
  ...ExternalNetworkPatchableProperties;

  @doc("Peering option list.")
  peeringOption?: PeeringOption;

  @doc("option B properties object")
  optionBProperties?: L3OptionBProperties;

  @doc("option A properties object")
  optionAProperties?: ExternalNetworkPatchPropertiesOptionAProperties;
}

@doc("option A properties object")
model ExternalNetworkPatchPropertiesOptionAProperties {
  ...Layer3IpPrefixProperties;
  ...L3OptionAProperties;
}

@doc("Neighbor Group Properties defines the properties of the resource.")
model NeighborGroupProperties {
  ...AnnotationResource;
  ...NeighborGroupPatchableProperties;

  @doc("List of NetworkTap IDs where neighbor group is associated.")
  @visibility("read")
  networkTapIds?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("List of Network Tap Rule IDs where neighbor group is associated.")
  @visibility("read")
  networkTapRuleIds?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>[];

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Neighbor Group Patchable Properties defines the patchable properties of the resource.")
model NeighborGroupPatchableProperties {
  @doc("An array of destination IPv4 Addresses or IPv6 Addresses.")
  destination?: NeighborGroupDestination;
}

@doc("An array of destination IPv4 Addresses or IPv6 Addresses.")
model NeighborGroupDestination {
  @doc("Array of IPv4 Addresses.")
  ipv4Addresses?: string[];

  @doc("Array of IPv6 Addresses.")
  ipv6Addresses?: string[];
}

@doc("The Neighbor Group Patch definition.")
model NeighborGroupPatch extends TagsUpdate {
  @doc("Neighbor Group Patch properties.")
  properties?: NeighborGroupPatchProperties;
}

@doc("Neighbor Group Patch properties.")
model NeighborGroupPatchProperties {
  ...AnnotationResource;
  ...NeighborGroupPatchableProperties;
}

@doc("Network Device SKU Properties defines the properties of the resource.")
model NetworkDeviceSkuProperties {
  @doc("Model of the network device.")
  `model`: string;

  @doc("Manufacturer of the network device.")
  manufacturer?: string;

  @doc("List of supported version details of network device.")
  supportedVersions?: SupportedVersionProperties[];

  @doc("Available roles for the network device.")
  supportedRoleTypes?: NetworkDeviceRoleName[];

  @doc("List of network device interfaces.")
  interfaces?: DeviceInterfaceProperties[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Supported version details of the network device.")
model SupportedVersionProperties {
  @doc("Operating system and firmware combined versions.")
  version?: string;

  @doc("Operating system version.")
  vendorOsVersion?: string;

  @doc("Firmware version.")
  vendorFirmwareVersion?: string;

  @doc("If true newly provisioned Fabric will use this device version by default to bootstrap the network devices for the first time.")
  isDefault?: BooleanEnumProperty;
}

@doc("Network device interface properties.")
model DeviceInterfaceProperties {
  @doc("Interface identifier. Example: HundredGigE0/0.")
  identifier?: string;

  @doc("Interface type.")
  interfaceType?: string;

  @doc("List of supported connector types.")
  supportedConnectorTypes?: SupportedConnectorProperties[];
}

@doc("Supported connector properties.")
model SupportedConnectorProperties {
  @doc("Type of connector used. Example: Optical.")
  connectorType?: string;

  @doc("Maximum speed of the connector in Mbps.")
  maxSpeedInMbps?: int32;
}

@doc("Network Device Properties defines the properties of the resource.")
model NetworkDeviceProperties {
  ...AnnotationResource;
  ...NetworkDevicePatchableProperties;

  @doc("Current version of the device as defined in SKU.")
  @visibility("read")
  version?: string;

  @doc("Network Device SKU name.")
  @visibility("read", "create")
  networkDeviceSku?: string;

  @doc("NetworkDeviceRole is the device role: Example: CE | ToR.")
  @visibility("read")
  networkDeviceRole?: NetworkDeviceRole;

  @doc("Reference to network rack resource id.")
  @visibility("read")
  networkRackId?: string;

  @doc("Management IPv4 Address.")
  @visibility("read")
  managementIpv4Address?: string;

  @doc("Management IPv6 Address.")
  @visibility("read")
  managementIpv6Address?: string;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("Network Device updatable properties.")
model NetworkDevicePatchableProperties {
  @doc("The host name of the device.")
  @minLength(1)
  hostName?: string;

  @doc("Serial number of the device. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.")
  @minLength(1)
  serialNumber?: string;
}

@doc("The Network Device Patch Parameters defines the patch parameters of the resource.")
model NetworkDevicePatchParameters extends TagsUpdate {
  @doc("Network Device Patch properties.")
  properties?: NetworkDevicePatchParametersProperties;
}

@doc("Network Device Patch properties.")
model NetworkDevicePatchParametersProperties {
  ...AnnotationResource;
  ...NetworkDevicePatchableProperties;
}

@doc("Network Interface Properties defines the properties of the resource.")
model NetworkInterfaceProperties extends AnnotationResource {
  @doc("Physical Identifier of the network interface.")
  @visibility("read")
  physicalIdentifier?: string;

  @doc("The ARM resource id of the interface or compute server its connected to.")
  @visibility("read")
  connectedTo?: string;

  @doc("The Interface Type. Example: Management/Data")
  @visibility("read")
  interfaceType?: InterfaceType;

  @doc("IPv4Address of the interface.")
  @visibility("read")
  ipv4Address?: string;

  @doc("IPv6Address of the interface.")
  @visibility("read")
  ipv6Address?: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("The NetworkInterfacePatch resource definition.")
model NetworkInterfacePatch {
  @doc("Network Interface Patch properties.")
  properties?: NetworkInterfacePatchProperties;
}

@doc("Network Interface Patch properties.")
model NetworkInterfacePatchProperties extends AnnotationResource {}

@doc("Reboot properties.")
model RebootProperties {
  @doc("Type of reboot to be performed. Example: GracefulRebootWithZTP")
  rebootType?: RebootType;
}

@doc("Update the administrative state on list of resources.")
model UpdateDeviceAdministrativeState extends EnableDisableOnResources {
  @doc("Administrative state.")
  state?: DeviceAdministrativeState;
}

@doc("Update version properties.")
model UpdateVersion {
  @doc("Specify the version.")
  version?: string;
}

@doc("NetworkFabricControllerProperties defines the resource properties.")
model NetworkFabricControllerProperties {
  ...AnnotationResource;
  ...NetworkFabricControllerPatchableProperties;

  @doc("InfrastructureServices IP ranges.")
  @visibility("read")
  infrastructureServices?: ControllerServices;

  @doc("WorkloadServices IP ranges.")
  @visibility("read")
  workloadServices?: ControllerServices;

  @doc("Managed Resource Group configuration properties.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("The NF-ID will be an input parameter used by the NF to link and get associated with the parent NFC Service.")
  @visibility("read")
  networkFabricIds?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>[];

  @doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints. This is used for the backward compatibility.")
  @visibility("read")
  workloadManagementNetwork?: boolean;

  @doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.")
  isWorkloadManagementNetworkEnabled?: IsWorkloadManagementNetworkEnabled;

  @doc("List of tenant InternetGateway resource IDs")
  @visibility("read")
  tenantInternetGatewayIds?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGateways";
    }
  ]>[];

  @doc("IPv4 Network Fabric Controller Address Space.")
  @minLength(1)
  ipv4AddressSpace?: string;

  @doc("IPv6 Network Fabric Controller Address Space.")
  @minLength(1)
  ipv6AddressSpace?: string;

  @doc("Network Fabric Controller SKU.")
  nfcSku?: NfcSku;

  @doc("Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of NFC provisioning.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Network Fabric Controller services.")
model ControllerServices {
  @doc("The IPv4 Address space is optional, if the value is not defined at the time of NFC creation, then the default value 10.0.0.0/19 is considered. The IPV4 address subnet is an optional attribute.")
  ipv4AddressSpaces?: string[];

  @doc("The IPv6 is not supported right now.")
  ipv6AddressSpaces?: string[];
}

@doc("Managed Resource Group configuration properties.")
model ManagedResourceGroupConfiguration {
  @doc("The NFC service will be hosted in a Managed resource group.")
  name?: string;

  @doc("Managed resource group location.")
  location?: string;
}

@doc("Network Fabric Controller updatable properties")
model NetworkFabricControllerPatchableProperties {
  @doc("As part of an update, the Infrastructure ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Infrastructure services. (This is a Mandatory attribute)")
  infrastructureExpressRouteConnections?: ExpressRouteConnectionInformation[];

  @doc("As part of an update, the workload ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Workload services. (This is a Mandatory attribute).")
  workloadExpressRouteConnections?: ExpressRouteConnectionInformation[];
}

@doc("The ExpressRoute circuit ID and the Auth Key are required for you to successfully deploy NFC service.")
model ExpressRouteConnectionInformation {
  @doc("The express route circuit Azure resource ID, must be of type Microsoft.Network/expressRouteCircuits/circuitName. The ExpressRoute Circuit is a mandatory attribute.")
  expressRouteCircuitId: ResourceIdentifier<[
    {
      type: "Microsoft.Network/expressRouteCircuits";
    }
  ]>;

  @doc("Authorization key for the circuit, must be of type Microsoft.Network/expressRouteCircuits/authorizations. The Auth Key is a mandatory attribute.")
  expressRouteAuthorizationKey?: string;
}

@doc("The Network Fabric Controller Patch payload definition.")
model NetworkFabricControllerPatch extends TagsUpdate {
  @doc("Network Fabric Controller patch properties.")
  properties?: NetworkFabricControllerPatchableProperties;
}

@doc("Network Fabric SKU Properties define properties of the resource.")
model NetworkFabricSkuProperties {
  @doc("Type of Network Fabric SKU.")
  @visibility("read")
  type?: FabricSkuType;

  @doc("Maximum number of compute racks available for this Network Fabric SKU. The value of max count racks is 4 for 4 rack SKU and 8 for 8 rack SKU.")
  maxComputeRacks?: int32;

  @doc("Maximum number of servers available for this Network Fabric SKU.")
  maximumServerCount?: int32;

  @doc("List of supported Network Fabric SKU versions.")
  @visibility("read")
  supportedVersions?: string[];

  @doc("URL providing detailed configuration of the fabric SKU.")
  @visibility("read")
  details?: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Network Fabric Properties defines the properties of the resource.")
model NetworkFabricProperties extends AnnotationResource {
  @doc("Supported Network Fabric SKU.Example: Compute / Aggregate racks. Once the user chooses a particular SKU, only supported racks can be added to the Network Fabric. The SKU determines whether it is a single / multi rack Network Fabric.")
  @visibility("read", "create")
  @minLength(1)
  networkFabricSku: string;

  @doc("The version of Network Fabric.")
  @visibility("read")
  fabricVersion?: string;

  @doc("Array of router IDs.")
  @visibility("read")
  routerIds?: string[];

  @doc("Azure resource ID for the NetworkFabricController the NetworkFabric belongs.")
  @visibility("read", "create")
  networkFabricControllerId: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabricControllers";
    }
  ]>;

  @doc("Number of compute racks associated to Network Fabric.")
  @maxValue(8)
  @minValue(1)
  rackCount?: int32;

  @doc("Number of servers.Possible values are from 1-16.")
  @maxValue(16)
  @minValue(1)
  serverCountPerRack: int32;

  @doc("IPv4Prefix for Management Network. Example: 10.1.0.0/19.")
  @minLength(1)
  ipv4Prefix: string;

  @doc("IPv6Prefix for Management Network. Example: 3FFE:FFFF:0:CD40::/59")
  @minLength(1)
  ipv6Prefix?: string;

  @doc("ASN of CE devices for CE/PE connectivity.")
  @maxValue(4294967295)
  @minValue(1)
  fabricASN: int32;

  @doc("Network and credentials configuration currently applied to terminal server.")
  terminalServerConfiguration: TerminalServerConfiguration;

  @doc("Configuration to be used to setup the management network.")
  managementNetworkConfiguration: ManagementNetworkConfigurationProperties;

  @doc("List of NetworkRack resource IDs under the Network Fabric. The number of racks allowed depends on the Network Fabric SKU.")
  @visibility("read")
  racks?: string[];

  @doc("List of L2 Isolation Domain resource IDs under the Network Fabric.")
  @visibility("read")
  l2IsolationDomains?: string[];

  @doc("List of L3 Isolation Domain resource IDs under the Network Fabric.")
  @visibility("read")
  l3IsolationDomains?: string[];

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of NFC provisioning.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("Network and credentials configuration currently applied to terminal server.")
model TerminalServerConfiguration {
  ...TerminalServerPatchableProperties;
  ...Layer3IpPrefixProperties;

  @doc("ARM Resource ID used for the NetworkDevice.")
  @visibility("read")
  networkDeviceId?: string;
}

@doc("Network and credential configuration currently applied on terminal server.")
model TerminalServerPatchableProperties {
  @doc("Username for the terminal server connection.")
  @minLength(1)
  username?: string;

  @doc("Password for the terminal server connection.")
  @minLength(1)
  password?: string;

  @doc("Serial Number of Terminal server.")
  @minLength(1)
  serialNumber?: string;
}

@doc("Configuration to be used to setup the management network.")
model ManagementNetworkConfigurationProperties {
  @doc("VPN Configuration properties.")
  infrastructureVpnConfiguration: VpnConfigurationProperties;

  @doc("VPN Configuration properties.")
  workloadVpnConfiguration: VpnConfigurationProperties;
}

@doc("Network and credential configuration currently applied on terminal server.")
model VpnConfigurationProperties {
  @doc("ARM Resource ID of the Network To Network Interconnect.")
  networkToNetworkInterconnectId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;

  @doc("Peering option list.")
  peeringOption: PeeringOption;

  @doc("option B properties")
  optionBProperties?: OptionBProperties;

  @doc("option A properties")
  optionAProperties?: VpnConfigurationPropertiesOptionAProperties;
}

@doc("Option B configuration to be used for Management VPN.")
model OptionBProperties {
  @doc("Route Targets to be applied for incoming routes into CE. This is for backward compatibility.")
  importRouteTargets?: string[];

  @doc("Route Targets to be applied for outgoing routes from CE. This is for backward compatibility.")
  exportRouteTargets?: string[];

  @doc("Route Targets to be applied.")
  routeTargets?: RouteTargetInformation;
}

@doc("option A properties")
model VpnConfigurationPropertiesOptionAProperties {
  ...OptionAProperties;
  ...Layer3IpPrefixProperties;
}

@doc("Peering optionA properties")
model OptionAProperties {
  @doc("MTU to use for option A peering.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  @doc("Vlan Id.Example : 501")
  @maxValue(4094)
  @minValue(501)
  vlanId?: int32;

  @doc("Peer ASN number.Example : 28")
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int32;

  @doc("BFD Configuration properties.")
  bfdConfiguration?: BfdConfiguration;
}

@doc("The Network Fabric resource definition.")
model NetworkFabricPatch extends TagsUpdate {
  @doc("Network Fabric Patch properties.")
  properties?: NetworkFabricPatchProperties;
}

@doc("Network Fabric Patch properties.")
model NetworkFabricPatchProperties {
  ...AnnotationResource;
  ...NetworkFabricPatchableProperties;
}

@doc("Network Fabric updatable properties.")
model NetworkFabricPatchableProperties {
  @doc("Number of compute racks associated to Network Fabric.")
  @maxValue(8)
  @minValue(1)
  rackCount?: int32;

  @doc("Number of servers.Possible values are from 1-16.")
  @maxValue(16)
  @minValue(1)
  serverCountPerRack?: int32;

  @doc("IPv4Prefix for Management Network. Example: 10.1.0.0/19.")
  @minLength(1)
  ipv4Prefix?: string;

  @doc("IPv6Prefix for Management Network. Example: 3FFE:FFFF:0:CD40::/59.")
  @minLength(1)
  ipv6Prefix?: string;

  @doc("ASN of CE devices for CE/PE connectivity.")
  @maxValue(4294967295)
  @minValue(1)
  fabricASN?: int32;

  @doc("Network and credentials configuration already applied to terminal server.")
  terminalServerConfiguration?: NetworkFabricPatchablePropertiesTerminalServerConfiguration;

  @doc("Configuration to be used to setup the management network.")
  managementNetworkConfiguration?: ManagementNetworkConfigurationPatchableProperties;
}

@doc("Network and credentials configuration already applied to terminal server.")
model NetworkFabricPatchablePropertiesTerminalServerConfiguration {
  ...TerminalServerPatchableProperties;
  ...Layer3IpPrefixProperties;
}

@doc("Configuration to be used to setup the management network.")
model ManagementNetworkConfigurationPatchableProperties {
  @doc("VPN Configuration properties.")
  infrastructureVpnConfiguration?: VpnConfigurationPatchableProperties;

  @doc("VPN Configuration properties.")
  workloadVpnConfiguration?: VpnConfigurationPatchableProperties;
}

@doc("Network and credential configuration currently applied on terminal server.")
model VpnConfigurationPatchableProperties {
  @doc("ARM Resource ID of the Network To Network Interconnect.")
  networkToNetworkInterconnectId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  @doc("Peering option list.")
  peeringOption?: PeeringOption;

  @doc("option B properties")
  optionBProperties?: OptionBProperties;

  @doc("option A properties")
  optionAProperties?: VpnConfigurationPatchablePropertiesOptionAProperties;
}

@doc("option A properties")
model VpnConfigurationPatchablePropertiesOptionAProperties {
  ...OptionAProperties;
  ...Layer3IpPrefixProperties;
}

@doc("Validation configuration properties.")
model ValidateConfigurationProperties {
  @doc("Validate action that to be performed")
  validateAction?: ValidateAction;
}

@doc("Configuration used to setup CE-PE connectivity.")
model NetworkToNetworkInterconnectProperties {
  @doc("Type of NNI used. Example: CE | NPB")
  nniType?: NniType;

  @doc("Configuration to use NNI for Infrastructure Management. Example: True/False.")
  isManagementType?: IsManagementType;

  @doc("Based on this option layer3 parameters are mandatory. Example: True/False")
  useOptionB: BooleanEnumProperty;

  @doc("Common properties for Layer2 Configuration.")
  layer2Configuration?: Layer2Configuration;

  @doc("Common properties for Layer3Configuration.")
  optionBLayer3Configuration?: NetworkToNetworkInterconnectPropertiesOptionBLayer3Configuration;

  @doc("NPB Static Route Configuration properties.")
  npbStaticRouteConfiguration?: NpbStaticRouteConfiguration;

  @doc("Import Route Policy configuration.")
  importRoutePolicy?: ImportRoutePolicyInformation;

  @doc("Export Route Policy configuration.")
  exportRoutePolicy?: ExportRoutePolicyInformation;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  egressAclId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Ingress Acl. ARM resource ID of Access Control Lists.")
  ingressAclId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("Common properties for Layer2 Configuration.")
model Layer2Configuration {
  @doc("MTU of the packets between PE & CE.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  @doc("List of network device interfaces resource IDs.")
  interfaces?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];
}

@doc("Common properties for Layer3Configuration.")
model NetworkToNetworkInterconnectPropertiesOptionBLayer3Configuration
  extends OptionBLayer3Configuration {}

@doc("OptionB Layer3 Configuration properties.")
model OptionBLayer3Configuration extends Layer3IpPrefixProperties {
  @doc("ASN of PE devices for CE/PE connectivity.Example : 28")
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int32;

  @doc("VLAN for CE/PE Layer 3 connectivity.Example : 501")
  @maxValue(4094)
  @minValue(100)
  vlanId?: int32;

  @doc("ASN of CE devices for CE/PE connectivity.")
  @visibility("read")
  fabricASN?: int32;
}

@doc("NPB Static Route Configuration properties.")
model NpbStaticRouteConfiguration {
  @doc("BFD Configuration properties.")
  bfdConfiguration?: BfdConfiguration;

  @doc("List of IPv4 Routes.")
  ipv4Routes?: StaticRouteProperties[];

  @doc("List of IPv6 Routes.")
  ipv6Routes?: StaticRouteProperties[];
}

@doc("Import Route Policy Configuration.")
model ImportRoutePolicyInformation {
  @doc("Import IPv4 Route Policy Id.")
  importIpv4RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Import IPv6 Route Policy Id.")
  importIpv6RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Export Route Policy Configuration.")
model ExportRoutePolicyInformation {
  @doc("Export IPv4 Route Policy Id.")
  exportIpv4RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Export IPv6 Route Policy Id.")
  exportIpv6RoutePolicyId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("The Network To Network Interconnect resource patch definition.")
model NetworkToNetworkInterconnectPatch extends ProxyResource {
  @doc("Resource properties.")
  properties?: NetworkToNetworkInterconnectPatchableProperties;
}

@doc("Network to Network Interconnect patchable properties.")
model NetworkToNetworkInterconnectPatchableProperties {
  @doc("Common properties for Layer2Configuration.")
  layer2Configuration?: Layer2Configuration;

  @doc("Common properties for Layer3Configuration.")
  optionBLayer3Configuration?: OptionBLayer3Configuration;

  @doc("NPB Static Route Configuration properties.")
  npbStaticRouteConfiguration?: NpbStaticRouteConfiguration;

  @doc("Import Route Policy information.")
  importRoutePolicy?: ImportRoutePolicyInformation;

  @doc("Export Route Policy information")
  exportRoutePolicy?: ExportRoutePolicyInformation;

  @doc("Egress Acl. ARM resource ID of Access Control Lists.")
  egressAclId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  @doc("Ingress Acl. ARM resource ID of Access Control Lists.")
  ingressAclId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;
}

@doc("Network Packet Broker Properties defines the properties of the resource.")
model NetworkPacketBrokerProperties {
  @doc("ARM resource ID of the Network Fabric.")
  @visibility("read", "create")
  networkFabricId: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("List of ARM resource IDs of Network Devices [NPB].")
  @visibility("read")
  networkDeviceIds?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];

  @doc("List of network interfaces across NPB devices that are used to mirror source traffic.")
  @visibility("read")
  sourceInterfaceIds?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];

  @doc("List of network Tap IDs configured on NPB.")
  @visibility("read")
  networkTapIds?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("List of neighbor group IDs configured on NPB.")
  @visibility("read")
  neighborGroupIds?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The NetworkPacketBroker patch resource definition.")
model NetworkPacketBrokerPatch extends TagsUpdate {}

@doc("Network Rack Properties defines the properties of the resource.")
model NetworkRackProperties extends AnnotationResource {
  @doc("Network Rack SKU name.")
  networkRackType?: NetworkRackType;

  @doc("ARM resource ID of the Network Fabric.")
  networkFabricId: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("List of network device ARM resource IDs.")
  @visibility("read")
  networkDevices?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Network Tap Rule Properties defines the resource properties.")
model NetworkTapRuleProperties {
  ...AnnotationResource;
  ...NetworkTapRulePatchableProperties;

  @doc("The ARM resource Id of the NetworkTap.")
  @visibility("read")
  networkTapId?: string;

  @doc("Polling interval in seconds.")
  pollingIntervalInSeconds?: PollingIntervalInSeconds;

  @doc("The last sync timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncedTime?: utcDateTime;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("Network Tap Rule updatable properties.")
model NetworkTapRulePatchableProperties {
  @doc("Input method to configure Network Tap Rule.")
  configurationType?: ConfigurationType;

  @doc("Network Tap Rules file URL.")
  tapRulesUrl?: string;

  @doc("List of match configurations.")
  matchConfigurations?: NetworkTapRuleMatchConfiguration[];

  @doc("List of dynamic match configurations.")
  dynamicMatchConfigurations?: CommonDynamicMatchConfiguration[];
}

@doc("Defines the match configuration that are supported to filter the traffic.")
model NetworkTapRuleMatchConfiguration {
  @doc("The name of the match configuration.")
  @minLength(1)
  matchConfigurationName?: string;

  @doc("Sequence Number of the match configuration..")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int32;

  @doc("Type of IP Address. IPv4 or IPv6")
  ipAddressType?: IPAddressType;

  @doc("List of the match conditions.")
  matchConditions?: NetworkTapRuleMatchCondition[];

  @doc("List of actions that need to be performed for the matched conditions.")
  actions?: NetworkTapRuleAction[];
}

@doc("Defines the match condition that is supported to filter the traffic.")
model NetworkTapRuleMatchCondition extends CommonMatchConditions {
  @doc("Encapsulation Type that needs to be matched.")
  encapsulationType?: EncapsulationType;

  @doc("Defines the port condition that needs to be matched.")
  portCondition?: PortCondition;
}

@doc("Action that need to performed.")
model NetworkTapRuleAction {
  @doc("Type of actions that can be performed.")
  type?: TapRuleActionType;

  @doc("Truncate. 0 indicates do not truncate.")
  @minLength(1)
  truncate?: string;

  @doc("The parameter to enable or disable the timestamp.")
  isTimestampEnabled?: BooleanEnumProperty;

  @doc("Destination Id. The ARM resource Id may be either Network To Network Interconnect or NeighborGroup.")
  destinationId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/neighborGroups";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  @doc("The name of the match configuration. This is used when Goto type is provided. If Goto type is selected and no match configuration name is provided. It goes to next configuration.")
  @minLength(1)
  matchConfigurationName?: string;
}

@doc("The NetworkTapRule resource definition.")
model NetworkTapRulePatch extends TagsUpdate {
  @doc("Network Tap Rule Patch properties.")
  properties?: NetworkTapRulePatchProperties;
}

@doc("Network Tap Rule Patch properties.")
model NetworkTapRulePatchProperties {
  ...AnnotationResource;
  ...NetworkTapRulePatchableProperties;
}

@doc("Network Tap Properties defines the properties of the resource.")
model NetworkTapProperties extends AnnotationResource {
  @doc("ARM resource ID of the Network Packet Broker.")
  @visibility("read", "create")
  networkPacketBrokerId: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Source Tap Rule Id. ARM Resource ID of the Network Tap Rule.")
  @visibility("read")
  sourceTapRuleId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;

  @doc("List of destinations to send the filter traffic.")
  destinations: NetworkTapPropertiesDestinationsItem[];

  @doc("Polling type.")
  pollingType?: PollingType;

  @doc("Gets the configurations state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of Network Tap provisioning.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource. Example -Enabled/Disabled")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("Destination.")
model NetworkTapPropertiesDestinationsItem extends DestinationProperties {}

@doc("The network tap destination properties.")
model DestinationProperties {
  @doc("Destination name.")
  @minLength(1)
  name?: string;

  @doc("Type of destination. Input can be IsolationDomain or Direct.")
  destinationType?: DestinationType;

  @doc("The destination Id. ARM Resource ID of either NNI or Internal Networks.")
  destinationId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkToNetworkInterconnects";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains/internalNetworks";
    }
  ]>;

  @doc("Isolation Domain Properties.")
  isolationDomainProperties?: IsolationDomainProperties;

  @doc("ARM Resource ID of destination Tap Rule that contains match configurations.")
  destinationTapRuleId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;
}

@doc("Isolation Domain Properties.")
model IsolationDomainProperties {
  @doc("Type of encapsulation.")
  encapsulation?: Encapsulation;

  @doc("List of Neighbor Group IDs.")
  neighborGroupIds?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/neighborGroups";
    }
  ]>[];
}

@doc("The NetworkFabric resource definition.")
model NetworkTapPatch extends TagsUpdate {
  @doc("Resource properties.")
  properties?: NetworkTapPatchableParameters;
}

@doc("The Network Tap resource patch definition.")
model NetworkTapPatchableParameters extends AnnotationResource {
  @doc("Polling type.")
  pollingType?: PollingType;

  @doc("List of destination properties to send the filter traffic.")
  destinations?: NetworkTapPatchableParametersDestinationsItem[];
}

@doc("Destination.")
model NetworkTapPatchableParametersDestinationsItem
  extends DestinationProperties {}

@doc("RoutePolicyProperties defines the resource properties.")
model RoutePolicyProperties {
  ...AnnotationResource;
  ...RoutePolicyPatchableProperties;

  @doc("Arm Resource ID of Network Fabric.")
  networkFabricId: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("AddressFamilyType. This parameter decides whether the given ipv4 or ipv6 route policy.")
  addressFamilyType?: AddressFamilyType;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("Route Policy patchable properties.")
model RoutePolicyPatchableProperties {
  @doc("Default action that needs to be applied when no condition is matched. Example: Permit | Deny.")
  defaultAction?: CommunityActionTypes;

  @doc("Route Policy statements.")
  statements?: RoutePolicyStatementProperties[];
}

@doc("Route Policy Statement properties.")
model RoutePolicyStatementProperties extends AnnotationResource {
  @doc("Sequence to insert to/delete from existing route.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int32;

  @doc("Route policy condition properties.")
  condition: StatementConditionProperties;

  @doc("Route policy action properties.")
  action: StatementActionProperties;
}

@doc("Route policy statement condition properties.")
model StatementConditionProperties {
  ...IpCommunityIdList;
  ...IpExtendedCommunityIdList;

  @doc("Type of the condition used.")
  type?: RoutePolicyConditionType;

  @doc("Arm Resource Id of IpPrefix.")
  ipPrefixId?: string;
}

@doc("IP Community ID list properties.")
model IpCommunityIdList {
  @doc("List of IP Community resource IDs.")
  ipCommunityIds?: string[];
}

@doc("IP Extended Community Id list properties.")
model IpExtendedCommunityIdList {
  @doc("List of IP Extended Community resource IDs.")
  ipExtendedCommunityIds?: string[];
}

@doc("Route policy action properties.")
model StatementActionProperties {
  @doc("Local Preference of the route policy.")
  @maxValue(4294967295)
  localPreference?: int32;

  @doc("Action type. Example: Permit | Deny | Continue.")
  actionType: RoutePolicyActionType;

  @doc("IP Community Properties.")
  ipCommunityProperties?: ActionIpCommunityProperties;

  @doc("IP Extended Community Properties.")
  ipExtendedCommunityProperties?: ActionIpExtendedCommunityProperties;
}

@doc("IP Community Properties.")
model ActionIpCommunityProperties {
  ...IpCommunityAddOperationProperties;
  ...IpCommunityDeleteOperationProperties;
  ...IpCommunitySetOperationProperties;
}

@doc("IP Community add operation properties.")
model IpCommunityAddOperationProperties {
  @doc("List of IP Community IDs.")
  add?: IpCommunityIdList;
}

@doc("IP Community delete operation properties.")
model IpCommunityDeleteOperationProperties {
  @doc("List of IP Community IDs.")
  delete?: IpCommunityIdList;
}

@doc("IP Community set operation properties.")
model IpCommunitySetOperationProperties {
  @doc("List of IP Community IDs.")
  set?: IpCommunityIdList;
}

@doc("IP Extended Community Properties.")
model ActionIpExtendedCommunityProperties {
  ...IpExtendedCommunityAddOperationProperties;
  ...IpExtendedCommunityDeleteOperationProperties;
  ...IpExtendedCommunitySetOperationProperties;
}

@doc("IP Extended Community add operation properties.")
model IpExtendedCommunityAddOperationProperties {
  @doc("List of IP Extended Community IDs.")
  add?: IpExtendedCommunityIdList;
}

@doc("IP Extended Community delete operation properties.")
model IpExtendedCommunityDeleteOperationProperties {
  @doc("List of IP Extended Community IDs.")
  delete?: IpExtendedCommunityIdList;
}

@doc("IP Extended Community set operation properties.")
model IpExtendedCommunitySetOperationProperties {
  @doc("List of IP Extended Community IDs.")
  set?: IpExtendedCommunityIdList;
}

@doc("The Route Policy patch resource definition.")
model RoutePolicyPatch extends TagsUpdate {
  @doc("The RoutePolicy patchable properties.")
  properties?: RoutePolicyPatchableProperties;
}

@doc("The extended location.")
model ExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}
