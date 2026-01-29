import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DomainRegistration;

/**
 * Reasons why domain is not renewable.
 */
union ResourceNotRenewableReason {
  string,

  /**
   * Registration status is not supported for renewal.
   */
  RegistrationStatusNotSupportedForRenewal: "RegistrationStatusNotSupportedForRenewal",

  /**
   * Domain expiration is not in the renewal time range.
   */
  ExpirationNotInRenewalTimeRange: "ExpirationNotInRenewalTimeRange",

  /**
   * Subscription is not active.
   */
  SubscriptionNotActive: "SubscriptionNotActive",
}

/**
 * Valid values are Regular domain: Azure will charge the full price of domain registration, SoftDeleted: Purchasing this domain will simply restore it and this operation will not cost anything.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DomainType {
  Regular,
  SoftDeleted,
}

/**
 * Domain registration status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DomainStatus {
  Active,
  Awaiting,
  Cancelled,
  Confiscated,
  Disabled,
  Excluded,
  Expired,
  Failed,
  Held,
  Locked,
  Parked,
  Pending,
  Reserved,
  Reverted,
  Suspended,
  Transferred,
  Unknown,
  Unlocked,
  Unparked,
  Updated,
  JsonConverterFailed,
}

/**
 * Domain provisioning state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  InProgress,
  Deleting,
}

/**
 * Type of the Azure resource the hostname is assigned to.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AzureResourceType {
  Website,
  TrafficManager,
}

/**
 * Type of the DNS record.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CustomHostNameDnsRecordType {
  CName,
  A,
}

/**
 * Type of the hostname.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum HostNameType {
  Verified,
  Managed,
}

/**
 * Current DNS type
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DnsType {
  AzureDns,
  DefaultDomainRegistrarDns,
}

/**
 * Description of an operation available for Microsoft.Web resource provider.
 */
model CsmOperationDescription {
  /**
   * Operation name, e.g. Microsoft.Web/sites/write.
   */
  name?: string;

  /**
   * Operation display name.
   */
  isDataAction?: boolean;

  /**
   * Meta data about operation used for display in portal.
   */
  display?: CsmOperationDisplay;

  /**
   * Origin of the operation, e.g. "system" or "user".
   */
  origin?: string;

  /**
   * Properties available for a Microsoft.Web resource provider operation.
   */
  properties?: CsmOperationDescriptionProperties;
}

/**
 * Meta data about operation used for display in portal.
 */
model CsmOperationDisplay {
  /**
   * Provider name.
   */
  provider?: string;

  /**
   * Resource type.
   */
  resource?: string;

  /**
   * Operation name.
   */
  operation?: string;

  /**
   * Operation description.
   */
  description?: string;
}

/**
 * Properties available for a Microsoft.Web resource provider operation.
 */
