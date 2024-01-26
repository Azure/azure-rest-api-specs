import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace PaloAltoNetworks.Cloudngfw;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Rulestack Type
 */
enum ScopeType {
  LOCAL,
  GLOBAL,
}

/**
 * Type for Default Mode for rules creation
 */
enum DefaultMode {
  IPS,
  FIREWALL,
  NONE,
}

/**
 * Provisioning state of the firewall resource.
 */
enum ProvisioningState {
  Accepted,
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
  Deleted,
  NotSpecified,
}

/**
 * Type of the managed identity.
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * Boolean Enum
 */
enum BooleanEnum {
  TRUE,
  FALSE,
}

enum AdvSecurityObjectTypeEnum {
  urlCustom,
  feeds,
}

enum SecurityServicesTypeEnum {
  antiSpyware,
  antiVirus,
  ipsVulnerability,
  urlFiltering,
  fileBlocking,
  dnsSubscription,
}

/**
 * Enabled or Disabled Enum
 */
enum StateEnum {
  DISABLED,
  ENABLED,
}

enum ActionEnum {
  Allow,
  DenySilent,
  DenyResetServer,
  DenyResetBoth,
}

enum DecryptionRuleTypeEnum {
  SSLOutboundInspection,
  SSLInboundInspection,
  None,
}

/**
 * NetworkType Enum
 */
enum NetworkType {
  VNET,
  VWAN,
}

/**
 * Egress NAT
 */
enum EgressNat {
  DISABLED,
  ENABLED,
}

/**
 * DNS Proxy
 */
enum DNSProxy {
  DISABLED,
  ENABLED,
}

/**
 * Enabled DNS type values
 */
enum EnabledDNSType {
  CUSTOM,
  AZURE,
}

/**
 * Protocol Enum
 */
enum ProtocolType {
  TCP,
  UDP,
}

/**
 * Usage Type
 */
enum UsageType {
  PAYG,
  COMMITTED,
}

/**
 * Billing cycle
 */
enum BillingCycle {
  WEEKLY,
  MONTHLY,
}

/**
 * Marketplace Subscription Status
 */
enum MarketplaceSubscriptionStatus {
  PendingFulfillmentStart,
  Subscribed,
  Suspended,
  Unsubscribed,
  NotStarted,
  FulfillmentRequested,
}

/**
 * Possible log types
 */
enum LogType {
  TRAFFIC,
  THREAT,
  DECRYPTION,
  WILDFIRE,
  DLP,
  AUDIT,
}

/**
 * Log options possible
 */
enum LogOption {
  SAME_DESTINATION,
  INDIVIDUAL_DESTINATION,
}

/**
 * Status Codes for the Firewall
 */
enum HealthStatus {
  GREEN,
  YELLOW,
  RED,
  INITIALIZING,
}

/**
 * Connectivity Status for Panorama Server
 */
enum ServerStatus {
  UP,
  DOWN,
}

/**
 * Provisioning state of the firewall resource.
 */
enum ReadOnlyProvisioningState {
  Succeeded,
  Failed,
  Deleted,
}

/**
 * PAN Rulestack Describe Object
 */
model RulestackProperties {
  /**
   * PanEtag info
   */
  panEtag?: string;

  /**
   * Rulestack Location, Required for GlobalRulestacks, Not for LocalRulestacks
   */
  panLocation?: string;

  /**
   * Rulestack Type
   */
  scope?: ScopeType;

  /**
   * subscription scope of global rulestack
   */
  associatedSubscriptions?: string[];

  /**
   * rulestack description
   */
  description?: string;

  /**
   * Mode for default rules creation
   */
  defaultMode?: DefaultMode;

  /**
   * minimum version
   */
  minAppIdVersion?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Security Profile
   */
  securityServices?: SecurityServices;
}

/**
 * security services
 */
model SecurityServices {
  /**
   * IPs Vulnerability Profile Data
   */
  vulnerabilityProfile?: string;

  /**
   * Anti spyware Profile data
   */
  antiSpywareProfile?: string;

  /**
   * anti virus profile data
   */
  antiVirusProfile?: string;

  /**
   * URL filtering profile data
   */
  urlFilteringProfile?: string;

  /**
   * File blocking profile data
   */
  fileBlockingProfile?: string;

  /**
   * DNS Subscription profile data
   */
  dnsSubscription?: string;

  /**
   * Untrusted Egress Decryption profile data
   */
  outboundUnTrustCertificate?: string;

  /**
   * Trusted Egress Decryption profile data
   */
  outboundTrustCertificate?: string;
}

