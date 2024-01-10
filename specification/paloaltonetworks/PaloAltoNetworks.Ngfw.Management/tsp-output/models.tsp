import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace PaloAltoNetworks.Cloudngfw;

interface Operations extends Azure.ResourceManager.Operations {}

enum ScopeType {
  LOCAL,
  GLOBAL,
}

enum DefaultMode {
  IPS,
  FIREWALL,
  NONE,
}

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

enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

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

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum NetworkType {
  VNET,
  VWAN,
}

enum EgressNat {
  DISABLED,
  ENABLED,
}

enum DNSProxy {
  DISABLED,
  ENABLED,
}

enum EnabledDNSType {
  CUSTOM,
  AZURE,
}

enum ProtocolType {
  TCP,
  UDP,
}

enum UsageType {
  PAYG,
  COMMITTED,
}

enum BillingCycle {
  WEEKLY,
  MONTHLY,
}

enum MarketplaceSubscriptionStatus {
  PendingFulfillmentStart,
  Subscribed,
  Suspended,
  Unsubscribed,
  NotStarted,
  FulfillmentRequested,
}

enum LogType {
  TRAFFIC,
  THREAT,
  DECRYPTION,
  WILDFIRE,
  DLP,
  AUDIT,
}

enum LogOption {
  SAME_DESTINATION,
  INDIVIDUAL_DESTINATION,
}

enum HealthStatus {
  GREEN,
  YELLOW,
  RED,
  INITIALIZING,
}

enum ServerStatus {
  UP,
  DOWN,
}

enum ReadOnlyProvisioningState {
  Succeeded,
  Failed,
  Deleted,
}

enum ManagedIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  SystemAndUserAssigned: "SystemAssigned,UserAssigned",
}

@doc("PAN Rulestack Describe Object")
model RulestackProperties {
  @doc("PanEtag info")
  panEtag?: string;

  @doc("Rulestack Location, Required for GlobalRulestacks, Not for LocalRulestacks")
  panLocation?: string;

  @doc("Rulestack Type")
  scope?: ScopeType;

  @doc("subscription scope of global rulestack")
  associatedSubscriptions?: string[];

  @doc("rulestack description")
  description?: string;

  @doc("Mode for default rules creation")
  defaultMode?: DefaultMode;

  @doc("minimum version")
  minAppIdVersion?: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Security Profile")
  securityServices?: SecurityServices;
}

@doc("security services")
model SecurityServices {
  @doc("IPs Vulnerability Profile Data")
  vulnerabilityProfile?: string;

  @doc("Anti spyware Profile data")
  antiSpywareProfile?: string;

  @doc("anti virus profile data")
  antiVirusProfile?: string;

  @doc("URL filtering profile data")
  urlFilteringProfile?: string;

  @doc("File blocking profile data")
  fileBlockingProfile?: string;

  @doc("DNS Subscription profile data")
  dnsSubscription?: string;

  @doc("Untrusted Egress Decryption profile data")
  outboundUnTrustCertificate?: string;

  @doc("Trusted Egress Decryption profile data")
  outboundTrustCertificate?: string;
}

@doc("The properties of the managed service identities assigned to this resource.")
model AzureResourceManagerManagedIdentityProperties {
  @doc("The Active Directory tenant id of the principal.")
  @visibility("read")
  tenantId?: string;

  @doc("The active directory identifier of this principal.")
  @visibility("read")
  principalId?: string;

  @doc("Type of the managed identity.")
  type: ManagedServiceIdentityType;

  @doc("The identities assigned to this resource by the user.")
  userAssignedIdentities?: Record<AzureResourceManagerUserAssignedIdentity>;
}

