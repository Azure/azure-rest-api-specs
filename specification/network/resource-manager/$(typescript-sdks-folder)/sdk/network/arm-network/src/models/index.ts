import * as coreClient from "@azure/core-client";

export type FirewallPolicyRuleCollectionUnion =
  | FirewallPolicyRuleCollection
  | FirewallPolicyNatRuleCollection
  | FirewallPolicyFilterRuleCollection;
export type ActiveBaseSecurityAdminRuleUnion =
  | ActiveBaseSecurityAdminRule
  | ActiveSecurityAdminRule
  | ActiveDefaultSecurityAdminRule;
export type EffectiveBaseSecurityAdminRuleUnion =
  | EffectiveBaseSecurityAdminRule
  | EffectiveSecurityAdminRule
  | EffectiveDefaultSecurityAdminRule;
export type FirewallPolicyRuleUnion =
  | FirewallPolicyRule
  | ApplicationRule
  | NatRule
  | NetworkRule;
export type BaseAdminRuleUnion = BaseAdminRule | AdminRule | DefaultAdminRule;

/** An error response from the service. */
export interface CloudError {
  /** Cloud error body. */
  error?: CloudErrorBody;
}

/** An error response from the service. */
export interface CloudErrorBody {
  /** An identifier for the error. Codes are invariant and are intended to be consumed programmatically. */
  code?: string;
  /** A message describing the error, intended to be suitable for display in a user interface. */
  message?: string;
  /** The target of the particular error. For example, the name of the property in error. */
  target?: string;
  /** A list of additional details about the error. */
  details?: CloudErrorBody[];
}

/** SKU of an application gateway. */
export interface ApplicationGatewaySku {
  /** Name of an application gateway SKU. */
  name?: ApplicationGatewaySkuName;
  /** Tier of an application gateway. */
  tier?: ApplicationGatewayTier;
  /** Capacity (instance count) of an application gateway. */
  capacity?: number;
}

/** Application Gateway Ssl policy. */
export interface ApplicationGatewaySslPolicy {
  /** Ssl protocols to be disabled on application gateway. */
  disabledSslProtocols?: ApplicationGatewaySslProtocol[];
  /** Type of Ssl Policy. */
  policyType?: ApplicationGatewaySslPolicyType;
  /** Name of Ssl predefined policy. */
  policyName?: ApplicationGatewaySslPolicyName;
  /** Ssl cipher suites to be enabled in the specified order to application gateway. */
  cipherSuites?: ApplicationGatewaySslCipherSuite[];
  /** Minimum version of Ssl protocol to be supported on application gateway. */
  minProtocolVersion?: ApplicationGatewaySslProtocol;
}

/** Reference to another subresource. */
export interface SubResource {
  /** Resource ID. */
  id?: string;
}

/** Application gateway probe health response match. */
export interface ApplicationGatewayProbeHealthResponseMatch {
  /** Body that must be contained in the health response. Default value is empty. */
  body?: string;
  /** Allowed ranges of healthy status codes. Default range of healthy status codes is 200-399. */
  statusCodes?: string[];
}

/** Common resource representation. */
export interface Resource {
  /** Resource ID. */
  id?: string;
  /**
   * Resource name.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Resource location. */
  location?: string;
  /** Resource tags. */
  tags?: { [propertyName: string]: string };
}

/** ExtendedLocation complex type. */
export interface ExtendedLocation {
  /** The name of the extended location. */
  name?: string;
  /** The type of the extended location. */
  type?: ExtendedLocationTypes;
}

/** A collection of information about the state of the connection between service consumer and provider. */
export interface PrivateLinkServiceConnectionState {
  /** Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service. */
  status?: string;
  /** The reason for approval/rejection of the connection. */
  description?: string;
  /** A message indicating if changes on the service provider require any updates on the consumer. */
  actionsRequired?: string;
}

/** Contains custom Dns resolution configuration from customer. */
export interface CustomDnsConfigPropertiesFormat {
  /** Fqdn that resolves to private endpoint ip address. */
  fqdn?: string;
  /** A list of private ip addresses of the private endpoint. */
  ipAddresses?: string[];
}

/** An IP Configuration of the private endpoint. */
export interface PrivateEndpointIPConfiguration {
  /** The name of the resource that is unique within a resource group. */
  name?: string;
  /**
   * The resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The ID of a group obtained from the remote resource that this private endpoint should connect to. */
  groupId?: string;
  /** The member name of a group obtained from the remote resource that this private endpoint should connect to. */
  memberName?: string;
  /** A private ip address obtained from the private endpoint's subnet. */
  privateIPAddress?: string;
}

/** DNS settings of a network interface. */
export interface NetworkInterfaceDnsSettings {
  /** List of DNS servers IP addresses. Use 'AzureProvidedDNS' to switch to azure provided DNS resolution. 'AzureProvidedDNS' value cannot be combined with other IPs, it must be the only value in dnsServers collection. */
  dnsServers?: string[];
  /**
   * If the VM that uses this NIC is part of an Availability Set, then this list will have the union of all DNS servers from all NICs that are part of the Availability Set. This property is what is configured on each of those VMs.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly appliedDnsServers?: string[];
  /** Relative DNS name for this NIC used for internal communications between VMs in the same virtual network. */
  internalDnsNameLabel?: string;
  /**
   * Fully qualified DNS name supporting internal communications between VMs in the same virtual network.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly internalFqdn?: string;
  /**
   * Even if internalDnsNameLabel is not specified, a DNS entry is created for the primary NIC of the VM. This DNS name can be constructed by concatenating the VM name with the value of internalDomainNameSuffix.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly internalDomainNameSuffix?: string;
}

/** The base resource set for visibility and auto-approval. */
export interface ResourceSet {
  /** The list of subscriptions. */
  subscriptions?: string[];
}

/** Parameters that define the retention policy for flow log. */
export interface RetentionPolicyParameters {
  /** Number of days to retain flow log records. */
  days?: number;
  /** Flag to enable/disable retention. */
  enabled?: boolean;
}

/** Parameters that define the flow log format. */
export interface FlowLogFormatParameters {
  /** The file type of flow log. */
  type?: FlowLogFormatType;
  /** The version (revision) of the flow log. */
  version?: number;
}

/** Parameters that define the configuration of traffic analytics. */
export interface TrafficAnalyticsProperties {
  /** Parameters that define the configuration of traffic analytics. */
  networkWatcherFlowAnalyticsConfiguration?: TrafficAnalyticsConfigurationProperties;
}

/** Parameters that define the configuration of traffic analytics. */
export interface TrafficAnalyticsConfigurationProperties {
  /** Flag to enable/disable traffic analytics. */
  enabled?: boolean;
  /** The resource guid of the attached workspace. */
  workspaceId?: string;
  /** The location of the attached workspace. */
  workspaceRegion?: string;
  /** Resource Id of the attached workspace. */
  workspaceResourceId?: string;
  /** The interval in minutes which would decide how frequently TA service should do flow analytics. */
  trafficAnalyticsInterval?: number;
}

/** The service endpoint properties. */
export interface ServiceEndpointPropertiesFormat {
  /** The type of the endpoint service. */
  service?: string;
  /** A list of locations. */
  locations?: string[];
  /**
   * The provisioning state of the service endpoint resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** SKU of a public IP address. */
export interface PublicIPAddressSku {
  /** Name of a public IP address SKU. */
  name?: PublicIPAddressSkuName;
  /** Tier of a public IP address SKU. */
  tier?: PublicIPAddressSkuTier;
}

/** Contains FQDN of the DNS record associated with the public IP address. */
export interface PublicIPAddressDnsSettings {
  /** The domain name label. The concatenation of the domain name label and the regionalized DNS zone make up the fully qualified domain name associated with the public IP address. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system. */
  domainNameLabel?: string;
  /** The Fully Qualified Domain Name of the A DNS record associated with the public IP. This is the concatenation of the domainNameLabel and the regionalized DNS zone. */
  fqdn?: string;
  /** The reverse FQDN. A user-visible, fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN. */
  reverseFqdn?: string;
}

/** Contains the DDoS protection settings of the public IP. */
export interface DdosSettings {
  /** The DDoS custom policy associated with the public IP. */
  ddosCustomPolicy?: SubResource;
  /** The DDoS protection policy customizability of the public IP. Only standard coverage will have the ability to be customized. */
  protectionCoverage?: DdosSettingsProtectionCoverage;
  /** Enables DDoS protection on the public IP. */
  protectedIP?: boolean;
}

/** Contains the IpTag associated with the object. */
export interface IpTag {
  /** The IP tag type. Example: FirstPartyUsage. */
  ipTagType?: string;
  /** The value of the IP tag associated with the public IP. Example: SQL. */
  tag?: string;
}

/** SKU of nat gateway. */
export interface NatGatewaySku {
  /** Name of Nat Gateway SKU. */
  name?: NatGatewaySkuName;
}

/** Gateway load balancer tunnel interface of a load balancer backend address pool. */
export interface GatewayLoadBalancerTunnelInterface {
  /** Port of gateway load balancer tunnel interface. */
  port?: number;
  /** Identifier of gateway load balancer tunnel interface. */
  identifier?: number;
  /** Protocol of gateway load balancer tunnel interface. */
  protocol?: GatewayLoadBalancerTunnelProtocol;
  /** Traffic type of gateway load balancer tunnel interface. */
  type?: GatewayLoadBalancerTunnelInterfaceType;
}

/** Load balancer backend addresses. */
export interface LoadBalancerBackendAddress {
  /** Name of the backend address. */
  name?: string;
  /** Reference to an existing virtual network. */
  virtualNetwork?: SubResource;
  /** Reference to an existing subnet. */
  subnet?: SubResource;
  /** IP Address belonging to the referenced virtual network. */
  ipAddress?: string;
  /**
   * Reference to IP address defined in network interfaces.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly networkInterfaceIPConfiguration?: SubResource;
  /** Reference to the frontend ip address configuration defined in regional loadbalancer. */
  loadBalancerFrontendIPConfiguration?: SubResource;
  /**
   * Collection of inbound NAT rule port mappings.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly inboundNatRulesPortMapping?: NatRulePortMapping[];
  /** A list of administrative states which once set can override health probe so that Load Balancer will always forward new connections to backend, or deny new connections and reset existing connections. */
  adminState?: LoadBalancerBackendAddressAdminState;
}

/** Individual port mappings for inbound NAT rule created for backend pool. */
export interface NatRulePortMapping {
  /** Name of inbound NAT rule. */
  inboundNatRuleName?: string;
  /** Frontend port. */
  frontendPort?: number;
  /** Backend port. */
  backendPort?: number;
}

/** PrivateLinkConnection properties for the network interface. */
export interface NetworkInterfaceIPConfigurationPrivateLinkConnectionProperties {
  /**
   * The group ID for current private link connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly groupId?: string;
  /**
   * The required member name for current private link connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly requiredMemberName?: string;
  /**
   * List of FQDNs for current private link connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly fqdns?: string[];
}

/** Backend address of an application gateway. */
export interface ApplicationGatewayBackendAddress {
  /** Fully qualified domain name (FQDN). */
  fqdn?: string;
  /** IP address. */
  ipAddress?: string;
}

/** Connection draining allows open connections to a backend server to be active for a specified time after the backend server got removed from the configuration. */
export interface ApplicationGatewayConnectionDraining {
  /** Whether connection draining is enabled or not. */
  enabled: boolean;
  /** The number of seconds connection draining is active. Acceptable values are from 1 second to 3600 seconds. */
  drainTimeoutInSec: number;
}

/** Customer error of an application gateway. */
export interface ApplicationGatewayCustomError {
  /** Status code of the application gateway customer error. */
  statusCode?: ApplicationGatewayCustomErrorStatusCode;
  /** Error page URL of the application gateway customer error. */
  customErrorPageUrl?: string;
}

/** Application gateway client authentication configuration. */
export interface ApplicationGatewayClientAuthConfiguration {
  /** Verify client certificate issuer name on the application gateway. */
  verifyClientCertIssuerDN?: boolean;
}

/** Rewrite rule of an application gateway. */
export interface ApplicationGatewayRewriteRule {
  /** Name of the rewrite rule that is unique within an Application Gateway. */
  name?: string;
  /** Rule Sequence of the rewrite rule that determines the order of execution of a particular rule in a RewriteRuleSet. */
  ruleSequence?: number;
  /** Conditions based on which the action set execution will be evaluated. */
  conditions?: ApplicationGatewayRewriteRuleCondition[];
  /** Set of actions to be done as part of the rewrite Rule. */
  actionSet?: ApplicationGatewayRewriteRuleActionSet;
}

/** Set of conditions in the Rewrite Rule in Application Gateway. */
export interface ApplicationGatewayRewriteRuleCondition {
  /** The condition parameter of the RewriteRuleCondition. */
  variable?: string;
  /** The pattern, either fixed string or regular expression, that evaluates the truthfulness of the condition. */
  pattern?: string;
  /** Setting this parameter to truth value with force the pattern to do a case in-sensitive comparison. */
  ignoreCase?: boolean;
  /** Setting this value as truth will force to check the negation of the condition given by the user. */
  negate?: boolean;
}

/** Set of actions in the Rewrite Rule in Application Gateway. */
export interface ApplicationGatewayRewriteRuleActionSet {
  /** Request Header Actions in the Action Set. */
  requestHeaderConfigurations?: ApplicationGatewayHeaderConfiguration[];
  /** Response Header Actions in the Action Set. */
  responseHeaderConfigurations?: ApplicationGatewayHeaderConfiguration[];
  /** Url Configuration Action in the Action Set. */
  urlConfiguration?: ApplicationGatewayUrlConfiguration;
}

/** Header configuration of the Actions set in Application Gateway. */
export interface ApplicationGatewayHeaderConfiguration {
  /** Header name of the header configuration. */
  headerName?: string;
  /** Header value of the header configuration. */
  headerValue?: string;
}

/** Url configuration of the Actions set in Application Gateway. */
export interface ApplicationGatewayUrlConfiguration {
  /** Url path which user has provided for url rewrite. Null means no path will be updated. Default value is null. */
  modifiedPath?: string;
  /** Query string which user has provided for url rewrite. Null means no query string will be updated. Default value is null. */
  modifiedQueryString?: string;
  /** If set as true, it will re-evaluate the url path map provided in path based request routing rules using modified path. Default value is false. */
  reroute?: boolean;
}

/** Application gateway web application firewall configuration. */
export interface ApplicationGatewayWebApplicationFirewallConfiguration {
  /** Whether the web application firewall is enabled or not. */
  enabled: boolean;
  /** Web application firewall mode. */
  firewallMode: ApplicationGatewayFirewallMode;
  /** The type of the web application firewall rule set. Possible values are: 'OWASP'. */
  ruleSetType: string;
  /** The version of the rule set type. */
  ruleSetVersion: string;
  /** The disabled rule groups. */
  disabledRuleGroups?: ApplicationGatewayFirewallDisabledRuleGroup[];
  /** Whether allow WAF to check request Body. */
  requestBodyCheck?: boolean;
  /** Maximum request body size for WAF. */
  maxRequestBodySize?: number;
  /** Maximum request body size in Kb for WAF. */
  maxRequestBodySizeInKb?: number;
  /** Maximum file upload size in Mb for WAF. */
  fileUploadLimitInMb?: number;
  /** The exclusion list. */
  exclusions?: ApplicationGatewayFirewallExclusion[];
}

/** Allows to disable rules within a rule group or an entire rule group. */
export interface ApplicationGatewayFirewallDisabledRuleGroup {
  /** The name of the rule group that will be disabled. */
  ruleGroupName: string;
  /** The list of rules that will be disabled. If null, all rules of the rule group will be disabled. */
  rules?: number[];
}

/** Allow to exclude some variable satisfy the condition for the WAF check. */
export interface ApplicationGatewayFirewallExclusion {
  /** The variable to be excluded. */
  matchVariable: string;
  /** When matchVariable is a collection, operate on the selector to specify which elements in the collection this exclusion applies to. */
  selectorMatchOperator: string;
  /** When matchVariable is a collection, operator used to specify which elements in the collection this exclusion applies to. */
  selector: string;
}

/** Application Gateway autoscale configuration. */
export interface ApplicationGatewayAutoscaleConfiguration {
  /** Lower bound on number of Application Gateway capacity. */
  minCapacity: number;
  /** Upper bound on number of Application Gateway capacity. */
  maxCapacity?: number;
}

/** Application Gateway global configuration. */
export interface ApplicationGatewayGlobalConfiguration {
  /** Enable request buffering. */
  enableRequestBuffering?: boolean;
  /** Enable response buffering. */
  enableResponseBuffering?: boolean;
}

/** Identity for the resource. */
export interface ManagedServiceIdentity {
  /**
   * The principal id of the system assigned identity. This property will only be provided for a system assigned identity.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly principalId?: string;
  /**
   * The tenant id of the system assigned identity. This property will only be provided for a system assigned identity.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly tenantId?: string;
  /** The type of identity used for the resource. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine. */
  type?: ResourceIdentityType;
  /** The list of user identities associated with resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'. */
  userAssignedIdentities?: {
    [propertyName: string]: Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties;
  };
}

export interface Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties {
  /**
   * The principal id of user assigned identity.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly principalId?: string;
  /**
   * The client id of user assigned identity.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly clientId?: string;
}

/** Tags object for patch operations. */
export interface TagsObject {
  /** Resource tags. */
  tags?: { [propertyName: string]: string };
}

/** Response for ListApplicationGateways API service call. */
export interface ApplicationGatewayListResult {
  /** List of an application gateways in a resource group. */
  value?: ApplicationGateway[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ApplicationGatewayBackendHealth API service call. */
export interface ApplicationGatewayBackendHealth {
  /** A list of ApplicationGatewayBackendHealthPool resources. */
  backendAddressPools?: ApplicationGatewayBackendHealthPool[];
}

/** Application gateway BackendHealth pool. */
export interface ApplicationGatewayBackendHealthPool {
  /** Reference to an ApplicationGatewayBackendAddressPool resource. */
  backendAddressPool?: ApplicationGatewayBackendAddressPool;
  /** List of ApplicationGatewayBackendHealthHttpSettings resources. */
  backendHttpSettingsCollection?: ApplicationGatewayBackendHealthHttpSettings[];
}

/** Application gateway BackendHealthHttp settings. */
export interface ApplicationGatewayBackendHealthHttpSettings {
  /** Reference to an ApplicationGatewayBackendHttpSettings resource. */
  backendHttpSettings?: ApplicationGatewayBackendHttpSettings;
  /** List of ApplicationGatewayBackendHealthServer resources. */
  servers?: ApplicationGatewayBackendHealthServer[];
}

/** Application gateway backendhealth http settings. */
export interface ApplicationGatewayBackendHealthServer {
  /** IP address or FQDN of backend server. */
  address?: string;
  /** Reference to IP configuration of backend server. */
  ipConfiguration?: NetworkInterfaceIPConfiguration;
  /** Health of backend server. */
  health?: ApplicationGatewayBackendHealthServerHealth;
  /** Health Probe Log. */
  healthProbeLog?: string;
}

/** Details of on demand test probe request. */
export interface ApplicationGatewayOnDemandProbe {
  /** The protocol used for the probe. */
  protocol?: ApplicationGatewayProtocol;
  /** Host name to send the probe to. */
  host?: string;
  /** Relative path of probe. Valid path starts from '/'. Probe is sent to <Protocol>://<host>:<port><path>. */
  path?: string;
  /** The probe timeout in seconds. Probe marked as failed if valid response is not received with this timeout period. Acceptable values are from 1 second to 86400 seconds. */
  timeout?: number;
  /** Whether the host header should be picked from the backend http settings. Default value is false. */
  pickHostNameFromBackendHttpSettings?: boolean;
  /** Criterion for classifying a healthy probe response. */
  match?: ApplicationGatewayProbeHealthResponseMatch;
  /** Reference to backend pool of application gateway to which probe request will be sent. */
  backendAddressPool?: SubResource;
  /** Reference to backend http setting of application gateway to be used for test probe. */
  backendHttpSettings?: SubResource;
}

/** Result of on demand test probe. */
export interface ApplicationGatewayBackendHealthOnDemand {
  /** Reference to an ApplicationGatewayBackendAddressPool resource. */
  backendAddressPool?: ApplicationGatewayBackendAddressPool;
  /** Application gateway BackendHealthHttp settings. */
  backendHealthHttpSettings?: ApplicationGatewayBackendHealthHttpSettings;
}

/** Response for ListApplicationGatewayPrivateLinkResources API service call. Gets all private link resources for an application gateway. */
export interface ApplicationGatewayPrivateLinkResourceListResult {
  /** List of private link resources of an application gateway. */
  value?: ApplicationGatewayPrivateLinkResource[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListApplicationGatewayPrivateEndpointConnection API service call. Gets all private endpoint connections for an application gateway. */
export interface ApplicationGatewayPrivateEndpointConnectionListResult {
  /** List of private endpoint connections on an application gateway. */
  value?: ApplicationGatewayPrivateEndpointConnection[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Common error representation. */
export interface ErrorModel {
  /** Error code. */
  code?: string;
  /** Error message. */
  message?: string;
  /** Error target. */
  target?: string;
  /** Error details. */
  details?: ErrorDetails[];
  /** Inner error message. */
  innerError?: string;
}

/** Common error details representation. */
export interface ErrorDetails {
  /** Error code. */
  code?: string;
  /** Error target. */
  target?: string;
  /** Error message. */
  message?: string;
}

/** Response for ApplicationGatewayAvailableWafRuleSets API service call. */
export interface ApplicationGatewayAvailableWafRuleSetsResult {
  /** The list of application gateway rule sets. */
  value?: ApplicationGatewayFirewallRuleSet[];
}

/** A web application firewall rule group. */
export interface ApplicationGatewayFirewallRuleGroup {
  /** The name of the web application firewall rule group. */
  ruleGroupName: string;
  /** The description of the web application firewall rule group. */
  description?: string;
  /** The rules of the web application firewall rule group. */
  rules: ApplicationGatewayFirewallRule[];
}

/** A web application firewall rule. */
export interface ApplicationGatewayFirewallRule {
  /** The identifier of the web application firewall rule. */
  ruleId: number;
  /** The description of the web application firewall rule. */
  description?: string;
}

/** Response for ApplicationGatewayAvailableSslOptions API service call. */
export interface ApplicationGatewayAvailableSslPredefinedPolicies {
  /** List of available Ssl predefined policy. */
  value?: ApplicationGatewaySslPredefinedPolicy[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** A list of application security groups. */
export interface ApplicationSecurityGroupListResult {
  /** A list of application security groups. */
  value?: ApplicationSecurityGroup[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** An array of available delegations. */
export interface AvailableDelegationsResult {
  /** An array of available delegations. */
  value?: AvailableDelegation[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** The serviceName of an AvailableDelegation indicates a possible delegation for a subnet. */
export interface AvailableDelegation {
  /** The name of the AvailableDelegation resource. */
  name?: string;
  /** A unique identifier of the AvailableDelegation resource. */
  id?: string;
  /** Resource type. */
  type?: string;
  /** The name of the service and resource. */
  serviceName?: string;
  /** The actions permitted to the service upon delegation. */
  actions?: string[];
}

/** An array of available service aliases. */
export interface AvailableServiceAliasesResult {
  /** An array of available service aliases. */
  value?: AvailableServiceAlias[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** The available service alias. */
export interface AvailableServiceAlias {
  /** The name of the service alias. */
  name?: string;
  /** The ID of the service alias. */
  id?: string;
  /** The type of the resource. */
  type?: string;
  /** The resource name of the service alias. */
  resourceName?: string;
}

/** Properties of the AzureFirewallRCAction. */
export interface AzureFirewallRCAction {
  /** The type of action. */
  type?: AzureFirewallRCActionType;
}

/** Properties of an application rule. */
export interface AzureFirewallApplicationRule {
  /** Name of the application rule. */
  name?: string;
  /** Description of the rule. */
  description?: string;
  /** List of source IP addresses for this rule. */
  sourceAddresses?: string[];
  /** Array of ApplicationRuleProtocols. */
  protocols?: AzureFirewallApplicationRuleProtocol[];
  /** List of FQDNs for this rule. */
  targetFqdns?: string[];
  /** List of FQDN Tags for this rule. */
  fqdnTags?: string[];
  /** List of source IpGroups for this rule. */
  sourceIpGroups?: string[];
}

/** Properties of the application rule protocol. */
export interface AzureFirewallApplicationRuleProtocol {
  /** Protocol type. */
  protocolType?: AzureFirewallApplicationRuleProtocolType;
  /** Port number for the protocol, cannot be greater than 64000. This field is optional. */
  port?: number;
}

/** AzureFirewall NAT Rule Collection Action. */
export interface AzureFirewallNatRCAction {
  /** The type of action. */
  type?: AzureFirewallNatRCActionType;
}

/** Properties of a NAT rule. */
export interface AzureFirewallNatRule {
  /** Name of the NAT rule. */
  name?: string;
  /** Description of the rule. */
  description?: string;
  /** List of source IP addresses for this rule. */
  sourceAddresses?: string[];
  /** List of destination IP addresses for this rule. Supports IP ranges, prefixes, and service tags. */
  destinationAddresses?: string[];
  /** List of destination ports. */
  destinationPorts?: string[];
  /** Array of AzureFirewallNetworkRuleProtocols applicable to this NAT rule. */
  protocols?: AzureFirewallNetworkRuleProtocol[];
  /** The translated address for this NAT rule. */
  translatedAddress?: string;
  /** The translated port for this NAT rule. */
  translatedPort?: string;
  /** The translated FQDN for this NAT rule. */
  translatedFqdn?: string;
  /** List of source IpGroups for this rule. */
  sourceIpGroups?: string[];
}

/** Properties of the network rule. */
export interface AzureFirewallNetworkRule {
  /** Name of the network rule. */
  name?: string;
  /** Description of the rule. */
  description?: string;
  /** Array of AzureFirewallNetworkRuleProtocols. */
  protocols?: AzureFirewallNetworkRuleProtocol[];
  /** List of source IP addresses for this rule. */
  sourceAddresses?: string[];
  /** List of destination IP addresses. */
  destinationAddresses?: string[];
  /** List of destination ports. */
  destinationPorts?: string[];
  /** List of destination FQDNs. */
  destinationFqdns?: string[];
  /** List of source IpGroups for this rule. */
  sourceIpGroups?: string[];
  /** List of destination IpGroups for this rule. */
  destinationIpGroups?: string[];
}

/** IP addresses associated with azure firewall. */
export interface HubIPAddresses {
  /** Public IP addresses associated with azure firewall. */
  publicIPs?: HubPublicIPAddresses;
  /** Private IP Address associated with azure firewall. */
  privateIPAddress?: string;
}

/** Public IP addresses associated with azure firewall. */
export interface HubPublicIPAddresses {
  /** The list of Public IP addresses associated with azure firewall or IP addresses to be retained. */
  addresses?: AzureFirewallPublicIPAddress[];
  /** The number of Public IP addresses associated with azure firewall. */
  count?: number;
}

/** Public IP Address associated with azure firewall. */
export interface AzureFirewallPublicIPAddress {
  /** Public IP Address value. */
  address?: string;
}

/** IpGroups associated with azure firewall. */
export interface AzureFirewallIpGroups {
  /**
   * Resource ID.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * The iteration number.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly changeNumber?: string;
}

/** SKU of an Azure Firewall. */
export interface AzureFirewallSku {
  /** Name of an Azure Firewall SKU. */
  name?: AzureFirewallSkuName;
  /** Tier of an Azure Firewall. */
  tier?: AzureFirewallSkuTier;
}

/** Response for ListAzureFirewalls API service call. */
export interface AzureFirewallListResult {
  /** List of Azure Firewalls in a resource group. */
  value?: AzureFirewall[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** List of SNAT IP Prefixes learnt by firewall to not SNAT */
export interface IPPrefixesList {
  /** IP Prefix value. */
  ipPrefixes?: string[];
}

/** Response for ListAzureFirewallFqdnTags API service call. */
export interface AzureFirewallFqdnTagListResult {
  /** List of Azure Firewall FQDN Tags in a resource group. */
  value?: AzureFirewallFqdnTag[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Azure Web Category Resource. */
export interface AzureWebCategory {
  /** Resource ID. */
  id?: string;
  /**
   * Resource name.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The name of the group that the category belongs to.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly group?: string;
}

/** Response for ListAzureWebCategories API service call. */
export interface AzureWebCategoryListResult {
  /** List of Azure Web Categories for a given Subscription. */
  value?: AzureWebCategory[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** The sku of this Bastion Host. */
export interface Sku {
  /** The name of this Bastion Host. */
  name?: BastionHostSkuName;
}

/** Response for ListBastionHosts API service call. */
export interface BastionHostListResult {
  /** List of Bastion Hosts in a resource group. */
  value?: BastionHost[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Post request for all the Bastion Shareable Link endpoints. */
export interface BastionShareableLinkListRequest {
  /** List of VM references. */
  vms?: BastionShareableLink[];
}

/** Bastion Shareable Link. */
export interface BastionShareableLink {
  /** Reference of the virtual machine resource. */
  vm: Vm;
  /**
   * The unique Bastion Shareable Link to the virtual machine.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly bsl?: string;
  /**
   * The time when the link was created.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly createdAt?: string;
  /**
   * Optional field indicating the warning or error message related to the vm in case of partial failure.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly message?: string;
}

/** Response for all the Bastion Shareable Link endpoints. */
export interface BastionShareableLinkListResult {
  /** List of Bastion Shareable Links for the request. */
  value?: BastionShareableLink[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for GetActiveSessions. */
export interface BastionActiveSessionListResult {
  /** List of active sessions on the bastion. */
  value?: BastionActiveSession[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** The session detail for a target. */
export interface BastionActiveSession {
  /**
   * A unique id for the session.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sessionId?: string;
  /**
   * The time when the session started.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly startTime?: Record<string, unknown>;
  /**
   * The subscription id for the target virtual machine.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly targetSubscriptionId?: string;
  /**
   * The type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceType?: string;
  /**
   * The host name of the target.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly targetHostName?: string;
  /**
   * The resource group of the target.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly targetResourceGroup?: string;
  /**
   * The user name who is active on this session.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly userName?: string;
  /**
   * The IP Address of the target.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly targetIpAddress?: string;
  /**
   * The protocol used to connect to the target.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly protocol?: BastionConnectProtocol;
  /**
   * The resource id of the target.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly targetResourceId?: string;
  /**
   * Duration in mins the session has been active.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sessionDurationInMins?: number;
}

/** List of session IDs. */
export interface SessionIds {
  /** List of session IDs. */
  sessionIds?: string[];
}

/** Response for DisconnectActiveSessions. */
export interface BastionSessionDeleteResult {
  /** List of sessions with their corresponding state. */
  value?: BastionSessionState[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** The session state detail for a target. */
export interface BastionSessionState {
  /**
   * A unique id for the session.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sessionId?: string;
  /**
   * Used for extra information.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly message?: string;
  /**
   * The state of the session. Disconnected/Failed/NotFound.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly state?: string;
}

/** Response for the CheckDnsNameAvailability API service call. */
export interface DnsNameAvailabilityResult {
  /** Domain availability (True/False). */
  available?: boolean;
}

/** Response for the ListNetworkInterface API service call. */
export interface NetworkInterfaceListResult {
  /** A list of network interfaces in a resource group. */
  value?: NetworkInterface[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListPublicIpAddresses API service call. */
export interface PublicIPAddressListResult {
  /** A list of public IP addresses that exists in a resource group. */
  value?: PublicIPAddress[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListCustomIpPrefixes API service call. */
export interface CustomIpPrefixListResult {
  /** A list of Custom IP prefixes that exists in a resource group. */
  value?: CustomIpPrefix[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** DDoS custom policy properties. */
export interface ProtocolCustomSettingsFormat {
  /** The protocol for which the DDoS protection policy is being customized. */
  protocol?: DdosCustomPolicyProtocol;
  /** The customized DDoS protection trigger rate. */
  triggerRateOverride?: string;
  /** The customized DDoS protection source rate. */
  sourceRateOverride?: string;
  /** The customized DDoS protection trigger rate sensitivity degrees. High: Trigger rate set with most sensitivity w.r.t. normal traffic. Default: Trigger rate set with moderate sensitivity w.r.t. normal traffic. Low: Trigger rate set with less sensitivity w.r.t. normal traffic. Relaxed: Trigger rate set with least sensitivity w.r.t. normal traffic. */
  triggerSensitivityOverride?: DdosCustomPolicyTriggerSensitivityOverride;
}

/** A DDoS protection plan in a resource group. */
export interface DdosProtectionPlan {
  /**
   * Resource ID.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * Resource name.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Resource location. */
  location?: string;
  /** Resource tags. */
  tags?: { [propertyName: string]: string };
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The resource GUID property of the DDoS protection plan resource. It uniquely identifies the resource, even if the user changes its name or migrate the resource across subscriptions or resource groups.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the DDoS protection plan resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The list of virtual networks associated with the DDoS protection plan resource. This list is read-only.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly virtualNetworks?: SubResource[];
}

/** A list of DDoS protection plans. */
export interface DdosProtectionPlanListResult {
  /** A list of DDoS protection plans. */
  value?: DdosProtectionPlan[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Qos Traffic Profiler IP Range properties. */
export interface QosIpRange {
  /** Start IP Address. */
  startIP?: string;
  /** End IP Address. */
  endIP?: string;
}

/** Qos Traffic Profiler Port range properties. */
export interface QosPortRange {
  /** Qos Port Range start. */
  start?: number;
  /** Qos Port Range end. */
  end?: number;
}

/** Quality of Service defines the traffic configuration between endpoints. Mandatory to have one marking. */
export interface QosDefinition {
  /** List of markings to be used in the configuration. */
  markings?: number[];
  /** Source IP ranges. */
  sourceIpRanges?: QosIpRange[];
  /** Destination IP ranges. */
  destinationIpRanges?: QosIpRange[];
  /** Sources port ranges. */
  sourcePortRanges?: QosPortRange[];
  /** Destination port ranges. */
  destinationPortRanges?: QosPortRange[];
  /** RNM supported protocol types. */
  protocol?: ProtocolType;
}

/** Response for the DscpConfigurationList API service call. */
export interface DscpConfigurationListResult {
  /** A list of dscp configurations in a resource group. */
  value?: DscpConfiguration[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for the ListAvailableEndpointServices API service call. */
export interface EndpointServicesListResult {
  /** List of available endpoint services in a region. */
  value?: EndpointServiceResult[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListAuthorizations API service call retrieves all authorizations that belongs to an ExpressRouteCircuit. */
export interface AuthorizationListResult {
  /** The authorizations in an ExpressRoute Circuit. */
  value?: ExpressRouteCircuitAuthorization[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Specifies the peering configuration. */
export interface ExpressRouteCircuitPeeringConfig {
  /** The reference to AdvertisedPublicPrefixes. */
  advertisedPublicPrefixes?: string[];
  /** The communities of bgp peering. Specified for microsoft peering. */
  advertisedCommunities?: string[];
  /**
   * The advertised public prefix state of the Peering resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly advertisedPublicPrefixesState?: ExpressRouteCircuitPeeringAdvertisedPublicPrefixState;
  /** The legacy mode of the peering. */
  legacyMode?: number;
  /** The CustomerASN of the peering. */
  customerASN?: number;
  /** The RoutingRegistryName of the configuration. */
  routingRegistryName?: string;
}

/** Contains stats associated with the peering. */
export interface ExpressRouteCircuitStats {
  /** The Primary BytesIn of the peering. */
  primarybytesIn?: number;
  /** The primary BytesOut of the peering. */
  primarybytesOut?: number;
  /** The secondary BytesIn of the peering. */
  secondarybytesIn?: number;
  /** The secondary BytesOut of the peering. */
  secondarybytesOut?: number;
}

/** Contains IPv6 peering config. */
export interface Ipv6ExpressRouteCircuitPeeringConfig {
  /** The primary address prefix. */
  primaryPeerAddressPrefix?: string;
  /** The secondary address prefix. */
  secondaryPeerAddressPrefix?: string;
  /** The Microsoft peering configuration. */
  microsoftPeeringConfig?: ExpressRouteCircuitPeeringConfig;
  /** The reference to the RouteFilter resource. */
  routeFilter?: SubResource;
  /** The state of peering. */
  state?: ExpressRouteCircuitPeeringState;
}

/** The ID of the ExpressRouteConnection. */
export interface ExpressRouteConnectionId {
  /**
   * The ID of the ExpressRouteConnection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
}

/** IPv6 Circuit Connection properties for global reach. */
export interface Ipv6CircuitConnectionConfig {
  /** /125 IP address space to carve out customer addresses for global reach. */
  addressPrefix?: string;
  /**
   * Express Route Circuit connection state.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly circuitConnectionStatus?: CircuitConnectionStatus;
}

/** Response for ListPeering API service call retrieves all peerings that belong to an ExpressRouteCircuit. */
export interface ExpressRouteCircuitPeeringListResult {
  /** The peerings in an express route circuit. */
  value?: ExpressRouteCircuitPeering[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListConnections API service call retrieves all global reach connections that belongs to a Private Peering for an ExpressRouteCircuit. */
export interface ExpressRouteCircuitConnectionListResult {
  /** The global reach connection associated with Private Peering in an ExpressRoute Circuit. */
  value?: ExpressRouteCircuitConnection[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListPeeredConnections API service call retrieves all global reach peer circuit connections that belongs to a Private Peering for an ExpressRouteCircuit. */
export interface PeerExpressRouteCircuitConnectionListResult {
  /** The global reach peer circuit connection associated with Private Peering in an ExpressRoute Circuit. */
  value?: PeerExpressRouteCircuitConnection[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Contains SKU in an ExpressRouteCircuit. */
export interface ExpressRouteCircuitSku {
  /** The name of the SKU. */
  name?: string;
  /** The tier of the SKU. */
  tier?: ExpressRouteCircuitSkuTier;
  /** The family of the SKU. */
  family?: ExpressRouteCircuitSkuFamily;
}

/** Contains ServiceProviderProperties in an ExpressRouteCircuit. */
export interface ExpressRouteCircuitServiceProviderProperties {
  /** The serviceProviderName. */
  serviceProviderName?: string;
  /** The peering location. */
  peeringLocation?: string;
  /** The BandwidthInMbps. */
  bandwidthInMbps?: number;
}

/** Response for ListArpTable associated with the Express Route Circuits API. */
export interface ExpressRouteCircuitsArpTableListResult {
  /** A list of the ARP tables. */
  value?: ExpressRouteCircuitArpTable[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** The ARP table associated with the ExpressRouteCircuit. */
export interface ExpressRouteCircuitArpTable {
  /** Entry age in minutes. */
  age?: number;
  /** Interface address. */
  interface?: string;
  /** The IP address. */
  ipAddress?: string;
  /** The MAC address. */
  macAddress?: string;
}

/** Response for ListRoutesTable associated with the Express Route Circuits API. */
export interface ExpressRouteCircuitsRoutesTableListResult {
  /** The list of routes table. */
  value?: ExpressRouteCircuitRoutesTable[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** The routes table associated with the ExpressRouteCircuit. */
export interface ExpressRouteCircuitRoutesTable {
  /** IP address of a network entity. */
  network?: string;
  /** NextHop address. */
  nextHop?: string;
  /** Local preference value as set with the set local-preference route-map configuration command. */
  locPrf?: string;
  /** Route Weight. */
  weight?: number;
  /** Autonomous system paths to the destination network. */
  path?: string;
}

/** Response for ListRoutesTable associated with the Express Route Circuits API. */
export interface ExpressRouteCircuitsRoutesTableSummaryListResult {
  /** A list of the routes table. */
  value?: ExpressRouteCircuitRoutesTableSummary[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** The routes table associated with the ExpressRouteCircuit. */
export interface ExpressRouteCircuitRoutesTableSummary {
  /** IP address of the neighbor. */
  neighbor?: string;
  /** BGP version number spoken to the neighbor. */
  v?: number;
  /** Autonomous system number. */
  as?: number;
  /** The length of time that the BGP session has been in the Established state, or the current status if not in the Established state. */
  upDown?: string;
  /** Current state of the BGP session, and the number of prefixes that have been received from a neighbor or peer group. */
  statePfxRcd?: string;
}

/** Response for ListExpressRouteCircuit API service call. */
export interface ExpressRouteCircuitListResult {
  /** A list of ExpressRouteCircuits in a resource group. */
  value?: ExpressRouteCircuit[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for the ListExpressRouteServiceProvider API service call. */
export interface ExpressRouteServiceProviderListResult {
  /** A list of ExpressRouteResourceProvider resources. */
  value?: ExpressRouteServiceProvider[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Contains bandwidths offered in ExpressRouteServiceProvider resources. */
export interface ExpressRouteServiceProviderBandwidthsOffered {
  /** The OfferName. */
  offerName?: string;
  /** The ValueInMbps. */
  valueInMbps?: number;
}

/** Response for ListExpressRouteCrossConnection API service call. */
export interface ExpressRouteCrossConnectionListResult {
  /** A list of ExpressRouteCrossConnection resources. */
  value?: ExpressRouteCrossConnection[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Reference to an express route circuit. */
export interface ExpressRouteCircuitReference {
  /** Corresponding Express Route Circuit Id. */
  id?: string;
}

/** Response for ListPeering API service call retrieves all peerings that belong to an ExpressRouteCrossConnection. */
export interface ExpressRouteCrossConnectionPeeringList {
  /** The peerings in an express route cross connection. */
  value?: ExpressRouteCrossConnectionPeering[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListRoutesTable associated with the Express Route Cross Connections. */
export interface ExpressRouteCrossConnectionsRoutesTableSummaryListResult {
  /** A list of the routes table. */
  value?: ExpressRouteCrossConnectionRoutesTableSummary[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** The routes table associated with the ExpressRouteCircuit. */
export interface ExpressRouteCrossConnectionRoutesTableSummary {
  /** IP address of Neighbor router. */
  neighbor?: string;
  /** Autonomous system number. */
  asn?: number;
  /** The length of time that the BGP session has been in the Established state, or the current status if not in the Established state. */
  upDown?: string;
  /** Current state of the BGP session, and the number of prefixes that have been received from a neighbor or peer group. */
  stateOrPrefixesReceived?: string;
}

/** Response for ListExpressRoutePortsLocations API service call. */
export interface ExpressRoutePortsLocationListResult {
  /** The list of all ExpressRoutePort peering locations. */
  value?: ExpressRoutePortsLocation[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Real-time inventory of available ExpressRoute port bandwidths. */
export interface ExpressRoutePortsLocationBandwidths {
  /**
   * Bandwidth descriptive name.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly offerName?: string;
  /**
   * Bandwidth value in Gbps.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly valueInGbps?: number;
}

/** ExpressRouteLink Mac Security Configuration. */
export interface ExpressRouteLinkMacSecConfig {
  /** Keyvault Secret Identifier URL containing Mac security CKN key. */
  cknSecretIdentifier?: string;
  /** Keyvault Secret Identifier URL containing Mac security CAK key. */
  cakSecretIdentifier?: string;
  /** Mac security cipher. */
  cipher?: ExpressRouteLinkMacSecCipher;
  /** Sci mode enabled/disabled. */
  sciState?: ExpressRouteLinkMacSecSciState;
}

/** Response for ListExpressRoutePorts API service call. */
export interface ExpressRoutePortListResult {
  /** A list of ExpressRoutePort resources. */
  value?: ExpressRoutePort[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListExpressRouteLinks API service call. */
export interface ExpressRouteLinkListResult {
  /** The list of ExpressRouteLink sub-resources. */
  value?: ExpressRouteLink[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** The customer name to be printed on a letter of authorization. */
export interface GenerateExpressRoutePortsLOARequest {
  /** The customer name. */
  customerName: string;
}

/** Response for GenerateExpressRoutePortsLOA API service call. */
export interface GenerateExpressRoutePortsLOAResult {
  /** The content as a base64 encoded string. */
  encodedContent?: string;
}

/** Response for ListExpressRoutePortAuthorizations API service call. */
export interface ExpressRoutePortAuthorizationListResult {
  /** The authorizations in an ExpressRoute Port. */
  value?: ExpressRoutePortAuthorization[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListExpressRouteProviderPort API service call. */
export interface ExpressRouteProviderPortListResult {
  /** A list of ExpressRouteProviderPort resources. */
  value?: ExpressRouteProviderPort[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** ThreatIntel Whitelist for Firewall Policy. */
export interface FirewallPolicyThreatIntelWhitelist {
  /** List of IP addresses for the ThreatIntel Whitelist. */
  ipAddresses?: string[];
  /** List of FQDNs for the ThreatIntel Whitelist. */
  fqdns?: string[];
}

/** Firewall Policy Insights. */
export interface FirewallPolicyInsights {
  /** A flag to indicate if the insights are enabled on the policy. */
  isEnabled?: boolean;
  /** Number of days the insights should be enabled on the policy. */
  retentionDays?: number;
  /** Workspaces needed to configure the Firewall Policy Insights. */
  logAnalyticsResources?: FirewallPolicyLogAnalyticsResources;
}

/** Log Analytics Resources for Firewall Policy Insights. */
export interface FirewallPolicyLogAnalyticsResources {
  /** List of workspaces for Firewall Policy Insights. */
  workspaces?: FirewallPolicyLogAnalyticsWorkspace[];
  /** The default workspace Id for Firewall Policy Insights. */
  defaultWorkspaceId?: SubResource;
}

/** Log Analytics Workspace for Firewall Policy Insights. */
export interface FirewallPolicyLogAnalyticsWorkspace {
  /** Region to configure the Workspace. */
  region?: string;
  /** The workspace Id for Firewall Policy Insights. */
  workspaceId?: SubResource;
}

/** The private IP addresses/IP ranges to which traffic will not be SNAT. */
export interface FirewallPolicySnat {
  /** List of private IP addresses/IP address ranges to not be SNAT. */
  privateRanges?: string[];
  /** The operation mode for automatically learning private ranges to not be SNAT */
  autoLearnPrivateRanges?: AutoLearnPrivateRangesMode;
}

/** SQL Settings in Firewall Policy. */
export interface FirewallPolicySQL {
  /** A flag to indicate if SQL Redirect traffic filtering is enabled. Turning on the flag requires no rule using port 11000-11999. */
  allowSqlRedirect?: boolean;
}

/** DNS Proxy Settings in Firewall Policy. */
export interface DnsSettings {
  /** List of Custom DNS Servers. */
  servers?: string[];
  /** Enable DNS Proxy on Firewalls attached to the Firewall Policy. */
  enableProxy?: boolean;
  /** FQDNs in Network Rules are supported when set to true. */
  requireProxyForNetworkRules?: boolean;
}

/** Explicit Proxy Settings in Firewall Policy. */
export interface ExplicitProxy {
  /** When set to true, explicit proxy mode is enabled. */
  enableExplicitProxy?: boolean;
  /** Port number for explicit proxy http protocol, cannot be greater than 64000. */
  httpPort?: number;
  /** Port number for explicit proxy https protocol, cannot be greater than 64000. */
  httpsPort?: number;
  /** When set to true, pac file port and url needs to be provided. */
  enablePacFile?: boolean;
  /** Port number for firewall to serve PAC file. */
  pacFilePort?: number;
  /** SAS URL for PAC file. */
  pacFile?: string;
}

/** Configuration for intrusion detection mode and rules. */
export interface FirewallPolicyIntrusionDetection {
  /** Intrusion detection general state. */
  mode?: FirewallPolicyIntrusionDetectionStateType;
  /** Intrusion detection configuration properties. */
  configuration?: FirewallPolicyIntrusionDetectionConfiguration;
}

/** The operation for configuring intrusion detection. */
export interface FirewallPolicyIntrusionDetectionConfiguration {
  /** List of specific signatures states. */
  signatureOverrides?: FirewallPolicyIntrusionDetectionSignatureSpecification[];
  /** List of rules for traffic to bypass. */
  bypassTrafficSettings?: FirewallPolicyIntrusionDetectionBypassTrafficSpecifications[];
  /** IDPS Private IP address ranges are used to identify traffic direction (i.e. inbound, outbound, etc.). By default, only ranges defined by IANA RFC 1918 are considered private IP addresses. To modify default ranges, specify your Private IP address ranges with this property */
  privateRanges?: string[];
}

/** Intrusion detection signatures specification states. */
export interface FirewallPolicyIntrusionDetectionSignatureSpecification {
  /** Signature id. */
  id?: string;
  /** The signature state. */
  mode?: FirewallPolicyIntrusionDetectionStateType;
}

/** Intrusion detection bypass traffic specification. */
export interface FirewallPolicyIntrusionDetectionBypassTrafficSpecifications {
  /** Name of the bypass traffic rule. */
  name?: string;
  /** Description of the bypass traffic rule. */
  description?: string;
  /** The rule bypass protocol. */
  protocol?: FirewallPolicyIntrusionDetectionProtocol;
  /** List of source IP addresses or ranges for this rule. */
  sourceAddresses?: string[];
  /** List of destination IP addresses or ranges for this rule. */
  destinationAddresses?: string[];
  /** List of destination ports or ranges. */
  destinationPorts?: string[];
  /** List of source IpGroups for this rule. */
  sourceIpGroups?: string[];
  /** List of destination IpGroups for this rule. */
  destinationIpGroups?: string[];
}

/** Configuration needed to perform TLS termination & initiation. */
export interface FirewallPolicyTransportSecurity {
  /** The CA used for intermediate CA generation. */
  certificateAuthority?: FirewallPolicyCertificateAuthority;
}

/** Trusted Root certificates properties for tls. */
export interface FirewallPolicyCertificateAuthority {
  /** Secret Id of (base-64 encoded unencrypted pfx) 'Secret' or 'Certificate' object stored in KeyVault. */
  keyVaultSecretId?: string;
  /** Name of the CA certificate. */
  name?: string;
}

/** SKU of Firewall policy. */
export interface FirewallPolicySku {
  /** Tier of Firewall Policy. */
  tier?: FirewallPolicySkuTier;
}

/** Response for ListFirewallPolicies API service call. */
export interface FirewallPolicyListResult {
  /** List of Firewall Policies in a resource group. */
  value?: FirewallPolicy[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Properties of the rule collection. */
export interface FirewallPolicyRuleCollection {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  ruleCollectionType:
    | "FirewallPolicyNatRuleCollection"
    | "FirewallPolicyFilterRuleCollection";
  /** The name of the rule collection. */
  name?: string;
  /** Priority of the Firewall Policy Rule Collection resource. */
  priority?: number;
}

/** Response for ListFirewallPolicyRuleCollectionGroups API service call. */
export interface FirewallPolicyRuleCollectionGroupListResult {
  /** List of FirewallPolicyRuleCollectionGroups in a FirewallPolicy. */
  value?: FirewallPolicyRuleCollectionGroup[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Will describe the query to run against the IDPS signatures DB */
export interface IdpsQueryObject {
  /** Contain all filters names and values */
  filters?: FilterItems[];
  /** Search term in all columns */
  search?: string;
  /** Column to sort response by */
  orderBy?: OrderBy;
  /** The number of the results to return in each page */
  resultsPerPage?: number;
  /** The number of records matching the filter to skip */
  skip?: number;
}

/** Will contain the filter name and values to operate on */
export interface FilterItems {
  /** The name of the field we would like to filter */
  field?: string;
  /** List of values to filter the current field by */
  values?: string[];
}

/** Describes a column to sort */
export interface OrderBy {
  /** Describes the actual column name to sort by */
  field?: string;
  /** Describes if results should be in ascending/descending order */
  order?: FirewallPolicyIdpsQuerySortOrder;
}

/** Query result */
export interface QueryResults {
  /** Number of total records matching the query. */
  matchingRecordsCount?: number;
  /** Array containing the results of the query */
  signatures?: SingleQueryResult[];
}

export interface SingleQueryResult {
  /** The ID of the signature */
  signatureId?: number;
  /** The current mode enforced, 0 - Disabled, 1 - Alert, 2 -Deny */
  mode?: FirewallPolicyIdpsSignatureMode;
  /** Describes the severity of signature: 1 - Low, 2 - Medium, 3 - High */
  severity?: FirewallPolicyIdpsSignatureSeverity;
  /** Describes in which direction signature is being enforced: 0 - Inbound, 1 - OutBound, 2 - Bidirectional */
  direction?: FirewallPolicyIdpsSignatureDirection;
  /** Describes the groups the signature belongs to */
  group?: string;
  /** Describes what is the signature enforces */
  description?: string;
  /** Describes the protocol the signatures is being enforced in */
  protocol?: string;
  /** Describes the list of source ports related to this signature */
  sourcePorts?: string[];
  /** Describes the list of destination ports related to this signature */
  destinationPorts?: string[];
  /** Describes the last updated time of the signature (provided from 3rd party vendor) */
  lastUpdated?: string;
  /** Describes if this override is inherited from base policy or not */
  inheritedFromParentPolicy?: boolean;
}

/** Contains all specific policy signatures overrides for the IDPS */
export interface SignaturesOverrides {
  /** Contains the name of the resource (default) */
  name?: string;
  /** Will contain the resource id of the signature override resource */
  id?: string;
  /** Will contain the type of the resource: Microsoft.Network/firewallPolicies/intrusionDetectionSignaturesOverrides */
  type?: string;
  /** Will contain the properties of the resource (the actual signature overrides) */
  properties?: SignaturesOverridesProperties;
}

/** Will contain the properties of the resource (the actual signature overrides) */
export interface SignaturesOverridesProperties {
  /** Dictionary of <string> */
  signatures?: { [propertyName: string]: string };
}

/** Describes the filter values possibles for a given column */
export interface SignatureOverridesFilterValuesQuery {
  /** Describes the name of the column which values will be returned */
  filterName?: string;
}

/** Describes the list of all possible values for a specific filter value */
export interface SignatureOverridesFilterValuesResponse {
  /** Describes the possible values */
  filterValues?: string[];
}

/** Describes an object containing an array with a single item */
export interface SignaturesOverridesList {
  /** Describes a list consisting exactly one item describing the policy's signature override status */
  value?: SignaturesOverrides[];
}

/** Response for the ListIpAllocations API service call. */
export interface IpAllocationListResult {
  /** A list of IpAllocation resources. */
  value?: IpAllocation[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for the ListIpGroups API service call. */
export interface IpGroupListResult {
  /** The list of IpGroups information resources. */
  value?: IpGroup[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** SKU of a load balancer. */
export interface LoadBalancerSku {
  /** Name of a load balancer SKU. */
  name?: LoadBalancerSkuName;
  /** Tier of a load balancer SKU. */
  tier?: LoadBalancerSkuTier;
}

/** Response for ListLoadBalancers API service call. */
export interface LoadBalancerListResult {
  /** A list of load balancers in a resource group. */
  value?: LoadBalancer[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListBackendAddressPool API service call. */
export interface LoadBalancerBackendAddressPoolListResult {
  /** A list of backend address pools in a load balancer. */
  value?: BackendAddressPool[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListFrontendIPConfiguration API service call. */
export interface LoadBalancerFrontendIPConfigurationListResult {
  /** A list of frontend IP configurations in a load balancer. */
  value?: FrontendIPConfiguration[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListInboundNatRule API service call. */
export interface InboundNatRuleListResult {
  /** A list of inbound NAT rules in a load balancer. */
  value?: InboundNatRule[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListLoadBalancingRule API service call. */
export interface LoadBalancerLoadBalancingRuleListResult {
  /** A list of load balancing rules in a load balancer. */
  value?: LoadBalancingRule[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListOutboundRule API service call. */
export interface LoadBalancerOutboundRuleListResult {
  /** A list of outbound rules in a load balancer. */
  value?: OutboundRule[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListProbe API service call. */
export interface LoadBalancerProbeListResult {
  /** A list of probes in a load balancer. */
  value?: Probe[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** The request for a VIP swap. */
export interface LoadBalancerVipSwapRequest {
  /** A list of frontend IP configuration resources that should swap VIPs. */
  frontendIPConfigurations?: LoadBalancerVipSwapRequestFrontendIPConfiguration[];
}

/** VIP swap request's frontend IP configuration object. */
export interface LoadBalancerVipSwapRequestFrontendIPConfiguration {
  /** The ID of frontend IP configuration resource. */
  id?: string;
  /** A reference to public IP address resource. */
  publicIPAddress?: SubResource;
}

/** The request for a QueryInboundNatRulePortMapping API. Either IpConfiguration or IpAddress should be set */
export interface QueryInboundNatRulePortMappingRequest {
  /** NetworkInterfaceIPConfiguration set in load balancer backend address. */
  ipConfiguration?: SubResource;
  /** IP address set in load balancer backend address. */
  ipAddress?: string;
}

/** The response for a QueryInboundNatRulePortMapping API. */
export interface BackendAddressInboundNatRulePortMappings {
  /** Collection of inbound NAT rule port mappings. */
  inboundNatRulePortMappings?: InboundNatRulePortMapping[];
}

/** Individual port mappings for inbound NAT rule created for backend pool. */
export interface InboundNatRulePortMapping {
  /**
   * Name of inbound NAT rule.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly inboundNatRuleName?: string;
  /**
   * The reference to the transport protocol used by the inbound NAT rule.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly protocol?: TransportProtocol;
  /**
   * Frontend port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly frontendPort?: number;
  /**
   * Backend port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly backendPort?: number;
}

/** Response for ListNatGateways API service call. */
export interface NatGatewayListResult {
  /** A list of Nat Gateways that exists in a resource group. */
  value?: NatGateway[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for list effective route API service call. */
export interface EffectiveRouteListResult {
  /** A list of effective routes. */
  value?: EffectiveRoute[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Effective Route. */
export interface EffectiveRoute {
  /** The name of the user defined route. This is optional. */
  name?: string;
  /** If true, on-premises routes are not propagated to the network interfaces in the subnet. */
  disableBgpRoutePropagation?: boolean;
  /** Who created the route. */
  source?: EffectiveRouteSource;
  /** The value of effective route. */
  state?: EffectiveRouteState;
  /** The address prefixes of the effective routes in CIDR notation. */
  addressPrefix?: string[];
  /** The IP address of the next hop of the effective route. */
  nextHopIpAddress?: string[];
  /** The type of Azure hop the packet should be sent to. */
  nextHopType?: RouteNextHopType;
}

/** Response for list effective network security groups API service call. */
export interface EffectiveNetworkSecurityGroupListResult {
  /** A list of effective network security groups. */
  value?: EffectiveNetworkSecurityGroup[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Effective network security group. */
export interface EffectiveNetworkSecurityGroup {
  /** The ID of network security group that is applied. */
  networkSecurityGroup?: SubResource;
  /** Associated resources. */
  association?: EffectiveNetworkSecurityGroupAssociation;
  /** A collection of effective security rules. */
  effectiveSecurityRules?: EffectiveNetworkSecurityRule[];
  /** Mapping of tags to list of IP Addresses included within the tag. */
  tagMap?: string;
}

/** The effective network security group association. */
export interface EffectiveNetworkSecurityGroupAssociation {
  /** The ID of the Azure network manager if assigned. */
  networkManager?: SubResource;
  /** The ID of the subnet if assigned. */
  subnet?: SubResource;
  /** The ID of the network interface if assigned. */
  networkInterface?: SubResource;
}

/** Effective network security rules. */
export interface EffectiveNetworkSecurityRule {
  /** The name of the security rule specified by the user (if created by the user). */
  name?: string;
  /** The network protocol this rule applies to. */
  protocol?: EffectiveSecurityRuleProtocol;
  /** The source port or range. */
  sourcePortRange?: string;
  /** The destination port or range. */
  destinationPortRange?: string;
  /** The source port ranges. Expected values include a single integer between 0 and 65535, a range using '-' as separator (e.g. 100-400), or an asterisk (*). */
  sourcePortRanges?: string[];
  /** The destination port ranges. Expected values include a single integer between 0 and 65535, a range using '-' as separator (e.g. 100-400), or an asterisk (*). */
  destinationPortRanges?: string[];
  /** The source address prefix. */
  sourceAddressPrefix?: string;
  /** The destination address prefix. */
  destinationAddressPrefix?: string;
  /** The source address prefixes. Expected values include CIDR IP ranges, Default Tags (VirtualNetwork, AzureLoadBalancer, Internet), System Tags, and the asterisk (*). */
  sourceAddressPrefixes?: string[];
  /** The destination address prefixes. Expected values include CIDR IP ranges, Default Tags (VirtualNetwork, AzureLoadBalancer, Internet), System Tags, and the asterisk (*). */
  destinationAddressPrefixes?: string[];
  /** The expanded source address prefix. */
  expandedSourceAddressPrefix?: string[];
  /** Expanded destination address prefix. */
  expandedDestinationAddressPrefix?: string[];
  /** Whether network traffic is allowed or denied. */
  access?: SecurityRuleAccess;
  /** The priority of the rule. */
  priority?: number;
  /** The direction of the rule. */
  direction?: SecurityRuleDirection;
}

/** Response for list ip configurations API service call. */
export interface NetworkInterfaceIPConfigurationListResult {
  /** A list of ip configurations. */
  value?: NetworkInterfaceIPConfiguration[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for list ip configurations API service call. */
export interface NetworkInterfaceLoadBalancerListResult {
  /** A list of load balancers. */
  value?: LoadBalancer[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for list tap configurations API service call. */
export interface NetworkInterfaceTapConfigurationListResult {
  /** A list of tap configurations. */
  value?: NetworkInterfaceTapConfiguration[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Scope of Network Manager. */
export interface NetworkManagerPropertiesNetworkManagerScopes {
  /** List of management groups. */
  managementGroups?: string[];
  /** List of subscriptions. */
  subscriptions?: string[];
  /**
   * List of cross tenant scopes.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly crossTenantScopes?: CrossTenantScopes[];
}

/** Cross tenant scopes. */
export interface CrossTenantScopes {
  /**
   * Tenant ID.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly tenantId?: string;
  /**
   * List of management groups.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly managementGroups?: string[];
  /**
   * List of subscriptions.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly subscriptions?: string[];
}

/** Metadata pertaining to creation and last modification of the resource. */
export interface SystemData {
  /** The identity that created the resource. */
  createdBy?: string;
  /** The type of identity that created the resource. */
  createdByType?: CreatedByType;
  /** The timestamp of resource creation (UTC). */
  createdAt?: Date;
  /** The identity that last modified the resource. */
  lastModifiedBy?: string;
  /** The type of identity that last modified the resource. */
  lastModifiedByType?: CreatedByType;
  /** The type of identity that last modified the resource. */
  lastModifiedAt?: Date;
}

/** Object for patch operations. */
export interface PatchObject {
  /** Resource tags. */
  tags?: { [propertyName: string]: string };
}

/** Network Manager Commit. */
export interface NetworkManagerCommit {
  /**
   * Commit Id.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly commitId?: string;
  /** List of target locations. */
  targetLocations: string[];
  /** List of configuration ids. */
  configurationIds?: string[];
  /** Commit Type. */
  commitType: ConfigurationType;
}

/** Network Manager Deployment Status Parameter. */
export interface NetworkManagerDeploymentStatusParameter {
  /** List of locations. */
  regions?: string[];
  /** List of deployment types. */
  deploymentTypes?: ConfigurationType[];
  /** Continuation token for pagination, capturing the next page size and offset, as well as the context of the query. */
  skipToken?: string;
}

/** A list of Network Manager Deployment Status */
export interface NetworkManagerDeploymentStatusListResult {
  /** Gets a page of Network Manager Deployment Status */
  value?: NetworkManagerDeploymentStatus[];
  /** When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data. */
  skipToken?: string;
}

/** Network Manager Deployment Status. */
export interface NetworkManagerDeploymentStatus {
  /** Commit Time. */
  commitTime?: Date;
  /** Region Name. */
  region?: string;
  /** Deployment Status. */
  deploymentStatus?: DeploymentStatus;
  /** List of configuration ids. */
  configurationIds?: string[];
  /** Configuration Deployment Type. */
  deploymentType?: ConfigurationType;
  /** Error Message. */
  errorMessage?: string;
}

/** Result of the request to list NetworkManager. It contains a list of network managers and a URL link to get the next set of results. */
export interface NetworkManagerListResult {
  /** Gets a page of NetworkManager */
  value?: NetworkManager[];
  /** Gets the URL to get the next page of results. */
  nextLink?: string;
}

/** Effective Virtual Networks Parameter. */
export interface ActiveConfigurationParameter {
  /** List of regions. */
  regions?: string[];
  /** When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data. */
  skipToken?: string;
}

/** Result of the request to list active connectivity configurations. It contains a list of active connectivity configurations and a skiptoken to get the next set of results. */
export interface ActiveConnectivityConfigurationsListResult {
  /** Gets a page of active connectivity configurations. */
  value?: ActiveConnectivityConfiguration[];
  /** When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data. */
  skipToken?: string;
}

/** The network manager effective connectivity configuration */
export interface EffectiveConnectivityConfiguration {
  /** Connectivity configuration ID. */
  id?: string;
  /** Effective configuration groups. */
  configurationGroups?: ConfigurationGroup[];
  /** A description of the connectivity configuration. */
  description?: string;
  /** Connectivity topology type. */
  connectivityTopology?: ConnectivityTopology;
  /** List of hubItems */
  hubs?: Hub[];
  /** Flag if global mesh is supported. */
  isGlobal?: IsGlobal;
  /** Groups for configuration */
  appliesToGroups?: ConnectivityGroupItem[];
  /**
   * The provisioning state of the connectivity configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Flag if need to remove current existing peerings. */
  deleteExistingPeering?: DeleteExistingPeering;
}

/** Hub Item. */
export interface Hub {
  /** Resource Id. */
  resourceId?: string;
  /** Resource Type. */
  resourceType?: string;
}

/** Connectivity group item. */
export interface ConnectivityGroupItem {
  /** Network group Id. */
  networkGroupId: string;
  /** Flag if need to use hub gateway. */
  useHubGateway?: UseHubGateway;
  /** Flag if global is supported. */
  isGlobal?: IsGlobal;
  /** Group connectivity type. */
  groupConnectivity: GroupConnectivity;
}

/** The network configuration group resource */
export interface ConfigurationGroup {
  /** Network group ID. */
  id?: string;
  /** A description of the network group. */
  description?: string;
  /**
   * The provisioning state of the scope assignment resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Result of the request to list active security admin rules. It contains a list of active security admin rules and a skiptoken to get the next set of results. */
export interface ActiveSecurityAdminRulesListResult {
  /** Gets a page of active security admin rules. */
  value?: ActiveBaseSecurityAdminRuleUnion[];
  /** When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data. */
  skipToken?: string;
}

/** Network base admin rule. */
export interface ActiveBaseSecurityAdminRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  kind: "Custom" | "Default";
  /** Resource ID. */
  id?: string;
  /** Deployment time string. */
  commitTime?: Date;
  /** Deployment region. */
  region?: string;
  /** A description of the security admin configuration. */
  configurationDescription?: string;
  /** A description of the rule collection. */
  ruleCollectionDescription?: string;
  /** Groups for rule collection */
  ruleCollectionAppliesToGroups?: NetworkManagerSecurityGroupItem[];
  /** Effective configuration groups. */
  ruleGroups?: ConfigurationGroup[];
}

/** Network manager security group item. */
export interface NetworkManagerSecurityGroupItem {
  /** Network manager group Id. */
  networkGroupId: string;
}

/** Proxy resource representation. */
export interface ChildResource {
  /**
   * Resource ID.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * Resource name.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
}

/** List of network manager connections. */
export interface NetworkManagerConnectionListResult {
  /** List of network manager connections. */
  value?: NetworkManagerConnection[];
  /** Gets the URL to get the next page of results. */
  nextLink?: string;
}

/** Result of the request to list network manager connectivity configurations. It contains a list of configurations and a link to get the next set of results. */
export interface ConnectivityConfigurationListResult {
  /** Gets a page of Connectivity Configurations */
  value?: ConnectivityConfiguration[];
  /** Gets the URL to get the next page of results. */
  nextLink?: string;
}

/** Query Request Options */
export interface QueryRequestOptions {
  /** When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data. */
  skipToken?: string;
}

/** Result of the request to list networkManagerEffectiveConnectivityConfiguration. It contains a list of groups and a skiptoken to get the next set of results. */
export interface NetworkManagerEffectiveConnectivityConfigurationListResult {
  /** Gets a page of NetworkManagerEffectiveConnectivityConfiguration */
  value?: EffectiveConnectivityConfiguration[];
  /** When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data. */
  skipToken?: string;
}

/** Result of the request to list networkManagerEffectiveSecurityAdminRules. It contains a list of groups and a skiptoken to get the next set of results. */
export interface NetworkManagerEffectiveSecurityAdminRulesListResult {
  /** Gets a page of NetworkManagerEffectiveSecurityAdminRules */
  value?: EffectiveBaseSecurityAdminRuleUnion[];
  /** When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data. */
  skipToken?: string;
}

/** Network base admin rule. */
export interface EffectiveBaseSecurityAdminRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  kind: "Custom" | "Default";
  /** Resource ID. */
  id?: string;
  /** A description of the security admin configuration. */
  configurationDescription?: string;
  /** A description of the rule collection. */
  ruleCollectionDescription?: string;
  /** Groups for rule collection */
  ruleCollectionAppliesToGroups?: NetworkManagerSecurityGroupItem[];
  /** Effective configuration groups. */
  ruleGroups?: ConfigurationGroup[];
}

/** Result of the request to list NetworkGroup. It contains a list of groups and a URL link to get the next set of results. */
export interface NetworkGroupListResult {
  /** Gets a page of NetworkGroup */
  value?: NetworkGroup[];
  /** Gets the URL to get the next set of results. */
  nextLink?: string;
}

/** Result of the request to list StaticMember. It contains a list of groups and a URL link to get the next set of results. */
export interface StaticMemberListResult {
  /** Gets a page of StaticMember */
  value?: StaticMember[];
  /** Gets the URL to get the next set of results. */
  nextLink?: string;
}

/** List of scope connections. */
export interface ScopeConnectionListResult {
  /** List of scope connections. */
  value?: ScopeConnection[];
  /** Gets the URL to get the next page of results. */
  nextLink?: string;
}

/** A list of network manager security admin configurations */
export interface SecurityAdminConfigurationListResult {
  /** Gets a page of security admin configurations */
  value?: SecurityAdminConfiguration[];
  /** Gets the URL to get the next page of results. */
  nextLink?: string;
}

/** Security admin configuration rule collection list result. */
export interface AdminRuleCollectionListResult {
  /** A list of network manager security admin configuration rule collections */
  value?: AdminRuleCollection[];
  /** Gets the URL to get the next set of results. */
  nextLink?: string;
}

/** security configuration admin rule list result. */
export interface AdminRuleListResult {
  /** A list of admin rules */
  value?: BaseAdminRuleUnion[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** The ip configuration for a container network interface. */
export interface ContainerNetworkInterfaceIpConfiguration {
  /** The name of the resource. This name can be used to access the resource. */
  name?: string;
  /**
   * Sub Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The provisioning state of the container network interface IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Response for ListNetworkProfiles API service call. */
export interface NetworkProfileListResult {
  /** A list of network profiles that exist in a resource group. */
  value?: NetworkProfile[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListNetworkSecurityGroups API service call. */
export interface NetworkSecurityGroupListResult {
  /** A list of NetworkSecurityGroup resources. */
  value?: NetworkSecurityGroup[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListSecurityRule API service call. Retrieves all security rules that belongs to a network security group. */
export interface SecurityRuleListResult {
  /** The security rules in a network security group. */
  value?: SecurityRule[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Network Virtual Appliance Sku Properties. */
export interface VirtualApplianceSkuProperties {
  /** Virtual Appliance Vendor. */
  vendor?: string;
  /** Virtual Appliance Scale Unit. */
  bundledScaleUnit?: string;
  /** Virtual Appliance Version. */
  marketPlaceVersion?: string;
}

/** Network Virtual Appliance NIC properties. */
export interface VirtualApplianceNicProperties {
  /**
   * NIC name.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * Public IP address.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly publicIpAddress?: string;
  /**
   * Private IP address.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateIpAddress?: string;
}

/** Response for ListNetworkVirtualAppliances API service call. */
export interface NetworkVirtualApplianceListResult {
  /** List of Network Virtual Appliances. */
  value?: NetworkVirtualAppliance[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Network Virtual Appliance Sku Properties. */
export interface Office365PolicyProperties {
  /** Office 365 breakout categories. */
  breakOutCategories?: BreakOutCategoryPolicies;
}

/** Network Virtual Appliance Sku Properties. */
export interface BreakOutCategoryPolicies {
  /** Flag to control breakout of o365 allow category. */
  allow?: boolean;
  /** Flag to control breakout of o365 optimize category. */
  optimize?: boolean;
  /** Flag to control breakout of o365 default category. */
  default?: boolean;
}

/** Response for ListNetworkVirtualApplianceSites API service call. */
export interface NetworkVirtualApplianceSiteListResult {
  /** List of Network Virtual Appliance sites. */
  value?: VirtualApplianceSite[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListNetworkVirtualApplianceSkus API service call. */
export interface NetworkVirtualApplianceSkuListResult {
  /** List of Network Virtual Appliance Skus that are available. */
  value?: NetworkVirtualApplianceSku[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** List of available Sku and instances. */
export interface NetworkVirtualApplianceSkuInstances {
  /**
   * Scale Unit.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly scaleUnit?: string;
  /**
   * Instance Count.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly instanceCount?: number;
}

/** Properties of the Inbound Security Rules resource. */
export interface InboundSecurityRules {
  /** Protocol. This should be either TCP or UDP. */
  protocol?: InboundSecurityRulesProtocol;
  /** The CIDR or source IP range. Only /30, /31 and /32 Ip ranges are allowed. */
  sourceAddressPrefix?: string;
  /** NVA port ranges to be opened up. One needs to provide specific ports. */
  destinationPortRange?: number;
}

/** The error object. */
export interface ErrorResponse {
  /** The error details object. */
  error?: ErrorDetails;
}

/** Response for ListNetworkWatchers API service call. */
export interface NetworkWatcherListResult {
  /** List of network watcher resources. */
  value?: NetworkWatcher[];
}

/** Parameters that define the representation of topology. */
export interface TopologyParameters {
  /** The name of the target resource group to perform topology on. */
  targetResourceGroupName?: string;
  /** The reference to the Virtual Network resource. */
  targetVirtualNetwork?: SubResource;
  /** The reference to the Subnet resource. */
  targetSubnet?: SubResource;
}

/** Topology of the specified resource group. */
export interface Topology {
  /**
   * GUID representing the operation id.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * The datetime when the topology was initially created for the resource group.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly createdDateTime?: Date;
  /**
   * The datetime when the topology was last modified.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly lastModified?: Date;
  /** A list of topology resources. */
  resources?: TopologyResource[];
}

/** The network resource topology information for the given resource group. */
export interface TopologyResource {
  /** Name of the resource. */
  name?: string;
  /** ID of the resource. */
  id?: string;
  /** Resource location. */
  location?: string;
  /** Holds the associations the resource has with other resources in the resource group. */
  associations?: TopologyAssociation[];
}

/** Resources that have an association with the parent resource. */
export interface TopologyAssociation {
  /** The name of the resource that is associated with the parent resource. */
  name?: string;
  /** The ID of the resource that is associated with the parent resource. */
  resourceId?: string;
  /** The association type of the child resource to the parent resource. */
  associationType?: AssociationType;
}

/** Parameters that define the IP flow to be verified. */
export interface VerificationIPFlowParameters {
  /** The ID of the target resource to perform next-hop on. */
  targetResourceId: string;
  /** The direction of the packet represented as a 5-tuple. */
  direction: Direction;
  /** Protocol to be verified on. */
  protocol: IpFlowProtocol;
  /** The local port. Acceptable values are a single integer in the range (0-65535). Support for * for the source port, which depends on the direction. */
  localPort: string;
  /** The remote port. Acceptable values are a single integer in the range (0-65535). Support for * for the source port, which depends on the direction. */
  remotePort: string;
  /** The local IP address. Acceptable values are valid IPv4 addresses. */
  localIPAddress: string;
  /** The remote IP address. Acceptable values are valid IPv4 addresses. */
  remoteIPAddress: string;
  /** The NIC ID. (If VM has multiple NICs and IP forwarding is enabled on any of them, then this parameter must be specified. Otherwise optional). */
  targetNicResourceId?: string;
}

/** Results of IP flow verification on the target resource. */
export interface VerificationIPFlowResult {
  /** Indicates whether the traffic is allowed or denied. */
  access?: Access;
  /** Name of the rule. If input is not matched against any security rule, it is not displayed. */
  ruleName?: string;
}

/** Parameters that define the source and destination endpoint. */
export interface NextHopParameters {
  /** The resource identifier of the target resource against which the action is to be performed. */
  targetResourceId: string;
  /** The source IP address. */
  sourceIPAddress: string;
  /** The destination IP address. */
  destinationIPAddress: string;
  /** The NIC ID. (If VM has multiple NICs and IP forwarding is enabled on any of the nics, then this parameter must be specified. Otherwise optional). */
  targetNicResourceId?: string;
}

/** The information about next hop from the specified VM. */
export interface NextHopResult {
  /** Next hop type. */
  nextHopType?: NextHopType;
  /** Next hop IP Address. */
  nextHopIpAddress?: string;
  /** The resource identifier for the route table associated with the route being returned. If the route being returned does not correspond to any user created routes then this field will be the string 'System Route'. */
  routeTableId?: string;
}

/** Parameters that define the VM to check security groups for. */
export interface SecurityGroupViewParameters {
  /** ID of the target VM. */
  targetResourceId: string;
}

/** The information about security rules applied to the specified VM. */
export interface SecurityGroupViewResult {
  /** List of network interfaces on the specified VM. */
  networkInterfaces?: SecurityGroupNetworkInterface[];
}

/** Network interface and all its associated security rules. */
export interface SecurityGroupNetworkInterface {
  /** ID of the network interface. */
  id?: string;
  /** All security rules associated with the network interface. */
  securityRuleAssociations?: SecurityRuleAssociations;
}

/** All security rules associated with the network interface. */
export interface SecurityRuleAssociations {
  /** Network interface and it's custom security rules. */
  networkInterfaceAssociation?: NetworkInterfaceAssociation;
  /** Subnet and it's custom security rules. */
  subnetAssociation?: SubnetAssociation;
  /** Collection of default security rules of the network security group. */
  defaultSecurityRules?: SecurityRule[];
  /** Collection of effective security rules. */
  effectiveSecurityRules?: EffectiveNetworkSecurityRule[];
}

/** Network interface and its custom security rules. */
export interface NetworkInterfaceAssociation {
  /**
   * Network interface ID.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /** Collection of custom security rules. */
  securityRules?: SecurityRule[];
}

/** Subnet and it's custom security rules. */
export interface SubnetAssociation {
  /**
   * Subnet ID.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /** Collection of custom security rules. */
  securityRules?: SecurityRule[];
}

/** Parameters that define the create packet capture operation. */
export interface PacketCapture {
  /** The ID of the targeted resource, only AzureVM and AzureVMSS as target type are currently supported. */
  target: string;
  /** A list of AzureVMSS instances which can be included or excluded to run packet capture. If both included and excluded are empty, then the packet capture will run on all instances of AzureVMSS. */
  scope?: PacketCaptureMachineScope;
  /** Target type of the resource provided. */
  targetType?: PacketCaptureTargetType;
  /** Number of bytes captured per packet, the remaining bytes are truncated. */
  bytesToCapturePerPacket?: number;
  /** Maximum size of the capture output. */
  totalBytesPerSession?: number;
  /** Maximum duration of the capture session in seconds. */
  timeLimitInSeconds?: number;
  /** The storage location for a packet capture session. */
  storageLocation: PacketCaptureStorageLocation;
  /** A list of packet capture filters. */
  filters?: PacketCaptureFilter[];
}

/** Parameters that define the create packet capture operation. */
export interface PacketCaptureParameters {
  /** The ID of the targeted resource, only AzureVM and AzureVMSS as target type are currently supported. */
  target: string;
  /** A list of AzureVMSS instances which can be included or excluded to run packet capture. If both included and excluded are empty, then the packet capture will run on all instances of AzureVMSS. */
  scope?: PacketCaptureMachineScope;
  /** Target type of the resource provided. */
  targetType?: PacketCaptureTargetType;
  /** Number of bytes captured per packet, the remaining bytes are truncated. */
  bytesToCapturePerPacket?: number;
  /** Maximum size of the capture output. */
  totalBytesPerSession?: number;
  /** Maximum duration of the capture session in seconds. */
  timeLimitInSeconds?: number;
  /** The storage location for a packet capture session. */
  storageLocation: PacketCaptureStorageLocation;
  /** A list of packet capture filters. */
  filters?: PacketCaptureFilter[];
}

/** A list of AzureVMSS instances which can be included or excluded to run packet capture. If both included and excluded are empty, then the packet capture will run on all instances of AzureVMSS. */
export interface PacketCaptureMachineScope {
  /** List of AzureVMSS instances to run packet capture on. */
  include?: string[];
  /** List of AzureVMSS instances which has to be excluded from the AzureVMSS from running packet capture. */
  exclude?: string[];
}

/** The storage location for a packet capture session. */
export interface PacketCaptureStorageLocation {
  /** The ID of the storage account to save the packet capture session. Required if no local file path is provided. */
  storageId?: string;
  /** The URI of the storage path to save the packet capture. Must be a well-formed URI describing the location to save the packet capture. */
  storagePath?: string;
  /** A valid local path on the targeting VM. Must include the name of the capture file (*.cap). For linux virtual machine it must start with /var/captures. Required if no storage ID is provided, otherwise optional. */
  filePath?: string;
}

/** Filter that is applied to packet capture request. Multiple filters can be applied. */
export interface PacketCaptureFilter {
  /** Protocol to be filtered on. */
  protocol?: PcProtocol;
  /** Local IP Address to be filtered on. Notation: "127.0.0.1" for single address entry. "127.0.0.1-127.0.0.255" for range. "127.0.0.1;127.0.0.5"? for multiple entries. Multiple ranges not currently supported. Mixing ranges with multiple entries not currently supported. Default = null. */
  localIPAddress?: string;
  /** Local IP Address to be filtered on. Notation: "127.0.0.1" for single address entry. "127.0.0.1-127.0.0.255" for range. "127.0.0.1;127.0.0.5;" for multiple entries. Multiple ranges not currently supported. Mixing ranges with multiple entries not currently supported. Default = null. */
  remoteIPAddress?: string;
  /** Local port to be filtered on. Notation: "80" for single port entry."80-85" for range. "80;443;" for multiple entries. Multiple ranges not currently supported. Mixing ranges with multiple entries not currently supported. Default = null. */
  localPort?: string;
  /** Remote port to be filtered on. Notation: "80" for single port entry."80-85" for range. "80;443;" for multiple entries. Multiple ranges not currently supported. Mixing ranges with multiple entries not currently supported. Default = null. */
  remotePort?: string;
}

/** Information about packet capture session. */
export interface PacketCaptureResult {
  /**
   * Name of the packet capture session.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * ID of the packet capture operation.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The ID of the targeted resource, only AzureVM and AzureVMSS as target type are currently supported. */
  target?: string;
  /** A list of AzureVMSS instances which can be included or excluded to run packet capture. If both included and excluded are empty, then the packet capture will run on all instances of AzureVMSS. */
  scope?: PacketCaptureMachineScope;
  /** Target type of the resource provided. */
  targetType?: PacketCaptureTargetType;
  /** Number of bytes captured per packet, the remaining bytes are truncated. */
  bytesToCapturePerPacket?: number;
  /** Maximum size of the capture output. */
  totalBytesPerSession?: number;
  /** Maximum duration of the capture session in seconds. */
  timeLimitInSeconds?: number;
  /** The storage location for a packet capture session. */
  storageLocation?: PacketCaptureStorageLocation;
  /** A list of packet capture filters. */
  filters?: PacketCaptureFilter[];
  /**
   * The provisioning state of the packet capture session.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Status of packet capture session. */
export interface PacketCaptureQueryStatusResult {
  /** The name of the packet capture resource. */
  name?: string;
  /** The ID of the packet capture resource. */
  id?: string;
  /** The start time of the packet capture session. */
  captureStartTime?: Date;
  /** The status of the packet capture session. */
  packetCaptureStatus?: PcStatus;
  /** The reason the current packet capture session was stopped. */
  stopReason?: string;
  /** List of errors of packet capture session. */
  packetCaptureError?: PcError[];
}

/** List of packet capture sessions. */
export interface PacketCaptureListResult {
  /** Information about packet capture sessions. */
  value?: PacketCaptureResult[];
}

/** Parameters that define the resource to troubleshoot. */
export interface TroubleshootingParameters {
  /** The target resource to troubleshoot. */
  targetResourceId: string;
  /** The ID for the storage account to save the troubleshoot result. */
  storageId: string;
  /** The path to the blob to save the troubleshoot result in. */
  storagePath: string;
}

/** Troubleshooting information gained from specified resource. */
export interface TroubleshootingResult {
  /** The start time of the troubleshooting. */
  startTime?: Date;
  /** The end time of the troubleshooting. */
  endTime?: Date;
  /** The result code of the troubleshooting. */
  code?: string;
  /** Information from troubleshooting. */
  results?: TroubleshootingDetails[];
}

/** Information gained from troubleshooting of specified resource. */
export interface TroubleshootingDetails {
  /** The id of the get troubleshoot operation. */
  id?: string;
  /** Reason type of failure. */
  reasonType?: string;
  /** A summary of troubleshooting. */
  summary?: string;
  /** Details on troubleshooting results. */
  detail?: string;
  /** List of recommended actions. */
  recommendedActions?: TroubleshootingRecommendedActions[];
}

/** Recommended actions based on discovered issues. */
export interface TroubleshootingRecommendedActions {
  /** ID of the recommended action. */
  actionId?: string;
  /** Description of recommended actions. */
  actionText?: string;
  /** The uri linking to a documentation for the recommended troubleshooting actions. */
  actionUri?: string;
  /** The information from the URI for the recommended troubleshooting actions. */
  actionUriText?: string;
}

/** Parameters that define the resource to query the troubleshooting result. */
export interface QueryTroubleshootingParameters {
  /** The target resource ID to query the troubleshooting result. */
  targetResourceId: string;
}

/** Information on the configuration of flow log and traffic analytics (optional) . */
export interface FlowLogInformation {
  /** The ID of the resource to configure for flow log and traffic analytics (optional) . */
  targetResourceId: string;
  /** Parameters that define the configuration of traffic analytics. */
  flowAnalyticsConfiguration?: TrafficAnalyticsProperties;
  /** ID of the storage account which is used to store the flow log. */
  storageId: string;
  /** Flag to enable/disable flow logging. */
  enabled: boolean;
  /** Parameters that define the retention policy for flow log. */
  retentionPolicy?: RetentionPolicyParameters;
  /** Parameters that define the flow log format. */
  format?: FlowLogFormatParameters;
}

/** Parameters that define a resource to query flow log and traffic analytics (optional) status. */
export interface FlowLogStatusParameters {
  /** The target resource where getting the flow log and traffic analytics (optional) status. */
  targetResourceId: string;
}

/** Parameters that determine how the connectivity check will be performed. */
export interface ConnectivityParameters {
  /** The source of the connection. */
  source: ConnectivitySource;
  /** The destination of connection. */
  destination: ConnectivityDestination;
  /** Network protocol. */
  protocol?: Protocol;
  /** Configuration of the protocol. */
  protocolConfiguration?: ProtocolConfiguration;
  /** Preferred IP version of the connection. */
  preferredIPVersion?: IPVersion;
}

/** Parameters that define the source of the connection. */
export interface ConnectivitySource {
  /** The ID of the resource from which a connectivity check will be initiated. */
  resourceId: string;
  /** The source port from which a connectivity check will be performed. */
  port?: number;
}

/** Parameters that define destination of connection. */
export interface ConnectivityDestination {
  /** The ID of the resource to which a connection attempt will be made. */
  resourceId?: string;
  /** The IP address or URI the resource to which a connection attempt will be made. */
  address?: string;
  /** Port on which check connectivity will be performed. */
  port?: number;
}

/** Configuration of the protocol. */
export interface ProtocolConfiguration {
  /** HTTP configuration of the connectivity check. */
  httpConfiguration?: HttpConfiguration;
}

/** HTTP configuration of the connectivity check. */
export interface HttpConfiguration {
  /** HTTP method. */
  method?: HttpMethod;
  /** List of HTTP headers. */
  headers?: HttpHeader[];
  /** Valid status codes. */
  validStatusCodes?: number[];
}

/** The HTTP header. */
export interface HttpHeader {
  /** The name in HTTP header. */
  name?: string;
  /** The value in HTTP header. */
  value?: string;
}

/** Information on the connectivity status. */
export interface ConnectivityInformation {
  /**
   * List of hops between the source and the destination.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly hops?: ConnectivityHop[];
  /**
   * The connection status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionStatus?: ConnectionStatus;
  /**
   * Average latency in milliseconds.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly avgLatencyInMs?: number;
  /**
   * Minimum latency in milliseconds.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly minLatencyInMs?: number;
  /**
   * Maximum latency in milliseconds.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly maxLatencyInMs?: number;
  /**
   * Total number of probes sent.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly probesSent?: number;
  /**
   * Number of failed probes.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly probesFailed?: number;
}

/** Information about a hop between the source and the destination. */
export interface ConnectivityHop {
  /**
   * The type of the hop.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * The ID of the hop.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * The IP address of the hop.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly address?: string;
  /**
   * The ID of the resource corresponding to this hop.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceId?: string;
  /**
   * List of next hop identifiers.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextHopIds?: string[];
  /**
   * List of previous hop identifiers.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly previousHopIds?: string[];
  /**
   * List of hop links.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly links?: HopLink[];
  /**
   * List of previous hop links.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly previousLinks?: HopLink[];
  /**
   * List of issues.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly issues?: ConnectivityIssue[];
}

/** Hop link. */
export interface HopLink {
  /**
   * The ID of the next hop.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextHopId?: string;
  /**
   * Link type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly linkType?: string;
  /**
   * List of issues.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly issues?: ConnectivityIssue[];
  /**
   * Provides additional context on links.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly context?: { [propertyName: string]: string };
  /**
   * Resource ID.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceId?: string;
  /**
   * Minimum roundtrip time in milliseconds.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly roundTripTimeMin?: number;
  /**
   * Average roundtrip time in milliseconds.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly roundTripTimeAvg?: number;
  /**
   * Maximum roundtrip time in milliseconds.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly roundTripTimeMax?: number;
}

/** Information about an issue encountered in the process of checking for connectivity. */
export interface ConnectivityIssue {
  /**
   * The origin of the issue.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly origin?: Origin;
  /**
   * The severity of the issue.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly severity?: Severity;
  /**
   * The type of issue.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: IssueType;
  /**
   * Provides additional context on the issue.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly context?: { [propertyName: string]: string }[];
}

/** Geographic and time constraints for Azure reachability report. */
export interface AzureReachabilityReportParameters {
  /** Parameters that define a geographic location. */
  providerLocation: AzureReachabilityReportLocation;
  /** List of Internet service providers. */
  providers?: string[];
  /** Optional Azure regions to scope the query to. */
  azureLocations?: string[];
  /** The start time for the Azure reachability report. */
  startTime: Date;
  /** The end time for the Azure reachability report. */
  endTime: Date;
}

/** Parameters that define a geographic location. */
export interface AzureReachabilityReportLocation {
  /** The name of the country. */
  country: string;
  /** The name of the state. */
  state?: string;
  /** The name of the city or town. */
  city?: string;
}

/** Azure reachability report details. */
export interface AzureReachabilityReport {
  /** The aggregation level of Azure reachability report. Can be Country, State or City. */
  aggregationLevel: string;
  /** Parameters that define a geographic location. */
  providerLocation: AzureReachabilityReportLocation;
  /** List of Azure reachability report items. */
  reachabilityReport: AzureReachabilityReportItem[];
}

/** Azure reachability report details for a given provider location. */
export interface AzureReachabilityReportItem {
  /** The Internet service provider. */
  provider?: string;
  /** The Azure region. */
  azureLocation?: string;
  /** List of latency details for each of the time series. */
  latencies?: AzureReachabilityReportLatencyInfo[];
}

/** Details on latency for a time series. */
export interface AzureReachabilityReportLatencyInfo {
  /** The time stamp. */
  timeStamp?: Date;
  /** The relative latency score between 1 and 100, higher values indicating a faster connection. */
  score?: number;
}

/** Constraints that determine the list of available Internet service providers. */
export interface AvailableProvidersListParameters {
  /** A list of Azure regions. */
  azureLocations?: string[];
  /** The country for available providers list. */
  country?: string;
  /** The state for available providers list. */
  state?: string;
  /** The city or town for available providers list. */
  city?: string;
}

/** List of available countries with details. */
export interface AvailableProvidersList {
  /** List of available countries. */
  countries: AvailableProvidersListCountry[];
}

/** Country details. */
export interface AvailableProvidersListCountry {
  /** The country name. */
  countryName?: string;
  /** A list of Internet service providers. */
  providers?: string[];
  /** List of available states in the country. */
  states?: AvailableProvidersListState[];
}

/** State details. */
export interface AvailableProvidersListState {
  /** The state name. */
  stateName?: string;
  /** A list of Internet service providers. */
  providers?: string[];
  /** List of available cities or towns in the state. */
  cities?: AvailableProvidersListCity[];
}

/** City or town details. */
export interface AvailableProvidersListCity {
  /** The city or town name. */
  cityName?: string;
  /** A list of Internet service providers. */
  providers?: string[];
}

/** Parameters to get network configuration diagnostic. */
export interface NetworkConfigurationDiagnosticParameters {
  /** The ID of the target resource to perform network configuration diagnostic. Valid options are VM, NetworkInterface, VMSS/NetworkInterface and Application Gateway. */
  targetResourceId: string;
  /** Verbosity level. */
  verbosityLevel?: VerbosityLevel;
  /** List of network configuration diagnostic profiles. */
  profiles: NetworkConfigurationDiagnosticProfile[];
}

/** Parameters to compare with network configuration. */
export interface NetworkConfigurationDiagnosticProfile {
  /** The direction of the traffic. */
  direction: Direction;
  /** Protocol to be verified on. Accepted values are '*', TCP, UDP. */
  protocol: string;
  /** Traffic source. Accepted values are '*', IP Address/CIDR, Service Tag. */
  source: string;
  /** Traffic destination. Accepted values are: '*', IP Address/CIDR, Service Tag. */
  destination: string;
  /** Traffic destination port. Accepted values are '*' and a single port in the range (0 - 65535). */
  destinationPort: string;
}

/** Results of network configuration diagnostic on the target resource. */
export interface NetworkConfigurationDiagnosticResponse {
  /**
   * List of network configuration diagnostic results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly results?: NetworkConfigurationDiagnosticResult[];
}

/** Network configuration diagnostic result corresponded to provided traffic query. */
export interface NetworkConfigurationDiagnosticResult {
  /** Network configuration diagnostic profile. */
  profile?: NetworkConfigurationDiagnosticProfile;
  /** Network security group result. */
  networkSecurityGroupResult?: NetworkSecurityGroupResult;
}

/** Network configuration diagnostic result corresponded provided traffic query. */
export interface NetworkSecurityGroupResult {
  /** The network traffic is allowed or denied. */
  securityRuleAccessResult?: SecurityRuleAccess;
  /**
   * List of results network security groups diagnostic.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly evaluatedNetworkSecurityGroups?: EvaluatedNetworkSecurityGroup[];
}

/** Results of network security group evaluation. */
export interface EvaluatedNetworkSecurityGroup {
  /** Network security group ID. */
  networkSecurityGroupId?: string;
  /** Resource ID of nic or subnet to which network security group is applied. */
  appliedTo?: string;
  /** Matched network security rule. */
  matchedRule?: MatchedRule;
  /**
   * List of network security rules evaluation results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly rulesEvaluationResult?: NetworkSecurityRulesEvaluationResult[];
}

/** Matched rule. */
export interface MatchedRule {
  /** Name of the matched network security rule. */
  ruleName?: string;
  /** The network traffic is allowed or denied. Possible values are 'Allow' and 'Deny'. */
  action?: string;
}

/** Network security rules evaluation result. */
export interface NetworkSecurityRulesEvaluationResult {
  /** Name of the network security rule. */
  name?: string;
  /** Value indicating whether protocol is matched. */
  protocolMatched?: boolean;
  /** Value indicating whether source is matched. */
  sourceMatched?: boolean;
  /** Value indicating whether source port is matched. */
  sourcePortMatched?: boolean;
  /** Value indicating whether destination is matched. */
  destinationMatched?: boolean;
  /** Value indicating whether destination port is matched. */
  destinationPortMatched?: boolean;
}

/** Parameters that define the operation to create a connection monitor. */
export interface ConnectionMonitor {
  /** Connection monitor location. */
  location?: string;
  /** Connection monitor tags. */
  tags?: { [propertyName: string]: string };
  /** Describes the source of connection monitor. */
  source?: ConnectionMonitorSource;
  /** Describes the destination of connection monitor. */
  destination?: ConnectionMonitorDestination;
  /** Determines if the connection monitor will start automatically once created. */
  autoStart?: boolean;
  /** Monitoring interval in seconds. */
  monitoringIntervalInSeconds?: number;
  /** List of connection monitor endpoints. */
  endpoints?: ConnectionMonitorEndpoint[];
  /** List of connection monitor test configurations. */
  testConfigurations?: ConnectionMonitorTestConfiguration[];
  /** List of connection monitor test groups. */
  testGroups?: ConnectionMonitorTestGroup[];
  /** List of connection monitor outputs. */
  outputs?: ConnectionMonitorOutput[];
  /** Optional notes to be associated with the connection monitor. */
  notes?: string;
}

/** Parameters that define the operation to create a connection monitor. */
export interface ConnectionMonitorParameters {
  /** Describes the source of connection monitor. */
  source?: ConnectionMonitorSource;
  /** Describes the destination of connection monitor. */
  destination?: ConnectionMonitorDestination;
  /** Determines if the connection monitor will start automatically once created. */
  autoStart?: boolean;
  /** Monitoring interval in seconds. */
  monitoringIntervalInSeconds?: number;
  /** List of connection monitor endpoints. */
  endpoints?: ConnectionMonitorEndpoint[];
  /** List of connection monitor test configurations. */
  testConfigurations?: ConnectionMonitorTestConfiguration[];
  /** List of connection monitor test groups. */
  testGroups?: ConnectionMonitorTestGroup[];
  /** List of connection monitor outputs. */
  outputs?: ConnectionMonitorOutput[];
  /** Optional notes to be associated with the connection monitor. */
  notes?: string;
}

/** Describes the source of connection monitor. */
export interface ConnectionMonitorSource {
  /** The ID of the resource used as the source by connection monitor. */
  resourceId: string;
  /** The source port used by connection monitor. */
  port?: number;
}

/** Describes the destination of connection monitor. */
export interface ConnectionMonitorDestination {
  /** The ID of the resource used as the destination by connection monitor. */
  resourceId?: string;
  /** Address of the connection monitor destination (IP or domain name). */
  address?: string;
  /** The destination port used by connection monitor. */
  port?: number;
}

/** Describes the connection monitor endpoint. */
export interface ConnectionMonitorEndpoint {
  /** The name of the connection monitor endpoint. */
  name: string;
  /** The endpoint type. */
  type?: EndpointType;
  /** Resource ID of the connection monitor endpoint. */
  resourceId?: string;
  /** Address of the connection monitor endpoint (IP or domain name). */
  address?: string;
  /** Filter for sub-items within the endpoint. */
  filter?: ConnectionMonitorEndpointFilter;
  /** Endpoint scope. */
  scope?: ConnectionMonitorEndpointScope;
  /** Test coverage for the endpoint. */
  coverageLevel?: CoverageLevel;
}

/** Describes the connection monitor endpoint filter. */
export interface ConnectionMonitorEndpointFilter {
  /** The behavior of the endpoint filter. Currently only 'Include' is supported. */
  type?: ConnectionMonitorEndpointFilterType;
  /** List of items in the filter. */
  items?: ConnectionMonitorEndpointFilterItem[];
}

/** Describes the connection monitor endpoint filter item. */
export interface ConnectionMonitorEndpointFilterItem {
  /** The type of item included in the filter. Currently only 'AgentAddress' is supported. */
  type?: ConnectionMonitorEndpointFilterItemType;
  /** The address of the filter item. */
  address?: string;
}

/** Describes the connection monitor endpoint scope. */
export interface ConnectionMonitorEndpointScope {
  /** List of items which needs to be included to the endpoint scope. */
  include?: ConnectionMonitorEndpointScopeItem[];
  /** List of items which needs to be excluded from the endpoint scope. */
  exclude?: ConnectionMonitorEndpointScopeItem[];
}

/** Describes the connection monitor endpoint scope item. */
export interface ConnectionMonitorEndpointScopeItem {
  /** The address of the endpoint item. Supported types are IPv4/IPv6 subnet mask or IPv4/IPv6 IP address. */
  address?: string;
}

/** Describes a connection monitor test configuration. */
export interface ConnectionMonitorTestConfiguration {
  /** The name of the connection monitor test configuration. */
  name: string;
  /** The frequency of test evaluation, in seconds. */
  testFrequencySec?: number;
  /** The protocol to use in test evaluation. */
  protocol: ConnectionMonitorTestConfigurationProtocol;
  /** The preferred IP version to use in test evaluation. The connection monitor may choose to use a different version depending on other parameters. */
  preferredIPVersion?: PreferredIPVersion;
  /** The parameters used to perform test evaluation over HTTP. */
  httpConfiguration?: ConnectionMonitorHttpConfiguration;
  /** The parameters used to perform test evaluation over TCP. */
  tcpConfiguration?: ConnectionMonitorTcpConfiguration;
  /** The parameters used to perform test evaluation over ICMP. */
  icmpConfiguration?: ConnectionMonitorIcmpConfiguration;
  /** The threshold for declaring a test successful. */
  successThreshold?: ConnectionMonitorSuccessThreshold;
}

/** Describes the HTTP configuration. */
export interface ConnectionMonitorHttpConfiguration {
  /** The port to connect to. */
  port?: number;
  /** The HTTP method to use. */
  method?: HttpConfigurationMethod;
  /** The path component of the URI. For instance, "/dir1/dir2". */
  path?: string;
  /** The HTTP headers to transmit with the request. */
  requestHeaders?: HttpHeader[];
  /** HTTP status codes to consider successful. For instance, "2xx,301-304,418". */
  validStatusCodeRanges?: string[];
  /** Value indicating whether HTTPS is preferred over HTTP in cases where the choice is not explicit. */
  preferHttps?: boolean;
}

/** Describes the TCP configuration. */
export interface ConnectionMonitorTcpConfiguration {
  /** The port to connect to. */
  port?: number;
  /** Value indicating whether path evaluation with trace route should be disabled. */
  disableTraceRoute?: boolean;
  /** Destination port behavior. */
  destinationPortBehavior?: DestinationPortBehavior;
}

/** Describes the ICMP configuration. */
export interface ConnectionMonitorIcmpConfiguration {
  /** Value indicating whether path evaluation with trace route should be disabled. */
  disableTraceRoute?: boolean;
}

/** Describes the threshold for declaring a test successful. */
export interface ConnectionMonitorSuccessThreshold {
  /** The maximum percentage of failed checks permitted for a test to evaluate as successful. */
  checksFailedPercent?: number;
  /** The maximum round-trip time in milliseconds permitted for a test to evaluate as successful. */
  roundTripTimeMs?: number;
}

/** Describes the connection monitor test group. */
export interface ConnectionMonitorTestGroup {
  /** The name of the connection monitor test group. */
  name: string;
  /** Value indicating whether test group is disabled. */
  disable?: boolean;
  /** List of test configuration names. */
  testConfigurations: string[];
  /** List of source endpoint names. */
  sources: string[];
  /** List of destination endpoint names. */
  destinations: string[];
}

/** Describes a connection monitor output destination. */
export interface ConnectionMonitorOutput {
  /** Connection monitor output destination type. Currently, only "Workspace" is supported. */
  type?: OutputType;
  /** Describes the settings for producing output into a log analytics workspace. */
  workspaceSettings?: ConnectionMonitorWorkspaceSettings;
}

/** Describes the settings for producing output into a log analytics workspace. */
export interface ConnectionMonitorWorkspaceSettings {
  /** Log analytics workspace resource ID. */
  workspaceResourceId?: string;
}

/** Information about the connection monitor. */
export interface ConnectionMonitorResult {
  /**
   * Name of the connection monitor.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * ID of the connection monitor.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Connection monitor type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Connection monitor location. */
  location?: string;
  /** Connection monitor tags. */
  tags?: { [propertyName: string]: string };
  /** Describes the source of connection monitor. */
  source?: ConnectionMonitorSource;
  /** Describes the destination of connection monitor. */
  destination?: ConnectionMonitorDestination;
  /** Determines if the connection monitor will start automatically once created. */
  autoStart?: boolean;
  /** Monitoring interval in seconds. */
  monitoringIntervalInSeconds?: number;
  /** List of connection monitor endpoints. */
  endpoints?: ConnectionMonitorEndpoint[];
  /** List of connection monitor test configurations. */
  testConfigurations?: ConnectionMonitorTestConfiguration[];
  /** List of connection monitor test groups. */
  testGroups?: ConnectionMonitorTestGroup[];
  /** List of connection monitor outputs. */
  outputs?: ConnectionMonitorOutput[];
  /** Optional notes to be associated with the connection monitor. */
  notes?: string;
  /**
   * The provisioning state of the connection monitor.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The date and time when the connection monitor was started.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly startTime?: Date;
  /**
   * The monitoring status of the connection monitor.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly monitoringStatus?: string;
  /**
   * Type of connection monitor.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionMonitorType?: ConnectionMonitorType;
}

/** List of connection states snapshots. */
export interface ConnectionMonitorQueryResult {
  /** Status of connection monitor source. */
  sourceStatus?: ConnectionMonitorSourceStatus;
  /** Information about connection states. */
  states?: ConnectionStateSnapshot[];
}

/** Connection state snapshot. */
export interface ConnectionStateSnapshot {
  /** The connection state. */
  connectionState?: ConnectionState;
  /** The start time of the connection snapshot. */
  startTime?: Date;
  /** The end time of the connection snapshot. */
  endTime?: Date;
  /** Connectivity analysis evaluation state. */
  evaluationState?: EvaluationState;
  /** Average latency in ms. */
  avgLatencyInMs?: number;
  /** Minimum latency in ms. */
  minLatencyInMs?: number;
  /** Maximum latency in ms. */
  maxLatencyInMs?: number;
  /** The number of sent probes. */
  probesSent?: number;
  /** The number of failed probes. */
  probesFailed?: number;
  /**
   * List of hops between the source and the destination.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly hops?: ConnectivityHop[];
}

/** List of connection monitors. */
export interface ConnectionMonitorListResult {
  /** Information about connection monitors. */
  value?: ConnectionMonitorResult[];
}

/** List of flow logs. */
export interface FlowLogListResult {
  /** Information about flow log resource. */
  value?: FlowLog[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Result of the request to list Network operations. It contains a list of operations and a URL link to get the next set of results. */
export interface OperationListResult {
  /** List of Network operations supported by the Network resource provider. */
  value?: Operation[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Network REST API operation definition. */
export interface Operation {
  /** Operation name: {provider}/{resource}/{operation}. */
  name?: string;
  /** Display metadata associated with the operation. */
  display?: OperationDisplay;
  /** Origin of the operation. */
  origin?: string;
  /** Specification of the service. */
  serviceSpecification?: OperationPropertiesFormatServiceSpecification;
}

/** Display metadata associated with the operation. */
export interface OperationDisplay {
  /** Service provider: Microsoft Network. */
  provider?: string;
  /** Resource on which the operation is performed. */
  resource?: string;
  /** Type of the operation: get, read, delete, etc. */
  operation?: string;
  /** Description of the operation. */
  description?: string;
}

/** Specification of the service. */
export interface OperationPropertiesFormatServiceSpecification {
  /** Operation service specification. */
  metricSpecifications?: MetricSpecification[];
  /** Operation log specification. */
  logSpecifications?: LogSpecification[];
}

/** Description of metrics specification. */
export interface MetricSpecification {
  /** The name of the metric. */
  name?: string;
  /** The display name of the metric. */
  displayName?: string;
  /** The description of the metric. */
  displayDescription?: string;
  /** Units the metric to be displayed in. */
  unit?: string;
  /** The aggregation type. */
  aggregationType?: string;
  /** List of availability. */
  availabilities?: Availability[];
  /** Whether regional MDM account enabled. */
  enableRegionalMdmAccount?: boolean;
  /** Whether gaps would be filled with zeros. */
  fillGapWithZero?: boolean;
  /** Pattern for the filter of the metric. */
  metricFilterPattern?: string;
  /** List of dimensions. */
  dimensions?: Dimension[];
  /** Whether the metric is internal. */
  isInternal?: boolean;
  /** The source MDM account. */
  sourceMdmAccount?: string;
  /** The source MDM namespace. */
  sourceMdmNamespace?: string;
  /** The resource Id dimension name override. */
  resourceIdDimensionNameOverride?: string;
}

/** Availability of the metric. */
export interface Availability {
  /** The time grain of the availability. */
  timeGrain?: string;
  /** The retention of the availability. */
  retention?: string;
  /** Duration of the availability blob. */
  blobDuration?: string;
}

/** Dimension of the metric. */
export interface Dimension {
  /** The name of the dimension. */
  name?: string;
  /** The display name of the dimension. */
  displayName?: string;
  /** The internal name of the dimension. */
  internalName?: string;
}

/** Description of logging specification. */
export interface LogSpecification {
  /** The name of the specification. */
  name?: string;
  /** The display name of the specification. */
  displayName?: string;
  /** Duration of the blob. */
  blobDuration?: string;
}

/** Response for the ListPrivateEndpoints API service call. */
export interface PrivateEndpointListResult {
  /** A list of private endpoint resources in a resource group. */
  value?: PrivateEndpoint[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** An array of available PrivateEndpoint types. */
export interface AvailablePrivateEndpointTypesResult {
  /** An array of available privateEndpoint type. */
  value?: AvailablePrivateEndpointType[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** The information of an AvailablePrivateEndpointType. */
export interface AvailablePrivateEndpointType {
  /** The name of the service and resource. */
  name?: string;
  /** A unique identifier of the AvailablePrivateEndpoint Type resource. */
  id?: string;
  /** Resource type. */
  type?: string;
  /** The name of the service and resource. */
  resourceName?: string;
  /** Display name of the resource. */
  displayName?: string;
}

/** PrivateDnsZoneConfig resource. */
export interface PrivateDnsZoneConfig {
  /** Name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /** The resource id of the private dns zone. */
  privateDnsZoneId?: string;
  /**
   * A collection of information regarding a recordSet, holding information to identify private resources.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly recordSets?: RecordSet[];
}

/** A collective group of information about the record set information. */
export interface RecordSet {
  /** Resource record type. */
  recordType?: string;
  /** Recordset name. */
  recordSetName?: string;
  /** Fqdn that resolves to private endpoint ip address. */
  fqdn?: string;
  /**
   * The provisioning state of the recordset.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Recordset time to live. */
  ttl?: number;
  /** The private ip address of the private endpoint. */
  ipAddresses?: string[];
}

/** Response for the ListPrivateDnsZoneGroups API service call. */
export interface PrivateDnsZoneGroupListResult {
  /** A list of private dns zone group resources in a private endpoint. */
  value?: PrivateDnsZoneGroup[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for the ListPrivateLinkService API service call. */
export interface PrivateLinkServiceListResult {
  /** A list of PrivateLinkService resources in a resource group. */
  value?: PrivateLinkService[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for the ListPrivateEndpointConnection API service call. */
export interface PrivateEndpointConnectionListResult {
  /** A list of PrivateEndpointConnection resources for a specific private link service. */
  value?: PrivateEndpointConnection[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Request body of the CheckPrivateLinkServiceVisibility API service call. */
export interface CheckPrivateLinkServiceVisibilityRequest {
  /** The alias of the private link service. */
  privateLinkServiceAlias?: string;
}

/** Response for the CheckPrivateLinkServiceVisibility API service call. */
export interface PrivateLinkServiceVisibility {
  /** Private Link Service Visibility (True/False). */
  visible?: boolean;
}

/** An array of private link service id that can be linked to a private end point with auto approved. */
export interface AutoApprovedPrivateLinkServicesResult {
  /** An array of auto approved private link service. */
  value?: AutoApprovedPrivateLinkService[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** The information of an AutoApprovedPrivateLinkService. */
export interface AutoApprovedPrivateLinkService {
  /** The id of the private link service resource. */
  privateLinkService?: string;
}

/** SKU of a public IP prefix. */
export interface PublicIPPrefixSku {
  /** Name of a public IP prefix SKU. */
  name?: PublicIPPrefixSkuName;
  /** Tier of a public IP prefix SKU. */
  tier?: PublicIPPrefixSkuTier;
}

/** Reference to a public IP address. */
export interface ReferencedPublicIpAddress {
  /** The PublicIPAddress Reference. */
  id?: string;
}

/** Response for ListPublicIpPrefixes API service call. */
export interface PublicIPPrefixListResult {
  /** A list of public IP prefixes that exists in a resource group. */
  value?: PublicIPPrefix[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for the ListRouteFilters API service call. */
export interface RouteFilterListResult {
  /** A list of route filters in a resource group. */
  value?: RouteFilter[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for the ListRouteFilterRules API service call. */
export interface RouteFilterRuleListResult {
  /** A list of RouteFilterRules in a resource group. */
  value?: RouteFilterRule[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for the ListRouteTable API service call. */
export interface RouteTableListResult {
  /** A list of route tables in a resource group. */
  value?: RouteTable[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for the ListRoute API service call. */
export interface RouteListResult {
  /** A list of routes in a resource group. */
  value?: Route[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListSecurityPartnerProviders API service call. */
export interface SecurityPartnerProviderListResult {
  /** List of Security Partner Providers in a resource group. */
  value?: SecurityPartnerProvider[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Response for the ListServiceCommunity API service call. */
export interface BgpServiceCommunityListResult {
  /** A list of service community resources. */
  value?: BgpServiceCommunity[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Contains bgp community information offered in Service Community resources. */
export interface BGPCommunity {
  /** The region which the service support. e.g. For O365, region is Global. */
  serviceSupportedRegion?: string;
  /** The name of the bgp community. e.g. Skype. */
  communityName?: string;
  /** The value of the bgp community. For more information: https://docs.microsoft.com/en-us/azure/expressroute/expressroute-routing. */
  communityValue?: string;
  /** The prefixes that the bgp community contains. */
  communityPrefixes?: string[];
  /** Customer is authorized to use bgp community or not. */
  isAuthorizedToUse?: boolean;
  /** The service group of the bgp community contains. */
  serviceGroup?: string;
}

/** Response for ListServiceEndpointPolicies API service call. */
export interface ServiceEndpointPolicyListResult {
  /** A list of ServiceEndpointPolicy resources. */
  value?: ServiceEndpointPolicy[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListServiceEndpointPolicyDefinition API service call. Retrieves all service endpoint policy definition that belongs to a service endpoint policy. */
export interface ServiceEndpointPolicyDefinitionListResult {
  /** The service endpoint policy definition in a service endpoint policy. */
  value?: ServiceEndpointPolicyDefinition[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for the ListServiceTags API service call. */
export interface ServiceTagsListResult {
  /**
   * The name of the cloud.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * The ID of the cloud.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * The azure resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * The iteration number.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly changeNumber?: string;
  /**
   * The name of the cloud.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly cloud?: string;
  /**
   * The list of service tag information resources.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly values?: ServiceTagInformation[];
  /**
   * The URL to get next page of service tag information resources.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** The service tag information. */
export interface ServiceTagInformation {
  /**
   * Properties of the service tag information.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly properties?: ServiceTagInformationPropertiesFormat;
  /**
   * The name of service tag.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * The ID of service tag.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * The iteration number of service tag object for region.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly serviceTagChangeNumber?: string;
}

/** Properties of the service tag information. */
export interface ServiceTagInformationPropertiesFormat {
  /**
   * The iteration number of service tag.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly changeNumber?: string;
  /**
   * The region of service tag.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly region?: string;
  /**
   * The name of system service.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemService?: string;
  /**
   * The list of IP address prefixes.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly addressPrefixes?: string[];
  /**
   * The state of the service tag.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly state?: string;
}

/** Response for Get ServiceTagInformation API service call. Retrieves the list of service tag information resources. */
export interface ServiceTagInformationListResult {
  /** The list of service tag information resources. */
  value?: ServiceTagInformation[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** The list usages operation response. */
export interface UsagesListResult {
  /** The list network resource usages. */
  value?: Usage[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** The network resource usage. */
export interface Usage {
  /**
   * Resource identifier.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /** An enum describing the unit of measurement. */
  unit: UsageUnit;
  /** The current value of the usage. */
  currentValue: number;
  /** The limit of usage. */
  limit: number;
  /** The name of the type of usage. */
  name: UsageName;
}

/** The usage names. */
export interface UsageName {
  /** A string describing the resource name. */
  value?: string;
  /** A localized string describing the resource name. */
  localizedValue?: string;
}

/** AddressSpace contains an array of IP address ranges that can be used by subnets of the virtual network. */
export interface AddressSpace {
  /** A list of address blocks reserved for this virtual network in CIDR notation. */
  addressPrefixes?: string[];
}

/** DhcpOptions contains an array of DNS servers available to VMs deployed in the virtual network. Standard DHCP option for a subnet overrides VNET DHCP options. */
export interface DhcpOptions {
  /** The list of DNS servers IP addresses. */
  dnsServers?: string[];
}

/** Bgp Communities sent over ExpressRoute with each route corresponding to a prefix in this VNET. */
export interface VirtualNetworkBgpCommunities {
  /** The BGP community associated with the virtual network. */
  virtualNetworkCommunity: string;
  /**
   * The BGP community associated with the region of the virtual network.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly regionalCommunity?: string;
}

/** Indicates if encryption is enabled on virtual network and if VM without encryption is allowed in encrypted VNet. */
export interface VirtualNetworkEncryption {
  /** Indicates if encryption is enabled on the virtual network. */
  enabled: boolean;
  /** If the encrypted VNet allows VM that does not support encryption */
  enforcement?: VirtualNetworkEncryptionEnforcement;
}

/** Response for the ListVirtualNetworks API service call. */
export interface VirtualNetworkListResult {
  /** A list of VirtualNetwork resources in a resource group. */
  value?: VirtualNetwork[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Details of PrepareNetworkPolicies for Subnet. */
export interface PrepareNetworkPoliciesRequest {
  /** The name of the service for which subnet is being prepared for. */
  serviceName?: string;
  /** A list of NetworkIntentPolicyConfiguration. */
  networkIntentPolicyConfigurations?: NetworkIntentPolicyConfiguration[];
}

/** Details of NetworkIntentPolicyConfiguration for PrepareNetworkPoliciesRequest. */
export interface NetworkIntentPolicyConfiguration {
  /** The name of the Network Intent Policy for storing in target subscription. */
  networkIntentPolicyName?: string;
  /** Source network intent policy. */
  sourceNetworkIntentPolicy?: NetworkIntentPolicy;
}

/** Details of UnprepareNetworkPolicies for Subnet. */
export interface UnprepareNetworkPoliciesRequest {
  /** The name of the service for which subnet is being unprepared for. */
  serviceName?: string;
}

/** Response for ResourceNavigationLinks_List operation. */
export interface ResourceNavigationLinksListResult {
  /** The resource navigation links in a subnet. */
  value?: ResourceNavigationLink[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ServiceAssociationLinks_List operation. */
export interface ServiceAssociationLinksListResult {
  /** The service association links in a subnet. */
  value?: ServiceAssociationLink[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for ListSubnets API service callRetrieves all subnet that belongs to a virtual network. */
export interface SubnetListResult {
  /** The subnets in a virtual network. */
  value?: Subnet[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListSubnets API service call. Retrieves all subnets that belong to a virtual network. */
export interface VirtualNetworkPeeringListResult {
  /** The peerings in a virtual network. */
  value?: VirtualNetworkPeering[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for CheckIPAddressAvailability API service call. */
export interface IPAddressAvailabilityResult {
  /** Private IP address availability. */
  available?: boolean;
  /** Contains other available private IP addresses if the asked for address is taken. */
  availableIPAddresses?: string[];
  /** Private IP address platform reserved. */
  isPlatformReserved?: boolean;
}

/** Response for the virtual networks GetUsage API service call. */
export interface VirtualNetworkListUsageResult {
  /**
   * VirtualNetwork usage stats.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly value?: VirtualNetworkUsage[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Usage details for subnet. */
export interface VirtualNetworkUsage {
  /**
   * Indicates number of IPs used from the Subnet.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly currentValue?: number;
  /**
   * Subnet identifier.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * Indicates the size of the subnet.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly limit?: number;
  /**
   * The name containing common and localized value for usage.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: VirtualNetworkUsageName;
  /**
   * Usage units. Returns 'Count'.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly unit?: string;
}

/** Usage strings container. */
export interface VirtualNetworkUsageName {
  /**
   * Localized subnet size and usage string.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly localizedValue?: string;
  /**
   * Subnet size and usage string.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly value?: string;
}

/** VirtualNetworkGatewaySku details. */
export interface VirtualNetworkGatewaySku {
  /** Gateway SKU name. */
  name?: VirtualNetworkGatewaySkuName;
  /** Gateway SKU tier. */
  tier?: VirtualNetworkGatewaySkuTier;
  /**
   * The capacity.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly capacity?: number;
}

/** VpnClientConfiguration for P2S client. */
export interface VpnClientConfiguration {
  /** The reference to the address space resource which represents Address space for P2S VpnClient. */
  vpnClientAddressPool?: AddressSpace;
  /** VpnClientRootCertificate for virtual network gateway. */
  vpnClientRootCertificates?: VpnClientRootCertificate[];
  /** VpnClientRevokedCertificate for Virtual network gateway. */
  vpnClientRevokedCertificates?: VpnClientRevokedCertificate[];
  /** VpnClientProtocols for Virtual network gateway. */
  vpnClientProtocols?: VpnClientProtocol[];
  /** VPN authentication types for the virtual network gateway.. */
  vpnAuthenticationTypes?: VpnAuthenticationType[];
  /** VpnClientIpsecPolicies for virtual network gateway P2S client. */
  vpnClientIpsecPolicies?: IpsecPolicy[];
  /** The radius server address property of the VirtualNetworkGateway resource for vpn client connection. */
  radiusServerAddress?: string;
  /** The radius secret property of the VirtualNetworkGateway resource for vpn client connection. */
  radiusServerSecret?: string;
  /** The radiusServers property for multiple radius server configuration. */
  radiusServers?: RadiusServer[];
  /** The AADTenant property of the VirtualNetworkGateway resource for vpn client connection used for AAD authentication. */
  aadTenant?: string;
  /** The AADAudience property of the VirtualNetworkGateway resource for vpn client connection used for AAD authentication. */
  aadAudience?: string;
  /** The AADIssuer property of the VirtualNetworkGateway resource for vpn client connection used for AAD authentication. */
  aadIssuer?: string;
}

/** An IPSec Policy configuration for a virtual network gateway connection. */
export interface IpsecPolicy {
  /** The IPSec Security Association (also called Quick Mode or Phase 2 SA) lifetime in seconds for a site to site VPN tunnel. */
  saLifeTimeSeconds: number;
  /** The IPSec Security Association (also called Quick Mode or Phase 2 SA) payload size in KB for a site to site VPN tunnel. */
  saDataSizeKilobytes: number;
  /** The IPSec encryption algorithm (IKE phase 1). */
  ipsecEncryption: IpsecEncryption;
  /** The IPSec integrity algorithm (IKE phase 1). */
  ipsecIntegrity: IpsecIntegrity;
  /** The IKE encryption algorithm (IKE phase 2). */
  ikeEncryption: IkeEncryption;
  /** The IKE integrity algorithm (IKE phase 2). */
  ikeIntegrity: IkeIntegrity;
  /** The DH Group used in IKE Phase 1 for initial SA. */
  dhGroup: DhGroup;
  /** The Pfs Group used in IKE Phase 2 for new child SA. */
  pfsGroup: PfsGroup;
}

/** Radius Server Settings. */
export interface RadiusServer {
  /** The address of this radius server. */
  radiusServerAddress: string;
  /** The initial score assigned to this radius server. */
  radiusServerScore?: number;
  /** The secret used for this radius server. */
  radiusServerSecret?: string;
}

/** BGP settings details. */
export interface BgpSettings {
  /** The BGP speaker's ASN. */
  asn?: number;
  /** The BGP peering address and BGP identifier of this BGP speaker. */
  bgpPeeringAddress?: string;
  /** The weight added to routes learned from this BGP speaker. */
  peerWeight?: number;
  /** BGP peering address with IP configuration ID for virtual network gateway. */
  bgpPeeringAddresses?: IPConfigurationBgpPeeringAddress[];
}

/** Properties of IPConfigurationBgpPeeringAddress. */
export interface IPConfigurationBgpPeeringAddress {
  /** The ID of IP configuration which belongs to gateway. */
  ipconfigurationId?: string;
  /**
   * The list of default BGP peering addresses which belong to IP configuration.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly defaultBgpIpAddresses?: string[];
  /** The list of custom BGP peering addresses which belong to IP configuration. */
  customBgpIpAddresses?: string[];
  /**
   * The list of tunnel public IP addresses which belong to IP configuration.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly tunnelIpAddresses?: string[];
}

/** Vpn NatRule mapping. */
export interface VpnNatRuleMapping {
  /** Address space for Vpn NatRule mapping. */
  addressSpace?: string;
  /** Port range for Vpn NatRule mapping. */
  portRange?: string;
}

/** Response for the ListVirtualNetworkGateways API service call. */
export interface VirtualNetworkGatewayListResult {
  /** A list of VirtualNetworkGateway resources that exists in a resource group. */
  value?: VirtualNetworkGateway[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Response for the VirtualNetworkGatewayListConnections API service call. */
export interface VirtualNetworkGatewayListConnectionsResult {
  /** A list of VirtualNetworkGatewayConnection resources that exists in a resource group. */
  value?: VirtualNetworkGatewayConnectionListEntity[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** A reference to VirtualNetworkGateway or LocalNetworkGateway resource. */
export interface VirtualNetworkConnectionGatewayReference {
  /** The ID of VirtualNetworkGateway or LocalNetworkGateway resource. */
  id: string;
}

/** VirtualNetworkGatewayConnection properties. */
export interface TunnelConnectionHealth {
  /**
   * Tunnel name.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly tunnel?: string;
  /**
   * Virtual Network Gateway connection status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionStatus?: VirtualNetworkGatewayConnectionStatus;
  /**
   * The Ingress Bytes Transferred in this connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ingressBytesTransferred?: number;
  /**
   * The Egress Bytes Transferred in this connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly egressBytesTransferred?: number;
  /**
   * The time at which connection was established in Utc format.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly lastConnectionEstablishedUtcTime?: string;
}

/** GatewayCustomBgpIpAddressIpConfiguration for a virtual network gateway connection. */
export interface GatewayCustomBgpIpAddressIpConfiguration {
  /** The IpconfigurationId of ipconfiguration which belongs to gateway. */
  ipConfigurationId: string;
  /** The custom BgpPeeringAddress which belongs to IpconfigurationId. */
  customBgpIpAddress: string;
}

/** An traffic selector policy for a virtual network gateway connection. */
export interface TrafficSelectorPolicy {
  /** A collection of local address spaces in CIDR format. */
  localAddressRanges: string[];
  /** A collection of remote address spaces in CIDR format. */
  remoteAddressRanges: string[];
}

/** Vpn Client Parameters for package generation. */
export interface VpnClientParameters {
  /** VPN client Processor Architecture. */
  processorArchitecture?: ProcessorArchitecture;
  /** VPN client authentication method. */
  authenticationMethod?: AuthenticationMethod;
  /** The public certificate data for the radius server authentication certificate as a Base-64 encoded string. Required only if external radius authentication has been configured with EAPTLS authentication. */
  radiusServerAuthCertificate?: string;
  /** A list of client root certificates public certificate data encoded as Base-64 strings. Optional parameter for external radius based authentication with EAPTLS. */
  clientRootCertificates?: string[];
}

/** Response for list BGP peer status API service call. */
export interface BgpPeerStatusListResult {
  /** List of BGP peers. */
  value?: BgpPeerStatus[];
}

/** BGP peer status details. */
export interface BgpPeerStatus {
  /**
   * The virtual network gateway's local address.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly localAddress?: string;
  /**
   * The remote BGP peer.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly neighbor?: string;
  /**
   * The autonomous system number of the remote BGP peer.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly asn?: number;
  /**
   * The BGP peer state.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly state?: BgpPeerState;
  /**
   * For how long the peering has been up.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectedDuration?: string;
  /**
   * The number of routes learned from this peer.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly routesReceived?: number;
  /**
   * The number of BGP messages sent.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly messagesSent?: number;
  /**
   * The number of BGP messages received.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly messagesReceived?: number;
}

/** List of virtual network gateway routes. */
export interface GatewayRouteListResult {
  /** List of gateway routes. */
  value?: GatewayRoute[];
}

/** Gateway routing details. */
export interface GatewayRoute {
  /**
   * The gateway's local address.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly localAddress?: string;
  /**
   * The route's network prefix.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly network?: string;
  /**
   * The route's next hop.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextHop?: string;
  /**
   * The peer this route was learned from.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sourcePeer?: string;
  /**
   * The source this route was learned from.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly origin?: string;
  /**
   * The route's AS path sequence.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly asPath?: string;
  /**
   * The route's weight.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly weight?: number;
}

/** An IPSec parameters for a virtual network gateway P2S connection. */
export interface VpnClientIPsecParameters {
  /** The IPSec Security Association (also called Quick Mode or Phase 2 SA) lifetime in seconds for P2S client. */
  saLifeTimeSeconds: number;
  /** The IPSec Security Association (also called Quick Mode or Phase 2 SA) payload size in KB for P2S client.. */
  saDataSizeKilobytes: number;
  /** The IPSec encryption algorithm (IKE phase 1). */
  ipsecEncryption: IpsecEncryption;
  /** The IPSec integrity algorithm (IKE phase 1). */
  ipsecIntegrity: IpsecIntegrity;
  /** The IKE encryption algorithm (IKE phase 2). */
  ikeEncryption: IkeEncryption;
  /** The IKE integrity algorithm (IKE phase 2). */
  ikeIntegrity: IkeIntegrity;
  /** The DH Group used in IKE Phase 1 for initial SA. */
  dhGroup: DhGroup;
  /** The Pfs Group used in IKE Phase 2 for new child SA. */
  pfsGroup: PfsGroup;
}

/** Vpn device configuration script generation parameters. */
export interface VpnDeviceScriptParameters {
  /** The vendor for the vpn device. */
  vendor?: string;
  /** The device family for the vpn device. */
  deviceFamily?: string;
  /** The firmware version for the vpn device. */
  firmwareVersion?: string;
}

/** Start packet capture parameters on virtual network gateway. */
export interface VpnPacketCaptureStartParameters {
  /** Start Packet capture parameters. */
  filterData?: string;
}

/** Stop packet capture parameters. */
export interface VpnPacketCaptureStopParameters {
  /** SAS url for packet capture on virtual network gateway. */
  sasUrl?: string;
}

/** Response for the ListVirtualNetworkGatewayConnections API service call. */
export interface VirtualNetworkGatewayConnectionListResult {
  /** A list of VirtualNetworkGatewayConnection resources that exists in a resource group. */
  value?: VirtualNetworkGatewayConnection[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** The virtual network connection reset shared key. */
export interface ConnectionResetSharedKey {
  /** The virtual network connection reset shared key length, should between 1 and 128. */
  keyLength: number;
}

/** Response for ListLocalNetworkGateways API service call. */
export interface LocalNetworkGatewayListResult {
  /** A list of local network gateways that exists in a resource group. */
  value?: LocalNetworkGateway[];
  /**
   * The URL to get the next set of results.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** List of virtual network gateway vpn client connection health. */
export interface VpnClientConnectionHealthDetailListResult {
  /** List of vpn client connection health. */
  value?: VpnClientConnectionHealthDetail[];
}

/** VPN client connection health detail. */
export interface VpnClientConnectionHealthDetail {
  /**
   * The vpn client Id.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly vpnConnectionId?: string;
  /**
   * The duration time of a connected vpn client.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly vpnConnectionDuration?: number;
  /**
   * The start time of a connected vpn client.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly vpnConnectionTime?: string;
  /**
   * The public Ip of a connected vpn client.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly publicIpAddress?: string;
  /**
   * The assigned private Ip of a connected vpn client.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateIpAddress?: string;
  /**
   * The user name of a connected vpn client.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly vpnUserName?: string;
  /**
   * The max band width.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly maxBandwidth?: number;
  /**
   * The egress packets per second.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly egressPacketsTransferred?: number;
  /**
   * The egress bytes per second.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly egressBytesTransferred?: number;
  /**
   * The ingress packets per second.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ingressPacketsTransferred?: number;
  /**
   * The ingress bytes per second.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ingressBytesTransferred?: number;
  /**
   * The max packets transferred per second.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly maxPacketsPerSecond?: number;
}

/** List of p2s vpn connections to be disconnected. */
export interface P2SVpnConnectionRequest {
  /** List of p2s vpn connection Ids. */
  vpnConnectionIds?: string[];
}

/** Result of the request to list all nat rules to a virtual network gateway. It contains a list of Nat rules and a URL nextLink to get the next set of results. */
export interface ListVirtualNetworkGatewayNatRulesResult {
  /** List of Nat Rules. */
  value?: VirtualNetworkGatewayNatRule[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Response for ListVirtualNetworkTap API service call. */
export interface VirtualNetworkTapListResult {
  /** A list of VirtualNetworkTaps in a resource group. */
  value?: VirtualNetworkTap[];
  /** The URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListVirtualRouters API service call. */
export interface VirtualRouterListResult {
  /** List of Virtual Routers. */
  value?: VirtualRouter[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Response for ListVirtualRouterPeerings API service call. */
export interface VirtualRouterPeeringListResult {
  /** List of VirtualRouterPeerings in a VirtualRouter. */
  value?: VirtualRouterPeering[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** Result of the request to list VirtualWANs. It contains a list of VirtualWANs and a URL nextLink to get the next set of results. */
export interface ListVirtualWANsResult {
  /** List of VirtualWANs. */
  value?: VirtualWAN[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** List of properties of the device. */
export interface DeviceProperties {
  /** Name of the device Vendor. */
  deviceVendor?: string;
  /** Model of the device. */
  deviceModel?: string;
  /** Link speed. */
  linkSpeedInMbps?: number;
}

/** List of properties of a link provider. */
export interface VpnLinkProviderProperties {
  /** Name of the link provider. */
  linkProviderName?: string;
  /** Link speed. */
  linkSpeedInMbps?: number;
}

/** BGP settings details for a link. */
export interface VpnLinkBgpSettings {
  /** The BGP speaker's ASN. */
  asn?: number;
  /** The BGP peering address and BGP identifier of this BGP speaker. */
  bgpPeeringAddress?: string;
}

/** The Office365 breakout policy. */
export interface O365PolicyProperties {
  /** Office365 breakout categories. */
  breakOutCategories?: O365BreakOutCategoryPolicies;
}

/** Office365 breakout categories. */
export interface O365BreakOutCategoryPolicies {
  /** Flag to control allow category. */
  allow?: boolean;
  /** Flag to control optimize category. */
  optimize?: boolean;
  /** Flag to control default category. */
  default?: boolean;
}

/** Result of the request to list VpnSites. It contains a list of VpnSites and a URL nextLink to get the next set of results. */
export interface ListVpnSitesResult {
  /** List of VpnSites. */
  value?: VpnSite[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Result of the request to list VpnSiteLinks. It contains a list of VpnSiteLinks and a URL nextLink to get the next set of results. */
export interface ListVpnSiteLinksResult {
  /** List of VpnSitesLinks. */
  value?: VpnSiteLink[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** List of Vpn-Sites. */
export interface GetVpnSitesConfigurationRequest {
  /** List of resource-ids of the vpn-sites for which config is to be downloaded. */
  vpnSites?: string[];
  /** The sas-url to download the configurations for vpn-sites. */
  outputBlobSasUrl: string;
}

/** Collection of SecurityProviders. */
export interface VirtualWanSecurityProviders {
  /** List of VirtualWAN security providers. */
  supportedProviders?: VirtualWanSecurityProvider[];
}

/** Collection of SecurityProviders. */
export interface VirtualWanSecurityProvider {
  /** Name of the security provider. */
  name?: string;
  /** Url of the security provider. */
  url?: string;
  /**
   * Name of the security provider.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: VirtualWanSecurityProviderType;
}

/** Properties of VPN client root certificate of VpnServerConfiguration. */
export interface VpnServerConfigVpnClientRootCertificate {
  /** The certificate name. */
  name?: string;
  /** The certificate public data. */
  publicCertData?: string;
}

/** Properties of the revoked VPN client certificate of VpnServerConfiguration. */
export interface VpnServerConfigVpnClientRevokedCertificate {
  /** The certificate name. */
  name?: string;
  /** The revoked VPN client certificate thumbprint. */
  thumbprint?: string;
}

/** Properties of Radius Server root certificate of VpnServerConfiguration. */
export interface VpnServerConfigRadiusServerRootCertificate {
  /** The certificate name. */
  name?: string;
  /** The certificate public data. */
  publicCertData?: string;
}

/** Properties of the Radius client root certificate of VpnServerConfiguration. */
export interface VpnServerConfigRadiusClientRootCertificate {
  /** The certificate name. */
  name?: string;
  /** The Radius client root certificate thumbprint. */
  thumbprint?: string;
}

/** AAD Vpn authentication type related parameters. */
export interface AadAuthenticationParameters {
  /** AAD Vpn authentication parameter AAD tenant. */
  aadTenant?: string;
  /** AAD Vpn authentication parameter AAD audience. */
  aadAudience?: string;
  /** AAD Vpn authentication parameter AAD issuer. */
  aadIssuer?: string;
}

/** Routing Configuration indicating the associated and propagated route tables for this connection. */
export interface RoutingConfiguration {
  /** The resource id RouteTable associated with this RoutingConfiguration. */
  associatedRouteTable?: SubResource;
  /** The list of RouteTables to advertise the routes to. */
  propagatedRouteTables?: PropagatedRouteTable;
  /** List of routes that control routing from VirtualHub into a virtual network connection. */
  vnetRoutes?: VnetRoute;
}

/** The list of RouteTables to advertise the routes to. */
export interface PropagatedRouteTable {
  /** The list of labels. */
  labels?: string[];
  /** The list of resource ids of all the RouteTables. */
  ids?: SubResource[];
}

/** List of routes that control routing from VirtualHub into a virtual network connection. */
export interface VnetRoute {
  /** List of all Static Routes. */
  staticRoutes?: StaticRoute[];
  /**
   * The list of references to HubBgpConnection objects.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly bgpConnections?: SubResource[];
}

/** List of all Static Routes. */
export interface StaticRoute {
  /** The name of the StaticRoute that is unique within a VnetRoute. */
  name?: string;
  /** List of all address prefixes. */
  addressPrefixes?: string[];
  /** The ip address of the next hop. */
  nextHopIpAddress?: string;
}

/** VpnServerConfiguration PolicyGroup member */
export interface VpnServerConfigurationPolicyGroupMember {
  /** Name of the VpnServerConfigurationPolicyGroupMember. */
  name?: string;
  /** The Vpn Policy member attribute type. */
  attributeType?: VpnPolicyMemberAttributeType;
  /** The value of Attribute used for this VpnServerConfigurationPolicyGroupMember. */
  attributeValue?: string;
}

/** VpnClientConnectionHealth properties. */
export interface VpnClientConnectionHealth {
  /**
   * Total of the Ingress Bytes Transferred in this P2S Vpn connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly totalIngressBytesTransferred?: number;
  /**
   * Total of the Egress Bytes Transferred in this connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly totalEgressBytesTransferred?: number;
  /** The total of p2s vpn clients connected at this time to this P2SVpnGateway. */
  vpnClientConnectionsCount?: number;
  /** List of allocated ip addresses to the connected p2s vpn clients. */
  allocatedIpAddresses?: string[];
}

/** Result of the request to list all VpnServerConfigurations. It contains a list of VpnServerConfigurations and a URL nextLink to get the next set of results. */
export interface ListVpnServerConfigurationsResult {
  /** List of VpnServerConfigurations. */
  value?: VpnServerConfiguration[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Result of the request to list VpnServerConfigurationPolicyGroups. It contains a list of VpnServerConfigurationPolicyGroups and a URL nextLink to get the next set of results. */
export interface ListVpnServerConfigurationPolicyGroupsResult {
  /** List of VpnServerConfigurationPolicyGroups. */
  value?: VpnServerConfigurationPolicyGroup[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** VirtualHub route table. */
export interface VirtualHubRouteTable {
  /** List of all routes. */
  routes?: VirtualHubRoute[];
}

/** VirtualHub route. */
export interface VirtualHubRoute {
  /** List of all addressPrefixes. */
  addressPrefixes?: string[];
  /** NextHop ip address. */
  nextHopIpAddress?: string;
}

/** VirtualHubRouteTableV2 route. */
export interface VirtualHubRouteV2 {
  /** The type of destinations. */
  destinationType?: string;
  /** List of all destinations. */
  destinations?: string[];
  /** The type of next hops. */
  nextHopType?: string;
  /** NextHops ip address. */
  nextHops?: string[];
}

/** The VirtualHub Router autoscale configuration. */
export interface VirtualRouterAutoScaleConfiguration {
  /** The minimum number of scale units for VirtualHub Router. */
  minCapacity?: number;
}

/** Result of the request to list VirtualHubs. It contains a list of VirtualHubs and a URL nextLink to get the next set of results. */
export interface ListVirtualHubsResult {
  /** List of VirtualHubs. */
  value?: VirtualHub[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** List of HubVirtualNetworkConnections and a URL nextLink to get the next set of results. */
export interface ListHubVirtualNetworkConnectionsResult {
  /** List of HubVirtualNetworkConnections. */
  value?: HubVirtualNetworkConnection[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** IP Configuration of a VPN Gateway Resource. */
export interface VpnGatewayIpConfiguration {
  /** The identifier of the IP configuration for a VPN Gateway. */
  id?: string;
  /** The public IP address of this IP configuration. */
  publicIpAddress?: string;
  /** The private IP address of this IP configuration. */
  privateIpAddress?: string;
}

/** Start packet capture parameters. */
export interface VpnGatewayPacketCaptureStartParameters {
  /** Start Packet capture parameters on vpn gateway. */
  filterData?: string;
}

/** Stop packet capture parameters. */
export interface VpnGatewayPacketCaptureStopParameters {
  /** SAS url for packet capture on vpn gateway. */
  sasUrl?: string;
}

/** Result of the request to list VpnGateways. It contains a list of VpnGateways and a URL nextLink to get the next set of results. */
export interface ListVpnGatewaysResult {
  /** List of VpnGateways. */
  value?: VpnGateway[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Vpn Connection packet capture parameters supplied to start packet capture on gateway connection. */
export interface VpnConnectionPacketCaptureStartParameters {
  /** Start Packet capture parameters on vpn connection. */
  filterData?: string;
  /** List of site link connection names. */
  linkConnectionNames?: string[];
}

/** Vpn Connection packet capture parameters supplied to stop packet capture on gateway connection. */
export interface VpnConnectionPacketCaptureStopParameters {
  /** SAS url for packet capture on vpn connection. */
  sasUrl?: string;
  /** List of site link connection names. */
  linkConnectionNames?: string[];
}

/** Result of the request to list all vpn connections to a virtual wan vpn gateway. It contains a list of Vpn Connections and a URL nextLink to get the next set of results. */
export interface ListVpnConnectionsResult {
  /** List of Vpn Connections. */
  value?: VpnConnection[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Result of the request to list all vpn connections to a virtual wan vpn gateway. It contains a list of Vpn Connections and a URL nextLink to get the next set of results. */
export interface ListVpnSiteLinkConnectionsResult {
  /** List of VpnSiteLinkConnections. */
  value?: VpnSiteLinkConnection[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Result of the request to list all nat rules to a virtual wan vpn gateway. It contains a list of Nat rules and a URL nextLink to get the next set of results. */
export interface ListVpnGatewayNatRulesResult {
  /** List of Nat Rules. */
  value?: VpnGatewayNatRule[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Result of the request to list P2SVpnGateways. It contains a list of P2SVpnGateways and a URL nextLink to get the next set of results. */
export interface ListP2SVpnGatewaysResult {
  /** List of P2SVpnGateways. */
  value?: P2SVpnGateway[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Vpn Client Parameters for package generation. */
export interface P2SVpnProfileParameters {
  /** VPN client authentication method. */
  authenticationMethod?: AuthenticationMethod;
}

/** Vpn Profile Response for package generation. */
export interface VpnProfileResponse {
  /** URL to the VPN profile. */
  profileUrl?: string;
}

/** List of P2S Vpn connection health request. */
export interface P2SVpnConnectionHealthRequest {
  /** The list of p2s vpn user names whose p2s vpn connection detailed health to retrieve for. */
  vpnUserNamesFilter?: string[];
  /** The sas-url to download the P2S Vpn connection health detail. */
  outputBlobSasUrl?: string;
}

/** P2S Vpn connection detailed health written to sas url. */
export interface P2SVpnConnectionHealth {
  /** Returned sas url of the blob to which the p2s vpn connection detailed health will be written. */
  sasUrl?: string;
}

/** VpnServerConfigurations list associated with VirtualWan Response. */
export interface VpnServerConfigurationsResponse {
  /** List of VpnServerConfigurations associated with VirtualWan. */
  vpnServerConfigurationResourceIds?: string[];
}

/** Virtual Wan Vpn profile parameters Vpn profile generation. */
export interface VirtualWanVpnProfileParameters {
  /** VpnServerConfiguration partial resource uri with which VirtualWan is associated to. */
  vpnServerConfigurationResourceId?: string;
  /** VPN client authentication method. */
  authenticationMethod?: AuthenticationMethod;
}

/** List of VirtualHubRouteTableV2s and a URL nextLink to get the next set of results. */
export interface ListVirtualHubRouteTableV2SResult {
  /** List of VirtualHubRouteTableV2s. */
  value?: VirtualHubRouteTableV2[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** List of ExpressRoute gateways. */
export interface ExpressRouteGatewayList {
  /** List of ExpressRoute gateways. */
  value?: ExpressRouteGateway[];
}

/** Configuration for auto scaling. */
export interface ExpressRouteGatewayPropertiesAutoScaleConfiguration {
  /** Minimum and maximum number of scale units to deploy. */
  bounds?: ExpressRouteGatewayPropertiesAutoScaleConfigurationBounds;
}

/** Minimum and maximum number of scale units to deploy. */
export interface ExpressRouteGatewayPropertiesAutoScaleConfigurationBounds {
  /** Minimum number of scale units deployed for ExpressRoute gateway. */
  min?: number;
  /** Maximum number of scale units deployed for ExpressRoute gateway. */
  max?: number;
}

/** ExpressRoute circuit peering identifier. */
export interface ExpressRouteCircuitPeeringId {
  /** The ID of the ExpressRoute circuit peering. */
  id?: string;
}

/** Virtual Hub identifier. */
export interface VirtualHubId {
  /** The resource URI for the Virtual Hub where the ExpressRoute gateway is or will be deployed. The Virtual Hub resource and the ExpressRoute gateway resource reside in the same subscription. */
  id?: string;
}

/** ExpressRouteConnection list. */
export interface ExpressRouteConnectionList {
  /** The list of ExpressRoute connections. */
  value?: ExpressRouteConnection[];
}

/** VirtualHubBgpConnections list. */
export interface ListVirtualHubBgpConnectionResults {
  /** The list of VirtualHubBgpConnections. */
  value?: BgpConnection[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** List of virtual router peer routes. */
export interface PeerRouteList {
  /** List of peer routes. */
  value?: PeerRoute[];
}

/** Peer routing details. */
export interface PeerRoute {
  /**
   * The peer's local address.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly localAddress?: string;
  /**
   * The route's network prefix.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly network?: string;
  /**
   * The route's next hop.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextHop?: string;
  /**
   * The peer this route was learned from.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sourcePeer?: string;
  /**
   * The source this route was learned from.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly origin?: string;
  /**
   * The route's AS path sequence.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly asPath?: string;
  /**
   * The route's weight.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly weight?: number;
}

/** VirtualHubIpConfigurations list. */
export interface ListVirtualHubIpConfigurationResults {
  /** The list of VirtualHubIpConfigurations. */
  value?: HubIpConfiguration[];
  /** URL to get the next set of results. */
  nextLink?: string;
}

/** RouteTable route. */
export interface HubRoute {
  /** The name of the Route that is unique within a RouteTable. This name can be used to access this route. */
  name: string;
  /** The type of destinations (eg: CIDR, ResourceId, Service). */
  destinationType: string;
  /** List of all destinations. */
  destinations: string[];
  /** The type of next hop (eg: ResourceId). */
  nextHopType: string;
  /** NextHop resource ID. */
  nextHop: string;
}

/** List of RouteTables and a URL nextLink to get the next set of results. */
export interface ListHubRouteTablesResult {
  /** List of RouteTables. */
  value?: HubRouteTable[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** The parameters specifying the resource whose effective routes are being requested. */
export interface EffectiveRoutesParameters {
  /** The resource whose effective routes are being requested. */
  resourceId?: string;
  /** The type of the specified resource like RouteTable, ExpressRouteConnection, HubVirtualNetworkConnection, VpnConnection and P2SConnection. */
  virtualWanResourceType?: string;
}

/** The routing policy object used in a RoutingIntent resource. */
export interface RoutingPolicy {
  /** The unique name for the routing policy. */
  name: string;
  /** List of all destinations which this routing policy is applicable to (for example: Internet, PrivateTraffic). */
  destinations: string[];
  /** The next hop resource id on which this routing policy is applicable to. */
  nextHop: string;
}

/** List of the routing intent result and a URL nextLink to get the next set of results. */
export interface ListRoutingIntentResult {
  /** List of RoutingIntent resource. */
  value?: RoutingIntent[];
  /** URL to get the next set of operation list results if there are any. */
  nextLink?: string;
}

/** Result of the request to list WebApplicationFirewallPolicies. It contains a list of WebApplicationFirewallPolicy objects and a URL link to get the next set of results. */
export interface WebApplicationFirewallPolicyListResult {
  /**
   * List of WebApplicationFirewallPolicies within a resource group.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly value?: WebApplicationFirewallPolicy[];
  /**
   * URL to get the next set of WebApplicationFirewallPolicy objects if there are any.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Defines contents of a web application firewall global configuration. */
export interface PolicySettings {
  /** The state of the policy. */
  state?: WebApplicationFirewallEnabledState;
  /** The mode of the policy. */
  mode?: WebApplicationFirewallMode;
  /** Whether to allow WAF to check request Body. */
  requestBodyCheck?: boolean;
  /** Maximum request body size in Kb for WAF. */
  maxRequestBodySizeInKb?: number;
  /** Maximum file upload size in Mb for WAF. */
  fileUploadLimitInMb?: number;
}

/** Defines contents of a web application rule. */
export interface WebApplicationFirewallCustomRule {
  /** The name of the resource that is unique within a policy. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Priority of the rule. Rules with a lower value will be evaluated before rules with a higher value. */
  priority: number;
  /** The rule type. */
  ruleType: WebApplicationFirewallRuleType;
  /** List of match conditions. */
  matchConditions: MatchCondition[];
  /** Type of Actions. */
  action: WebApplicationFirewallAction;
}

/** Define match conditions. */
export interface MatchCondition {
  /** List of match variables. */
  matchVariables: MatchVariable[];
  /** The operator to be matched. */
  operator: WebApplicationFirewallOperator;
  /** Whether this is negate condition or not. */
  negationConditon?: boolean;
  /** Match value. */
  matchValues: string[];
  /** List of transforms. */
  transforms?: WebApplicationFirewallTransform[];
}

/** Define match variables. */
export interface MatchVariable {
  /** Match Variable. */
  variableName: WebApplicationFirewallMatchVariable;
  /** The selector of match variable. */
  selector?: string;
}

/** Allow to exclude some variable satisfy the condition for the WAF check. */
export interface ManagedRulesDefinition {
  /** The Exclusions that are applied on the policy. */
  exclusions?: OwaspCrsExclusionEntry[];
  /** The managed rule sets that are associated with the policy. */
  managedRuleSets: ManagedRuleSet[];
}

/** Allow to exclude some variable satisfy the condition for the WAF check. */
export interface OwaspCrsExclusionEntry {
  /** The variable to be excluded. */
  matchVariable: OwaspCrsExclusionEntryMatchVariable;
  /** When matchVariable is a collection, operate on the selector to specify which elements in the collection this exclusion applies to. */
  selectorMatchOperator: OwaspCrsExclusionEntrySelectorMatchOperator;
  /** When matchVariable is a collection, operator used to specify which elements in the collection this exclusion applies to. */
  selector: string;
  /** The managed rule sets that are associated with the exclusion. */
  exclusionManagedRuleSets?: ExclusionManagedRuleSet[];
}

/** Defines a managed rule set for Exclusions. */
export interface ExclusionManagedRuleSet {
  /** Defines the rule set type to use. */
  ruleSetType: string;
  /** Defines the version of the rule set to use. */
  ruleSetVersion: string;
  /** Defines the rule groups to apply to the rule set. */
  ruleGroups?: ExclusionManagedRuleGroup[];
}

/** Defines a managed rule group to use for exclusion. */
export interface ExclusionManagedRuleGroup {
  /** The managed rule group for exclusion. */
  ruleGroupName: string;
  /** List of rules that will be excluded. If none specified, all rules in the group will be excluded. */
  rules?: ExclusionManagedRule[];
}

/** Defines a managed rule to use for exclusion. */
export interface ExclusionManagedRule {
  /** Identifier for the managed rule. */
  ruleId: string;
}

/** Defines a managed rule set. */
export interface ManagedRuleSet {
  /** Defines the rule set type to use. */
  ruleSetType: string;
  /** Defines the version of the rule set to use. */
  ruleSetVersion: string;
  /** Defines the rule group overrides to apply to the rule set. */
  ruleGroupOverrides?: ManagedRuleGroupOverride[];
}

/** Defines a managed rule group override setting. */
export interface ManagedRuleGroupOverride {
  /** The managed rule group to override. */
  ruleGroupName: string;
  /** List of rules that will be disabled. If none specified, all rules in the group will be disabled. */
  rules?: ManagedRuleOverride[];
}

/** Defines a managed rule group override setting. */
export interface ManagedRuleOverride {
  /** Identifier for the managed rule. */
  ruleId: string;
  /** The state of the managed rule. Defaults to Disabled if not specified. */
  state?: ManagedRuleEnabledState;
}

/** SwapResource to represent slot type on the specified cloud service. */
export interface SwapResource {
  /**
   * Resource Id.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * Resource name.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Swap resource properties */
  properties?: SwapResourceProperties;
}

/** Swap resource properties */
export interface SwapResourceProperties {
  /** Specifies slot info on a cloud service */
  slotType?: SlotType;
}

/** SwapResource List with single entry to represent slot type on the specified cloud service. */
export interface SwapResourceListResult {
  value?: SwapResource[];
}

/** Properties of the FirewallPolicyNatRuleCollectionAction. */
export interface FirewallPolicyNatRuleCollectionAction {
  /** The type of action. */
  type?: FirewallPolicyNatRuleCollectionActionType;
}

/** Properties of a rule. */
export interface FirewallPolicyRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  ruleType: "ApplicationRule" | "NatRule" | "NetworkRule";
  /** Name of the rule. */
  name?: string;
  /** Description of the rule. */
  description?: string;
}

/** Properties of the FirewallPolicyFilterRuleCollectionAction. */
export interface FirewallPolicyFilterRuleCollectionAction {
  /** The type of action. */
  type?: FirewallPolicyFilterRuleCollectionActionType;
}

/** Properties of the application rule protocol. */
export interface FirewallPolicyRuleApplicationProtocol {
  /** Protocol type. */
  protocolType?: FirewallPolicyRuleApplicationProtocolType;
  /** Port number for the protocol, cannot be greater than 64000. */
  port?: number;
}

/** The response body contains the status of the specified asynchronous operation, indicating whether it has succeeded, is in progress, or has failed. Note that this status is distinct from the HTTP status code returned for the Get Operation Status operation itself. If the asynchronous operation succeeded, the response body includes the HTTP status code for the successful request. If the asynchronous operation failed, the response body includes the HTTP status code for the failed request and error information regarding the failure. */
export interface AzureAsyncOperationResult {
  /** Status of the Azure async operation. */
  status?: NetworkOperationStatus;
  /** Details of the error occurred during specified asynchronous operation. */
  error?: ErrorModel;
}

/** Address prefix item. */
export interface AddressPrefixItem {
  /** Address prefix. */
  addressPrefix?: string;
  /** Address prefix type. */
  addressPrefixType?: AddressPrefixType;
}

/** VpnSite Resource. */
export interface VpnSiteId {
  /**
   * The resource-uri of the vpn-site for which config is to be fetched.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly vpnSite?: string;
}

/** EffectiveRoutes List. */
export interface VirtualHubEffectiveRouteList {
  /** The list of effective routes configured on the virtual hub or the specified resource. */
  value?: VirtualHubEffectiveRoute[];
}

/** The effective route configured on the virtual hub or specified resource. */
export interface VirtualHubEffectiveRoute {
  /** The list of address prefixes. */
  addressPrefixes?: string[];
  /** The list of next hops. */
  nextHops?: string[];
  /** The type of the next hop. */
  nextHopType?: string;
  /** The ASPath of this route. */
  asPath?: string;
  /** The origin of this route. */
  routeOrigin?: string;
}

/** IP configuration of an application gateway. Currently 1 public and 1 private IP configuration is allowed. */
export interface ApplicationGatewayIPConfiguration extends SubResource {
  /** Name of the IP configuration that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Reference to the subnet resource. A subnet from where application gateway gets its private address. */
  subnet?: SubResource;
  /**
   * The provisioning state of the application gateway IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Authentication certificates of an application gateway. */
export interface ApplicationGatewayAuthenticationCertificate
  extends SubResource {
  /** Name of the authentication certificate that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Certificate public data. */
  data?: string;
  /**
   * The provisioning state of the authentication certificate resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Trusted Root certificates of an application gateway. */
export interface ApplicationGatewayTrustedRootCertificate extends SubResource {
  /** Name of the trusted root certificate that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Certificate public data. */
  data?: string;
  /** Secret Id of (base-64 encoded unencrypted pfx) 'Secret' or 'Certificate' object stored in KeyVault. */
  keyVaultSecretId?: string;
  /**
   * The provisioning state of the trusted root certificate resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Trusted client certificates of an application gateway. */
export interface ApplicationGatewayTrustedClientCertificate
  extends SubResource {
  /** Name of the trusted client certificate that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Certificate public data. */
  data?: string;
  /**
   * Validated certificate data.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly validatedCertData?: string;
  /**
   * Distinguished name of client certificate issuer.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly clientCertIssuerDN?: string;
  /**
   * The provisioning state of the trusted client certificate resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** SSL certificates of an application gateway. */
export interface ApplicationGatewaySslCertificate extends SubResource {
  /** Name of the SSL certificate that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Base-64 encoded pfx certificate. Only applicable in PUT Request. */
  data?: string;
  /** Password for the pfx file specified in data. Only applicable in PUT request. */
  password?: string;
  /**
   * Base-64 encoded Public cert data corresponding to pfx specified in data. Only applicable in GET request.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly publicCertData?: string;
  /** Secret Id of (base-64 encoded unencrypted pfx) 'Secret' or 'Certificate' object stored in KeyVault. */
  keyVaultSecretId?: string;
  /**
   * The provisioning state of the SSL certificate resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Frontend IP configuration of an application gateway. */
export interface ApplicationGatewayFrontendIPConfiguration extends SubResource {
  /** Name of the frontend IP configuration that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** PrivateIPAddress of the network interface IP Configuration. */
  privateIPAddress?: string;
  /** The private IP address allocation method. */
  privateIPAllocationMethod?: IPAllocationMethod;
  /** Reference to the subnet resource. */
  subnet?: SubResource;
  /** Reference to the PublicIP resource. */
  publicIPAddress?: SubResource;
  /** Reference to the application gateway private link configuration. */
  privateLinkConfiguration?: SubResource;
  /**
   * The provisioning state of the frontend IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Frontend port of an application gateway. */
export interface ApplicationGatewayFrontendPort extends SubResource {
  /** Name of the frontend port that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Frontend port. */
  port?: number;
  /**
   * The provisioning state of the frontend port resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Probe of the application gateway. */
export interface ApplicationGatewayProbe extends SubResource {
  /** Name of the probe that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The protocol used for the probe. */
  protocol?: ApplicationGatewayProtocol;
  /** Host name to send the probe to. */
  host?: string;
  /** Relative path of probe. Valid path starts from '/'. Probe is sent to <Protocol>://<host>:<port><path>. */
  path?: string;
  /** The probing interval in seconds. This is the time interval between two consecutive probes. Acceptable values are from 1 second to 86400 seconds. */
  interval?: number;
  /** The probe timeout in seconds. Probe marked as failed if valid response is not received with this timeout period. Acceptable values are from 1 second to 86400 seconds. */
  timeout?: number;
  /** The probe retry count. Backend server is marked down after consecutive probe failure count reaches UnhealthyThreshold. Acceptable values are from 1 second to 20. */
  unhealthyThreshold?: number;
  /** Whether the host header should be picked from the backend http settings. Default value is false. */
  pickHostNameFromBackendHttpSettings?: boolean;
  /** Whether the server name indication should be picked from the backend settings for Tls protocol. Default value is false. */
  pickHostNameFromBackendSettings?: boolean;
  /** Minimum number of servers that are always marked healthy. Default value is 0. */
  minServers?: number;
  /** Criterion for classifying a healthy probe response. */
  match?: ApplicationGatewayProbeHealthResponseMatch;
  /**
   * The provisioning state of the probe resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from http settings will be used. This property is valid for Standard_v2 and WAF_v2 only. */
  port?: number;
}

/** Tap configuration in a Network Interface. */
export interface NetworkInterfaceTapConfiguration extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Sub Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The reference to the Virtual Network Tap resource. */
  virtualNetworkTap?: VirtualNetworkTap;
  /**
   * The provisioning state of the network interface tap configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Network security rule. */
export interface SecurityRule extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The type of the resource. */
  type?: string;
  /** A description for this rule. Restricted to 140 chars. */
  description?: string;
  /** Network protocol this rule applies to. */
  protocol?: SecurityRuleProtocol;
  /** The source port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports. */
  sourcePortRange?: string;
  /** The destination port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports. */
  destinationPortRange?: string;
  /** The CIDR or source IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. If this is an ingress rule, specifies where network traffic originates from. */
  sourceAddressPrefix?: string;
  /** The CIDR or source IP ranges. */
  sourceAddressPrefixes?: string[];
  /** The application security group specified as source. */
  sourceApplicationSecurityGroups?: ApplicationSecurityGroup[];
  /** The destination address prefix. CIDR or destination IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. */
  destinationAddressPrefix?: string;
  /** The destination address prefixes. CIDR or destination IP ranges. */
  destinationAddressPrefixes?: string[];
  /** The application security group specified as destination. */
  destinationApplicationSecurityGroups?: ApplicationSecurityGroup[];
  /** The source port ranges. */
  sourcePortRanges?: string[];
  /** The destination port ranges. */
  destinationPortRanges?: string[];
  /** The network traffic is allowed or denied. */
  access?: SecurityRuleAccess;
  /** The priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule. */
  priority?: number;
  /** The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic. */
  direction?: SecurityRuleDirection;
  /**
   * The provisioning state of the security rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** PrivateLinkServiceConnection resource. */
export interface PrivateLinkServiceConnection extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * The resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The provisioning state of the private link service connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The resource id of private link service. */
  privateLinkServiceId?: string;
  /** The ID(s) of the group(s) obtained from the remote resource that this private endpoint should connect to. */
  groupIds?: string[];
  /** A message passed to the owner of the remote resource with this connection request. Restricted to 140 chars. */
  requestMessage?: string;
  /** A collection of read-only information about the state of the connection to the remote resource. */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

/** The private link service ip configuration. */
export interface PrivateLinkServiceIpConfiguration extends SubResource {
  /** The name of private link service ip configuration. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The private IP address of the IP configuration. */
  privateIPAddress?: string;
  /** The private IP address allocation method. */
  privateIPAllocationMethod?: IPAllocationMethod;
  /** The reference to the subnet resource. */
  subnet?: Subnet;
  /** Whether the ip configuration is primary or not. */
  primary?: boolean;
  /**
   * The provisioning state of the private link service IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Whether the specific IP configuration is IPv4 or IPv6. Default is IPv4. */
  privateIPAddressVersion?: IPVersion;
}

/** PrivateEndpointConnection resource. */
export interface PrivateEndpointConnection extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * The resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The resource of private end point.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateEndpoint?: PrivateEndpoint;
  /** A collection of information about the state of the connection between service consumer and provider. */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
  /**
   * The provisioning state of the private endpoint connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The consumer link id.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly linkIdentifier?: string;
}

/** Route resource. */
export interface Route extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The type of the resource. */
  type?: string;
  /** The destination CIDR to which the route applies. */
  addressPrefix?: string;
  /** The type of Azure hop the packet should be sent to. */
  nextHopType?: RouteNextHopType;
  /** The IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance. */
  nextHopIpAddress?: string;
  /**
   * The provisioning state of the route resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** A value indicating whether this route overrides overlapping BGP routes regardless of LPM. */
  hasBgpOverride?: boolean;
}

/** Service Endpoint policy definitions. */
export interface ServiceEndpointPolicyDefinition extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The type of the resource. */
  type?: string;
  /** A description for this rule. Restricted to 140 chars. */
  description?: string;
  /** Service endpoint name. */
  service?: string;
  /** A list of service resources. */
  serviceResources?: string[];
  /**
   * The provisioning state of the service endpoint policy definition resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** IP configuration. */
export interface IPConfiguration extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The private IP address of the IP configuration. */
  privateIPAddress?: string;
  /** The private IP address allocation method. */
  privateIPAllocationMethod?: IPAllocationMethod;
  /** The reference to the subnet resource. */
  subnet?: Subnet;
  /** The reference to the public IP resource. */
  publicIPAddress?: PublicIPAddress;
  /**
   * The provisioning state of the IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** IP configuration profile child resource. */
export interface IPConfigurationProfile extends SubResource {
  /** The name of the resource. This name can be used to access the resource. */
  name?: string;
  /**
   * Sub Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The reference to the subnet resource to create a container network interface ip configuration. */
  subnet?: Subnet;
  /**
   * The provisioning state of the IP configuration profile resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** ResourceNavigationLink resource. */
export interface ResourceNavigationLink extends SubResource {
  /** Name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Resource type of the linked resource. */
  linkedResourceType?: string;
  /** Link to the external resource. */
  link?: string;
  /**
   * The provisioning state of the resource navigation link resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** ServiceAssociationLink resource. */
export interface ServiceAssociationLink extends SubResource {
  /** Name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Resource type of the linked resource. */
  linkedResourceType?: string;
  /** Link to the external resource. */
  link?: string;
  /**
   * The provisioning state of the service association link resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** If true, the resource can be deleted. */
  allowDelete?: boolean;
  /** A list of locations. */
  locations?: string[];
}

/** Details the service to which the subnet is delegated. */
export interface Delegation extends SubResource {
  /** The name of the resource that is unique within a subnet. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Resource type. */
  type?: string;
  /** The name of the service to whom the subnet should be delegated (e.g. Microsoft.Sql/servers). */
  serviceName?: string;
  /**
   * The actions permitted to the service upon delegation.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly actions?: string[];
  /**
   * The provisioning state of the service delegation resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Subnet in a virtual network resource. */
export interface Subnet extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Resource type. */
  type?: string;
  /** The address prefix for the subnet. */
  addressPrefix?: string;
  /** List of address prefixes for the subnet. */
  addressPrefixes?: string[];
  /** The reference to the NetworkSecurityGroup resource. */
  networkSecurityGroup?: NetworkSecurityGroup;
  /** The reference to the RouteTable resource. */
  routeTable?: RouteTable;
  /** Nat gateway associated with this subnet. */
  natGateway?: SubResource;
  /** An array of service endpoints. */
  serviceEndpoints?: ServiceEndpointPropertiesFormat[];
  /** An array of service endpoint policies. */
  serviceEndpointPolicies?: ServiceEndpointPolicy[];
  /**
   * An array of references to private endpoints.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateEndpoints?: PrivateEndpoint[];
  /**
   * An array of references to the network interface IP configurations using subnet.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipConfigurations?: IPConfiguration[];
  /**
   * Array of IP configuration profiles which reference this subnet.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipConfigurationProfiles?: IPConfigurationProfile[];
  /** Array of IpAllocation which reference this subnet. */
  ipAllocations?: SubResource[];
  /**
   * An array of references to the external resources using subnet.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceNavigationLinks?: ResourceNavigationLink[];
  /**
   * An array of references to services injecting into this subnet.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly serviceAssociationLinks?: ServiceAssociationLink[];
  /** An array of references to the delegations on the subnet. */
  delegations?: Delegation[];
  /**
   * A read-only string identifying the intention of use for this subnet based on delegations and other user-defined properties.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly purpose?: string;
  /**
   * The provisioning state of the subnet resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Enable or Disable apply network policies on private end point in the subnet. */
  privateEndpointNetworkPolicies?: VirtualNetworkPrivateEndpointNetworkPolicies;
  /** Enable or Disable apply network policies on private link service in the subnet. */
  privateLinkServiceNetworkPolicies?: VirtualNetworkPrivateLinkServiceNetworkPolicies;
  /** Application gateway IP configurations of virtual network resource. */
  applicationGatewayIpConfigurations?: ApplicationGatewayIPConfiguration[];
}

/** Frontend IP address of the load balancer. */
export interface FrontendIPConfiguration extends SubResource {
  /** The name of the resource that is unique within the set of frontend IP configurations used by the load balancer. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** A list of availability zones denoting the IP allocated for the resource needs to come from. */
  zones?: string[];
  /**
   * An array of references to inbound rules that use this frontend IP.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly inboundNatRules?: SubResource[];
  /**
   * An array of references to inbound pools that use this frontend IP.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly inboundNatPools?: SubResource[];
  /**
   * An array of references to outbound rules that use this frontend IP.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly outboundRules?: SubResource[];
  /**
   * An array of references to load balancing rules that use this frontend IP.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly loadBalancingRules?: SubResource[];
  /** The private IP address of the IP configuration. */
  privateIPAddress?: string;
  /** The Private IP allocation method. */
  privateIPAllocationMethod?: IPAllocationMethod;
  /** Whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. */
  privateIPAddressVersion?: IPVersion;
  /** The reference to the subnet resource. */
  subnet?: Subnet;
  /** The reference to the Public IP resource. */
  publicIPAddress?: PublicIPAddress;
  /** The reference to the Public IP Prefix resource. */
  publicIPPrefix?: SubResource;
  /** The reference to gateway load balancer frontend IP. */
  gatewayLoadBalancer?: SubResource;
  /**
   * The provisioning state of the frontend IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Pool of backend IP addresses. */
export interface BackendAddressPool extends SubResource {
  /** The name of the resource that is unique within the set of backend address pools used by the load balancer. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The location of the backend address pool. */
  location?: string;
  /** An array of gateway load balancer tunnel interfaces. */
  tunnelInterfaces?: GatewayLoadBalancerTunnelInterface[];
  /** An array of backend addresses. */
  loadBalancerBackendAddresses?: LoadBalancerBackendAddress[];
  /**
   * An array of references to IP addresses defined in network interfaces.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly backendIPConfigurations?: NetworkInterfaceIPConfiguration[];
  /**
   * An array of references to load balancing rules that use this backend address pool.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly loadBalancingRules?: SubResource[];
  /**
   * A reference to an outbound rule that uses this backend address pool.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly outboundRule?: SubResource;
  /**
   * An array of references to outbound rules that use this backend address pool.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly outboundRules?: SubResource[];
  /**
   * An array of references to inbound NAT rules that use this backend address pool.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly inboundNatRules?: SubResource[];
  /**
   * The provisioning state of the backend address pool resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Amount of seconds Load Balancer waits for before sending RESET to client and backend address. */
  drainPeriodInSeconds?: number;
}

/** Inbound NAT rule of the load balancer. */
export interface InboundNatRule extends SubResource {
  /** The name of the resource that is unique within the set of inbound NAT rules used by the load balancer. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** A reference to frontend IP addresses. */
  frontendIPConfiguration?: SubResource;
  /**
   * A reference to a private IP address defined on a network interface of a VM. Traffic sent to the frontend port of each of the frontend IP configurations is forwarded to the backend IP.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly backendIPConfiguration?: NetworkInterfaceIPConfiguration;
  /** The reference to the transport protocol used by the load balancing rule. */
  protocol?: TransportProtocol;
  /** The port for the external endpoint. Port numbers for each rule must be unique within the Load Balancer. Acceptable values range from 1 to 65534. */
  frontendPort?: number;
  /** The port used for the internal endpoint. Acceptable values range from 1 to 65535. */
  backendPort?: number;
  /** The timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. The default value is 4 minutes. This element is only used when the protocol is set to TCP. */
  idleTimeoutInMinutes?: number;
  /** Configures a virtual machine's endpoint for the floating IP capability required to configure a SQL AlwaysOn Availability Group. This setting is required when using the SQL AlwaysOn Availability Groups in SQL server. This setting can't be changed after you create the endpoint. */
  enableFloatingIP?: boolean;
  /** Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination. This element is only used when the protocol is set to TCP. */
  enableTcpReset?: boolean;
  /** The port range start for the external endpoint. This property is used together with BackendAddressPool and FrontendPortRangeEnd. Individual inbound NAT rule port mappings will be created for each backend address from BackendAddressPool. Acceptable values range from 1 to 65534. */
  frontendPortRangeStart?: number;
  /** The port range end for the external endpoint. This property is used together with BackendAddressPool and FrontendPortRangeStart. Individual inbound NAT rule port mappings will be created for each backend address from BackendAddressPool. Acceptable values range from 1 to 65534. */
  frontendPortRangeEnd?: number;
  /** A reference to backendAddressPool resource. */
  backendAddressPool?: SubResource;
  /**
   * The provisioning state of the inbound NAT rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** IPConfiguration in a network interface. */
export interface NetworkInterfaceIPConfiguration extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Resource type. */
  type?: string;
  /** The reference to gateway load balancer frontend IP. */
  gatewayLoadBalancer?: SubResource;
  /** The reference to Virtual Network Taps. */
  virtualNetworkTaps?: VirtualNetworkTap[];
  /** The reference to ApplicationGatewayBackendAddressPool resource. */
  applicationGatewayBackendAddressPools?: ApplicationGatewayBackendAddressPool[];
  /** The reference to LoadBalancerBackendAddressPool resource. */
  loadBalancerBackendAddressPools?: BackendAddressPool[];
  /** A list of references of LoadBalancerInboundNatRules. */
  loadBalancerInboundNatRules?: InboundNatRule[];
  /** Private IP address of the IP configuration. */
  privateIPAddress?: string;
  /** The private IP address allocation method. */
  privateIPAllocationMethod?: IPAllocationMethod;
  /** Whether the specific IP configuration is IPv4 or IPv6. Default is IPv4. */
  privateIPAddressVersion?: IPVersion;
  /** Subnet bound to the IP configuration. */
  subnet?: Subnet;
  /** Whether this is a primary customer address on the network interface. */
  primary?: boolean;
  /** Public IP address bound to the IP configuration. */
  publicIPAddress?: PublicIPAddress;
  /** Application security groups in which the IP configuration is included. */
  applicationSecurityGroups?: ApplicationSecurityGroup[];
  /**
   * The provisioning state of the network interface IP configuration.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * PrivateLinkConnection properties for the network interface.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateLinkConnectionProperties?: NetworkInterfaceIPConfigurationPrivateLinkConnectionProperties;
}

/** Backend Address Pool of an application gateway. */
export interface ApplicationGatewayBackendAddressPool extends SubResource {
  /** Name of the backend address pool that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * Collection of references to IPs defined in network interfaces.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly backendIPConfigurations?: NetworkInterfaceIPConfiguration[];
  /** Backend addresses. */
  backendAddresses?: ApplicationGatewayBackendAddress[];
  /**
   * The provisioning state of the backend address pool resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Backend address pool settings of an application gateway. */
export interface ApplicationGatewayBackendHttpSettings extends SubResource {
  /** Name of the backend http settings that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The destination port on the backend. */
  port?: number;
  /** The protocol used to communicate with the backend. */
  protocol?: ApplicationGatewayProtocol;
  /** Cookie based affinity. */
  cookieBasedAffinity?: ApplicationGatewayCookieBasedAffinity;
  /** Request timeout in seconds. Application Gateway will fail the request if response is not received within RequestTimeout. Acceptable values are from 1 second to 86400 seconds. */
  requestTimeout?: number;
  /** Probe resource of an application gateway. */
  probe?: SubResource;
  /** Array of references to application gateway authentication certificates. */
  authenticationCertificates?: SubResource[];
  /** Array of references to application gateway trusted root certificates. */
  trustedRootCertificates?: SubResource[];
  /** Connection draining of the backend http settings resource. */
  connectionDraining?: ApplicationGatewayConnectionDraining;
  /** Host header to be sent to the backend servers. */
  hostName?: string;
  /** Whether to pick host header should be picked from the host name of the backend server. Default value is false. */
  pickHostNameFromBackendAddress?: boolean;
  /** Cookie name to use for the affinity cookie. */
  affinityCookieName?: string;
  /** Whether the probe is enabled. Default value is false. */
  probeEnabled?: boolean;
  /** Path which should be used as a prefix for all HTTP requests. Null means no path will be prefixed. Default value is null. */
  path?: string;
  /**
   * The provisioning state of the backend HTTP settings resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Backend address pool settings of an application gateway. */
export interface ApplicationGatewayBackendSettings extends SubResource {
  /** Name of the backend settings that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The destination port on the backend. */
  port?: number;
  /** The protocol used to communicate with the backend. */
  protocol?: ApplicationGatewayProtocol;
  /** Connection timeout in seconds. Application Gateway will fail the request if response is not received within ConnectionTimeout. Acceptable values are from 1 second to 86400 seconds. */
  timeout?: number;
  /** Probe resource of an application gateway. */
  probe?: SubResource;
  /** Array of references to application gateway trusted root certificates. */
  trustedRootCertificates?: SubResource[];
  /** Server name indication to be sent to the backend servers for Tls protocol. */
  hostName?: string;
  /** Whether to pick server name indication from the host name of the backend server for Tls protocol. Default value is false. */
  pickHostNameFromBackendAddress?: boolean;
  /**
   * The provisioning state of the backend HTTP settings resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Http listener of an application gateway. */
export interface ApplicationGatewayHttpListener extends SubResource {
  /** Name of the HTTP listener that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Frontend IP configuration resource of an application gateway. */
  frontendIPConfiguration?: SubResource;
  /** Frontend port resource of an application gateway. */
  frontendPort?: SubResource;
  /** Protocol of the HTTP listener. */
  protocol?: ApplicationGatewayProtocol;
  /** Host name of HTTP listener. */
  hostName?: string;
  /** SSL certificate resource of an application gateway. */
  sslCertificate?: SubResource;
  /** SSL profile resource of the application gateway. */
  sslProfile?: SubResource;
  /** Applicable only if protocol is https. Enables SNI for multi-hosting. */
  requireServerNameIndication?: boolean;
  /**
   * The provisioning state of the HTTP listener resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Custom error configurations of the HTTP listener. */
  customErrorConfigurations?: ApplicationGatewayCustomError[];
  /** Reference to the FirewallPolicy resource. */
  firewallPolicy?: SubResource;
  /** List of Host names for HTTP Listener that allows special wildcard characters as well. */
  hostNames?: string[];
}

/** Listener of an application gateway. */
export interface ApplicationGatewayListener extends SubResource {
  /** Name of the listener that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Frontend IP configuration resource of an application gateway. */
  frontendIPConfiguration?: SubResource;
  /** Frontend port resource of an application gateway. */
  frontendPort?: SubResource;
  /** Protocol of the listener. */
  protocol?: ApplicationGatewayProtocol;
  /** SSL certificate resource of an application gateway. */
  sslCertificate?: SubResource;
  /** SSL profile resource of the application gateway. */
  sslProfile?: SubResource;
  /**
   * The provisioning state of the listener resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** SSL profile of an application gateway. */
export interface ApplicationGatewaySslProfile extends SubResource {
  /** Name of the SSL profile that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Array of references to application gateway trusted client certificates. */
  trustedClientCertificates?: SubResource[];
  /** SSL policy of the application gateway resource. */
  sslPolicy?: ApplicationGatewaySslPolicy;
  /** Client authentication configuration of the application gateway resource. */
  clientAuthConfiguration?: ApplicationGatewayClientAuthConfiguration;
  /**
   * The provisioning state of the HTTP listener resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Path rule of URL path map of an application gateway. */
export interface ApplicationGatewayPathRule extends SubResource {
  /** Name of the path rule that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Path rules of URL path map. */
  paths?: string[];
  /** Backend address pool resource of URL path map path rule. */
  backendAddressPool?: SubResource;
  /** Backend http settings resource of URL path map path rule. */
  backendHttpSettings?: SubResource;
  /** Redirect configuration resource of URL path map path rule. */
  redirectConfiguration?: SubResource;
  /** Rewrite rule set resource of URL path map path rule. */
  rewriteRuleSet?: SubResource;
  /** Load Distribution Policy resource of URL path map path rule. */
  loadDistributionPolicy?: SubResource;
  /**
   * The provisioning state of the path rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Reference to the FirewallPolicy resource. */
  firewallPolicy?: SubResource;
}

/** UrlPathMaps give a url path to the backend mapping information for PathBasedRouting. */
export interface ApplicationGatewayUrlPathMap extends SubResource {
  /** Name of the URL path map that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Default backend address pool resource of URL path map. */
  defaultBackendAddressPool?: SubResource;
  /** Default backend http settings resource of URL path map. */
  defaultBackendHttpSettings?: SubResource;
  /** Default Rewrite rule set resource of URL path map. */
  defaultRewriteRuleSet?: SubResource;
  /** Default redirect configuration resource of URL path map. */
  defaultRedirectConfiguration?: SubResource;
  /** Default Load Distribution Policy resource of URL path map. */
  defaultLoadDistributionPolicy?: SubResource;
  /** Path rule of URL path map resource. */
  pathRules?: ApplicationGatewayPathRule[];
  /**
   * The provisioning state of the URL path map resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Request routing rule of an application gateway. */
export interface ApplicationGatewayRequestRoutingRule extends SubResource {
  /** Name of the request routing rule that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Rule type. */
  ruleType?: ApplicationGatewayRequestRoutingRuleType;
  /** Priority of the request routing rule. */
  priority?: number;
  /** Backend address pool resource of the application gateway. */
  backendAddressPool?: SubResource;
  /** Backend http settings resource of the application gateway. */
  backendHttpSettings?: SubResource;
  /** Http listener resource of the application gateway. */
  httpListener?: SubResource;
  /** URL path map resource of the application gateway. */
  urlPathMap?: SubResource;
  /** Rewrite Rule Set resource in Basic rule of the application gateway. */
  rewriteRuleSet?: SubResource;
  /** Redirect configuration resource of the application gateway. */
  redirectConfiguration?: SubResource;
  /** Load Distribution Policy resource of the application gateway. */
  loadDistributionPolicy?: SubResource;
  /**
   * The provisioning state of the request routing rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Routing rule of an application gateway. */
export interface ApplicationGatewayRoutingRule extends SubResource {
  /** Name of the routing rule that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Rule type. */
  ruleType?: ApplicationGatewayRequestRoutingRuleType;
  /** Priority of the routing rule. */
  priority?: number;
  /** Backend address pool resource of the application gateway. */
  backendAddressPool?: SubResource;
  /** Backend settings resource of the application gateway. */
  backendSettings?: SubResource;
  /** Listener resource of the application gateway. */
  listener?: SubResource;
  /**
   * The provisioning state of the request routing rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Rewrite rule set of an application gateway. */
export interface ApplicationGatewayRewriteRuleSet extends SubResource {
  /** Name of the rewrite rule set that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Rewrite rules in the rewrite rule set. */
  rewriteRules?: ApplicationGatewayRewriteRule[];
  /**
   * The provisioning state of the rewrite rule set resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Redirect configuration of an application gateway. */
export interface ApplicationGatewayRedirectConfiguration extends SubResource {
  /** Name of the redirect configuration that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** HTTP redirection type. */
  redirectType?: ApplicationGatewayRedirectType;
  /** Reference to a listener to redirect the request to. */
  targetListener?: SubResource;
  /** Url to redirect the request to. */
  targetUrl?: string;
  /** Include path in the redirected url. */
  includePath?: boolean;
  /** Include query string in the redirected url. */
  includeQueryString?: boolean;
  /** Request routing specifying redirect configuration. */
  requestRoutingRules?: SubResource[];
  /** Url path maps specifying default redirect configuration. */
  urlPathMaps?: SubResource[];
  /** Path rules specifying redirect configuration. */
  pathRules?: SubResource[];
}

/** The application gateway private link ip configuration. */
export interface ApplicationGatewayPrivateLinkIpConfiguration
  extends SubResource {
  /** The name of application gateway private link ip configuration. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The private IP address of the IP configuration. */
  privateIPAddress?: string;
  /** The private IP address allocation method. */
  privateIPAllocationMethod?: IPAllocationMethod;
  /** Reference to the subnet resource. */
  subnet?: SubResource;
  /** Whether the ip configuration is primary or not. */
  primary?: boolean;
  /**
   * The provisioning state of the application gateway private link IP configuration.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Private Link Configuration on an application gateway. */
export interface ApplicationGatewayPrivateLinkConfiguration
  extends SubResource {
  /** Name of the private link configuration that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** An array of application gateway private link ip configurations. */
  ipConfigurations?: ApplicationGatewayPrivateLinkIpConfiguration[];
  /**
   * The provisioning state of the application gateway private link configuration.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Private Endpoint connection on an application gateway. */
export interface ApplicationGatewayPrivateEndpointConnection
  extends SubResource {
  /** Name of the private endpoint connection on an application gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * The resource of private end point.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateEndpoint?: PrivateEndpoint;
  /** A collection of information about the state of the connection between service consumer and provider. */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
  /**
   * The provisioning state of the application gateway private endpoint connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The consumer link id.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly linkIdentifier?: string;
}

/** Load Distribution Target of an application gateway. */
export interface ApplicationGatewayLoadDistributionTarget extends SubResource {
  /** Name of the load distribution policy that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Weight per server. Range between 1 and 100. */
  weightPerServer?: number;
  /** Backend address pool resource of the application gateway. */
  backendAddressPool?: SubResource;
}

/** Load Distribution Policy of an application gateway. */
export interface ApplicationGatewayLoadDistributionPolicy extends SubResource {
  /** Name of the load distribution policy that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Load Distribution Targets resource of an application gateway. */
  loadDistributionTargets?: ApplicationGatewayLoadDistributionTarget[];
  /** Load Distribution Targets resource of an application gateway. */
  loadDistributionAlgorithm?: ApplicationGatewayLoadDistributionAlgorithm;
  /**
   * The provisioning state of the Load Distribution Policy resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** PrivateLink Resource of an application gateway. */
export interface ApplicationGatewayPrivateLinkResource extends SubResource {
  /** Name of the private link resource that is unique within an Application Gateway. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * Group identifier of private link resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly groupId?: string;
  /**
   * Required member names of private link resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly requiredMembers?: string[];
  /** Required DNS zone names of the the private link resource. */
  requiredZoneNames?: string[];
}

/** An Ssl predefined policy. */
export interface ApplicationGatewaySslPredefinedPolicy extends SubResource {
  /** Name of the Ssl predefined policy. */
  name?: string;
  /** Ssl cipher suites to be enabled in the specified order for application gateway. */
  cipherSuites?: ApplicationGatewaySslCipherSuite[];
  /** Minimum version of Ssl protocol to be supported on application gateway. */
  minProtocolVersion?: ApplicationGatewaySslProtocol;
}

/** Application rule collection resource. */
export interface AzureFirewallApplicationRuleCollection extends SubResource {
  /** The name of the resource that is unique within the Azure firewall. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Priority of the application rule collection resource. */
  priority?: number;
  /** The action type of a rule collection. */
  action?: AzureFirewallRCAction;
  /** Collection of rules used by a application rule collection. */
  rules?: AzureFirewallApplicationRule[];
  /**
   * The provisioning state of the application rule collection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** NAT rule collection resource. */
export interface AzureFirewallNatRuleCollection extends SubResource {
  /** The name of the resource that is unique within the Azure firewall. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Priority of the NAT rule collection resource. */
  priority?: number;
  /** The action type of a NAT rule collection. */
  action?: AzureFirewallNatRCAction;
  /** Collection of rules used by a NAT rule collection. */
  rules?: AzureFirewallNatRule[];
  /**
   * The provisioning state of the NAT rule collection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Network rule collection resource. */
export interface AzureFirewallNetworkRuleCollection extends SubResource {
  /** The name of the resource that is unique within the Azure firewall. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Priority of the network rule collection resource. */
  priority?: number;
  /** The action type of a rule collection. */
  action?: AzureFirewallRCAction;
  /** Collection of rules used by a network rule collection. */
  rules?: AzureFirewallNetworkRule[];
  /**
   * The provisioning state of the network rule collection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** IP configuration of an Azure Firewall. */
export interface AzureFirewallIPConfiguration extends SubResource {
  /** Name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * The Firewall Internal Load Balancer IP to be used as the next hop in User Defined Routes.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateIPAddress?: string;
  /** Reference to the subnet resource. This resource must be named 'AzureFirewallSubnet' or 'AzureFirewallManagementSubnet'. */
  subnet?: SubResource;
  /** Reference to the PublicIP resource. This field is a mandatory input if subnet is not null. */
  publicIPAddress?: SubResource;
  /**
   * The provisioning state of the Azure firewall IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** IP configuration of an Bastion Host. */
export interface BastionHostIPConfiguration extends SubResource {
  /** Name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Ip configuration type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Reference of the subnet resource. */
  subnet?: SubResource;
  /** Reference of the PublicIP resource. */
  publicIPAddress?: SubResource;
  /**
   * The provisioning state of the bastion host IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Private IP allocation method. */
  privateIPAllocationMethod?: IPAllocationMethod;
}

/** Endpoint service. */
export interface EndpointServiceResult extends SubResource {
  /**
   * Name of the endpoint service.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * Type of the endpoint service.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
}

/** Authorization in an ExpressRouteCircuit resource. */
export interface ExpressRouteCircuitAuthorization extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The authorization key. */
  authorizationKey?: string;
  /** The authorization use status. */
  authorizationUseStatus?: AuthorizationUseStatus;
  /**
   * The provisioning state of the authorization resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Express Route Circuit Connection in an ExpressRouteCircuitPeering resource. */
export interface ExpressRouteCircuitConnection extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Reference to Express Route Circuit Private Peering Resource of the circuit initiating connection. */
  expressRouteCircuitPeering?: SubResource;
  /** Reference to Express Route Circuit Private Peering Resource of the peered circuit. */
  peerExpressRouteCircuitPeering?: SubResource;
  /** /29 IP address space to carve out Customer addresses for tunnels. */
  addressPrefix?: string;
  /** The authorization key. */
  authorizationKey?: string;
  /** IPv6 Address PrefixProperties of the express route circuit connection. */
  ipv6CircuitConnectionConfig?: Ipv6CircuitConnectionConfig;
  /**
   * Express Route Circuit connection state.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly circuitConnectionStatus?: CircuitConnectionStatus;
  /**
   * The provisioning state of the express route circuit connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Peer Express Route Circuit Connection in an ExpressRouteCircuitPeering resource. */
export interface PeerExpressRouteCircuitConnection extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Reference to Express Route Circuit Private Peering Resource of the circuit. */
  expressRouteCircuitPeering?: SubResource;
  /** Reference to Express Route Circuit Private Peering Resource of the peered circuit. */
  peerExpressRouteCircuitPeering?: SubResource;
  /** /29 IP address space to carve out Customer addresses for tunnels. */
  addressPrefix?: string;
  /**
   * Express Route Circuit connection state.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly circuitConnectionStatus?: CircuitConnectionStatus;
  /** The name of the express route circuit connection resource. */
  connectionName?: string;
  /** The resource guid of the authorization used for the express route circuit connection. */
  authResourceGuid?: string;
  /**
   * The provisioning state of the peer express route circuit connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Peering in an ExpressRouteCircuit resource. */
export interface ExpressRouteCircuitPeering extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The peering type. */
  peeringType?: ExpressRoutePeeringType;
  /** The peering state. */
  state?: ExpressRoutePeeringState;
  /** The Azure ASN. */
  azureASN?: number;
  /** The peer ASN. */
  peerASN?: number;
  /** The primary address prefix. */
  primaryPeerAddressPrefix?: string;
  /** The secondary address prefix. */
  secondaryPeerAddressPrefix?: string;
  /** The primary port. */
  primaryAzurePort?: string;
  /** The secondary port. */
  secondaryAzurePort?: string;
  /** The shared key. */
  sharedKey?: string;
  /** The VLAN ID. */
  vlanId?: number;
  /** The Microsoft peering configuration. */
  microsoftPeeringConfig?: ExpressRouteCircuitPeeringConfig;
  /** The peering stats of express route circuit. */
  stats?: ExpressRouteCircuitStats;
  /**
   * The provisioning state of the express route circuit peering resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The GatewayManager Etag. */
  gatewayManagerEtag?: string;
  /**
   * Who was the last to modify the peering.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly lastModifiedBy?: string;
  /** The reference to the RouteFilter resource. */
  routeFilter?: SubResource;
  /** The IPv6 peering configuration. */
  ipv6PeeringConfig?: Ipv6ExpressRouteCircuitPeeringConfig;
  /** The ExpressRoute connection. */
  expressRouteConnection?: ExpressRouteConnectionId;
  /** The list of circuit connections associated with Azure Private Peering for this circuit. */
  connections?: ExpressRouteCircuitConnection[];
  /**
   * The list of peered circuit connections associated with Azure Private Peering for this circuit.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly peeredConnections?: PeerExpressRouteCircuitConnection[];
}

/** Peering in an ExpressRoute Cross Connection resource. */
export interface ExpressRouteCrossConnectionPeering extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The peering type. */
  peeringType?: ExpressRoutePeeringType;
  /** The peering state. */
  state?: ExpressRoutePeeringState;
  /**
   * The Azure ASN.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly azureASN?: number;
  /** The peer ASN. */
  peerASN?: number;
  /** The primary address prefix. */
  primaryPeerAddressPrefix?: string;
  /** The secondary address prefix. */
  secondaryPeerAddressPrefix?: string;
  /**
   * The primary port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly primaryAzurePort?: string;
  /**
   * The secondary port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly secondaryAzurePort?: string;
  /** The shared key. */
  sharedKey?: string;
  /** The VLAN ID. */
  vlanId?: number;
  /** The Microsoft peering configuration. */
  microsoftPeeringConfig?: ExpressRouteCircuitPeeringConfig;
  /**
   * The provisioning state of the express route cross connection peering resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The GatewayManager Etag. */
  gatewayManagerEtag?: string;
  /**
   * Who was the last to modify the peering.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly lastModifiedBy?: string;
  /** The IPv6 peering configuration. */
  ipv6PeeringConfig?: Ipv6ExpressRouteCircuitPeeringConfig;
}

/** ExpressRouteLink child resource definition. */
export interface ExpressRouteLink extends SubResource {
  /** Name of child port resource that is unique among child port resources of the parent. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Name of Azure router associated with physical port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly routerName?: string;
  /**
   * Name of Azure router interface.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly interfaceName?: string;
  /**
   * Mapping between physical port to patch panel port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly patchPanelId?: string;
  /**
   * Mapping of physical patch panel to rack.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly rackId?: string;
  /**
   * Cololocation for ExpressRoute Hybrid Direct.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly coloLocation?: string;
  /**
   * Physical fiber port type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectorType?: ExpressRouteLinkConnectorType;
  /** Administrative state of the physical port. */
  adminState?: ExpressRouteLinkAdminState;
  /**
   * The provisioning state of the express route link resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** MacSec configuration. */
  macSecConfig?: ExpressRouteLinkMacSecConfig;
}

/** ExpressRoutePort Authorization resource definition. */
export interface ExpressRoutePortAuthorization extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * The authorization key.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly authorizationKey?: string;
  /**
   * The authorization use status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly authorizationUseStatus?: ExpressRoutePortAuthorizationUseStatus;
  /**
   * The reference to the ExpressRoute circuit resource using the authorization.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly circuitResourceUri?: string;
  /**
   * The provisioning state of the authorization resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Rule Collection Group resource. */
export interface FirewallPolicyRuleCollectionGroup extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Rule Group type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Priority of the Firewall Policy Rule Collection Group resource. */
  priority?: number;
  /** Group of Firewall Policy rule collections. */
  ruleCollections?: FirewallPolicyRuleCollectionUnion[];
  /**
   * The provisioning state of the firewall policy rule collection group resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** A load balancing rule for a load balancer. */
export interface LoadBalancingRule extends SubResource {
  /** The name of the resource that is unique within the set of load balancing rules used by the load balancer. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** A reference to frontend IP addresses. */
  frontendIPConfiguration?: SubResource;
  /** A reference to a pool of DIPs. Inbound traffic is randomly load balanced across IPs in the backend IPs. */
  backendAddressPool?: SubResource;
  /** An array of references to pool of DIPs. */
  backendAddressPools?: SubResource[];
  /** The reference to the load balancer probe used by the load balancing rule. */
  probe?: SubResource;
  /** The reference to the transport protocol used by the load balancing rule. */
  protocol?: TransportProtocol;
  /** The load distribution policy for this rule. */
  loadDistribution?: LoadDistribution;
  /** The port for the external endpoint. Port numbers for each rule must be unique within the Load Balancer. Acceptable values are between 0 and 65534. Note that value 0 enables "Any Port". */
  frontendPort?: number;
  /** The port used for internal connections on the endpoint. Acceptable values are between 0 and 65535. Note that value 0 enables "Any Port". */
  backendPort?: number;
  /** The timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. The default value is 4 minutes. This element is only used when the protocol is set to TCP. */
  idleTimeoutInMinutes?: number;
  /** Configures a virtual machine's endpoint for the floating IP capability required to configure a SQL AlwaysOn Availability Group. This setting is required when using the SQL AlwaysOn Availability Groups in SQL server. This setting can't be changed after you create the endpoint. */
  enableFloatingIP?: boolean;
  /** Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination. This element is only used when the protocol is set to TCP. */
  enableTcpReset?: boolean;
  /** Configures SNAT for the VMs in the backend pool to use the publicIP address specified in the frontend of the load balancing rule. */
  disableOutboundSnat?: boolean;
  /**
   * The provisioning state of the load balancing rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** A load balancer probe. */
export interface Probe extends SubResource {
  /** The name of the resource that is unique within the set of probes used by the load balancer. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * The load balancer rules that use this probe.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly loadBalancingRules?: SubResource[];
  /** The protocol of the end point. If 'Tcp' is specified, a received ACK is required for the probe to be successful. If 'Http' or 'Https' is specified, a 200 OK response from the specifies URI is required for the probe to be successful. */
  protocol?: ProbeProtocol;
  /** The port for communicating the probe. Possible values range from 1 to 65535, inclusive. */
  port?: number;
  /** The interval, in seconds, for how frequently to probe the endpoint for health status. Typically, the interval is slightly less than half the allocated timeout period (in seconds) which allows two full probes before taking the instance out of rotation. The default value is 15, the minimum value is 5. */
  intervalInSeconds?: number;
  /** The number of probes where if no response, will result in stopping further traffic from being delivered to the endpoint. This values allows endpoints to be taken out of rotation faster or slower than the typical times used in Azure. */
  numberOfProbes?: number;
  /** The URI used for requesting health status from the VM. Path is required if a protocol is set to http. Otherwise, it is not allowed. There is no default value. */
  requestPath?: string;
  /**
   * The provisioning state of the probe resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Inbound NAT pool of the load balancer. */
export interface InboundNatPool extends SubResource {
  /** The name of the resource that is unique within the set of inbound NAT pools used by the load balancer. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** A reference to frontend IP addresses. */
  frontendIPConfiguration?: SubResource;
  /** The reference to the transport protocol used by the inbound NAT pool. */
  protocol?: TransportProtocol;
  /** The first port number in the range of external ports that will be used to provide Inbound Nat to NICs associated with a load balancer. Acceptable values range between 1 and 65534. */
  frontendPortRangeStart?: number;
  /** The last port number in the range of external ports that will be used to provide Inbound Nat to NICs associated with a load balancer. Acceptable values range between 1 and 65535. */
  frontendPortRangeEnd?: number;
  /** The port used for internal connections on the endpoint. Acceptable values are between 1 and 65535. */
  backendPort?: number;
  /** The timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. The default value is 4 minutes. This element is only used when the protocol is set to TCP. */
  idleTimeoutInMinutes?: number;
  /** Configures a virtual machine's endpoint for the floating IP capability required to configure a SQL AlwaysOn Availability Group. This setting is required when using the SQL AlwaysOn Availability Groups in SQL server. This setting can't be changed after you create the endpoint. */
  enableFloatingIP?: boolean;
  /** Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination. This element is only used when the protocol is set to TCP. */
  enableTcpReset?: boolean;
  /**
   * The provisioning state of the inbound NAT pool resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Outbound rule of the load balancer. */
export interface OutboundRule extends SubResource {
  /** The name of the resource that is unique within the set of outbound rules used by the load balancer. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Type of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The number of outbound ports to be used for NAT. */
  allocatedOutboundPorts?: number;
  /** The Frontend IP addresses of the load balancer. */
  frontendIPConfigurations?: SubResource[];
  /** A reference to a pool of DIPs. Outbound traffic is randomly load balanced across IPs in the backend IPs. */
  backendAddressPool?: SubResource;
  /**
   * The provisioning state of the outbound rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The protocol for the outbound rule in load balancer. */
  protocol?: LoadBalancerOutboundRuleProtocol;
  /** Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination. This element is only used when the protocol is set to TCP. */
  enableTcpReset?: boolean;
  /** The timeout for the TCP idle connection. */
  idleTimeoutInMinutes?: number;
}

/** Container network interface configuration child resource. */
export interface ContainerNetworkInterfaceConfiguration extends SubResource {
  /** The name of the resource. This name can be used to access the resource. */
  name?: string;
  /**
   * Sub Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** A list of ip configurations of the container network interface configuration. */
  ipConfigurations?: IPConfigurationProfile[];
  /** A list of container network interfaces created from this container network interface configuration. */
  containerNetworkInterfaces?: SubResource[];
  /**
   * The provisioning state of the container network interface configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Reference to container resource in remote resource provider. */
export interface Container extends SubResource {}

/** Container network interface child resource. */
export interface ContainerNetworkInterface extends SubResource {
  /** The name of the resource. This name can be used to access the resource. */
  name?: string;
  /**
   * Sub Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Container network interface configuration from which this container network interface is created.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly containerNetworkInterfaceConfiguration?: ContainerNetworkInterfaceConfiguration;
  /** Reference to the container to which this container network interface is attached. */
  container?: Container;
  /**
   * Reference to the ip configuration on this container nic.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipConfigurations?: ContainerNetworkInterfaceIpConfiguration[];
  /**
   * The provisioning state of the container network interface resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Virtual Appliance Site resource. */
export interface VirtualApplianceSite extends SubResource {
  /** Name of the virtual appliance site. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Site type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Address Prefix. */
  addressPrefix?: string;
  /** Office 365 Policy. */
  o365Policy?: Office365PolicyProperties;
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** NVA Inbound Security Rule resource. */
export interface InboundSecurityRule extends SubResource {
  /** Name of security rule collection. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * NVA inbound security rule type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** List of allowed rules. */
  rules?: InboundSecurityRules[];
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Private dns zone group resource. */
export interface PrivateDnsZoneGroup extends SubResource {
  /** Name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The provisioning state of the private dns zone group resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** A collection of private dns zone configurations of the private dns zone group. */
  privateDnsZoneConfigs?: PrivateDnsZoneConfig[];
}

/** Route Filter Rule Resource. */
export interface RouteFilterRule extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /** Resource location. */
  location?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The access type of the rule. */
  access?: Access;
  /** The rule type of the rule. */
  routeFilterRuleType?: RouteFilterRuleType;
  /** The collection for bgp community values to filter on. e.g. ['12076:5010','12076:5020']. */
  communities?: string[];
  /**
   * The provisioning state of the route filter rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Peerings in a virtual network resource. */
export interface VirtualNetworkPeering extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Resource type. */
  type?: string;
  /** Whether the VMs in the local virtual network space would be able to access the VMs in remote virtual network space. */
  allowVirtualNetworkAccess?: boolean;
  /** Whether the forwarded traffic from the VMs in the local virtual network will be allowed/disallowed in remote virtual network. */
  allowForwardedTraffic?: boolean;
  /** If gateway links can be used in remote virtual networking to link to this virtual network. */
  allowGatewayTransit?: boolean;
  /** If remote gateways can be used on this virtual network. If the flag is set to true, and allowGatewayTransit on remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. */
  useRemoteGateways?: boolean;
  /** The reference to the remote virtual network. The remote virtual network can be in the same or different region (preview). See here to register for the preview and learn more (https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-create-peering). */
  remoteVirtualNetwork?: SubResource;
  /** The reference to the address space peered with the remote virtual network. */
  remoteAddressSpace?: AddressSpace;
  /** The reference to the current address space of the remote virtual network. */
  remoteVirtualNetworkAddressSpace?: AddressSpace;
  /** The reference to the remote virtual network's Bgp Communities. */
  remoteBgpCommunities?: VirtualNetworkBgpCommunities;
  /**
   * The reference to the remote virtual network's encryption
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly remoteVirtualNetworkEncryption?: VirtualNetworkEncryption;
  /** The status of the virtual network peering. */
  peeringState?: VirtualNetworkPeeringState;
  /** The peering sync status of the virtual network peering. */
  peeringSyncLevel?: VirtualNetworkPeeringLevel;
  /**
   * The provisioning state of the virtual network peering resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** If we need to verify the provisioning state of the remote gateway. */
  doNotVerifyRemoteGateways?: boolean;
  /**
   * The resourceGuid property of the Virtual Network peering resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
}

/** IP configuration for virtual network gateway. */
export interface VirtualNetworkGatewayIPConfiguration extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The private IP address allocation method. */
  privateIPAllocationMethod?: IPAllocationMethod;
  /** The reference to the subnet resource. */
  subnet?: SubResource;
  /** The reference to the public IP resource. */
  publicIPAddress?: SubResource;
  /**
   * Private IP Address for this gateway.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateIPAddress?: string;
  /**
   * The provisioning state of the virtual network gateway IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** VPN client root certificate of virtual network gateway. */
export interface VpnClientRootCertificate extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The certificate public data. */
  publicCertData: string;
  /**
   * The provisioning state of the VPN client root certificate resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** VPN client revoked certificate of virtual network gateway. */
export interface VpnClientRevokedCertificate extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The revoked VPN client certificate thumbprint. */
  thumbprint?: string;
  /**
   * The provisioning state of the VPN client revoked certificate resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** VirtualNetworkGatewayNatRule Resource. */
export interface VirtualNetworkGatewayNatRule extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * The provisioning state of the NAT Rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The type of NAT rule for VPN NAT. */
  typePropertiesType?: VpnNatRuleType;
  /** The Source NAT direction of a VPN NAT. */
  mode?: VpnNatRuleMode;
  /** The private IP address internal mapping for NAT. */
  internalMappings?: VpnNatRuleMapping[];
  /** The private IP address external mapping for NAT. */
  externalMappings?: VpnNatRuleMapping[];
  /** The IP Configuration ID this NAT rule applies to. */
  ipConfigurationId?: string;
}

/** Response for GetConnectionSharedKey API service call. */
export interface ConnectionSharedKey extends SubResource {
  /** The virtual network connection shared key value. */
  value: string;
}

/** Virtual Router Peering resource. */
export interface VirtualRouterPeering extends SubResource {
  /** Name of the virtual router peering that is unique within a virtual router. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Peering type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Peer ASN. */
  peerAsn?: number;
  /** Peer IP. */
  peerIp?: string;
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** VpnSiteLink Resource. */
export interface VpnSiteLink extends SubResource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The link provider properties. */
  linkProperties?: VpnLinkProviderProperties;
  /** The ip-address for the vpn-site-link. */
  ipAddress?: string;
  /** FQDN of vpn-site-link. */
  fqdn?: string;
  /** The set of bgp properties. */
  bgpProperties?: VpnLinkBgpSettings;
  /**
   * The provisioning state of the VPN site link resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** VpnServerConfigurationPolicyGroup Resource. */
export interface VpnServerConfigurationPolicyGroup extends SubResource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Shows if this is a Default VpnServerConfigurationPolicyGroup or not. */
  isDefault?: boolean;
  /** Priority for VpnServerConfigurationPolicyGroup. */
  priority?: number;
  /** Multiple PolicyMembers for VpnServerConfigurationPolicyGroup. */
  policyMembers?: VpnServerConfigurationPolicyGroupMember[];
  /**
   * List of references to P2SConnectionConfigurations.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly p2SConnectionConfigurations?: SubResource[];
  /**
   * The provisioning state of the VpnServerConfigurationPolicyGroup resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** P2SConnectionConfiguration Resource. */
export interface P2SConnectionConfiguration extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The reference to the address space resource which represents Address space for P2S VpnClient. */
  vpnClientAddressPool?: AddressSpace;
  /** The Routing Configuration indicating the associated and propagated route tables on this connection. */
  routingConfiguration?: RoutingConfiguration;
  /** Flag indicating whether the enable internet security flag is turned on for the P2S Connections or not. */
  enableInternetSecurity?: boolean;
  /**
   * List of Configuration Policy Groups that this P2SConnectionConfiguration is attached to.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly configurationPolicyGroupAssociations?: SubResource[];
  /**
   * List of previous Configuration Policy Groups that this P2SConnectionConfiguration was attached to.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly previousConfigurationPolicyGroupAssociations?: VpnServerConfigurationPolicyGroup[];
  /**
   * The provisioning state of the P2SConnectionConfiguration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** VirtualHubRouteTableV2 Resource. */
export interface VirtualHubRouteTableV2 extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** List of all routes. */
  routes?: VirtualHubRouteV2[];
  /** List of all connections attached to this route table v2. */
  attachedConnections?: string[];
  /**
   * The provisioning state of the virtual hub route table v2 resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** HubVirtualNetworkConnection Resource. */
export interface HubVirtualNetworkConnection extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Reference to the remote virtual network. */
  remoteVirtualNetwork?: SubResource;
  /** Deprecated: VirtualHub to RemoteVnet transit to enabled or not. */
  allowHubToRemoteVnetTransit?: boolean;
  /** Deprecated: Allow RemoteVnet to use Virtual Hub's gateways. */
  allowRemoteVnetToUseHubVnetGateways?: boolean;
  /** Enable internet security. */
  enableInternetSecurity?: boolean;
  /** The Routing Configuration indicating the associated and propagated route tables on this connection. */
  routingConfiguration?: RoutingConfiguration;
  /**
   * The provisioning state of the hub virtual network connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** VpnSiteLinkConnection Resource. */
export interface VpnSiteLinkConnection extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Id of the connected vpn site link. */
  vpnSiteLink?: SubResource;
  /** Routing weight for vpn connection. */
  routingWeight?: number;
  /** Vpn link connection mode. */
  vpnLinkConnectionMode?: VpnLinkConnectionMode;
  /**
   * The connection status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionStatus?: VpnConnectionStatus;
  /** Connection protocol used for this connection. */
  vpnConnectionProtocolType?: VirtualNetworkGatewayConnectionProtocol;
  /**
   * Ingress bytes transferred.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ingressBytesTransferred?: number;
  /**
   * Egress bytes transferred.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly egressBytesTransferred?: number;
  /** Expected bandwidth in MBPS. */
  connectionBandwidth?: number;
  /** SharedKey for the vpn connection. */
  sharedKey?: string;
  /** EnableBgp flag. */
  enableBgp?: boolean;
  /** vpnGatewayCustomBgpAddresses used by this connection. */
  vpnGatewayCustomBgpAddresses?: GatewayCustomBgpIpAddressIpConfiguration[];
  /** Enable policy-based traffic selectors. */
  usePolicyBasedTrafficSelectors?: boolean;
  /** The IPSec Policies to be considered by this connection. */
  ipsecPolicies?: IpsecPolicy[];
  /** EnableBgp flag. */
  enableRateLimiting?: boolean;
  /** Use local azure ip to initiate connection. */
  useLocalAzureIpAddress?: boolean;
  /**
   * The provisioning state of the VPN site link connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** List of ingress NatRules. */
  ingressNatRules?: SubResource[];
  /** List of egress NatRules. */
  egressNatRules?: SubResource[];
}

/** VpnConnection Resource. */
export interface VpnConnection extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Id of the connected vpn site. */
  remoteVpnSite?: SubResource;
  /** Routing weight for vpn connection. */
  routingWeight?: number;
  /** DPD timeout in seconds for vpn connection. */
  dpdTimeoutSeconds?: number;
  /**
   * The connection status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionStatus?: VpnConnectionStatus;
  /** Connection protocol used for this connection. */
  vpnConnectionProtocolType?: VirtualNetworkGatewayConnectionProtocol;
  /**
   * Ingress bytes transferred.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ingressBytesTransferred?: number;
  /**
   * Egress bytes transferred.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly egressBytesTransferred?: number;
  /** Expected bandwidth in MBPS. */
  connectionBandwidth?: number;
  /** SharedKey for the vpn connection. */
  sharedKey?: string;
  /** EnableBgp flag. */
  enableBgp?: boolean;
  /** Enable policy-based traffic selectors. */
  usePolicyBasedTrafficSelectors?: boolean;
  /** The IPSec Policies to be considered by this connection. */
  ipsecPolicies?: IpsecPolicy[];
  /** The Traffic Selector Policies to be considered by this connection. */
  trafficSelectorPolicies?: TrafficSelectorPolicy[];
  /** EnableBgp flag. */
  enableRateLimiting?: boolean;
  /** Enable internet security. */
  enableInternetSecurity?: boolean;
  /** Use local azure ip to initiate connection. */
  useLocalAzureIpAddress?: boolean;
  /**
   * The provisioning state of the VPN connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** List of all vpn site link connections to the gateway. */
  vpnLinkConnections?: VpnSiteLinkConnection[];
  /** The Routing Configuration indicating the associated and propagated route tables on this connection. */
  routingConfiguration?: RoutingConfiguration;
}

/** VpnGatewayNatRule Resource. */
export interface VpnGatewayNatRule extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * The provisioning state of the NAT Rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The type of NAT rule for VPN NAT. */
  typePropertiesType?: VpnNatRuleType;
  /** The Source NAT direction of a VPN NAT. */
  mode?: VpnNatRuleMode;
  /** The private IP address internal mapping for NAT. */
  internalMappings?: VpnNatRuleMapping[];
  /** The private IP address external mapping for NAT. */
  externalMappings?: VpnNatRuleMapping[];
  /** The IP Configuration ID this NAT rule applies to. */
  ipConfigurationId?: string;
  /**
   * List of egress VpnSiteLinkConnections.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly egressVpnSiteLinkConnections?: SubResource[];
  /**
   * List of ingress VpnSiteLinkConnections.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ingressVpnSiteLinkConnections?: SubResource[];
}

/** ExpressRouteConnection resource. */
export interface ExpressRouteConnection extends SubResource {
  /** The name of the resource. */
  name: string;
  /**
   * The provisioning state of the express route connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The ExpressRoute circuit peering. */
  expressRouteCircuitPeering?: ExpressRouteCircuitPeeringId;
  /** Authorization key to establish the connection. */
  authorizationKey?: string;
  /** The routing weight associated to the connection. */
  routingWeight?: number;
  /** Enable internet security. */
  enableInternetSecurity?: boolean;
  /** Enable FastPath to vWan Firewall hub. */
  expressRouteGatewayBypass?: boolean;
  /** The Routing Configuration indicating the associated and propagated route tables on this connection. */
  routingConfiguration?: RoutingConfiguration;
}

/** Virtual Appliance Site resource. */
export interface BgpConnection extends SubResource {
  /** Name of the connection. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Connection type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Peer ASN. */
  peerAsn?: number;
  /** Peer IP. */
  peerIp?: string;
  /** The reference to the HubVirtualNetworkConnection resource. */
  hubVirtualNetworkConnection?: SubResource;
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The current state of the VirtualHub to Peer.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionState?: HubBgpConnectionStatus;
}

/** IpConfigurations. */
export interface HubIpConfiguration extends SubResource {
  /** Name of the Ip Configuration. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Ipconfiguration type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** The private IP address of the IP configuration. */
  privateIPAddress?: string;
  /** The private IP address allocation method. */
  privateIPAllocationMethod?: IPAllocationMethod;
  /** The reference to the subnet resource. */
  subnet?: Subnet;
  /** The reference to the public IP resource. */
  publicIPAddress?: PublicIPAddress;
  /**
   * The provisioning state of the IP configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** RouteTable resource in a virtual hub. */
export interface HubRouteTable extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** List of all routes. */
  routes?: HubRoute[];
  /** List of labels associated with this route table. */
  labels?: string[];
  /**
   * List of all connections associated with this route table.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly associatedConnections?: string[];
  /**
   * List of all connections that advertise to this route table.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly propagatingConnections?: string[];
  /**
   * The provisioning state of the RouteTable resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** The routing intent child resource of a Virtual hub. */
export interface RoutingIntent extends SubResource {
  /** The name of the resource that is unique within a resource group. This name can be used to access the resource. */
  name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** List of routing policies. */
  routingPolicies?: RoutingPolicy[];
  /**
   * The provisioning state of the RoutingIntent resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Route Filter Rule Resource. */
export interface PatchRouteFilterRule extends SubResource {
  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The access type of the rule. */
  access?: Access;
  /** The rule type of the rule. */
  routeFilterRuleType?: RouteFilterRuleType;
  /** The collection for bgp community values to filter on. e.g. ['12076:5010','12076:5020']. */
  communities?: string[];
  /**
   * The provisioning state of the route filter rule resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Route Filter Resource. */
export interface PatchRouteFilter extends SubResource {
  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Resource type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Resource tags. */
  tags?: { [propertyName: string]: string };
  /** Collection of RouteFilterRules contained within a route filter. */
  rules?: RouteFilterRule[];
  /**
   * A collection of references to express route circuit peerings.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly peerings?: ExpressRouteCircuitPeering[];
  /**
   * A collection of references to express route circuit ipv6 peerings.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipv6Peerings?: ExpressRouteCircuitPeering[];
  /**
   * The provisioning state of the route filter resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** An application security group in a resource group. */
export interface ApplicationSecurityGroup extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The resource GUID property of the application security group resource. It uniquely identifies a resource, even if the user changes its name or migrate the resource across subscriptions or resource groups.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the application security group resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Private endpoint resource. */
export interface PrivateEndpoint extends Resource {
  /** The extended location of the load balancer. */
  extendedLocation?: ExtendedLocation;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The ID of the subnet from which the private IP will be allocated. */
  subnet?: Subnet;
  /**
   * An array of references to the network interfaces created for this private endpoint.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly networkInterfaces?: NetworkInterface[];
  /**
   * The provisioning state of the private endpoint resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** A grouping of information about the connection to the remote resource. */
  privateLinkServiceConnections?: PrivateLinkServiceConnection[];
  /** A grouping of information about the connection to the remote resource. Used when the network admin does not have access to approve connections to the remote resource. */
  manualPrivateLinkServiceConnections?: PrivateLinkServiceConnection[];
  /** An array of custom dns configurations. */
  customDnsConfigs?: CustomDnsConfigPropertiesFormat[];
  /** Application security groups in which the private endpoint IP configuration is included. */
  applicationSecurityGroups?: ApplicationSecurityGroup[];
  /** A list of IP configurations of the private endpoint. This will be used to map to the First Party Service's endpoints. */
  ipConfigurations?: PrivateEndpointIPConfiguration[];
  /** The custom name of the network interface attached to the private endpoint. */
  customNetworkInterfaceName?: string;
}

/** Private link service resource. */
export interface PrivateLinkService extends Resource {
  /** The extended location of the load balancer. */
  extendedLocation?: ExtendedLocation;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** An array of references to the load balancer IP configurations. */
  loadBalancerFrontendIpConfigurations?: FrontendIPConfiguration[];
  /** An array of private link service IP configurations. */
  ipConfigurations?: PrivateLinkServiceIpConfiguration[];
  /**
   * An array of references to the network interfaces created for this private link service.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly networkInterfaces?: NetworkInterface[];
  /**
   * The provisioning state of the private link service resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * An array of list about connections to the private endpoint.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateEndpointConnections?: PrivateEndpointConnection[];
  /** The visibility list of the private link service. */
  visibility?: PrivateLinkServicePropertiesVisibility;
  /** The auto-approval list of the private link service. */
  autoApproval?: PrivateLinkServicePropertiesAutoApproval;
  /** The list of Fqdn. */
  fqdns?: string[];
  /**
   * The alias of the private link service.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly alias?: string;
  /** Whether the private link service is enabled for proxy protocol or not. */
  enableProxyProtocol?: boolean;
}

/** A network interface in a resource group. */
export interface NetworkInterface extends Resource {
  /** The extended location of the network interface. */
  extendedLocation?: ExtendedLocation;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The reference to a virtual machine.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly virtualMachine?: SubResource;
  /** The reference to the NetworkSecurityGroup resource. */
  networkSecurityGroup?: NetworkSecurityGroup;
  /**
   * A reference to the private endpoint to which the network interface is linked.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateEndpoint?: PrivateEndpoint;
  /** A list of IPConfigurations of the network interface. */
  ipConfigurations?: NetworkInterfaceIPConfiguration[];
  /**
   * A list of TapConfigurations of the network interface.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly tapConfigurations?: NetworkInterfaceTapConfiguration[];
  /** The DNS settings in network interface. */
  dnsSettings?: NetworkInterfaceDnsSettings;
  /**
   * The MAC address of the network interface.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly macAddress?: string;
  /**
   * Whether this is a primary network interface on a virtual machine.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly primary?: boolean;
  /**
   * Whether the virtual machine this nic is attached to supports encryption.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly vnetEncryptionSupported?: boolean;
  /** If the network interface is configured for accelerated networking. Not applicable to VM sizes which require accelerated networking. */
  enableAcceleratedNetworking?: boolean;
  /** Indicates whether to disable tcp state tracking. */
  disableTcpStateTracking?: boolean;
  /** Indicates whether IP forwarding is enabled on this network interface. */
  enableIPForwarding?: boolean;
  /**
   * A list of references to linked BareMetal resources.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly hostedWorkloads?: string[];
  /**
   * A reference to the dscp configuration to which the network interface is linked.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly dscpConfiguration?: SubResource;
  /**
   * The resource GUID property of the network interface resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the network interface resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** WorkloadType of the NetworkInterface for BareMetal resources */
  workloadType?: string;
  /** Type of Network Interface resource. */
  nicType?: NetworkInterfaceNicType;
  /** Privatelinkservice of the network interface resource. */
  privateLinkService?: PrivateLinkService;
  /** Migration phase of Network Interface resource. */
  migrationPhase?: NetworkInterfaceMigrationPhase;
  /** Auxiliary mode of Network Interface resource. */
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;
}

/** A flow log resource. */
export interface FlowLog extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** ID of network security group to which flow log will be applied. */
  targetResourceId?: string;
  /**
   * Guid of network security group to which flow log will be applied.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly targetResourceGuid?: string;
  /** ID of the storage account which is used to store the flow log. */
  storageId?: string;
  /** Flag to enable/disable flow logging. */
  enabled?: boolean;
  /** Parameters that define the retention policy for flow log. */
  retentionPolicy?: RetentionPolicyParameters;
  /** Parameters that define the flow log format. */
  format?: FlowLogFormatParameters;
  /** Parameters that define the configuration of traffic analytics. */
  flowAnalyticsConfiguration?: TrafficAnalyticsProperties;
  /**
   * The provisioning state of the flow log.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** NetworkSecurityGroup resource. */
export interface NetworkSecurityGroup extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** When enabled, flows created from Network Security Group connections will be re-evaluated when rules are updates. Initial enablement will trigger re-evaluation. */
  flushConnection?: boolean;
  /** A collection of security rules of the network security group. */
  securityRules?: SecurityRule[];
  /**
   * The default security rules of network security group.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly defaultSecurityRules?: SecurityRule[];
  /**
   * A collection of references to network interfaces.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly networkInterfaces?: NetworkInterface[];
  /**
   * A collection of references to subnets.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly subnets?: Subnet[];
  /**
   * A collection of references to flow log resources.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly flowLogs?: FlowLog[];
  /**
   * The resource GUID property of the network security group resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the network security group resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Route table resource. */
export interface RouteTable extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Collection of routes contained within a route table. */
  routes?: Route[];
  /**
   * A collection of references to subnets.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly subnets?: Subnet[];
  /** Whether to disable the routes learned by BGP on that route table. True means disable. */
  disableBgpRoutePropagation?: boolean;
  /**
   * The provisioning state of the route table resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The resource GUID property of the route table.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
}

/** Service End point policy resource. */
export interface ServiceEndpointPolicy extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Kind of service endpoint policy. This is metadata used for the Azure portal experience.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly kind?: string;
  /** A collection of service endpoint policy definitions of the service endpoint policy. */
  serviceEndpointPolicyDefinitions?: ServiceEndpointPolicyDefinition[];
  /**
   * A collection of references to subnets.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly subnets?: Subnet[];
  /**
   * The resource GUID property of the service endpoint policy resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the service endpoint policy resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The alias indicating if the policy belongs to a service */
  serviceAlias?: string;
  /** A collection of contextual service endpoint policy. */
  contextualServiceEndpointPolicies?: string[];
}

/** Nat Gateway resource. */
export interface NatGateway extends Resource {
  /** The nat gateway SKU. */
  sku?: NatGatewaySku;
  /** A list of availability zones denoting the zone in which Nat Gateway should be deployed. */
  zones?: string[];
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The idle timeout of the nat gateway. */
  idleTimeoutInMinutes?: number;
  /** An array of public ip addresses associated with the nat gateway resource. */
  publicIpAddresses?: SubResource[];
  /** An array of public ip prefixes associated with the nat gateway resource. */
  publicIpPrefixes?: SubResource[];
  /**
   * An array of references to the subnets using this nat gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly subnets?: SubResource[];
  /**
   * The resource GUID property of the NAT gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the NAT gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Public IP address resource. */
export interface PublicIPAddress extends Resource {
  /** The extended location of the public ip address. */
  extendedLocation?: ExtendedLocation;
  /** The public IP address SKU. */
  sku?: PublicIPAddressSku;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** A list of availability zones denoting the IP allocated for the resource needs to come from. */
  zones?: string[];
  /** The public IP address allocation method. */
  publicIPAllocationMethod?: IPAllocationMethod;
  /** The public IP address version. */
  publicIPAddressVersion?: IPVersion;
  /**
   * The IP configuration associated with the public IP address.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipConfiguration?: IPConfiguration;
  /** The FQDN of the DNS record associated with the public IP address. */
  dnsSettings?: PublicIPAddressDnsSettings;
  /** The DDoS protection custom policy associated with the public IP address. */
  ddosSettings?: DdosSettings;
  /** The list of tags associated with the public IP address. */
  ipTags?: IpTag[];
  /** The IP address associated with the public IP address resource. */
  ipAddress?: string;
  /** The Public IP Prefix this Public IP Address should be allocated from. */
  publicIPPrefix?: SubResource;
  /** The idle timeout of the public IP address. */
  idleTimeoutInMinutes?: number;
  /**
   * The resource GUID property of the public IP address resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the public IP address resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The service public IP address of the public IP address resource. */
  servicePublicIPAddress?: PublicIPAddress;
  /** The NatGateway for the Public IP address. */
  natGateway?: NatGateway;
  /** Migration phase of Public IP Address. */
  migrationPhase?: PublicIPAddressMigrationPhase;
  /** The linked public IP address of the public IP address resource. */
  linkedPublicIPAddress?: PublicIPAddress;
  /** Specify what happens to the public IP address when the VM using it is deleted */
  deleteOption?: DeleteOptions;
}

/** Virtual Network Tap resource. */
export interface VirtualNetworkTap extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Specifies the list of resource IDs for the network interface IP configuration that needs to be tapped.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly networkInterfaceTapConfigurations?: NetworkInterfaceTapConfiguration[];
  /**
   * The resource GUID property of the virtual network tap resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the virtual network tap resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The reference to the private IP Address of the collector nic that will receive the tap. */
  destinationNetworkInterfaceIPConfiguration?: NetworkInterfaceIPConfiguration;
  /** The reference to the private IP address on the internal Load Balancer that will receive the tap. */
  destinationLoadBalancerFrontEndIPConfiguration?: FrontendIPConfiguration;
  /** The VXLAN destination port that will receive the tapped traffic. */
  destinationPort?: number;
}

/** Application gateway resource. */
export interface ApplicationGateway extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** A list of availability zones denoting where the resource needs to come from. */
  zones?: string[];
  /** The identity of the application gateway, if configured. */
  identity?: ManagedServiceIdentity;
  /** SKU of the application gateway resource. */
  sku?: ApplicationGatewaySku;
  /** SSL policy of the application gateway resource. */
  sslPolicy?: ApplicationGatewaySslPolicy;
  /**
   * Operational state of the application gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly operationalState?: ApplicationGatewayOperationalState;
  /** Subnets of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  gatewayIPConfigurations?: ApplicationGatewayIPConfiguration[];
  /** Authentication certificates of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  authenticationCertificates?: ApplicationGatewayAuthenticationCertificate[];
  /** Trusted Root certificates of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  trustedRootCertificates?: ApplicationGatewayTrustedRootCertificate[];
  /** Trusted client certificates of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  trustedClientCertificates?: ApplicationGatewayTrustedClientCertificate[];
  /** SSL certificates of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  sslCertificates?: ApplicationGatewaySslCertificate[];
  /** Frontend IP addresses of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  frontendIPConfigurations?: ApplicationGatewayFrontendIPConfiguration[];
  /** Frontend ports of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  frontendPorts?: ApplicationGatewayFrontendPort[];
  /** Probes of the application gateway resource. */
  probes?: ApplicationGatewayProbe[];
  /** Backend address pool of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  backendAddressPools?: ApplicationGatewayBackendAddressPool[];
  /** Backend http settings of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  backendHttpSettingsCollection?: ApplicationGatewayBackendHttpSettings[];
  /** Backend settings of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  backendSettingsCollection?: ApplicationGatewayBackendSettings[];
  /** Http listeners of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  httpListeners?: ApplicationGatewayHttpListener[];
  /** Listeners of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  listeners?: ApplicationGatewayListener[];
  /** SSL profiles of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  sslProfiles?: ApplicationGatewaySslProfile[];
  /** URL path map of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  urlPathMaps?: ApplicationGatewayUrlPathMap[];
  /** Request routing rules of the application gateway resource. */
  requestRoutingRules?: ApplicationGatewayRequestRoutingRule[];
  /** Routing rules of the application gateway resource. */
  routingRules?: ApplicationGatewayRoutingRule[];
  /** Rewrite rules for the application gateway resource. */
  rewriteRuleSets?: ApplicationGatewayRewriteRuleSet[];
  /** Redirect configurations of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits). */
  redirectConfigurations?: ApplicationGatewayRedirectConfiguration[];
  /** Web application firewall configuration. */
  webApplicationFirewallConfiguration?: ApplicationGatewayWebApplicationFirewallConfiguration;
  /** Reference to the FirewallPolicy resource. */
  firewallPolicy?: SubResource;
  /** Whether HTTP2 is enabled on the application gateway resource. */
  enableHttp2?: boolean;
  /** Whether FIPS is enabled on the application gateway resource. */
  enableFips?: boolean;
  /** Autoscale Configuration. */
  autoscaleConfiguration?: ApplicationGatewayAutoscaleConfiguration;
  /** PrivateLink configurations on application gateway. */
  privateLinkConfigurations?: ApplicationGatewayPrivateLinkConfiguration[];
  /**
   * Private Endpoint connections on application gateway.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly privateEndpointConnections?: ApplicationGatewayPrivateEndpointConnection[];
  /**
   * The resource GUID property of the application gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the application gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Custom error configurations of the application gateway resource. */
  customErrorConfigurations?: ApplicationGatewayCustomError[];
  /** If true, associates a firewall policy with an application gateway regardless whether the policy differs from the WAF Config. */
  forceFirewallPolicyAssociation?: boolean;
  /** Load distribution policies of the application gateway resource. */
  loadDistributionPolicies?: ApplicationGatewayLoadDistributionPolicy[];
  /** Global Configuration. */
  globalConfiguration?: ApplicationGatewayGlobalConfiguration;
}

/** A web application firewall rule set. */
export interface ApplicationGatewayFirewallRuleSet extends Resource {
  /**
   * The provisioning state of the web application firewall rule set.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The type of the web application firewall rule set. */
  ruleSetType?: string;
  /** The version of the web application firewall rule set type. */
  ruleSetVersion?: string;
  /** The rule groups of the web application firewall rule set. */
  ruleGroups?: ApplicationGatewayFirewallRuleGroup[];
}

/** Response for ApplicationGatewayAvailableSslOptions API service call. */
export interface ApplicationGatewayAvailableSslOptions extends Resource {
  /** List of available Ssl predefined policy. */
  predefinedPolicies?: SubResource[];
  /** Name of the Ssl predefined policy applied by default to application gateway. */
  defaultPolicy?: ApplicationGatewaySslPolicyName;
  /** List of available Ssl cipher suites. */
  availableCipherSuites?: ApplicationGatewaySslCipherSuite[];
  /** List of available Ssl protocols. */
  availableProtocols?: ApplicationGatewaySslProtocol[];
}

/** Azure Firewall resource. */
export interface AzureFirewall extends Resource {
  /** A list of availability zones denoting where the resource needs to come from. */
  zones?: string[];
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Collection of application rule collections used by Azure Firewall. */
  applicationRuleCollections?: AzureFirewallApplicationRuleCollection[];
  /** Collection of NAT rule collections used by Azure Firewall. */
  natRuleCollections?: AzureFirewallNatRuleCollection[];
  /** Collection of network rule collections used by Azure Firewall. */
  networkRuleCollections?: AzureFirewallNetworkRuleCollection[];
  /** IP configuration of the Azure Firewall resource. */
  ipConfigurations?: AzureFirewallIPConfiguration[];
  /** IP configuration of the Azure Firewall used for management traffic. */
  managementIpConfiguration?: AzureFirewallIPConfiguration;
  /**
   * The provisioning state of the Azure firewall resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The operation mode for Threat Intelligence. */
  threatIntelMode?: AzureFirewallThreatIntelMode;
  /** The virtualHub to which the firewall belongs. */
  virtualHub?: SubResource;
  /** The firewallPolicy associated with this azure firewall. */
  firewallPolicy?: SubResource;
  /** IP addresses associated with AzureFirewall. */
  hubIPAddresses?: HubIPAddresses;
  /**
   * IpGroups associated with AzureFirewall.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipGroups?: AzureFirewallIpGroups[];
  /** The Azure Firewall Resource SKU. */
  sku?: AzureFirewallSku;
  /** The additional properties used to further config this azure firewall. */
  additionalProperties?: { [propertyName: string]: string };
}

/** Azure Firewall FQDN Tag Resource. */
export interface AzureFirewallFqdnTag extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The provisioning state of the Azure firewall FQDN tag resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The name of this FQDN Tag.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly fqdnTagName?: string;
}

/** Bastion Host resource. */
export interface BastionHost extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The sku of this Bastion Host. */
  sku?: Sku;
  /** IP configuration of the Bastion Host resource. */
  ipConfigurations?: BastionHostIPConfiguration[];
  /** FQDN for the endpoint on which bastion host is accessible. */
  dnsName?: string;
  /**
   * The provisioning state of the bastion host resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The scale units for the Bastion Host resource. */
  scaleUnits?: number;
  /** Enable/Disable Copy/Paste feature of the Bastion Host resource. */
  disableCopyPaste?: boolean;
  /** Enable/Disable File Copy feature of the Bastion Host resource. */
  enableFileCopy?: boolean;
  /** Enable/Disable IP Connect feature of the Bastion Host resource. */
  enableIpConnect?: boolean;
  /** Enable/Disable Shareable Link of the Bastion Host resource. */
  enableShareableLink?: boolean;
  /** Enable/Disable Tunneling feature of the Bastion Host resource. */
  enableTunneling?: boolean;
}

/** Describes a Virtual Machine. */
export interface Vm extends Resource {}

/** Custom IP prefix resource. */
export interface CustomIpPrefix extends Resource {
  /** The extended location of the custom IP prefix. */
  extendedLocation?: ExtendedLocation;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** A list of availability zones denoting the IP allocated for the resource needs to come from. */
  zones?: string[];
  /** The prefix range in CIDR notation. Should include the start address and the prefix length. */
  cidr?: string;
  /** Signed message for WAN validation. */
  signedMessage?: string;
  /** Authorization message for WAN validation. */
  authorizationMessage?: string;
  /** The Parent CustomIpPrefix for IPv6 /64 CustomIpPrefix. */
  customIpPrefixParent?: SubResource;
  /**
   * The list of all Children for IPv6 /48 CustomIpPrefix.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly childCustomIpPrefixes?: SubResource[];
  /** The commissioned state of the Custom IP Prefix. */
  commissionedState?: CommissionedState;
  /** Whether to Advertise the range to Internet. */
  noInternetAdvertise?: boolean;
  /**
   * The list of all referenced PublicIpPrefixes.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly publicIpPrefixes?: SubResource[];
  /**
   * The resource GUID property of the custom IP prefix resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The reason why resource is in failed state.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly failedReason?: string;
  /**
   * The provisioning state of the custom IP prefix resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** A DDoS custom policy in a resource group. */
export interface DdosCustomPolicy extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The resource GUID property of the DDoS custom policy resource. It uniquely identifies the resource, even if the user changes its name or migrate the resource across subscriptions or resource groups.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the DDoS custom policy resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The list of public IPs associated with the DDoS custom policy resource. This list is read-only.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly publicIPAddresses?: SubResource[];
  /** The protocol-specific DDoS policy customization parameters. */
  protocolCustomSettings?: ProtocolCustomSettingsFormat[];
}

/** Differentiated Services Code Point configuration for any given network interface */
export interface DscpConfiguration extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** List of markings to be used in the configuration. */
  markings?: number[];
  /** Source IP ranges. */
  sourceIpRanges?: QosIpRange[];
  /** Destination IP ranges. */
  destinationIpRanges?: QosIpRange[];
  /** Sources port ranges. */
  sourcePortRanges?: QosPortRange[];
  /** Destination port ranges. */
  destinationPortRanges?: QosPortRange[];
  /** RNM supported protocol types. */
  protocol?: ProtocolType;
  /** QoS object definitions */
  qosDefinitionCollection?: QosDefinition[];
  /**
   * Qos Collection ID generated by RNM.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly qosCollectionId?: string;
  /**
   * Associated Network Interfaces to the DSCP Configuration.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly associatedNetworkInterfaces?: NetworkInterface[];
  /**
   * The resource GUID property of the DSCP Configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the DSCP Configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** ExpressRouteCircuit resource. */
export interface ExpressRouteCircuit extends Resource {
  /** The SKU. */
  sku?: ExpressRouteCircuitSku;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Allow classic operations. */
  allowClassicOperations?: boolean;
  /** The CircuitProvisioningState state of the resource. */
  circuitProvisioningState?: string;
  /** The ServiceProviderProvisioningState state of the resource. */
  serviceProviderProvisioningState?: ServiceProviderProvisioningState;
  /** The list of authorizations. */
  authorizations?: ExpressRouteCircuitAuthorization[];
  /** The list of peerings. */
  peerings?: ExpressRouteCircuitPeering[];
  /** The ServiceKey. */
  serviceKey?: string;
  /** The ServiceProviderNotes. */
  serviceProviderNotes?: string;
  /** The ServiceProviderProperties. */
  serviceProviderProperties?: ExpressRouteCircuitServiceProviderProperties;
  /** The reference to the ExpressRoutePort resource when the circuit is provisioned on an ExpressRoutePort resource. */
  expressRoutePort?: SubResource;
  /** The bandwidth of the circuit when the circuit is provisioned on an ExpressRoutePort resource. */
  bandwidthInGbps?: number;
  /**
   * The identifier of the circuit traffic. Outer tag for QinQ encapsulation.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly stag?: number;
  /**
   * The provisioning state of the express route circuit resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The GatewayManager Etag. */
  gatewayManagerEtag?: string;
  /** Flag denoting global reach status. */
  globalReachEnabled?: boolean;
  /** The authorizationKey. */
  authorizationKey?: string;
}

/** A ExpressRouteResourceProvider object. */
export interface ExpressRouteServiceProvider extends Resource {
  /** A list of peering locations. */
  peeringLocations?: string[];
  /** A list of bandwidths offered. */
  bandwidthsOffered?: ExpressRouteServiceProviderBandwidthsOffered[];
  /**
   * The provisioning state of the express route service provider resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** ExpressRouteCrossConnection resource. */
export interface ExpressRouteCrossConnection extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The name of the primary port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly primaryAzurePort?: string;
  /**
   * The name of the secondary port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly secondaryAzurePort?: string;
  /**
   * The identifier of the circuit traffic.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sTag?: number;
  /**
   * The peering location of the ExpressRoute circuit.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly peeringLocation?: string;
  /**
   * The circuit bandwidth In Mbps.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly bandwidthInMbps?: number;
  /** The ExpressRouteCircuit. */
  expressRouteCircuit?: ExpressRouteCircuitReference;
  /** The provisioning state of the circuit in the connectivity provider system. */
  serviceProviderProvisioningState?: ServiceProviderProvisioningState;
  /** Additional read only notes set by the connectivity provider. */
  serviceProviderNotes?: string;
  /**
   * The provisioning state of the express route cross connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The list of peerings. */
  peerings?: ExpressRouteCrossConnectionPeering[];
}

/** Definition of the ExpressRoutePorts peering location resource. */
export interface ExpressRoutePortsLocation extends Resource {
  /**
   * Address of peering location.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly address?: string;
  /**
   * Contact details of peering locations.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly contact?: string;
  /** The inventory of available ExpressRoutePort bandwidths. */
  availableBandwidths?: ExpressRoutePortsLocationBandwidths[];
  /**
   * The provisioning state of the express route port location resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** ExpressRoutePort resource definition. */
export interface ExpressRoutePort extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The identity of ExpressRoutePort, if configured. */
  identity?: ManagedServiceIdentity;
  /** The name of the peering location that the ExpressRoutePort is mapped to physically. */
  peeringLocation?: string;
  /** Bandwidth of procured ports in Gbps. */
  bandwidthInGbps?: number;
  /**
   * Aggregate Gbps of associated circuit bandwidths.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisionedBandwidthInGbps?: number;
  /**
   * Maximum transmission unit of the physical port pair(s).
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly mtu?: string;
  /** Encapsulation method on physical ports. */
  encapsulation?: ExpressRoutePortsEncapsulation;
  /**
   * Ether type of the physical port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etherType?: string;
  /**
   * Date of the physical port allocation to be used in Letter of Authorization.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly allocationDate?: string;
  /** The set of physical links of the ExpressRoutePort resource. */
  links?: ExpressRouteLink[];
  /**
   * Reference the ExpressRoute circuit(s) that are provisioned on this ExpressRoutePort resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly circuits?: SubResource[];
  /**
   * The provisioning state of the express route port resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The resource GUID property of the express route port resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
}

/** ExpressRouteProviderPort resource. */
export interface ExpressRouteProviderPort extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The name of the port pair.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly portPairDescriptor?: string;
  /**
   * The name of the primary port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly primaryAzurePort?: string;
  /**
   * The name of the secondary port.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly secondaryAzurePort?: string;
  /** The peering location of the port pair. */
  peeringLocation?: string;
  /** Overprovisioning factor for the port pair. */
  overprovisionFactor?: number;
  /** Bandwidth of the port in Mbps */
  portBandwidthInMbps?: number;
  /** Used Bandwidth of the port in Mbps */
  usedBandwidthInMbps?: number;
  /** Remaining Bandwidth of the port in Mbps */
  remainingBandwidthInMbps?: number;
}

/** FirewallPolicy Resource. */
export interface FirewallPolicy extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The identity of the firewall policy. */
  identity?: ManagedServiceIdentity;
  /**
   * List of references to FirewallPolicyRuleCollectionGroups.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ruleCollectionGroups?: SubResource[];
  /**
   * The provisioning state of the firewall policy resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The parent firewall policy from which rules are inherited. */
  basePolicy?: SubResource;
  /**
   * List of references to Azure Firewalls that this Firewall Policy is associated with.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly firewalls?: SubResource[];
  /**
   * List of references to Child Firewall Policies.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly childPolicies?: SubResource[];
  /** The operation mode for Threat Intelligence. */
  threatIntelMode?: AzureFirewallThreatIntelMode;
  /** ThreatIntel Whitelist for Firewall Policy. */
  threatIntelWhitelist?: FirewallPolicyThreatIntelWhitelist;
  /** Insights on Firewall Policy. */
  insights?: FirewallPolicyInsights;
  /** The private IP addresses/IP ranges to which traffic will not be SNAT. */
  snat?: FirewallPolicySnat;
  /** SQL Settings definition. */
  sql?: FirewallPolicySQL;
  /** DNS Proxy Settings definition. */
  dnsSettings?: DnsSettings;
  /** Explicit Proxy Settings definition. */
  explicitProxy?: ExplicitProxy;
  /** The configuration for Intrusion detection. */
  intrusionDetection?: FirewallPolicyIntrusionDetection;
  /** TLS Configuration definition. */
  transportSecurity?: FirewallPolicyTransportSecurity;
  /** The Firewall Policy SKU. */
  sku?: FirewallPolicySku;
}

/** IpAllocation resource. */
export interface IpAllocation extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The Subnet that using the prefix of this IpAllocation resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly subnet?: SubResource;
  /**
   * The VirtualNetwork that using the prefix of this IpAllocation resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly virtualNetwork?: SubResource;
  /** The type for the IpAllocation. */
  typePropertiesType?: IpAllocationType;
  /** The address prefix for the IpAllocation. */
  prefix?: string;
  /** The address prefix length for the IpAllocation. */
  prefixLength?: number;
  /** The address prefix Type for the IpAllocation. */
  prefixType?: IPVersion;
  /** The IPAM allocation ID. */
  ipamAllocationId?: string;
  /** IpAllocation tags. */
  allocationTags?: { [propertyName: string]: string };
}

/** The IpGroups resource information. */
export interface IpGroup extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The provisioning state of the IpGroups resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** IpAddresses/IpAddressPrefixes in the IpGroups resource. */
  ipAddresses?: string[];
  /**
   * List of references to Firewall resources that this IpGroups is associated with.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly firewalls?: SubResource[];
  /**
   * List of references to Firewall Policies resources that this IpGroups is associated with.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly firewallPolicies?: SubResource[];
}

/** LoadBalancer resource. */
export interface LoadBalancer extends Resource {
  /** The extended location of the load balancer. */
  extendedLocation?: ExtendedLocation;
  /** The load balancer SKU. */
  sku?: LoadBalancerSku;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Object representing the frontend IPs to be used for the load balancer. */
  frontendIPConfigurations?: FrontendIPConfiguration[];
  /** Collection of backend address pools used by a load balancer. */
  backendAddressPools?: BackendAddressPool[];
  /** Object collection representing the load balancing rules Gets the provisioning. */
  loadBalancingRules?: LoadBalancingRule[];
  /** Collection of probe objects used in the load balancer. */
  probes?: Probe[];
  /** Collection of inbound NAT Rules used by a load balancer. Defining inbound NAT rules on your load balancer is mutually exclusive with defining an inbound NAT pool. Inbound NAT pools are referenced from virtual machine scale sets. NICs that are associated with individual virtual machines cannot reference an Inbound NAT pool. They have to reference individual inbound NAT rules. */
  inboundNatRules?: InboundNatRule[];
  /** Defines an external port range for inbound NAT to a single backend port on NICs associated with a load balancer. Inbound NAT rules are created automatically for each NIC associated with the Load Balancer using an external port from this range. Defining an Inbound NAT pool on your Load Balancer is mutually exclusive with defining inbound NAT rules. Inbound NAT pools are referenced from virtual machine scale sets. NICs that are associated with individual virtual machines cannot reference an inbound NAT pool. They have to reference individual inbound NAT rules. */
  inboundNatPools?: InboundNatPool[];
  /** The outbound rules. */
  outboundRules?: OutboundRule[];
  /**
   * The resource GUID property of the load balancer resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the load balancer resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** The Managed Network resource */
export interface NetworkManager extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The system metadata related to this resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
  /** A description of the network manager. */
  description?: string;
  /** Scope of Network Manager. */
  networkManagerScopes?: NetworkManagerPropertiesNetworkManagerScopes;
  /** Scope Access. */
  networkManagerScopeAccesses?: ConfigurationType[];
  /**
   * The provisioning state of the network manager resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Network profile resource. */
export interface NetworkProfile extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * List of child container network interfaces.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly containerNetworkInterfaces?: ContainerNetworkInterface[];
  /** List of chid container network interface configurations. */
  containerNetworkInterfaceConfigurations?: ContainerNetworkInterfaceConfiguration[];
  /**
   * The resource GUID property of the network profile resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the network profile resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** NetworkVirtualAppliance Resource. */
export interface NetworkVirtualAppliance extends Resource {
  /** The service principal that has read access to cloud-init and config blob. */
  identity?: ManagedServiceIdentity;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Network Virtual Appliance SKU. */
  nvaSku?: VirtualApplianceSkuProperties;
  /**
   * Address Prefix.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly addressPrefix?: string;
  /** BootStrapConfigurationBlobs storage URLs. */
  bootStrapConfigurationBlobs?: string[];
  /** The Virtual Hub where Network Virtual Appliance is being deployed. */
  virtualHub?: SubResource;
  /** CloudInitConfigurationBlob storage URLs. */
  cloudInitConfigurationBlobs?: string[];
  /** CloudInitConfiguration string in plain text. */
  cloudInitConfiguration?: string;
  /** VirtualAppliance ASN. */
  virtualApplianceAsn?: number;
  /** Public key for SSH login. */
  sshPublicKey?: string;
  /**
   * List of Virtual Appliance Network Interfaces.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly virtualApplianceNics?: VirtualApplianceNicProperties[];
  /**
   * List of references to VirtualApplianceSite.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly virtualApplianceSites?: SubResource[];
  /**
   * List of references to InboundSecurityRules.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly inboundSecurityRules?: SubResource[];
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Definition of the NetworkVirtualApplianceSkus resource. */
export interface NetworkVirtualApplianceSku extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Network Virtual Appliance Sku vendor.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly vendor?: string;
  /**
   * Available Network Virtual Appliance versions.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly availableVersions?: string[];
  /** The list of scale units available. */
  availableScaleUnits?: NetworkVirtualApplianceSkuInstances[];
}

/** Network watcher in a resource group. */
export interface NetworkWatcher extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The provisioning state of the network watcher resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Public IP prefix resource. */
export interface PublicIPPrefix extends Resource {
  /** The extended location of the public ip address. */
  extendedLocation?: ExtendedLocation;
  /** The public IP prefix SKU. */
  sku?: PublicIPPrefixSku;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** A list of availability zones denoting the IP allocated for the resource needs to come from. */
  zones?: string[];
  /** The public IP address version. */
  publicIPAddressVersion?: IPVersion;
  /** The list of tags associated with the public IP prefix. */
  ipTags?: IpTag[];
  /** The Length of the Public IP Prefix. */
  prefixLength?: number;
  /**
   * The allocated Prefix.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipPrefix?: string;
  /**
   * The list of all referenced PublicIPAddresses.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly publicIPAddresses?: ReferencedPublicIpAddress[];
  /**
   * The reference to load balancer frontend IP configuration associated with the public IP prefix.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly loadBalancerFrontendIpConfiguration?: SubResource;
  /** The customIpPrefix that this prefix is associated with. */
  customIPPrefix?: SubResource;
  /**
   * The resource GUID property of the public IP prefix resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the public IP prefix resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** NatGateway of Public IP Prefix. */
  natGateway?: NatGateway;
}

/** Route Filter Resource. */
export interface RouteFilter extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Collection of RouteFilterRules contained within a route filter. */
  rules?: RouteFilterRule[];
  /**
   * A collection of references to express route circuit peerings.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly peerings?: ExpressRouteCircuitPeering[];
  /**
   * A collection of references to express route circuit ipv6 peerings.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipv6Peerings?: ExpressRouteCircuitPeering[];
  /**
   * The provisioning state of the route filter resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Security Partner Provider resource. */
export interface SecurityPartnerProvider extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * The provisioning state of the Security Partner Provider resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The security provider name. */
  securityProviderName?: SecurityProviderName;
  /**
   * The connection status with the Security Partner Provider.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionStatus?: SecurityPartnerProviderConnectionStatus;
  /** The virtualHub to which the Security Partner Provider belongs. */
  virtualHub?: SubResource;
}

/** Service Community Properties. */
export interface BgpServiceCommunity extends Resource {
  /** The name of the bgp community. e.g. Skype. */
  serviceName?: string;
  /** A list of bgp communities. */
  bgpCommunities?: BGPCommunity[];
}

/** Virtual Network resource. */
export interface VirtualNetwork extends Resource {
  /** The extended location of the virtual network. */
  extendedLocation?: ExtendedLocation;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The AddressSpace that contains an array of IP address ranges that can be used by subnets. */
  addressSpace?: AddressSpace;
  /** The dhcpOptions that contains an array of DNS servers available to VMs deployed in the virtual network. */
  dhcpOptions?: DhcpOptions;
  /** The FlowTimeout value (in minutes) for the Virtual Network */
  flowTimeoutInMinutes?: number;
  /** A list of subnets in a Virtual Network. */
  subnets?: Subnet[];
  /** A list of peerings in a Virtual Network. */
  virtualNetworkPeerings?: VirtualNetworkPeering[];
  /**
   * The resourceGuid property of the Virtual Network resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the virtual network resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Indicates if DDoS protection is enabled for all the protected resources in the virtual network. It requires a DDoS protection plan associated with the resource. */
  enableDdosProtection?: boolean;
  /** Indicates if VM protection is enabled for all the subnets in the virtual network. */
  enableVmProtection?: boolean;
  /** The DDoS protection plan associated with the virtual network. */
  ddosProtectionPlan?: SubResource;
  /** Bgp Communities sent over ExpressRoute with each route corresponding to a prefix in this VNET. */
  bgpCommunities?: VirtualNetworkBgpCommunities;
  /** Indicates if encryption is enabled on virtual network and if VM without encryption is allowed in encrypted VNet. */
  encryption?: VirtualNetworkEncryption;
  /** Array of IpAllocation which reference this VNET. */
  ipAllocations?: SubResource[];
}

/** Network Intent Policy resource. */
export interface NetworkIntentPolicy extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
}

/** A common class for general resource information. */
export interface VirtualNetworkGateway extends Resource {
  /** The extended location of type local virtual network gateway. */
  extendedLocation?: ExtendedLocation;
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** IP configurations for virtual network gateway. */
  ipConfigurations?: VirtualNetworkGatewayIPConfiguration[];
  /** The type of this virtual network gateway. */
  gatewayType?: VirtualNetworkGatewayType;
  /** The type of this virtual network gateway. */
  vpnType?: VpnType;
  /** The generation for this VirtualNetworkGateway. Must be None if gatewayType is not VPN. */
  vpnGatewayGeneration?: VpnGatewayGeneration;
  /** Whether BGP is enabled for this virtual network gateway or not. */
  enableBgp?: boolean;
  /** Whether private IP needs to be enabled on this gateway for connections or not. */
  enablePrivateIpAddress?: boolean;
  /** ActiveActive flag. */
  active?: boolean;
  /** disableIPSecReplayProtection flag. */
  disableIPSecReplayProtection?: boolean;
  /** The reference to the LocalNetworkGateway resource which represents local network site having default routes. Assign Null value in case of removing existing default site setting. */
  gatewayDefaultSite?: SubResource;
  /** The reference to the VirtualNetworkGatewaySku resource which represents the SKU selected for Virtual network gateway. */
  sku?: VirtualNetworkGatewaySku;
  /** The reference to the VpnClientConfiguration resource which represents the P2S VpnClient configurations. */
  vpnClientConfiguration?: VpnClientConfiguration;
  /** Virtual network gateway's BGP speaker settings. */
  bgpSettings?: BgpSettings;
  /** The reference to the address space resource which represents the custom routes address space specified by the customer for virtual network gateway and VpnClient. */
  customRoutes?: AddressSpace;
  /**
   * The resource GUID property of the virtual network gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the virtual network gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Whether dns forwarding is enabled or not. */
  enableDnsForwarding?: boolean;
  /**
   * The IP address allocated by the gateway to which dns requests can be sent.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly inboundDnsForwardingEndpoint?: string;
  /** Customer vnet resource id. VirtualNetworkGateway of type local gateway is associated with the customer vnet. */
  vNetExtendedLocationResourceId?: string;
  /** NatRules for virtual network gateway. */
  natRules?: VirtualNetworkGatewayNatRule[];
  /** EnableBgpRouteTranslationForNat flag. */
  enableBgpRouteTranslationForNat?: boolean;
}

/** A common class for general resource information. */
export interface VirtualNetworkGatewayConnectionListEntity extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The authorizationKey. */
  authorizationKey?: string;
  /** The reference to virtual network gateway resource. */
  virtualNetworkGateway1: VirtualNetworkConnectionGatewayReference;
  /** The reference to virtual network gateway resource. */
  virtualNetworkGateway2?: VirtualNetworkConnectionGatewayReference;
  /** The reference to local network gateway resource. */
  localNetworkGateway2?: VirtualNetworkConnectionGatewayReference;
  /** Gateway connection type. */
  connectionType: VirtualNetworkGatewayConnectionType;
  /** Connection protocol used for this connection. */
  connectionProtocol?: VirtualNetworkGatewayConnectionProtocol;
  /** The routing weight. */
  routingWeight?: number;
  /** The connection mode for this connection. */
  connectionMode?: VirtualNetworkGatewayConnectionMode;
  /** The IPSec shared key. */
  sharedKey?: string;
  /**
   * Virtual Network Gateway connection status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionStatus?: VirtualNetworkGatewayConnectionStatus;
  /**
   * Collection of all tunnels' connection health status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly tunnelConnectionStatus?: TunnelConnectionHealth[];
  /**
   * The egress bytes transferred in this connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly egressBytesTransferred?: number;
  /**
   * The ingress bytes transferred in this connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ingressBytesTransferred?: number;
  /** The reference to peerings resource. */
  peer?: SubResource;
  /** EnableBgp flag. */
  enableBgp?: boolean;
  /** GatewayCustomBgpIpAddresses to be used for virtual network gateway Connection. */
  gatewayCustomBgpIpAddresses?: GatewayCustomBgpIpAddressIpConfiguration[];
  /** Enable policy-based traffic selectors. */
  usePolicyBasedTrafficSelectors?: boolean;
  /** The IPSec Policies to be considered by this connection. */
  ipsecPolicies?: IpsecPolicy[];
  /** The Traffic Selector Policies to be considered by this connection. */
  trafficSelectorPolicies?: TrafficSelectorPolicy[];
  /**
   * The resource GUID property of the virtual network gateway connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the virtual network gateway connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Bypass ExpressRoute Gateway for data forwarding. */
  expressRouteGatewayBypass?: boolean;
}

/** A common class for general resource information. */
export interface LocalNetworkGateway extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Local network site address space. */
  localNetworkAddressSpace?: AddressSpace;
  /** IP address of local network gateway. */
  gatewayIpAddress?: string;
  /** FQDN of local network gateway. */
  fqdn?: string;
  /** Local network gateway's BGP speaker settings. */
  bgpSettings?: BgpSettings;
  /**
   * The resource GUID property of the local network gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the local network gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** A common class for general resource information. */
export interface VirtualNetworkGatewayConnection extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The authorizationKey. */
  authorizationKey?: string;
  /** The reference to virtual network gateway resource. */
  virtualNetworkGateway1: VirtualNetworkGateway;
  /** The reference to virtual network gateway resource. */
  virtualNetworkGateway2?: VirtualNetworkGateway;
  /** The reference to local network gateway resource. */
  localNetworkGateway2?: LocalNetworkGateway;
  /** List of ingress NatRules. */
  ingressNatRules?: SubResource[];
  /** List of egress NatRules. */
  egressNatRules?: SubResource[];
  /** Gateway connection type. */
  connectionType: VirtualNetworkGatewayConnectionType;
  /** Connection protocol used for this connection. */
  connectionProtocol?: VirtualNetworkGatewayConnectionProtocol;
  /** The routing weight. */
  routingWeight?: number;
  /** The dead peer detection timeout of this connection in seconds. */
  dpdTimeoutSeconds?: number;
  /** The connection mode for this connection. */
  connectionMode?: VirtualNetworkGatewayConnectionMode;
  /** The IPSec shared key. */
  sharedKey?: string;
  /**
   * Virtual Network Gateway connection status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionStatus?: VirtualNetworkGatewayConnectionStatus;
  /**
   * Collection of all tunnels' connection health status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly tunnelConnectionStatus?: TunnelConnectionHealth[];
  /**
   * The egress bytes transferred in this connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly egressBytesTransferred?: number;
  /**
   * The ingress bytes transferred in this connection.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ingressBytesTransferred?: number;
  /** The reference to peerings resource. */
  peer?: SubResource;
  /** EnableBgp flag. */
  enableBgp?: boolean;
  /** GatewayCustomBgpIpAddresses to be used for virtual network gateway Connection. */
  gatewayCustomBgpIpAddresses?: GatewayCustomBgpIpAddressIpConfiguration[];
  /** Use private local Azure IP for the connection. */
  useLocalAzureIpAddress?: boolean;
  /** Enable policy-based traffic selectors. */
  usePolicyBasedTrafficSelectors?: boolean;
  /** The IPSec Policies to be considered by this connection. */
  ipsecPolicies?: IpsecPolicy[];
  /** The Traffic Selector Policies to be considered by this connection. */
  trafficSelectorPolicies?: TrafficSelectorPolicy[];
  /**
   * The resource GUID property of the virtual network gateway connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceGuid?: string;
  /**
   * The provisioning state of the virtual network gateway connection resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Bypass ExpressRoute Gateway for data forwarding. */
  expressRouteGatewayBypass?: boolean;
}

/** VirtualRouter Resource. */
export interface VirtualRouter extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** VirtualRouter ASN. */
  virtualRouterAsn?: number;
  /** VirtualRouter IPs. */
  virtualRouterIps?: string[];
  /** The Subnet on which VirtualRouter is hosted. */
  hostedSubnet?: SubResource;
  /** The Gateway on which VirtualRouter is hosted. */
  hostedGateway?: SubResource;
  /**
   * List of references to VirtualRouterPeerings.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly peerings?: SubResource[];
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** VirtualWAN Resource. */
export interface VirtualWAN extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Vpn encryption to be disabled or not. */
  disableVpnEncryption?: boolean;
  /**
   * List of VirtualHubs in the VirtualWAN.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly virtualHubs?: SubResource[];
  /**
   * List of VpnSites in the VirtualWAN.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly vpnSites?: SubResource[];
  /** True if branch to branch traffic is allowed. */
  allowBranchToBranchTraffic?: boolean;
  /** True if Vnet to Vnet traffic is allowed. */
  allowVnetToVnetTraffic?: boolean;
  /**
   * The office local breakout category.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly office365LocalBreakoutCategory?: OfficeTrafficCategory;
  /**
   * The provisioning state of the virtual WAN resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The type of the VirtualWAN. */
  typePropertiesType?: string;
}

/** VpnSite Resource. */
export interface VpnSite extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The VirtualWAN to which the vpnSite belongs. */
  virtualWan?: SubResource;
  /** The device properties. */
  deviceProperties?: DeviceProperties;
  /** The ip-address for the vpn-site. */
  ipAddress?: string;
  /** The key for vpn-site that can be used for connections. */
  siteKey?: string;
  /** The AddressSpace that contains an array of IP address ranges. */
  addressSpace?: AddressSpace;
  /** The set of bgp properties. */
  bgpProperties?: BgpSettings;
  /**
   * The provisioning state of the VPN site resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** IsSecuritySite flag. */
  isSecuritySite?: boolean;
  /** List of all vpn site links. */
  vpnSiteLinks?: VpnSiteLink[];
  /** Office365 Policy. */
  o365Policy?: O365PolicyProperties;
}

/** P2SVpnGateway Resource. */
export interface P2SVpnGateway extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The VirtualHub to which the gateway belongs. */
  virtualHub?: SubResource;
  /** List of all p2s connection configurations of the gateway. */
  p2SConnectionConfigurations?: P2SConnectionConfiguration[];
  /**
   * The provisioning state of the P2S VPN gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The scale unit for this p2s vpn gateway. */
  vpnGatewayScaleUnit?: number;
  /** The VpnServerConfiguration to which the p2sVpnGateway is attached to. */
  vpnServerConfiguration?: SubResource;
  /**
   * All P2S VPN clients' connection health status.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly vpnClientConnectionHealth?: VpnClientConnectionHealth;
  /** List of all customer specified DNS servers IP addresses. */
  customDnsServers?: string[];
  /** Enable Routing Preference property for the Public IP Interface of the P2SVpnGateway. */
  isRoutingPreferenceInternet?: boolean;
}

/** VpnServerConfiguration Resource. */
export interface VpnServerConfiguration extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The name of the VpnServerConfiguration that is unique within a resource group. */
  namePropertiesName?: string;
  /** VPN protocols for the VpnServerConfiguration. */
  vpnProtocols?: VpnGatewayTunnelingProtocol[];
  /** VPN authentication types for the VpnServerConfiguration. */
  vpnAuthenticationTypes?: VpnAuthenticationType[];
  /** VPN client root certificate of VpnServerConfiguration. */
  vpnClientRootCertificates?: VpnServerConfigVpnClientRootCertificate[];
  /** VPN client revoked certificate of VpnServerConfiguration. */
  vpnClientRevokedCertificates?: VpnServerConfigVpnClientRevokedCertificate[];
  /** Radius Server root certificate of VpnServerConfiguration. */
  radiusServerRootCertificates?: VpnServerConfigRadiusServerRootCertificate[];
  /** Radius client root certificate of VpnServerConfiguration. */
  radiusClientRootCertificates?: VpnServerConfigRadiusClientRootCertificate[];
  /** VpnClientIpsecPolicies for VpnServerConfiguration. */
  vpnClientIpsecPolicies?: IpsecPolicy[];
  /** The radius server address property of the VpnServerConfiguration resource for point to site client connection. */
  radiusServerAddress?: string;
  /** The radius secret property of the VpnServerConfiguration resource for point to site client connection. */
  radiusServerSecret?: string;
  /** Multiple Radius Server configuration for VpnServerConfiguration. */
  radiusServers?: RadiusServer[];
  /** The set of aad vpn authentication parameters. */
  aadAuthenticationParameters?: AadAuthenticationParameters;
  /**
   * The provisioning state of the VpnServerConfiguration resource. Possible values are: 'Updating', 'Deleting', and 'Failed'.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: string;
  /**
   * List of references to P2SVpnGateways.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly p2SVpnGateways?: P2SVpnGateway[];
  /** List of all VpnServerConfigurationPolicyGroups. */
  configurationPolicyGroups?: VpnServerConfigurationPolicyGroup[];
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etagPropertiesEtag?: string;
}

/** VirtualHub Resource. */
export interface VirtualHub extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /**
   * Kind of service virtual hub. This is metadata used for the Azure portal experience for Route Server.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly kind?: string;
  /** The VirtualWAN to which the VirtualHub belongs. */
  virtualWan?: SubResource;
  /** The VpnGateway associated with this VirtualHub. */
  vpnGateway?: SubResource;
  /** The P2SVpnGateway associated with this VirtualHub. */
  p2SVpnGateway?: SubResource;
  /** The expressRouteGateway associated with this VirtualHub. */
  expressRouteGateway?: SubResource;
  /** The azureFirewall associated with this VirtualHub. */
  azureFirewall?: SubResource;
  /** The securityPartnerProvider associated with this VirtualHub. */
  securityPartnerProvider?: SubResource;
  /** Address-prefix for this VirtualHub. */
  addressPrefix?: string;
  /** The routeTable associated with this virtual hub. */
  routeTable?: VirtualHubRouteTable;
  /**
   * The provisioning state of the virtual hub resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The Security Provider name. */
  securityProviderName?: string;
  /** List of all virtual hub route table v2s associated with this VirtualHub. */
  virtualHubRouteTableV2S?: VirtualHubRouteTableV2[];
  /** The sku of this VirtualHub. */
  sku?: string;
  /**
   * The routing state.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly routingState?: RoutingState;
  /**
   * List of references to Bgp Connections.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly bgpConnections?: SubResource[];
  /**
   * List of references to IpConfigurations.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipConfigurations?: SubResource[];
  /** VirtualRouter ASN. */
  virtualRouterAsn?: number;
  /** VirtualRouter IPs. */
  virtualRouterIps?: string[];
  /** Flag to control transit for VirtualRouter hub. */
  allowBranchToBranchTraffic?: boolean;
  /** The preferred gateway to route on-prem traffic */
  preferredRoutingGateway?: PreferredRoutingGateway;
  /** The hubRoutingPreference of this VirtualHub. */
  hubRoutingPreference?: HubRoutingPreference;
  /** The VirtualHub Router autoscale configuration. */
  virtualRouterAutoScaleConfiguration?: VirtualRouterAutoScaleConfiguration;
}

/** VpnGateway Resource. */
export interface VpnGateway extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The VirtualHub to which the gateway belongs. */
  virtualHub?: SubResource;
  /** List of all vpn connections to the gateway. */
  connections?: VpnConnection[];
  /** Local network gateway's BGP speaker settings. */
  bgpSettings?: BgpSettings;
  /**
   * The provisioning state of the VPN gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The scale unit for this vpn gateway. */
  vpnGatewayScaleUnit?: number;
  /**
   * List of all IPs configured on the gateway.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly ipConfigurations?: VpnGatewayIpConfiguration[];
  /** Enable BGP routes translation for NAT on this VpnGateway. */
  enableBgpRouteTranslationForNat?: boolean;
  /** Enable Routing Preference property for the Public IP Interface of the VpnGateway. */
  isRoutingPreferenceInternet?: boolean;
  /** List of all the nat Rules associated with the gateway. */
  natRules?: VpnGatewayNatRule[];
}

/** ExpressRoute gateway resource. */
export interface ExpressRouteGateway extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** Configuration for auto scaling. */
  autoScaleConfiguration?: ExpressRouteGatewayPropertiesAutoScaleConfiguration;
  /** List of ExpressRoute connections to the ExpressRoute gateway. */
  expressRouteConnections?: ExpressRouteConnection[];
  /**
   * The provisioning state of the express route gateway resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** The Virtual Hub where the ExpressRoute gateway is or will be deployed. */
  virtualHub?: VirtualHubId;
}

/** Defines web application firewall policy. */
export interface WebApplicationFirewallPolicy extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly etag?: string;
  /** The PolicySettings for policy. */
  policySettings?: PolicySettings;
  /** The custom rules inside the policy. */
  customRules?: WebApplicationFirewallCustomRule[];
  /**
   * A collection of references to application gateways.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly applicationGateways?: ApplicationGateway[];
  /**
   * The provisioning state of the web application firewall policy resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * Resource status of the policy.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resourceState?: WebApplicationFirewallPolicyResourceState;
  /** Describes the managedRules structure. */
  managedRules?: ManagedRulesDefinition;
  /**
   * A collection of references to application gateway http listeners.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly httpListeners?: SubResource[];
  /**
   * A collection of references to application gateway path rules.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly pathBasedRules?: SubResource[];
}

/** The visibility list of the private link service. */
export interface PrivateLinkServicePropertiesVisibility extends ResourceSet {}

/** The auto-approval list of the private link service. */
export interface PrivateLinkServicePropertiesAutoApproval extends ResourceSet {}

/** Firewall Policy NAT Rule Collection. */
export interface FirewallPolicyNatRuleCollection
  extends FirewallPolicyRuleCollection {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  ruleCollectionType: "FirewallPolicyNatRuleCollection";
  /** The action type of a Nat rule collection. */
  action?: FirewallPolicyNatRuleCollectionAction;
  /** List of rules included in a rule collection. */
  rules?: FirewallPolicyRuleUnion[];
}

/** Firewall Policy Filter Rule Collection. */
export interface FirewallPolicyFilterRuleCollection
  extends FirewallPolicyRuleCollection {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  ruleCollectionType: "FirewallPolicyFilterRuleCollection";
  /** The action type of a Filter rule collection. */
  action?: FirewallPolicyFilterRuleCollectionAction;
  /** List of rules included in a rule collection. */
  rules?: FirewallPolicyRuleUnion[];
}

/** Active connectivity configuration. */
export interface ActiveConnectivityConfiguration
  extends EffectiveConnectivityConfiguration {
  /** Deployment time string. */
  commitTime?: Date;
  /** Deployment region. */
  region?: string;
}

/** Network admin rule. */
export interface ActiveSecurityAdminRule extends ActiveBaseSecurityAdminRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  kind: "Custom";
  /** A description for this rule. Restricted to 140 chars. */
  description?: string;
  /** Network protocol this rule applies to. */
  protocol?: SecurityConfigurationRuleProtocol;
  /** The CIDR or source IP ranges. */
  sources?: AddressPrefixItem[];
  /** The destination address prefixes. CIDR or destination IP ranges. */
  destinations?: AddressPrefixItem[];
  /** The source port ranges. */
  sourcePortRanges?: string[];
  /** The destination port ranges. */
  destinationPortRanges?: string[];
  /** Indicates the access allowed for this particular rule */
  access?: SecurityConfigurationRuleAccess;
  /** The priority of the rule. The value can be between 1 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule. */
  priority?: number;
  /** Indicates if the traffic matched against the rule in inbound or outbound. */
  direction?: SecurityConfigurationRuleDirection;
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Network default admin rule. */
export interface ActiveDefaultSecurityAdminRule
  extends ActiveBaseSecurityAdminRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  kind: "Default";
  /**
   * A description for this rule. Restricted to 140 chars.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly description?: string;
  /** Default rule flag. */
  flag?: string;
  /**
   * Network protocol this rule applies to.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly protocol?: SecurityConfigurationRuleProtocol;
  /**
   * The CIDR or source IP ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sources?: AddressPrefixItem[];
  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly destinations?: AddressPrefixItem[];
  /**
   * The source port ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sourcePortRanges?: string[];
  /**
   * The destination port ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly destinationPortRanges?: string[];
  /**
   * Indicates the access allowed for this particular rule
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly access?: SecurityConfigurationRuleAccess;
  /**
   * The priority of the rule. The value can be between 1 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly priority?: number;
  /**
   * Indicates if the traffic matched against the rule in inbound or outbound.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly direction?: SecurityConfigurationRuleDirection;
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** The Network Manager Connection resource */
export interface NetworkManagerConnection extends ChildResource {
  /**
   * The system metadata related to this resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
  /** Network Manager Id. */
  networkManagerId?: string;
  /**
   * Connection state.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionState?: ScopeConnectionState;
  /** A description of the network manager connection. */
  description?: string;
}

/** The network manager connectivity configuration resource */
export interface ConnectivityConfiguration extends ChildResource {
  /**
   * The system metadata related to this resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
  /** A description of the connectivity configuration. */
  description?: string;
  /** Connectivity topology type. */
  connectivityTopology?: ConnectivityTopology;
  /** List of hubItems */
  hubs?: Hub[];
  /** Flag if global mesh is supported. */
  isGlobal?: IsGlobal;
  /** Groups for configuration */
  appliesToGroups?: ConnectivityGroupItem[];
  /**
   * The provisioning state of the connectivity configuration resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Flag if need to remove current existing peerings. */
  deleteExistingPeering?: DeleteExistingPeering;
}

/** The network group resource */
export interface NetworkGroup extends ChildResource {
  /**
   * The system metadata related to this resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
  /** A description of the network group. */
  description?: string;
  /**
   * The provisioning state of the scope assignment resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** StaticMember Item. */
export interface StaticMember extends ChildResource {
  /**
   * The system metadata related to this resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
  /** Resource Id. */
  resourceId?: string;
  /**
   * Resource region.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly region?: string;
  /**
   * The provisioning state of the scope assignment resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** The Scope Connections resource */
export interface ScopeConnection extends ChildResource {
  /**
   * The system metadata related to this resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
  /** Tenant ID. */
  tenantId?: string;
  /** Resource ID. */
  resourceId?: string;
  /**
   * Connection State
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionState?: ScopeConnectionState;
  /** A description of the scope connection. */
  description?: string;
}

/** Defines the security admin configuration */
export interface SecurityAdminConfiguration extends ChildResource {
  /**
   * The system metadata related to this resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
  /** A description of the security configuration. */
  description?: string;
  /** Enum list of network intent policy based services. */
  applyOnNetworkIntentPolicyBasedServices?: NetworkIntentPolicyBasedService[];
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Defines the admin rule collection. */
export interface AdminRuleCollection extends ChildResource {
  /**
   * The system metadata related to this resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
  /** A description of the admin rule collection. */
  description?: string;
  /** Groups for configuration */
  appliesToGroups?: NetworkManagerSecurityGroupItem[];
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Network base admin rule. */
export interface BaseAdminRule extends ChildResource {
  /** Whether the rule is custom or default. */
  kind: AdminRuleKind;
  /**
   * The system metadata related to this resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
}

/** Network admin rule. */
export interface EffectiveSecurityAdminRule
  extends EffectiveBaseSecurityAdminRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  kind: "Custom";
  /** A description for this rule. Restricted to 140 chars. */
  description?: string;
  /** Network protocol this rule applies to. */
  protocol?: SecurityConfigurationRuleProtocol;
  /** The CIDR or source IP ranges. */
  sources?: AddressPrefixItem[];
  /** The destination address prefixes. CIDR or destination IP ranges. */
  destinations?: AddressPrefixItem[];
  /** The source port ranges. */
  sourcePortRanges?: string[];
  /** The destination port ranges. */
  destinationPortRanges?: string[];
  /** Indicates the access allowed for this particular rule */
  access?: SecurityConfigurationRuleAccess;
  /** The priority of the rule. The value can be between 1 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule. */
  priority?: number;
  /** Indicates if the traffic matched against the rule in inbound or outbound. */
  direction?: SecurityConfigurationRuleDirection;
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Network default admin rule. */
export interface EffectiveDefaultSecurityAdminRule
  extends EffectiveBaseSecurityAdminRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  kind: "Default";
  /**
   * A description for this rule. Restricted to 140 chars.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly description?: string;
  /** Default rule flag. */
  flag?: string;
  /**
   * Network protocol this rule applies to.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly protocol?: SecurityConfigurationRuleProtocol;
  /**
   * The CIDR or source IP ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sources?: AddressPrefixItem[];
  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly destinations?: AddressPrefixItem[];
  /**
   * The source port ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sourcePortRanges?: string[];
  /**
   * The destination port ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly destinationPortRanges?: string[];
  /**
   * Indicates the access allowed for this particular rule
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly access?: SecurityConfigurationRuleAccess;
  /**
   * The priority of the rule. The value can be between 1 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly priority?: number;
  /**
   * Indicates if the traffic matched against the rule in inbound or outbound.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly direction?: SecurityConfigurationRuleDirection;
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** The properties of a packet capture session. */
export interface PacketCaptureResultProperties extends PacketCaptureParameters {
  /**
   * The provisioning state of the packet capture session.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Describes the properties of a connection monitor. */
export interface ConnectionMonitorResultProperties
  extends ConnectionMonitorParameters {
  /**
   * The provisioning state of the connection monitor.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /**
   * The date and time when the connection monitor was started.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly startTime?: Date;
  /**
   * The monitoring status of the connection monitor.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly monitoringStatus?: string;
  /**
   * Type of connection monitor.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly connectionMonitorType?: ConnectionMonitorType;
}

/** Rule of type application. */
export interface ApplicationRule extends FirewallPolicyRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  ruleType: "ApplicationRule";
  /** List of source IP addresses for this rule. */
  sourceAddresses?: string[];
  /** List of destination IP addresses or Service Tags. */
  destinationAddresses?: string[];
  /** Array of Application Protocols. */
  protocols?: FirewallPolicyRuleApplicationProtocol[];
  /** List of FQDNs for this rule. */
  targetFqdns?: string[];
  /** List of Urls for this rule condition. */
  targetUrls?: string[];
  /** List of FQDN Tags for this rule. */
  fqdnTags?: string[];
  /** List of source IpGroups for this rule. */
  sourceIpGroups?: string[];
  /** Terminate TLS connections for this rule. */
  terminateTLS?: boolean;
  /** List of destination azure web categories. */
  webCategories?: string[];
}

/** Rule of type nat. */
export interface NatRule extends FirewallPolicyRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  ruleType: "NatRule";
  /** Array of FirewallPolicyRuleNetworkProtocols. */
  ipProtocols?: FirewallPolicyRuleNetworkProtocol[];
  /** List of source IP addresses for this rule. */
  sourceAddresses?: string[];
  /** List of destination IP addresses or Service Tags. */
  destinationAddresses?: string[];
  /** List of destination ports. */
  destinationPorts?: string[];
  /** The translated address for this NAT rule. */
  translatedAddress?: string;
  /** The translated port for this NAT rule. */
  translatedPort?: string;
  /** List of source IpGroups for this rule. */
  sourceIpGroups?: string[];
  /** The translated FQDN for this NAT rule. */
  translatedFqdn?: string;
}

/** Rule of type network. */
export interface NetworkRule extends FirewallPolicyRule {
  /** Polymorphic discriminator, which specifies the different types this object can be */
  ruleType: "NetworkRule";
  /** Array of FirewallPolicyRuleNetworkProtocols. */
  ipProtocols?: FirewallPolicyRuleNetworkProtocol[];
  /** List of source IP addresses for this rule. */
  sourceAddresses?: string[];
  /** List of destination IP addresses or Service Tags. */
  destinationAddresses?: string[];
  /** List of destination ports. */
  destinationPorts?: string[];
  /** List of source IpGroups for this rule. */
  sourceIpGroups?: string[];
  /** List of destination IpGroups for this rule. */
  destinationIpGroups?: string[];
  /** List of destination FQDNs. */
  destinationFqdns?: string[];
}

/** Network admin rule. */
export interface AdminRule extends BaseAdminRule {
  /** A description for this rule. Restricted to 140 chars. */
  description?: string;
  /** Network protocol this rule applies to. */
  protocol?: SecurityConfigurationRuleProtocol;
  /** The CIDR or source IP ranges. */
  sources?: AddressPrefixItem[];
  /** The destination address prefixes. CIDR or destination IP ranges. */
  destinations?: AddressPrefixItem[];
  /** The source port ranges. */
  sourcePortRanges?: string[];
  /** The destination port ranges. */
  destinationPortRanges?: string[];
  /** Indicates the access allowed for this particular rule */
  access?: SecurityConfigurationRuleAccess;
  /** The priority of the rule. The value can be between 1 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule. */
  priority?: number;
  /** Indicates if the traffic matched against the rule in inbound or outbound. */
  direction?: SecurityConfigurationRuleDirection;
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Network default admin rule. */
export interface DefaultAdminRule extends BaseAdminRule {
  /**
   * A description for this rule. Restricted to 140 chars.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly description?: string;
  /** Default rule flag. */
  flag?: string;
  /**
   * Network protocol this rule applies to.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly protocol?: SecurityConfigurationRuleProtocol;
  /**
   * The CIDR or source IP ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sources?: AddressPrefixItem[];
  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly destinations?: AddressPrefixItem[];
  /**
   * The source port ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly sourcePortRanges?: string[];
  /**
   * The destination port ranges.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly destinationPortRanges?: string[];
  /**
   * Indicates the access allowed for this particular rule
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly access?: SecurityConfigurationRuleAccess;
  /**
   * The priority of the rule. The value can be between 1 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly priority?: number;
  /**
   * Indicates if the traffic matched against the rule in inbound or outbound.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly direction?: SecurityConfigurationRuleDirection;
  /**
   * The provisioning state of the resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
}

/** Defines headers for NetworkManagers_delete operation. */
export interface NetworkManagersDeleteHeaders {
  /** The URL of the resource used to check the status of the asynchronous operation. */
  location?: string;
}

/** Defines headers for NetworkManagerCommits_post operation. */
export interface NetworkManagerCommitsPostHeaders {
  /** The URL of the resource used to check the status of the asynchronous operation. */
  location?: string;
}

/** Defines headers for ConnectivityConfigurations_delete operation. */
export interface ConnectivityConfigurationsDeleteHeaders {
  /** The URL of the resource used to check the status of the asynchronous operation. */
  location?: string;
}

/** Defines headers for NetworkGroups_createOrUpdate operation. */
export interface NetworkGroupsCreateOrUpdateHeaders {
  /** The current entity tag. */
  eTag?: string;
}

/** Defines headers for NetworkGroups_delete operation. */
export interface NetworkGroupsDeleteHeaders {
  /** The URL of the resource used to check the status of the asynchronous operation. */
  location?: string;
}

/** Defines headers for SecurityAdminConfigurations_delete operation. */
export interface SecurityAdminConfigurationsDeleteHeaders {
  /** The URL of the resource used to check the status of the asynchronous operation. */
  location?: string;
}

/** Defines headers for AdminRuleCollections_delete operation. */
export interface AdminRuleCollectionsDeleteHeaders {
  /** The URL of the resource used to check the status of the asynchronous operation. */
  location?: string;
}

/** Defines headers for AdminRules_delete operation. */
export interface AdminRulesDeleteHeaders {
  /** The URL of the resource used to check the status of the asynchronous operation. */
  location?: string;
}

/** Known values of {@link ApplicationGatewaySkuName} that the service accepts. */
export enum KnownApplicationGatewaySkuName {
  /** StandardSmall */
  StandardSmall = "Standard_Small",
  /** StandardMedium */
  StandardMedium = "Standard_Medium",
  /** StandardLarge */
  StandardLarge = "Standard_Large",
  /** WAFMedium */
  WAFMedium = "WAF_Medium",
  /** WAFLarge */
  WAFLarge = "WAF_Large",
  /** StandardV2 */
  StandardV2 = "Standard_v2",
  /** WAFV2 */
  WAFV2 = "WAF_v2"
}

/**
 * Defines values for ApplicationGatewaySkuName. \
 * {@link KnownApplicationGatewaySkuName} can be used interchangeably with ApplicationGatewaySkuName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Standard_Small** \
 * **Standard_Medium** \
 * **Standard_Large** \
 * **WAF_Medium** \
 * **WAF_Large** \
 * **Standard_v2** \
 * **WAF_v2**
 */
export type ApplicationGatewaySkuName = string;

/** Known values of {@link ApplicationGatewayTier} that the service accepts. */
export enum KnownApplicationGatewayTier {
  /** Standard */
  Standard = "Standard",
  /** WAF */
  WAF = "WAF",
  /** StandardV2 */
  StandardV2 = "Standard_v2",
  /** WAFV2 */
  WAFV2 = "WAF_v2"
}

/**
 * Defines values for ApplicationGatewayTier. \
 * {@link KnownApplicationGatewayTier} can be used interchangeably with ApplicationGatewayTier,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Standard** \
 * **WAF** \
 * **Standard_v2** \
 * **WAF_v2**
 */
export type ApplicationGatewayTier = string;

/** Known values of {@link ApplicationGatewaySslProtocol} that the service accepts. */
export enum KnownApplicationGatewaySslProtocol {
  /** TLSv10 */
  TLSv10 = "TLSv1_0",
  /** TLSv11 */
  TLSv11 = "TLSv1_1",
  /** TLSv12 */
  TLSv12 = "TLSv1_2",
  /** TLSv13 */
  TLSv13 = "TLSv1_3"
}

/**
 * Defines values for ApplicationGatewaySslProtocol. \
 * {@link KnownApplicationGatewaySslProtocol} can be used interchangeably with ApplicationGatewaySslProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TLSv1_0** \
 * **TLSv1_1** \
 * **TLSv1_2** \
 * **TLSv1_3**
 */
export type ApplicationGatewaySslProtocol = string;

/** Known values of {@link ApplicationGatewaySslPolicyType} that the service accepts. */
export enum KnownApplicationGatewaySslPolicyType {
  /** Predefined */
  Predefined = "Predefined",
  /** Custom */
  Custom = "Custom",
  /** CustomV2 */
  CustomV2 = "CustomV2"
}

/**
 * Defines values for ApplicationGatewaySslPolicyType. \
 * {@link KnownApplicationGatewaySslPolicyType} can be used interchangeably with ApplicationGatewaySslPolicyType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Predefined** \
 * **Custom** \
 * **CustomV2**
 */
export type ApplicationGatewaySslPolicyType = string;

/** Known values of {@link ApplicationGatewaySslPolicyName} that the service accepts. */
export enum KnownApplicationGatewaySslPolicyName {
  /** AppGwSslPolicy20150501 */
  AppGwSslPolicy20150501 = "AppGwSslPolicy20150501",
  /** AppGwSslPolicy20170401 */
  AppGwSslPolicy20170401 = "AppGwSslPolicy20170401",
  /** AppGwSslPolicy20170401S */
  AppGwSslPolicy20170401S = "AppGwSslPolicy20170401S",
  /** AppGwSslPolicy20220101 */
  AppGwSslPolicy20220101 = "AppGwSslPolicy20220101",
  /** AppGwSslPolicy20220101S */
  AppGwSslPolicy20220101S = "AppGwSslPolicy20220101S"
}

/**
 * Defines values for ApplicationGatewaySslPolicyName. \
 * {@link KnownApplicationGatewaySslPolicyName} can be used interchangeably with ApplicationGatewaySslPolicyName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **AppGwSslPolicy20150501** \
 * **AppGwSslPolicy20170401** \
 * **AppGwSslPolicy20170401S** \
 * **AppGwSslPolicy20220101** \
 * **AppGwSslPolicy20220101S**
 */
export type ApplicationGatewaySslPolicyName = string;

/** Known values of {@link ApplicationGatewaySslCipherSuite} that the service accepts. */
export enum KnownApplicationGatewaySslCipherSuite {
  /** TLSEcdheRSAWithAES256CBCSHA384 */
  TLSEcdheRSAWithAES256CBCSHA384 = "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384",
  /** TLSEcdheRSAWithAES128CBCSHA256 */
  TLSEcdheRSAWithAES128CBCSHA256 = "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256",
  /** TLSEcdheRSAWithAES256CBCSHA */
  TLSEcdheRSAWithAES256CBCSHA = "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
  /** TLSEcdheRSAWithAES128CBCSHA */
  TLSEcdheRSAWithAES128CBCSHA = "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
  /** TLSDHERSAWithAES256GCMSHA384 */
  TLSDHERSAWithAES256GCMSHA384 = "TLS_DHE_RSA_WITH_AES_256_GCM_SHA384",
  /** TLSDHERSAWithAES128GCMSHA256 */
  TLSDHERSAWithAES128GCMSHA256 = "TLS_DHE_RSA_WITH_AES_128_GCM_SHA256",
  /** TLSDHERSAWithAES256CBCSHA */
  TLSDHERSAWithAES256CBCSHA = "TLS_DHE_RSA_WITH_AES_256_CBC_SHA",
  /** TLSDHERSAWithAES128CBCSHA */
  TLSDHERSAWithAES128CBCSHA = "TLS_DHE_RSA_WITH_AES_128_CBC_SHA",
  /** TLSRSAWithAES256GCMSHA384 */
  TLSRSAWithAES256GCMSHA384 = "TLS_RSA_WITH_AES_256_GCM_SHA384",
  /** TLSRSAWithAES128GCMSHA256 */
  TLSRSAWithAES128GCMSHA256 = "TLS_RSA_WITH_AES_128_GCM_SHA256",
  /** TLSRSAWithAES256CBCSHA256 */
  TLSRSAWithAES256CBCSHA256 = "TLS_RSA_WITH_AES_256_CBC_SHA256",
  /** TLSRSAWithAES128CBCSHA256 */
  TLSRSAWithAES128CBCSHA256 = "TLS_RSA_WITH_AES_128_CBC_SHA256",
  /** TLSRSAWithAES256CBCSHA */
  TLSRSAWithAES256CBCSHA = "TLS_RSA_WITH_AES_256_CBC_SHA",
  /** TLSRSAWithAES128CBCSHA */
  TLSRSAWithAES128CBCSHA = "TLS_RSA_WITH_AES_128_CBC_SHA",
  /** TLSEcdheEcdsaWithAES256GCMSHA384 */
  TLSEcdheEcdsaWithAES256GCMSHA384 = "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
  /** TLSEcdheEcdsaWithAES128GCMSHA256 */
  TLSEcdheEcdsaWithAES128GCMSHA256 = "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
  /** TLSEcdheEcdsaWithAES256CBCSHA384 */
  TLSEcdheEcdsaWithAES256CBCSHA384 = "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
  /** TLSEcdheEcdsaWithAES128CBCSHA256 */
  TLSEcdheEcdsaWithAES128CBCSHA256 = "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
  /** TLSEcdheEcdsaWithAES256CBCSHA */
  TLSEcdheEcdsaWithAES256CBCSHA = "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA",
  /** TLSEcdheEcdsaWithAES128CBCSHA */
  TLSEcdheEcdsaWithAES128CBCSHA = "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA",
  /** TLSDHEDSSWithAES256CBCSHA256 */
  TLSDHEDSSWithAES256CBCSHA256 = "TLS_DHE_DSS_WITH_AES_256_CBC_SHA256",
  /** TLSDHEDSSWithAES128CBCSHA256 */
  TLSDHEDSSWithAES128CBCSHA256 = "TLS_DHE_DSS_WITH_AES_128_CBC_SHA256",
  /** TLSDHEDSSWithAES256CBCSHA */
  TLSDHEDSSWithAES256CBCSHA = "TLS_DHE_DSS_WITH_AES_256_CBC_SHA",
  /** TLSDHEDSSWithAES128CBCSHA */
  TLSDHEDSSWithAES128CBCSHA = "TLS_DHE_DSS_WITH_AES_128_CBC_SHA",
  /** TLSRSAWith3DESEDECBCSHA */
  TLSRSAWith3DESEDECBCSHA = "TLS_RSA_WITH_3DES_EDE_CBC_SHA",
  /** TLSDHEDSSWith3DESEDECBCSHA */
  TLSDHEDSSWith3DESEDECBCSHA = "TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA",
  /** TLSEcdheRSAWithAES128GCMSHA256 */
  TLSEcdheRSAWithAES128GCMSHA256 = "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
  /** TLSEcdheRSAWithAES256GCMSHA384 */
  TLSEcdheRSAWithAES256GCMSHA384 = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"
}

/**
 * Defines values for ApplicationGatewaySslCipherSuite. \
 * {@link KnownApplicationGatewaySslCipherSuite} can be used interchangeably with ApplicationGatewaySslCipherSuite,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384** \
 * **TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256** \
 * **TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA** \
 * **TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA** \
 * **TLS_DHE_RSA_WITH_AES_256_GCM_SHA384** \
 * **TLS_DHE_RSA_WITH_AES_128_GCM_SHA256** \
 * **TLS_DHE_RSA_WITH_AES_256_CBC_SHA** \
 * **TLS_DHE_RSA_WITH_AES_128_CBC_SHA** \
 * **TLS_RSA_WITH_AES_256_GCM_SHA384** \
 * **TLS_RSA_WITH_AES_128_GCM_SHA256** \
 * **TLS_RSA_WITH_AES_256_CBC_SHA256** \
 * **TLS_RSA_WITH_AES_128_CBC_SHA256** \
 * **TLS_RSA_WITH_AES_256_CBC_SHA** \
 * **TLS_RSA_WITH_AES_128_CBC_SHA** \
 * **TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384** \
 * **TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256** \
 * **TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384** \
 * **TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256** \
 * **TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA** \
 * **TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA** \
 * **TLS_DHE_DSS_WITH_AES_256_CBC_SHA256** \
 * **TLS_DHE_DSS_WITH_AES_128_CBC_SHA256** \
 * **TLS_DHE_DSS_WITH_AES_256_CBC_SHA** \
 * **TLS_DHE_DSS_WITH_AES_128_CBC_SHA** \
 * **TLS_RSA_WITH_3DES_EDE_CBC_SHA** \
 * **TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA** \
 * **TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256** \
 * **TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384**
 */
export type ApplicationGatewaySslCipherSuite = string;

/** Known values of {@link ApplicationGatewayOperationalState} that the service accepts. */
export enum KnownApplicationGatewayOperationalState {
  /** Stopped */
  Stopped = "Stopped",
  /** Starting */
  Starting = "Starting",
  /** Running */
  Running = "Running",
  /** Stopping */
  Stopping = "Stopping"
}

/**
 * Defines values for ApplicationGatewayOperationalState. \
 * {@link KnownApplicationGatewayOperationalState} can be used interchangeably with ApplicationGatewayOperationalState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Stopped** \
 * **Starting** \
 * **Running** \
 * **Stopping**
 */
export type ApplicationGatewayOperationalState = string;

/** Known values of {@link ProvisioningState} that the service accepts. */
export enum KnownProvisioningState {
  /** Succeeded */
  Succeeded = "Succeeded",
  /** Updating */
  Updating = "Updating",
  /** Deleting */
  Deleting = "Deleting",
  /** Failed */
  Failed = "Failed"
}

/**
 * Defines values for ProvisioningState. \
 * {@link KnownProvisioningState} can be used interchangeably with ProvisioningState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Succeeded** \
 * **Updating** \
 * **Deleting** \
 * **Failed**
 */
export type ProvisioningState = string;

/** Known values of {@link IPAllocationMethod} that the service accepts. */
export enum KnownIPAllocationMethod {
  /** Static */
  Static = "Static",
  /** Dynamic */
  Dynamic = "Dynamic"
}

/**
 * Defines values for IPAllocationMethod. \
 * {@link KnownIPAllocationMethod} can be used interchangeably with IPAllocationMethod,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Static** \
 * **Dynamic**
 */
export type IPAllocationMethod = string;

/** Known values of {@link ApplicationGatewayProtocol} that the service accepts. */
export enum KnownApplicationGatewayProtocol {
  /** Http */
  Http = "Http",
  /** Https */
  Https = "Https",
  /** Tcp */
  Tcp = "Tcp",
  /** Tls */
  Tls = "Tls"
}

/**
 * Defines values for ApplicationGatewayProtocol. \
 * {@link KnownApplicationGatewayProtocol} can be used interchangeably with ApplicationGatewayProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Http** \
 * **Https** \
 * **Tcp** \
 * **Tls**
 */
export type ApplicationGatewayProtocol = string;

/** Known values of {@link IPVersion} that the service accepts. */
export enum KnownIPVersion {
  /** IPv4 */
  IPv4 = "IPv4",
  /** IPv6 */
  IPv6 = "IPv6"
}

/**
 * Defines values for IPVersion. \
 * {@link KnownIPVersion} can be used interchangeably with IPVersion,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **IPv4** \
 * **IPv6**
 */
export type IPVersion = string;

/** Known values of {@link SecurityRuleProtocol} that the service accepts. */
export enum KnownSecurityRuleProtocol {
  /** Tcp */
  Tcp = "Tcp",
  /** Udp */
  Udp = "Udp",
  /** Icmp */
  Icmp = "Icmp",
  /** Esp */
  Esp = "Esp",
  /** Asterisk */
  Asterisk = "*",
  /** Ah */
  Ah = "Ah"
}

/**
 * Defines values for SecurityRuleProtocol. \
 * {@link KnownSecurityRuleProtocol} can be used interchangeably with SecurityRuleProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Tcp** \
 * **Udp** \
 * **Icmp** \
 * **Esp** \
 * ***** \
 * **Ah**
 */
export type SecurityRuleProtocol = string;

/** Known values of {@link SecurityRuleAccess} that the service accepts. */
export enum KnownSecurityRuleAccess {
  /** Allow */
  Allow = "Allow",
  /** Deny */
  Deny = "Deny"
}

/**
 * Defines values for SecurityRuleAccess. \
 * {@link KnownSecurityRuleAccess} can be used interchangeably with SecurityRuleAccess,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Allow** \
 * **Deny**
 */
export type SecurityRuleAccess = string;

/** Known values of {@link SecurityRuleDirection} that the service accepts. */
export enum KnownSecurityRuleDirection {
  /** Inbound */
  Inbound = "Inbound",
  /** Outbound */
  Outbound = "Outbound"
}

/**
 * Defines values for SecurityRuleDirection. \
 * {@link KnownSecurityRuleDirection} can be used interchangeably with SecurityRuleDirection,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Inbound** \
 * **Outbound**
 */
export type SecurityRuleDirection = string;

/** Known values of {@link ExtendedLocationTypes} that the service accepts. */
export enum KnownExtendedLocationTypes {
  /** EdgeZone */
  EdgeZone = "EdgeZone"
}

/**
 * Defines values for ExtendedLocationTypes. \
 * {@link KnownExtendedLocationTypes} can be used interchangeably with ExtendedLocationTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **EdgeZone**
 */
export type ExtendedLocationTypes = string;

/** Known values of {@link NetworkInterfaceNicType} that the service accepts. */
export enum KnownNetworkInterfaceNicType {
  /** Standard */
  Standard = "Standard",
  /** Elastic */
  Elastic = "Elastic"
}

/**
 * Defines values for NetworkInterfaceNicType. \
 * {@link KnownNetworkInterfaceNicType} can be used interchangeably with NetworkInterfaceNicType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Standard** \
 * **Elastic**
 */
export type NetworkInterfaceNicType = string;

/** Known values of {@link NetworkInterfaceMigrationPhase} that the service accepts. */
export enum KnownNetworkInterfaceMigrationPhase {
  /** None */
  None = "None",
  /** Prepare */
  Prepare = "Prepare",
  /** Commit */
  Commit = "Commit",
  /** Abort */
  Abort = "Abort",
  /** Committed */
  Committed = "Committed"
}

/**
 * Defines values for NetworkInterfaceMigrationPhase. \
 * {@link KnownNetworkInterfaceMigrationPhase} can be used interchangeably with NetworkInterfaceMigrationPhase,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **Prepare** \
 * **Commit** \
 * **Abort** \
 * **Committed**
 */
export type NetworkInterfaceMigrationPhase = string;

/** Known values of {@link NetworkInterfaceAuxiliaryMode} that the service accepts. */
export enum KnownNetworkInterfaceAuxiliaryMode {
  /** None */
  None = "None",
  /** MaxConnections */
  MaxConnections = "MaxConnections",
  /** Floating */
  Floating = "Floating"
}

/**
 * Defines values for NetworkInterfaceAuxiliaryMode. \
 * {@link KnownNetworkInterfaceAuxiliaryMode} can be used interchangeably with NetworkInterfaceAuxiliaryMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **MaxConnections** \
 * **Floating**
 */
export type NetworkInterfaceAuxiliaryMode = string;

/** Known values of {@link FlowLogFormatType} that the service accepts. */
export enum KnownFlowLogFormatType {
  /** Json */
  Json = "JSON"
}

/**
 * Defines values for FlowLogFormatType. \
 * {@link KnownFlowLogFormatType} can be used interchangeably with FlowLogFormatType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **JSON**
 */
export type FlowLogFormatType = string;

/** Known values of {@link RouteNextHopType} that the service accepts. */
export enum KnownRouteNextHopType {
  /** VirtualNetworkGateway */
  VirtualNetworkGateway = "VirtualNetworkGateway",
  /** VnetLocal */
  VnetLocal = "VnetLocal",
  /** Internet */
  Internet = "Internet",
  /** VirtualAppliance */
  VirtualAppliance = "VirtualAppliance",
  /** None */
  None = "None"
}

/**
 * Defines values for RouteNextHopType. \
 * {@link KnownRouteNextHopType} can be used interchangeably with RouteNextHopType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **VirtualNetworkGateway** \
 * **VnetLocal** \
 * **Internet** \
 * **VirtualAppliance** \
 * **None**
 */
export type RouteNextHopType = string;

/** Known values of {@link PublicIPAddressSkuName} that the service accepts. */
export enum KnownPublicIPAddressSkuName {
  /** Basic */
  Basic = "Basic",
  /** Standard */
  Standard = "Standard"
}

/**
 * Defines values for PublicIPAddressSkuName. \
 * {@link KnownPublicIPAddressSkuName} can be used interchangeably with PublicIPAddressSkuName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Basic** \
 * **Standard**
 */
export type PublicIPAddressSkuName = string;

/** Known values of {@link PublicIPAddressSkuTier} that the service accepts. */
export enum KnownPublicIPAddressSkuTier {
  /** Regional */
  Regional = "Regional",
  /** Global */
  Global = "Global"
}

/**
 * Defines values for PublicIPAddressSkuTier. \
 * {@link KnownPublicIPAddressSkuTier} can be used interchangeably with PublicIPAddressSkuTier,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Regional** \
 * **Global**
 */
export type PublicIPAddressSkuTier = string;

/** Known values of {@link DdosSettingsProtectionCoverage} that the service accepts. */
export enum KnownDdosSettingsProtectionCoverage {
  /** Basic */
  Basic = "Basic",
  /** Standard */
  Standard = "Standard"
}

/**
 * Defines values for DdosSettingsProtectionCoverage. \
 * {@link KnownDdosSettingsProtectionCoverage} can be used interchangeably with DdosSettingsProtectionCoverage,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Basic** \
 * **Standard**
 */
export type DdosSettingsProtectionCoverage = string;

/** Known values of {@link NatGatewaySkuName} that the service accepts. */
export enum KnownNatGatewaySkuName {
  /** Standard */
  Standard = "Standard"
}

/**
 * Defines values for NatGatewaySkuName. \
 * {@link KnownNatGatewaySkuName} can be used interchangeably with NatGatewaySkuName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Standard**
 */
export type NatGatewaySkuName = string;

/** Known values of {@link PublicIPAddressMigrationPhase} that the service accepts. */
export enum KnownPublicIPAddressMigrationPhase {
  /** None */
  None = "None",
  /** Prepare */
  Prepare = "Prepare",
  /** Commit */
  Commit = "Commit",
  /** Abort */
  Abort = "Abort",
  /** Committed */
  Committed = "Committed"
}

/**
 * Defines values for PublicIPAddressMigrationPhase. \
 * {@link KnownPublicIPAddressMigrationPhase} can be used interchangeably with PublicIPAddressMigrationPhase,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **Prepare** \
 * **Commit** \
 * **Abort** \
 * **Committed**
 */
export type PublicIPAddressMigrationPhase = string;

/** Known values of {@link DeleteOptions} that the service accepts. */
export enum KnownDeleteOptions {
  /** Delete */
  Delete = "Delete",
  /** Detach */
  Detach = "Detach"
}

/**
 * Defines values for DeleteOptions. \
 * {@link KnownDeleteOptions} can be used interchangeably with DeleteOptions,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Delete** \
 * **Detach**
 */
export type DeleteOptions = string;

/** Known values of {@link VirtualNetworkPrivateEndpointNetworkPolicies} that the service accepts. */
export enum KnownVirtualNetworkPrivateEndpointNetworkPolicies {
  /** Enabled */
  Enabled = "Enabled",
  /** Disabled */
  Disabled = "Disabled"
}

/**
 * Defines values for VirtualNetworkPrivateEndpointNetworkPolicies. \
 * {@link KnownVirtualNetworkPrivateEndpointNetworkPolicies} can be used interchangeably with VirtualNetworkPrivateEndpointNetworkPolicies,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Enabled** \
 * **Disabled**
 */
export type VirtualNetworkPrivateEndpointNetworkPolicies = string;

/** Known values of {@link VirtualNetworkPrivateLinkServiceNetworkPolicies} that the service accepts. */
export enum KnownVirtualNetworkPrivateLinkServiceNetworkPolicies {
  /** Enabled */
  Enabled = "Enabled",
  /** Disabled */
  Disabled = "Disabled"
}

/**
 * Defines values for VirtualNetworkPrivateLinkServiceNetworkPolicies. \
 * {@link KnownVirtualNetworkPrivateLinkServiceNetworkPolicies} can be used interchangeably with VirtualNetworkPrivateLinkServiceNetworkPolicies,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Enabled** \
 * **Disabled**
 */
export type VirtualNetworkPrivateLinkServiceNetworkPolicies = string;

/** Known values of {@link GatewayLoadBalancerTunnelProtocol} that the service accepts. */
export enum KnownGatewayLoadBalancerTunnelProtocol {
  /** None */
  None = "None",
  /** Native */
  Native = "Native",
  /** Vxlan */
  Vxlan = "VXLAN"
}

/**
 * Defines values for GatewayLoadBalancerTunnelProtocol. \
 * {@link KnownGatewayLoadBalancerTunnelProtocol} can be used interchangeably with GatewayLoadBalancerTunnelProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **Native** \
 * **VXLAN**
 */
export type GatewayLoadBalancerTunnelProtocol = string;

/** Known values of {@link GatewayLoadBalancerTunnelInterfaceType} that the service accepts. */
export enum KnownGatewayLoadBalancerTunnelInterfaceType {
  /** None */
  None = "None",
  /** Internal */
  Internal = "Internal",
  /** External */
  External = "External"
}

/**
 * Defines values for GatewayLoadBalancerTunnelInterfaceType. \
 * {@link KnownGatewayLoadBalancerTunnelInterfaceType} can be used interchangeably with GatewayLoadBalancerTunnelInterfaceType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **Internal** \
 * **External**
 */
export type GatewayLoadBalancerTunnelInterfaceType = string;

/** Known values of {@link LoadBalancerBackendAddressAdminState} that the service accepts. */
export enum KnownLoadBalancerBackendAddressAdminState {
  /** None */
  None = "None",
  /** Up */
  Up = "Up",
  /** Down */
  Down = "Down",
  /** Drain */
  Drain = "Drain"
}

/**
 * Defines values for LoadBalancerBackendAddressAdminState. \
 * {@link KnownLoadBalancerBackendAddressAdminState} can be used interchangeably with LoadBalancerBackendAddressAdminState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **Up** \
 * **Down** \
 * **Drain**
 */
export type LoadBalancerBackendAddressAdminState = string;

/** Known values of {@link TransportProtocol} that the service accepts. */
export enum KnownTransportProtocol {
  /** Udp */
  Udp = "Udp",
  /** Tcp */
  Tcp = "Tcp",
  /** All */
  All = "All"
}

/**
 * Defines values for TransportProtocol. \
 * {@link KnownTransportProtocol} can be used interchangeably with TransportProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Udp** \
 * **Tcp** \
 * **All**
 */
export type TransportProtocol = string;

/** Known values of {@link ApplicationGatewayCookieBasedAffinity} that the service accepts. */
export enum KnownApplicationGatewayCookieBasedAffinity {
  /** Enabled */
  Enabled = "Enabled",
  /** Disabled */
  Disabled = "Disabled"
}

/**
 * Defines values for ApplicationGatewayCookieBasedAffinity. \
 * {@link KnownApplicationGatewayCookieBasedAffinity} can be used interchangeably with ApplicationGatewayCookieBasedAffinity,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Enabled** \
 * **Disabled**
 */
export type ApplicationGatewayCookieBasedAffinity = string;

/** Known values of {@link ApplicationGatewayCustomErrorStatusCode} that the service accepts. */
export enum KnownApplicationGatewayCustomErrorStatusCode {
  /** HttpStatus403 */
  HttpStatus403 = "HttpStatus403",
  /** HttpStatus502 */
  HttpStatus502 = "HttpStatus502"
}

/**
 * Defines values for ApplicationGatewayCustomErrorStatusCode. \
 * {@link KnownApplicationGatewayCustomErrorStatusCode} can be used interchangeably with ApplicationGatewayCustomErrorStatusCode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **HttpStatus403** \
 * **HttpStatus502**
 */
export type ApplicationGatewayCustomErrorStatusCode = string;

/** Known values of {@link ApplicationGatewayRequestRoutingRuleType} that the service accepts. */
export enum KnownApplicationGatewayRequestRoutingRuleType {
  /** Basic */
  Basic = "Basic",
  /** PathBasedRouting */
  PathBasedRouting = "PathBasedRouting"
}

/**
 * Defines values for ApplicationGatewayRequestRoutingRuleType. \
 * {@link KnownApplicationGatewayRequestRoutingRuleType} can be used interchangeably with ApplicationGatewayRequestRoutingRuleType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Basic** \
 * **PathBasedRouting**
 */
export type ApplicationGatewayRequestRoutingRuleType = string;

/** Known values of {@link ApplicationGatewayRedirectType} that the service accepts. */
export enum KnownApplicationGatewayRedirectType {
  /** Permanent */
  Permanent = "Permanent",
  /** Found */
  Found = "Found",
  /** SeeOther */
  SeeOther = "SeeOther",
  /** Temporary */
  Temporary = "Temporary"
}

/**
 * Defines values for ApplicationGatewayRedirectType. \
 * {@link KnownApplicationGatewayRedirectType} can be used interchangeably with ApplicationGatewayRedirectType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Permanent** \
 * **Found** \
 * **SeeOther** \
 * **Temporary**
 */
export type ApplicationGatewayRedirectType = string;

/** Known values of {@link ApplicationGatewayFirewallMode} that the service accepts. */
export enum KnownApplicationGatewayFirewallMode {
  /** Detection */
  Detection = "Detection",
  /** Prevention */
  Prevention = "Prevention"
}

/**
 * Defines values for ApplicationGatewayFirewallMode. \
 * {@link KnownApplicationGatewayFirewallMode} can be used interchangeably with ApplicationGatewayFirewallMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Detection** \
 * **Prevention**
 */
export type ApplicationGatewayFirewallMode = string;

/** Known values of {@link ApplicationGatewayLoadDistributionAlgorithm} that the service accepts. */
export enum KnownApplicationGatewayLoadDistributionAlgorithm {
  /** RoundRobin */
  RoundRobin = "RoundRobin",
  /** LeastConnections */
  LeastConnections = "LeastConnections",
  /** IpHash */
  IpHash = "IpHash"
}

/**
 * Defines values for ApplicationGatewayLoadDistributionAlgorithm. \
 * {@link KnownApplicationGatewayLoadDistributionAlgorithm} can be used interchangeably with ApplicationGatewayLoadDistributionAlgorithm,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **RoundRobin** \
 * **LeastConnections** \
 * **IpHash**
 */
export type ApplicationGatewayLoadDistributionAlgorithm = string;

/** Known values of {@link ApplicationGatewayBackendHealthServerHealth} that the service accepts. */
export enum KnownApplicationGatewayBackendHealthServerHealth {
  /** Unknown */
  Unknown = "Unknown",
  /** Up */
  Up = "Up",
  /** Down */
  Down = "Down",
  /** Partial */
  Partial = "Partial",
  /** Draining */
  Draining = "Draining"
}

/**
 * Defines values for ApplicationGatewayBackendHealthServerHealth. \
 * {@link KnownApplicationGatewayBackendHealthServerHealth} can be used interchangeably with ApplicationGatewayBackendHealthServerHealth,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **Up** \
 * **Down** \
 * **Partial** \
 * **Draining**
 */
export type ApplicationGatewayBackendHealthServerHealth = string;

/** Known values of {@link AzureFirewallRCActionType} that the service accepts. */
export enum KnownAzureFirewallRCActionType {
  /** Allow */
  Allow = "Allow",
  /** Deny */
  Deny = "Deny"
}

/**
 * Defines values for AzureFirewallRCActionType. \
 * {@link KnownAzureFirewallRCActionType} can be used interchangeably with AzureFirewallRCActionType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Allow** \
 * **Deny**
 */
export type AzureFirewallRCActionType = string;

/** Known values of {@link AzureFirewallApplicationRuleProtocolType} that the service accepts. */
export enum KnownAzureFirewallApplicationRuleProtocolType {
  /** Http */
  Http = "Http",
  /** Https */
  Https = "Https",
  /** Mssql */
  Mssql = "Mssql"
}

/**
 * Defines values for AzureFirewallApplicationRuleProtocolType. \
 * {@link KnownAzureFirewallApplicationRuleProtocolType} can be used interchangeably with AzureFirewallApplicationRuleProtocolType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Http** \
 * **Https** \
 * **Mssql**
 */
export type AzureFirewallApplicationRuleProtocolType = string;

/** Known values of {@link AzureFirewallNatRCActionType} that the service accepts. */
export enum KnownAzureFirewallNatRCActionType {
  /** Snat */
  Snat = "Snat",
  /** Dnat */
  Dnat = "Dnat"
}

/**
 * Defines values for AzureFirewallNatRCActionType. \
 * {@link KnownAzureFirewallNatRCActionType} can be used interchangeably with AzureFirewallNatRCActionType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Snat** \
 * **Dnat**
 */
export type AzureFirewallNatRCActionType = string;

/** Known values of {@link AzureFirewallNetworkRuleProtocol} that the service accepts. */
export enum KnownAzureFirewallNetworkRuleProtocol {
  /** TCP */
  TCP = "TCP",
  /** UDP */
  UDP = "UDP",
  /** Any */
  Any = "Any",
  /** Icmp */
  Icmp = "ICMP"
}

/**
 * Defines values for AzureFirewallNetworkRuleProtocol. \
 * {@link KnownAzureFirewallNetworkRuleProtocol} can be used interchangeably with AzureFirewallNetworkRuleProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TCP** \
 * **UDP** \
 * **Any** \
 * **ICMP**
 */
export type AzureFirewallNetworkRuleProtocol = string;

/** Known values of {@link AzureFirewallThreatIntelMode} that the service accepts. */
export enum KnownAzureFirewallThreatIntelMode {
  /** Alert */
  Alert = "Alert",
  /** Deny */
  Deny = "Deny",
  /** Off */
  Off = "Off"
}

/**
 * Defines values for AzureFirewallThreatIntelMode. \
 * {@link KnownAzureFirewallThreatIntelMode} can be used interchangeably with AzureFirewallThreatIntelMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Alert** \
 * **Deny** \
 * **Off**
 */
export type AzureFirewallThreatIntelMode = string;

/** Known values of {@link AzureFirewallSkuName} that the service accepts. */
export enum KnownAzureFirewallSkuName {
  /** AzfwVnet */
  AzfwVnet = "AZFW_VNet",
  /** AzfwHub */
  AzfwHub = "AZFW_Hub"
}

/**
 * Defines values for AzureFirewallSkuName. \
 * {@link KnownAzureFirewallSkuName} can be used interchangeably with AzureFirewallSkuName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **AZFW_VNet** \
 * **AZFW_Hub**
 */
export type AzureFirewallSkuName = string;

/** Known values of {@link AzureFirewallSkuTier} that the service accepts. */
export enum KnownAzureFirewallSkuTier {
  /** Standard */
  Standard = "Standard",
  /** Premium */
  Premium = "Premium",
  /** Basic */
  Basic = "Basic"
}

/**
 * Defines values for AzureFirewallSkuTier. \
 * {@link KnownAzureFirewallSkuTier} can be used interchangeably with AzureFirewallSkuTier,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Standard** \
 * **Premium** \
 * **Basic**
 */
export type AzureFirewallSkuTier = string;

/** Known values of {@link BastionHostSkuName} that the service accepts. */
export enum KnownBastionHostSkuName {
  /** Basic */
  Basic = "Basic",
  /** Standard */
  Standard = "Standard"
}

/**
 * Defines values for BastionHostSkuName. \
 * {@link KnownBastionHostSkuName} can be used interchangeably with BastionHostSkuName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Basic** \
 * **Standard**
 */
export type BastionHostSkuName = string;

/** Known values of {@link BastionConnectProtocol} that the service accepts. */
export enum KnownBastionConnectProtocol {
  /** SSH */
  SSH = "SSH",
  /** RDP */
  RDP = "RDP"
}

/**
 * Defines values for BastionConnectProtocol. \
 * {@link KnownBastionConnectProtocol} can be used interchangeably with BastionConnectProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **SSH** \
 * **RDP**
 */
export type BastionConnectProtocol = string;

/** Known values of {@link CommissionedState} that the service accepts. */
export enum KnownCommissionedState {
  /** Provisioning */
  Provisioning = "Provisioning",
  /** Provisioned */
  Provisioned = "Provisioned",
  /** Commissioning */
  Commissioning = "Commissioning",
  /** Commissioned */
  Commissioned = "Commissioned",
  /** Decommissioning */
  Decommissioning = "Decommissioning",
  /** Deprovisioning */
  Deprovisioning = "Deprovisioning",
  /** CommissionedNoInternetAdvertise */
  CommissionedNoInternetAdvertise = "CommissionedNoInternetAdvertise"
}

/**
 * Defines values for CommissionedState. \
 * {@link KnownCommissionedState} can be used interchangeably with CommissionedState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Provisioning** \
 * **Provisioned** \
 * **Commissioning** \
 * **Commissioned** \
 * **Decommissioning** \
 * **Deprovisioning** \
 * **CommissionedNoInternetAdvertise**
 */
export type CommissionedState = string;

/** Known values of {@link DdosCustomPolicyProtocol} that the service accepts. */
export enum KnownDdosCustomPolicyProtocol {
  /** Tcp */
  Tcp = "Tcp",
  /** Udp */
  Udp = "Udp",
  /** Syn */
  Syn = "Syn"
}

/**
 * Defines values for DdosCustomPolicyProtocol. \
 * {@link KnownDdosCustomPolicyProtocol} can be used interchangeably with DdosCustomPolicyProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Tcp** \
 * **Udp** \
 * **Syn**
 */
export type DdosCustomPolicyProtocol = string;

/** Known values of {@link DdosCustomPolicyTriggerSensitivityOverride} that the service accepts. */
export enum KnownDdosCustomPolicyTriggerSensitivityOverride {
  /** Relaxed */
  Relaxed = "Relaxed",
  /** Low */
  Low = "Low",
  /** Default */
  Default = "Default",
  /** High */
  High = "High"
}

/**
 * Defines values for DdosCustomPolicyTriggerSensitivityOverride. \
 * {@link KnownDdosCustomPolicyTriggerSensitivityOverride} can be used interchangeably with DdosCustomPolicyTriggerSensitivityOverride,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Relaxed** \
 * **Low** \
 * **Default** \
 * **High**
 */
export type DdosCustomPolicyTriggerSensitivityOverride = string;

/** Known values of {@link ProtocolType} that the service accepts. */
export enum KnownProtocolType {
  /** DoNotUse */
  DoNotUse = "DoNotUse",
  /** Icmp */
  Icmp = "Icmp",
  /** Tcp */
  Tcp = "Tcp",
  /** Udp */
  Udp = "Udp",
  /** Gre */
  Gre = "Gre",
  /** Esp */
  Esp = "Esp",
  /** Ah */
  Ah = "Ah",
  /** Vxlan */
  Vxlan = "Vxlan",
  /** All */
  All = "All"
}

/**
 * Defines values for ProtocolType. \
 * {@link KnownProtocolType} can be used interchangeably with ProtocolType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **DoNotUse** \
 * **Icmp** \
 * **Tcp** \
 * **Udp** \
 * **Gre** \
 * **Esp** \
 * **Ah** \
 * **Vxlan** \
 * **All**
 */
export type ProtocolType = string;

/** Known values of {@link AuthorizationUseStatus} that the service accepts. */
export enum KnownAuthorizationUseStatus {
  /** Available */
  Available = "Available",
  /** InUse */
  InUse = "InUse"
}

/**
 * Defines values for AuthorizationUseStatus. \
 * {@link KnownAuthorizationUseStatus} can be used interchangeably with AuthorizationUseStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Available** \
 * **InUse**
 */
export type AuthorizationUseStatus = string;

/** Known values of {@link ExpressRoutePeeringType} that the service accepts. */
export enum KnownExpressRoutePeeringType {
  /** AzurePublicPeering */
  AzurePublicPeering = "AzurePublicPeering",
  /** AzurePrivatePeering */
  AzurePrivatePeering = "AzurePrivatePeering",
  /** MicrosoftPeering */
  MicrosoftPeering = "MicrosoftPeering"
}

/**
 * Defines values for ExpressRoutePeeringType. \
 * {@link KnownExpressRoutePeeringType} can be used interchangeably with ExpressRoutePeeringType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **AzurePublicPeering** \
 * **AzurePrivatePeering** \
 * **MicrosoftPeering**
 */
export type ExpressRoutePeeringType = string;

/** Known values of {@link ExpressRoutePeeringState} that the service accepts. */
export enum KnownExpressRoutePeeringState {
  /** Disabled */
  Disabled = "Disabled",
  /** Enabled */
  Enabled = "Enabled"
}

/**
 * Defines values for ExpressRoutePeeringState. \
 * {@link KnownExpressRoutePeeringState} can be used interchangeably with ExpressRoutePeeringState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Disabled** \
 * **Enabled**
 */
export type ExpressRoutePeeringState = string;

/** Known values of {@link ExpressRouteCircuitPeeringAdvertisedPublicPrefixState} that the service accepts. */
export enum KnownExpressRouteCircuitPeeringAdvertisedPublicPrefixState {
  /** NotConfigured */
  NotConfigured = "NotConfigured",
  /** Configuring */
  Configuring = "Configuring",
  /** Configured */
  Configured = "Configured",
  /** ValidationNeeded */
  ValidationNeeded = "ValidationNeeded"
}

/**
 * Defines values for ExpressRouteCircuitPeeringAdvertisedPublicPrefixState. \
 * {@link KnownExpressRouteCircuitPeeringAdvertisedPublicPrefixState} can be used interchangeably with ExpressRouteCircuitPeeringAdvertisedPublicPrefixState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **NotConfigured** \
 * **Configuring** \
 * **Configured** \
 * **ValidationNeeded**
 */
export type ExpressRouteCircuitPeeringAdvertisedPublicPrefixState = string;

/** Known values of {@link ExpressRouteCircuitPeeringState} that the service accepts. */
export enum KnownExpressRouteCircuitPeeringState {
  /** Disabled */
  Disabled = "Disabled",
  /** Enabled */
  Enabled = "Enabled"
}

/**
 * Defines values for ExpressRouteCircuitPeeringState. \
 * {@link KnownExpressRouteCircuitPeeringState} can be used interchangeably with ExpressRouteCircuitPeeringState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Disabled** \
 * **Enabled**
 */
export type ExpressRouteCircuitPeeringState = string;

/** Known values of {@link CircuitConnectionStatus} that the service accepts. */
export enum KnownCircuitConnectionStatus {
  /** Connected */
  Connected = "Connected",
  /** Connecting */
  Connecting = "Connecting",
  /** Disconnected */
  Disconnected = "Disconnected"
}

/**
 * Defines values for CircuitConnectionStatus. \
 * {@link KnownCircuitConnectionStatus} can be used interchangeably with CircuitConnectionStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Connected** \
 * **Connecting** \
 * **Disconnected**
 */
export type CircuitConnectionStatus = string;

/** Known values of {@link ExpressRouteCircuitSkuTier} that the service accepts. */
export enum KnownExpressRouteCircuitSkuTier {
  /** Standard */
  Standard = "Standard",
  /** Premium */
  Premium = "Premium",
  /** Basic */
  Basic = "Basic",
  /** Local */
  Local = "Local"
}

/**
 * Defines values for ExpressRouteCircuitSkuTier. \
 * {@link KnownExpressRouteCircuitSkuTier} can be used interchangeably with ExpressRouteCircuitSkuTier,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Standard** \
 * **Premium** \
 * **Basic** \
 * **Local**
 */
export type ExpressRouteCircuitSkuTier = string;

/** Known values of {@link ExpressRouteCircuitSkuFamily} that the service accepts. */
export enum KnownExpressRouteCircuitSkuFamily {
  /** UnlimitedData */
  UnlimitedData = "UnlimitedData",
  /** MeteredData */
  MeteredData = "MeteredData"
}

/**
 * Defines values for ExpressRouteCircuitSkuFamily. \
 * {@link KnownExpressRouteCircuitSkuFamily} can be used interchangeably with ExpressRouteCircuitSkuFamily,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **UnlimitedData** \
 * **MeteredData**
 */
export type ExpressRouteCircuitSkuFamily = string;

/** Known values of {@link ServiceProviderProvisioningState} that the service accepts. */
export enum KnownServiceProviderProvisioningState {
  /** NotProvisioned */
  NotProvisioned = "NotProvisioned",
  /** Provisioning */
  Provisioning = "Provisioning",
  /** Provisioned */
  Provisioned = "Provisioned",
  /** Deprovisioning */
  Deprovisioning = "Deprovisioning"
}

/**
 * Defines values for ServiceProviderProvisioningState. \
 * {@link KnownServiceProviderProvisioningState} can be used interchangeably with ServiceProviderProvisioningState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **NotProvisioned** \
 * **Provisioning** \
 * **Provisioned** \
 * **Deprovisioning**
 */
export type ServiceProviderProvisioningState = string;

/** Known values of {@link ExpressRoutePortsEncapsulation} that the service accepts. */
export enum KnownExpressRoutePortsEncapsulation {
  /** Dot1Q */
  Dot1Q = "Dot1Q",
  /** QinQ */
  QinQ = "QinQ"
}

/**
 * Defines values for ExpressRoutePortsEncapsulation. \
 * {@link KnownExpressRoutePortsEncapsulation} can be used interchangeably with ExpressRoutePortsEncapsulation,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Dot1Q** \
 * **QinQ**
 */
export type ExpressRoutePortsEncapsulation = string;

/** Known values of {@link ExpressRouteLinkConnectorType} that the service accepts. */
export enum KnownExpressRouteLinkConnectorType {
  /** LC */
  LC = "LC",
  /** SC */
  SC = "SC"
}

/**
 * Defines values for ExpressRouteLinkConnectorType. \
 * {@link KnownExpressRouteLinkConnectorType} can be used interchangeably with ExpressRouteLinkConnectorType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **LC** \
 * **SC**
 */
export type ExpressRouteLinkConnectorType = string;

/** Known values of {@link ExpressRouteLinkAdminState} that the service accepts. */
export enum KnownExpressRouteLinkAdminState {
  /** Enabled */
  Enabled = "Enabled",
  /** Disabled */
  Disabled = "Disabled"
}

/**
 * Defines values for ExpressRouteLinkAdminState. \
 * {@link KnownExpressRouteLinkAdminState} can be used interchangeably with ExpressRouteLinkAdminState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Enabled** \
 * **Disabled**
 */
export type ExpressRouteLinkAdminState = string;

/** Known values of {@link ExpressRouteLinkMacSecCipher} that the service accepts. */
export enum KnownExpressRouteLinkMacSecCipher {
  /** GcmAes256 */
  GcmAes256 = "GcmAes256",
  /** GcmAes128 */
  GcmAes128 = "GcmAes128",
  /** GcmAesXpn128 */
  GcmAesXpn128 = "GcmAesXpn128",
  /** GcmAesXpn256 */
  GcmAesXpn256 = "GcmAesXpn256"
}

/**
 * Defines values for ExpressRouteLinkMacSecCipher. \
 * {@link KnownExpressRouteLinkMacSecCipher} can be used interchangeably with ExpressRouteLinkMacSecCipher,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **GcmAes256** \
 * **GcmAes128** \
 * **GcmAesXpn128** \
 * **GcmAesXpn256**
 */
export type ExpressRouteLinkMacSecCipher = string;

/** Known values of {@link ExpressRouteLinkMacSecSciState} that the service accepts. */
export enum KnownExpressRouteLinkMacSecSciState {
  /** Disabled */
  Disabled = "Disabled",
  /** Enabled */
  Enabled = "Enabled"
}

/**
 * Defines values for ExpressRouteLinkMacSecSciState. \
 * {@link KnownExpressRouteLinkMacSecSciState} can be used interchangeably with ExpressRouteLinkMacSecSciState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Disabled** \
 * **Enabled**
 */
export type ExpressRouteLinkMacSecSciState = string;

/** Known values of {@link ExpressRoutePortAuthorizationUseStatus} that the service accepts. */
export enum KnownExpressRoutePortAuthorizationUseStatus {
  /** Available */
  Available = "Available",
  /** InUse */
  InUse = "InUse"
}

/**
 * Defines values for ExpressRoutePortAuthorizationUseStatus. \
 * {@link KnownExpressRoutePortAuthorizationUseStatus} can be used interchangeably with ExpressRoutePortAuthorizationUseStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Available** \
 * **InUse**
 */
export type ExpressRoutePortAuthorizationUseStatus = string;

/** Known values of {@link AutoLearnPrivateRangesMode} that the service accepts. */
export enum KnownAutoLearnPrivateRangesMode {
  /** Enabled */
  Enabled = "Enabled",
  /** Disabled */
  Disabled = "Disabled"
}

/**
 * Defines values for AutoLearnPrivateRangesMode. \
 * {@link KnownAutoLearnPrivateRangesMode} can be used interchangeably with AutoLearnPrivateRangesMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Enabled** \
 * **Disabled**
 */
export type AutoLearnPrivateRangesMode = string;

/** Known values of {@link FirewallPolicyIntrusionDetectionStateType} that the service accepts. */
export enum KnownFirewallPolicyIntrusionDetectionStateType {
  /** Off */
  Off = "Off",
  /** Alert */
  Alert = "Alert",
  /** Deny */
  Deny = "Deny"
}

/**
 * Defines values for FirewallPolicyIntrusionDetectionStateType. \
 * {@link KnownFirewallPolicyIntrusionDetectionStateType} can be used interchangeably with FirewallPolicyIntrusionDetectionStateType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Off** \
 * **Alert** \
 * **Deny**
 */
export type FirewallPolicyIntrusionDetectionStateType = string;

/** Known values of {@link FirewallPolicyIntrusionDetectionProtocol} that the service accepts. */
export enum KnownFirewallPolicyIntrusionDetectionProtocol {
  /** TCP */
  TCP = "TCP",
  /** UDP */
  UDP = "UDP",
  /** Icmp */
  Icmp = "ICMP",
  /** ANY */
  ANY = "ANY"
}

/**
 * Defines values for FirewallPolicyIntrusionDetectionProtocol. \
 * {@link KnownFirewallPolicyIntrusionDetectionProtocol} can be used interchangeably with FirewallPolicyIntrusionDetectionProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TCP** \
 * **UDP** \
 * **ICMP** \
 * **ANY**
 */
export type FirewallPolicyIntrusionDetectionProtocol = string;

/** Known values of {@link FirewallPolicySkuTier} that the service accepts. */
export enum KnownFirewallPolicySkuTier {
  /** Standard */
  Standard = "Standard",
  /** Premium */
  Premium = "Premium",
  /** Basic */
  Basic = "Basic"
}

/**
 * Defines values for FirewallPolicySkuTier. \
 * {@link KnownFirewallPolicySkuTier} can be used interchangeably with FirewallPolicySkuTier,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Standard** \
 * **Premium** \
 * **Basic**
 */
export type FirewallPolicySkuTier = string;

/** Known values of {@link FirewallPolicyRuleCollectionType} that the service accepts. */
export enum KnownFirewallPolicyRuleCollectionType {
  /** FirewallPolicyNatRuleCollection */
  FirewallPolicyNatRuleCollection = "FirewallPolicyNatRuleCollection",
  /** FirewallPolicyFilterRuleCollection */
  FirewallPolicyFilterRuleCollection = "FirewallPolicyFilterRuleCollection"
}

/**
 * Defines values for FirewallPolicyRuleCollectionType. \
 * {@link KnownFirewallPolicyRuleCollectionType} can be used interchangeably with FirewallPolicyRuleCollectionType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **FirewallPolicyNatRuleCollection** \
 * **FirewallPolicyFilterRuleCollection**
 */
export type FirewallPolicyRuleCollectionType = string;

/** Known values of {@link FirewallPolicyIdpsQuerySortOrder} that the service accepts. */
export enum KnownFirewallPolicyIdpsQuerySortOrder {
  /** Ascending */
  Ascending = "Ascending",
  /** Descending */
  Descending = "Descending"
}

/**
 * Defines values for FirewallPolicyIdpsQuerySortOrder. \
 * {@link KnownFirewallPolicyIdpsQuerySortOrder} can be used interchangeably with FirewallPolicyIdpsQuerySortOrder,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Ascending** \
 * **Descending**
 */
export type FirewallPolicyIdpsQuerySortOrder = string;

/** Known values of {@link IpAllocationType} that the service accepts. */
export enum KnownIpAllocationType {
  /** Undefined */
  Undefined = "Undefined",
  /** Hypernet */
  Hypernet = "Hypernet"
}

/**
 * Defines values for IpAllocationType. \
 * {@link KnownIpAllocationType} can be used interchangeably with IpAllocationType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Undefined** \
 * **Hypernet**
 */
export type IpAllocationType = string;

/** Known values of {@link LoadBalancerSkuName} that the service accepts. */
export enum KnownLoadBalancerSkuName {
  /** Basic */
  Basic = "Basic",
  /** Standard */
  Standard = "Standard",
  /** Gateway */
  Gateway = "Gateway"
}

/**
 * Defines values for LoadBalancerSkuName. \
 * {@link KnownLoadBalancerSkuName} can be used interchangeably with LoadBalancerSkuName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Basic** \
 * **Standard** \
 * **Gateway**
 */
export type LoadBalancerSkuName = string;

/** Known values of {@link LoadBalancerSkuTier} that the service accepts. */
export enum KnownLoadBalancerSkuTier {
  /** Regional */
  Regional = "Regional",
  /** Global */
  Global = "Global"
}

/**
 * Defines values for LoadBalancerSkuTier. \
 * {@link KnownLoadBalancerSkuTier} can be used interchangeably with LoadBalancerSkuTier,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Regional** \
 * **Global**
 */
export type LoadBalancerSkuTier = string;

/** Known values of {@link LoadDistribution} that the service accepts. */
export enum KnownLoadDistribution {
  /** Default */
  Default = "Default",
  /** SourceIP */
  SourceIP = "SourceIP",
  /** SourceIPProtocol */
  SourceIPProtocol = "SourceIPProtocol"
}

/**
 * Defines values for LoadDistribution. \
 * {@link KnownLoadDistribution} can be used interchangeably with LoadDistribution,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Default** \
 * **SourceIP** \
 * **SourceIPProtocol**
 */
export type LoadDistribution = string;

/** Known values of {@link ProbeProtocol} that the service accepts. */
export enum KnownProbeProtocol {
  /** Http */
  Http = "Http",
  /** Tcp */
  Tcp = "Tcp",
  /** Https */
  Https = "Https"
}

/**
 * Defines values for ProbeProtocol. \
 * {@link KnownProbeProtocol} can be used interchangeably with ProbeProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Http** \
 * **Tcp** \
 * **Https**
 */
export type ProbeProtocol = string;

/** Known values of {@link LoadBalancerOutboundRuleProtocol} that the service accepts. */
export enum KnownLoadBalancerOutboundRuleProtocol {
  /** Tcp */
  Tcp = "Tcp",
  /** Udp */
  Udp = "Udp",
  /** All */
  All = "All"
}

/**
 * Defines values for LoadBalancerOutboundRuleProtocol. \
 * {@link KnownLoadBalancerOutboundRuleProtocol} can be used interchangeably with LoadBalancerOutboundRuleProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Tcp** \
 * **Udp** \
 * **All**
 */
export type LoadBalancerOutboundRuleProtocol = string;

/** Known values of {@link EffectiveRouteSource} that the service accepts. */
export enum KnownEffectiveRouteSource {
  /** Unknown */
  Unknown = "Unknown",
  /** User */
  User = "User",
  /** VirtualNetworkGateway */
  VirtualNetworkGateway = "VirtualNetworkGateway",
  /** Default */
  Default = "Default"
}

/**
 * Defines values for EffectiveRouteSource. \
 * {@link KnownEffectiveRouteSource} can be used interchangeably with EffectiveRouteSource,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **User** \
 * **VirtualNetworkGateway** \
 * **Default**
 */
export type EffectiveRouteSource = string;

/** Known values of {@link EffectiveRouteState} that the service accepts. */
export enum KnownEffectiveRouteState {
  /** Active */
  Active = "Active",
  /** Invalid */
  Invalid = "Invalid"
}

/**
 * Defines values for EffectiveRouteState. \
 * {@link KnownEffectiveRouteState} can be used interchangeably with EffectiveRouteState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Active** \
 * **Invalid**
 */
export type EffectiveRouteState = string;

/** Known values of {@link EffectiveSecurityRuleProtocol} that the service accepts. */
export enum KnownEffectiveSecurityRuleProtocol {
  /** Tcp */
  Tcp = "Tcp",
  /** Udp */
  Udp = "Udp",
  /** All */
  All = "All"
}

/**
 * Defines values for EffectiveSecurityRuleProtocol. \
 * {@link KnownEffectiveSecurityRuleProtocol} can be used interchangeably with EffectiveSecurityRuleProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Tcp** \
 * **Udp** \
 * **All**
 */
export type EffectiveSecurityRuleProtocol = string;

/** Known values of {@link ConfigurationType} that the service accepts. */
export enum KnownConfigurationType {
  /** SecurityAdmin */
  SecurityAdmin = "SecurityAdmin",
  /** Connectivity */
  Connectivity = "Connectivity"
}

/**
 * Defines values for ConfigurationType. \
 * {@link KnownConfigurationType} can be used interchangeably with ConfigurationType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **SecurityAdmin** \
 * **Connectivity**
 */
export type ConfigurationType = string;

/** Known values of {@link CreatedByType} that the service accepts. */
export enum KnownCreatedByType {
  /** User */
  User = "User",
  /** Application */
  Application = "Application",
  /** ManagedIdentity */
  ManagedIdentity = "ManagedIdentity",
  /** Key */
  Key = "Key"
}

/**
 * Defines values for CreatedByType. \
 * {@link KnownCreatedByType} can be used interchangeably with CreatedByType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **User** \
 * **Application** \
 * **ManagedIdentity** \
 * **Key**
 */
export type CreatedByType = string;

/** Known values of {@link DeploymentStatus} that the service accepts. */
export enum KnownDeploymentStatus {
  /** NotStarted */
  NotStarted = "NotStarted",
  /** Deploying */
  Deploying = "Deploying",
  /** Deployed */
  Deployed = "Deployed",
  /** Failed */
  Failed = "Failed"
}

/**
 * Defines values for DeploymentStatus. \
 * {@link KnownDeploymentStatus} can be used interchangeably with DeploymentStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **NotStarted** \
 * **Deploying** \
 * **Deployed** \
 * **Failed**
 */
export type DeploymentStatus = string;

/** Known values of {@link ConnectivityTopology} that the service accepts. */
export enum KnownConnectivityTopology {
  /** HubAndSpoke */
  HubAndSpoke = "HubAndSpoke",
  /** Mesh */
  Mesh = "Mesh"
}

/**
 * Defines values for ConnectivityTopology. \
 * {@link KnownConnectivityTopology} can be used interchangeably with ConnectivityTopology,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **HubAndSpoke** \
 * **Mesh**
 */
export type ConnectivityTopology = string;

/** Known values of {@link IsGlobal} that the service accepts. */
export enum KnownIsGlobal {
  /** False */
  False = "False",
  /** True */
  True = "True"
}

/**
 * Defines values for IsGlobal. \
 * {@link KnownIsGlobal} can be used interchangeably with IsGlobal,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **False** \
 * **True**
 */
export type IsGlobal = string;

/** Known values of {@link UseHubGateway} that the service accepts. */
export enum KnownUseHubGateway {
  /** False */
  False = "False",
  /** True */
  True = "True"
}

/**
 * Defines values for UseHubGateway. \
 * {@link KnownUseHubGateway} can be used interchangeably with UseHubGateway,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **False** \
 * **True**
 */
export type UseHubGateway = string;

/** Known values of {@link GroupConnectivity} that the service accepts. */
export enum KnownGroupConnectivity {
  /** None */
  None = "None",
  /** DirectlyConnected */
  DirectlyConnected = "DirectlyConnected"
}

/**
 * Defines values for GroupConnectivity. \
 * {@link KnownGroupConnectivity} can be used interchangeably with GroupConnectivity,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **DirectlyConnected**
 */
export type GroupConnectivity = string;

/** Known values of {@link DeleteExistingPeering} that the service accepts. */
export enum KnownDeleteExistingPeering {
  /** False */
  False = "False",
  /** True */
  True = "True"
}

/**
 * Defines values for DeleteExistingPeering. \
 * {@link KnownDeleteExistingPeering} can be used interchangeably with DeleteExistingPeering,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **False** \
 * **True**
 */
export type DeleteExistingPeering = string;

/** Known values of {@link EffectiveAdminRuleKind} that the service accepts. */
export enum KnownEffectiveAdminRuleKind {
  /** Custom */
  Custom = "Custom",
  /** Default */
  Default = "Default"
}

/**
 * Defines values for EffectiveAdminRuleKind. \
 * {@link KnownEffectiveAdminRuleKind} can be used interchangeably with EffectiveAdminRuleKind,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Custom** \
 * **Default**
 */
export type EffectiveAdminRuleKind = string;

/** Known values of {@link ScopeConnectionState} that the service accepts. */
export enum KnownScopeConnectionState {
  /** Connected */
  Connected = "Connected",
  /** Pending */
  Pending = "Pending",
  /** Conflict */
  Conflict = "Conflict",
  /** Revoked */
  Revoked = "Revoked",
  /** Rejected */
  Rejected = "Rejected"
}

/**
 * Defines values for ScopeConnectionState. \
 * {@link KnownScopeConnectionState} can be used interchangeably with ScopeConnectionState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Connected** \
 * **Pending** \
 * **Conflict** \
 * **Revoked** \
 * **Rejected**
 */
export type ScopeConnectionState = string;

/** Known values of {@link NetworkIntentPolicyBasedService} that the service accepts. */
export enum KnownNetworkIntentPolicyBasedService {
  /** None */
  None = "None",
  /** All */
  All = "All"
}

/**
 * Defines values for NetworkIntentPolicyBasedService. \
 * {@link KnownNetworkIntentPolicyBasedService} can be used interchangeably with NetworkIntentPolicyBasedService,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **All**
 */
export type NetworkIntentPolicyBasedService = string;

/** Known values of {@link AdminRuleKind} that the service accepts. */
export enum KnownAdminRuleKind {
  /** Custom */
  Custom = "Custom",
  /** Default */
  Default = "Default"
}

/**
 * Defines values for AdminRuleKind. \
 * {@link KnownAdminRuleKind} can be used interchangeably with AdminRuleKind,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Custom** \
 * **Default**
 */
export type AdminRuleKind = string;

/** Known values of {@link InboundSecurityRulesProtocol} that the service accepts. */
export enum KnownInboundSecurityRulesProtocol {
  /** TCP */
  TCP = "TCP",
  /** UDP */
  UDP = "UDP"
}

/**
 * Defines values for InboundSecurityRulesProtocol. \
 * {@link KnownInboundSecurityRulesProtocol} can be used interchangeably with InboundSecurityRulesProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TCP** \
 * **UDP**
 */
export type InboundSecurityRulesProtocol = string;

/** Known values of {@link AssociationType} that the service accepts. */
export enum KnownAssociationType {
  /** Associated */
  Associated = "Associated",
  /** Contains */
  Contains = "Contains"
}

/**
 * Defines values for AssociationType. \
 * {@link KnownAssociationType} can be used interchangeably with AssociationType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Associated** \
 * **Contains**
 */
export type AssociationType = string;

/** Known values of {@link Direction} that the service accepts. */
export enum KnownDirection {
  /** Inbound */
  Inbound = "Inbound",
  /** Outbound */
  Outbound = "Outbound"
}

/**
 * Defines values for Direction. \
 * {@link KnownDirection} can be used interchangeably with Direction,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Inbound** \
 * **Outbound**
 */
export type Direction = string;

/** Known values of {@link IpFlowProtocol} that the service accepts. */
export enum KnownIpFlowProtocol {
  /** TCP */
  TCP = "TCP",
  /** UDP */
  UDP = "UDP"
}

/**
 * Defines values for IpFlowProtocol. \
 * {@link KnownIpFlowProtocol} can be used interchangeably with IpFlowProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TCP** \
 * **UDP**
 */
export type IpFlowProtocol = string;

/** Known values of {@link Access} that the service accepts. */
export enum KnownAccess {
  /** Allow */
  Allow = "Allow",
  /** Deny */
  Deny = "Deny"
}

/**
 * Defines values for Access. \
 * {@link KnownAccess} can be used interchangeably with Access,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Allow** \
 * **Deny**
 */
export type Access = string;

/** Known values of {@link NextHopType} that the service accepts. */
export enum KnownNextHopType {
  /** Internet */
  Internet = "Internet",
  /** VirtualAppliance */
  VirtualAppliance = "VirtualAppliance",
  /** VirtualNetworkGateway */
  VirtualNetworkGateway = "VirtualNetworkGateway",
  /** VnetLocal */
  VnetLocal = "VnetLocal",
  /** HyperNetGateway */
  HyperNetGateway = "HyperNetGateway",
  /** None */
  None = "None"
}

/**
 * Defines values for NextHopType. \
 * {@link KnownNextHopType} can be used interchangeably with NextHopType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Internet** \
 * **VirtualAppliance** \
 * **VirtualNetworkGateway** \
 * **VnetLocal** \
 * **HyperNetGateway** \
 * **None**
 */
export type NextHopType = string;

/** Known values of {@link PcProtocol} that the service accepts. */
export enum KnownPcProtocol {
  /** TCP */
  TCP = "TCP",
  /** UDP */
  UDP = "UDP",
  /** Any */
  Any = "Any"
}

/**
 * Defines values for PcProtocol. \
 * {@link KnownPcProtocol} can be used interchangeably with PcProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TCP** \
 * **UDP** \
 * **Any**
 */
export type PcProtocol = string;

/** Known values of {@link PcStatus} that the service accepts. */
export enum KnownPcStatus {
  /** NotStarted */
  NotStarted = "NotStarted",
  /** Running */
  Running = "Running",
  /** Stopped */
  Stopped = "Stopped",
  /** Error */
  Error = "Error",
  /** Unknown */
  Unknown = "Unknown"
}

/**
 * Defines values for PcStatus. \
 * {@link KnownPcStatus} can be used interchangeably with PcStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **NotStarted** \
 * **Running** \
 * **Stopped** \
 * **Error** \
 * **Unknown**
 */
export type PcStatus = string;

/** Known values of {@link PcError} that the service accepts. */
export enum KnownPcError {
  /** InternalError */
  InternalError = "InternalError",
  /** AgentStopped */
  AgentStopped = "AgentStopped",
  /** CaptureFailed */
  CaptureFailed = "CaptureFailed",
  /** LocalFileFailed */
  LocalFileFailed = "LocalFileFailed",
  /** StorageFailed */
  StorageFailed = "StorageFailed"
}

/**
 * Defines values for PcError. \
 * {@link KnownPcError} can be used interchangeably with PcError,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **InternalError** \
 * **AgentStopped** \
 * **CaptureFailed** \
 * **LocalFileFailed** \
 * **StorageFailed**
 */
export type PcError = string;

/** Known values of {@link Protocol} that the service accepts. */
export enum KnownProtocol {
  /** Tcp */
  Tcp = "Tcp",
  /** Http */
  Http = "Http",
  /** Https */
  Https = "Https",
  /** Icmp */
  Icmp = "Icmp"
}

/**
 * Defines values for Protocol. \
 * {@link KnownProtocol} can be used interchangeably with Protocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Tcp** \
 * **Http** \
 * **Https** \
 * **Icmp**
 */
export type Protocol = string;

/** Known values of {@link HttpMethod} that the service accepts. */
export enum KnownHttpMethod {
  /** Get */
  Get = "Get"
}

/**
 * Defines values for HttpMethod. \
 * {@link KnownHttpMethod} can be used interchangeably with HttpMethod,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Get**
 */
export type HttpMethod = string;

/** Known values of {@link Origin} that the service accepts. */
export enum KnownOrigin {
  /** Local */
  Local = "Local",
  /** Inbound */
  Inbound = "Inbound",
  /** Outbound */
  Outbound = "Outbound"
}

/**
 * Defines values for Origin. \
 * {@link KnownOrigin} can be used interchangeably with Origin,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Local** \
 * **Inbound** \
 * **Outbound**
 */
export type Origin = string;

/** Known values of {@link Severity} that the service accepts. */
export enum KnownSeverity {
  /** Error */
  Error = "Error",
  /** Warning */
  Warning = "Warning"
}

/**
 * Defines values for Severity. \
 * {@link KnownSeverity} can be used interchangeably with Severity,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Error** \
 * **Warning**
 */
export type Severity = string;

/** Known values of {@link IssueType} that the service accepts. */
export enum KnownIssueType {
  /** Unknown */
  Unknown = "Unknown",
  /** AgentStopped */
  AgentStopped = "AgentStopped",
  /** GuestFirewall */
  GuestFirewall = "GuestFirewall",
  /** DnsResolution */
  DnsResolution = "DnsResolution",
  /** SocketBind */
  SocketBind = "SocketBind",
  /** NetworkSecurityRule */
  NetworkSecurityRule = "NetworkSecurityRule",
  /** UserDefinedRoute */
  UserDefinedRoute = "UserDefinedRoute",
  /** PortThrottled */
  PortThrottled = "PortThrottled",
  /** Platform */
  Platform = "Platform"
}

/**
 * Defines values for IssueType. \
 * {@link KnownIssueType} can be used interchangeably with IssueType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **AgentStopped** \
 * **GuestFirewall** \
 * **DnsResolution** \
 * **SocketBind** \
 * **NetworkSecurityRule** \
 * **UserDefinedRoute** \
 * **PortThrottled** \
 * **Platform**
 */
export type IssueType = string;

/** Known values of {@link ConnectionStatus} that the service accepts. */
export enum KnownConnectionStatus {
  /** Unknown */
  Unknown = "Unknown",
  /** Connected */
  Connected = "Connected",
  /** Disconnected */
  Disconnected = "Disconnected",
  /** Degraded */
  Degraded = "Degraded"
}

/**
 * Defines values for ConnectionStatus. \
 * {@link KnownConnectionStatus} can be used interchangeably with ConnectionStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **Connected** \
 * **Disconnected** \
 * **Degraded**
 */
export type ConnectionStatus = string;

/** Known values of {@link VerbosityLevel} that the service accepts. */
export enum KnownVerbosityLevel {
  /** Normal */
  Normal = "Normal",
  /** Minimum */
  Minimum = "Minimum",
  /** Full */
  Full = "Full"
}

/**
 * Defines values for VerbosityLevel. \
 * {@link KnownVerbosityLevel} can be used interchangeably with VerbosityLevel,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Normal** \
 * **Minimum** \
 * **Full**
 */
export type VerbosityLevel = string;

/** Known values of {@link EndpointType} that the service accepts. */
export enum KnownEndpointType {
  /** AzureVM */
  AzureVM = "AzureVM",
  /** AzureVNet */
  AzureVNet = "AzureVNet",
  /** AzureSubnet */
  AzureSubnet = "AzureSubnet",
  /** ExternalAddress */
  ExternalAddress = "ExternalAddress",
  /** MMAWorkspaceMachine */
  MMAWorkspaceMachine = "MMAWorkspaceMachine",
  /** MMAWorkspaceNetwork */
  MMAWorkspaceNetwork = "MMAWorkspaceNetwork",
  /** AzureArcVM */
  AzureArcVM = "AzureArcVM",
  /** AzureVmss */
  AzureVmss = "AzureVMSS"
}

/**
 * Defines values for EndpointType. \
 * {@link KnownEndpointType} can be used interchangeably with EndpointType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **AzureVM** \
 * **AzureVNet** \
 * **AzureSubnet** \
 * **ExternalAddress** \
 * **MMAWorkspaceMachine** \
 * **MMAWorkspaceNetwork** \
 * **AzureArcVM** \
 * **AzureVMSS**
 */
export type EndpointType = string;

/** Known values of {@link ConnectionMonitorEndpointFilterType} that the service accepts. */
export enum KnownConnectionMonitorEndpointFilterType {
  /** Include */
  Include = "Include"
}

/**
 * Defines values for ConnectionMonitorEndpointFilterType. \
 * {@link KnownConnectionMonitorEndpointFilterType} can be used interchangeably with ConnectionMonitorEndpointFilterType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Include**
 */
export type ConnectionMonitorEndpointFilterType = string;

/** Known values of {@link ConnectionMonitorEndpointFilterItemType} that the service accepts. */
export enum KnownConnectionMonitorEndpointFilterItemType {
  /** AgentAddress */
  AgentAddress = "AgentAddress"
}

/**
 * Defines values for ConnectionMonitorEndpointFilterItemType. \
 * {@link KnownConnectionMonitorEndpointFilterItemType} can be used interchangeably with ConnectionMonitorEndpointFilterItemType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **AgentAddress**
 */
export type ConnectionMonitorEndpointFilterItemType = string;

/** Known values of {@link CoverageLevel} that the service accepts. */
export enum KnownCoverageLevel {
  /** Default */
  Default = "Default",
  /** Low */
  Low = "Low",
  /** BelowAverage */
  BelowAverage = "BelowAverage",
  /** Average */
  Average = "Average",
  /** AboveAverage */
  AboveAverage = "AboveAverage",
  /** Full */
  Full = "Full"
}

/**
 * Defines values for CoverageLevel. \
 * {@link KnownCoverageLevel} can be used interchangeably with CoverageLevel,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Default** \
 * **Low** \
 * **BelowAverage** \
 * **Average** \
 * **AboveAverage** \
 * **Full**
 */
export type CoverageLevel = string;

/** Known values of {@link ConnectionMonitorTestConfigurationProtocol} that the service accepts. */
export enum KnownConnectionMonitorTestConfigurationProtocol {
  /** Tcp */
  Tcp = "Tcp",
  /** Http */
  Http = "Http",
  /** Icmp */
  Icmp = "Icmp"
}

/**
 * Defines values for ConnectionMonitorTestConfigurationProtocol. \
 * {@link KnownConnectionMonitorTestConfigurationProtocol} can be used interchangeably with ConnectionMonitorTestConfigurationProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Tcp** \
 * **Http** \
 * **Icmp**
 */
export type ConnectionMonitorTestConfigurationProtocol = string;

/** Known values of {@link PreferredIPVersion} that the service accepts. */
export enum KnownPreferredIPVersion {
  /** IPv4 */
  IPv4 = "IPv4",
  /** IPv6 */
  IPv6 = "IPv6"
}

/**
 * Defines values for PreferredIPVersion. \
 * {@link KnownPreferredIPVersion} can be used interchangeably with PreferredIPVersion,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **IPv4** \
 * **IPv6**
 */
export type PreferredIPVersion = string;

/** Known values of {@link HttpConfigurationMethod} that the service accepts. */
export enum KnownHttpConfigurationMethod {
  /** Get */
  Get = "Get",
  /** Post */
  Post = "Post"
}

/**
 * Defines values for HttpConfigurationMethod. \
 * {@link KnownHttpConfigurationMethod} can be used interchangeably with HttpConfigurationMethod,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Get** \
 * **Post**
 */
export type HttpConfigurationMethod = string;

/** Known values of {@link DestinationPortBehavior} that the service accepts. */
export enum KnownDestinationPortBehavior {
  /** None */
  None = "None",
  /** ListenIfAvailable */
  ListenIfAvailable = "ListenIfAvailable"
}

/**
 * Defines values for DestinationPortBehavior. \
 * {@link KnownDestinationPortBehavior} can be used interchangeably with DestinationPortBehavior,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **ListenIfAvailable**
 */
export type DestinationPortBehavior = string;

/** Known values of {@link OutputType} that the service accepts. */
export enum KnownOutputType {
  /** Workspace */
  Workspace = "Workspace"
}

/**
 * Defines values for OutputType. \
 * {@link KnownOutputType} can be used interchangeably with OutputType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Workspace**
 */
export type OutputType = string;

/** Known values of {@link ConnectionMonitorType} that the service accepts. */
export enum KnownConnectionMonitorType {
  /** MultiEndpoint */
  MultiEndpoint = "MultiEndpoint",
  /** SingleSourceDestination */
  SingleSourceDestination = "SingleSourceDestination"
}

/**
 * Defines values for ConnectionMonitorType. \
 * {@link KnownConnectionMonitorType} can be used interchangeably with ConnectionMonitorType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **MultiEndpoint** \
 * **SingleSourceDestination**
 */
export type ConnectionMonitorType = string;

/** Known values of {@link ConnectionMonitorSourceStatus} that the service accepts. */
export enum KnownConnectionMonitorSourceStatus {
  /** Unknown */
  Unknown = "Unknown",
  /** Active */
  Active = "Active",
  /** Inactive */
  Inactive = "Inactive"
}

/**
 * Defines values for ConnectionMonitorSourceStatus. \
 * {@link KnownConnectionMonitorSourceStatus} can be used interchangeably with ConnectionMonitorSourceStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **Active** \
 * **Inactive**
 */
export type ConnectionMonitorSourceStatus = string;

/** Known values of {@link ConnectionState} that the service accepts. */
export enum KnownConnectionState {
  /** Reachable */
  Reachable = "Reachable",
  /** Unreachable */
  Unreachable = "Unreachable",
  /** Unknown */
  Unknown = "Unknown"
}

/**
 * Defines values for ConnectionState. \
 * {@link KnownConnectionState} can be used interchangeably with ConnectionState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Reachable** \
 * **Unreachable** \
 * **Unknown**
 */
export type ConnectionState = string;

/** Known values of {@link EvaluationState} that the service accepts. */
export enum KnownEvaluationState {
  /** NotStarted */
  NotStarted = "NotStarted",
  /** InProgress */
  InProgress = "InProgress",
  /** Completed */
  Completed = "Completed"
}

/**
 * Defines values for EvaluationState. \
 * {@link KnownEvaluationState} can be used interchangeably with EvaluationState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **NotStarted** \
 * **InProgress** \
 * **Completed**
 */
export type EvaluationState = string;

/** Known values of {@link PublicIPPrefixSkuName} that the service accepts. */
export enum KnownPublicIPPrefixSkuName {
  /** Standard */
  Standard = "Standard"
}

/**
 * Defines values for PublicIPPrefixSkuName. \
 * {@link KnownPublicIPPrefixSkuName} can be used interchangeably with PublicIPPrefixSkuName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Standard**
 */
export type PublicIPPrefixSkuName = string;

/** Known values of {@link PublicIPPrefixSkuTier} that the service accepts. */
export enum KnownPublicIPPrefixSkuTier {
  /** Regional */
  Regional = "Regional",
  /** Global */
  Global = "Global"
}

/**
 * Defines values for PublicIPPrefixSkuTier. \
 * {@link KnownPublicIPPrefixSkuTier} can be used interchangeably with PublicIPPrefixSkuTier,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Regional** \
 * **Global**
 */
export type PublicIPPrefixSkuTier = string;

/** Known values of {@link RouteFilterRuleType} that the service accepts. */
export enum KnownRouteFilterRuleType {
  /** Community */
  Community = "Community"
}

/**
 * Defines values for RouteFilterRuleType. \
 * {@link KnownRouteFilterRuleType} can be used interchangeably with RouteFilterRuleType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Community**
 */
export type RouteFilterRuleType = string;

/** Known values of {@link SecurityProviderName} that the service accepts. */
export enum KnownSecurityProviderName {
  /** ZScaler */
  ZScaler = "ZScaler",
  /** IBoss */
  IBoss = "IBoss",
  /** Checkpoint */
  Checkpoint = "Checkpoint"
}

/**
 * Defines values for SecurityProviderName. \
 * {@link KnownSecurityProviderName} can be used interchangeably with SecurityProviderName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **ZScaler** \
 * **IBoss** \
 * **Checkpoint**
 */
export type SecurityProviderName = string;

/** Known values of {@link SecurityPartnerProviderConnectionStatus} that the service accepts. */
export enum KnownSecurityPartnerProviderConnectionStatus {
  /** Unknown */
  Unknown = "Unknown",
  /** PartiallyConnected */
  PartiallyConnected = "PartiallyConnected",
  /** Connected */
  Connected = "Connected",
  /** NotConnected */
  NotConnected = "NotConnected"
}

/**
 * Defines values for SecurityPartnerProviderConnectionStatus. \
 * {@link KnownSecurityPartnerProviderConnectionStatus} can be used interchangeably with SecurityPartnerProviderConnectionStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **PartiallyConnected** \
 * **Connected** \
 * **NotConnected**
 */
export type SecurityPartnerProviderConnectionStatus = string;

/** Known values of {@link UsageUnit} that the service accepts. */
export enum KnownUsageUnit {
  /** Count */
  Count = "Count"
}

/**
 * Defines values for UsageUnit. \
 * {@link KnownUsageUnit} can be used interchangeably with UsageUnit,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Count**
 */
export type UsageUnit = string;

/** Known values of {@link VirtualNetworkEncryptionEnforcement} that the service accepts. */
export enum KnownVirtualNetworkEncryptionEnforcement {
  /** DropUnencrypted */
  DropUnencrypted = "DropUnencrypted",
  /** AllowUnencrypted */
  AllowUnencrypted = "AllowUnencrypted"
}

/**
 * Defines values for VirtualNetworkEncryptionEnforcement. \
 * {@link KnownVirtualNetworkEncryptionEnforcement} can be used interchangeably with VirtualNetworkEncryptionEnforcement,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **DropUnencrypted** \
 * **AllowUnencrypted**
 */
export type VirtualNetworkEncryptionEnforcement = string;

/** Known values of {@link VirtualNetworkPeeringState} that the service accepts. */
export enum KnownVirtualNetworkPeeringState {
  /** Initiated */
  Initiated = "Initiated",
  /** Connected */
  Connected = "Connected",
  /** Disconnected */
  Disconnected = "Disconnected"
}

/**
 * Defines values for VirtualNetworkPeeringState. \
 * {@link KnownVirtualNetworkPeeringState} can be used interchangeably with VirtualNetworkPeeringState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Initiated** \
 * **Connected** \
 * **Disconnected**
 */
export type VirtualNetworkPeeringState = string;

/** Known values of {@link VirtualNetworkPeeringLevel} that the service accepts. */
export enum KnownVirtualNetworkPeeringLevel {
  /** FullyInSync */
  FullyInSync = "FullyInSync",
  /** RemoteNotInSync */
  RemoteNotInSync = "RemoteNotInSync",
  /** LocalNotInSync */
  LocalNotInSync = "LocalNotInSync",
  /** LocalAndRemoteNotInSync */
  LocalAndRemoteNotInSync = "LocalAndRemoteNotInSync"
}

/**
 * Defines values for VirtualNetworkPeeringLevel. \
 * {@link KnownVirtualNetworkPeeringLevel} can be used interchangeably with VirtualNetworkPeeringLevel,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **FullyInSync** \
 * **RemoteNotInSync** \
 * **LocalNotInSync** \
 * **LocalAndRemoteNotInSync**
 */
export type VirtualNetworkPeeringLevel = string;

/** Known values of {@link SyncRemoteAddressSpace} that the service accepts. */
export enum KnownSyncRemoteAddressSpace {
  /** True */
  True = "true"
}

/**
 * Defines values for SyncRemoteAddressSpace. \
 * {@link KnownSyncRemoteAddressSpace} can be used interchangeably with SyncRemoteAddressSpace,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **true**
 */
export type SyncRemoteAddressSpace = string;

/** Known values of {@link VirtualNetworkGatewayType} that the service accepts. */
export enum KnownVirtualNetworkGatewayType {
  /** Vpn */
  Vpn = "Vpn",
  /** ExpressRoute */
  ExpressRoute = "ExpressRoute",
  /** LocalGateway */
  LocalGateway = "LocalGateway"
}

/**
 * Defines values for VirtualNetworkGatewayType. \
 * {@link KnownVirtualNetworkGatewayType} can be used interchangeably with VirtualNetworkGatewayType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Vpn** \
 * **ExpressRoute** \
 * **LocalGateway**
 */
export type VirtualNetworkGatewayType = string;

/** Known values of {@link VpnType} that the service accepts. */
export enum KnownVpnType {
  /** PolicyBased */
  PolicyBased = "PolicyBased",
  /** RouteBased */
  RouteBased = "RouteBased"
}

/**
 * Defines values for VpnType. \
 * {@link KnownVpnType} can be used interchangeably with VpnType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **PolicyBased** \
 * **RouteBased**
 */
export type VpnType = string;

/** Known values of {@link VpnGatewayGeneration} that the service accepts. */
export enum KnownVpnGatewayGeneration {
  /** None */
  None = "None",
  /** Generation1 */
  Generation1 = "Generation1",
  /** Generation2 */
  Generation2 = "Generation2"
}

/**
 * Defines values for VpnGatewayGeneration. \
 * {@link KnownVpnGatewayGeneration} can be used interchangeably with VpnGatewayGeneration,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **Generation1** \
 * **Generation2**
 */
export type VpnGatewayGeneration = string;

/** Known values of {@link VirtualNetworkGatewaySkuName} that the service accepts. */
export enum KnownVirtualNetworkGatewaySkuName {
  /** Basic */
  Basic = "Basic",
  /** HighPerformance */
  HighPerformance = "HighPerformance",
  /** Standard */
  Standard = "Standard",
  /** UltraPerformance */
  UltraPerformance = "UltraPerformance",
  /** VpnGw1 */
  VpnGw1 = "VpnGw1",
  /** VpnGw2 */
  VpnGw2 = "VpnGw2",
  /** VpnGw3 */
  VpnGw3 = "VpnGw3",
  /** VpnGw4 */
  VpnGw4 = "VpnGw4",
  /** VpnGw5 */
  VpnGw5 = "VpnGw5",
  /** VpnGw1AZ */
  VpnGw1AZ = "VpnGw1AZ",
  /** VpnGw2AZ */
  VpnGw2AZ = "VpnGw2AZ",
  /** VpnGw3AZ */
  VpnGw3AZ = "VpnGw3AZ",
  /** VpnGw4AZ */
  VpnGw4AZ = "VpnGw4AZ",
  /** VpnGw5AZ */
  VpnGw5AZ = "VpnGw5AZ",
  /** ErGw1AZ */
  ErGw1AZ = "ErGw1AZ",
  /** ErGw2AZ */
  ErGw2AZ = "ErGw2AZ",
  /** ErGw3AZ */
  ErGw3AZ = "ErGw3AZ"
}

/**
 * Defines values for VirtualNetworkGatewaySkuName. \
 * {@link KnownVirtualNetworkGatewaySkuName} can be used interchangeably with VirtualNetworkGatewaySkuName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Basic** \
 * **HighPerformance** \
 * **Standard** \
 * **UltraPerformance** \
 * **VpnGw1** \
 * **VpnGw2** \
 * **VpnGw3** \
 * **VpnGw4** \
 * **VpnGw5** \
 * **VpnGw1AZ** \
 * **VpnGw2AZ** \
 * **VpnGw3AZ** \
 * **VpnGw4AZ** \
 * **VpnGw5AZ** \
 * **ErGw1AZ** \
 * **ErGw2AZ** \
 * **ErGw3AZ**
 */
export type VirtualNetworkGatewaySkuName = string;

/** Known values of {@link VirtualNetworkGatewaySkuTier} that the service accepts. */
export enum KnownVirtualNetworkGatewaySkuTier {
  /** Basic */
  Basic = "Basic",
  /** HighPerformance */
  HighPerformance = "HighPerformance",
  /** Standard */
  Standard = "Standard",
  /** UltraPerformance */
  UltraPerformance = "UltraPerformance",
  /** VpnGw1 */
  VpnGw1 = "VpnGw1",
  /** VpnGw2 */
  VpnGw2 = "VpnGw2",
  /** VpnGw3 */
  VpnGw3 = "VpnGw3",
  /** VpnGw4 */
  VpnGw4 = "VpnGw4",
  /** VpnGw5 */
  VpnGw5 = "VpnGw5",
  /** VpnGw1AZ */
  VpnGw1AZ = "VpnGw1AZ",
  /** VpnGw2AZ */
  VpnGw2AZ = "VpnGw2AZ",
  /** VpnGw3AZ */
  VpnGw3AZ = "VpnGw3AZ",
  /** VpnGw4AZ */
  VpnGw4AZ = "VpnGw4AZ",
  /** VpnGw5AZ */
  VpnGw5AZ = "VpnGw5AZ",
  /** ErGw1AZ */
  ErGw1AZ = "ErGw1AZ",
  /** ErGw2AZ */
  ErGw2AZ = "ErGw2AZ",
  /** ErGw3AZ */
  ErGw3AZ = "ErGw3AZ"
}

/**
 * Defines values for VirtualNetworkGatewaySkuTier. \
 * {@link KnownVirtualNetworkGatewaySkuTier} can be used interchangeably with VirtualNetworkGatewaySkuTier,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Basic** \
 * **HighPerformance** \
 * **Standard** \
 * **UltraPerformance** \
 * **VpnGw1** \
 * **VpnGw2** \
 * **VpnGw3** \
 * **VpnGw4** \
 * **VpnGw5** \
 * **VpnGw1AZ** \
 * **VpnGw2AZ** \
 * **VpnGw3AZ** \
 * **VpnGw4AZ** \
 * **VpnGw5AZ** \
 * **ErGw1AZ** \
 * **ErGw2AZ** \
 * **ErGw3AZ**
 */
export type VirtualNetworkGatewaySkuTier = string;

/** Known values of {@link VpnClientProtocol} that the service accepts. */
export enum KnownVpnClientProtocol {
  /** IkeV2 */
  IkeV2 = "IkeV2",
  /** Sstp */
  Sstp = "SSTP",
  /** OpenVPN */
  OpenVPN = "OpenVPN"
}

/**
 * Defines values for VpnClientProtocol. \
 * {@link KnownVpnClientProtocol} can be used interchangeably with VpnClientProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **IkeV2** \
 * **SSTP** \
 * **OpenVPN**
 */
export type VpnClientProtocol = string;

/** Known values of {@link VpnAuthenticationType} that the service accepts. */
export enum KnownVpnAuthenticationType {
  /** Certificate */
  Certificate = "Certificate",
  /** Radius */
  Radius = "Radius",
  /** AAD */
  AAD = "AAD"
}

/**
 * Defines values for VpnAuthenticationType. \
 * {@link KnownVpnAuthenticationType} can be used interchangeably with VpnAuthenticationType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Certificate** \
 * **Radius** \
 * **AAD**
 */
export type VpnAuthenticationType = string;

/** Known values of {@link IpsecEncryption} that the service accepts. */
export enum KnownIpsecEncryption {
  /** None */
  None = "None",
  /** DES */
  DES = "DES",
  /** DES3 */
  DES3 = "DES3",
  /** AES128 */
  AES128 = "AES128",
  /** AES192 */
  AES192 = "AES192",
  /** AES256 */
  AES256 = "AES256",
  /** Gcmaes128 */
  Gcmaes128 = "GCMAES128",
  /** Gcmaes192 */
  Gcmaes192 = "GCMAES192",
  /** Gcmaes256 */
  Gcmaes256 = "GCMAES256"
}

/**
 * Defines values for IpsecEncryption. \
 * {@link KnownIpsecEncryption} can be used interchangeably with IpsecEncryption,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **DES** \
 * **DES3** \
 * **AES128** \
 * **AES192** \
 * **AES256** \
 * **GCMAES128** \
 * **GCMAES192** \
 * **GCMAES256**
 */
export type IpsecEncryption = string;

/** Known values of {@link IpsecIntegrity} that the service accepts. */
export enum KnownIpsecIntegrity {
  /** MD5 */
  MD5 = "MD5",
  /** SHA1 */
  SHA1 = "SHA1",
  /** SHA256 */
  SHA256 = "SHA256",
  /** Gcmaes128 */
  Gcmaes128 = "GCMAES128",
  /** Gcmaes192 */
  Gcmaes192 = "GCMAES192",
  /** Gcmaes256 */
  Gcmaes256 = "GCMAES256"
}

/**
 * Defines values for IpsecIntegrity. \
 * {@link KnownIpsecIntegrity} can be used interchangeably with IpsecIntegrity,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **MD5** \
 * **SHA1** \
 * **SHA256** \
 * **GCMAES128** \
 * **GCMAES192** \
 * **GCMAES256**
 */
export type IpsecIntegrity = string;

/** Known values of {@link IkeEncryption} that the service accepts. */
export enum KnownIkeEncryption {
  /** DES */
  DES = "DES",
  /** DES3 */
  DES3 = "DES3",
  /** AES128 */
  AES128 = "AES128",
  /** AES192 */
  AES192 = "AES192",
  /** AES256 */
  AES256 = "AES256",
  /** Gcmaes256 */
  Gcmaes256 = "GCMAES256",
  /** Gcmaes128 */
  Gcmaes128 = "GCMAES128"
}

/**
 * Defines values for IkeEncryption. \
 * {@link KnownIkeEncryption} can be used interchangeably with IkeEncryption,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **DES** \
 * **DES3** \
 * **AES128** \
 * **AES192** \
 * **AES256** \
 * **GCMAES256** \
 * **GCMAES128**
 */
export type IkeEncryption = string;

/** Known values of {@link IkeIntegrity} that the service accepts. */
export enum KnownIkeIntegrity {
  /** MD5 */
  MD5 = "MD5",
  /** SHA1 */
  SHA1 = "SHA1",
  /** SHA256 */
  SHA256 = "SHA256",
  /** SHA384 */
  SHA384 = "SHA384",
  /** Gcmaes256 */
  Gcmaes256 = "GCMAES256",
  /** Gcmaes128 */
  Gcmaes128 = "GCMAES128"
}

/**
 * Defines values for IkeIntegrity. \
 * {@link KnownIkeIntegrity} can be used interchangeably with IkeIntegrity,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **MD5** \
 * **SHA1** \
 * **SHA256** \
 * **SHA384** \
 * **GCMAES256** \
 * **GCMAES128**
 */
export type IkeIntegrity = string;

/** Known values of {@link DhGroup} that the service accepts. */
export enum KnownDhGroup {
  /** None */
  None = "None",
  /** DHGroup1 */
  DHGroup1 = "DHGroup1",
  /** DHGroup2 */
  DHGroup2 = "DHGroup2",
  /** DHGroup14 */
  DHGroup14 = "DHGroup14",
  /** DHGroup2048 */
  DHGroup2048 = "DHGroup2048",
  /** ECP256 */
  ECP256 = "ECP256",
  /** ECP384 */
  ECP384 = "ECP384",
  /** DHGroup24 */
  DHGroup24 = "DHGroup24"
}

/**
 * Defines values for DhGroup. \
 * {@link KnownDhGroup} can be used interchangeably with DhGroup,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **DHGroup1** \
 * **DHGroup2** \
 * **DHGroup14** \
 * **DHGroup2048** \
 * **ECP256** \
 * **ECP384** \
 * **DHGroup24**
 */
export type DhGroup = string;

/** Known values of {@link PfsGroup} that the service accepts. */
export enum KnownPfsGroup {
  /** None */
  None = "None",
  /** PFS1 */
  PFS1 = "PFS1",
  /** PFS2 */
  PFS2 = "PFS2",
  /** PFS2048 */
  PFS2048 = "PFS2048",
  /** ECP256 */
  ECP256 = "ECP256",
  /** ECP384 */
  ECP384 = "ECP384",
  /** PFS24 */
  PFS24 = "PFS24",
  /** PFS14 */
  PFS14 = "PFS14",
  /** Pfsmm */
  Pfsmm = "PFSMM"
}

/**
 * Defines values for PfsGroup. \
 * {@link KnownPfsGroup} can be used interchangeably with PfsGroup,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **PFS1** \
 * **PFS2** \
 * **PFS2048** \
 * **ECP256** \
 * **ECP384** \
 * **PFS24** \
 * **PFS14** \
 * **PFSMM**
 */
export type PfsGroup = string;

/** Known values of {@link VpnNatRuleType} that the service accepts. */
export enum KnownVpnNatRuleType {
  /** Static */
  Static = "Static",
  /** Dynamic */
  Dynamic = "Dynamic"
}

/**
 * Defines values for VpnNatRuleType. \
 * {@link KnownVpnNatRuleType} can be used interchangeably with VpnNatRuleType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Static** \
 * **Dynamic**
 */
export type VpnNatRuleType = string;

/** Known values of {@link VpnNatRuleMode} that the service accepts. */
export enum KnownVpnNatRuleMode {
  /** EgressSnat */
  EgressSnat = "EgressSnat",
  /** IngressSnat */
  IngressSnat = "IngressSnat"
}

/**
 * Defines values for VpnNatRuleMode. \
 * {@link KnownVpnNatRuleMode} can be used interchangeably with VpnNatRuleMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **EgressSnat** \
 * **IngressSnat**
 */
export type VpnNatRuleMode = string;

/** Known values of {@link VirtualNetworkGatewayConnectionType} that the service accepts. */
export enum KnownVirtualNetworkGatewayConnectionType {
  /** IPsec */
  IPsec = "IPsec",
  /** Vnet2Vnet */
  Vnet2Vnet = "Vnet2Vnet",
  /** ExpressRoute */
  ExpressRoute = "ExpressRoute",
  /** VPNClient */
  VPNClient = "VPNClient"
}

/**
 * Defines values for VirtualNetworkGatewayConnectionType. \
 * {@link KnownVirtualNetworkGatewayConnectionType} can be used interchangeably with VirtualNetworkGatewayConnectionType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **IPsec** \
 * **Vnet2Vnet** \
 * **ExpressRoute** \
 * **VPNClient**
 */
export type VirtualNetworkGatewayConnectionType = string;

/** Known values of {@link VirtualNetworkGatewayConnectionProtocol} that the service accepts. */
export enum KnownVirtualNetworkGatewayConnectionProtocol {
  /** IKEv2 */
  IKEv2 = "IKEv2",
  /** IKEv1 */
  IKEv1 = "IKEv1"
}

/**
 * Defines values for VirtualNetworkGatewayConnectionProtocol. \
 * {@link KnownVirtualNetworkGatewayConnectionProtocol} can be used interchangeably with VirtualNetworkGatewayConnectionProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **IKEv2** \
 * **IKEv1**
 */
export type VirtualNetworkGatewayConnectionProtocol = string;

/** Known values of {@link VirtualNetworkGatewayConnectionMode} that the service accepts. */
export enum KnownVirtualNetworkGatewayConnectionMode {
  /** Default */
  Default = "Default",
  /** ResponderOnly */
  ResponderOnly = "ResponderOnly",
  /** InitiatorOnly */
  InitiatorOnly = "InitiatorOnly"
}

/**
 * Defines values for VirtualNetworkGatewayConnectionMode. \
 * {@link KnownVirtualNetworkGatewayConnectionMode} can be used interchangeably with VirtualNetworkGatewayConnectionMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Default** \
 * **ResponderOnly** \
 * **InitiatorOnly**
 */
export type VirtualNetworkGatewayConnectionMode = string;

/** Known values of {@link VirtualNetworkGatewayConnectionStatus} that the service accepts. */
export enum KnownVirtualNetworkGatewayConnectionStatus {
  /** Unknown */
  Unknown = "Unknown",
  /** Connecting */
  Connecting = "Connecting",
  /** Connected */
  Connected = "Connected",
  /** NotConnected */
  NotConnected = "NotConnected"
}

/**
 * Defines values for VirtualNetworkGatewayConnectionStatus. \
 * {@link KnownVirtualNetworkGatewayConnectionStatus} can be used interchangeably with VirtualNetworkGatewayConnectionStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **Connecting** \
 * **Connected** \
 * **NotConnected**
 */
export type VirtualNetworkGatewayConnectionStatus = string;

/** Known values of {@link ProcessorArchitecture} that the service accepts. */
export enum KnownProcessorArchitecture {
  /** Amd64 */
  Amd64 = "Amd64",
  /** X86 */
  X86 = "X86"
}

/**
 * Defines values for ProcessorArchitecture. \
 * {@link KnownProcessorArchitecture} can be used interchangeably with ProcessorArchitecture,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Amd64** \
 * **X86**
 */
export type ProcessorArchitecture = string;

/** Known values of {@link AuthenticationMethod} that the service accepts. */
export enum KnownAuthenticationMethod {
  /** Eaptls */
  Eaptls = "EAPTLS",
  /** EapmschaPv2 */
  EapmschaPv2 = "EAPMSCHAPv2"
}

/**
 * Defines values for AuthenticationMethod. \
 * {@link KnownAuthenticationMethod} can be used interchangeably with AuthenticationMethod,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **EAPTLS** \
 * **EAPMSCHAPv2**
 */
export type AuthenticationMethod = string;

/** Known values of {@link BgpPeerState} that the service accepts. */
export enum KnownBgpPeerState {
  /** Unknown */
  Unknown = "Unknown",
  /** Stopped */
  Stopped = "Stopped",
  /** Idle */
  Idle = "Idle",
  /** Connecting */
  Connecting = "Connecting",
  /** Connected */
  Connected = "Connected"
}

/**
 * Defines values for BgpPeerState. \
 * {@link KnownBgpPeerState} can be used interchangeably with BgpPeerState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **Stopped** \
 * **Idle** \
 * **Connecting** \
 * **Connected**
 */
export type BgpPeerState = string;

/** Known values of {@link OfficeTrafficCategory} that the service accepts. */
export enum KnownOfficeTrafficCategory {
  /** Optimize */
  Optimize = "Optimize",
  /** OptimizeAndAllow */
  OptimizeAndAllow = "OptimizeAndAllow",
  /** All */
  All = "All",
  /** None */
  None = "None"
}

/**
 * Defines values for OfficeTrafficCategory. \
 * {@link KnownOfficeTrafficCategory} can be used interchangeably with OfficeTrafficCategory,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Optimize** \
 * **OptimizeAndAllow** \
 * **All** \
 * **None**
 */
export type OfficeTrafficCategory = string;

/** Known values of {@link VirtualWanSecurityProviderType} that the service accepts. */
export enum KnownVirtualWanSecurityProviderType {
  /** External */
  External = "External",
  /** Native */
  Native = "Native"
}

/**
 * Defines values for VirtualWanSecurityProviderType. \
 * {@link KnownVirtualWanSecurityProviderType} can be used interchangeably with VirtualWanSecurityProviderType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **External** \
 * **Native**
 */
export type VirtualWanSecurityProviderType = string;

/** Known values of {@link VpnGatewayTunnelingProtocol} that the service accepts. */
export enum KnownVpnGatewayTunnelingProtocol {
  /** IkeV2 */
  IkeV2 = "IkeV2",
  /** OpenVPN */
  OpenVPN = "OpenVPN"
}

/**
 * Defines values for VpnGatewayTunnelingProtocol. \
 * {@link KnownVpnGatewayTunnelingProtocol} can be used interchangeably with VpnGatewayTunnelingProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **IkeV2** \
 * **OpenVPN**
 */
export type VpnGatewayTunnelingProtocol = string;

/** Known values of {@link VpnPolicyMemberAttributeType} that the service accepts. */
export enum KnownVpnPolicyMemberAttributeType {
  /** CertificateGroupId */
  CertificateGroupId = "CertificateGroupId",
  /** AADGroupId */
  AADGroupId = "AADGroupId",
  /** RadiusAzureGroupId */
  RadiusAzureGroupId = "RadiusAzureGroupId"
}

/**
 * Defines values for VpnPolicyMemberAttributeType. \
 * {@link KnownVpnPolicyMemberAttributeType} can be used interchangeably with VpnPolicyMemberAttributeType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **CertificateGroupId** \
 * **AADGroupId** \
 * **RadiusAzureGroupId**
 */
export type VpnPolicyMemberAttributeType = string;

/** Known values of {@link RoutingState} that the service accepts. */
export enum KnownRoutingState {
  /** None */
  None = "None",
  /** Provisioned */
  Provisioned = "Provisioned",
  /** Provisioning */
  Provisioning = "Provisioning",
  /** Failed */
  Failed = "Failed"
}

/**
 * Defines values for RoutingState. \
 * {@link KnownRoutingState} can be used interchangeably with RoutingState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **Provisioned** \
 * **Provisioning** \
 * **Failed**
 */
export type RoutingState = string;

/** Known values of {@link PreferredRoutingGateway} that the service accepts. */
export enum KnownPreferredRoutingGateway {
  /** ExpressRoute */
  ExpressRoute = "ExpressRoute",
  /** VpnGateway */
  VpnGateway = "VpnGateway",
  /** None */
  None = "None"
}

/**
 * Defines values for PreferredRoutingGateway. \
 * {@link KnownPreferredRoutingGateway} can be used interchangeably with PreferredRoutingGateway,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **ExpressRoute** \
 * **VpnGateway** \
 * **None**
 */
export type PreferredRoutingGateway = string;

/** Known values of {@link HubRoutingPreference} that the service accepts. */
export enum KnownHubRoutingPreference {
  /** ExpressRoute */
  ExpressRoute = "ExpressRoute",
  /** VpnGateway */
  VpnGateway = "VpnGateway",
  /** ASPath */
  ASPath = "ASPath"
}

/**
 * Defines values for HubRoutingPreference. \
 * {@link KnownHubRoutingPreference} can be used interchangeably with HubRoutingPreference,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **ExpressRoute** \
 * **VpnGateway** \
 * **ASPath**
 */
export type HubRoutingPreference = string;

/** Known values of {@link VpnConnectionStatus} that the service accepts. */
export enum KnownVpnConnectionStatus {
  /** Unknown */
  Unknown = "Unknown",
  /** Connecting */
  Connecting = "Connecting",
  /** Connected */
  Connected = "Connected",
  /** NotConnected */
  NotConnected = "NotConnected"
}

/**
 * Defines values for VpnConnectionStatus. \
 * {@link KnownVpnConnectionStatus} can be used interchangeably with VpnConnectionStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **Connecting** \
 * **Connected** \
 * **NotConnected**
 */
export type VpnConnectionStatus = string;

/** Known values of {@link VpnLinkConnectionMode} that the service accepts. */
export enum KnownVpnLinkConnectionMode {
  /** Default */
  Default = "Default",
  /** ResponderOnly */
  ResponderOnly = "ResponderOnly",
  /** InitiatorOnly */
  InitiatorOnly = "InitiatorOnly"
}

/**
 * Defines values for VpnLinkConnectionMode. \
 * {@link KnownVpnLinkConnectionMode} can be used interchangeably with VpnLinkConnectionMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Default** \
 * **ResponderOnly** \
 * **InitiatorOnly**
 */
export type VpnLinkConnectionMode = string;

/** Known values of {@link HubBgpConnectionStatus} that the service accepts. */
export enum KnownHubBgpConnectionStatus {
  /** Unknown */
  Unknown = "Unknown",
  /** Connecting */
  Connecting = "Connecting",
  /** Connected */
  Connected = "Connected",
  /** NotConnected */
  NotConnected = "NotConnected"
}

/**
 * Defines values for HubBgpConnectionStatus. \
 * {@link KnownHubBgpConnectionStatus} can be used interchangeably with HubBgpConnectionStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **Connecting** \
 * **Connected** \
 * **NotConnected**
 */
export type HubBgpConnectionStatus = string;

/** Known values of {@link WebApplicationFirewallEnabledState} that the service accepts. */
export enum KnownWebApplicationFirewallEnabledState {
  /** Disabled */
  Disabled = "Disabled",
  /** Enabled */
  Enabled = "Enabled"
}

/**
 * Defines values for WebApplicationFirewallEnabledState. \
 * {@link KnownWebApplicationFirewallEnabledState} can be used interchangeably with WebApplicationFirewallEnabledState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Disabled** \
 * **Enabled**
 */
export type WebApplicationFirewallEnabledState = string;

/** Known values of {@link WebApplicationFirewallMode} that the service accepts. */
export enum KnownWebApplicationFirewallMode {
  /** Prevention */
  Prevention = "Prevention",
  /** Detection */
  Detection = "Detection"
}

/**
 * Defines values for WebApplicationFirewallMode. \
 * {@link KnownWebApplicationFirewallMode} can be used interchangeably with WebApplicationFirewallMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Prevention** \
 * **Detection**
 */
export type WebApplicationFirewallMode = string;

/** Known values of {@link WebApplicationFirewallRuleType} that the service accepts. */
export enum KnownWebApplicationFirewallRuleType {
  /** MatchRule */
  MatchRule = "MatchRule",
  /** Invalid */
  Invalid = "Invalid"
}

/**
 * Defines values for WebApplicationFirewallRuleType. \
 * {@link KnownWebApplicationFirewallRuleType} can be used interchangeably with WebApplicationFirewallRuleType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **MatchRule** \
 * **Invalid**
 */
export type WebApplicationFirewallRuleType = string;

/** Known values of {@link WebApplicationFirewallMatchVariable} that the service accepts. */
export enum KnownWebApplicationFirewallMatchVariable {
  /** RemoteAddr */
  RemoteAddr = "RemoteAddr",
  /** RequestMethod */
  RequestMethod = "RequestMethod",
  /** QueryString */
  QueryString = "QueryString",
  /** PostArgs */
  PostArgs = "PostArgs",
  /** RequestUri */
  RequestUri = "RequestUri",
  /** RequestHeaders */
  RequestHeaders = "RequestHeaders",
  /** RequestBody */
  RequestBody = "RequestBody",
  /** RequestCookies */
  RequestCookies = "RequestCookies"
}

/**
 * Defines values for WebApplicationFirewallMatchVariable. \
 * {@link KnownWebApplicationFirewallMatchVariable} can be used interchangeably with WebApplicationFirewallMatchVariable,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **RemoteAddr** \
 * **RequestMethod** \
 * **QueryString** \
 * **PostArgs** \
 * **RequestUri** \
 * **RequestHeaders** \
 * **RequestBody** \
 * **RequestCookies**
 */
export type WebApplicationFirewallMatchVariable = string;

/** Known values of {@link WebApplicationFirewallOperator} that the service accepts. */
export enum KnownWebApplicationFirewallOperator {
  /** IPMatch */
  IPMatch = "IPMatch",
  /** Equal */
  Equal = "Equal",
  /** Contains */
  Contains = "Contains",
  /** LessThan */
  LessThan = "LessThan",
  /** GreaterThan */
  GreaterThan = "GreaterThan",
  /** LessThanOrEqual */
  LessThanOrEqual = "LessThanOrEqual",
  /** GreaterThanOrEqual */
  GreaterThanOrEqual = "GreaterThanOrEqual",
  /** BeginsWith */
  BeginsWith = "BeginsWith",
  /** EndsWith */
  EndsWith = "EndsWith",
  /** Regex */
  Regex = "Regex",
  /** GeoMatch */
  GeoMatch = "GeoMatch",
  /** Any */
  Any = "Any"
}

/**
 * Defines values for WebApplicationFirewallOperator. \
 * {@link KnownWebApplicationFirewallOperator} can be used interchangeably with WebApplicationFirewallOperator,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **IPMatch** \
 * **Equal** \
 * **Contains** \
 * **LessThan** \
 * **GreaterThan** \
 * **LessThanOrEqual** \
 * **GreaterThanOrEqual** \
 * **BeginsWith** \
 * **EndsWith** \
 * **Regex** \
 * **GeoMatch** \
 * **Any**
 */
export type WebApplicationFirewallOperator = string;

/** Known values of {@link WebApplicationFirewallTransform} that the service accepts. */
export enum KnownWebApplicationFirewallTransform {
  /** Lowercase */
  Lowercase = "Lowercase",
  /** Trim */
  Trim = "Trim",
  /** UrlDecode */
  UrlDecode = "UrlDecode",
  /** UrlEncode */
  UrlEncode = "UrlEncode",
  /** RemoveNulls */
  RemoveNulls = "RemoveNulls",
  /** HtmlEntityDecode */
  HtmlEntityDecode = "HtmlEntityDecode"
}

/**
 * Defines values for WebApplicationFirewallTransform. \
 * {@link KnownWebApplicationFirewallTransform} can be used interchangeably with WebApplicationFirewallTransform,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Lowercase** \
 * **Trim** \
 * **UrlDecode** \
 * **UrlEncode** \
 * **RemoveNulls** \
 * **HtmlEntityDecode**
 */
export type WebApplicationFirewallTransform = string;

/** Known values of {@link WebApplicationFirewallAction} that the service accepts. */
export enum KnownWebApplicationFirewallAction {
  /** Allow */
  Allow = "Allow",
  /** Block */
  Block = "Block",
  /** Log */
  Log = "Log"
}

/**
 * Defines values for WebApplicationFirewallAction. \
 * {@link KnownWebApplicationFirewallAction} can be used interchangeably with WebApplicationFirewallAction,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Allow** \
 * **Block** \
 * **Log**
 */
export type WebApplicationFirewallAction = string;

/** Known values of {@link WebApplicationFirewallPolicyResourceState} that the service accepts. */
export enum KnownWebApplicationFirewallPolicyResourceState {
  /** Creating */
  Creating = "Creating",
  /** Enabling */
  Enabling = "Enabling",
  /** Enabled */
  Enabled = "Enabled",
  /** Disabling */
  Disabling = "Disabling",
  /** Disabled */
  Disabled = "Disabled",
  /** Deleting */
  Deleting = "Deleting"
}

/**
 * Defines values for WebApplicationFirewallPolicyResourceState. \
 * {@link KnownWebApplicationFirewallPolicyResourceState} can be used interchangeably with WebApplicationFirewallPolicyResourceState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Creating** \
 * **Enabling** \
 * **Enabled** \
 * **Disabling** \
 * **Disabled** \
 * **Deleting**
 */
export type WebApplicationFirewallPolicyResourceState = string;

/** Known values of {@link OwaspCrsExclusionEntryMatchVariable} that the service accepts. */
export enum KnownOwaspCrsExclusionEntryMatchVariable {
  /** RequestHeaderNames */
  RequestHeaderNames = "RequestHeaderNames",
  /** RequestCookieNames */
  RequestCookieNames = "RequestCookieNames",
  /** RequestArgNames */
  RequestArgNames = "RequestArgNames",
  /** RequestHeaderKeys */
  RequestHeaderKeys = "RequestHeaderKeys",
  /** RequestHeaderValues */
  RequestHeaderValues = "RequestHeaderValues",
  /** RequestCookieKeys */
  RequestCookieKeys = "RequestCookieKeys",
  /** RequestCookieValues */
  RequestCookieValues = "RequestCookieValues",
  /** RequestArgKeys */
  RequestArgKeys = "RequestArgKeys",
  /** RequestArgValues */
  RequestArgValues = "RequestArgValues"
}

/**
 * Defines values for OwaspCrsExclusionEntryMatchVariable. \
 * {@link KnownOwaspCrsExclusionEntryMatchVariable} can be used interchangeably with OwaspCrsExclusionEntryMatchVariable,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **RequestHeaderNames** \
 * **RequestCookieNames** \
 * **RequestArgNames** \
 * **RequestHeaderKeys** \
 * **RequestHeaderValues** \
 * **RequestCookieKeys** \
 * **RequestCookieValues** \
 * **RequestArgKeys** \
 * **RequestArgValues**
 */
export type OwaspCrsExclusionEntryMatchVariable = string;

/** Known values of {@link OwaspCrsExclusionEntrySelectorMatchOperator} that the service accepts. */
export enum KnownOwaspCrsExclusionEntrySelectorMatchOperator {
  /** Equals */
  Equals = "Equals",
  /** Contains */
  Contains = "Contains",
  /** StartsWith */
  StartsWith = "StartsWith",
  /** EndsWith */
  EndsWith = "EndsWith",
  /** EqualsAny */
  EqualsAny = "EqualsAny"
}

/**
 * Defines values for OwaspCrsExclusionEntrySelectorMatchOperator. \
 * {@link KnownOwaspCrsExclusionEntrySelectorMatchOperator} can be used interchangeably with OwaspCrsExclusionEntrySelectorMatchOperator,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Equals** \
 * **Contains** \
 * **StartsWith** \
 * **EndsWith** \
 * **EqualsAny**
 */
export type OwaspCrsExclusionEntrySelectorMatchOperator = string;

/** Known values of {@link ManagedRuleEnabledState} that the service accepts. */
export enum KnownManagedRuleEnabledState {
  /** Disabled */
  Disabled = "Disabled"
}

/**
 * Defines values for ManagedRuleEnabledState. \
 * {@link KnownManagedRuleEnabledState} can be used interchangeably with ManagedRuleEnabledState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Disabled**
 */
export type ManagedRuleEnabledState = string;

/** Known values of {@link FirewallPolicyNatRuleCollectionActionType} that the service accepts. */
export enum KnownFirewallPolicyNatRuleCollectionActionType {
  /** Dnat */
  Dnat = "DNAT"
}

/**
 * Defines values for FirewallPolicyNatRuleCollectionActionType. \
 * {@link KnownFirewallPolicyNatRuleCollectionActionType} can be used interchangeably with FirewallPolicyNatRuleCollectionActionType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **DNAT**
 */
export type FirewallPolicyNatRuleCollectionActionType = string;

/** Known values of {@link FirewallPolicyRuleType} that the service accepts. */
export enum KnownFirewallPolicyRuleType {
  /** ApplicationRule */
  ApplicationRule = "ApplicationRule",
  /** NetworkRule */
  NetworkRule = "NetworkRule",
  /** NatRule */
  NatRule = "NatRule"
}

/**
 * Defines values for FirewallPolicyRuleType. \
 * {@link KnownFirewallPolicyRuleType} can be used interchangeably with FirewallPolicyRuleType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **ApplicationRule** \
 * **NetworkRule** \
 * **NatRule**
 */
export type FirewallPolicyRuleType = string;

/** Known values of {@link FirewallPolicyFilterRuleCollectionActionType} that the service accepts. */
export enum KnownFirewallPolicyFilterRuleCollectionActionType {
  /** Allow */
  Allow = "Allow",
  /** Deny */
  Deny = "Deny"
}

/**
 * Defines values for FirewallPolicyFilterRuleCollectionActionType. \
 * {@link KnownFirewallPolicyFilterRuleCollectionActionType} can be used interchangeably with FirewallPolicyFilterRuleCollectionActionType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Allow** \
 * **Deny**
 */
export type FirewallPolicyFilterRuleCollectionActionType = string;

/** Known values of {@link FirewallPolicyRuleApplicationProtocolType} that the service accepts. */
export enum KnownFirewallPolicyRuleApplicationProtocolType {
  /** Http */
  Http = "Http",
  /** Https */
  Https = "Https"
}

/**
 * Defines values for FirewallPolicyRuleApplicationProtocolType. \
 * {@link KnownFirewallPolicyRuleApplicationProtocolType} can be used interchangeably with FirewallPolicyRuleApplicationProtocolType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Http** \
 * **Https**
 */
export type FirewallPolicyRuleApplicationProtocolType = string;

/** Known values of {@link FirewallPolicyRuleNetworkProtocol} that the service accepts. */
export enum KnownFirewallPolicyRuleNetworkProtocol {
  /** TCP */
  TCP = "TCP",
  /** UDP */
  UDP = "UDP",
  /** Any */
  Any = "Any",
  /** Icmp */
  Icmp = "ICMP"
}

/**
 * Defines values for FirewallPolicyRuleNetworkProtocol. \
 * {@link KnownFirewallPolicyRuleNetworkProtocol} can be used interchangeably with FirewallPolicyRuleNetworkProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TCP** \
 * **UDP** \
 * **Any** \
 * **ICMP**
 */
export type FirewallPolicyRuleNetworkProtocol = string;

/** Known values of {@link NetworkOperationStatus} that the service accepts. */
export enum KnownNetworkOperationStatus {
  /** InProgress */
  InProgress = "InProgress",
  /** Succeeded */
  Succeeded = "Succeeded",
  /** Failed */
  Failed = "Failed"
}

/**
 * Defines values for NetworkOperationStatus. \
 * {@link KnownNetworkOperationStatus} can be used interchangeably with NetworkOperationStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **InProgress** \
 * **Succeeded** \
 * **Failed**
 */
export type NetworkOperationStatus = string;

/** Known values of {@link SecurityConfigurationRuleProtocol} that the service accepts. */
export enum KnownSecurityConfigurationRuleProtocol {
  /** Tcp */
  Tcp = "Tcp",
  /** Udp */
  Udp = "Udp",
  /** Icmp */
  Icmp = "Icmp",
  /** Esp */
  Esp = "Esp",
  /** Any */
  Any = "Any",
  /** Ah */
  Ah = "Ah"
}

/**
 * Defines values for SecurityConfigurationRuleProtocol. \
 * {@link KnownSecurityConfigurationRuleProtocol} can be used interchangeably with SecurityConfigurationRuleProtocol,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Tcp** \
 * **Udp** \
 * **Icmp** \
 * **Esp** \
 * **Any** \
 * **Ah**
 */
export type SecurityConfigurationRuleProtocol = string;

/** Known values of {@link AddressPrefixType} that the service accepts. */
export enum KnownAddressPrefixType {
  /** IPPrefix */
  IPPrefix = "IPPrefix",
  /** ServiceTag */
  ServiceTag = "ServiceTag"
}

/**
 * Defines values for AddressPrefixType. \
 * {@link KnownAddressPrefixType} can be used interchangeably with AddressPrefixType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **IPPrefix** \
 * **ServiceTag**
 */
export type AddressPrefixType = string;

/** Known values of {@link SecurityConfigurationRuleAccess} that the service accepts. */
export enum KnownSecurityConfigurationRuleAccess {
  /** Allow */
  Allow = "Allow",
  /** Deny */
  Deny = "Deny",
  /** AlwaysAllow */
  AlwaysAllow = "AlwaysAllow"
}

/**
 * Defines values for SecurityConfigurationRuleAccess. \
 * {@link KnownSecurityConfigurationRuleAccess} can be used interchangeably with SecurityConfigurationRuleAccess,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Allow** \
 * **Deny** \
 * **AlwaysAllow**
 */
export type SecurityConfigurationRuleAccess = string;

/** Known values of {@link SecurityConfigurationRuleDirection} that the service accepts. */
export enum KnownSecurityConfigurationRuleDirection {
  /** Inbound */
  Inbound = "Inbound",
  /** Outbound */
  Outbound = "Outbound"
}

/**
 * Defines values for SecurityConfigurationRuleDirection. \
 * {@link KnownSecurityConfigurationRuleDirection} can be used interchangeably with SecurityConfigurationRuleDirection,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Inbound** \
 * **Outbound**
 */
export type SecurityConfigurationRuleDirection = string;

/** Known values of {@link TunnelConnectionStatus} that the service accepts. */
export enum KnownTunnelConnectionStatus {
  /** Unknown */
  Unknown = "Unknown",
  /** Connecting */
  Connecting = "Connecting",
  /** Connected */
  Connected = "Connected",
  /** NotConnected */
  NotConnected = "NotConnected"
}

/**
 * Defines values for TunnelConnectionStatus. \
 * {@link KnownTunnelConnectionStatus} can be used interchangeably with TunnelConnectionStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **Connecting** \
 * **Connected** \
 * **NotConnected**
 */
export type TunnelConnectionStatus = string;

/** Known values of {@link HubVirtualNetworkConnectionStatus} that the service accepts. */
export enum KnownHubVirtualNetworkConnectionStatus {
  /** Unknown */
  Unknown = "Unknown",
  /** Connecting */
  Connecting = "Connecting",
  /** Connected */
  Connected = "Connected",
  /** NotConnected */
  NotConnected = "NotConnected"
}

/**
 * Defines values for HubVirtualNetworkConnectionStatus. \
 * {@link KnownHubVirtualNetworkConnectionStatus} can be used interchangeably with HubVirtualNetworkConnectionStatus,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown** \
 * **Connecting** \
 * **Connected** \
 * **NotConnected**
 */
export type HubVirtualNetworkConnectionStatus = string;
/** Defines values for ResourceIdentityType. */
export type ResourceIdentityType =
  | "SystemAssigned"
  | "UserAssigned"
  | "SystemAssigned, UserAssigned"
  | "None";
/** Defines values for FirewallPolicyIdpsSignatureMode. */
export type FirewallPolicyIdpsSignatureMode = 0 | 1 | 2;
/** Defines values for FirewallPolicyIdpsSignatureSeverity. */
export type FirewallPolicyIdpsSignatureSeverity = 1 | 2 | 3;
/** Defines values for FirewallPolicyIdpsSignatureDirection. */
export type FirewallPolicyIdpsSignatureDirection = 0 | 1 | 2;
/** Defines values for PacketCaptureTargetType. */
export type PacketCaptureTargetType = "AzureVM" | "AzureVMSS";
/** Defines values for SlotType. */
export type SlotType = "Production" | "Staging";

/** Optional parameters. */
export interface ApplicationGatewaysDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ApplicationGatewaysGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ApplicationGatewaysGetResponse = ApplicationGateway;

/** Optional parameters. */
export interface ApplicationGatewaysCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ApplicationGatewaysCreateOrUpdateResponse = ApplicationGateway;

/** Optional parameters. */
export interface ApplicationGatewaysUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type ApplicationGatewaysUpdateTagsResponse = ApplicationGateway;

/** Optional parameters. */
export interface ApplicationGatewaysListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ApplicationGatewaysListResponse = ApplicationGatewayListResult;

/** Optional parameters. */
export interface ApplicationGatewaysListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type ApplicationGatewaysListAllResponse = ApplicationGatewayListResult;

/** Optional parameters. */
export interface ApplicationGatewaysStartOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ApplicationGatewaysStopOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ApplicationGatewaysBackendHealthOptionalParams
  extends coreClient.OperationOptions {
  /** Expands BackendAddressPool and BackendHttpSettings referenced in backend health. */
  expand?: string;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the backendHealth operation. */
export type ApplicationGatewaysBackendHealthResponse = ApplicationGatewayBackendHealth;

/** Optional parameters. */
export interface ApplicationGatewaysBackendHealthOnDemandOptionalParams
  extends coreClient.OperationOptions {
  /** Expands BackendAddressPool and BackendHttpSettings referenced in backend health. */
  expand?: string;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the backendHealthOnDemand operation. */
export type ApplicationGatewaysBackendHealthOnDemandResponse = ApplicationGatewayBackendHealthOnDemand;

/** Optional parameters. */
export interface ApplicationGatewaysListAvailableServerVariablesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAvailableServerVariables operation. */
export type ApplicationGatewaysListAvailableServerVariablesResponse = {
  /** The parsed response body. */
  body: string[];
};

/** Optional parameters. */
export interface ApplicationGatewaysListAvailableRequestHeadersOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAvailableRequestHeaders operation. */
export type ApplicationGatewaysListAvailableRequestHeadersResponse = {
  /** The parsed response body. */
  body: string[];
};

/** Optional parameters. */
export interface ApplicationGatewaysListAvailableResponseHeadersOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAvailableResponseHeaders operation. */
export type ApplicationGatewaysListAvailableResponseHeadersResponse = {
  /** The parsed response body. */
  body: string[];
};

/** Optional parameters. */
export interface ApplicationGatewaysListAvailableWafRuleSetsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAvailableWafRuleSets operation. */
export type ApplicationGatewaysListAvailableWafRuleSetsResponse = ApplicationGatewayAvailableWafRuleSetsResult;

/** Optional parameters. */
export interface ApplicationGatewaysListAvailableSslOptionsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAvailableSslOptions operation. */
export type ApplicationGatewaysListAvailableSslOptionsResponse = ApplicationGatewayAvailableSslOptions;

/** Optional parameters. */
export interface ApplicationGatewaysListAvailableSslPredefinedPoliciesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAvailableSslPredefinedPolicies operation. */
export type ApplicationGatewaysListAvailableSslPredefinedPoliciesResponse = ApplicationGatewayAvailableSslPredefinedPolicies;

/** Optional parameters. */
export interface ApplicationGatewaysGetSslPredefinedPolicyOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getSslPredefinedPolicy operation. */
export type ApplicationGatewaysGetSslPredefinedPolicyResponse = ApplicationGatewaySslPredefinedPolicy;

/** Optional parameters. */
export interface ApplicationGatewaysListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ApplicationGatewaysListNextResponse = ApplicationGatewayListResult;

/** Optional parameters. */
export interface ApplicationGatewaysListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type ApplicationGatewaysListAllNextResponse = ApplicationGatewayListResult;

/** Optional parameters. */
export interface ApplicationGatewaysListAvailableSslPredefinedPoliciesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAvailableSslPredefinedPoliciesNext operation. */
export type ApplicationGatewaysListAvailableSslPredefinedPoliciesNextResponse = ApplicationGatewayAvailableSslPredefinedPolicies;

/** Optional parameters. */
export interface ApplicationGatewayPrivateLinkResourcesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ApplicationGatewayPrivateLinkResourcesListResponse = ApplicationGatewayPrivateLinkResourceListResult;

/** Optional parameters. */
export interface ApplicationGatewayPrivateLinkResourcesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ApplicationGatewayPrivateLinkResourcesListNextResponse = ApplicationGatewayPrivateLinkResourceListResult;

/** Optional parameters. */
export interface ApplicationGatewayPrivateEndpointConnectionsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ApplicationGatewayPrivateEndpointConnectionsUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the update operation. */
export type ApplicationGatewayPrivateEndpointConnectionsUpdateResponse = ApplicationGatewayPrivateEndpointConnection;

/** Optional parameters. */
export interface ApplicationGatewayPrivateEndpointConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ApplicationGatewayPrivateEndpointConnectionsGetResponse = ApplicationGatewayPrivateEndpointConnection;

/** Optional parameters. */
export interface ApplicationGatewayPrivateEndpointConnectionsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ApplicationGatewayPrivateEndpointConnectionsListResponse = ApplicationGatewayPrivateEndpointConnectionListResult;

/** Optional parameters. */
export interface ApplicationGatewayPrivateEndpointConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ApplicationGatewayPrivateEndpointConnectionsListNextResponse = ApplicationGatewayPrivateEndpointConnectionListResult;

/** Optional parameters. */
export interface ApplicationSecurityGroupsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ApplicationSecurityGroupsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ApplicationSecurityGroupsGetResponse = ApplicationSecurityGroup;

/** Optional parameters. */
export interface ApplicationSecurityGroupsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ApplicationSecurityGroupsCreateOrUpdateResponse = ApplicationSecurityGroup;

/** Optional parameters. */
export interface ApplicationSecurityGroupsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type ApplicationSecurityGroupsUpdateTagsResponse = ApplicationSecurityGroup;

/** Optional parameters. */
export interface ApplicationSecurityGroupsListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type ApplicationSecurityGroupsListAllResponse = ApplicationSecurityGroupListResult;

/** Optional parameters. */
export interface ApplicationSecurityGroupsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ApplicationSecurityGroupsListResponse = ApplicationSecurityGroupListResult;

/** Optional parameters. */
export interface ApplicationSecurityGroupsListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type ApplicationSecurityGroupsListAllNextResponse = ApplicationSecurityGroupListResult;

/** Optional parameters. */
export interface ApplicationSecurityGroupsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ApplicationSecurityGroupsListNextResponse = ApplicationSecurityGroupListResult;

/** Optional parameters. */
export interface AvailableDelegationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type AvailableDelegationsListResponse = AvailableDelegationsResult;

/** Optional parameters. */
export interface AvailableDelegationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type AvailableDelegationsListNextResponse = AvailableDelegationsResult;

/** Optional parameters. */
export interface AvailableResourceGroupDelegationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type AvailableResourceGroupDelegationsListResponse = AvailableDelegationsResult;

/** Optional parameters. */
export interface AvailableResourceGroupDelegationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type AvailableResourceGroupDelegationsListNextResponse = AvailableDelegationsResult;

/** Optional parameters. */
export interface AvailableServiceAliasesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type AvailableServiceAliasesListResponse = AvailableServiceAliasesResult;

/** Optional parameters. */
export interface AvailableServiceAliasesListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type AvailableServiceAliasesListByResourceGroupResponse = AvailableServiceAliasesResult;

/** Optional parameters. */
export interface AvailableServiceAliasesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type AvailableServiceAliasesListNextResponse = AvailableServiceAliasesResult;

/** Optional parameters. */
export interface AvailableServiceAliasesListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type AvailableServiceAliasesListByResourceGroupNextResponse = AvailableServiceAliasesResult;

/** Optional parameters. */
export interface AzureFirewallsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface AzureFirewallsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type AzureFirewallsGetResponse = AzureFirewall;

/** Optional parameters. */
export interface AzureFirewallsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type AzureFirewallsCreateOrUpdateResponse = AzureFirewall;

/** Optional parameters. */
export interface AzureFirewallsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the updateTags operation. */
export type AzureFirewallsUpdateTagsResponse = AzureFirewall;

/** Optional parameters. */
export interface AzureFirewallsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type AzureFirewallsListResponse = AzureFirewallListResult;

/** Optional parameters. */
export interface AzureFirewallsListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type AzureFirewallsListAllResponse = AzureFirewallListResult;

/** Optional parameters. */
export interface AzureFirewallsListLearnedPrefixesOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listLearnedPrefixes operation. */
export type AzureFirewallsListLearnedPrefixesResponse = IPPrefixesList;

/** Optional parameters. */
export interface AzureFirewallsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type AzureFirewallsListNextResponse = AzureFirewallListResult;

/** Optional parameters. */
export interface AzureFirewallsListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type AzureFirewallsListAllNextResponse = AzureFirewallListResult;

/** Optional parameters. */
export interface AzureFirewallFqdnTagsListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type AzureFirewallFqdnTagsListAllResponse = AzureFirewallFqdnTagListResult;

/** Optional parameters. */
export interface AzureFirewallFqdnTagsListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type AzureFirewallFqdnTagsListAllNextResponse = AzureFirewallFqdnTagListResult;

/** Optional parameters. */
export interface WebCategoriesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands resourceIds back referenced by the azureWebCategory resource. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type WebCategoriesGetResponse = AzureWebCategory;

/** Optional parameters. */
export interface WebCategoriesListBySubscriptionOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listBySubscription operation. */
export type WebCategoriesListBySubscriptionResponse = AzureWebCategoryListResult;

/** Optional parameters. */
export interface WebCategoriesListBySubscriptionNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listBySubscriptionNext operation. */
export type WebCategoriesListBySubscriptionNextResponse = AzureWebCategoryListResult;

/** Optional parameters. */
export interface BastionHostsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface BastionHostsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type BastionHostsGetResponse = BastionHost;

/** Optional parameters. */
export interface BastionHostsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type BastionHostsCreateOrUpdateResponse = BastionHost;

/** Optional parameters. */
export interface BastionHostsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the updateTags operation. */
export type BastionHostsUpdateTagsResponse = BastionHost;

/** Optional parameters. */
export interface BastionHostsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type BastionHostsListResponse = BastionHostListResult;

/** Optional parameters. */
export interface BastionHostsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type BastionHostsListByResourceGroupResponse = BastionHostListResult;

/** Optional parameters. */
export interface BastionHostsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type BastionHostsListNextResponse = BastionHostListResult;

/** Optional parameters. */
export interface BastionHostsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type BastionHostsListByResourceGroupNextResponse = BastionHostListResult;

/** Optional parameters. */
export interface PutBastionShareableLinkOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the putBastionShareableLink operation. */
export type PutBastionShareableLinkResponse = BastionShareableLinkListResult;

/** Optional parameters. */
export interface DeleteBastionShareableLinkOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface GetBastionShareableLinkOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getBastionShareableLink operation. */
export type GetBastionShareableLinkResponse = BastionShareableLinkListResult;

/** Optional parameters. */
export interface GetActiveSessionsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getActiveSessions operation. */
export type GetActiveSessionsResponse = BastionActiveSessionListResult;

/** Optional parameters. */
export interface DisconnectActiveSessionsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the disconnectActiveSessions operation. */
export type DisconnectActiveSessionsResponse = BastionSessionDeleteResult;

/** Optional parameters. */
export interface CheckDnsNameAvailabilityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the checkDnsNameAvailability operation. */
export type CheckDnsNameAvailabilityResponse = DnsNameAvailabilityResult;

/** Optional parameters. */
export interface ExpressRouteProviderPortOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the expressRouteProviderPort operation. */
export type ExpressRouteProviderPortResponse = ExpressRouteProviderPort;

/** Optional parameters. */
export interface ListActiveConnectivityConfigurationsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listActiveConnectivityConfigurations operation. */
export type ListActiveConnectivityConfigurationsResponse = ActiveConnectivityConfigurationsListResult;

/** Optional parameters. */
export interface ListActiveSecurityAdminRulesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listActiveSecurityAdminRules operation. */
export type ListActiveSecurityAdminRulesResponse = ActiveSecurityAdminRulesListResult;

/** Optional parameters. */
export interface ListNetworkManagerEffectiveConnectivityConfigurationsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNetworkManagerEffectiveConnectivityConfigurations operation. */
export type ListNetworkManagerEffectiveConnectivityConfigurationsResponse = NetworkManagerEffectiveConnectivityConfigurationListResult;

/** Optional parameters. */
export interface ListNetworkManagerEffectiveSecurityAdminRulesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNetworkManagerEffectiveSecurityAdminRules operation. */
export type ListNetworkManagerEffectiveSecurityAdminRulesResponse = NetworkManagerEffectiveSecurityAdminRulesListResult;

/** Optional parameters. */
export interface SupportedSecurityProvidersOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the supportedSecurityProviders operation. */
export type SupportedSecurityProvidersResponse = VirtualWanSecurityProviders;

/** Optional parameters. */
export interface GeneratevirtualwanvpnserverconfigurationvpnprofileOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the generatevirtualwanvpnserverconfigurationvpnprofile operation. */
export type GeneratevirtualwanvpnserverconfigurationvpnprofileResponse = VpnProfileResponse;

/** Optional parameters. */
export interface PutBastionShareableLinkNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the putBastionShareableLinkNext operation. */
export type PutBastionShareableLinkNextResponse = BastionShareableLinkListResult;

/** Optional parameters. */
export interface GetBastionShareableLinkNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getBastionShareableLinkNext operation. */
export type GetBastionShareableLinkNextResponse = BastionShareableLinkListResult;

/** Optional parameters. */
export interface GetActiveSessionsNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getActiveSessionsNext operation. */
export type GetActiveSessionsNextResponse = BastionActiveSessionListResult;

/** Optional parameters. */
export interface DisconnectActiveSessionsNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the disconnectActiveSessionsNext operation. */
export type DisconnectActiveSessionsNextResponse = BastionSessionDeleteResult;

/** Optional parameters. */
export interface NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCloudServiceRoleInstanceNetworkInterfaces operation. */
export type NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesListCloudServiceNetworkInterfacesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCloudServiceNetworkInterfaces operation. */
export type NetworkInterfacesListCloudServiceNetworkInterfacesResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesGetCloudServiceNetworkInterfaceOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the getCloudServiceNetworkInterface operation. */
export type NetworkInterfacesGetCloudServiceNetworkInterfaceResponse = NetworkInterface;

/** Optional parameters. */
export interface NetworkInterfacesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NetworkInterfacesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type NetworkInterfacesGetResponse = NetworkInterface;

/** Optional parameters. */
export interface NetworkInterfacesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type NetworkInterfacesCreateOrUpdateResponse = NetworkInterface;

/** Optional parameters. */
export interface NetworkInterfacesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type NetworkInterfacesUpdateTagsResponse = NetworkInterface;

/** Optional parameters. */
export interface NetworkInterfacesListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type NetworkInterfacesListAllResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NetworkInterfacesListResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesGetEffectiveRouteTableOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getEffectiveRouteTable operation. */
export type NetworkInterfacesGetEffectiveRouteTableResponse = EffectiveRouteListResult;

/** Optional parameters. */
export interface NetworkInterfacesListEffectiveNetworkSecurityGroupsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listEffectiveNetworkSecurityGroups operation. */
export type NetworkInterfacesListEffectiveNetworkSecurityGroupsResponse = EffectiveNetworkSecurityGroupListResult;

/** Optional parameters. */
export interface NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSetVMNetworkInterfaces operation. */
export type NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSetNetworkInterfaces operation. */
export type NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesGetVirtualMachineScaleSetNetworkInterfaceOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the getVirtualMachineScaleSetNetworkInterface operation. */
export type NetworkInterfacesGetVirtualMachineScaleSetNetworkInterfaceResponse = NetworkInterface;

/** Optional parameters. */
export interface NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the listVirtualMachineScaleSetIpConfigurations operation. */
export type NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsResponse = NetworkInterfaceIPConfigurationListResult;

/** Optional parameters. */
export interface NetworkInterfacesGetVirtualMachineScaleSetIpConfigurationOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the getVirtualMachineScaleSetIpConfiguration operation. */
export type NetworkInterfacesGetVirtualMachineScaleSetIpConfigurationResponse = NetworkInterfaceIPConfiguration;

/** Optional parameters. */
export interface NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCloudServiceRoleInstanceNetworkInterfacesNext operation. */
export type NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesNextResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesListCloudServiceNetworkInterfacesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCloudServiceNetworkInterfacesNext operation. */
export type NetworkInterfacesListCloudServiceNetworkInterfacesNextResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type NetworkInterfacesListAllNextResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type NetworkInterfacesListNextResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSetVMNetworkInterfacesNext operation. */
export type NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesNextResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSetNetworkInterfacesNext operation. */
export type NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesNextResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsNextOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the listVirtualMachineScaleSetIpConfigurationsNext operation. */
export type NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsNextResponse = NetworkInterfaceIPConfigurationListResult;

/** Optional parameters. */
export interface PublicIPAddressesListCloudServicePublicIPAddressesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCloudServicePublicIPAddresses operation. */
export type PublicIPAddressesListCloudServicePublicIPAddressesResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesListCloudServiceRoleInstancePublicIPAddressesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCloudServiceRoleInstancePublicIPAddresses operation. */
export type PublicIPAddressesListCloudServiceRoleInstancePublicIPAddressesResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesGetCloudServicePublicIPAddressOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the getCloudServicePublicIPAddress operation. */
export type PublicIPAddressesGetCloudServicePublicIPAddressResponse = PublicIPAddress;

/** Optional parameters. */
export interface PublicIPAddressesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface PublicIPAddressesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type PublicIPAddressesGetResponse = PublicIPAddress;

/** Optional parameters. */
export interface PublicIPAddressesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type PublicIPAddressesCreateOrUpdateResponse = PublicIPAddress;

/** Optional parameters. */
export interface PublicIPAddressesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type PublicIPAddressesUpdateTagsResponse = PublicIPAddress;

/** Optional parameters. */
export interface PublicIPAddressesListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type PublicIPAddressesListAllResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type PublicIPAddressesListResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesListVirtualMachineScaleSetPublicIPAddressesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSetPublicIPAddresses operation. */
export type PublicIPAddressesListVirtualMachineScaleSetPublicIPAddressesResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesListVirtualMachineScaleSetVMPublicIPAddressesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSetVMPublicIPAddresses operation. */
export type PublicIPAddressesListVirtualMachineScaleSetVMPublicIPAddressesResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesGetVirtualMachineScaleSetPublicIPAddressOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the getVirtualMachineScaleSetPublicIPAddress operation. */
export type PublicIPAddressesGetVirtualMachineScaleSetPublicIPAddressResponse = PublicIPAddress;

/** Optional parameters. */
export interface PublicIPAddressesListCloudServicePublicIPAddressesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCloudServicePublicIPAddressesNext operation. */
export type PublicIPAddressesListCloudServicePublicIPAddressesNextResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesListCloudServiceRoleInstancePublicIPAddressesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCloudServiceRoleInstancePublicIPAddressesNext operation. */
export type PublicIPAddressesListCloudServiceRoleInstancePublicIPAddressesNextResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type PublicIPAddressesListAllNextResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type PublicIPAddressesListNextResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesListVirtualMachineScaleSetPublicIPAddressesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSetPublicIPAddressesNext operation. */
export type PublicIPAddressesListVirtualMachineScaleSetPublicIPAddressesNextResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface PublicIPAddressesListVirtualMachineScaleSetVMPublicIPAddressesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSetVMPublicIPAddressesNext operation. */
export type PublicIPAddressesListVirtualMachineScaleSetVMPublicIPAddressesNextResponse = PublicIPAddressListResult;

/** Optional parameters. */
export interface CustomIPPrefixesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface CustomIPPrefixesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type CustomIPPrefixesGetResponse = CustomIpPrefix;

/** Optional parameters. */
export interface CustomIPPrefixesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type CustomIPPrefixesCreateOrUpdateResponse = CustomIpPrefix;

/** Optional parameters. */
export interface CustomIPPrefixesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type CustomIPPrefixesUpdateTagsResponse = CustomIpPrefix;

/** Optional parameters. */
export interface CustomIPPrefixesListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type CustomIPPrefixesListAllResponse = CustomIpPrefixListResult;

/** Optional parameters. */
export interface CustomIPPrefixesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type CustomIPPrefixesListResponse = CustomIpPrefixListResult;

/** Optional parameters. */
export interface CustomIPPrefixesListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type CustomIPPrefixesListAllNextResponse = CustomIpPrefixListResult;

/** Optional parameters. */
export interface CustomIPPrefixesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type CustomIPPrefixesListNextResponse = CustomIpPrefixListResult;

/** Optional parameters. */
export interface DdosCustomPoliciesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface DdosCustomPoliciesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type DdosCustomPoliciesGetResponse = DdosCustomPolicy;

/** Optional parameters. */
export interface DdosCustomPoliciesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type DdosCustomPoliciesCreateOrUpdateResponse = DdosCustomPolicy;

/** Optional parameters. */
export interface DdosCustomPoliciesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type DdosCustomPoliciesUpdateTagsResponse = DdosCustomPolicy;

/** Optional parameters. */
export interface DdosProtectionPlansDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface DdosProtectionPlansGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type DdosProtectionPlansGetResponse = DdosProtectionPlan;

/** Optional parameters. */
export interface DdosProtectionPlansCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type DdosProtectionPlansCreateOrUpdateResponse = DdosProtectionPlan;

/** Optional parameters. */
export interface DdosProtectionPlansUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type DdosProtectionPlansUpdateTagsResponse = DdosProtectionPlan;

/** Optional parameters. */
export interface DdosProtectionPlansListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type DdosProtectionPlansListResponse = DdosProtectionPlanListResult;

/** Optional parameters. */
export interface DdosProtectionPlansListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type DdosProtectionPlansListByResourceGroupResponse = DdosProtectionPlanListResult;

/** Optional parameters. */
export interface DdosProtectionPlansListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type DdosProtectionPlansListNextResponse = DdosProtectionPlanListResult;

/** Optional parameters. */
export interface DdosProtectionPlansListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type DdosProtectionPlansListByResourceGroupNextResponse = DdosProtectionPlanListResult;

/** Optional parameters. */
export interface DscpConfigurationCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type DscpConfigurationCreateOrUpdateResponse = DscpConfiguration;

/** Optional parameters. */
export interface DscpConfigurationDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface DscpConfigurationGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type DscpConfigurationGetResponse = DscpConfiguration;

/** Optional parameters. */
export interface DscpConfigurationListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type DscpConfigurationListResponse = DscpConfigurationListResult;

/** Optional parameters. */
export interface DscpConfigurationListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type DscpConfigurationListAllResponse = DscpConfigurationListResult;

/** Optional parameters. */
export interface DscpConfigurationListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type DscpConfigurationListNextResponse = DscpConfigurationListResult;

/** Optional parameters. */
export interface DscpConfigurationListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type DscpConfigurationListAllNextResponse = DscpConfigurationListResult;

/** Optional parameters. */
export interface AvailableEndpointServicesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type AvailableEndpointServicesListResponse = EndpointServicesListResult;

/** Optional parameters. */
export interface AvailableEndpointServicesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type AvailableEndpointServicesListNextResponse = EndpointServicesListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitAuthorizationsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ExpressRouteCircuitAuthorizationsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRouteCircuitAuthorizationsGetResponse = ExpressRouteCircuitAuthorization;

/** Optional parameters. */
export interface ExpressRouteCircuitAuthorizationsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse = ExpressRouteCircuitAuthorization;

/** Optional parameters. */
export interface ExpressRouteCircuitAuthorizationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRouteCircuitAuthorizationsListResponse = AuthorizationListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitAuthorizationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRouteCircuitAuthorizationsListNextResponse = AuthorizationListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitPeeringsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ExpressRouteCircuitPeeringsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRouteCircuitPeeringsGetResponse = ExpressRouteCircuitPeering;

/** Optional parameters. */
export interface ExpressRouteCircuitPeeringsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRouteCircuitPeeringsCreateOrUpdateResponse = ExpressRouteCircuitPeering;

/** Optional parameters. */
export interface ExpressRouteCircuitPeeringsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRouteCircuitPeeringsListResponse = ExpressRouteCircuitPeeringListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitPeeringsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRouteCircuitPeeringsListNextResponse = ExpressRouteCircuitPeeringListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitConnectionsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ExpressRouteCircuitConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRouteCircuitConnectionsGetResponse = ExpressRouteCircuitConnection;

/** Optional parameters. */
export interface ExpressRouteCircuitConnectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRouteCircuitConnectionsCreateOrUpdateResponse = ExpressRouteCircuitConnection;

/** Optional parameters. */
export interface ExpressRouteCircuitConnectionsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRouteCircuitConnectionsListResponse = ExpressRouteCircuitConnectionListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRouteCircuitConnectionsListNextResponse = ExpressRouteCircuitConnectionListResult;

/** Optional parameters. */
export interface PeerExpressRouteCircuitConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type PeerExpressRouteCircuitConnectionsGetResponse = PeerExpressRouteCircuitConnection;

/** Optional parameters. */
export interface PeerExpressRouteCircuitConnectionsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type PeerExpressRouteCircuitConnectionsListResponse = PeerExpressRouteCircuitConnectionListResult;

/** Optional parameters. */
export interface PeerExpressRouteCircuitConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type PeerExpressRouteCircuitConnectionsListNextResponse = PeerExpressRouteCircuitConnectionListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ExpressRouteCircuitsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRouteCircuitsGetResponse = ExpressRouteCircuit;

/** Optional parameters. */
export interface ExpressRouteCircuitsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRouteCircuitsCreateOrUpdateResponse = ExpressRouteCircuit;

/** Optional parameters. */
export interface ExpressRouteCircuitsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type ExpressRouteCircuitsUpdateTagsResponse = ExpressRouteCircuit;

/** Optional parameters. */
export interface ExpressRouteCircuitsListArpTableOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listArpTable operation. */
export type ExpressRouteCircuitsListArpTableResponse = ExpressRouteCircuitsArpTableListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitsListRoutesTableOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listRoutesTable operation. */
export type ExpressRouteCircuitsListRoutesTableResponse = ExpressRouteCircuitsRoutesTableListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitsListRoutesTableSummaryOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listRoutesTableSummary operation. */
export type ExpressRouteCircuitsListRoutesTableSummaryResponse = ExpressRouteCircuitsRoutesTableSummaryListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitsGetStatsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getStats operation. */
export type ExpressRouteCircuitsGetStatsResponse = ExpressRouteCircuitStats;

/** Optional parameters. */
export interface ExpressRouteCircuitsGetPeeringStatsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getPeeringStats operation. */
export type ExpressRouteCircuitsGetPeeringStatsResponse = ExpressRouteCircuitStats;

/** Optional parameters. */
export interface ExpressRouteCircuitsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRouteCircuitsListResponse = ExpressRouteCircuitListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitsListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type ExpressRouteCircuitsListAllResponse = ExpressRouteCircuitListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRouteCircuitsListNextResponse = ExpressRouteCircuitListResult;

/** Optional parameters. */
export interface ExpressRouteCircuitsListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type ExpressRouteCircuitsListAllNextResponse = ExpressRouteCircuitListResult;

/** Optional parameters. */
export interface ExpressRouteServiceProvidersListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRouteServiceProvidersListResponse = ExpressRouteServiceProviderListResult;

/** Optional parameters. */
export interface ExpressRouteServiceProvidersListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRouteServiceProvidersListNextResponse = ExpressRouteServiceProviderListResult;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRouteCrossConnectionsListResponse = ExpressRouteCrossConnectionListResult;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type ExpressRouteCrossConnectionsListByResourceGroupResponse = ExpressRouteCrossConnectionListResult;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRouteCrossConnectionsGetResponse = ExpressRouteCrossConnection;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRouteCrossConnectionsCreateOrUpdateResponse = ExpressRouteCrossConnection;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type ExpressRouteCrossConnectionsUpdateTagsResponse = ExpressRouteCrossConnection;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsListArpTableOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listArpTable operation. */
export type ExpressRouteCrossConnectionsListArpTableResponse = ExpressRouteCircuitsArpTableListResult;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsListRoutesTableSummaryOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listRoutesTableSummary operation. */
export type ExpressRouteCrossConnectionsListRoutesTableSummaryResponse = ExpressRouteCrossConnectionsRoutesTableSummaryListResult;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsListRoutesTableOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listRoutesTable operation. */
export type ExpressRouteCrossConnectionsListRoutesTableResponse = ExpressRouteCircuitsRoutesTableListResult;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRouteCrossConnectionsListNextResponse = ExpressRouteCrossConnectionListResult;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type ExpressRouteCrossConnectionsListByResourceGroupNextResponse = ExpressRouteCrossConnectionListResult;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionPeeringsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRouteCrossConnectionPeeringsListResponse = ExpressRouteCrossConnectionPeeringList;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionPeeringsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ExpressRouteCrossConnectionPeeringsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRouteCrossConnectionPeeringsGetResponse = ExpressRouteCrossConnectionPeering;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionPeeringsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse = ExpressRouteCrossConnectionPeering;

/** Optional parameters. */
export interface ExpressRouteCrossConnectionPeeringsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRouteCrossConnectionPeeringsListNextResponse = ExpressRouteCrossConnectionPeeringList;

/** Optional parameters. */
export interface ExpressRoutePortsLocationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRoutePortsLocationsListResponse = ExpressRoutePortsLocationListResult;

/** Optional parameters. */
export interface ExpressRoutePortsLocationsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRoutePortsLocationsGetResponse = ExpressRoutePortsLocation;

/** Optional parameters. */
export interface ExpressRoutePortsLocationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRoutePortsLocationsListNextResponse = ExpressRoutePortsLocationListResult;

/** Optional parameters. */
export interface ExpressRoutePortsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ExpressRoutePortsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRoutePortsGetResponse = ExpressRoutePort;

/** Optional parameters. */
export interface ExpressRoutePortsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRoutePortsCreateOrUpdateResponse = ExpressRoutePort;

/** Optional parameters. */
export interface ExpressRoutePortsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type ExpressRoutePortsUpdateTagsResponse = ExpressRoutePort;

/** Optional parameters. */
export interface ExpressRoutePortsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type ExpressRoutePortsListByResourceGroupResponse = ExpressRoutePortListResult;

/** Optional parameters. */
export interface ExpressRoutePortsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRoutePortsListResponse = ExpressRoutePortListResult;

/** Optional parameters. */
export interface ExpressRoutePortsGenerateLOAOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the generateLOA operation. */
export type ExpressRoutePortsGenerateLOAResponse = GenerateExpressRoutePortsLOAResult;

/** Optional parameters. */
export interface ExpressRoutePortsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type ExpressRoutePortsListByResourceGroupNextResponse = ExpressRoutePortListResult;

/** Optional parameters. */
export interface ExpressRoutePortsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRoutePortsListNextResponse = ExpressRoutePortListResult;

/** Optional parameters. */
export interface ExpressRouteLinksGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRouteLinksGetResponse = ExpressRouteLink;

/** Optional parameters. */
export interface ExpressRouteLinksListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRouteLinksListResponse = ExpressRouteLinkListResult;

/** Optional parameters. */
export interface ExpressRouteLinksListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRouteLinksListNextResponse = ExpressRouteLinkListResult;

/** Optional parameters. */
export interface ExpressRoutePortAuthorizationsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ExpressRoutePortAuthorizationsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRoutePortAuthorizationsGetResponse = ExpressRoutePortAuthorization;

/** Optional parameters. */
export interface ExpressRoutePortAuthorizationsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRoutePortAuthorizationsCreateOrUpdateResponse = ExpressRoutePortAuthorization;

/** Optional parameters. */
export interface ExpressRoutePortAuthorizationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRoutePortAuthorizationsListResponse = ExpressRoutePortAuthorizationListResult;

/** Optional parameters. */
export interface ExpressRoutePortAuthorizationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ExpressRoutePortAuthorizationsListNextResponse = ExpressRoutePortAuthorizationListResult;

/** Optional parameters. */
export interface ExpressRouteProviderPortsLocationListOptionalParams
  extends coreClient.OperationOptions {
  /** The filter to apply on the operation. For example, you can use $filter=location eq '{state}'. */
  filter?: string;
}

/** Contains response data for the list operation. */
export type ExpressRouteProviderPortsLocationListResponse = ExpressRouteProviderPortListResult;

/** Optional parameters. */
export interface FirewallPoliciesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface FirewallPoliciesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type FirewallPoliciesGetResponse = FirewallPolicy;

/** Optional parameters. */
export interface FirewallPoliciesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type FirewallPoliciesCreateOrUpdateResponse = FirewallPolicy;

/** Optional parameters. */
export interface FirewallPoliciesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type FirewallPoliciesUpdateTagsResponse = FirewallPolicy;

/** Optional parameters. */
export interface FirewallPoliciesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type FirewallPoliciesListResponse = FirewallPolicyListResult;

/** Optional parameters. */
export interface FirewallPoliciesListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type FirewallPoliciesListAllResponse = FirewallPolicyListResult;

/** Optional parameters. */
export interface FirewallPoliciesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type FirewallPoliciesListNextResponse = FirewallPolicyListResult;

/** Optional parameters. */
export interface FirewallPoliciesListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type FirewallPoliciesListAllNextResponse = FirewallPolicyListResult;

/** Optional parameters. */
export interface FirewallPolicyRuleCollectionGroupsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface FirewallPolicyRuleCollectionGroupsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type FirewallPolicyRuleCollectionGroupsGetResponse = FirewallPolicyRuleCollectionGroup;

/** Optional parameters. */
export interface FirewallPolicyRuleCollectionGroupsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type FirewallPolicyRuleCollectionGroupsCreateOrUpdateResponse = FirewallPolicyRuleCollectionGroup;

/** Optional parameters. */
export interface FirewallPolicyRuleCollectionGroupsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type FirewallPolicyRuleCollectionGroupsListResponse = FirewallPolicyRuleCollectionGroupListResult;

/** Optional parameters. */
export interface FirewallPolicyRuleCollectionGroupsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type FirewallPolicyRuleCollectionGroupsListNextResponse = FirewallPolicyRuleCollectionGroupListResult;

/** Optional parameters. */
export interface FirewallPolicyIdpsSignaturesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type FirewallPolicyIdpsSignaturesListResponse = QueryResults;

/** Optional parameters. */
export interface FirewallPolicyIdpsSignaturesOverridesPatchOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the patch operation. */
export type FirewallPolicyIdpsSignaturesOverridesPatchResponse = SignaturesOverrides;

/** Optional parameters. */
export interface FirewallPolicyIdpsSignaturesOverridesPutOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the put operation. */
export type FirewallPolicyIdpsSignaturesOverridesPutResponse = SignaturesOverrides;

/** Optional parameters. */
export interface FirewallPolicyIdpsSignaturesOverridesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type FirewallPolicyIdpsSignaturesOverridesGetResponse = SignaturesOverrides;

/** Optional parameters. */
export interface FirewallPolicyIdpsSignaturesOverridesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type FirewallPolicyIdpsSignaturesOverridesListResponse = SignaturesOverridesList;

/** Optional parameters. */
export interface FirewallPolicyIdpsSignaturesFilterValuesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type FirewallPolicyIdpsSignaturesFilterValuesListResponse = SignatureOverridesFilterValuesResponse;

/** Optional parameters. */
export interface IpAllocationsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface IpAllocationsGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type IpAllocationsGetResponse = IpAllocation;

/** Optional parameters. */
export interface IpAllocationsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type IpAllocationsCreateOrUpdateResponse = IpAllocation;

/** Optional parameters. */
export interface IpAllocationsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type IpAllocationsUpdateTagsResponse = IpAllocation;

/** Optional parameters. */
export interface IpAllocationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type IpAllocationsListResponse = IpAllocationListResult;

/** Optional parameters. */
export interface IpAllocationsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type IpAllocationsListByResourceGroupResponse = IpAllocationListResult;

/** Optional parameters. */
export interface IpAllocationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type IpAllocationsListNextResponse = IpAllocationListResult;

/** Optional parameters. */
export interface IpAllocationsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type IpAllocationsListByResourceGroupNextResponse = IpAllocationListResult;

/** Optional parameters. */
export interface IpGroupsGetOptionalParams extends coreClient.OperationOptions {
  /** Expands resourceIds (of Firewalls/Network Security Groups etc.) back referenced by the IpGroups resource. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type IpGroupsGetResponse = IpGroup;

/** Optional parameters. */
export interface IpGroupsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type IpGroupsCreateOrUpdateResponse = IpGroup;

/** Optional parameters. */
export interface IpGroupsUpdateGroupsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateGroups operation. */
export type IpGroupsUpdateGroupsResponse = IpGroup;

/** Optional parameters. */
export interface IpGroupsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface IpGroupsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type IpGroupsListByResourceGroupResponse = IpGroupListResult;

/** Optional parameters. */
export interface IpGroupsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type IpGroupsListResponse = IpGroupListResult;

/** Optional parameters. */
export interface IpGroupsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type IpGroupsListByResourceGroupNextResponse = IpGroupListResult;

/** Optional parameters. */
export interface IpGroupsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type IpGroupsListNextResponse = IpGroupListResult;

/** Optional parameters. */
export interface LoadBalancersDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface LoadBalancersGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type LoadBalancersGetResponse = LoadBalancer;

/** Optional parameters. */
export interface LoadBalancersCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type LoadBalancersCreateOrUpdateResponse = LoadBalancer;

/** Optional parameters. */
export interface LoadBalancersUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type LoadBalancersUpdateTagsResponse = LoadBalancer;

/** Optional parameters. */
export interface LoadBalancersListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type LoadBalancersListAllResponse = LoadBalancerListResult;

/** Optional parameters. */
export interface LoadBalancersListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type LoadBalancersListResponse = LoadBalancerListResult;

/** Optional parameters. */
export interface LoadBalancersSwapPublicIpAddressesOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface LoadBalancersListInboundNatRulePortMappingsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listInboundNatRulePortMappings operation. */
export type LoadBalancersListInboundNatRulePortMappingsResponse = BackendAddressInboundNatRulePortMappings;

/** Optional parameters. */
export interface LoadBalancersListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type LoadBalancersListAllNextResponse = LoadBalancerListResult;

/** Optional parameters. */
export interface LoadBalancersListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type LoadBalancersListNextResponse = LoadBalancerListResult;

/** Optional parameters. */
export interface LoadBalancerBackendAddressPoolsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type LoadBalancerBackendAddressPoolsListResponse = LoadBalancerBackendAddressPoolListResult;

/** Optional parameters. */
export interface LoadBalancerBackendAddressPoolsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type LoadBalancerBackendAddressPoolsGetResponse = BackendAddressPool;

/** Optional parameters. */
export interface LoadBalancerBackendAddressPoolsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type LoadBalancerBackendAddressPoolsCreateOrUpdateResponse = BackendAddressPool;

/** Optional parameters. */
export interface LoadBalancerBackendAddressPoolsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface LoadBalancerBackendAddressPoolsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type LoadBalancerBackendAddressPoolsListNextResponse = LoadBalancerBackendAddressPoolListResult;

/** Optional parameters. */
export interface LoadBalancerFrontendIPConfigurationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type LoadBalancerFrontendIPConfigurationsListResponse = LoadBalancerFrontendIPConfigurationListResult;

/** Optional parameters. */
export interface LoadBalancerFrontendIPConfigurationsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type LoadBalancerFrontendIPConfigurationsGetResponse = FrontendIPConfiguration;

/** Optional parameters. */
export interface LoadBalancerFrontendIPConfigurationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type LoadBalancerFrontendIPConfigurationsListNextResponse = LoadBalancerFrontendIPConfigurationListResult;

/** Optional parameters. */
export interface InboundNatRulesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type InboundNatRulesListResponse = InboundNatRuleListResult;

/** Optional parameters. */
export interface InboundNatRulesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface InboundNatRulesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type InboundNatRulesGetResponse = InboundNatRule;

/** Optional parameters. */
export interface InboundNatRulesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type InboundNatRulesCreateOrUpdateResponse = InboundNatRule;

/** Optional parameters. */
export interface InboundNatRulesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type InboundNatRulesListNextResponse = InboundNatRuleListResult;

/** Optional parameters. */
export interface LoadBalancerLoadBalancingRulesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type LoadBalancerLoadBalancingRulesListResponse = LoadBalancerLoadBalancingRuleListResult;

/** Optional parameters. */
export interface LoadBalancerLoadBalancingRulesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type LoadBalancerLoadBalancingRulesGetResponse = LoadBalancingRule;

/** Optional parameters. */
export interface LoadBalancerLoadBalancingRulesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type LoadBalancerLoadBalancingRulesListNextResponse = LoadBalancerLoadBalancingRuleListResult;

/** Optional parameters. */
export interface LoadBalancerOutboundRulesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type LoadBalancerOutboundRulesListResponse = LoadBalancerOutboundRuleListResult;

/** Optional parameters. */
export interface LoadBalancerOutboundRulesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type LoadBalancerOutboundRulesGetResponse = OutboundRule;

/** Optional parameters. */
export interface LoadBalancerOutboundRulesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type LoadBalancerOutboundRulesListNextResponse = LoadBalancerOutboundRuleListResult;

/** Optional parameters. */
export interface LoadBalancerNetworkInterfacesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type LoadBalancerNetworkInterfacesListResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface LoadBalancerNetworkInterfacesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type LoadBalancerNetworkInterfacesListNextResponse = NetworkInterfaceListResult;

/** Optional parameters. */
export interface LoadBalancerProbesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type LoadBalancerProbesListResponse = LoadBalancerProbeListResult;

/** Optional parameters. */
export interface LoadBalancerProbesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type LoadBalancerProbesGetResponse = Probe;

/** Optional parameters. */
export interface LoadBalancerProbesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type LoadBalancerProbesListNextResponse = LoadBalancerProbeListResult;

/** Optional parameters. */
export interface NatGatewaysDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NatGatewaysGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type NatGatewaysGetResponse = NatGateway;

/** Optional parameters. */
export interface NatGatewaysCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type NatGatewaysCreateOrUpdateResponse = NatGateway;

/** Optional parameters. */
export interface NatGatewaysUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type NatGatewaysUpdateTagsResponse = NatGateway;

/** Optional parameters. */
export interface NatGatewaysListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type NatGatewaysListAllResponse = NatGatewayListResult;

/** Optional parameters. */
export interface NatGatewaysListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NatGatewaysListResponse = NatGatewayListResult;

/** Optional parameters. */
export interface NatGatewaysListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type NatGatewaysListAllNextResponse = NatGatewayListResult;

/** Optional parameters. */
export interface NatGatewaysListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type NatGatewaysListNextResponse = NatGatewayListResult;

/** Optional parameters. */
export interface NetworkInterfaceIPConfigurationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NetworkInterfaceIPConfigurationsListResponse = NetworkInterfaceIPConfigurationListResult;

/** Optional parameters. */
export interface NetworkInterfaceIPConfigurationsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type NetworkInterfaceIPConfigurationsGetResponse = NetworkInterfaceIPConfiguration;

/** Optional parameters. */
export interface NetworkInterfaceIPConfigurationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type NetworkInterfaceIPConfigurationsListNextResponse = NetworkInterfaceIPConfigurationListResult;

/** Optional parameters. */
export interface NetworkInterfaceLoadBalancersListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NetworkInterfaceLoadBalancersListResponse = NetworkInterfaceLoadBalancerListResult;

/** Optional parameters. */
export interface NetworkInterfaceLoadBalancersListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type NetworkInterfaceLoadBalancersListNextResponse = NetworkInterfaceLoadBalancerListResult;

/** Optional parameters. */
export interface NetworkInterfaceTapConfigurationsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NetworkInterfaceTapConfigurationsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type NetworkInterfaceTapConfigurationsGetResponse = NetworkInterfaceTapConfiguration;

/** Optional parameters. */
export interface NetworkInterfaceTapConfigurationsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type NetworkInterfaceTapConfigurationsCreateOrUpdateResponse = NetworkInterfaceTapConfiguration;

/** Optional parameters. */
export interface NetworkInterfaceTapConfigurationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NetworkInterfaceTapConfigurationsListResponse = NetworkInterfaceTapConfigurationListResult;

/** Optional parameters. */
export interface NetworkInterfaceTapConfigurationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type NetworkInterfaceTapConfigurationsListNextResponse = NetworkInterfaceTapConfigurationListResult;

/** Optional parameters. */
export interface NetworkManagersGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type NetworkManagersGetResponse = NetworkManager;

/** Optional parameters. */
export interface NetworkManagersCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type NetworkManagersCreateOrUpdateResponse = NetworkManager;

/** Optional parameters. */
export interface NetworkManagersDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete. */
  force?: boolean;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NetworkManagersPatchOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the patch operation. */
export type NetworkManagersPatchResponse = NetworkManager;

/** Optional parameters. */
export interface NetworkManagersListBySubscriptionOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listBySubscription operation. */
export type NetworkManagersListBySubscriptionResponse = NetworkManagerListResult;

/** Optional parameters. */
export interface NetworkManagersListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type NetworkManagersListResponse = NetworkManagerListResult;

/** Optional parameters. */
export interface NetworkManagersListBySubscriptionNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listBySubscriptionNext operation. */
export type NetworkManagersListBySubscriptionNextResponse = NetworkManagerListResult;

/** Optional parameters. */
export interface NetworkManagersListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type NetworkManagersListNextResponse = NetworkManagerListResult;

/** Optional parameters. */
export interface NetworkManagerCommitsPostOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the post operation. */
export type NetworkManagerCommitsPostResponse = NetworkManagerCommit;

/** Optional parameters. */
export interface NetworkManagerDeploymentStatusListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NetworkManagerDeploymentStatusListResponse = NetworkManagerDeploymentStatusListResult;

/** Optional parameters. */
export interface SubscriptionNetworkManagerConnectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type SubscriptionNetworkManagerConnectionsCreateOrUpdateResponse = NetworkManagerConnection;

/** Optional parameters. */
export interface SubscriptionNetworkManagerConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type SubscriptionNetworkManagerConnectionsGetResponse = NetworkManagerConnection;

/** Optional parameters. */
export interface SubscriptionNetworkManagerConnectionsDeleteOptionalParams
  extends coreClient.OperationOptions {}

/** Optional parameters. */
export interface SubscriptionNetworkManagerConnectionsListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type SubscriptionNetworkManagerConnectionsListResponse = NetworkManagerConnectionListResult;

/** Optional parameters. */
export interface SubscriptionNetworkManagerConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type SubscriptionNetworkManagerConnectionsListNextResponse = NetworkManagerConnectionListResult;

/** Optional parameters. */
export interface ManagementGroupNetworkManagerConnectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type ManagementGroupNetworkManagerConnectionsCreateOrUpdateResponse = NetworkManagerConnection;

/** Optional parameters. */
export interface ManagementGroupNetworkManagerConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ManagementGroupNetworkManagerConnectionsGetResponse = NetworkManagerConnection;

/** Optional parameters. */
export interface ManagementGroupNetworkManagerConnectionsDeleteOptionalParams
  extends coreClient.OperationOptions {}

/** Optional parameters. */
export interface ManagementGroupNetworkManagerConnectionsListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type ManagementGroupNetworkManagerConnectionsListResponse = NetworkManagerConnectionListResult;

/** Optional parameters. */
export interface ManagementGroupNetworkManagerConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type ManagementGroupNetworkManagerConnectionsListNextResponse = NetworkManagerConnectionListResult;

/** Optional parameters. */
export interface ConnectivityConfigurationsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ConnectivityConfigurationsGetResponse = ConnectivityConfiguration;

/** Optional parameters. */
export interface ConnectivityConfigurationsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type ConnectivityConfigurationsCreateOrUpdateResponse = ConnectivityConfiguration;

/** Optional parameters. */
export interface ConnectivityConfigurationsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete. */
  force?: boolean;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ConnectivityConfigurationsListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type ConnectivityConfigurationsListResponse = ConnectivityConfigurationListResult;

/** Optional parameters. */
export interface ConnectivityConfigurationsListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type ConnectivityConfigurationsListNextResponse = ConnectivityConfigurationListResult;

/** Optional parameters. */
export interface NetworkGroupsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type NetworkGroupsGetResponse = NetworkGroup;

/** Optional parameters. */
export interface NetworkGroupsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes. */
  ifMatch?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type NetworkGroupsCreateOrUpdateResponse = NetworkGroupsCreateOrUpdateHeaders &
  NetworkGroup;

/** Optional parameters. */
export interface NetworkGroupsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete. */
  force?: boolean;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NetworkGroupsListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type NetworkGroupsListResponse = NetworkGroupListResult;

/** Optional parameters. */
export interface NetworkGroupsListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type NetworkGroupsListNextResponse = NetworkGroupListResult;

/** Optional parameters. */
export interface StaticMembersGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type StaticMembersGetResponse = StaticMember;

/** Optional parameters. */
export interface StaticMembersCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type StaticMembersCreateOrUpdateResponse = StaticMember;

/** Optional parameters. */
export interface StaticMembersDeleteOptionalParams
  extends coreClient.OperationOptions {}

/** Optional parameters. */
export interface StaticMembersListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type StaticMembersListResponse = StaticMemberListResult;

/** Optional parameters. */
export interface StaticMembersListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type StaticMembersListNextResponse = StaticMemberListResult;

/** Optional parameters. */
export interface ScopeConnectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type ScopeConnectionsCreateOrUpdateResponse = ScopeConnection;

/** Optional parameters. */
export interface ScopeConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ScopeConnectionsGetResponse = ScopeConnection;

/** Optional parameters. */
export interface ScopeConnectionsDeleteOptionalParams
  extends coreClient.OperationOptions {}

/** Optional parameters. */
export interface ScopeConnectionsListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type ScopeConnectionsListResponse = ScopeConnectionListResult;

/** Optional parameters. */
export interface ScopeConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type ScopeConnectionsListNextResponse = ScopeConnectionListResult;

/** Optional parameters. */
export interface SecurityAdminConfigurationsListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type SecurityAdminConfigurationsListResponse = SecurityAdminConfigurationListResult;

/** Optional parameters. */
export interface SecurityAdminConfigurationsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type SecurityAdminConfigurationsGetResponse = SecurityAdminConfiguration;

/** Optional parameters. */
export interface SecurityAdminConfigurationsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type SecurityAdminConfigurationsCreateOrUpdateResponse = SecurityAdminConfiguration;

/** Optional parameters. */
export interface SecurityAdminConfigurationsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete. */
  force?: boolean;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface SecurityAdminConfigurationsListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type SecurityAdminConfigurationsListNextResponse = SecurityAdminConfigurationListResult;

/** Optional parameters. */
export interface AdminRuleCollectionsListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type AdminRuleCollectionsListResponse = AdminRuleCollectionListResult;

/** Optional parameters. */
export interface AdminRuleCollectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type AdminRuleCollectionsGetResponse = AdminRuleCollection;

/** Optional parameters. */
export interface AdminRuleCollectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type AdminRuleCollectionsCreateOrUpdateResponse = AdminRuleCollection;

/** Optional parameters. */
export interface AdminRuleCollectionsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete. */
  force?: boolean;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface AdminRuleCollectionsListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type AdminRuleCollectionsListNextResponse = AdminRuleCollectionListResult;

/** Optional parameters. */
export interface AdminRulesListOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the list operation. */
export type AdminRulesListResponse = AdminRuleListResult;

/** Optional parameters. */
export interface AdminRulesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type AdminRulesGetResponse = BaseAdminRuleUnion;

/** Optional parameters. */
export interface AdminRulesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type AdminRulesCreateOrUpdateResponse = BaseAdminRuleUnion;

/** Optional parameters. */
export interface AdminRulesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete. */
  force?: boolean;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface AdminRulesListNextOptionalParams
  extends coreClient.OperationOptions {
  /** An optional query parameter which specifies the maximum number of records to be returned by the server. */
  top?: number;
  /** SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls. */
  skipToken?: string;
}

/** Contains response data for the listNext operation. */
export type AdminRulesListNextResponse = AdminRuleListResult;

/** Optional parameters. */
export interface NetworkProfilesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NetworkProfilesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type NetworkProfilesGetResponse = NetworkProfile;

/** Optional parameters. */
export interface NetworkProfilesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type NetworkProfilesCreateOrUpdateResponse = NetworkProfile;

/** Optional parameters. */
export interface NetworkProfilesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type NetworkProfilesUpdateTagsResponse = NetworkProfile;

/** Optional parameters. */
export interface NetworkProfilesListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type NetworkProfilesListAllResponse = NetworkProfileListResult;

/** Optional parameters. */
export interface NetworkProfilesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NetworkProfilesListResponse = NetworkProfileListResult;

/** Optional parameters. */
export interface NetworkProfilesListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type NetworkProfilesListAllNextResponse = NetworkProfileListResult;

/** Optional parameters. */
export interface NetworkProfilesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type NetworkProfilesListNextResponse = NetworkProfileListResult;

/** Optional parameters. */
export interface NetworkSecurityGroupsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NetworkSecurityGroupsGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type NetworkSecurityGroupsGetResponse = NetworkSecurityGroup;

/** Optional parameters. */
export interface NetworkSecurityGroupsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type NetworkSecurityGroupsCreateOrUpdateResponse = NetworkSecurityGroup;

/** Optional parameters. */
export interface NetworkSecurityGroupsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type NetworkSecurityGroupsUpdateTagsResponse = NetworkSecurityGroup;

/** Optional parameters. */
export interface NetworkSecurityGroupsListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type NetworkSecurityGroupsListAllResponse = NetworkSecurityGroupListResult;

/** Optional parameters. */
export interface NetworkSecurityGroupsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NetworkSecurityGroupsListResponse = NetworkSecurityGroupListResult;

/** Optional parameters. */
export interface NetworkSecurityGroupsListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type NetworkSecurityGroupsListAllNextResponse = NetworkSecurityGroupListResult;

/** Optional parameters. */
export interface NetworkSecurityGroupsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type NetworkSecurityGroupsListNextResponse = NetworkSecurityGroupListResult;

/** Optional parameters. */
export interface SecurityRulesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface SecurityRulesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type SecurityRulesGetResponse = SecurityRule;

/** Optional parameters. */
export interface SecurityRulesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type SecurityRulesCreateOrUpdateResponse = SecurityRule;

/** Optional parameters. */
export interface SecurityRulesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type SecurityRulesListResponse = SecurityRuleListResult;

/** Optional parameters. */
export interface SecurityRulesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type SecurityRulesListNextResponse = SecurityRuleListResult;

/** Optional parameters. */
export interface DefaultSecurityRulesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type DefaultSecurityRulesListResponse = SecurityRuleListResult;

/** Optional parameters. */
export interface DefaultSecurityRulesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type DefaultSecurityRulesGetResponse = SecurityRule;

/** Optional parameters. */
export interface DefaultSecurityRulesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type DefaultSecurityRulesListNextResponse = SecurityRuleListResult;

/** Optional parameters. */
export interface NetworkVirtualAppliancesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NetworkVirtualAppliancesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type NetworkVirtualAppliancesGetResponse = NetworkVirtualAppliance;

/** Optional parameters. */
export interface NetworkVirtualAppliancesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type NetworkVirtualAppliancesUpdateTagsResponse = NetworkVirtualAppliance;

/** Optional parameters. */
export interface NetworkVirtualAppliancesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type NetworkVirtualAppliancesCreateOrUpdateResponse = NetworkVirtualAppliance;

/** Optional parameters. */
export interface NetworkVirtualAppliancesListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type NetworkVirtualAppliancesListByResourceGroupResponse = NetworkVirtualApplianceListResult;

/** Optional parameters. */
export interface NetworkVirtualAppliancesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NetworkVirtualAppliancesListResponse = NetworkVirtualApplianceListResult;

/** Optional parameters. */
export interface NetworkVirtualAppliancesListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type NetworkVirtualAppliancesListByResourceGroupNextResponse = NetworkVirtualApplianceListResult;

/** Optional parameters. */
export interface NetworkVirtualAppliancesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type NetworkVirtualAppliancesListNextResponse = NetworkVirtualApplianceListResult;

/** Optional parameters. */
export interface VirtualApplianceSitesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualApplianceSitesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualApplianceSitesGetResponse = VirtualApplianceSite;

/** Optional parameters. */
export interface VirtualApplianceSitesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualApplianceSitesCreateOrUpdateResponse = VirtualApplianceSite;

/** Optional parameters. */
export interface VirtualApplianceSitesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualApplianceSitesListResponse = NetworkVirtualApplianceSiteListResult;

/** Optional parameters. */
export interface VirtualApplianceSitesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualApplianceSitesListNextResponse = NetworkVirtualApplianceSiteListResult;

/** Optional parameters. */
export interface VirtualApplianceSkusListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualApplianceSkusListResponse = NetworkVirtualApplianceSkuListResult;

/** Optional parameters. */
export interface VirtualApplianceSkusGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualApplianceSkusGetResponse = NetworkVirtualApplianceSku;

/** Optional parameters. */
export interface VirtualApplianceSkusListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualApplianceSkusListNextResponse = NetworkVirtualApplianceSkuListResult;

/** Optional parameters. */
export interface InboundSecurityRuleCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type InboundSecurityRuleCreateOrUpdateResponse = InboundSecurityRule;

/** Optional parameters. */
export interface NetworkWatchersCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type NetworkWatchersCreateOrUpdateResponse = NetworkWatcher;

/** Optional parameters. */
export interface NetworkWatchersGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type NetworkWatchersGetResponse = NetworkWatcher;

/** Optional parameters. */
export interface NetworkWatchersDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NetworkWatchersUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type NetworkWatchersUpdateTagsResponse = NetworkWatcher;

/** Optional parameters. */
export interface NetworkWatchersListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type NetworkWatchersListResponse = NetworkWatcherListResult;

/** Optional parameters. */
export interface NetworkWatchersListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type NetworkWatchersListAllResponse = NetworkWatcherListResult;

/** Optional parameters. */
export interface NetworkWatchersGetTopologyOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getTopology operation. */
export type NetworkWatchersGetTopologyResponse = Topology;

/** Optional parameters. */
export interface NetworkWatchersVerifyIPFlowOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the verifyIPFlow operation. */
export type NetworkWatchersVerifyIPFlowResponse = VerificationIPFlowResult;

/** Optional parameters. */
export interface NetworkWatchersGetNextHopOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getNextHop operation. */
export type NetworkWatchersGetNextHopResponse = NextHopResult;

/** Optional parameters. */
export interface NetworkWatchersGetVMSecurityRulesOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getVMSecurityRules operation. */
export type NetworkWatchersGetVMSecurityRulesResponse = SecurityGroupViewResult;

/** Optional parameters. */
export interface NetworkWatchersGetTroubleshootingOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getTroubleshooting operation. */
export type NetworkWatchersGetTroubleshootingResponse = TroubleshootingResult;

/** Optional parameters. */
export interface NetworkWatchersGetTroubleshootingResultOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getTroubleshootingResult operation. */
export type NetworkWatchersGetTroubleshootingResultResponse = TroubleshootingResult;

/** Optional parameters. */
export interface NetworkWatchersSetFlowLogConfigurationOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the setFlowLogConfiguration operation. */
export type NetworkWatchersSetFlowLogConfigurationResponse = FlowLogInformation;

/** Optional parameters. */
export interface NetworkWatchersGetFlowLogStatusOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getFlowLogStatus operation. */
export type NetworkWatchersGetFlowLogStatusResponse = FlowLogInformation;

/** Optional parameters. */
export interface NetworkWatchersCheckConnectivityOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the checkConnectivity operation. */
export type NetworkWatchersCheckConnectivityResponse = ConnectivityInformation;

/** Optional parameters. */
export interface NetworkWatchersGetAzureReachabilityReportOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getAzureReachabilityReport operation. */
export type NetworkWatchersGetAzureReachabilityReportResponse = AzureReachabilityReport;

/** Optional parameters. */
export interface NetworkWatchersListAvailableProvidersOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listAvailableProviders operation. */
export type NetworkWatchersListAvailableProvidersResponse = AvailableProvidersList;

/** Optional parameters. */
export interface NetworkWatchersGetNetworkConfigurationDiagnosticOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getNetworkConfigurationDiagnostic operation. */
export type NetworkWatchersGetNetworkConfigurationDiagnosticResponse = NetworkConfigurationDiagnosticResponse;

/** Optional parameters. */
export interface PacketCapturesCreateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the create operation. */
export type PacketCapturesCreateResponse = PacketCaptureResult;

/** Optional parameters. */
export interface PacketCapturesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type PacketCapturesGetResponse = PacketCaptureResult;

/** Optional parameters. */
export interface PacketCapturesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface PacketCapturesStopOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface PacketCapturesGetStatusOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getStatus operation. */
export type PacketCapturesGetStatusResponse = PacketCaptureQueryStatusResult;

/** Optional parameters. */
export interface PacketCapturesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type PacketCapturesListResponse = PacketCaptureListResult;

/** Optional parameters. */
export interface ConnectionMonitorsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Value indicating whether connection monitor V1 should be migrated to V2 format. */
  migrate?: string;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ConnectionMonitorsCreateOrUpdateResponse = ConnectionMonitorResult;

/** Optional parameters. */
export interface ConnectionMonitorsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ConnectionMonitorsGetResponse = ConnectionMonitorResult;

/** Optional parameters. */
export interface ConnectionMonitorsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ConnectionMonitorsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type ConnectionMonitorsUpdateTagsResponse = ConnectionMonitorResult;

/** Optional parameters. */
export interface ConnectionMonitorsStopOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ConnectionMonitorsStartOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ConnectionMonitorsQueryOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the query operation. */
export type ConnectionMonitorsQueryResponse = ConnectionMonitorQueryResult;

/** Optional parameters. */
export interface ConnectionMonitorsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ConnectionMonitorsListResponse = ConnectionMonitorListResult;

/** Optional parameters. */
export interface FlowLogsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type FlowLogsCreateOrUpdateResponse = FlowLog;

/** Optional parameters. */
export interface FlowLogsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type FlowLogsUpdateTagsResponse = FlowLog;

/** Optional parameters. */
export interface FlowLogsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type FlowLogsGetResponse = FlowLog;

/** Optional parameters. */
export interface FlowLogsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface FlowLogsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type FlowLogsListResponse = FlowLogListResult;

/** Optional parameters. */
export interface FlowLogsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type FlowLogsListNextResponse = FlowLogListResult;

/** Optional parameters. */
export interface OperationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type OperationsListResponse = OperationListResult;

/** Optional parameters. */
export interface OperationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type OperationsListNextResponse = OperationListResult;

/** Optional parameters. */
export interface PrivateEndpointsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface PrivateEndpointsGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type PrivateEndpointsGetResponse = PrivateEndpoint;

/** Optional parameters. */
export interface PrivateEndpointsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type PrivateEndpointsCreateOrUpdateResponse = PrivateEndpoint;

/** Optional parameters. */
export interface PrivateEndpointsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type PrivateEndpointsListResponse = PrivateEndpointListResult;

/** Optional parameters. */
export interface PrivateEndpointsListBySubscriptionOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listBySubscription operation. */
export type PrivateEndpointsListBySubscriptionResponse = PrivateEndpointListResult;

/** Optional parameters. */
export interface PrivateEndpointsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type PrivateEndpointsListNextResponse = PrivateEndpointListResult;

/** Optional parameters. */
export interface PrivateEndpointsListBySubscriptionNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listBySubscriptionNext operation. */
export type PrivateEndpointsListBySubscriptionNextResponse = PrivateEndpointListResult;

/** Optional parameters. */
export interface AvailablePrivateEndpointTypesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type AvailablePrivateEndpointTypesListResponse = AvailablePrivateEndpointTypesResult;

/** Optional parameters. */
export interface AvailablePrivateEndpointTypesListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type AvailablePrivateEndpointTypesListByResourceGroupResponse = AvailablePrivateEndpointTypesResult;

/** Optional parameters. */
export interface AvailablePrivateEndpointTypesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type AvailablePrivateEndpointTypesListNextResponse = AvailablePrivateEndpointTypesResult;

/** Optional parameters. */
export interface AvailablePrivateEndpointTypesListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type AvailablePrivateEndpointTypesListByResourceGroupNextResponse = AvailablePrivateEndpointTypesResult;

/** Optional parameters. */
export interface PrivateDnsZoneGroupsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface PrivateDnsZoneGroupsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type PrivateDnsZoneGroupsGetResponse = PrivateDnsZoneGroup;

/** Optional parameters. */
export interface PrivateDnsZoneGroupsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type PrivateDnsZoneGroupsCreateOrUpdateResponse = PrivateDnsZoneGroup;

/** Optional parameters. */
export interface PrivateDnsZoneGroupsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type PrivateDnsZoneGroupsListResponse = PrivateDnsZoneGroupListResult;

/** Optional parameters. */
export interface PrivateDnsZoneGroupsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type PrivateDnsZoneGroupsListNextResponse = PrivateDnsZoneGroupListResult;

/** Optional parameters. */
export interface PrivateLinkServicesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface PrivateLinkServicesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type PrivateLinkServicesGetResponse = PrivateLinkService;

/** Optional parameters. */
export interface PrivateLinkServicesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type PrivateLinkServicesCreateOrUpdateResponse = PrivateLinkService;

/** Optional parameters. */
export interface PrivateLinkServicesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type PrivateLinkServicesListResponse = PrivateLinkServiceListResult;

/** Optional parameters. */
export interface PrivateLinkServicesListBySubscriptionOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listBySubscription operation. */
export type PrivateLinkServicesListBySubscriptionResponse = PrivateLinkServiceListResult;

/** Optional parameters. */
export interface PrivateLinkServicesGetPrivateEndpointConnectionOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the getPrivateEndpointConnection operation. */
export type PrivateLinkServicesGetPrivateEndpointConnectionResponse = PrivateEndpointConnection;

/** Optional parameters. */
export interface PrivateLinkServicesUpdatePrivateEndpointConnectionOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updatePrivateEndpointConnection operation. */
export type PrivateLinkServicesUpdatePrivateEndpointConnectionResponse = PrivateEndpointConnection;

/** Optional parameters. */
export interface PrivateLinkServicesDeletePrivateEndpointConnectionOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface PrivateLinkServicesListPrivateEndpointConnectionsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listPrivateEndpointConnections operation. */
export type PrivateLinkServicesListPrivateEndpointConnectionsResponse = PrivateEndpointConnectionListResult;

/** Optional parameters. */
export interface PrivateLinkServicesCheckPrivateLinkServiceVisibilityOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the checkPrivateLinkServiceVisibility operation. */
export type PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse = PrivateLinkServiceVisibility;

/** Optional parameters. */
export interface PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the checkPrivateLinkServiceVisibilityByResourceGroup operation. */
export type PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse = PrivateLinkServiceVisibility;

/** Optional parameters. */
export interface PrivateLinkServicesListAutoApprovedPrivateLinkServicesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAutoApprovedPrivateLinkServices operation. */
export type PrivateLinkServicesListAutoApprovedPrivateLinkServicesResponse = AutoApprovedPrivateLinkServicesResult;

/** Optional parameters. */
export interface PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAutoApprovedPrivateLinkServicesByResourceGroup operation. */
export type PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupResponse = AutoApprovedPrivateLinkServicesResult;

/** Optional parameters. */
export interface PrivateLinkServicesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type PrivateLinkServicesListNextResponse = PrivateLinkServiceListResult;

/** Optional parameters. */
export interface PrivateLinkServicesListBySubscriptionNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listBySubscriptionNext operation. */
export type PrivateLinkServicesListBySubscriptionNextResponse = PrivateLinkServiceListResult;

/** Optional parameters. */
export interface PrivateLinkServicesListPrivateEndpointConnectionsNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listPrivateEndpointConnectionsNext operation. */
export type PrivateLinkServicesListPrivateEndpointConnectionsNextResponse = PrivateEndpointConnectionListResult;

/** Optional parameters. */
export interface PrivateLinkServicesListAutoApprovedPrivateLinkServicesNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAutoApprovedPrivateLinkServicesNext operation. */
export type PrivateLinkServicesListAutoApprovedPrivateLinkServicesNextResponse = AutoApprovedPrivateLinkServicesResult;

/** Optional parameters. */
export interface PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAutoApprovedPrivateLinkServicesByResourceGroupNext operation. */
export type PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupNextResponse = AutoApprovedPrivateLinkServicesResult;

/** Optional parameters. */
export interface PublicIPPrefixesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface PublicIPPrefixesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type PublicIPPrefixesGetResponse = PublicIPPrefix;

/** Optional parameters. */
export interface PublicIPPrefixesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type PublicIPPrefixesCreateOrUpdateResponse = PublicIPPrefix;

/** Optional parameters. */
export interface PublicIPPrefixesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type PublicIPPrefixesUpdateTagsResponse = PublicIPPrefix;

/** Optional parameters. */
export interface PublicIPPrefixesListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type PublicIPPrefixesListAllResponse = PublicIPPrefixListResult;

/** Optional parameters. */
export interface PublicIPPrefixesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type PublicIPPrefixesListResponse = PublicIPPrefixListResult;

/** Optional parameters. */
export interface PublicIPPrefixesListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type PublicIPPrefixesListAllNextResponse = PublicIPPrefixListResult;

/** Optional parameters. */
export interface PublicIPPrefixesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type PublicIPPrefixesListNextResponse = PublicIPPrefixListResult;

/** Optional parameters. */
export interface RouteFiltersDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface RouteFiltersGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced express route bgp peering resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type RouteFiltersGetResponse = RouteFilter;

/** Optional parameters. */
export interface RouteFiltersCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type RouteFiltersCreateOrUpdateResponse = RouteFilter;

/** Optional parameters. */
export interface RouteFiltersUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type RouteFiltersUpdateTagsResponse = RouteFilter;

/** Optional parameters. */
export interface RouteFiltersListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type RouteFiltersListByResourceGroupResponse = RouteFilterListResult;

/** Optional parameters. */
export interface RouteFiltersListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type RouteFiltersListResponse = RouteFilterListResult;

/** Optional parameters. */
export interface RouteFiltersListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type RouteFiltersListByResourceGroupNextResponse = RouteFilterListResult;

/** Optional parameters. */
export interface RouteFiltersListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type RouteFiltersListNextResponse = RouteFilterListResult;

/** Optional parameters. */
export interface RouteFilterRulesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface RouteFilterRulesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type RouteFilterRulesGetResponse = RouteFilterRule;

/** Optional parameters. */
export interface RouteFilterRulesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type RouteFilterRulesCreateOrUpdateResponse = RouteFilterRule;

/** Optional parameters. */
export interface RouteFilterRulesListByRouteFilterOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByRouteFilter operation. */
export type RouteFilterRulesListByRouteFilterResponse = RouteFilterRuleListResult;

/** Optional parameters. */
export interface RouteFilterRulesListByRouteFilterNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByRouteFilterNext operation. */
export type RouteFilterRulesListByRouteFilterNextResponse = RouteFilterRuleListResult;

/** Optional parameters. */
export interface RouteTablesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface RouteTablesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type RouteTablesGetResponse = RouteTable;

/** Optional parameters. */
export interface RouteTablesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type RouteTablesCreateOrUpdateResponse = RouteTable;

/** Optional parameters. */
export interface RouteTablesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type RouteTablesUpdateTagsResponse = RouteTable;

/** Optional parameters. */
export interface RouteTablesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type RouteTablesListResponse = RouteTableListResult;

/** Optional parameters. */
export interface RouteTablesListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type RouteTablesListAllResponse = RouteTableListResult;

/** Optional parameters. */
export interface RouteTablesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type RouteTablesListNextResponse = RouteTableListResult;

/** Optional parameters. */
export interface RouteTablesListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type RouteTablesListAllNextResponse = RouteTableListResult;

/** Optional parameters. */
export interface RoutesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface RoutesGetOptionalParams extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type RoutesGetResponse = Route;

/** Optional parameters. */
export interface RoutesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type RoutesCreateOrUpdateResponse = Route;

/** Optional parameters. */
export interface RoutesListOptionalParams extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type RoutesListResponse = RouteListResult;

/** Optional parameters. */
export interface RoutesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type RoutesListNextResponse = RouteListResult;

/** Optional parameters. */
export interface SecurityPartnerProvidersDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface SecurityPartnerProvidersGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type SecurityPartnerProvidersGetResponse = SecurityPartnerProvider;

/** Optional parameters. */
export interface SecurityPartnerProvidersCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type SecurityPartnerProvidersCreateOrUpdateResponse = SecurityPartnerProvider;

/** Optional parameters. */
export interface SecurityPartnerProvidersUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type SecurityPartnerProvidersUpdateTagsResponse = SecurityPartnerProvider;

/** Optional parameters. */
export interface SecurityPartnerProvidersListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type SecurityPartnerProvidersListByResourceGroupResponse = SecurityPartnerProviderListResult;

/** Optional parameters. */
export interface SecurityPartnerProvidersListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type SecurityPartnerProvidersListResponse = SecurityPartnerProviderListResult;

/** Optional parameters. */
export interface SecurityPartnerProvidersListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type SecurityPartnerProvidersListByResourceGroupNextResponse = SecurityPartnerProviderListResult;

/** Optional parameters. */
export interface SecurityPartnerProvidersListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type SecurityPartnerProvidersListNextResponse = SecurityPartnerProviderListResult;

/** Optional parameters. */
export interface BgpServiceCommunitiesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type BgpServiceCommunitiesListResponse = BgpServiceCommunityListResult;

/** Optional parameters. */
export interface BgpServiceCommunitiesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type BgpServiceCommunitiesListNextResponse = BgpServiceCommunityListResult;

/** Optional parameters. */
export interface ServiceEndpointPoliciesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ServiceEndpointPoliciesGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type ServiceEndpointPoliciesGetResponse = ServiceEndpointPolicy;

/** Optional parameters. */
export interface ServiceEndpointPoliciesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ServiceEndpointPoliciesCreateOrUpdateResponse = ServiceEndpointPolicy;

/** Optional parameters. */
export interface ServiceEndpointPoliciesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type ServiceEndpointPoliciesUpdateTagsResponse = ServiceEndpointPolicy;

/** Optional parameters. */
export interface ServiceEndpointPoliciesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ServiceEndpointPoliciesListResponse = ServiceEndpointPolicyListResult;

/** Optional parameters. */
export interface ServiceEndpointPoliciesListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type ServiceEndpointPoliciesListByResourceGroupResponse = ServiceEndpointPolicyListResult;

/** Optional parameters. */
export interface ServiceEndpointPoliciesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type ServiceEndpointPoliciesListNextResponse = ServiceEndpointPolicyListResult;

/** Optional parameters. */
export interface ServiceEndpointPoliciesListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type ServiceEndpointPoliciesListByResourceGroupNextResponse = ServiceEndpointPolicyListResult;

/** Optional parameters. */
export interface ServiceEndpointPolicyDefinitionsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ServiceEndpointPolicyDefinitionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ServiceEndpointPolicyDefinitionsGetResponse = ServiceEndpointPolicyDefinition;

/** Optional parameters. */
export interface ServiceEndpointPolicyDefinitionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ServiceEndpointPolicyDefinitionsCreateOrUpdateResponse = ServiceEndpointPolicyDefinition;

/** Optional parameters. */
export interface ServiceEndpointPolicyDefinitionsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type ServiceEndpointPolicyDefinitionsListByResourceGroupResponse = ServiceEndpointPolicyDefinitionListResult;

/** Optional parameters. */
export interface ServiceEndpointPolicyDefinitionsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type ServiceEndpointPolicyDefinitionsListByResourceGroupNextResponse = ServiceEndpointPolicyDefinitionListResult;

/** Optional parameters. */
export interface ServiceTagsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ServiceTagsListResponse = ServiceTagsListResult;

/** Optional parameters. */
export interface ServiceTagInformationListOptionalParams
  extends coreClient.OperationOptions {
  /** Do not return address prefixes for the tag(s). */
  noAddressPrefixes?: boolean;
  /** Return tag information for a particular tag. */
  tagName?: string;
}

/** Contains response data for the list operation. */
export type ServiceTagInformationListResponse = ServiceTagInformationListResult;

/** Optional parameters. */
export interface ServiceTagInformationListNextOptionalParams
  extends coreClient.OperationOptions {
  /** Do not return address prefixes for the tag(s). */
  noAddressPrefixes?: boolean;
  /** Return tag information for a particular tag. */
  tagName?: string;
}

/** Contains response data for the listNext operation. */
export type ServiceTagInformationListNextResponse = ServiceTagInformationListResult;

/** Optional parameters. */
export interface UsagesListOptionalParams extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type UsagesListResponse = UsagesListResult;

/** Optional parameters. */
export interface UsagesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type UsagesListNextResponse = UsagesListResult;

/** Optional parameters. */
export interface VirtualNetworksDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualNetworksGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type VirtualNetworksGetResponse = VirtualNetwork;

/** Optional parameters. */
export interface VirtualNetworksCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualNetworksCreateOrUpdateResponse = VirtualNetwork;

/** Optional parameters. */
export interface VirtualNetworksUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type VirtualNetworksUpdateTagsResponse = VirtualNetwork;

/** Optional parameters. */
export interface VirtualNetworksListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type VirtualNetworksListAllResponse = VirtualNetworkListResult;

/** Optional parameters. */
export interface VirtualNetworksListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualNetworksListResponse = VirtualNetworkListResult;

/** Optional parameters. */
export interface VirtualNetworksCheckIPAddressAvailabilityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the checkIPAddressAvailability operation. */
export type VirtualNetworksCheckIPAddressAvailabilityResponse = IPAddressAvailabilityResult;

/** Optional parameters. */
export interface VirtualNetworksListUsageOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listUsage operation. */
export type VirtualNetworksListUsageResponse = VirtualNetworkListUsageResult;

/** Optional parameters. */
export interface VirtualNetworksListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type VirtualNetworksListAllNextResponse = VirtualNetworkListResult;

/** Optional parameters. */
export interface VirtualNetworksListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualNetworksListNextResponse = VirtualNetworkListResult;

/** Optional parameters. */
export interface VirtualNetworksListUsageNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listUsageNext operation. */
export type VirtualNetworksListUsageNextResponse = VirtualNetworkListUsageResult;

/** Optional parameters. */
export interface SubnetsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface SubnetsGetOptionalParams extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type SubnetsGetResponse = Subnet;

/** Optional parameters. */
export interface SubnetsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type SubnetsCreateOrUpdateResponse = Subnet;

/** Optional parameters. */
export interface SubnetsPrepareNetworkPoliciesOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface SubnetsUnprepareNetworkPoliciesOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface SubnetsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type SubnetsListResponse = SubnetListResult;

/** Optional parameters. */
export interface SubnetsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type SubnetsListNextResponse = SubnetListResult;

/** Optional parameters. */
export interface ResourceNavigationLinksListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ResourceNavigationLinksListResponse = ResourceNavigationLinksListResult;

/** Optional parameters. */
export interface ServiceAssociationLinksListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ServiceAssociationLinksListResponse = ServiceAssociationLinksListResult;

/** Optional parameters. */
export interface VirtualNetworkPeeringsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualNetworkPeeringsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualNetworkPeeringsGetResponse = VirtualNetworkPeering;

/** Optional parameters. */
export interface VirtualNetworkPeeringsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Parameter indicates the intention to sync the peering with the current address space on the remote vNet after it's updated. */
  syncRemoteAddressSpace?: SyncRemoteAddressSpace;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualNetworkPeeringsCreateOrUpdateResponse = VirtualNetworkPeering;

/** Optional parameters. */
export interface VirtualNetworkPeeringsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualNetworkPeeringsListResponse = VirtualNetworkPeeringListResult;

/** Optional parameters. */
export interface VirtualNetworkPeeringsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualNetworkPeeringsListNextResponse = VirtualNetworkPeeringListResult;

/** Optional parameters. */
export interface VirtualNetworkGatewaysCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualNetworkGatewaysCreateOrUpdateResponse = VirtualNetworkGateway;

/** Optional parameters. */
export interface VirtualNetworkGatewaysGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualNetworkGatewaysGetResponse = VirtualNetworkGateway;

/** Optional parameters. */
export interface VirtualNetworkGatewaysDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualNetworkGatewaysUpdateTagsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the updateTags operation. */
export type VirtualNetworkGatewaysUpdateTagsResponse = VirtualNetworkGateway;

/** Optional parameters. */
export interface VirtualNetworkGatewaysListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualNetworkGatewaysListResponse = VirtualNetworkGatewayListResult;

/** Optional parameters. */
export interface VirtualNetworkGatewaysListConnectionsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listConnections operation. */
export type VirtualNetworkGatewaysListConnectionsResponse = VirtualNetworkGatewayListConnectionsResult;

/** Optional parameters. */
export interface VirtualNetworkGatewaysResetOptionalParams
  extends coreClient.OperationOptions {
  /** Virtual network gateway vip address supplied to the begin reset of the active-active feature enabled gateway. */
  gatewayVip?: string;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the reset operation. */
export type VirtualNetworkGatewaysResetResponse = VirtualNetworkGateway;

/** Optional parameters. */
export interface VirtualNetworkGatewaysResetVpnClientSharedKeyOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualNetworkGatewaysGeneratevpnclientpackageOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the generatevpnclientpackage operation. */
export type VirtualNetworkGatewaysGeneratevpnclientpackageResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewaysGenerateVpnProfileOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the generateVpnProfile operation. */
export type VirtualNetworkGatewaysGenerateVpnProfileResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewaysGetVpnProfilePackageUrlOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getVpnProfilePackageUrl operation. */
export type VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewaysGetBgpPeerStatusOptionalParams
  extends coreClient.OperationOptions {
  /** The IP address of the peer to retrieve the status of. */
  peer?: string;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getBgpPeerStatus operation. */
export type VirtualNetworkGatewaysGetBgpPeerStatusResponse = BgpPeerStatusListResult;

/** Optional parameters. */
export interface VirtualNetworkGatewaysSupportedVpnDevicesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the supportedVpnDevices operation. */
export type VirtualNetworkGatewaysSupportedVpnDevicesResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewaysGetLearnedRoutesOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getLearnedRoutes operation. */
export type VirtualNetworkGatewaysGetLearnedRoutesResponse = GatewayRouteListResult;

/** Optional parameters. */
export interface VirtualNetworkGatewaysGetAdvertisedRoutesOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getAdvertisedRoutes operation. */
export type VirtualNetworkGatewaysGetAdvertisedRoutesResponse = GatewayRouteListResult;

/** Optional parameters. */
export interface VirtualNetworkGatewaysSetVpnclientIpsecParametersOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the setVpnclientIpsecParameters operation. */
export type VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse = VpnClientIPsecParameters;

/** Optional parameters. */
export interface VirtualNetworkGatewaysGetVpnclientIpsecParametersOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getVpnclientIpsecParameters operation. */
export type VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse = VpnClientIPsecParameters;

/** Optional parameters. */
export interface VirtualNetworkGatewaysVpnDeviceConfigurationScriptOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the vpnDeviceConfigurationScript operation. */
export type VirtualNetworkGatewaysVpnDeviceConfigurationScriptResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewaysStartPacketCaptureOptionalParams
  extends coreClient.OperationOptions {
  /** Virtual network gateway packet capture parameters supplied to start packet capture on gateway. */
  parameters?: VpnPacketCaptureStartParameters;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the startPacketCapture operation. */
export type VirtualNetworkGatewaysStartPacketCaptureResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewaysStopPacketCaptureOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the stopPacketCapture operation. */
export type VirtualNetworkGatewaysStopPacketCaptureResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewaysGetVpnclientConnectionHealthOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getVpnclientConnectionHealth operation. */
export type VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse = VpnClientConnectionHealthDetailListResult;

/** Optional parameters. */
export interface VirtualNetworkGatewaysDisconnectVirtualNetworkGatewayVpnConnectionsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualNetworkGatewaysListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualNetworkGatewaysListNextResponse = VirtualNetworkGatewayListResult;

/** Optional parameters. */
export interface VirtualNetworkGatewaysListConnectionsNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listConnectionsNext operation. */
export type VirtualNetworkGatewaysListConnectionsNextResponse = VirtualNetworkGatewayListConnectionsResult;

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualNetworkGatewayConnectionsCreateOrUpdateResponse = VirtualNetworkGatewayConnection;

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualNetworkGatewayConnectionsGetResponse = VirtualNetworkGatewayConnection;

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the updateTags operation. */
export type VirtualNetworkGatewayConnectionsUpdateTagsResponse = VirtualNetworkGatewayConnection;

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsSetSharedKeyOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the setSharedKey operation. */
export type VirtualNetworkGatewayConnectionsSetSharedKeyResponse = ConnectionSharedKey;

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsGetSharedKeyOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getSharedKey operation. */
export type VirtualNetworkGatewayConnectionsGetSharedKeyResponse = ConnectionSharedKey;

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualNetworkGatewayConnectionsListResponse = VirtualNetworkGatewayConnectionListResult;

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsResetSharedKeyOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the resetSharedKey operation. */
export type VirtualNetworkGatewayConnectionsResetSharedKeyResponse = ConnectionResetSharedKey;

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsStartPacketCaptureOptionalParams
  extends coreClient.OperationOptions {
  /** Virtual network gateway packet capture parameters supplied to start packet capture on gateway connection. */
  parameters?: VpnPacketCaptureStartParameters;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the startPacketCapture operation. */
export type VirtualNetworkGatewayConnectionsStartPacketCaptureResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsStopPacketCaptureOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the stopPacketCapture operation. */
export type VirtualNetworkGatewayConnectionsStopPacketCaptureResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsGetIkeSasOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getIkeSas operation. */
export type VirtualNetworkGatewayConnectionsGetIkeSasResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsResetConnectionOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualNetworkGatewayConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualNetworkGatewayConnectionsListNextResponse = VirtualNetworkGatewayConnectionListResult;

/** Optional parameters. */
export interface LocalNetworkGatewaysCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type LocalNetworkGatewaysCreateOrUpdateResponse = LocalNetworkGateway;

/** Optional parameters. */
export interface LocalNetworkGatewaysGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type LocalNetworkGatewaysGetResponse = LocalNetworkGateway;

/** Optional parameters. */
export interface LocalNetworkGatewaysDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface LocalNetworkGatewaysUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type LocalNetworkGatewaysUpdateTagsResponse = LocalNetworkGateway;

/** Optional parameters. */
export interface LocalNetworkGatewaysListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type LocalNetworkGatewaysListResponse = LocalNetworkGatewayListResult;

/** Optional parameters. */
export interface LocalNetworkGatewaysListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type LocalNetworkGatewaysListNextResponse = LocalNetworkGatewayListResult;

/** Optional parameters. */
export interface VirtualNetworkGatewayNatRulesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualNetworkGatewayNatRulesGetResponse = VirtualNetworkGatewayNatRule;

/** Optional parameters. */
export interface VirtualNetworkGatewayNatRulesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualNetworkGatewayNatRulesCreateOrUpdateResponse = VirtualNetworkGatewayNatRule;

/** Optional parameters. */
export interface VirtualNetworkGatewayNatRulesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVirtualNetworkGateway operation. */
export type VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayResponse = ListVirtualNetworkGatewayNatRulesResult;

/** Optional parameters. */
export interface VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVirtualNetworkGatewayNext operation. */
export type VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayNextResponse = ListVirtualNetworkGatewayNatRulesResult;

/** Optional parameters. */
export interface VirtualNetworkTapsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualNetworkTapsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualNetworkTapsGetResponse = VirtualNetworkTap;

/** Optional parameters. */
export interface VirtualNetworkTapsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualNetworkTapsCreateOrUpdateResponse = VirtualNetworkTap;

/** Optional parameters. */
export interface VirtualNetworkTapsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type VirtualNetworkTapsUpdateTagsResponse = VirtualNetworkTap;

/** Optional parameters. */
export interface VirtualNetworkTapsListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type VirtualNetworkTapsListAllResponse = VirtualNetworkTapListResult;

/** Optional parameters. */
export interface VirtualNetworkTapsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type VirtualNetworkTapsListByResourceGroupResponse = VirtualNetworkTapListResult;

/** Optional parameters. */
export interface VirtualNetworkTapsListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type VirtualNetworkTapsListAllNextResponse = VirtualNetworkTapListResult;

/** Optional parameters. */
export interface VirtualNetworkTapsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type VirtualNetworkTapsListByResourceGroupNextResponse = VirtualNetworkTapListResult;

/** Optional parameters. */
export interface VirtualRoutersDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualRoutersGetOptionalParams
  extends coreClient.OperationOptions {
  /** Expands referenced resources. */
  expand?: string;
}

/** Contains response data for the get operation. */
export type VirtualRoutersGetResponse = VirtualRouter;

/** Optional parameters. */
export interface VirtualRoutersCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualRoutersCreateOrUpdateResponse = VirtualRouter;

/** Optional parameters. */
export interface VirtualRoutersListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type VirtualRoutersListByResourceGroupResponse = VirtualRouterListResult;

/** Optional parameters. */
export interface VirtualRoutersListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualRoutersListResponse = VirtualRouterListResult;

/** Optional parameters. */
export interface VirtualRoutersListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type VirtualRoutersListByResourceGroupNextResponse = VirtualRouterListResult;

/** Optional parameters. */
export interface VirtualRoutersListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualRoutersListNextResponse = VirtualRouterListResult;

/** Optional parameters. */
export interface VirtualRouterPeeringsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualRouterPeeringsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualRouterPeeringsGetResponse = VirtualRouterPeering;

/** Optional parameters. */
export interface VirtualRouterPeeringsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualRouterPeeringsCreateOrUpdateResponse = VirtualRouterPeering;

/** Optional parameters. */
export interface VirtualRouterPeeringsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualRouterPeeringsListResponse = VirtualRouterPeeringListResult;

/** Optional parameters. */
export interface VirtualRouterPeeringsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualRouterPeeringsListNextResponse = VirtualRouterPeeringListResult;

/** Optional parameters. */
export interface VirtualWansGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualWansGetResponse = VirtualWAN;

/** Optional parameters. */
export interface VirtualWansCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualWansCreateOrUpdateResponse = VirtualWAN;

/** Optional parameters. */
export interface VirtualWansUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type VirtualWansUpdateTagsResponse = VirtualWAN;

/** Optional parameters. */
export interface VirtualWansDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualWansListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type VirtualWansListByResourceGroupResponse = ListVirtualWANsResult;

/** Optional parameters. */
export interface VirtualWansListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualWansListResponse = ListVirtualWANsResult;

/** Optional parameters. */
export interface VirtualWansListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type VirtualWansListByResourceGroupNextResponse = ListVirtualWANsResult;

/** Optional parameters. */
export interface VirtualWansListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualWansListNextResponse = ListVirtualWANsResult;

/** Optional parameters. */
export interface VpnSitesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VpnSitesGetResponse = VpnSite;

/** Optional parameters. */
export interface VpnSitesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VpnSitesCreateOrUpdateResponse = VpnSite;

/** Optional parameters. */
export interface VpnSitesUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type VpnSitesUpdateTagsResponse = VpnSite;

/** Optional parameters. */
export interface VpnSitesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VpnSitesListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type VpnSitesListByResourceGroupResponse = ListVpnSitesResult;

/** Optional parameters. */
export interface VpnSitesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VpnSitesListResponse = ListVpnSitesResult;

/** Optional parameters. */
export interface VpnSitesListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type VpnSitesListByResourceGroupNextResponse = ListVpnSitesResult;

/** Optional parameters. */
export interface VpnSitesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VpnSitesListNextResponse = ListVpnSitesResult;

/** Optional parameters. */
export interface VpnSiteLinksGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VpnSiteLinksGetResponse = VpnSiteLink;

/** Optional parameters. */
export interface VpnSiteLinksListByVpnSiteOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnSite operation. */
export type VpnSiteLinksListByVpnSiteResponse = ListVpnSiteLinksResult;

/** Optional parameters. */
export interface VpnSiteLinksListByVpnSiteNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnSiteNext operation. */
export type VpnSiteLinksListByVpnSiteNextResponse = ListVpnSiteLinksResult;

/** Optional parameters. */
export interface VpnSitesConfigurationDownloadOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VpnServerConfigurationsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VpnServerConfigurationsGetResponse = VpnServerConfiguration;

/** Optional parameters. */
export interface VpnServerConfigurationsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VpnServerConfigurationsCreateOrUpdateResponse = VpnServerConfiguration;

/** Optional parameters. */
export interface VpnServerConfigurationsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type VpnServerConfigurationsUpdateTagsResponse = VpnServerConfiguration;

/** Optional parameters. */
export interface VpnServerConfigurationsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VpnServerConfigurationsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type VpnServerConfigurationsListByResourceGroupResponse = ListVpnServerConfigurationsResult;

/** Optional parameters. */
export interface VpnServerConfigurationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VpnServerConfigurationsListResponse = ListVpnServerConfigurationsResult;

/** Optional parameters. */
export interface VpnServerConfigurationsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type VpnServerConfigurationsListByResourceGroupNextResponse = ListVpnServerConfigurationsResult;

/** Optional parameters. */
export interface VpnServerConfigurationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VpnServerConfigurationsListNextResponse = ListVpnServerConfigurationsResult;

/** Optional parameters. */
export interface ConfigurationPolicyGroupsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ConfigurationPolicyGroupsCreateOrUpdateResponse = VpnServerConfigurationPolicyGroup;

/** Optional parameters. */
export interface ConfigurationPolicyGroupsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ConfigurationPolicyGroupsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ConfigurationPolicyGroupsGetResponse = VpnServerConfigurationPolicyGroup;

/** Optional parameters. */
export interface ConfigurationPolicyGroupsListByVpnServerConfigurationOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnServerConfiguration operation. */
export type ConfigurationPolicyGroupsListByVpnServerConfigurationResponse = ListVpnServerConfigurationPolicyGroupsResult;

/** Optional parameters. */
export interface ConfigurationPolicyGroupsListByVpnServerConfigurationNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnServerConfigurationNext operation. */
export type ConfigurationPolicyGroupsListByVpnServerConfigurationNextResponse = ListVpnServerConfigurationPolicyGroupsResult;

/** Optional parameters. */
export interface VirtualHubsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualHubsGetResponse = VirtualHub;

/** Optional parameters. */
export interface VirtualHubsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualHubsCreateOrUpdateResponse = VirtualHub;

/** Optional parameters. */
export interface VirtualHubsUpdateTagsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateTags operation. */
export type VirtualHubsUpdateTagsResponse = VirtualHub;

/** Optional parameters. */
export interface VirtualHubsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualHubsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type VirtualHubsListByResourceGroupResponse = ListVirtualHubsResult;

/** Optional parameters. */
export interface VirtualHubsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualHubsListResponse = ListVirtualHubsResult;

/** Optional parameters. */
export interface VirtualHubsGetEffectiveVirtualHubRoutesOptionalParams
  extends coreClient.OperationOptions {
  /** Parameters supplied to get the effective routes for a specific resource. */
  effectiveRoutesParameters?: EffectiveRoutesParameters;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualHubsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type VirtualHubsListByResourceGroupNextResponse = ListVirtualHubsResult;

/** Optional parameters. */
export interface VirtualHubsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualHubsListNextResponse = ListVirtualHubsResult;

/** Optional parameters. */
export interface HubVirtualNetworkConnectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type HubVirtualNetworkConnectionsCreateOrUpdateResponse = HubVirtualNetworkConnection;

/** Optional parameters. */
export interface HubVirtualNetworkConnectionsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface HubVirtualNetworkConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type HubVirtualNetworkConnectionsGetResponse = HubVirtualNetworkConnection;

/** Optional parameters. */
export interface HubVirtualNetworkConnectionsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type HubVirtualNetworkConnectionsListResponse = ListHubVirtualNetworkConnectionsResult;

/** Optional parameters. */
export interface HubVirtualNetworkConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type HubVirtualNetworkConnectionsListNextResponse = ListHubVirtualNetworkConnectionsResult;

/** Optional parameters. */
export interface VpnGatewaysGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VpnGatewaysGetResponse = VpnGateway;

/** Optional parameters. */
export interface VpnGatewaysCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VpnGatewaysCreateOrUpdateResponse = VpnGateway;

/** Optional parameters. */
export interface VpnGatewaysUpdateTagsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the updateTags operation. */
export type VpnGatewaysUpdateTagsResponse = VpnGateway;

/** Optional parameters. */
export interface VpnGatewaysDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VpnGatewaysResetOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the reset operation. */
export type VpnGatewaysResetResponse = VpnGateway;

/** Optional parameters. */
export interface VpnGatewaysStartPacketCaptureOptionalParams
  extends coreClient.OperationOptions {
  /** Vpn gateway packet capture parameters supplied to start packet capture on vpn gateway. */
  parameters?: VpnGatewayPacketCaptureStartParameters;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the startPacketCapture operation. */
export type VpnGatewaysStartPacketCaptureResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VpnGatewaysStopPacketCaptureOptionalParams
  extends coreClient.OperationOptions {
  /** Vpn gateway packet capture parameters supplied to stop packet capture on vpn gateway. */
  parameters?: VpnGatewayPacketCaptureStopParameters;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the stopPacketCapture operation. */
export type VpnGatewaysStopPacketCaptureResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VpnGatewaysListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type VpnGatewaysListByResourceGroupResponse = ListVpnGatewaysResult;

/** Optional parameters. */
export interface VpnGatewaysListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VpnGatewaysListResponse = ListVpnGatewaysResult;

/** Optional parameters. */
export interface VpnGatewaysListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type VpnGatewaysListByResourceGroupNextResponse = ListVpnGatewaysResult;

/** Optional parameters. */
export interface VpnGatewaysListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VpnGatewaysListNextResponse = ListVpnGatewaysResult;

/** Optional parameters. */
export interface VpnLinkConnectionsResetConnectionOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VpnLinkConnectionsGetIkeSasOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getIkeSas operation. */
export type VpnLinkConnectionsGetIkeSasResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VpnLinkConnectionsListByVpnConnectionOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnConnection operation. */
export type VpnLinkConnectionsListByVpnConnectionResponse = ListVpnSiteLinkConnectionsResult;

/** Optional parameters. */
export interface VpnLinkConnectionsListByVpnConnectionNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnConnectionNext operation. */
export type VpnLinkConnectionsListByVpnConnectionNextResponse = ListVpnSiteLinkConnectionsResult;

/** Optional parameters. */
export interface VpnConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VpnConnectionsGetResponse = VpnConnection;

/** Optional parameters. */
export interface VpnConnectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VpnConnectionsCreateOrUpdateResponse = VpnConnection;

/** Optional parameters. */
export interface VpnConnectionsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VpnConnectionsStartPacketCaptureOptionalParams
  extends coreClient.OperationOptions {
  /** Vpn Connection packet capture parameters supplied to start packet capture on gateway connection. */
  parameters?: VpnConnectionPacketCaptureStartParameters;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the startPacketCapture operation. */
export type VpnConnectionsStartPacketCaptureResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VpnConnectionsStopPacketCaptureOptionalParams
  extends coreClient.OperationOptions {
  /** Vpn Connection packet capture parameters supplied to stop packet capture on gateway connection. */
  parameters?: VpnConnectionPacketCaptureStopParameters;
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the stopPacketCapture operation. */
export type VpnConnectionsStopPacketCaptureResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VpnConnectionsListByVpnGatewayOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnGateway operation. */
export type VpnConnectionsListByVpnGatewayResponse = ListVpnConnectionsResult;

/** Optional parameters. */
export interface VpnConnectionsListByVpnGatewayNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnGatewayNext operation. */
export type VpnConnectionsListByVpnGatewayNextResponse = ListVpnConnectionsResult;

/** Optional parameters. */
export interface VpnSiteLinkConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VpnSiteLinkConnectionsGetResponse = VpnSiteLinkConnection;

/** Optional parameters. */
export interface NatRulesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type NatRulesGetResponse = VpnGatewayNatRule;

/** Optional parameters. */
export interface NatRulesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type NatRulesCreateOrUpdateResponse = VpnGatewayNatRule;

/** Optional parameters. */
export interface NatRulesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface NatRulesListByVpnGatewayOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnGateway operation. */
export type NatRulesListByVpnGatewayResponse = ListVpnGatewayNatRulesResult;

/** Optional parameters. */
export interface NatRulesListByVpnGatewayNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByVpnGatewayNext operation. */
export type NatRulesListByVpnGatewayNextResponse = ListVpnGatewayNatRulesResult;

/** Optional parameters. */
export interface P2SVpnGatewaysGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type P2SVpnGatewaysGetResponse = P2SVpnGateway;

/** Optional parameters. */
export interface P2SVpnGatewaysCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type P2SVpnGatewaysCreateOrUpdateResponse = P2SVpnGateway;

/** Optional parameters. */
export interface P2SVpnGatewaysUpdateTagsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the updateTags operation. */
export type P2SVpnGatewaysUpdateTagsResponse = P2SVpnGateway;

/** Optional parameters. */
export interface P2SVpnGatewaysDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface P2SVpnGatewaysListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type P2SVpnGatewaysListByResourceGroupResponse = ListP2SVpnGatewaysResult;

/** Optional parameters. */
export interface P2SVpnGatewaysListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type P2SVpnGatewaysListResponse = ListP2SVpnGatewaysResult;

/** Optional parameters. */
export interface P2SVpnGatewaysResetOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the reset operation. */
export type P2SVpnGatewaysResetResponse = P2SVpnGateway;

/** Optional parameters. */
export interface P2SVpnGatewaysGenerateVpnProfileOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the generateVpnProfile operation. */
export type P2SVpnGatewaysGenerateVpnProfileResponse = VpnProfileResponse;

/** Optional parameters. */
export interface P2SVpnGatewaysGetP2SVpnConnectionHealthOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getP2SVpnConnectionHealth operation. */
export type P2SVpnGatewaysGetP2SVpnConnectionHealthResponse = P2SVpnGateway;

/** Optional parameters. */
export interface P2SVpnGatewaysGetP2SVpnConnectionHealthDetailedOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the getP2SVpnConnectionHealthDetailed operation. */
export type P2SVpnGatewaysGetP2SVpnConnectionHealthDetailedResponse = P2SVpnConnectionHealth;

/** Optional parameters. */
export interface P2SVpnGatewaysDisconnectP2SVpnConnectionsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface P2SVpnGatewaysListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type P2SVpnGatewaysListByResourceGroupNextResponse = ListP2SVpnGatewaysResult;

/** Optional parameters. */
export interface P2SVpnGatewaysListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type P2SVpnGatewaysListNextResponse = ListP2SVpnGatewaysResult;

/** Optional parameters. */
export interface VpnServerConfigurationsAssociatedWithVirtualWanListOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the list operation. */
export type VpnServerConfigurationsAssociatedWithVirtualWanListResponse = VpnServerConfigurationsResponse;

/** Optional parameters. */
export interface VirtualHubRouteTableV2SGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualHubRouteTableV2SGetResponse = VirtualHubRouteTableV2;

/** Optional parameters. */
export interface VirtualHubRouteTableV2SCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualHubRouteTableV2SCreateOrUpdateResponse = VirtualHubRouteTableV2;

/** Optional parameters. */
export interface VirtualHubRouteTableV2SDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualHubRouteTableV2SListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualHubRouteTableV2SListResponse = ListVirtualHubRouteTableV2SResult;

/** Optional parameters. */
export interface VirtualHubRouteTableV2SListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualHubRouteTableV2SListNextResponse = ListVirtualHubRouteTableV2SResult;

/** Optional parameters. */
export interface ExpressRouteGatewaysListBySubscriptionOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listBySubscription operation. */
export type ExpressRouteGatewaysListBySubscriptionResponse = ExpressRouteGatewayList;

/** Optional parameters. */
export interface ExpressRouteGatewaysListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type ExpressRouteGatewaysListByResourceGroupResponse = ExpressRouteGatewayList;

/** Optional parameters. */
export interface ExpressRouteGatewaysCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRouteGatewaysCreateOrUpdateResponse = ExpressRouteGateway;

/** Optional parameters. */
export interface ExpressRouteGatewaysUpdateTagsOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the updateTags operation. */
export type ExpressRouteGatewaysUpdateTagsResponse = ExpressRouteGateway;

/** Optional parameters. */
export interface ExpressRouteGatewaysGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRouteGatewaysGetResponse = ExpressRouteGateway;

/** Optional parameters. */
export interface ExpressRouteGatewaysDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ExpressRouteConnectionsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type ExpressRouteConnectionsCreateOrUpdateResponse = ExpressRouteConnection;

/** Optional parameters. */
export interface ExpressRouteConnectionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type ExpressRouteConnectionsGetResponse = ExpressRouteConnection;

/** Optional parameters. */
export interface ExpressRouteConnectionsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface ExpressRouteConnectionsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type ExpressRouteConnectionsListResponse = ExpressRouteConnectionList;

/** Optional parameters. */
export interface VirtualHubBgpConnectionGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualHubBgpConnectionGetResponse = BgpConnection;

/** Optional parameters. */
export interface VirtualHubBgpConnectionCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualHubBgpConnectionCreateOrUpdateResponse = BgpConnection;

/** Optional parameters. */
export interface VirtualHubBgpConnectionDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualHubBgpConnectionsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualHubBgpConnectionsListResponse = ListVirtualHubBgpConnectionResults;

/** Optional parameters. */
export interface VirtualHubBgpConnectionsListLearnedRoutesOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listLearnedRoutes operation. */
export type VirtualHubBgpConnectionsListLearnedRoutesResponse = PeerRouteList;

/** Optional parameters. */
export interface VirtualHubBgpConnectionsListAdvertisedRoutesOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the listAdvertisedRoutes operation. */
export type VirtualHubBgpConnectionsListAdvertisedRoutesResponse = PeerRouteList;

/** Optional parameters. */
export interface VirtualHubBgpConnectionsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualHubBgpConnectionsListNextResponse = ListVirtualHubBgpConnectionResults;

/** Optional parameters. */
export interface VirtualHubIpConfigurationGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VirtualHubIpConfigurationGetResponse = HubIpConfiguration;

/** Optional parameters. */
export interface VirtualHubIpConfigurationCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type VirtualHubIpConfigurationCreateOrUpdateResponse = HubIpConfiguration;

/** Optional parameters. */
export interface VirtualHubIpConfigurationDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VirtualHubIpConfigurationListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VirtualHubIpConfigurationListResponse = ListVirtualHubIpConfigurationResults;

/** Optional parameters. */
export interface VirtualHubIpConfigurationListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type VirtualHubIpConfigurationListNextResponse = ListVirtualHubIpConfigurationResults;

/** Optional parameters. */
export interface HubRouteTablesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type HubRouteTablesCreateOrUpdateResponse = HubRouteTable;

/** Optional parameters. */
export interface HubRouteTablesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type HubRouteTablesGetResponse = HubRouteTable;

/** Optional parameters. */
export interface HubRouteTablesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface HubRouteTablesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type HubRouteTablesListResponse = ListHubRouteTablesResult;

/** Optional parameters. */
export interface HubRouteTablesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type HubRouteTablesListNextResponse = ListHubRouteTablesResult;

/** Optional parameters. */
export interface RoutingIntentCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type RoutingIntentCreateOrUpdateResponse = RoutingIntent;

/** Optional parameters. */
export interface RoutingIntentGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type RoutingIntentGetResponse = RoutingIntent;

/** Optional parameters. */
export interface RoutingIntentDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface RoutingIntentListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type RoutingIntentListResponse = ListRoutingIntentResult;

/** Optional parameters. */
export interface RoutingIntentListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type RoutingIntentListNextResponse = ListRoutingIntentResult;

/** Optional parameters. */
export interface WebApplicationFirewallPoliciesListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type WebApplicationFirewallPoliciesListResponse = WebApplicationFirewallPolicyListResult;

/** Optional parameters. */
export interface WebApplicationFirewallPoliciesListAllOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAll operation. */
export type WebApplicationFirewallPoliciesListAllResponse = WebApplicationFirewallPolicyListResult;

/** Optional parameters. */
export interface WebApplicationFirewallPoliciesGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type WebApplicationFirewallPoliciesGetResponse = WebApplicationFirewallPolicy;

/** Optional parameters. */
export interface WebApplicationFirewallPoliciesCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createOrUpdate operation. */
export type WebApplicationFirewallPoliciesCreateOrUpdateResponse = WebApplicationFirewallPolicy;

/** Optional parameters. */
export interface WebApplicationFirewallPoliciesDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface WebApplicationFirewallPoliciesListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type WebApplicationFirewallPoliciesListNextResponse = WebApplicationFirewallPolicyListResult;

/** Optional parameters. */
export interface WebApplicationFirewallPoliciesListAllNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAllNext operation. */
export type WebApplicationFirewallPoliciesListAllNextResponse = WebApplicationFirewallPolicyListResult;

/** Optional parameters. */
export interface VipSwapGetOptionalParams extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VipSwapGetResponse = SwapResource;

/** Optional parameters. */
export interface VipSwapCreateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Optional parameters. */
export interface VipSwapListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type VipSwapListResponse = SwapResourceListResult;

/** Optional parameters. */
export interface NetworkManagementClientOptionalParams
  extends coreClient.ServiceClientOptions {
  /** server parameter */
  $host?: string;
  /** Overrides client endpoint. */
  endpoint?: string;
}