model CsmOperationDescriptionProperties {
  /**
   * Resource metrics service provided by Microsoft.Insights resource provider.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Resource metrics service provided by Microsoft.Insights resource provider.
 */
model ServiceSpecification {
  /**
   * Resource metrics service name.
   */
  @identifiers(#["name"])
  metricSpecifications?: MetricSpecification[];

  /**
   * Resource logs service provided by Microsoft.Insights resource provider.
   */
  @identifiers(#["name"])
  logSpecifications?: LogSpecification[];
}

/**
 * Definition of a single resource metric.
 */
model MetricSpecification {
  /**
   * Name of the resource metric.
   */
  name?: string;

  /**
   * Display name of the resource metric.
   */
  displayName?: string;

  /**
   * Description of the resource metric.
   */
  displayDescription?: string;

  /**
   * Resource metric unit.
   */
  unit?: string;

  /**
   * Resource metric aggregation type.
   */
  aggregationType?: string;

  /**
   * Resource metric supported aggregation types.
   */
  supportsInstanceLevelAggregation?: boolean;

  /**
   * Resource metric supported time grain types.
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * Resource metric source MDM account.
   */
  sourceMdmAccount?: string;

  /**
   * Resource metric source MDM namespace.
   */
  sourceMdmNamespace?: string;

  /**
   * Resource metric filter pattern.
   */
  metricFilterPattern?: string;

  /**
   * Resource metric fill gap with zero.
   */
  fillGapWithZero?: boolean;

  /**
   * Resource metric is internal.
   */
  isInternal?: boolean;

  /**
   * Resource metric dimensions.
   */
  @identifiers(#["name"])
  dimensions?: Dimension[];

  /**
   * Resource metric category.
   */
  category?: string;

  /**
   * Resource metric availability.
   */
  @identifiers(#[])
  availabilities?: MetricAvailability[];

  /**
   * Resource metric supported time grain types.
   */
  supportedTimeGrainTypes?: string[];

  /**
   * Resource metric supported aggregation types.
   */
  supportedAggregationTypes?: string[];
}

/**
 * Dimension of a resource metric. For e.g. instance specific HTTP requests for a web app,
 * where instance name is dimension of the metric HTTP request
 */
model Dimension {
  /**
   * Name of the dimension.
   */
  name?: string;

  /**
   * Display name of the dimension.
   */
  displayName?: string;

  /**
   * Dimension of the internal name.
   */
  internalName?: string;

  /**
   * Dimension to be exported for shoebox.
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * Retention policy of a resource metric.
 */
model MetricAvailability {
  /**
   * Metric availability time grain.
   */
  timeGrain?: string;

  /**
   * Metric availability blob duration.
   */
  blobDuration?: string;
}

/**
 * Log Definition of a single resource metric.
 */
model LogSpecification {
  /**
   * Name of the log.
   */
  name?: string;

  /**
   * Display name of the log.
   */
  displayName?: string;

  /**
   * Blob duration of the log.
   */
  blobDuration?: string;

  /**
   * Log filtered pattern of the log.
   */
  logFilterPattern?: string;
}

/**
 * App Service error response.
 */
@error
model DefaultErrorResponse {
  /**
   * Error model.
   */
  @visibility(Lifecycle.Read)
  error?: DefaultErrorResponseError;
}

/**
 * Error model.
 */
model DefaultErrorResponseError {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * Error details.
   */
  @identifiers(#[])
  details?: DefaultErrorResponseErrorDetailsItem[];

  /**
   * More information to debug error.
   */
  @visibility(Lifecycle.Read)
  innererror?: string;
}

/**
 * Detailed errors.
 */
model DefaultErrorResponseErrorDetailsItem {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  target?: string;
}

/**
 * Identifies an object.
 */
model NameIdentifier {
  /**
   * Name of the object.
   */
  name?: string;
}

/**
 * Domain availability check result.
 */
model DomainAvailabilityCheckResult {
  /**
   * Name of the domain.
   */
  name?: string;

  /**
   * <code>true</code> if domain can be purchased using CreateDomain API; otherwise, <code>false</code>.
   */
  available?: boolean;

  /**
   * Valid values are Regular domain: Azure will charge the full price of domain registration, SoftDeleted: Purchasing this domain will simply restore it and this operation will not cost anything.
   */
  domainType?: DomainType;
}

/**
 * Collection of domains.
 */
model DomainCollection is Azure.Core.Page<Domain>;

/**
 * Domain resource specific properties
 */
model DomainProperties {
  /**
   * Administrative contact.
   */
  @visibility(Lifecycle.Create)
  contactAdmin: Contact;

  /**
   * Billing contact.
   */
  @visibility(Lifecycle.Create)
  contactBilling: Contact;

  /**
   * Registrant contact.
   */
  @visibility(Lifecycle.Create)
  contactRegistrant: Contact;

  /**
   * Technical contact.
   */
  @visibility(Lifecycle.Create)
  contactTech: Contact;

  /**
   * Domain registration status.
   */
  @visibility(Lifecycle.Read)
  registrationStatus?: DomainStatus;

  /**
   * Domain provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Name servers.
   */
  @visibility(Lifecycle.Read)
  nameServers?: string[];

  /**
   * <code>true</code> if domain privacy is enabled for this domain; otherwise, <code>false</code>.
   */
  privacy?: boolean;

  /**
   * Domain creation timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Domain expiration timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Timestamp when the domain was renewed last time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRenewedTime?: utcDateTime;

  /**
   * <code>true</code> if the domain should be automatically renewed; otherwise, <code>false</code>.
   */
  autoRenew?: boolean = true;

  /**
   * <code>true</code> if Azure can assign this domain to App Service apps; otherwise, <code>false</code>. This value will be <code>true</code> if domain registration status is active and \n it is hosted on name servers Azure has programmatic access to.
   */
  @visibility(Lifecycle.Read)
  readyForDnsRecordManagement?: boolean;

  /**
   * All hostnames derived from the domain and assigned to Azure resources.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  managedHostNames?: HostName[];

  /**
   * Legal agreement consent.
   */
  @visibility(Lifecycle.Create)
  consent: DomainPurchaseConsent;

  /**
   * Reasons why domain is not renewable.
   */
  @visibility(Lifecycle.Read)
  domainNotRenewableReasons?: ResourceNotRenewableReason[];

  /**
   * Current DNS type
   */
  dnsType?: DnsType;

  /**
   * Azure DNS Zone to use
   */
  dnsZoneId?: string;

  /**
   * Target DNS type (would be used for migration)
   */
  targetDnsType?: DnsType;

  /**
   * Authorization code for the domain.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  authCode?: string;
}

/**
 * Contact information for domain registration. If 'Domain Privacy' option is not selected then the contact information is made publicly available through the Whois
 * directories as per ICANN requirements.
 */
model Contact {
  /**
   * Mailing address.
   */
  addressMailing?: Address;

  /**
   * Email address.
   */
  email: string;

  /**
   * Fax number.
   */
  fax?: string;

  /**
   * Job title.
   */
  jobTitle?: string;

  /**
   * First name.
   */
  nameFirst: string;

  /**
   * Last name.
   */
  nameLast: string;

  /**
   * Middle name.
   */
  nameMiddle?: string;

  /**
   * Organization contact belongs to.
   */
  organization?: string;

  /**
   * Phone number.
   */
  phone: string;
}

/**
 * Address information for domain registration.
 */
model Address {
  /**
   * First line of an Address.
   */
  address1: string;

  /**
   * The second line of the Address. Optional.
   */
  address2?: string;

  /**
   * The city for the address.
   */
  city: string;

  /**
   * The country for the address.
   */
  country: string;

  /**
   * The postal code for the address.
   */
  postalCode: string;

  /**
   * The state or province for the address.
   */
  state: string;
}

/**
 * Details of a hostname derived from a domain.
 */
model HostName {
  /**
   * Name of the hostname.
   */
  name?: string;

  /**
   * List of apps the hostname is assigned to. This list will have more than one app only if the hostname is pointing to a Traffic Manager.
   */
  siteNames?: string[];

  /**
   * Name of the Azure resource the hostname is assigned to. If it is assigned to a Traffic Manager then it will be the Traffic Manager name otherwise it will be the app name.
   */
  azureResourceName?: string;

  /**
   * Type of the Azure resource the hostname is assigned to.
   */
  azureResourceType?: AzureResourceType;

  /**
   * Type of the DNS record.
   */
  customHostNameDnsRecordType?: CustomHostNameDnsRecordType;

  /**
   * Type of the hostname.
   */
  hostNameType?: HostNameType;
}

/**
 * Domain purchase consent object, representing acceptance of applicable legal agreements.
 */
model DomainPurchaseConsent {
  /**
   * List of applicable legal agreement keys. This list can be retrieved using ListLegalAgreements API under <code>TopLevelDomain</code> resource.
   */
  agreementKeys?: string[];

  /**
   * Client IP address.
   */
  agreedBy?: string;

  /**
   * Timestamp when the agreements were accepted.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agreedAt?: utcDateTime;
}

/**
 * Single sign-on request information for domain management.
 */
model DomainControlCenterSsoRequest {
  /**
   * URL where the single sign-on request is to be made.
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * Post parameter key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  postParameterKey?: string;

  /**
   * Post parameter value. Client should use 'application/x-www-form-urlencoded' encoding for this value.
   */
  @visibility(Lifecycle.Read)
  postParameterValue?: string;
}

/**
 * Domain recommendation search parameters.
 */
model DomainRecommendationSearchParameters {
  /**
   * Keywords to be used for generating domain recommendations.
   */
  keywords?: string;

  /**
   * Maximum number of recommendations.
   */
  maxDomainRecommendations?: int32;
}

/**
 * Collection of domain name identifiers.
 */
@@identifiers(NameIdentifierCollection.value, #["name"]);
model NameIdentifierCollection is Azure.Core.Page<NameIdentifier>;

/**
 * ARM resource for a domain.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DomainPatchResource extends ProxyOnlyResource {
  /**
   * DomainPatchResource resource specific properties
   */
  properties?: DomainPatchResourceProperties;
}

/**
 * DomainPatchResource resource specific properties
 */
model DomainPatchResourceProperties {
  /**
   * Administrative contact.
   */
  @visibility(Lifecycle.Create)
  contactAdmin: Contact;

  /**
   * Billing contact.
   */
  @visibility(Lifecycle.Create)
  contactBilling: Contact;

  /**
   * Registrant contact.
   */
  @visibility(Lifecycle.Create)
  contactRegistrant: Contact;

  /**
   * Technical contact.
   */
  @visibility(Lifecycle.Create)
  contactTech: Contact;

  /**
   * Domain registration status.
   */
  @visibility(Lifecycle.Read)
  registrationStatus?: DomainStatus;

  /**
   * Domain provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Name servers.
   */
  @visibility(Lifecycle.Read)
  nameServers?: string[];

  /**
   * <code>true</code> if domain privacy is enabled for this domain; otherwise, <code>false</code>.
   */
  privacy?: boolean;

  /**
   * Domain creation timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Domain expiration timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Timestamp when the domain was renewed last time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRenewedTime?: utcDateTime;

  /**
   * <code>true</code> if the domain should be automatically renewed; otherwise, <code>false</code>.
   */
  autoRenew?: boolean = true;

  /**
   * <code>true</code> if Azure can assign this domain to App Service apps; otherwise, <code>false</code>. This value will be <code>true</code> if domain registration status is active and \n it is hosted on name servers Azure has programmatic access to.
   */
  @visibility(Lifecycle.Read)
  readyForDnsRecordManagement?: boolean;

  /**
   * All hostnames derived from the domain and assigned to Azure resources.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  managedHostNames?: HostName[];

  /**
   * Legal agreement consent.
   */
  @visibility(Lifecycle.Create)
  consent: DomainPurchaseConsent;

  /**
   * Reasons why domain is not renewable.
   */
  @visibility(Lifecycle.Read)
  domainNotRenewableReasons?: ResourceNotRenewableReason[];

  /**
   * Current DNS type
   */
  dnsType?: DnsType;

  /**
   * Azure DNS Zone to use
   */
  dnsZoneId?: string;

  /**
   * Target DNS type (would be used for migration)
   */
  targetDnsType?: DnsType;

  /**
   * Authorization code for the domain.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  authCode?: string;
}

/**
 * Azure proxy only resource. This resource is not tracked by Azure Resource Manager.
 */
model ProxyOnlyResource {
  /**
   * Resource Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource Name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Kind of resource.
   */
  kind?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Collection of domain ownership identifiers.
 */
model DomainOwnershipIdentifierCollection
  is Azure.Core.Page<DomainOwnershipIdentifier>;

/**
 * DomainOwnershipIdentifier resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DomainOwnershipIdentifierProperties {
  /**
   * Ownership Id.
   */
  ownershipId?: string;
}

/**
 * Collection of Top-level domains.
 */
model TopLevelDomainCollection is Azure.Core.Page<TopLevelDomain>;

/**
 * TopLevelDomain resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TopLevelDomainProperties {
  /**
   * If <code>true</code>, then the top level domain supports domain privacy; otherwise, <code>false</code>.
   */
  privacy?: boolean;
}

/**
 * Options for retrieving the list of top level domain legal agreements.
 */
model TopLevelDomainAgreementOption {
  /**
   * If <code>true</code>, then the list of agreements will include agreements for domain privacy as well; otherwise, <code>false</code>.
   */
  includePrivacy?: boolean;

  /**
   * If <code>true</code>, then the list of agreements will include agreements for domain transfer as well; otherwise, <code>false</code>.
   */
  forTransfer?: boolean;
}

/**
 * Collection of top-level domain legal agreements.
 */
@@identifiers(TldLegalAgreementCollection.value, #["agreementKey"]);
model TldLegalAgreementCollection is Azure.Core.Page<TldLegalAgreement>;

/**
 * Legal agreement for a top level domain.
 */
model TldLegalAgreement {
  /**
   * Unique identifier for the agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agreementKey: string;

  /**
   * Agreement title.
   */
  title: string;

  /**
   * Agreement details.
   */
  content: string;

  /**
   * URL where a copy of the agreement details is hosted.
   */
  url?: string;
}

/**
 * The server could not understand the request due to invalid syntax.
 */
@error
model ArmBadRequestResponse {
  ...TypeSpec.Http.Response<400>;
}

/**
 * Collection of Azure resource manager operation metadata.
 */
model CsmOperationCollection {
  /**
   * Collection of resources.
   */
  @pageItems
  @identifiers(#["name"])
  value: CsmOperationDescription[];

  /**
   * Link to next page of resources.
   */
  @doc("Link to next page of resources.")
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}