@doc("A managed identity assigned by the user.")
model AzureResourceManagerUserAssignedIdentity {
  @doc("The active directory client identifier for this principal.")
  clientId?: string;

  @doc("The active directory identifier for this principal.")
  principalId?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

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

@doc("The type used for update operations of the GlobalRulestackResource.")
model GlobalRulestackResourceUpdate {
  @doc("Global Location")
  location?: string;

  @doc("The managed service identities assigned to this resource.")
  identity?: AzureResourceManagerManagedIdentityProperties;

  @doc("The updatable properties of the GlobalRulestackResource.")
  properties?: GlobalRulestackResourceUpdateProperties;
}

@doc("The updatable properties of the GlobalRulestackResource.")
model GlobalRulestackResourceUpdateProperties {
  @doc("PanEtag info")
  panEtag?: string;

  @doc("Rulestack Location, Required for GlobalRulestacks, Not for LocalRulestacks")
  panLocation?: string;

  @doc("Rulestack Type")
  scope?: ScopeType;

  @doc("subscription scope of global rulestack")
  associatedSubscriptions?: string[];

  @doc("rulestack description")
  description?: string;

  @doc("Mode for default rules creation")
  defaultMode?: DefaultMode;

  @doc("minimum version")
  minAppIdVersion?: string;

  @doc("Security Profile")
  securityServices?: SecurityServices;
}

@doc("certificate used for inbound and outbound decryption")
model CertificateObject {
  @doc("Resource Id of certificate signer, to be populated only when certificateSelfSigned is false")
  certificateSignerResourceId?: string;

  @doc("use certificate self signed")
  certificateSelfSigned: BooleanEnum;

  @doc("comment for this object")
  auditComment?: string;

  @doc("user description for this object")
  description?: string;

  @doc("read only string representing last create or update")
  etag?: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("fqdn object")
model FqdnObject {
  @doc("fqdn object description")
  description?: string;

  @doc("fqdn list")
  fqdnList: string[];

  @doc("etag info")
  etag?: string;

  @doc("comment for this object")
  auditComment?: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Changelog list")
model Changelog {
  @doc("list of changes")
  changes: string[];

  @doc("lastCommitted timestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCommitted?: utcDateTime;

  @doc("lastModified timestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;
}

@doc("advanced security object")
model AdvSecurityObjectListResponse {
  @doc("response value")
  value: AdvSecurityObjectModel;

  @doc("next link")
  nextLink?: string;
}

@doc("List of custom and predefined url category")
model AdvSecurityObjectModel {
  @doc("type of object")
  type?: string;

  @doc("URL entry")
  entry: NameDescriptionObject[];
}

@doc("object type info")
model NameDescriptionObject {
  @doc("name value")
  name: string;

  @doc("description value")
  description?: string;
}

model ListAppIdResponse {
  @doc("List of AppIds")
  value: string[];

  @doc("next Link")
  nextLink?: string;
}

@doc("Countries Response Object")
model CountriesResponse {
  @doc("List of countries")
  value: Country[];

  @doc("next link")
  nextLink?: string;
}

@doc("Country Description")
model Country {
  @doc("country code")
  code: string;

  @doc("code description")
  description?: string;
}

@doc("List firewalls response")
model ListFirewallsResponse {
  @doc("firewalls list")
  value: string[];

  @doc("next link")
  nextLink?: string;
}

@doc("predefined url categories response")
model PredefinedUrlCategoriesResponse {
  @doc("predefined url categories")
  value: PredefinedUrlCategory[];

  @doc("next link")
  nextLink?: string;
}

@doc("Predefined URL category object")
model PredefinedUrlCategory {
  action: string;
  name: string;
}

@doc("Security services list response")
model SecurityServicesResponse {
  @doc("response value")
  value: SecurityServicesTypeList;

  @doc("next link")
  nextLink?: string;
}

@doc("Security services type list")
model SecurityServicesTypeList {
  @doc("security services type")
  type?: string;

  @doc("list")
  entry: NameDescriptionObject[];
}

@doc("definition of rule")
model RuleEntry {
  @doc("etag info")
  etag?: string;

  @doc("rule name")
  ruleName: string;

  @visibility("read")
  priority?: int32;

  @doc("rule description")
  description?: string;

  @doc("state of this rule")
  ruleState?: StateEnum;

  @doc("source address")
  source?: SourceAddr;

  @doc("cidr should not be 'any'")
  negateSource?: BooleanEnum;

  @doc("destination address")
  destination?: DestinationAddr;

  @doc("cidr should not be 'any'")
  negateDestination?: BooleanEnum;

  @doc("array of rule applications")
  applications?: string[];

  @doc("rule category")
  category?: Category;

  @doc("any, application-default, TCP:number, UDP:number")
  protocol?: string;

  @doc("prot port list")
  protocolPortList?: string[];

  @doc("inbound Inspection Certificate")
  inboundInspectionCertificate?: string;

  @doc("rule comment")
  auditComment?: string;

  @doc("rule action")
  actionType?: ActionEnum;

  @doc("enable or disable logging")
  enableLogging?: StateEnum;

  @doc("enable or disable decryption")
  decryptionRuleType?: DecryptionRuleTypeEnum;

  @doc("tag for rule")
  tags?: TagInfo[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Address properties")
model SourceAddr {
  @doc("special value 'any'")
  cidrs?: string[];

  @doc("list of countries")
  countries?: string[];

  @doc("list of feeds")
  feeds?: string[];

  @doc("prefix list")
  prefixLists?: string[];
}

@doc("destination address")
model DestinationAddr {
  @doc("special value 'any'")
  cidrs?: string[];

  @doc("list of countries")
  countries?: string[];

  @doc("list of feeds")
  feeds?: string[];

  @doc("prefix list")
  prefixLists?: string[];

  @doc("fqdn list")
  fqdnLists?: string[];
}

@doc("URL/EDL to match")
model Category {
  @doc("custom URL")
  urlCustom: string[];

  @doc("feed list")
  feeds: string[];
}

@doc("Tag")
model TagInfo {
  @doc("tag name")
  key: string;

  @doc("tag value")
  value: string;
}

@doc("Rule counter")
model RuleCounter {
  @doc("priority number")
  priority: string;

  @doc("rule Stack Name")
  ruleStackName?: string;

  @doc("rule list name")
  ruleListName?: string;

  @doc("firewall name")
  firewallName?: string;

  @doc("rule name")
  ruleName: string;

  @doc("hit count")
  hitCount?: int32;

  @doc("apps seen")
  appSeen?: AppSeenData;

  @doc("timestamp of response")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("timestamp of request")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestTimestamp?: utcDateTime;

  @doc("last updated timestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;
}

@doc("Data Type for App Seen")
model AppSeenData {
  @doc("number of rows")
  count: int32;

  @doc("array of appSeen")
  appSeenList: AppSeenInfo[];
}

@doc("Definition for App Seen")
model AppSeenInfo {
  @doc("title")
  title: string;

  @doc("category")
  category: string;

  @doc("subCategory")
  subCategory: string;

  @doc("risk")
  risk: string;

  @doc("tag")
  tag: string;

  @doc("technology")
  technology: string;

  @doc("standardPorts")
  standardPorts: string;
}

@doc("Rule counter reset")
model RuleCounterReset {
  @doc("priority number")
  @visibility("read")
  priority?: string;

  @doc("rule Stack Name")
  ruleStackName?: string;

  @doc("rule list name")
  ruleListName?: string;

  @doc("firewall name")
  firewallName?: string;

  @doc("rule name")
  ruleName?: string;
}

@doc("prefix entry")
model PrefixObject {
  @doc("prefix description")
  description?: string;

  @doc("prefix list")
  prefixList: string[];

  @doc("etag info")
  etag?: string;

  @doc("comment for this object")
  auditComment?: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Properties specific to the Firewall resource deployment.")
model FirewallDeploymentProperties {
  @doc("panEtag info")
  panEtag?: string;

  @doc("Network settings")
  networkProfile: NetworkProfile;

  @doc("Panorama Managed: Default is False. Default will be CloudSec managed")
  isPanoramaManaged?: BooleanEnum;

  @doc("Panorama Configuration")
  panoramaConfig?: PanoramaConfig;

  @doc("Associated Rulestack")
  associatedRulestack?: RulestackDetails;

  @doc("DNS settings for Firewall")
  dnsSettings: DNSSettings;

  @doc("Frontend settings for Firewall")
  frontEndSettings?: FrontendSetting[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Billing plan information.")
  planData: PlanData;

  @doc("Marketplace details")
  marketplaceDetails: MarketplaceDetails;
}

@doc("Network settings for Firewall")
model NetworkProfile {
  @doc("Vnet configurations")
  vnetConfiguration?: VnetConfiguration;

  @doc("Vwan configurations")
  vwanConfiguration?: VwanConfiguration;

  @doc("vnet or vwan, cannot be updated")
  networkType: NetworkType;

  @doc("List of IPs associated with the Firewall")
  publicIps: IPAddress[];

  @doc("Enable egress NAT, enabled by default")
  enableEgressNat: EgressNat;

  @doc("Egress nat IP to use")
  egressNatIp?: IPAddress[];

  @doc("Non-RFC 1918 address")
  trustedRanges?: string[];
}

@doc("VnetInfo for Firewall Networking")
model VnetConfiguration {
  @doc("Azure Virtual Network")
  vnet: IPAddressSpace;

  @doc("Trust Subnet")
  trustSubnet: IPAddressSpace;

  @doc("Untrust Subnet")
  unTrustSubnet: IPAddressSpace;

  @doc("IP of trust subnet for UDR")
  ipOfTrustSubnetForUdr?: IPAddress;
}

@doc("IP Address Space")
model IPAddressSpace {
  @doc("Resource Id")
  resourceId?: string;

  @doc("Address Space")
  addressSpace?: string;
}

@doc("IP Address")
model IPAddress {
  @doc("Resource Id")
  resourceId?: string;

  @doc("Address value")
  address?: string;
}

@doc("VwanInfo for Firewall Networking")
model VwanConfiguration {
  @doc("Network Virtual Appliance resource ID ")
  networkVirtualApplianceId?: string;

  @doc("vHub Address")
  vHub: IPAddressSpace;

  @doc("Trust Subnet")
  trustSubnet?: IPAddressSpace;

  @doc("Untrust Subnet")
  unTrustSubnet?: IPAddressSpace;

  @doc("IP of trust subnet for UDR")
  ipOfTrustSubnetForUdr?: IPAddress;
}

@doc("Panorama Config")
model PanoramaConfig {
  @doc("Base64 encoded string representing Panorama parameters to be used by Firewall to connect to Panorama. This string is generated via azure plugin in Panorama")
  configString: string;

  @doc("VM auth key for panorama connectivity")
  @visibility("read")
  vmAuthKey?: string;

  @doc("Primary Panorama Server IP address value in dotted format for IPv4")
  @visibility("read")
  panoramaServer?: string;

  @doc("Secondary Panorama Server IP address value in dotted format for IPv4")
  @visibility("read")
  panoramaServer2?: string;

  @doc("Panorama Device Group to join")
  @visibility("read")
  dgName?: string;

  @doc("Panorama Template Stack to join - (Once configured we can not edit the value)")
  @visibility("read")
  tplName?: string;

  @doc("Panorama Collector Group to join - (Once configured we can not edit the value)")
  @visibility("read")
  cgName?: string;

  @doc("Resource name(may be unique) for PN admin")
  @visibility("read")
  hostName?: string;
}

@doc("Associated rulestack details")
model RulestackDetails {
  @doc("Resource Id")
  resourceId?: string;

  @doc("Associated rulestack Id")
  rulestackId?: string;

  @doc("Rulestack location")
  location?: string;
}

@doc("DNS Proxy settings for Firewall")
model DNSSettings {
  @doc("Enable DNS proxy, disabled by default")
  enableDnsProxy?: DNSProxy;

  @doc("Enabled DNS proxy type, disabled by default")
  enabledDnsType?: EnabledDNSType;

  @doc("List of IPs associated with the Firewall")
  dnsServers?: IPAddress[];
}

@doc("Frontend setting for Firewall")
model FrontendSetting {
  @doc("Settings name")
  name: string;

  @doc("Protocol Type")
  protocol: ProtocolType;

  @doc("Frontend configurations")
  frontendConfiguration: EndpointConfiguration;

  @doc("Backend configurations")
  backendConfiguration: EndpointConfiguration;
}

@doc("Endpoint Configuration for frontend and backend")
model EndpointConfiguration {
  @doc("port ID")
  port: string;

  @doc("Address Space")
  address: IPAddress;
}

@doc("Billing plan information.")
model PlanData {
  @doc("different usage type like PAYG/COMMITTED")
  usageType?: UsageType;

  @doc("different billing cycles like MONTHLY/WEEKLY")
  billingCycle: BillingCycle;

  @doc("plan id as published by Liftr.PAN")
  @maxLength(50)
  planId: string;

  @doc("date when plan was applied")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;
}

@doc("MarketplaceDetails of PAN Firewall resource")
model MarketplaceDetails {
  @doc("Marketplace Subscription Id")
  @visibility("read")
  marketplaceSubscriptionId?: string;

  @doc("Offer Id")
  offerId: string;

  @doc("Publisher Id")
  publisherId: string;

  @doc("Marketplace Subscription Status")
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;
}

@doc("The type used for update operations of the FirewallResource.")
model FirewallResourceUpdate {
  @doc("The managed service identities assigned to this resource.")
  identity?: AzureResourceManagerManagedIdentityProperties;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The updatable properties of the FirewallResource.")
  properties?: FirewallResourceUpdateProperties;
}

@doc("The updatable properties of the FirewallResource.")
model FirewallResourceUpdateProperties {
  @doc("panEtag info")
  panEtag?: string;

  @doc("Network settings")
  networkProfile?: NetworkProfile;

  @doc("Panorama Managed: Default is False. Default will be CloudSec managed")
  isPanoramaManaged?: BooleanEnum;

  @doc("Panorama Configuration")
  panoramaConfig?: PanoramaConfig;

  @doc("Associated Rulestack")
  associatedRulestack?: RulestackDetails;

  @doc("DNS settings for Firewall")
  dnsSettings?: DNSSettings;

  @doc("Frontend settings for Firewall")
  frontEndSettings?: FrontendSetting[];

  @doc("Billing plan information.")
  planData?: PlanData;

  @doc("Marketplace details")
  marketplaceDetails?: MarketplaceDetails;
}

@doc("PAN Rulestack Describe Object")
model GlobalRulestackInfo {
  @doc("rulestack description")
  azureId: string;
}

@doc("Log Settings for Firewall")
model LogSettings {
  @doc("One of possible log type")
  logType?: LogType;

  @doc("Log option SAME/INDIVIDUAL")
  logOption?: LogOption;

  @doc("Application Insight details")
  applicationInsights?: ApplicationInsights;

  @doc("Common destination configurations")
  commonDestination?: LogDestination;

  @doc("Traffic destination configurations")
  trafficLogDestination?: LogDestination;

  @doc("Threat destination configurations")
  threatLogDestination?: LogDestination;

  @doc("Decrypt destination configurations")
  decryptLogDestination?: LogDestination;
}

@doc("Application Insights key")
model ApplicationInsights {
  @doc("Resource id for Application Insights")
  id?: string;

  @doc("Application Insights key")
  key?: string;
}

@doc("Log Destination")
model LogDestination {
  @doc("Storage account configurations")
  storageConfigurations?: StorageAccount;

  @doc("Event Hub configurations")
  eventHubConfigurations?: EventHub;

  @doc("Monitor Log configurations")
  monitorConfigurations?: MonitorLog;
}

@doc("Storage Account configurations")
model StorageAccount {
  @doc("Resource ID of storage account")
  id?: string;

  @doc("Subscription Id")
  subscriptionId?: string;

  @doc("Storage account name")
  accountName?: string;
}

@doc("EventHub configurations")
model EventHub {
  @doc("Resource ID of EventHub")
  id?: string;

  @doc("Subscription Id")
  subscriptionId?: string;

  @doc("EventHub name")
  name?: string;

  @doc("EventHub namespace")
  nameSpace?: string;

  @doc("EventHub policy name")
  policyName?: string;
}

@doc("MonitorLog configurations")
model MonitorLog {
  @doc("Resource ID of MonitorLog")
  id?: string;

  @doc("Subscription Id")
  subscriptionId?: string;

  @doc("MonitorLog workspace")
  workspace?: string;

  @doc("Primary Key value for Monitor")
  primaryKey?: string;

  @doc("Secondary Key value for Monitor")
  secondaryKey?: string;
}

@doc("Support information for the resource")
model SupportInfo {
  @doc("product SKU associated with given resource")
  productSku?: string;

  @doc("product Serial associated with given resource")
  productSerial?: string;

  @doc("account registered in Customer Support Portal")
  accountRegistered?: BooleanEnum;

  @doc("Support account associated with given resource")
  accountId?: string;

  @doc("user domain is supported in Customer Support Portal")
  userDomainSupported?: BooleanEnum;

  @doc("user registered in Customer Support Portal")
  userRegistered?: BooleanEnum;

  @doc("Product usage is in free trial period")
  freeTrial?: BooleanEnum;

  @doc("Free trial days remaining")
  freeTrialDaysLeft?: int32;

  @doc("Free trial credit remaining")
  freeTrialCreditLeft?: int32;

  @doc("URL for paloaltonetworks live community")
  helpURL?: string;

  @doc("URL for paloaltonetworks Customer Service Portal")
  supportURL?: string;

  @doc("URL for registering product in paloaltonetworks Customer Service Portal")
  registerURL?: string;
}

@doc("Firewall Status")
model FirewallStatusProperty {
  @doc("Panorama Managed: Default is False. Default will be CloudSec managed")
  @visibility("read")
  isPanoramaManaged?: BooleanEnum;

  @doc("Current status of the Firewall")
  @visibility("read")
  healthStatus?: HealthStatus;

  @doc("Detail description of current health of the Firewall")
  @visibility("read")
  healthReason?: string;

  @doc("Panorama Status")
  @visibility("read")
  panoramaStatus?: PanoramaStatus;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ReadOnlyProvisioningState;
}

@doc("Panorama connectivity information")
model PanoramaStatus {
  @doc("Primary Panorama connection status")
  @visibility("read")
  panoramaServerStatus?: ServerStatus;

  @doc("Secondary Panorama connection status")
  @visibility("read")
  panoramaServer2Status?: ServerStatus;
}

@doc("The type used for update operations of the LocalRulestackResource.")
model LocalRulestackResourceUpdate {
  @doc("The managed service identities assigned to this resource.")
  identity?: AzureResourceManagerManagedIdentityProperties;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The updatable properties of the LocalRulestackResource.")
  properties?: LocalRulestackResourceUpdateProperties;
}

@doc("The updatable properties of the LocalRulestackResource.")
model LocalRulestackResourceUpdateProperties {
  @doc("PanEtag info")
  panEtag?: string;

  @doc("Rulestack Location, Required for GlobalRulestacks, Not for LocalRulestacks")
  panLocation?: string;

  @doc("Rulestack Type")
  scope?: ScopeType;

  @doc("subscription scope of global rulestack")
  associatedSubscriptions?: string[];

  @doc("rulestack description")
  description?: string;

  @doc("Mode for default rules creation")
  defaultMode?: DefaultMode;

  @doc("minimum version")
  minAppIdVersion?: string;

  @doc("Security Profile")
  securityServices?: SecurityServices;
}
