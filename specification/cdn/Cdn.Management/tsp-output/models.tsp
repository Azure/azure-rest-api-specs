import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Cdn;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Type of CDN resource used in CheckNameAvailability.")
enum CdnResourceType {
  Endpoints: "Microsoft.Cdn/Profiles/Endpoints",
  FrontDoorEndpoints: "Microsoft.Cdn/Profiles/AfdEndpoints",
}

@doc("Indicates the endpoint name reuse scope. The default value is TenantReuse.")
enum DomainNameLabelScope {
  TenantReuse,
  SubscriptionReuse,
  ResourceGroupReuse,
  NoReuse,
}

@doc("An enum describing the unit of measurement.")
enum FrontDoorUsageUnit {
  Count,
}

@doc("Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step. DCV stands for DomainControlValidation.")
enum DomainValidationState {
  Unknown,
  Submitting,
  Pending,
  Rejected,
  TimedOut,
  PendingRevalidation,
  Approved,
  RefreshingValidationToken,
  InternalError,
}

@doc("Defines the source of the SSL certificate.")
enum FrontDoorCertificateType {
  CustomerCertificate,
  ManagedCertificate,
  AzureFirstPartyManagedCertificate,
}

@doc("Provisioning status")
enum FrontDoorProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Deleting,
  Creating,
}

enum FrontDoorDeploymentStatus {
  NotStarted,
  InProgress,
  Succeeded,
  Failed,
}

@doc("The type of identity that creates/modifies resources")
enum IdentityType {
  user,
  application,
  managedIdentity,
  key,
}

@doc("Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'")
enum EnabledState {
  Enabled,
  Disabled,
}

@doc("Supported protocols for the customer's endpoint.")
enum FrontDoorEndpointProtocol {
  Http,
  Https,
}

@doc("Defines how Frontdoor caches requests that include query strings. You can ignore any query strings when caching, ignore specific query strings, cache every request with a unique URL, or cache specific query strings.")
enum FrontDoorQueryStringCachingBehavior {
  IgnoreQueryString,
  UseQueryString,
  IgnoreSpecifiedQueryStrings,
  IncludeSpecifiedQueryStrings,
}

@doc("Protocol this rule will use when forwarding traffic to backends.")
enum ForwardingProtocol {
  HttpOnly,
  HttpsOnly,
  MatchRequest,
}

@doc("whether this route will be linked to the default endpoint domain.")
enum LinkToDefaultDomain {
  Enabled,
  Disabled,
}

@doc("Whether to automatically redirect HTTP traffic to HTTPS traffic. Note that this is a easy way to set up this rule and it will be the first rule that gets executed.")
enum HttpsRedirect {
  Enabled,
  Disabled,
}

@doc("The name of the condition for the delivery rule.")
enum MatchVariable {
  RemoteAddress,
  RequestMethod,
  QueryString,
  PostArgs,
  RequestUri,
  RequestHeader,
  RequestBody,
  RequestScheme,
  UrlPath,
  UrlFileExtension,
  UrlFileName,
  HttpVersion,
  Cookies,
  IsDevice,
  SocketAddr,
  ClientPort,
  ServerPort,
  HostName,
  SslProtocol,
}

@doc("The name of the action for the delivery rule.")
enum DeliveryRuleActionType {
  CacheExpiration,
  CacheKeyQueryString,
  ModifyRequestHeader,
  ModifyResponseHeader,
  UrlRedirect,
  UrlRewrite,
  UrlSigning,
  OriginGroupOverride,
  RouteConfigurationOverride,
}

@doc("If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.")
enum MatchProcessingBehavior {
  Continue,
  Stop,
}

@doc("The type of the Security policy to create.")
enum SecurityPolicyType {
  WebApplicationFirewall,
}

@doc("The type of the secret resource.")
enum SecretType {
  UrlSigningKey,
  CustomerCertificate,
  ManagedCertificate,
  AzureFirstPartyManagedCertificate,
}

enum LogMetric {
  clientRequestCount,
  clientRequestTraffic,
  clientRequestBandwidth,
  originRequestTraffic,
  originRequestBandwidth,
  totalLatency,
}

enum LogMetricsGranularity {
  PT5M,
  PT1H,
  P1D,
}

enum LogMetricsGroupBy {
  httpStatusCode,
  protocol,
  cacheStatus,
  countryOrRegion,
  customDomain,
}

enum MetricsResponseGranularity {
  PT5M,
  PT1H,
  P1D,
}

enum MetricsResponseSeriesItemUnit {
  count,
  bytes,
  bitsPerSecond,
  milliSeconds,
}

enum LogRanking {
  url,
  referrer,
  browser,
  userAgent,
  countryOrRegion,
}

enum LogRankingMetric {
  clientRequestCount,
  clientRequestTraffic,
  hitCount,
  missCount,
  userErrorCount,
  errorCount,
}

enum WafMetric {
  clientRequestCount,
}

enum WafGranularity {
  PT5M,
  PT1H,
  P1D,
}

enum WafAction {
  allow,
  block,
  log,
  redirect,
}

enum WafRankingGroupBy {
  httpStatusCode,
  customDomain,
}

enum WafRuleType {
  managed,
  custom,
  bot,
}

enum WafMetricsResponseGranularity {
  PT5M,
  PT1H,
  P1D,
}

enum WafMetricsResponseSeriesItemUnit {
  count,
}

enum WafRankingType {
  action,
  ruleGroup,
  ruleId,
  userAgent,
  clientIp,
  url,
  countryOrRegion,
  ruleType,
}

@doc("Name of the pricing tier.")
enum SkuName {
  Standard_Verizon,
  Premium_Verizon,
  Custom_Verizon,
  Standard_Akamai,
  Standard_ChinaCdn,
  Standard_Microsoft,
  Standard_AzureFrontDoor,
  Premium_AzureFrontDoor,
  Standard_955BandWidth_ChinaCdn,
  Standard_AvgBandWidth_ChinaCdn,
  StandardPlus_ChinaCdn,
  StandardPlus_955BandWidth_ChinaCdn,
  StandardPlus_AvgBandWidth_ChinaCdn,
}

@doc("Resource status of the profile.")
enum ProfileResourceState {
  Creating,
  Active,
  Deleting,
  Disabled,
}

@doc("Provisioning status of the profile.")
enum ProfileProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Deleting,
  Creating,
}

@doc("Specifies what scenario the customer wants this CDN endpoint to optimize, e.g. Download, Media services. With this information we can apply scenario driven optimization.")
enum OptimizationType {
  GeneralWebDelivery,
  GeneralMediaStreaming,
  VideoOnDemandMediaStreaming,
  LargeFileDownload,
  DynamicSiteAcceleration,
}

@doc("Unit of the usage. e.g. count.")
enum CdnUsageUnit {
  count,
}

@doc("The approval status for the connection to the Private Link")
enum PrivateEndpointStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

@doc("Resource status of the custom domain.")
enum CustomDomainResourceState {
  Creating,
  Active,
  Deleting,
}

@doc("Provisioning status of the custom domain.")
enum CustomHttpsProvisioningState {
  Enabling,
  Enabled,
  Disabling,
  Disabled,
  Failed,
}

@doc("Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.")
enum CustomHttpsAvailabilityState {
  SubmittingDomainControlValidationRequest,
  PendingDomainControlValidationREquestApproval,
  DomainControlValidationRequestApproved,
  DomainControlValidationRequestRejected,
  DomainControlValidationRequestTimedOut,
  IssuingCertificate,
  DeployingCertificate,
  CertificateDeployed,
  DeletingCertificate,
  CertificateDeleted,
}

@doc("Defines the source of the SSL certificate.")
enum CertificateSource {
  AzureKeyVault,
  Cdn,
}

@doc("Defines the TLS extension protocol that is used for secure delivery.")
enum SecureDeliveryProtocolType {
  ServerNameIndication,
  IPBased,
}

@doc("Resource status of the endpoint.")
enum EndpointResourceState {
  Creating,
  Deleting,
  Running,
  Starting,
  Stopped,
  Stopping,
}

@doc("Provisioning status of the endpoint.")
enum CdnEndpointProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Deleting,
  Creating,
}

enum KeyVaultSigningKeyType {
  KeyVaultSigningKey: "KeyVaultSigningKeyParameters",
}

@doc("Resource status of the origin.")
enum OriginResourceState {
  Creating,
  Active,
  Deleting,
}

@doc("Provisioning status of the origin.")
enum OriginProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Deleting,
  Creating,
}

@doc("Resource status of the origin group.")
enum OriginGroupResourceState {
  Creating,
  Active,
  Deleting,
}

@doc("Provisioning status of the origin group.")
enum OriginGroupProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Deleting,
  Creating,
}

@doc("describes if the policy is in enabled state or disabled state")
enum PolicyEnabledState {
  Disabled,
  Enabled,
}

@doc("Describes if it is in detection mode or prevention mode at policy level.")
enum PolicyMode {
  Prevention,
  Detection,
}

@doc("If the action type is block, this field defines the default customer overridable http response status code.")
enum PolicySettingsDefaultCustomBlockResponseStatusCode {
  `200`: 200,
  `403`: 403,
  `405`: 405,
  `406`: 406,
  `429`: 429,
}

@doc("Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.")
enum CustomRuleEnabledState {
  Disabled,
  Enabled,
}

@doc("Match variable to compare against.")
enum WafMatchVariable {
  RemoteAddr,
  SocketAddr,
  RequestMethod,
  RequestHeader,
  RequestUri,
  QueryString,
  RequestBody,
  Cookies,
  PostArgs,
}

@doc("Describes operator to be matched")
enum MatchOperator {
  Any,
  IPMatch,
  GeoMatch,
  Equal,
  Contains,
  LessThan,
  GreaterThan,
  LessThanOrEqual,
  GreaterThanOrEqual,
  BeginsWith,
  EndsWith,
  RegEx,
}

@doc("Describes what transforms were applied before matching.")
enum TransformType {
  Lowercase,
  Uppercase,
  Trim,
  UrlDecode,
  UrlEncode,
  RemoveNulls,
}

@doc("Defines the action to take on rule match.")
enum OverrideActionType {
  Allow,
  Block,
  Log,
  Redirect,
}

@doc("Describes if the managed rule is in enabled or disabled state. Defaults to Disabled if not specified.")
enum ManagedRuleSetupState {
  Disabled,
  Enabled,
}

@doc("Provisioning state of the WebApplicationFirewallPolicy.")
enum WebApplicationFirewallPolicyProvisioningState {
  Creating,
  Succeeded,
  Failed,
}

@doc("Resource status of the policy.")
enum PolicyResourceState {
  Creating,
  Enabling,
  Enabled,
  Disabling,
  Disabled,
  Deleting,
}

@doc("The validation status.")
enum ValidationStatus {
  Valid,
  Invalid,
  AccessDenied,
  CertificateExpired,
}

enum RemoteAddressMatchConditionType {
  RemoteAddressCondition: "DeliveryRuleRemoteAddressConditionParameters",
}

@doc("Describes operator to be matched")
enum RemoteAddressOperator {
  Any,
  IPMatch,
  GeoMatch,
}

@doc("Describes what transforms are applied before matching")
enum PreTransformCategory {
  Lowercase,
  Uppercase,
  Trim,
  UrlDecode,
  UrlEncode,
  RemoveNulls,
}

enum RequestMethodMatchConditionType {
  RequestMethodCondition: "DeliveryRuleRequestMethodConditionParameters",
}

@doc("Describes operator to be matched")
enum RequestMethodOperator {
  Equal,
}

enum RequestMethodMatchConditionMatchValue {
  GET,
  HEAD,
  POST,
  PUT,
  DELETE,
  OPTIONS,
  TRACE,
}

enum QueryStringMatchConditionType {
  QueryStringCondition: "DeliveryRuleQueryStringConditionParameters",
}

@doc("Describes operator to be matched")
enum QueryStringOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum PostArgsMatchConditionType {
  PostArgsCondition: "DeliveryRulePostArgsConditionParameters",
}

@doc("Describes operator to be matched")
enum PostArgsOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum RequestUriMatchConditionType {
  RequestUriCondition: "DeliveryRuleRequestUriConditionParameters",
}

@doc("Describes operator to be matched")
enum RequestUriOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum RequestHeaderMatchConditionType {
  RequestHeaderCondition: "DeliveryRuleRequestHeaderConditionParameters",
}

