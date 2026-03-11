import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace PaloAltoNetworks.Cloudngfw;

/**
 * Rulestack Type
 */
union ScopeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LOCAL: "LOCAL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GLOBAL: "GLOBAL",
}

/**
 * Type for Default Mode for rules creation
 */
union DefaultMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IPS: "IPS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FIREWALL: "FIREWALL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NONE: "NONE",
}

/**
 * Provisioning state of the firewall resource.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
}

/**
 * The kind of managed identity assigned to this resource.
 */
union ManagedIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAndUserAssigned: "SystemAssigned,UserAssigned",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Boolean Enum
 */
union BooleanEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TRUE: "TRUE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FALSE: "FALSE",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AdvSecurityObjectTypeEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  urlCustom: "urlCustom",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  feeds: "feeds",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SecurityServicesTypeEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  antiSpyware: "antiSpyware",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  antiVirus: "antiVirus",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipsVulnerability: "ipsVulnerability",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  urlFiltering: "urlFiltering",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileBlocking: "fileBlocking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dnsSubscription: "dnsSubscription",
}

/**
 * Enabled or Disabled Enum
 */
union StateEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DISABLED: "DISABLED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ENABLED: "ENABLED",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ActionEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DenySilent: "DenySilent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DenyResetServer: "DenyResetServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DenyResetBoth: "DenyResetBoth",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DecryptionRuleTypeEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SSLOutboundInspection: "SSLOutboundInspection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SSLInboundInspection: "SSLInboundInspection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * NetworkType Enum
 */
union NetworkType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VNET: "VNET",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VWAN: "VWAN",
}

/**
 * Egress NAT
 */
union EgressNat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DISABLED: "DISABLED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ENABLED: "ENABLED",
}

/**
 * DNS Proxy
 */
union DNSProxy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DISABLED: "DISABLED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ENABLED: "ENABLED",
}

/**
 * Enabled DNS type values
 */
union EnabledDNSType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CUSTOM: "CUSTOM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AZURE: "AZURE",
}

/**
 * Protocol Enum
 */
union ProtocolType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TCP: "TCP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UDP: "UDP",
}

/**
 * Usage Type
 */
union UsageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PAYG: "PAYG",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  COMMITTED: "COMMITTED",
}

/**
 * Billing cycle
 */
union BillingCycle {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WEEKLY: "WEEKLY",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MONTHLY: "MONTHLY",
}

/**
 * Marketplace Subscription Status
 */
union MarketplaceSubscriptionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingFulfillmentStart: "PendingFulfillmentStart",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Subscribed: "Subscribed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unsubscribed: "Unsubscribed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotStarted: "NotStarted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FulfillmentRequested: "FulfillmentRequested",
}

/**
 * Registration status
 */
union RegistrationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Registered: "Registered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Not Registered`: "Not Registered",
}

/**
 * Enable status
 */
union EnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Possible log types
 */
union LogType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TRAFFIC: "TRAFFIC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  THREAT: "THREAT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DECRYPTION: "DECRYPTION",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WILDFIRE: "WILDFIRE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DLP: "DLP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AUDIT: "AUDIT",
}

/**
 * Log options possible
 */
union LogOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAME_DESTINATION: "SAME_DESTINATION",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  INDIVIDUAL_DESTINATION: "INDIVIDUAL_DESTINATION",
}

/**
 * Status Codes for the Firewall
 */
union HealthStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GREEN: "GREEN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  YELLOW: "YELLOW",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RED: "RED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  INITIALIZING: "INITIALIZING",
}

/**
 * Connectivity Status for Panorama Server
 */
union ServerStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UP: "UP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DOWN: "DOWN",
}

/**
 * Provisioning state of the firewall resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ReadOnlyProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
}

/**
 * allocation status of the product serial number
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ProductSerialStatusValues {
  Allocated,
  InProgress,
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The active directory identifier of this principal.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The type of managed identity assigned to this resource.
   */
  type: ManagedIdentityType;

  /**
   * The identities assigned to this resource by the user.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ListAppIdResponse {
  /*
   *List of AppIds
   */
  @TypeSpec.pageItems
  value: string[];

  /*
   *next Link
   */
  @TypeSpec.nextLink
  nextLink?: string;
}

/**
 * Countries Response Object
 */
model CountriesResponse is Azure.Core.Page<Country>;

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
model PredefinedUrlCategoriesResponse is Azure.Core.Page<PredefinedUrlCategory>;

/**
 * Predefined URL category object
 */