/**
 * The properties of the managed service identities assigned to this resource.
 */
model AzureResourceManagerManagedIdentityProperties {
  /**
   * The Active Directory tenant id of the principal.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The active directory identifier of this principal.
   */
  @visibility("read")
  principalId?: string;

  /**
   * Type of the managed identity.
   */
  type: ManagedServiceIdentityType;

  /**
   * The identities assigned to this resource by the user.
   */
  userAssignedIdentities?: Record<AzureResourceManagerUserAssignedIdentity>;
}

/**
 * A managed identity assigned by the user.
 */
model AzureResourceManagerUserAssignedIdentity {
  /**
   * The active directory client identifier for this principal.
   */
  clientId?: string;

  /**
   * The active directory identifier for this principal.
   */
  principalId?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

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
 * The type used for update operations of the GlobalRulestackResource.
 */
model GlobalRulestackResourceUpdate {
  /**
   * Global Location
   */
  location?: string;

  /**
   * The managed service identities assigned to this resource.
   */
  identity?: AzureResourceManagerManagedIdentityProperties;

  /**
   * The updatable properties of the GlobalRulestackResource.
   */
  properties?: GlobalRulestackResourceUpdateProperties;
}

/**
 * The updatable properties of the GlobalRulestackResource.
 */
model GlobalRulestackResourceUpdateProperties {
  /**
   * PanEtag info
   */
  panEtag?: string;

  /**
   * Rulestack Location, Required for GlobalRulestacks, Not for LocalRulestacks
   */
  panLocation?: string;

  /**
   * Rulestack Type
   */
  scope?: ScopeType;

  /**
   * subscription scope of global rulestack
   */
  associatedSubscriptions?: string[];

  /**
   * rulestack description
   */
  description?: string;

  /**
   * Mode for default rules creation
   */
  defaultMode?: DefaultMode;

  /**
   * minimum version
   */
  minAppIdVersion?: string;

  /**
   * Security Profile
   */
  securityServices?: SecurityServices;
}

/**
 * certificate used for inbound and outbound decryption
 */
model CertificateObject {
  /**
   * Resource Id of certificate signer, to be populated only when certificateSelfSigned is false
   */
  certificateSignerResourceId?: string;

  /**
   * use certificate self signed
   */
  certificateSelfSigned: BooleanEnum;

  /**
   * comment for this object
   */
  auditComment?: string;

  /**
   * user description for this object
   */
  description?: string;

  /**
   * read only string representing last create or update
   */
  etag?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * fqdn object
 */
model FqdnObject {
  /**
   * fqdn object description
   */
  description?: string;

  /**
   * fqdn list
   */
  fqdnList: string[];

  /**
   * etag info
   */
  etag?: string;

  /**
   * comment for this object
   */
  auditComment?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Changelog list
 */
model Changelog {
  /**
   * list of changes
   */
  changes: string[];

  /**
   * lastCommitted timestamp
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCommitted?: utcDateTime;

  /**
   * lastModified timestamp
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;
}

/**
 * advanced security object
 */
model AdvSecurityObjectListResponse {
  /**
   * response value
   */
  value: AdvSecurityObjectModel;

  /**
   * next link
   */
  nextLink?: string;
}

/**
 * List of custom and predefined url category
 */
model AdvSecurityObjectModel {
  /**
   * type of object
   */
  type?: string;

  /**
   * URL entry
   */
  entry: NameDescriptionObject[];
}

/**
 * object type info
 */
model NameDescriptionObject {
  /**
   * name value
   */
  name: string;

  /**
   * description value
   */
  description?: string;
}

model ListAppIdResponse {
  /**
   * List of AppIds
   */
  value: string[];

  /**
   * next Link
   */
  nextLink?: string;
}

/**
 * Countries Response Object
 */
model CountriesResponse {
  /**
   * List of countries
   */
  value: Country[];

  /**
   * next link
   */
  nextLink?: string;
}

/**
 * Country Description
 */
model Country {
  /**
   * country code
   */
  code: string;

  /**
   * code description
   */
  description?: string;
}

/**
 * List firewalls response
 */
model ListFirewallsResponse {
  /**
   * firewalls list
   */
  value: string[];

  /**
   * next link
   */
  nextLink?: string;
}

/**
 * predefined url categories response
 */
model PredefinedUrlCategoriesResponse {
  /**
   * predefined url categories
   */
  value: PredefinedUrlCategory[];

  /**
   * next link
   */
  nextLink?: string;
}

/**
 * Predefined URL category object
 */
model PredefinedUrlCategory {
  action: string;
  name: string;
}

/**
 * Security services list response
 */
model SecurityServicesResponse {
  /**
   * response value
   */
  value: SecurityServicesTypeList;

  /**
   * next link
   */
  nextLink?: string;
}

/**
 * Security services type list
 */
model SecurityServicesTypeList {
  /**
   * security services type
   */
  type?: string;

  /**
   * list
   */
  entry: NameDescriptionObject[];
}

/**
 * definition of rule
 */
model RuleEntry {
  /**
   * etag info
   */
  etag?: string;

  /**
   * rule name
   */
  ruleName: string;

  @visibility("read")
  priority?: int32;

  /**
   * rule description
   */
  description?: string;

  /**
   * state of this rule
   */
  ruleState?: StateEnum;

  /**
   * source address
   */
  source?: SourceAddr;

  /**
   * cidr should not be 'any'
   */
  negateSource?: BooleanEnum;

  /**
   * destination address
   */
  destination?: DestinationAddr;

  /**
   * cidr should not be 'any'
   */
  negateDestination?: BooleanEnum;

  /**
   * array of rule applications
   */
  applications?: string[];

  /**
   * rule category
   */
  category?: Category;

  /**
   * any, application-default, TCP:number, UDP:number
   */
  protocol?: string = "application-default";

  /**
   * prot port list
   */
  protocolPortList?: string[];

  /**
   * inbound Inspection Certificate
   */
  inboundInspectionCertificate?: string;

  /**
   * rule comment
   */
  auditComment?: string;

  /**
   * rule action
   */
  actionType?: ActionEnum;

  /**
   * enable or disable logging
   */
  enableLogging?: StateEnum;

  /**
   * enable or disable decryption
   */
  decryptionRuleType?: DecryptionRuleTypeEnum;

  /**
   * tag for rule
   */
  tags?: TagInfo[];

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Address properties
 */
model SourceAddr {
  /**
   * special value 'any'
   */
  cidrs?: string[];

  /**
   * list of countries
   */
  countries?: string[];

  /**
   * list of feeds
   */
  feeds?: string[];

  /**
   * prefix list
   */
  prefixLists?: string[];
}

/**
 * destination address
 */
model DestinationAddr {
  /**
   * special value 'any'
   */
  cidrs?: string[];

  /**
   * list of countries
   */
  countries?: string[];

  /**
   * list of feeds
   */
  feeds?: string[];

  /**
   * prefix list
   */
  prefixLists?: string[];

  /**
   * fqdn list
   */
  fqdnLists?: string[];
}

/**
 * URL/EDL to match
 */
model Category {
  /**
   * custom URL
   */
  urlCustom: string[];

  /**
   * feed list
   */
  feeds: string[];
}

/**
 * Tag
 */
model TagInfo {
  /**
   * tag name
   */
  key: string;

  /**
   * tag value
   */
  value: string;
}

/**
 * Rule counter
 */
model RuleCounter {
  /**
   * priority number
   */
  priority: string;

  /**
   * rule Stack Name
   */
  ruleStackName?: string;

  /**
   * rule list name
   */
  ruleListName?: string;

  /**
   * firewall name
   */
  firewallName?: string;

  /**
   * rule name
   */
  ruleName: string;

  /**
   * hit count
   */
  hitCount?: int32;

  /**
   * apps seen
   */
  appSeen?: AppSeenData;

  /**
   * timestamp of response
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * timestamp of request
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestTimestamp?: utcDateTime;

  /**
   * last updated timestamp
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;
}

/**
 * Data Type for App Seen
 */
model AppSeenData {
  /**
   * number of rows
   */
  count: int32;

  /**
   * array of appSeen
   */
  appSeenList: AppSeenInfo[];
}

/**
 * Definition for App Seen
 */
model AppSeenInfo {
  /**
   * title
   */
  title: string;

  /**
   * category
   */
  category: string;

  /**
   * subCategory
   */
  subCategory: string;

  /**
   * risk
   */
  risk: string;

  /**
   * tag
   */
  tag: string;

  /**
   * technology
   */
  technology: string;

  /**
   * standardPorts
   */
  standardPorts: string;
}

/**
 * Rule counter reset
 */
model RuleCounterReset {
  /**
   * priority number
   */
  @visibility("read")
  priority?: string;

  /**
   * rule Stack Name
   */
  ruleStackName?: string;

  /**
   * rule list name
   */
  ruleListName?: string;

  /**
   * firewall name
   */
  firewallName?: string;

  /**
   * rule name
   */
  ruleName?: string;
}

/**
 * prefix entry
 */
model PrefixObject {
  /**
   * prefix description
   */
  description?: string;

  /**
   * prefix list
   */
  prefixList: string[];

  /**
   * etag info
   */
  etag?: string;

  /**
   * comment for this object
   */
  auditComment?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Properties specific to the Firewall resource deployment.
 */
model FirewallDeploymentProperties {
  /**
   * panEtag info
   */
  panEtag?: string;

  /**
   * Network settings
   */
  networkProfile: NetworkProfile;

  /**
   * Panorama Managed: Default is False. Default will be CloudSec managed
   */
  isPanoramaManaged?: BooleanEnum;

  /**
   * Panorama Configuration
   */
  panoramaConfig?: PanoramaConfig;

  /**
   * Associated Rulestack
   */
  associatedRulestack?: RulestackDetails;

  /**
   * DNS settings for Firewall
   */
  dnsSettings: DNSSettings;

  /**
   * Frontend settings for Firewall
   */
  frontEndSettings?: FrontendSetting[];

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Billing plan information.
   */
  planData: PlanData;

  /**
   * Marketplace details
   */
  marketplaceDetails: MarketplaceDetails;
}

/**
 * Network settings for Firewall
 */
model NetworkProfile {
  /**
   * Vnet configurations
   */
  vnetConfiguration?: VnetConfiguration;

  /**
   * Vwan configurations
   */
  vwanConfiguration?: VwanConfiguration;

  /**
   * vnet or vwan, cannot be updated
   */
  networkType: NetworkType;

  /**
   * List of IPs associated with the Firewall
   */
  publicIps: IPAddress[];

  /**
   * Enable egress NAT, enabled by default
   */
  enableEgressNat: EgressNat;

  /**
   * Egress nat IP to use
   */
  egressNatIp?: IPAddress[];

  /**
   * Non-RFC 1918 address
   */
  trustedRanges?: string[];
}

/**
 * VnetInfo for Firewall Networking
 */
model VnetConfiguration {
  /**
   * Azure Virtual Network
   */
  vnet: IPAddressSpace;

  /**
   * Trust Subnet
   */
  trustSubnet: IPAddressSpace;

  /**
   * Untrust Subnet
   */
  unTrustSubnet: IPAddressSpace;

  /**
   * IP of trust subnet for UDR
   */
  ipOfTrustSubnetForUdr?: IPAddress;
}

/**
 * IP Address Space
 */
model IPAddressSpace {
  /**
   * Resource Id
   */
  resourceId?: string;

  /**
   * Address Space
   */
  addressSpace?: string;
}

/**
 * IP Address
 */
model IPAddress {
  /**
   * Resource Id
   */
  resourceId?: string;

  /**
   * Address value
   */
  address?: string;
}

/**
 * VwanInfo for Firewall Networking
 */
model VwanConfiguration {
  /**
   * Network Virtual Appliance resource ID
   */
  networkVirtualApplianceId?: string;

  /**
   * vHub Address
   */
  vHub: IPAddressSpace;

  /**
   * Trust Subnet
   */
  trustSubnet?: IPAddressSpace;

  /**
   * Untrust Subnet
   */
  unTrustSubnet?: IPAddressSpace;

  /**
   * IP of trust subnet for UDR
   */
  ipOfTrustSubnetForUdr?: IPAddress;
}

/**
 * Panorama Config
 */
model PanoramaConfig {
  /**
   * Base64 encoded string representing Panorama parameters to be used by Firewall to connect to Panorama. This string is generated via azure plugin in Panorama
   */
  configString: string;

  /**
   * VM auth key for panorama connectivity
   */
  @visibility("read")
  vmAuthKey?: string;

  /**
   * Primary Panorama Server IP address value in dotted format for IPv4
   */
  @visibility("read")
  panoramaServer?: string;

  /**
   * Secondary Panorama Server IP address value in dotted format for IPv4
   */
  @visibility("read")
  panoramaServer2?: string;

  /**
   * Panorama Device Group to join
   */
  @visibility("read")
  dgName?: string;

  /**
   * Panorama Template Stack to join - (Once configured we can not edit the value)
   */
  @visibility("read")
  tplName?: string;

  /**
   * Panorama Collector Group to join - (Once configured we can not edit the value)
   */
  @visibility("read")
  cgName?: string;

  /**
   * Resource name(may be unique) for PN admin
   */
  @visibility("read")
  hostName?: string;
}

/**
 * Associated rulestack details
 */
model RulestackDetails {
  /**
   * Resource Id
   */
  resourceId?: string;

  /**
   * Associated rulestack Id
   */
  rulestackId?: string;

  /**
   * Rulestack location
   */
  location?: string;
}

/**
 * DNS Proxy settings for Firewall
 */
model DNSSettings {
  /**
   * Enable DNS proxy, disabled by default
   */
  enableDnsProxy?: DNSProxy;

  /**
   * Enabled DNS proxy type, disabled by default
   */
  enabledDnsType?: EnabledDNSType;

  /**
   * List of IPs associated with the Firewall
   */
  dnsServers?: IPAddress[];
}

/**
 * Frontend setting for Firewall
 */
model FrontendSetting {
  /**
   * Settings name
   */
  name: string;

  /**
   * Protocol Type
   */
  protocol: ProtocolType;

  /**
   * Frontend configurations
   */
  frontendConfiguration: EndpointConfiguration;

  /**
   * Backend configurations
   */
  backendConfiguration: EndpointConfiguration;
}

/**
 * Endpoint Configuration for frontend and backend
 */
model EndpointConfiguration {
  /**
   * port ID
   */
  port: string;

  /**
   * Address Space
   */
  address: IPAddress;
}

/**
 * Billing plan information.
 */
model PlanData {
  /**
   * different usage type like PAYG/COMMITTED
   */
  usageType?: UsageType;

  /**
   * different billing cycles like MONTHLY/WEEKLY
   */
  billingCycle: BillingCycle;

  /**
   * plan id as published by Liftr.PAN
   */
  @maxLength(50)
  planId: string;

  /**
   * date when plan was applied
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;
}

/**
 * MarketplaceDetails of PAN Firewall resource
 */
model MarketplaceDetails {
  /**
   * Marketplace Subscription Id
   */
  @visibility("read")
  marketplaceSubscriptionId?: string;

  /**
   * Offer Id
   */
  offerId: string;

  /**
   * Publisher Id
   */
  publisherId: string;

  /**
   * Marketplace Subscription Status
   */
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;
}

/**
 * The type used for update operations of the FirewallResource.
 */
model FirewallResourceUpdate {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: AzureResourceManagerManagedIdentityProperties;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The updatable properties of the FirewallResource.
   */
  properties?: FirewallResourceUpdateProperties;
}

/**
 * The updatable properties of the FirewallResource.
 */
model FirewallResourceUpdateProperties {
  /**
   * panEtag info
   */
  panEtag?: string;

  /**
   * Network settings
   */
  networkProfile?: NetworkProfile;

  /**
   * Panorama Managed: Default is False. Default will be CloudSec managed
   */
  isPanoramaManaged?: BooleanEnum;

  /**
   * Panorama Configuration
   */
  panoramaConfig?: PanoramaConfig;

  /**
   * Associated Rulestack
   */
  associatedRulestack?: RulestackDetails;

  /**
   * DNS settings for Firewall
   */
  dnsSettings?: DNSSettings;

  /**
   * Frontend settings for Firewall
   */
  frontEndSettings?: FrontendSetting[];

  /**
   * Billing plan information.
   */
  planData?: PlanData;

  /**
   * Marketplace details
   */
  marketplaceDetails?: MarketplaceDetails;
}

/**
 * PAN Rulestack Describe Object
 */
model GlobalRulestackInfo {
  /**
   * rulestack description
   */
  azureId: string;
}

/**
 * Log Settings for Firewall
 */
model LogSettings {
  /**
   * One of possible log type
   */
  logType?: LogType;

  /**
   * Log option SAME/INDIVIDUAL
   */
  logOption?: LogOption;

  /**
   * Application Insight details
   */
  applicationInsights?: ApplicationInsights;

  /**
   * Common destination configurations
   */
  commonDestination?: LogDestination;

  /**
   * Traffic destination configurations
   */
  trafficLogDestination?: LogDestination;

  /**
   * Threat destination configurations
   */
  threatLogDestination?: LogDestination;

  /**
   * Decrypt destination configurations
   */
  decryptLogDestination?: LogDestination;
}

/**
 * Application Insights key
 */
model ApplicationInsights {
  /**
   * Resource id for Application Insights
   */
  id?: string;

  /**
   * Application Insights key
   */
  key?: string;
}

/**
 * Log Destination
 */
model LogDestination {
  /**
   * Storage account configurations
   */
  storageConfigurations?: StorageAccount;

  /**
   * Event Hub configurations
   */
  eventHubConfigurations?: EventHub;

  /**
   * Monitor Log configurations
   */
  monitorConfigurations?: MonitorLog;
}

/**
 * Storage Account configurations
 */
model StorageAccount {
  /**
   * Resource ID of storage account
   */
  id?: string;

  /**
   * Subscription Id
   */
  subscriptionId?: string;

  /**
   * Storage account name
   */
  accountName?: string;
}

/**
 * EventHub configurations
 */
model EventHub {
  /**
   * Resource ID of EventHub
   */
  id?: string;

  /**
   * Subscription Id
   */
  subscriptionId?: string;

  /**
   * EventHub name
   */
  name?: string;

  /**
   * EventHub namespace
   */
  nameSpace?: string;

  /**
   * EventHub policy name
   */
  policyName?: string;
}

/**
 * MonitorLog configurations
 */
model MonitorLog {
  /**
   * Resource ID of MonitorLog
   */
  id?: string;

  /**
   * Subscription Id
   */
  subscriptionId?: string;

  /**
   * MonitorLog workspace
   */
  workspace?: string;

  /**
   * Primary Key value for Monitor
   */
  primaryKey?: string;

  /**
   * Secondary Key value for Monitor
   */
  secondaryKey?: string;
}

/**
 * Support information for the resource
 */
model SupportInfo {
  /**
   * product SKU associated with given resource
   */
  productSku?: string;

  /**
   * product Serial associated with given resource
   */
  productSerial?: string;

  /**
   * account registered in Customer Support Portal
   */
  accountRegistered?: BooleanEnum;

  /**
   * Support account associated with given resource
   */
  accountId?: string;

  /**
   * user domain is supported in Customer Support Portal
   */
  userDomainSupported?: BooleanEnum;

  /**
   * user registered in Customer Support Portal
   */
  userRegistered?: BooleanEnum;

  /**
   * Product usage is in free trial period
   */
  freeTrial?: BooleanEnum;

  /**
   * Free trial days remaining
   */
  freeTrialDaysLeft?: int32;

  /**
   * Free trial credit remaining
   */
  freeTrialCreditLeft?: int32;

  /**
   * URL for paloaltonetworks live community
   */
  helpURL?: string;

  /**
   * URL for paloaltonetworks Customer Service Portal
   */
  supportURL?: string;

  /**
   * URL for registering product in paloaltonetworks Customer Service Portal
   */
  registerURL?: string;
}

/**
 * Firewall Status
 */
model FirewallStatusProperty {
  /**
   * Panorama Managed: Default is False. Default will be CloudSec managed
   */
  @visibility("read")
  isPanoramaManaged?: BooleanEnum;

  /**
   * Current status of the Firewall
   */
  @visibility("read")
  healthStatus?: HealthStatus;

  /**
   * Detail description of current health of the Firewall
   */
  @visibility("read")
  healthReason?: string;

  /**
   * Panorama Status
   */
  @visibility("read")
  panoramaStatus?: PanoramaStatus;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ReadOnlyProvisioningState;
}

/**
 * Panorama connectivity information
 */
model PanoramaStatus {
  /**
   * Primary Panorama connection status
   */
  @visibility("read")
  panoramaServerStatus?: ServerStatus;

  /**
   * Secondary Panorama connection status
   */
  @visibility("read")
  panoramaServer2Status?: ServerStatus;
}

/**
 * The type used for update operations of the LocalRulestackResource.
 */
model LocalRulestackResourceUpdate {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: AzureResourceManagerManagedIdentityProperties;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The updatable properties of the LocalRulestackResource.
   */
  properties?: LocalRulestackResourceUpdateProperties;
}

/**
 * The updatable properties of the LocalRulestackResource.
 */
model LocalRulestackResourceUpdateProperties {
  /**
   * PanEtag info
   */
  panEtag?: string;

  /**
   * Rulestack Location, Required for GlobalRulestacks, Not for LocalRulestacks
   */
  panLocation?: string;

  /**
   * Rulestack Type
   */
  scope?: ScopeType;

  /**
   * subscription scope of global rulestack
   */
  associatedSubscriptions?: string[];

  /**
   * rulestack description
   */
  description?: string;

  /**
   * Mode for default rules creation
   */
  defaultMode?: DefaultMode;

  /**
   * minimum version
   */
  minAppIdVersion?: string;

  /**
   * Security Profile
   */
  securityServices?: SecurityServices;
}