@doc("Describes operator to be matched")
enum RequestHeaderOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum RequestBodyMatchConditionType {
  RequestBodyCondition: "DeliveryRuleRequestBodyConditionParameters",
}

@doc("Describes operator to be matched")
enum RequestBodyOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum RequestSchemeMatchConditionType {
  RequestSchemeCondition: "DeliveryRuleRequestSchemeConditionParameters",
}

@doc("Describes operator to be matched")
enum RequestSchemeOperator {
  Equal,
}

enum RequestSchemeMatchConditionMatchValue {
  HTTP,
  HTTPS,
}

enum UrlPathMatchConditionType {
  UrlPathMatchCondition: "DeliveryRuleUrlPathMatchConditionParameters",
}

@doc("Describes operator to be matched")
enum UrlPathOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  Wildcard,
  RegEx,
}

enum UrlFileExtensionMatchConditionType {
  UrlFileExtensionMatchCondition: "DeliveryRuleUrlFileExtensionMatchConditionParameters",
}

@doc("Describes operator to be matched")
enum UrlFileExtensionOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum UrlFileNameMatchConditionType {
  UrlFilenameCondition: "DeliveryRuleUrlFilenameConditionParameters",
}

@doc("Describes operator to be matched")
enum UrlFileNameOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum HttpVersionMatchConditionType {
  HttpVersionCondition: "DeliveryRuleHttpVersionConditionParameters",
}

@doc("Describes operator to be matched")
enum HttpVersionOperator {
  Equal,
}

enum CookiesMatchConditionType {
  CookiesCondition: "DeliveryRuleCookiesConditionParameters",
}

@doc("Describes operator to be matched")
enum CookiesOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum IsDeviceMatchConditionType {
  IsDeviceCondition: "DeliveryRuleIsDeviceConditionParameters",
}

@doc("Describes operator to be matched")
enum IsDeviceOperator {
  Equal,
}

enum IsDeviceMatchConditionMatchValue {
  Mobile,
  Desktop,
}

enum SocketAddressMatchConditionType {
  SocketAddressCondition: "DeliveryRuleSocketAddrConditionParameters",
}

@doc("Describes operator to be matched")
enum SocketAddressOperator {
  Any,
  IPMatch,
}

enum ClientPortMatchConditionType {
  ClientPortCondition: "DeliveryRuleClientPortConditionParameters",
}

@doc("Describes operator to be matched")
enum ClientPortOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum ServerPortMatchConditionType {
  ServerPortCondition: "DeliveryRuleServerPortConditionParameters",
}

@doc("Describes operator to be matched")
enum ServerPortOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum HostNameMatchConditionType {
  HostNameCondition: "DeliveryRuleHostNameConditionParameters",
}

@doc("Describes operator to be matched")
enum HostNameOperator {
  Any,
  Equal,
  Contains,
  BeginsWith,
  EndsWith,
  LessThan,
  LessThanOrEqual,
  GreaterThan,
  GreaterThanOrEqual,
  RegEx,
}

enum SslProtocolMatchConditionType {
  SslProtocolCondition: "DeliveryRuleSslProtocolConditionParameters",
}

@doc("Describes operator to be matched")
enum SslProtocolOperator {
  Equal,
}

@doc("The protocol of an established TLS connection.")
enum SslProtocol {
  TLSv1,
  `TLSv1.1`,
  `TLSv1.2`,
}

enum UrlRedirectActionType {
  UrlRedirectAction: "DeliveryRuleUrlRedirectActionParameters",
}

@doc("The redirect type the rule will use when redirecting traffic.")
enum RedirectType {
  Moved,
  Found,
  TemporaryRedirect,
  PermanentRedirect,
}

@doc("Protocol to use for the redirect. The default value is MatchRequest")
enum DestinationProtocol {
  MatchRequest,
  Http,
  Https,
}

enum UrlSigningActionType {
  UrlSigningAction: "DeliveryRuleUrlSigningActionParameters",
}

@doc("Algorithm to use for URL signing")
enum UrlSigningAlgorithm {
  SHA256,
}

@doc("Indicates the purpose of the parameter")
enum ParamIndicator {
  Expires,
  KeyId,
  Signature,
}

enum OriginGroupOverrideActionType {
  OriginGroupOverrideAction: "DeliveryRuleOriginGroupOverrideActionParameters",
}

enum UrlRewriteActionType {
  UrlRewriteAction: "DeliveryRuleUrlRewriteActionParameters",
}

enum HeaderActionType {
  HeaderAction: "DeliveryRuleHeaderActionParameters",
}

@doc("Action to perform")
enum HeaderAction {
  Append,
  Overwrite,
  Delete,
}

enum CacheExpirationActionType {
  CacheExpirationAction: "DeliveryRuleCacheExpirationActionParameters",
}

@doc("Caching behavior for the requests")
enum CacheBehaviorSetting {
  BypassCache,
  Override,
  SetIfMissing,
}

@doc("The level at which the content needs to be cached.")
enum CacheLevel {
  All,
}

enum CacheKeyQueryStringActionType {
  CacheKeyQueryStringBehaviorAction: "DeliveryRuleCacheKeyQueryStringBehaviorActionParameters",
}

@doc("Caching behavior for the requests")
enum QueryStringBehavior {
  Include,
  IncludeAll,
  Exclude,
  ExcludeAll,
}

enum RouteConfigurationOverrideActionType {
  RouteConfigurationOverrideAction: "DeliveryRuleRouteConfigurationOverrideActionParameters",
}

@doc("Defines how Frontdoor caches requests that include query strings. You can ignore any query strings when caching, ignore specific query strings, cache every request with a unique URL, or cache specific query strings.")
enum RuleQueryStringCachingBehavior {
  IgnoreQueryString,
  UseQueryString,
  IgnoreSpecifiedQueryStrings,
  IncludeSpecifiedQueryStrings,
}

@doc("Indicates whether content compression is enabled. If compression is enabled, content will be served as compressed if user requests for a compressed version. Content won't be compressed on AzureFrontDoor when requested content is smaller than 1 byte or larger than 1 MB.")
enum RuleIsCompressionEnabled {
  Enabled,
  Disabled,
}

@doc("Caching behavior for the requests")
enum RuleCacheBehavior {
  HonorOrigin,
  OverrideAlways,
  OverrideIfOriginMissing,
}

enum CdnCertificateSourceType {
  CdnCertificateSource: "CdnCertificateSourceParameters",
}

@doc("Type of certificate used")
enum CdnManagedCertificateType {
  Shared,
  Dedicated,
}

enum KeyVaultCertificateSourceType {
  KeyVaultCertificateSource: "KeyVaultCertificateSourceParameters",
}

@doc("Describes the action that shall be taken when the certificate is updated in Key Vault.")
enum CertificateUpdateAction {
  NoAction,
}

@doc("Describes the action that shall be taken when the certificate is removed from Key Vault.")
enum CertificateDeleteAction {
  NoAction,
}

@doc("TLS protocol version that will be used for Https")
@fixed
enum FrontDoorMinimumTlsVersion {
  TLS10,
  TLS12,
}

@doc("The type of health probe request that is made.")
@fixed
enum HealthProbeRequestType {
  NotSet,
  GET,
  HEAD,
}

@doc("Protocol to use for health probe.")
@fixed
enum HealthProbeProtocol {
  NotSet,
  Http,
  Https,
}

@doc("Status of the shared private link resource. Can be Pending, Approved, Rejected, Disconnected, or Timeout.")
@fixed
enum SharedPrivateLinkResourceStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

@doc("Type of response errors for real user requests for which origin will be deemed unhealthy")
@fixed
enum ResponseBasedDetectedErrorTypes {
  None,
  TcpErrorsOnly,
  TcpAndHttpErrors,
}

@doc("TLS protocol version that will be used for Https")
@fixed
enum CdnMinimumTlsVersion {
  None,
  TLS10,
  TLS12,
}

@doc("Defines how CDN caches requests that include query strings. You can ignore any query strings when caching, bypass caching to prevent requests that contain query strings from being cached, or cache every request with a unique URL.")
@fixed
enum QueryStringCachingBehavior {
  IgnoreQueryString,
  BypassCaching,
  UseQueryString,
  NotSet,
}

@doc("Action of the geo filter, i.e. allow or block access.")
@fixed
enum GeoFilterActions {
  Block,
  Allow,
}

@doc("Input of CheckNameAvailability API.")
model EndpointNameAvailabilityContent {
  @doc("The resource name to validate.")
  name: string;

  @doc("The type of the resource whose name is to be validated.")
  type: CdnResourceType;

  @doc("Indicates the endpoint name reuse scope. The default value is TenantReuse.")
  autoGeneratedDomainNameLabelScope?: DomainNameLabelScope;
}