model PredefinedUrlCategory {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  action: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#[])
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
  tags?: TagInfo[];

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Create Product Serial Number Request status
 */
model ProductSerialNumberRequestStatus {
  /**
   * allocation status of the product serial number
   */
  status: string;
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
   * Strata Cloud Managed: Default is False. Default will be CloudSec managed
   */
  isStrataCloudManaged?: BooleanEnum;

  /**
   * Panorama Configuration
   */
  panoramaConfig?: PanoramaConfig;

  /**
   * Strata Cloud Manager Configuration, only applicable if Strata Cloud Manager is selected.
   */
  strataCloudManagerConfig?: StrataCloudManagerConfig;

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
  @identifiers(#[])
  frontEndSettings?: FrontendSetting[];

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
  publicIps: IPAddress[];

  /**
   * Enable egress NAT, enabled by default
   */
  enableEgressNat: EgressNat;

  /**
   * Egress nat IP to use
   */
  @identifiers(#[])
  egressNatIp?: IPAddress[];

  /**
   * Non-RFC 1918 address
   */
  trustedRanges?: string[];

  /**
   * Array of ipv4 destination address for which source NAT is to be performed
   */
  privateSourceNatRulesDestination?: string[];
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read)
  vmAuthKey?: string;

  /**
   * Primary Panorama Server IP address value in dotted format for IPv4
   */
  @visibility(Lifecycle.Read)
  panoramaServer?: string;

  /**
   * Secondary Panorama Server IP address value in dotted format for IPv4
   */
  @visibility(Lifecycle.Read)
  panoramaServer2?: string;

  /**
   * Panorama Device Group to join
   */
  @visibility(Lifecycle.Read)
  dgName?: string;

  /**
   * Panorama Template Stack to join - (Once configured we can not edit the value)
   */
  @visibility(Lifecycle.Read)
  tplName?: string;

  /**
   * Panorama Collector Group to join - (Once configured we can not edit the value)
   */
  @visibility(Lifecycle.Read)
  cgName?: string;

  /**
   * Resource name(may be unique) for PN admin
   */
  @visibility(Lifecycle.Read)
  hostName?: string;
}

/**
 * This field is only present if Strata Cloud Manager is managing the policy for this firewall
 */
model StrataCloudManagerConfig {
  /**
   * Strata Cloud Manager name which is intended to manage the policy for this firewall.
   */
  cloudManagerName: string;
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#[])
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
 * Cloud Manager Tenant
 */
model CloudManagerTenantList {
  /**
   * List of Cloud Manager Tenants
   */
  value: string[];
}

/**
 * Product serial and status for the service
 */
model ProductSerialNumberStatus {
  /**
   * product Serial associated with given resource
   */
  serialNumber?: string;

  /**
   * allocation status of the product serial number
   */
  status: ProductSerialStatusValues;
}

/**
 * Support information for the service
 */
model SupportInfoModel {
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
  accountRegistrationStatus?: RegistrationStatus;

  /**
   * Support account associated with given resource
   */
  accountId?: string;

  /**
   * Product usage is in free trial period
   */
  freeTrial?: EnableStatus;

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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  helpURL?: string;

  /**
   * URL for paloaltonetworks Customer Service Portal
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportURL?: string;

  /**
   * URL for registering product in paloaltonetworks Customer Service Portal
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  registerURL?: string;

  /**
   * URL for Strata Cloud Manager
   */
  hubUrl?: string;

  /**
   * credits purchased, unit per hour
   */
  credits?: int32;

  /**
   * monthly credit is computed as credits * days in calendar month
   */
  monthlyCreditLeft?: int32;

  /**
   * date in format yyyy-mm-dd
   */
  startDateForCredits?: string;

  /**
   * date in format yyyy-mm-dd
   */
  endDateForCredits?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * Strata Cloud Managed: Default is False. Default will be CloudSec managed
   */
  isStrataCloudManaged?: BooleanEnum;

  /**
   * Panorama Configuration
   */
  panoramaConfig?: PanoramaConfig;

  /**
   * Strata Cloud Manager Configuration, only applicable if Strata Cloud Manager is selected.
   */
  strataCloudManagerConfig?: StrataCloudManagerConfig;

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
  @identifiers(#[])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  primaryKey?: string;

  /**
   * Secondary Key value for Monitor
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  helpURL?: string;

  /**
   * URL for paloaltonetworks Customer Service Portal
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportURL?: string;

  /**
   * URL for registering product in paloaltonetworks Customer Service Portal
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  registerURL?: string;
}

/**
 * Config for Metrics for firewall metrics
 */
model MetricsObject {
  /**
   * Resource Id of application insights resource
   */
  applicationInsightsResourceId: string;

  /**
   * Connection string of application insights resource
   */
  applicationInsightsConnectionString: string;

  /**
   * read only string representing last create or update
   */
  panEtag?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Firewall Status
 */
model FirewallStatusProperty {
  /**
   * Panorama Managed: Default is False. Default will be CloudSec managed
   */
  @visibility(Lifecycle.Read)
  isPanoramaManaged?: BooleanEnum;

  /**
   * Current status of the Firewall
   */
  @visibility(Lifecycle.Read)
  healthStatus?: HealthStatus;

  /**
   * Detail description of current health of the Firewall
   */
  @visibility(Lifecycle.Read)
  healthReason?: string;

  /**
   * Panorama Status
   */
  @visibility(Lifecycle.Read)
  panoramaStatus?: PanoramaStatus;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ReadOnlyProvisioningState;

  /**
   * Strata Cloud Manager
   */
  @visibility(Lifecycle.Read)
  isStrataCloudManaged?: BooleanEnum;

  /**
   * This field is only present if Strata Cloud Manager is managing the policy for this firewall
   */
  strataCloudManagerInfo?: StrataCloudManagerInfo;
}

/**
 * Panorama connectivity information
 */
model PanoramaStatus {
  /**
   * Primary Panorama connection status
   */
  @visibility(Lifecycle.Read)
  panoramaServerStatus?: ServerStatus;

  /**
   * Secondary Panorama connection status
   */
  @visibility(Lifecycle.Read)
  panoramaServer2Status?: ServerStatus;
}

/**
 * Strata Cloud Manager Info
 */
model StrataCloudManagerInfo {
  /**
   * Strata Cloud Manager folder in which this firewall has been placed
   */
  folderName?: string;

  /**
   * URL for Strata Cloud Manager
   */
  hubUrl?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