@doc("Output of check name availability API.")
model EndpointNameAvailabilityResult {
  @doc("Indicates whether the name is available.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("Returns the available hostname generated based on the AutoGeneratedDomainNameLabelScope when the name is available, otherwise it returns empty string")
  @visibility("read")
  availableHostname?: string;

  @doc("The reason why the name is not available.")
  @visibility("read")
  reason?: string;

  @doc("The detailed error message describing why the name is not available.")
  @visibility("read")
  message?: string;
}

@doc("Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).")
@error
model AfdErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The list usages operation response.")
model UsagesListResult is Azure.Core.Page<FrontDoorUsage>;

@doc("Describes resource usage.")
model FrontDoorUsage {
  @doc("Resource identifier.")
  @visibility("read")
  id?: string;

  @doc("An enum describing the unit of measurement.")
  unit: FrontDoorUsageUnit;

  @doc("The current value of the usage.")
  currentValue: int32;

  @doc("The limit of usage.")
  limit: int32;

  @doc("The name of the type of usage.")
  name: FrontDoorUsageResourceName;
}

@doc("The usage names.")
model FrontDoorUsageResourceName {
  @doc("A string describing the resource name.")
  value?: string;

  @doc("A localized string describing the resource name.")
  localizedValue?: string;
}

@doc("Input of CheckHostNameAvailability API.")
model HostNameAvailabilityContent {
  @doc("The host name to validate.")
  hostName: string;
}

@doc("Output of check name availability API.")
model CdnNameAvailabilityResult {
  @doc("Indicates whether the name is available.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason why the name is not available.")
  @visibility("read")
  reason?: string;

  @doc("The detailed error message describing why the name is not available.")
  @visibility("read")
  message?: string;
}

@doc("The JSON object that contains the properties of the domain to create.")
model AFDDomainProperties {
  ...AFDDomainUpdatePropertiesParameters;
  ...AFDStateProperties;

  @doc("Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step. DCV stands for DomainControlValidation.")
  @visibility("read")
  domainValidationState?: DomainValidationState;

  @doc("The host name of the domain. Must be a domain name.")
  hostName: string;

  @doc("Values the customer needs to validate domain ownership")
  @visibility("read")
  validationProperties?: DomainValidationProperties;
}

@doc("The JSON object that contains the properties to validate a domain.")
model DomainValidationProperties {
  @doc("Challenge used for DNS TXT record or file based validation")
  @visibility("read")
  validationToken?: string;

  @doc("The date time that the token expires")
  @visibility("read")
  @projectedName("json", "expirationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresDate?: utcDateTime;
}

@doc("The JSON object that contains the properties of the domain to create.")
model AFDDomainUpdatePropertiesParameters {
  @doc("The name of the profile which holds the domain.")
  @visibility("read")
  profileName?: string;

  @doc("The configuration specifying how to enable HTTPS for the domain - using AzureFrontDoor managed certificate or user's own certificate. If not specified, enabling ssl uses AzureFrontDoor managed certificate by default.")
  tlsSettings?: AFDDomainHttpsParameters;

  @doc("Resource reference to the Azure DNS zone")
  @projectedName("json", "azureDnsZone")
  dnsZone?: ResourceReference;

  @doc("Resource reference to the Azure resource where custom domain ownership was prevalidated")
  @projectedName("json", "preValidatedCustomDomainResourceId")
  preValidatedCustomDomainResource?: AFDDomainUpdatePropertiesParametersPreValidatedCustomDomainResourceId;
}

@doc("The JSON object that contains the properties to secure a domain.")
model AFDDomainHttpsParameters {
  @doc("Defines the source of the SSL certificate.")
  certificateType: FrontDoorCertificateType;

  @doc("TLS protocol version that will be used for Https")
  minimumTlsVersion?: FrontDoorMinimumTlsVersion;

  @doc("Resource reference to the secret. ie. subs/rg/profile/secret")
  secret?: AFDDomainHttpsParametersSecret;
}

@doc("Resource reference to the secret. ie. subs/rg/profile/secret")
model AFDDomainHttpsParametersSecret {
  @doc("Resource ID.")
  id?: string;
}

@doc("Reference to another resource.")
model ResourceReference {
  @doc("Resource ID.")
  id?: string;
}

@doc("Resource reference to the Azure resource where custom domain ownership was prevalidated")
model AFDDomainUpdatePropertiesParametersPreValidatedCustomDomainResourceId {
  @doc("Resource ID.")
  id?: string;
}

@doc("The tracking states for afd resources.")
model AFDStateProperties {
  @doc("Provisioning status")
  @visibility("read")
  provisioningState?: FrontDoorProvisioningState;

  @visibility("read")
  deploymentStatus?: FrontDoorDeploymentStatus;
}

@doc("The core properties of ARM resources")
model Resource {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("Read only system data")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The domain JSON object required for domain creation or update.")
model AFDDomainUpdateParameters {
  @doc("The JSON object that contains the properties of the domain to create.")
  properties?: AFDDomainUpdatePropertiesParameters;
}

@doc("The JSON object that contains the properties required to create an endpoint.")
model AFDEndpointProperties {
  ...AFDEndpointPropertiesUpdateParameters;
  ...AFDStateProperties;

  @doc("The host name of the endpoint structured as {endpointName}.{DNSZone}, e.g. contoso.azureedge.net")
  @visibility("read")
  hostName?: string;

  @doc("Indicates the endpoint name reuse scope. The default value is TenantReuse.")
  autoGeneratedDomainNameLabelScope?: DomainNameLabelScope;
}

@doc("The JSON object containing endpoint update parameters.")
model AFDEndpointPropertiesUpdateParameters {
  @doc("The name of the profile which holds the endpoint.")
  @visibility("read")
  profileName?: string;

  @doc("Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'")
  enabledState?: EnabledState;
}

@doc("Properties required to create or update an endpoint.")
model AFDEndpointUpdateParameters {
  @doc("Endpoint tags.")
  tags?: Record<string>;

  @doc("The JSON object containing endpoint update parameters.")
  properties?: AFDEndpointPropertiesUpdateParameters;
}

@doc("Parameters required for content purge.")
model FrontDoorPurgeParameters {
  @doc("The path to the content to be purged. Can describe a file path or a wild card directory.")
  contentPaths: string[];

  @doc("List of domains.")
  domains?: string[];
}

@doc("Input of the custom domain to be validated for DNS mapping.")
model ValidateCustomDomainContent {
  @doc("The host name of the custom domain. Must be a domain name.")
  hostName: string;
}

@doc("Output of custom domain validation.")
model ValidateCustomDomainResult {
  @doc("Indicates whether the custom domain is valid or not.")
  @visibility("read")
  @projectedName("json", "customDomainValidated")
  isCustomDomainValid?: boolean;

  @doc("The reason why the custom domain is not valid.")
  @visibility("read")
  reason?: string;

  @doc("Error message describing why the custom domain is not valid.")
  @visibility("read")
  message?: string;
}

@doc("The JSON object that contains the properties of the origin group.")
model AFDOriginGroupProperties {
  ...AFDOriginGroupUpdatePropertiesParameters;
  ...AFDStateProperties;
}

@doc("The JSON object that contains the properties of the origin group.")
model AFDOriginGroupUpdatePropertiesParameters {
  @doc("The name of the profile which holds the origin group.")
  @visibility("read")
  profileName?: string;

  @doc("Load balancing settings for a backend pool")
  loadBalancingSettings?: LoadBalancingSettings;

  @doc("Health probe settings to the origin that is used to determine the health of the origin.")
  healthProbeSettings?: HealthProbeSettings;

  @doc("Time in minutes to shift the traffic to the endpoint gradually when an unhealthy endpoint comes healthy or a new endpoint is added. Default is 10 mins. This property is currently not supported.")
  @maxValue(50)
  @projectedName(
    "json",
    "trafficRestorationTimeToHealedOrNewEndpointsInMinutes"
  )
  trafficRestorationTimeInMinutes?: int32;

  @doc("Whether to allow session affinity on this host. Valid options are 'Enabled' or 'Disabled'")
  sessionAffinityState?: EnabledState;
}

@doc("Round-Robin load balancing settings for a backend pool")
model LoadBalancingSettings {
  @doc("The number of samples to consider for load balancing decisions")
  sampleSize?: int32;

  @doc("The number of samples within the sample period that must succeed")
  successfulSamplesRequired?: int32;

  @doc("The additional latency in milliseconds for probes to fall into the lowest latency bucket")
  additionalLatencyInMilliseconds?: int32;
}

@doc("The JSON object that contains the properties to send health probes to origin.")
model HealthProbeSettings {
  @doc("The path relative to the origin that is used to determine the health of the origin.")
  probePath?: string;

  @doc("The type of health probe request that is made.")
  probeRequestType?: HealthProbeRequestType;

  @doc("Protocol to use for health probe.")
  probeProtocol?: HealthProbeProtocol;

  @doc("The number of seconds between health probes.Default is 240sec.")
  @maxValue(255)
  @minValue(1)
  probeIntervalInSeconds?: int32;
}

@doc("AFDOrigin group properties needed for origin group creation or update.")
model AFDOriginGroupUpdateParameters {
  @doc("The JSON object that contains the properties of the origin group.")
  properties?: AFDOriginGroupUpdatePropertiesParameters;
}

@doc("The JSON object that contains the properties of the origin.")
model AFDOriginProperties {
  ...AFDOriginUpdatePropertiesParameters;
  ...AFDStateProperties;
}

@doc("The JSON object that contains the properties of the origin.")
model AFDOriginUpdatePropertiesParameters {
  @doc("The name of the origin group which contains this origin.")
  @visibility("read")
  originGroupName?: string;

  @doc("Resource reference to the Azure origin resource.")
  @projectedName("json", "azureOrigin")
  origin?: ResourceReference;

  @doc("The address of the origin. Domain names, IPv4 addresses, and IPv6 addresses are supported.This should be unique across all origins in an endpoint.")
  hostName?: string;

  @doc("The value of the HTTP port. Must be between 1 and 65535.")
  @maxValue(65535)
  @minValue(1)
  httpPort?: int32;

  @doc("The value of the HTTPS port. Must be between 1 and 65535.")
  @maxValue(65535)
  @minValue(1)
  httpsPort?: int32;

  @doc("The host header value sent to the origin with each request. If you leave this blank, the request hostname determines this value. Azure CDN origins, such as Web Apps, Blob Storage, and Cloud Services require this host header value to match the origin hostname by default. This overrides the host header defined at Endpoint")
  originHostHeader?: string;

  @doc("Priority of origin in given origin group for load balancing. Higher priorities will not be used for load balancing if any lower priority origin is healthy.Must be between 1 and 5")
  @maxValue(5)
  @minValue(1)
  priority?: int32;

  @doc("Weight of the origin in given origin group for load balancing. Must be between 1 and 1000")
  @maxValue(1000)
  @minValue(1)
  weight?: int32;

  @doc("The properties of the private link resource for private origin.")
  sharedPrivateLinkResource?: SharedPrivateLinkResourceProperties;

  @doc("Whether to enable health probes to be made against backends defined under backendPools. Health probes can only be disabled if there is a single enabled backend in single enabled backend pool.")
  enabledState?: EnabledState;

  @doc("Whether to enable certificate name check at origin level")
  enforceCertificateNameCheck?: boolean;
}

@doc("Describes the properties of an existing Shared Private Link Resource to use when connecting to a private origin.")
model SharedPrivateLinkResourceProperties {
  @doc("The resource id of the resource the shared private link resource is for.")
  privateLink?: ResourceReference;

  @doc("The location of the shared private link resource")
  privateLinkLocation?: string;

  @doc("The group id from the provider of resource the shared private link resource is for.")
  groupId?: string;

  @doc("The request message for requesting approval of the shared private link resource.")
  requestMessage?: string;

  @doc("Status of the shared private link resource. Can be Pending, Approved, Rejected, Disconnected, or Timeout.")
  status?: SharedPrivateLinkResourceStatus;
}

@doc("AFDOrigin properties needed for origin update.")
model AFDOriginUpdateParameters {
  @doc("The JSON object that contains the properties of the origin.")
  properties?: AFDOriginUpdatePropertiesParameters;
}

@doc("The JSON object that contains the properties of the Routes to create.")
model RouteProperties {
  ...RouteUpdatePropertiesParameters;
  ...AFDStateProperties;
}

@doc("The JSON object that contains the properties of the domain to create.")
model RouteUpdatePropertiesParameters {
  @doc("The name of the endpoint which holds the route.")
  @visibility("read")
  endpointName?: string;

  @doc("Domains referenced by this endpoint.")
  customDomains?: FrontDoorActivatedResourceInfo[];

  @doc("A reference to the origin group.")
  originGroup?: ResourceReference;

  @doc("A directory path on the origin that AzureFrontDoor can use to retrieve content from, e.g. contoso.cloudapp.net/originpath.")
  originPath?: string;

  @doc("rule sets referenced by this endpoint.")
  ruleSets?: ResourceReference[];

  @doc("List of supported protocols for this route.")
  supportedProtocols?: FrontDoorEndpointProtocol[];

  @doc("The route patterns of the rule.")
  patternsToMatch?: string[];

  @doc("The caching configuration for this route. To disable caching, do not provide a cacheConfiguration object.")
  cacheConfiguration?: FrontDoorRouteCacheConfiguration;

  @doc("Protocol this rule will use when forwarding traffic to backends.")
  forwardingProtocol?: ForwardingProtocol;

  @doc("whether this route will be linked to the default endpoint domain.")
  linkToDefaultDomain?: LinkToDefaultDomain;

  @doc("Whether to automatically redirect HTTP traffic to HTTPS traffic. Note that this is a easy way to set up this rule and it will be the first rule that gets executed.")
  httpsRedirect?: HttpsRedirect;

  @doc("Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'")
  enabledState?: EnabledState;
}

@doc("Reference to another resource along with its state.")
model FrontDoorActivatedResourceInfo {
  @doc("Resource ID.")
  id?: string;

  @doc("Whether the resource is active or inactive")
  @visibility("read")
  isActive?: boolean;
}

@doc("Caching settings for a caching-type route. To disable caching, do not provide a cacheConfiguration object.")
model FrontDoorRouteCacheConfiguration {
  @doc("Defines how Frontdoor caches requests that include query strings. You can ignore any query strings when caching, ignore specific query strings, cache every request with a unique URL, or cache specific query strings.")
  queryStringCachingBehavior?: FrontDoorQueryStringCachingBehavior;

  @doc("query parameters to include or exclude (comma separated).")
  queryParameters?: string;

  @doc("compression settings.")
  compressionSettings?: RouteCacheCompressionSettings;
}

@doc("settings for compression.")
model RouteCacheCompressionSettings {
  @doc("List of content types on which compression applies. The value should be a valid MIME type.")
  contentTypesToCompress?: string[];

  @doc("Indicates whether content compression is enabled on AzureFrontDoor. Default value is false. If compression is enabled, content will be served as compressed if user requests for a compressed version. Content won't be compressed on AzureFrontDoor when requested content is smaller than 1 byte or larger than 1 MB.")
  isCompressionEnabled?: boolean;
}

@doc("The domain JSON object required for domain creation or update.")
model RouteUpdateParameters {
  @doc("The JSON object that contains the properties of the domain to create.")
  properties?: RouteUpdatePropertiesParameters;
}

@doc("The JSON object that contains the properties of the Rule Set to create.")
model RuleSetProperties extends AFDStateProperties {
  @doc("The name of the profile which holds the rule set.")
  @visibility("read")
  profileName?: string;
}

@doc("The JSON object that contains the properties of the Rules to create.")
model RuleProperties {
  ...RuleUpdatePropertiesParameters;
  ...AFDStateProperties;
}

@doc("The JSON object that contains the properties of the rule to update.")
model RuleUpdatePropertiesParameters {
  @doc("The name of the rule set containing the rule.")
  @visibility("read")
  ruleSetName?: string;

  @doc("The order in which the rules are applied for the endpoint. Possible values {0,1,2,3,………}. A rule with a lesser order will be applied before a rule with a greater order. Rule with order 0 is a special rule. It does not require any condition and actions listed in it will always be applied.")
  order?: int32;

  @doc("A list of conditions that must be matched for the actions to be executed")
  conditions?: DeliveryRuleCondition[];

  @doc("A list of actions that are executed when all the conditions of a rule are satisfied.")
  actions?: DeliveryRuleAction[];

  @doc("If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.")
  matchProcessingBehavior?: MatchProcessingBehavior;
}

@doc("A condition for the delivery rule.")
@discriminator("name")
model DeliveryRuleCondition {}

@doc("An action for the delivery rule.")
@discriminator("name")
model DeliveryRuleAction {}

@doc("The domain JSON object required for domain creation or update.")
model RuleUpdateParameters {
  @doc("The JSON object that contains the properties of the rule to update.")
  properties?: RuleUpdatePropertiesParameters;
}

@doc("The json object that contains properties required to create a security policy")
model SecurityPolicyDetails extends AFDStateProperties {
  @doc("The name of the profile which holds the security policy.")
  @visibility("read")
  profileName?: string;

  @doc("object which contains security policy parameters")
  @projectedName("json", "parameters")
  properties?: SecurityPolicyProperties;
}

@doc("The json object containing security policy parameters")
@discriminator("type")
model SecurityPolicyProperties {}

@doc("The JSON object containing security policy update parameters.")
model SecurityPolicyUpdateParameters {
  @doc("The json object that contains properties required to update a security policy")
  properties?: SecurityPolicyUpdateProperties;
}

@doc("The json object that contains properties required to update a security policy")
model SecurityPolicyUpdateProperties {
  @doc("object which contains security policy parameters")
  @projectedName("json", "parameters")
  properties?: SecurityPolicyProperties;
}

@doc("The JSON object that contains the properties of the Secret to create.")
model SecretDetails extends AFDStateProperties {
  @doc("The name of the profile which holds the secret.")
  @visibility("read")
  profileName?: string;

  @doc("object which contains secret parameters")
  @projectedName("json", "parameters")
  properties?: SecretProperties;
}

@doc("The json object containing secret parameters")
@discriminator("type")
model SecretProperties {}

@doc("Metrics Response")
model MetricsResponse {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeBegin?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeEnd?: utcDateTime;

  granularity?: MetricsResponseGranularity;
  series?: MetricsResponseSeriesItem[];
}

model MetricsResponseSeriesItem {
  metric?: string;
  unit?: MetricsResponseSeriesItemUnit;
  groups?: MetricsResponseSeriesPropertiesItemsItem[];
  data?: Components1Gs0LlpSchemasMetricsresponsePropertiesSeriesItemsPropertiesDataItems[];
}

model MetricsResponseSeriesPropertiesItemsItem {
  name?: string;
  value?: string;
}

model Components1Gs0LlpSchemasMetricsresponsePropertiesSeriesItemsPropertiesDataItems {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTime?: utcDateTime;

  value?: float32;
}

@doc("Rankings Response")
model RankingsResponse {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeBegin?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeEnd?: utcDateTime;

  tables?: RankingsResponseTablesItem[];
}

model RankingsResponseTablesItem {
  ranking?: string;
  data?: RankingsResponseTablesPropertiesItemsItem[];
}

model RankingsResponseTablesPropertiesItemsItem {
  name?: string;
  metrics?: RankingsResponseTablesPropertiesItemsMetricsItem[];
}

model RankingsResponseTablesPropertiesItemsMetricsItem {
  metric?: string;
  value?: int32;
  percentage?: float32;
}

@doc("Continents Response")
model ContinentsResponse {
  continents?: ContinentsResponseContinentsItem[];
  countryOrRegions?: ContinentsResponseCountryOrRegionsItem[];
}

model ContinentsResponseContinentsItem {
  id?: string;
}

model ContinentsResponseCountryOrRegionsItem {
  id?: string;
  continentId?: string;
}

@doc("Resources Response")
model ResourcesResponse {
  endpoints?: ResourcesResponseEndpointsItem[];
  customDomains?: ResourcesResponseCustomDomainsItem[];
}

model ResourcesResponseEndpointsItem {
  id?: string;
  name?: string;
  history?: boolean;
  customDomains?: ResourcesResponseEndpointsPropertiesItemsItem[];
}

model ResourcesResponseEndpointsPropertiesItemsItem {
  id?: string;
  name?: string;
  endpointId?: string;
  history?: boolean;
}

model ResourcesResponseCustomDomainsItem {
  id?: string;
  name?: string;
  endpointId?: string;
  history?: boolean;
}

@doc("Waf Metrics Response")
model WafMetricsResponse {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeBegin?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeEnd?: utcDateTime;

  granularity?: WafMetricsResponseGranularity;
  series?: WafMetricsResponseSeriesItem[];
}

model WafMetricsResponseSeriesItem {
  metric?: string;
  unit?: WafMetricsResponseSeriesItemUnit;
  groups?: WafMetricsResponseSeriesPropertiesItemsItem[];
  data?: Components18OrqelSchemasWafmetricsresponsePropertiesSeriesItemsPropertiesDataItems[];
}

model WafMetricsResponseSeriesPropertiesItemsItem {
  name?: string;
  value?: string;
}

model Components18OrqelSchemasWafmetricsresponsePropertiesSeriesItemsPropertiesDataItems {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTime?: utcDateTime;

  value?: float32;
}

@doc("Waf Rankings Response")
model WafRankingsResponse {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeBegin?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeEnd?: utcDateTime;

  groups?: string[];
  data?: WafRankingsResponseDataItem[];
}

model WafRankingsResponseDataItem {
  groupValues?: string[];
  metrics?: ComponentsKpo1PjSchemasWafrankingsresponsePropertiesDataItemsPropertiesMetricsItems[];
}

model ComponentsKpo1PjSchemasWafrankingsresponsePropertiesDataItemsPropertiesMetricsItems {
  metric?: string;
  value?: int32;
  percentage?: float32;
}

@doc("""
Standard_Verizon = The SKU name for a Standard Verizon CDN profile.
Premium_Verizon = The SKU name for a Premium Verizon CDN profile.
Custom_Verizon = The SKU name for a Custom Verizon CDN profile.
Standard_Akamai = The SKU name for an Akamai CDN profile.
Standard_ChinaCdn = The SKU name for a China CDN profile for VOD, Web and download scenarios using GB based billing model.
Standard_Microsoft = The SKU name for a Standard Microsoft CDN profile.
Standard_AzureFrontDoor =  The SKU name for an Azure Front Door Standard profile.
Premium_AzureFrontDoor = The SKU name for an Azure Front Door Premium profile.
Standard_955BandWidth_ChinaCdn = The SKU name for a China CDN profile for VOD, Web and download scenarios using 95-5 peak bandwidth billing model.
Standard_AvgBandWidth_ChinaCdn = The SKU name for a China CDN profile for VOD, Web and download scenarios using monthly average peak bandwidth billing model.
StandardPlus_ChinaCdn = The SKU name for a China CDN profile for live-streaming using GB based billing model.
StandardPlus_955BandWidth_ChinaCdn = The SKU name for a China CDN live-streaming profile using 95-5 peak bandwidth billing model.
StandardPlus_AvgBandWidth_ChinaCdn = The SKU name for a China CDN live-streaming profile using monthly average peak bandwidth billing model.

""")
model Sku {
  @doc("Name of the pricing tier.")
  name?: SkuName;
}

@doc("The JSON object that contains the properties required to create a profile.")
model ProfileProperties {
  @doc("Resource status of the profile.")
  @visibility("read")
  resourceState?: ProfileResourceState;

  @doc("Provisioning status of the profile.")
  @visibility("read")
  provisioningState?: ProfileProvisioningState;

  @doc("The Id of the frontdoor.")
  @visibility("read")
  frontDoorId?: string;

  @doc("Send and receive timeout on forwarding request to the origin. When timeout is reached, the request fails and returns.")
  @minValue(16)
  originResponseTimeoutSeconds?: int32;
}

@doc("Properties required to update a profile.")
model ProfileUpdateParameters {
  @doc("Profile tags")
  tags?: Record<string>;

  @doc("The JSON object containing profile update parameters.")
  properties?: ProfilePropertiesUpdateParameters;
}

@doc("The JSON object containing profile update parameters.")
model ProfilePropertiesUpdateParameters {
  @doc("Send and receive timeout on forwarding request to the origin. When timeout is reached, the request fails and returns.")
  @minValue(16)
  originResponseTimeoutSeconds?: int32;
}

@doc("The URI required to login to the supplemental portal from the Azure portal.")
model SsoUri {
  @doc("The URI used to login to the supplemental portal.")
  @visibility("read")
  @projectedName("json", "ssoUriValue")
  availableSsoUri?: string;
}

@doc("The result of the GetSupportedOptimizationTypes API")
model SupportedOptimizationTypesListResult {
  @doc("Supported optimization types for a profile.")
  @visibility("read")
  supportedOptimizationTypes?: OptimizationType[];
}

@doc("Output of check resource usage API.")
model ResourceUsageListResult is Azure.Core.Page<CdnUsage>;

@doc("Output of check resource usage API.")
model CdnUsage {
  @doc("Resource type for which the usage is provided.")
  @visibility("read")
  resourceType?: string;

  @doc("Unit of the usage. e.g. count.")
  @visibility("read")
  unit?: CdnUsageUnit;

  @doc("Actual value of usage on the specified resource type.")
  @visibility("read")
  currentValue?: int32;

  @doc("Quota of the specified resource type.")
  @visibility("read")
  limit?: int32;
}

@doc("The JSON object that contains the properties required to create an endpoint.")
model EndpointProperties extends EndpointPropertiesUpdateParameters {
  @doc("The host name of the endpoint structured as {endpointName}.{DNSZone}, e.g. contoso.azureedge.net")
  @visibility("read")
  hostName?: string;

  @doc("The source of the content being delivered via CDN.")
  origins: DeepCreatedOrigin[];

  @doc("The origin groups comprising of origins that are used for load balancing the traffic based on availability.")
  originGroups?: DeepCreatedOriginGroup[];

  @doc("The custom domains under the endpoint.")
  @visibility("read")
  customDomains?: CdnCustomDomain[];

  @doc("Resource status of the endpoint.")
  @visibility("read")
  resourceState?: EndpointResourceState;

  @doc("Provisioning status of the endpoint.")
  @visibility("read")
  provisioningState?: CdnEndpointProvisioningState;
}

@doc("The main origin of CDN content which is added when creating a CDN endpoint.")
model DeepCreatedOrigin {
  @doc("Origin name which must be unique within the endpoint. ")
  name: string;

  @doc("Properties of the origin created on the CDN endpoint.")
  properties?: DeepCreatedOriginProperties;
}

@doc("Properties of the origin created on the CDN endpoint.")
model DeepCreatedOriginProperties {
  @doc("The address of the origin. It can be a domain name, IPv4 address, or IPv6 address. This should be unique across all origins in an endpoint.")
  hostName: string;

  @doc("The value of the HTTP port. Must be between 1 and 65535.")
  @maxValue(65535)
  @minValue(1)
  httpPort?: int32;

  @doc("The value of the HTTPS port. Must be between 1 and 65535.")
  @maxValue(65535)
  @minValue(1)
  httpsPort?: int32;

  @doc("The host header value sent to the origin with each request. If you leave this blank, the request hostname determines this value. Azure CDN origins, such as Web Apps, Blob Storage, and Cloud Services require this host header value to match the origin hostname by default.")
  originHostHeader?: string;

  @doc("Priority of origin in given origin group for load balancing. Higher priorities will not be used for load balancing if any lower priority origin is healthy.Must be between 1 and 5.")
  @maxValue(5)
  @minValue(1)
  priority?: int32;

  @doc("Weight of the origin in given origin group for load balancing. Must be between 1 and 1000")
  @maxValue(1000)
  @minValue(1)
  weight?: int32;

  @doc("Origin is enabled for load balancing or not. By default, origin is always enabled.")
  enabled?: boolean;

  @doc("The Alias of the Private Link resource. Populating this optional field indicates that this origin is 'Private'")
  privateLinkAlias?: string;

  @doc("The Resource Id of the Private Link resource. Populating this optional field indicates that this backend is 'Private'")
  privateLinkResourceId?: string;

  @doc("The location of the Private Link resource. Required only if 'privateLinkResourceId' is populated")
  privateLinkLocation?: string;

  @doc("A custom message to be included in the approval request to connect to the Private Link.")
  privateLinkApprovalMessage?: string;

  @doc("The approval status for the connection to the Private Link")
  @visibility("read")
  privateEndpointStatus?: PrivateEndpointStatus;
}

@doc("The origin group for CDN content which is added when creating a CDN endpoint. Traffic is sent to the origins within the origin group based on origin health.")
model DeepCreatedOriginGroup {
  @doc("Origin group name which must be unique within the endpoint.")
  name: string;

  @doc("Properties of the origin group created on the CDN endpoint.")
  properties?: DeepCreatedOriginGroupProperties;
}

@doc("Properties of the origin group created on the CDN endpoint.")
model DeepCreatedOriginGroupProperties {
  @doc("Health probe settings to the origin that is used to determine the health of the origin.")
  healthProbeSettings?: HealthProbeSettings;

  @doc("The source of the content being delivered via CDN within given origin group.")
  origins: ResourceReference[];

  @doc("Time in minutes to shift the traffic to the endpoint gradually when an unhealthy endpoint comes healthy or a new endpoint is added. Default is 10 mins. This property is currently not supported.")
  @maxValue(50)
  trafficRestorationTimeToHealedOrNewEndpointsInMinutes?: int32;

  @doc("The JSON object that contains the properties to determine origin health using real requests/responses.This property is currently not supported.")
  responseBasedOriginErrorDetectionSettings?: ResponseBasedOriginErrorDetectionSettings;
}

@doc("The JSON object that contains the properties to determine origin health using real requests/responses.")
model ResponseBasedOriginErrorDetectionSettings {
  @doc("Type of response errors for real user requests for which origin will be deemed unhealthy")
  @projectedName("json", "responseBasedDetectedErrorTypes")
  responseBasedDetectedErrorType?: ResponseBasedDetectedErrorTypes;

  @doc("The percentage of failed requests in the sample where failover should trigger.")
  @maxValue(100)
  responseBasedFailoverThresholdPercentage?: int32;

  @doc("The list of Http status code ranges that are considered as server errors for origin and it is marked as unhealthy.")
  httpErrorRanges?: HttpErrorRange[];
}

@doc("The JSON object that represents the range for http status codes")
model HttpErrorRange {
  @doc("The inclusive start of the http status code range.")
  @maxValue(999)
  @minValue(100)
  begin?: int32;

  @doc("The inclusive end of the http status code range.")
  @maxValue(999)
  @minValue(100)
  end?: int32;
}

@doc("The JSON object that contains the properties of the custom domain to create.")
model CustomDomainProperties {
  @doc("The host name of the custom domain. Must be a domain name.")
  hostName: string;

  @doc("Resource status of the custom domain.")
  @visibility("read")
  resourceState?: CustomDomainResourceState;

  @doc("Provisioning status of the custom domain.")
  @visibility("read")
  customHttpsProvisioningState?: CustomHttpsProvisioningState;

  @doc("Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.")
  @visibility("read")
  @projectedName("json", "customHttpsProvisioningSubstate")
  customHttpsAvailabilityState?: CustomHttpsAvailabilityState;

  @doc("Certificate parameters for securing custom HTTPS")
  @projectedName("json", "customHttpsParameters")
  customDomainHttpsContent?: CustomDomainHttpsParameters;

  @doc("Special validation or data may be required when delivering CDN to some regions due to local compliance reasons. E.g. ICP license number of a custom domain is required to deliver content in China.")
  validationData?: string;

  @doc("Provisioning status of Custom Https of the custom domain.")
  @visibility("read")
  provisioningState?: CustomHttpsProvisioningState;
}

@doc("The JSON object that contains the properties to secure a custom domain.")
@discriminator("certificateSource")
model CustomDomainHttpsParameters {
  @doc("Defines the TLS extension protocol that is used for secure delivery.")
  protocolType: SecureDeliveryProtocolType;

  @doc("TLS protocol version that will be used for Https")
  minimumTlsVersion?: CdnMinimumTlsVersion;
}

@doc("The JSON object containing endpoint update parameters.")
model EndpointPropertiesUpdateParameters {
  @doc("A directory path on the origin that CDN can use to retrieve content from, e.g. contoso.cloudapp.net/originpath.")
  originPath?: string;

  @doc("List of content types on which compression applies. The value should be a valid MIME type.")
  contentTypesToCompress?: string[];

  @doc("The host header value sent to the origin with each request. This property at Endpoint is only allowed when endpoint uses single origin and can be overridden by the same property specified at origin.If you leave this blank, the request hostname determines this value. Azure CDN origins, such as Web Apps, Blob Storage, and Cloud Services require this host header value to match the origin hostname by default.")
  originHostHeader?: string;

  @doc("Indicates whether content compression is enabled on CDN. Default value is false. If compression is enabled, content will be served as compressed if user requests for a compressed version. Content won't be compressed on CDN when requested content is smaller than 1 byte or larger than 1 MB.")
  isCompressionEnabled?: boolean;

  @doc("Indicates whether HTTP traffic is allowed on the endpoint. Default value is true. At least one protocol (HTTP or HTTPS) must be allowed.")
  isHttpAllowed?: boolean;

  @doc("Indicates whether HTTPS traffic is allowed on the endpoint. Default value is true. At least one protocol (HTTP or HTTPS) must be allowed.")
  isHttpsAllowed?: boolean;

  @doc("Defines how CDN caches requests that include query strings. You can ignore any query strings when caching, bypass caching to prevent requests that contain query strings from being cached, or cache every request with a unique URL.")
  queryStringCachingBehavior?: QueryStringCachingBehavior;

  @doc("Specifies what scenario the customer wants this CDN endpoint to optimize for, e.g. Download, Media services. With this information, CDN can apply scenario driven optimization.")
  optimizationType?: OptimizationType;

  @doc("Path to a file hosted on the origin which helps accelerate delivery of the dynamic content and calculate the most optimal routes for the CDN. This is relative to the origin path. This property is only relevant when using a single origin.")
  probePath?: string;

  @doc("List of rules defining the user's geo access within a CDN endpoint. Each geo filter defines an access rule to a specified path or content, e.g. block APAC for path /pictures/")
  geoFilters?: GeoFilter[];

  @doc("A reference to the origin group.")
  defaultOriginGroup?: EndpointPropertiesUpdateParametersDefaultOriginGroup;

  @doc("List of keys used to validate the signed URL hashes.")
  urlSigningKeys?: UrlSigningKey[];

  @doc("A policy that specifies the delivery rules to be used for an endpoint.")
  deliveryPolicy?: EndpointPropertiesUpdateParametersDeliveryPolicy;

  @doc("Defines the Web Application Firewall policy for the endpoint (if applicable)")
  webApplicationFirewallPolicyLink?: EndpointPropertiesUpdateParametersWebApplicationFirewallPolicyLink;
}

@doc("Rules defining user's geo access within a CDN endpoint.")
model GeoFilter {
  @doc("Relative path applicable to geo filter. (e.g. '/mypictures', '/mypicture/kitty.jpg', and etc.)")
  relativePath: string;

  @doc("Action of the geo filter, i.e. allow or block access.")
  action: GeoFilterActions;

  @doc("Two letter country or region codes defining user country or region access in a geo filter, e.g. AU, MX, US.")
  countryCodes: string[];
}

@doc("A reference to the origin group.")
model EndpointPropertiesUpdateParametersDefaultOriginGroup {
  @doc("Resource ID.")
  id?: string;
}

@doc("Url signing key")
model UrlSigningKey {
  @doc("Defines the customer defined key Id. This id will exist in the incoming request to indicate the key used to form the hash.")
  keyId: string;

  @doc("Defines the parameters for using customer key vault for Url Signing Key.")
  keySourceParameters: KeyVaultSigningKey;
}

@doc("Describes the parameters for using a user's KeyVault for URL Signing Key.")
model KeyVaultSigningKey {
  @projectedName("json", "typeName")
  type: KeyVaultSigningKeyType;

  @doc("Subscription Id of the user's Key Vault containing the secret")
  subscriptionId: string;

  @doc("Resource group of the user's Key Vault containing the secret")
  resourceGroupName: string;

  @doc("The name of the user's Key Vault containing the secret")
  vaultName: string;

  @doc("The name of secret in Key Vault.")
  secretName: string;

  @doc("The version(GUID) of secret in Key Vault.")
  secretVersion: string;
}

@doc("A policy that specifies the delivery rules to be used for an endpoint.")
model EndpointPropertiesUpdateParametersDeliveryPolicy {
  @doc("User-friendly description of the policy.")
  description?: string;

  @doc("A list of the delivery rules.")
  rules: DeliveryRule[];
}

@doc("A rule that specifies a set of actions and conditions")
model DeliveryRule {
  @doc("Name of the rule")
  name?: string;

  @doc("The order in which the rules are applied for the endpoint. Possible values {0,1,2,3,………}. A rule with a lesser order will be applied before a rule with a greater order. Rule with order 0 is a special rule. It does not require any condition and actions listed in it will always be applied.")
  order: int32;

  @doc("A list of conditions that must be matched for the actions to be executed")
  conditions?: DeliveryRuleCondition[];

  @doc("A list of actions that are executed when all the conditions of a rule are satisfied.")
  actions: DeliveryRuleAction[];
}

@doc("Defines the Web Application Firewall policy for the endpoint (if applicable)")
model EndpointPropertiesUpdateParametersWebApplicationFirewallPolicyLink {
  @doc("Resource ID.")
  id?: string;
}

@doc("Properties required to create or update an endpoint.")
model EndpointUpdateParameters {
  @doc("Endpoint tags.")
  tags?: Record<string>;

  @doc("The JSON object containing endpoint update parameters.")
  properties?: EndpointPropertiesUpdateParameters;
}

@doc("Parameters required for content purge.")
model PurgeParameters {
  @doc("The path to the content to be purged. Can describe a file path or a wild card directory.")
  contentPaths: string[];
}

@doc("Parameters required for content load.")
model LoadParameters {
  @doc("The path to the content to be loaded. Path should be a relative file URL of the origin.")
  contentPaths: string[];
}

@doc("The JSON object that contains the properties of the origin.")
model OriginProperties extends OriginUpdatePropertiesParameters {
  @doc("Resource status of the origin.")
  @visibility("read")
  resourceState?: OriginResourceState;

  @doc("Provisioning status of the origin.")
  @visibility("read")
  provisioningState?: OriginProvisioningState;

  @doc("The approval status for the connection to the Private Link")
  @visibility("read")
  privateEndpointStatus?: PrivateEndpointStatus;
}

@doc("The JSON object that contains the properties of the origin.")
model OriginUpdatePropertiesParameters {
  @doc("The address of the origin. Domain names, IPv4 addresses, and IPv6 addresses are supported.This should be unique across all origins in an endpoint.")
  hostName?: string;

  @doc("The value of the HTTP port. Must be between 1 and 65535.")
  @maxValue(65535)
  @minValue(1)
  httpPort?: int32;

  @doc("The value of the HTTPS port. Must be between 1 and 65535.")
  @maxValue(65535)
  @minValue(1)
  httpsPort?: int32;

  @doc("The host header value sent to the origin with each request. If you leave this blank, the request hostname determines this value. Azure CDN origins, such as Web Apps, Blob Storage, and Cloud Services require this host header value to match the origin hostname by default. This overrides the host header defined at Endpoint")
  originHostHeader?: string;

  @doc("Priority of origin in given origin group for load balancing. Higher priorities will not be used for load balancing if any lower priority origin is healthy.Must be between 1 and 5")
  @maxValue(5)
  @minValue(1)
  priority?: int32;

  @doc("Weight of the origin in given origin group for load balancing. Must be between 1 and 1000")
  @maxValue(1000)
  @minValue(1)
  weight?: int32;

  @doc("Origin is enabled for load balancing or not")
  enabled?: boolean;

  @doc("The Alias of the Private Link resource. Populating this optional field indicates that this origin is 'Private'")
  privateLinkAlias?: string;

  @doc("The Resource Id of the Private Link resource. Populating this optional field indicates that this backend is 'Private'")
  privateLinkResourceId?: string;

  @doc("The location of the Private Link resource. Required only if 'privateLinkResourceId' is populated")
  privateLinkLocation?: string;

  @doc("A custom message to be included in the approval request to connect to the Private Link.")
  privateLinkApprovalMessage?: string;
}

@doc("Origin properties needed for origin update.")
model OriginUpdateParameters {
  @doc("The JSON object that contains the properties of the origin.")
  properties?: OriginUpdatePropertiesParameters;
}

@doc("The JSON object that contains the properties of the origin group.")
model OriginGroupProperties extends OriginGroupUpdatePropertiesParameters {
  @doc("Resource status of the origin group.")
  @visibility("read")
  resourceState?: OriginGroupResourceState;

  @doc("Provisioning status of the origin group.")
  @visibility("read")
  provisioningState?: OriginGroupProvisioningState;
}

@doc("The JSON object that contains the properties of the origin group.")
model OriginGroupUpdatePropertiesParameters {
  @doc("Health probe settings to the origin that is used to determine the health of the origin.")
  healthProbeSettings?: HealthProbeSettings;

  @doc("The source of the content being delivered via CDN within given origin group.")
  origins?: ResourceReference[];

  @doc("Time in minutes to shift the traffic to the endpoint gradually when an unhealthy endpoint comes healthy or a new endpoint is added. Default is 10 mins. This property is currently not supported.")
  @maxValue(50)
  trafficRestorationTimeToHealedOrNewEndpointsInMinutes?: int32;

  @doc("The JSON object that contains the properties to determine origin health using real requests/responses. This property is currently not supported.")
  responseBasedOriginErrorDetectionSettings?: ResponseBasedOriginErrorDetectionSettings;
}

@doc("Origin group properties needed for origin group creation or update.")
model OriginGroupUpdateParameters {
  @doc("The JSON object that contains the properties of the origin group.")
  properties?: OriginGroupUpdatePropertiesParameters;
}

@doc("The customDomain JSON object required for custom domain creation or update.")
model CustomDomainParameters {
  @doc("The JSON object that contains the properties of the custom domain to create.")
  properties?: CustomDomainPropertiesParameters;
}

@doc("The JSON object that contains the properties of the custom domain to create.")
model CustomDomainPropertiesParameters {
  @doc("The host name of the custom domain. Must be a domain name.")
  hostName: string;
}

@doc("Input of CheckNameAvailability API.")
model CdnNameAvailabilityContent {
  @doc("The resource name to validate.")
  name: string;

  @doc("The type of the resource whose name is to be validated.")
  type: CdnResourceType;
}

@doc("Input of the validate probe API.")
model ValidateProbeInput {
  @doc("The probe URL to validate.")
  probeURL: string;
}

@doc("Output of the validate probe API.")
model ValidateProbeResult {
  @doc("Indicates whether the probe URL is accepted or not.")
  @visibility("read")
  isValid?: boolean;

  @doc("Specifies the error code when the probe url is not accepted.")
  @visibility("read")
  errorCode?: string;

  @doc("The detailed error message describing why the probe URL is not accepted.")
  @visibility("read")
  message?: string;
}

@doc("Properties of operation, include metric specifications.")
model OperationProperties {
  @doc("One property of operation, include metric specifications.")
  serviceSpecification?: ServiceSpecification;
}

@doc("One property of operation, include log specifications.")
model ServiceSpecification {
  @doc("Log specifications of operation.")
  logSpecifications?: LogSpecification[];

  @doc("Metric specifications of operation.")
  metricSpecifications?: MetricSpecification[];
}

@doc("Log specification of operation.")
model LogSpecification {
  @doc("Name of log specification.")
  name?: string;

  @doc("Display name of log specification.")
  displayName?: string;

  @doc("Blob duration of specification.")
  blobDuration?: string;

  @doc("Pattern to filter based on name")
  logFilterPattern?: string;
}

@doc("Metric specification of operation.")
model MetricSpecification {
  @doc("Name of metric specification.")
  name?: string;

  @doc("Display name of metric specification.")
  displayName?: string;

  @doc("Display description of metric specification.")
  displayDescription?: string;

  @doc("The metric unit. Possible values include: 'Bytes', 'Count', 'Milliseconds'.")
  unit?: string;

  @doc("The metric aggregation type. Possible values include: 'Average', 'Count', 'Total'.")
  aggregationType?: string;

  @doc("Retention policies of a resource metric.")
  availabilities?: MetricAvailability[];

  @doc("The supported time grain types for the metrics.")
  supportedTimeGrainTypes?: string[];

  @doc("The dimensions of metric")
  dimensions?: DimensionProperties[];

  @doc("Property to specify whether to fill gap with zero.")
  fillGapWithZero?: boolean;

  @doc("Pattern to filter based on name")
  metricFilterPattern?: string;

  @doc("Property to specify metric is internal or not.")
  isInternal?: boolean;
}

@doc("Retention policy of a resource metric.")
model MetricAvailability {
  timeGrain?: string;
  blobDuration?: string;
}

@doc("Type of operation: get, read, delete, etc.")
model DimensionProperties {
  @doc("Name of dimension.")
  name?: string;

  @doc("Display name of dimension.")
  displayName?: string;

  @doc("Internal name of dimension.")
  internalName?: string;
}

@doc("Result of the request to list CDN edgenodes. It contains a list of ip address group and a URL link to get the next set of results.")
model EdgenodeResult is Azure.Core.Page<EdgeNode>;

@doc("Edgenode is a global Point of Presence (POP) location used to deliver CDN content to end users.")
model EdgeNode extends ProxyResource {
  @doc("The JSON object that contains the properties required to create an edgenode.")
  properties?: EdgeNodeProperties;
}

@doc("The JSON object that contains the properties required to create an edgenode.")
model EdgeNodeProperties {
  @doc("List of ip address groups.")
  ipAddressGroups: IpAddressGroup[];
}

@doc("CDN Ip address group")
model IpAddressGroup {
  @doc("The delivery region of the ip address group")
  deliveryRegion?: string;

  @doc("The list of ip v4 addresses.")
  ipv4Addresses?: CidrIpAddress[];

  @doc("The list of ip v6 addresses.")
  ipv6Addresses?: CidrIpAddress[];
}

@doc("CIDR Ip address")
model CidrIpAddress {
  @doc("Ip address itself.")
  baseIpAddress?: string;

  @doc("The length of the prefix of the ip address.")
  prefixLength?: int32;
}

@doc("Defines CDN web application firewall policy properties.")
model CdnWebApplicationFirewallPolicyProperties {
  @doc("Describes  policySettings for policy")
  policySettings?: WafPolicySettings;

  @doc("Describes rate limit rules inside the policy.")
  @projectedName("json", "rateLimitRules")
  rateLimitSettings?: RateLimitRuleList;

  @doc("Describes custom rules inside the policy.")
  @projectedName("json", "customRules")
  customSettings?: CustomRuleList;

  @doc("Describes managed rules inside the policy.")
  managedRules?: ManagedRuleSetList;

  @doc("Describes Azure CDN endpoints associated with this Web Application Firewall policy.")
  @visibility("read")
  endpointLinks?: CdnEndpointReference[];

  @doc("Provisioning state of the WebApplicationFirewallPolicy.")
  @visibility("read")
  provisioningState?: WebApplicationFirewallPolicyProvisioningState;

  @doc("Resource status of the policy.")
  @visibility("read")
  resourceState?: PolicyResourceState;
}

@doc("Defines contents of a web application firewall global configuration")
model WafPolicySettings {
  @doc("describes if the policy is in enabled state or disabled state")
  enabledState?: PolicyEnabledState;

  @doc("Describes if it is in detection mode or prevention mode at policy level.")
  mode?: PolicyMode;

  @doc("If action type is redirect, this field represents the default redirect URL for the client.")
  defaultRedirectUrl?: string;

  @doc("If the action type is block, this field defines the default customer overridable http response status code.")
  defaultCustomBlockResponseStatusCode?: PolicySettingsDefaultCustomBlockResponseStatusCode;

  @doc("If the action type is block, customer can override the response body. The body must be specified in base64 encoding.")
  @pattern("^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$")
  defaultCustomBlockResponseBody?: string;
}

@doc("Defines contents of rate limit rules")
model RateLimitRuleList {
  @doc("List of rules")
  rules?: RateLimitRule[];
}

@doc("Defines a rate limiting rule that can be included in a waf policy")
model RateLimitRule extends CustomRule {
  @doc("Defines rate limit threshold.")
  rateLimitThreshold: int32;

  @doc("Defines rate limit duration. Default is 1 minute.")
  @maxValue(60)
  rateLimitDurationInMinutes: int32;
}

@doc("Defines the common attributes for a custom rule that can be included in a waf policy")
model CustomRule {
  @doc("Defines the name of the custom rule")
  name: string;

  @doc("Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.")
  enabledState?: CustomRuleEnabledState;

  @doc("Defines in what order this rule be evaluated in the overall list of custom rules")
  @maxValue(1000)
  priority: int32;

  @doc("List of match conditions.")
  matchConditions: CustomRuleMatchCondition[];

  @doc("Describes what action to be applied when rule matches")
  action: OverrideActionType;
}

@doc("Define match conditions")
model CustomRuleMatchCondition {
  @doc("Match variable to compare against.")
  matchVariable: WafMatchVariable;

  @doc("Selector can used to match a specific key for QueryString, Cookies, RequestHeader or PostArgs.")
  selector?: string;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  matchOperator: MatchOperator;

  @doc("Describes if the result of this condition should be negated.")
  negateCondition?: boolean;

  @doc("List of possible match values.")
  matchValue: string[];

  @doc("List of transforms.")
  transforms?: TransformType[];
}

@doc("Defines contents of custom rules")
model CustomRuleList {
  @doc("List of rules")
  rules?: CustomRule[];
}

@doc("Defines the list of managed rule sets for the policy.")
model ManagedRuleSetList {
  @doc("List of rule sets.")
  managedRuleSets?: WafPolicyManagedRuleSet[];
}

@doc("Defines a managed rule set.")
model WafPolicyManagedRuleSet {
  @doc("Defines the rule set type to use.")
  ruleSetType: string;

  @doc("Defines the version of the rule set to use.")
  ruleSetVersion: string;

  @doc("Verizon only : If the rule set supports anomaly detection mode, this describes the threshold for blocking requests.")
  @maxValue(20)
  anomalyScore?: int32;

  @doc("Defines the rule overrides to apply to the rule set.")
  ruleGroupOverrides?: ManagedRuleGroupOverrideSetting[];
}

@doc("Defines a managed rule group override setting.")
model ManagedRuleGroupOverrideSetting {
  @doc("Describes the managed rule group within the rule set to override")
  ruleGroupName: string;

  @doc("List of rules that will be disabled. If none specified, all rules in the group will be disabled.")
  rules?: ManagedRuleOverrideSetting[];
}

@doc("Defines a managed rule group override setting.")
model ManagedRuleOverrideSetting {
  @doc("Identifier for the managed rule.")
  ruleId: string;

  @doc("Describes if the managed rule is in enabled or disabled state. Defaults to Disabled if not specified.")
  enabledState?: ManagedRuleSetupState;

  @doc("Describes the override action to be applied when rule matches.")
  action?: OverrideActionType;
}

@doc("Defines the ARM Resource ID for the linked endpoints")
model CdnEndpointReference {
  @doc("ARM Resource ID string.")
  id?: string;
}

@doc("Properties required to update a CdnWebApplicationFirewallPolicy.")
model CdnWebApplicationFirewallPolicyPatchParameters {
  @doc("CdnWebApplicationFirewallPolicy tags")
  tags?: Record<string>;
}

@doc("List of managed rule set definitions available for use in a policy.")
model ManagedRuleSetDefinitionList is Azure.Core.Page<ManagedRuleSetDefinition>;

@doc("Describes a managed rule set definition.")
model ManagedRuleSetDefinition extends Resource {
  @doc("Describes managed rule set definition properties.")
  properties?: ManagedRuleSetDefinitionProperties;

  @doc("The pricing tier (defines a CDN provider, feature list and rate) of the CdnWebApplicationFirewallPolicy.")
  sku?: Sku;
}

@doc("Properties for a managed rule set definition.")
model ManagedRuleSetDefinitionProperties {
  @doc("Provisioning state of the managed rule set.")
  @visibility("read")
  provisioningState?: string;

  @doc("Type of the managed rule set.")
  @visibility("read")
  ruleSetType?: string;

  @doc("Version of the managed rule set type.")
  @visibility("read")
  ruleSetVersion?: string;

  @doc("Rule groups of the managed rule set.")
  @visibility("read")
  ruleGroups?: ManagedRuleGroupDefinition[];
}

@doc("Describes a managed rule group.")
model ManagedRuleGroupDefinition {
  @doc("Name of the managed rule group.")
  @visibility("read")
  ruleGroupName?: string;

  @doc("Description of the managed rule group.")
  @visibility("read")
  description?: string;

  @doc("List of rules within the managed rule group.")
  @visibility("read")
  rules?: ManagedRuleDefinition[];
}

@doc("Describes a managed rule definition.")
model ManagedRuleDefinition {
  @doc("Identifier for the managed rule.")
  @visibility("read")
  ruleId?: string;

  @doc("Describes the functionality of the managed rule.")
  @visibility("read")
  description?: string;
}

@doc("Certificate used for https")
model Certificate {
  @doc("The type of the secret resource.")
  type?: SecretType;

  @doc("Subject name in the certificate.")
  @visibility("read")
  subject?: string;

  @doc("Certificate expiration date.")
  @visibility("read")
  expirationDate?: string;
}

@doc("Managed Certificate used for https")
model ManagedCertificate extends Certificate {}

@doc("Customer Certificate used for https")
model CustomerCertificate extends Certificate {
  @doc("Resource reference to the Azure Key Vault certificate. Expected to be in format of /subscriptions/{​​​​​​​​​subscriptionId}​​​​​​​​​/resourceGroups/{​​​​​​​​​resourceGroupName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/providers/Microsoft.KeyVault/vaults/{vaultName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/secrets/{certificateName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​")
  secretSource?: ResourceReference;

  @doc("Certificate version.")
  secretVersion?: string;

  @doc("Certificate issuing authority.")
  @visibility("read")
  certificateAuthority?: string;

  @doc("Whether to use the latest version for the certificate")
  useLatestVersion?: boolean;

  @doc("The list of SANs.")
  subjectAlternativeNames?: string[];

  @doc("Certificate thumbprint.")
  @visibility("read")
  thumbprint?: string;
}

@doc("Azure FirstParty Managed Certificate provided by other first party resource providers to enable HTTPS.")
model AzureFirstPartyManagedCertificate extends Certificate {}

@doc("Input of the secret to be validated.")
model ValidateSecretInput {
  @doc("The secret type.")
  secretType: SecretType;

  @doc("Resource reference to the Azure Key Vault secret. Expected to be in format of /subscriptions/{​​​​​​​​​subscriptionId}​​​​​​​​​/resourceGroups/{​​​​​​​​​resourceGroupName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/providers/Microsoft.KeyVault/vaults/{vaultName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/secrets/{secretName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​")
  secretSource: ResourceReference;

  @doc("Secret version, if customer is using a specific version.")
  secretVersion?: string;
}

@doc("Output of the validated secret.")
model ValidateSecretResult {
  @doc("The validation status.")
  status?: ValidationStatus;

  @doc("Detailed error message")
  message?: string;
}

@doc("The json object containing security policy waf parameters")
model SecurityPolicyWebApplicationFirewall extends SecurityPolicyProperties {
  @doc("Resource ID.")
  wafPolicy?: ResourceReference;

  @doc("Waf associations")
  associations?: SecurityPolicyWebApplicationFirewallAssociation[];

  @doc("The type of the Security policy to create.")
  type: "WebApplicationFirewall";
}

@doc("settings for security policy patterns to match")
model SecurityPolicyWebApplicationFirewallAssociation {
  @doc("List of domains.")
  domains?: FrontDoorActivatedResourceInfo[];

  @doc("List of paths")
  patternsToMatch?: string[];
}

@doc("Url signing key parameters")
model UriSigningKeyProperties extends SecretProperties {
  @doc("Defines the customer defined key Id. This id will exist in the incoming request to indicate the key used to form the hash.")
  keyId: string;

  @doc("Resource reference to the Azure Key Vault secret. Expected to be in format of /subscriptions/{​​​​​​​​​subscriptionId}​​​​​​​​​/resourceGroups/{​​​​​​​​​resourceGroupName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/providers/Microsoft.KeyVault/vaults/{vaultName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/secrets/{secretName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​")
  secretSource: ResourceReference;

  @doc("Version of the secret to be used")
  secretVersion?: string;

  @doc("The type of the secret resource.")
  type: "UrlSigningKey";
}

@doc("Managed Certificate used for https")
model ManagedCertificateProperties extends SecretProperties {
  @doc("Subject name in the certificate.")
  @visibility("read")
  subject?: string;

  @doc("Certificate expiration date.")
  @visibility("read")
  @projectedName("json", "expirationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresDate?: utcDateTime;

  @doc("The type of the secret resource.")
  type: "ManagedCertificate";
}

@doc("Customer Certificate used for https")
model CustomerCertificateProperties extends SecretProperties {
  @doc("Resource reference to the Azure Key Vault certificate. Expected to be in format of /subscriptions/{​​​​​​​​​subscriptionId}​​​​​​​​​/resourceGroups/{​​​​​​​​​resourceGroupName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/providers/Microsoft.KeyVault/vaults/{vaultName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/secrets/{certificateName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​")
  secretSource: ResourceReference;

  @doc("Version of the secret to be used")
  secretVersion?: string;

  @doc("Whether to use the latest version for the certificate")
  useLatestVersion?: boolean;

  @doc("Subject name in the certificate.")
  @visibility("read")
  subject?: string;

  @doc("Certificate expiration date.")
  @visibility("read")
  @projectedName("json", "expirationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresDate?: utcDateTime;

  @doc("Certificate issuing authority.")
  @visibility("read")
  certificateAuthority?: string;

  @doc("The list of SANs.")
  subjectAlternativeNames?: string[];

  @doc("Certificate thumbprint.")
  @visibility("read")
  thumbprint?: string;

  @doc("The type of the secret resource.")
  type: "CustomerCertificate";
}

@doc("Azure FirstParty Managed Certificate provided by other first party resource providers to enable HTTPS.")
model AzureFirstPartyManagedCertificateProperties extends SecretProperties {
  @doc("The type of the secret resource.")
  type: "AzureFirstPartyManagedCertificate";
}

@doc("The validation token.")
model ValidationToken {
  @visibility("read")
  token?: string;
}

@doc("Defines the RemoteAddress condition for the delivery rule.")
model DeliveryRuleRemoteAddressCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: RemoteAddressMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "RemoteAddress";
}

@doc("Defines the parameters for RemoteAddress match conditions")
model RemoteAddressMatchCondition {
  @projectedName("json", "typeName")
  type: RemoteAddressMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  remoteAddressOperator: RemoteAddressOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("Match values to match against. The operator will apply to each value in here with OR semantics. If any of them match the variable with the given operator this match condition is considered a match.")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the RequestMethod condition for the delivery rule.")
model DeliveryRuleRequestMethodCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: RequestMethodMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "RequestMethod";
}

@doc("Defines the parameters for RequestMethod match conditions")
model RequestMethodMatchCondition {
  @projectedName("json", "typeName")
  type: RequestMethodMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  requestMethodOperator: RequestMethodOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("List of transforms")
  transforms?: PreTransformCategory[];

  @doc("The match value for the condition of the delivery rule")
  matchValues?: RequestMethodMatchConditionMatchValue[];
}

@doc("Defines the QueryString condition for the delivery rule.")
model DeliveryRuleQueryStringCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: QueryStringMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "QueryString";
}

@doc("Defines the parameters for QueryString match conditions")
model QueryStringMatchCondition {
  @projectedName("json", "typeName")
  type: QueryStringMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  queryStringOperator: QueryStringOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the PostArgs condition for the delivery rule.")
model DeliveryRulePostArgsCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: PostArgsMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "PostArgs";
}

@doc("Defines the parameters for PostArgs match conditions")
model PostArgsMatchCondition {
  @projectedName("json", "typeName")
  type: PostArgsMatchConditionType;

  @doc("Name of PostArg to be matched")
  selector?: string;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  postArgsOperator: PostArgsOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the RequestUri condition for the delivery rule.")
model DeliveryRuleRequestUriCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: RequestUriMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "RequestUri";
}

@doc("Defines the parameters for RequestUri match conditions")
model RequestUriMatchCondition {
  @projectedName("json", "typeName")
  type: RequestUriMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  requestUriOperator: RequestUriOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the RequestHeader condition for the delivery rule.")
model DeliveryRuleRequestHeaderCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: RequestHeaderMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "RequestHeader";
}

@doc("Defines the parameters for RequestHeader match conditions")
model RequestHeaderMatchCondition {
  @projectedName("json", "typeName")
  type: RequestHeaderMatchConditionType;

  @doc("Name of Header to be matched")
  selector?: string;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  requestHeaderOperator: RequestHeaderOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the RequestBody condition for the delivery rule.")
model DeliveryRuleRequestBodyCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: RequestBodyMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "RequestBody";
}

@doc("Defines the parameters for RequestBody match conditions")
model RequestBodyMatchCondition {
  @projectedName("json", "typeName")
  type: RequestBodyMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  requestBodyOperator: RequestBodyOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the RequestScheme condition for the delivery rule.")
model DeliveryRuleRequestSchemeCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: RequestSchemeMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "RequestScheme";
}

@doc("Defines the parameters for RequestScheme match conditions ")
model RequestSchemeMatchCondition {
  @projectedName("json", "typeName")
  type: RequestSchemeMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  requestSchemeOperator: RequestSchemeOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("List of transforms")
  transforms?: PreTransformCategory[];

  @doc("The match value for the condition of the delivery rule")
  matchValues?: RequestSchemeMatchConditionMatchValue[];
}

@doc("Defines the UrlPath condition for the delivery rule.")
model DeliveryRuleUrlPathCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: UrlPathMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "UrlPath";
}

@doc("Defines the parameters for UrlPath match conditions")
model UrlPathMatchCondition {
  @projectedName("json", "typeName")
  type: UrlPathMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  urlPathOperator: UrlPathOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the UrlFileExtension condition for the delivery rule.")
model DeliveryRuleUrlFileExtensionCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: UrlFileExtensionMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "UrlFileExtension";
}

@doc("Defines the parameters for UrlFileExtension match conditions")
model UrlFileExtensionMatchCondition {
  @projectedName("json", "typeName")
  type: UrlFileExtensionMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  urlFileExtensionOperator: UrlFileExtensionOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the UrlFileName condition for the delivery rule.")
model DeliveryRuleUrlFileNameCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: UrlFileNameMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "UrlFileName";
}

@doc("Defines the parameters for UrlFilename match conditions")
model UrlFileNameMatchCondition {
  @projectedName("json", "typeName")
  type: UrlFileNameMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  urlFileNameOperator: UrlFileNameOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the HttpVersion condition for the delivery rule.")
model DeliveryRuleHttpVersionCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: HttpVersionMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "HttpVersion";
}

@doc("Defines the parameters for HttpVersion match conditions")
model HttpVersionMatchCondition {
  @projectedName("json", "typeName")
  type: HttpVersionMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  httpVersionOperator: HttpVersionOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the Cookies condition for the delivery rule.")
model DeliveryRuleCookiesCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: CookiesMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "Cookies";
}

@doc("Defines the parameters for Cookies match conditions")
model CookiesMatchCondition {
  @projectedName("json", "typeName")
  type: CookiesMatchConditionType;

  @doc("Name of Cookies to be matched")
  selector?: string;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  cookiesOperator: CookiesOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the IsDevice condition for the delivery rule.")
model DeliveryRuleIsDeviceCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: IsDeviceMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "IsDevice";
}

@doc("Defines the parameters for IsDevice match conditions")
model IsDeviceMatchCondition {
  @projectedName("json", "typeName")
  type: IsDeviceMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  IsDeviceOperator: IsDeviceOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: IsDeviceMatchConditionMatchValue[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the SocketAddress condition for the delivery rule.")
model DeliveryRuleSocketAddressCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: SocketAddressMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "SocketAddr";
}

@doc("Defines the parameters for SocketAddress match conditions")
model SocketAddressMatchCondition {
  @projectedName("json", "typeName")
  type: SocketAddressMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  socketAddressOperator: SocketAddressOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the ClientPort condition for the delivery rule.")
model DeliveryRuleClientPortCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: ClientPortMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "ClientPort";
}

@doc("Defines the parameters for ClientPort match conditions")
model ClientPortMatchCondition {
  @projectedName("json", "typeName")
  type: ClientPortMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  clientPortOperator: ClientPortOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the ServerPort condition for the delivery rule.")
model DeliveryRuleServerPortCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: ServerPortMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "ServerPort";
}

@doc("Defines the parameters for ServerPort match conditions")
model ServerPortMatchCondition {
  @projectedName("json", "typeName")
  type: ServerPortMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  serverPortOperator: ServerPortOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the HostName condition for the delivery rule.")
model DeliveryRuleHostNameCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: HostNameMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "HostName";
}

@doc("Defines the parameters for HostName match conditions")
model HostNameMatchCondition {
  @projectedName("json", "typeName")
  type: HostNameMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  hostNameOperator: HostNameOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: string[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the SslProtocol condition for the delivery rule.")
model DeliveryRuleSslProtocolCondition extends DeliveryRuleCondition {
  @doc("Defines the parameters for the condition.")
  @projectedName("json", "parameters")
  properties: SslProtocolMatchCondition;

  @doc("The name of the condition for the delivery rule.")
  name: "SslProtocol";
}

@doc("Defines the parameters for SslProtocol match conditions")
model SslProtocolMatchCondition {
  @projectedName("json", "typeName")
  type: SslProtocolMatchConditionType;

  @doc("Describes operator to be matched")
  @projectedName("json", "operator")
  sslProtocolOperator: SslProtocolOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("The match value for the condition of the delivery rule")
  matchValues?: SslProtocol[];

  @doc("List of transforms")
  transforms?: PreTransformCategory[];
}

@doc("Defines the url redirect action for the delivery rule.")
model UrlRedirectAction extends DeliveryRuleAction {
  @doc("Defines the parameters for the action.")
  @projectedName("json", "parameters")
  properties: UrlRedirectActionProperties;

  @doc("The name of the action for the delivery rule.")
  name: "UrlRedirect";
}

@doc("Defines the parameters for the url redirect action.")
model UrlRedirectActionProperties {
  @projectedName("json", "typeName")
  type: UrlRedirectActionType;

  @doc("The redirect type the rule will use when redirecting traffic.")
  redirectType: RedirectType;

  @doc("Protocol to use for the redirect. The default value is MatchRequest")
  destinationProtocol?: DestinationProtocol;

  @doc("The full path to redirect. Path cannot be empty and must start with /. Leave empty to use the incoming path as destination path.")
  customPath?: string;

  @doc("Host to redirect. Leave empty to use the incoming host as the destination host.")
  customHostname?: string;

  @doc("The set of query strings to be placed in the redirect URL. Setting this value would replace any existing query string; leave empty to preserve the incoming query string. Query string must be in <key>=<value> format. ? and & will be added automatically so do not include them.")
  customQueryString?: string;

  @doc("Fragment to add to the redirect URL. Fragment is the part of the URL that comes after #. Do not include the #.")
  customFragment?: string;
}

@doc("Defines the url signing action for the delivery rule.")
model UrlSigningAction extends DeliveryRuleAction {
  @doc("Defines the parameters for the action.")
  @projectedName("json", "parameters")
  properties: UrlSigningActionProperties;

  @doc("The name of the action for the delivery rule.")
  name: "UrlSigning";
}

@doc("Defines the parameters for the Url Signing action.")
model UrlSigningActionProperties {
  @projectedName("json", "typeName")
  type: UrlSigningActionType;

  @doc("Algorithm to use for URL signing")
  algorithm?: UrlSigningAlgorithm;

  @doc("Defines which query string parameters in the url to be considered for expires, key id etc. ")
  parameterNameOverride?: UrlSigningParamIdentifier[];
}

@doc("Defines how to identify a parameter for a specific purpose e.g. expires")
model UrlSigningParamIdentifier {
  @doc("Indicates the purpose of the parameter")
  paramIndicator: ParamIndicator;

  @doc("Parameter name")
  paramName: string;
}

@doc("Defines the origin group override action for the delivery rule.")
model OriginGroupOverrideAction extends DeliveryRuleAction {
  @doc("Defines the parameters for the action.")
  @projectedName("json", "parameters")
  properties: OriginGroupOverrideActionProperties;

  @doc("The name of the action for the delivery rule.")
  name: "OriginGroupOverride";
}

@doc("Defines the parameters for the origin group override action.")
model OriginGroupOverrideActionProperties {
  @projectedName("json", "typeName")
  type: OriginGroupOverrideActionType;

  @doc("defines the OriginGroup that would override the DefaultOriginGroup.")
  originGroup: ResourceReference;
}

@doc("Defines the url rewrite action for the delivery rule.")
model UrlRewriteAction extends DeliveryRuleAction {
  @doc("Defines the parameters for the action.")
  @projectedName("json", "parameters")
  properties: UrlRewriteActionProperties;

  @doc("The name of the action for the delivery rule.")
  name: "UrlRewrite";
}

@doc("Defines the parameters for the url rewrite action.")
model UrlRewriteActionProperties {
  @projectedName("json", "typeName")
  type: UrlRewriteActionType;

  @doc("define a request URI pattern that identifies the type of requests that may be rewritten. If value is blank, all strings are matched.")
  sourcePattern: string;

  @doc("Define the relative URL to which the above requests will be rewritten by.")
  destination: string;

  @doc("Whether to preserve unmatched path. Default value is true.")
  preserveUnmatchedPath?: boolean;
}

@doc("Defines the request header action for the delivery rule.")
model DeliveryRuleRequestHeaderAction extends DeliveryRuleAction {
  @doc("Defines the parameters for the action.")
  @projectedName("json", "parameters")
  properties: HeaderActionProperties;

  @doc("The name of the action for the delivery rule.")
  name: "ModifyRequestHeader";
}

@doc("Defines the parameters for the request header action.")
model HeaderActionProperties {
  @projectedName("json", "typeName")
  type: HeaderActionType;

  @doc("Action to perform")
  headerAction: HeaderAction;

  @doc("Name of the header to modify")
  headerName: string;

  @doc("Value for the specified action")
  value?: string;
}

@doc("Defines the response header action for the delivery rule.")
model DeliveryRuleResponseHeaderAction extends DeliveryRuleAction {
  @doc("Defines the parameters for the action.")
  @projectedName("json", "parameters")
  properties: HeaderActionProperties;

  @doc("The name of the action for the delivery rule.")
  name: "ModifyResponseHeader";
}

@doc("Defines the cache expiration action for the delivery rule.")
model DeliveryRuleCacheExpirationAction extends DeliveryRuleAction {
  @doc("Defines the parameters for the action.")
  @projectedName("json", "parameters")
  properties: CacheExpirationActionProperties;

  @doc("The name of the action for the delivery rule.")
  name: "CacheExpiration";
}

@doc("Defines the parameters for the cache expiration action.")
model CacheExpirationActionProperties {
  @projectedName("json", "typeName")
  type: CacheExpirationActionType;

  @doc("Caching behavior for the requests")
  cacheBehavior: CacheBehaviorSetting;

  @doc("The level at which the content needs to be cached.")
  cacheType: CacheLevel;

  @doc("The duration for which the content needs to be cached. Allowed format is [d.]hh:mm:ss")
  cacheDuration?: string;
}

@doc("Defines the cache-key query string action for the delivery rule.")
model DeliveryRuleCacheKeyQueryStringAction extends DeliveryRuleAction {
  @doc("Defines the parameters for the action.")
  @projectedName("json", "parameters")
  properties: CacheKeyQueryStringActionProperties;

  @doc("The name of the action for the delivery rule.")
  name: "CacheKeyQueryString";
}

@doc("Defines the parameters for the cache-key query string action.")
model CacheKeyQueryStringActionProperties {
  @projectedName("json", "typeName")
  type: CacheKeyQueryStringActionType;

  @doc("Caching behavior for the requests")
  queryStringBehavior: QueryStringBehavior;

  @doc("query parameters to include or exclude (comma separated).")
  queryParameters?: string;
}

@doc("Defines the route configuration override action for the delivery rule. Only applicable to Frontdoor Standard/Premium Profiles.")
model DeliveryRuleRouteConfigurationOverrideAction extends DeliveryRuleAction {
  @doc("Defines the parameters for the action.")
  @projectedName("json", "parameters")
  properties: RouteConfigurationOverrideActionProperties;

  @doc("The name of the action for the delivery rule.")
  name: "RouteConfigurationOverride";
}

@doc("Defines the parameters for the route configuration override action.")
model RouteConfigurationOverrideActionProperties {
  @projectedName("json", "typeName")
  type: RouteConfigurationOverrideActionType;

  @doc("A reference to the origin group override configuration. Leave empty to use the default origin group on route.")
  originGroupOverride?: OriginGroupOverride;

  @doc("The caching configuration associated with this rule. To disable caching, do not provide a cacheConfiguration object.")
  cacheConfiguration?: CacheConfiguration;
}

@doc("Defines the parameters for the origin group override configuration.")
model OriginGroupOverride {
  @doc("defines the OriginGroup that would override the DefaultOriginGroup on route.")
  originGroup?: ResourceReference;

  @doc("Protocol this rule will use when forwarding traffic to backends.")
  forwardingProtocol?: ForwardingProtocol;
}

@doc("Caching settings for a caching-type route. To disable caching, do not provide a cacheConfiguration object.")
model CacheConfiguration {
  @doc("Defines how Frontdoor caches requests that include query strings. You can ignore any query strings when caching, ignore specific query strings, cache every request with a unique URL, or cache specific query strings.")
  queryStringCachingBehavior?: RuleQueryStringCachingBehavior;

  @doc("query parameters to include or exclude (comma separated).")
  queryParameters?: string;

  @doc("Indicates whether content compression is enabled. If compression is enabled, content will be served as compressed if user requests for a compressed version. Content won't be compressed on AzureFrontDoor when requested content is smaller than 1 byte or larger than 1 MB.")
  isCompressionEnabled?: RuleIsCompressionEnabled;

  @doc("Caching behavior for the requests")
  cacheBehavior?: RuleCacheBehavior;

  @doc("The duration for which the content needs to be cached. Allowed format is [d.]hh:mm:ss")
  cacheDuration?: string;
}

@doc("Defines the certificate source parameters using CDN managed certificate for enabling SSL.")
model CdnManagedHttpsContent extends CustomDomainHttpsParameters {
  @doc("Defines the certificate source parameters using CDN managed certificate for enabling SSL.")
  certificateSourceParameters: CdnCertificateSource;

  @doc("Defines the source of the SSL certificate.")
  certificateSource: "Cdn";
}

@doc("Defines the parameters for using CDN managed certificate for securing custom domain.")
model CdnCertificateSource {
  @projectedName("json", "typeName")
  type: CdnCertificateSourceType;

  @doc("Type of certificate used")
  certificateType: CdnManagedCertificateType;
}

@doc("Defines the certificate source parameters using user's keyvault certificate for enabling SSL.")
model UserManagedHttpsContent extends CustomDomainHttpsParameters {
  @doc("Defines the certificate source parameters using user's keyvault certificate for enabling SSL.")
  certificateSourceParameters: KeyVaultCertificateSource;

  @doc("Defines the source of the SSL certificate.")
  certificateSource: "AzureKeyVault";
}

@doc("Describes the parameters for using a user's KeyVault certificate for securing custom domain.")
model KeyVaultCertificateSource {
  @projectedName("json", "typeName")
  type: KeyVaultCertificateSourceType;

  @doc("Subscription Id of the user's Key Vault containing the SSL certificate")
  subscriptionId: string;

  @doc("Resource group of the user's Key Vault containing the SSL certificate")
  resourceGroupName: string;

  @doc("The name of the user's Key Vault containing the SSL certificate")
  vaultName: string;

  @doc("The name of Key Vault Secret (representing the full certificate PFX) in Key Vault.")
  secretName: string;

  @doc("The version(GUID) of Key Vault Secret in Key Vault.")
  secretVersion?: string;

  @doc("Describes the action that shall be taken when the certificate is updated in Key Vault.")
  updateRule: CertificateUpdateAction;

  @doc("Describes the action that shall be taken when the certificate is removed from Key Vault.")
  deleteRule: CertificateDeleteAction;
}
