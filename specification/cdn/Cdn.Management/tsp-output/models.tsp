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

/**
 * Type of CDN resource used in CheckNameAvailability.
 */
enum CdnResourceType {
  Endpoints: "Microsoft.Cdn/Profiles/Endpoints",
  FrontDoorEndpoints: "Microsoft.Cdn/Profiles/AfdEndpoints",
}

/**
 * Indicates the endpoint name reuse scope. The default value is TenantReuse.
 */
enum DomainNameLabelScope {
  TenantReuse,
  SubscriptionReuse,
  ResourceGroupReuse,
  NoReuse,
}

/**
 * An enum describing the unit of measurement.
 */
enum FrontDoorUsageUnit {
  Count,
}

/**
 * Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step. DCV stands for DomainControlValidation.
 */
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

/**
 * Defines the source of the SSL certificate.
 */
enum FrontDoorCertificateType {
  CustomerCertificate,
  ManagedCertificate,
  AzureFirstPartyManagedCertificate,
}

/**
 * Provisioning status
 */
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

/**
 * The type of identity that creates/modifies resources
 */
enum IdentityType {
  user,
  application,
  managedIdentity,
  key,
}

/**
 * Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'
 */
enum EnabledState {
  Enabled,
  Disabled,
}

/**
 * Supported protocols for the customer's endpoint.
 */
enum FrontDoorEndpointProtocol {
  Http,
  Https,
}

/**
 * Defines how Frontdoor caches requests that include query strings. You can ignore any query strings when caching, ignore specific query strings, cache every request with a unique URL, or cache specific query strings.
 */
enum FrontDoorQueryStringCachingBehavior {
  IgnoreQueryString,
  UseQueryString,
  IgnoreSpecifiedQueryStrings,
  IncludeSpecifiedQueryStrings,
}

/**
 * Protocol this rule will use when forwarding traffic to backends.
 */
enum ForwardingProtocol {
  HttpOnly,
  HttpsOnly,
  MatchRequest,
}

/**
 * whether this route will be linked to the default endpoint domain.
 */
enum LinkToDefaultDomain {
  Enabled,
  Disabled,
}

/**
 * Whether to automatically redirect HTTP traffic to HTTPS traffic. Note that this is a easy way to set up this rule and it will be the first rule that gets executed.
 */
enum HttpsRedirect {
  Enabled,
  Disabled,
}

/**
 * The name of the condition for the delivery rule.
 */
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

/**
 * The name of the action for the delivery rule.
 */
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

/**
 * If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.
 */
enum MatchProcessingBehavior {
  Continue,
  Stop,
}

/**
 * The type of the Security policy to create.
 */
enum SecurityPolicyType {
  WebApplicationFirewall,
}

/**
 * The type of the secret resource.
 */
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

/**
 * Name of the pricing tier.
 */
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

/**
 * Resource status of the profile.
 */
enum ProfileResourceState {
  Creating,
  Active,
  Deleting,
  Disabled,
}

/**
 * Provisioning status of the profile.
 */
enum ProfileProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Deleting,
  Creating,
}

/**
 * Specifies what scenario the customer wants this CDN endpoint to optimize, e.g. Download, Media services. With this information we can apply scenario driven optimization.
 */
enum OptimizationType {
  GeneralWebDelivery,
  GeneralMediaStreaming,
  VideoOnDemandMediaStreaming,
  LargeFileDownload,
  DynamicSiteAcceleration,
}

/**
 * Unit of the usage. e.g. count.
 */
enum CdnUsageUnit {
  count,
}

/**
 * The approval status for the connection to the Private Link
 */
enum PrivateEndpointStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

/**
 * Resource status of the custom domain.
 */
enum CustomDomainResourceState {
  Creating,
  Active,
  Deleting,
}

/**
 * Provisioning status of the custom domain.
 */
enum CustomHttpsProvisioningState {
  Enabling,
  Enabled,
  Disabling,
  Disabled,
  Failed,
}

/**
 * Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.
 */
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

/**
 * Defines the source of the SSL certificate.
 */
enum CertificateSource {
  AzureKeyVault,
  Cdn,
}

/**
 * Defines the TLS extension protocol that is used for secure delivery.
 */
enum SecureDeliveryProtocolType {
  ServerNameIndication,
  IPBased,
}

/**
 * Resource status of the endpoint.
 */
enum EndpointResourceState {
  Creating,
  Deleting,
  Running,
  Starting,
  Stopped,
  Stopping,
}

/**
 * Provisioning status of the endpoint.
 */
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

/**
 * Resource status of the origin.
 */
enum OriginResourceState {
  Creating,
  Active,
  Deleting,
}

/**
 * Provisioning status of the origin.
 */
enum OriginProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Deleting,
  Creating,
}

/**
 * Resource status of the origin group.
 */
enum OriginGroupResourceState {
  Creating,
  Active,
  Deleting,
}

/**
 * Provisioning status of the origin group.
 */
enum OriginGroupProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Deleting,
  Creating,
}

/**
 * describes if the policy is in enabled state or disabled state
 */
enum PolicyEnabledState {
  Disabled,
  Enabled,
}

/**
 * Describes if it is in detection mode or prevention mode at policy level.
 */
enum PolicyMode {
  Prevention,
  Detection,
}

/**
 * If the action type is block, this field defines the default customer overridable http response status code.
 */
enum PolicySettingsDefaultCustomBlockResponseStatusCode {
  `200`: 200,
  `403`: 403,
  `405`: 405,
  `406`: 406,
  `429`: 429,
}

/**
 * Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.
 */
enum CustomRuleEnabledState {
  Disabled,
  Enabled,
}

/**
 * Match variable to compare against.
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes what transforms were applied before matching.
 */
enum TransformType {
  Lowercase,
  Uppercase,
  Trim,
  UrlDecode,
  UrlEncode,
  RemoveNulls,
}

/**
 * Defines the action to take on rule match.
 */
enum OverrideActionType {
  Allow,
  Block,
  Log,
  Redirect,
}

/**
 * Describes if the managed rule is in enabled or disabled state. Defaults to Disabled if not specified.
 */
enum ManagedRuleSetupState {
  Disabled,
  Enabled,
}

/**
 * Provisioning state of the WebApplicationFirewallPolicy.
 */
enum WebApplicationFirewallPolicyProvisioningState {
  Creating,
  Succeeded,
  Failed,
}

/**
 * Resource status of the policy.
 */
enum PolicyResourceState {
  Creating,
  Enabling,
  Enabled,
  Disabling,
  Disabled,
  Deleting,
}

/**
 * The validation status.
 */
enum ValidationStatus {
  Valid,
  Invalid,
  AccessDenied,
  CertificateExpired,
}

enum RemoteAddressMatchConditionType {
  RemoteAddressCondition: "DeliveryRuleRemoteAddressConditionParameters",
}

/**
 * Describes operator to be matched
 */
enum RemoteAddressOperator {
  Any,
  IPMatch,
  GeoMatch,
}

/**
 * Describes what transforms are applied before matching
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
enum HttpVersionOperator {
  Equal,
}

enum CookiesMatchConditionType {
  CookiesCondition: "DeliveryRuleCookiesConditionParameters",
}

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
enum SocketAddressOperator {
  Any,
  IPMatch,
}

enum ClientPortMatchConditionType {
  ClientPortCondition: "DeliveryRuleClientPortConditionParameters",
}

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
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

/**
 * Describes operator to be matched
 */
enum SslProtocolOperator {
  Equal,
}

/**
 * The protocol of an established TLS connection.
 */
enum SslProtocol {
  TLSv1,
  `TLSv1.1`,
  `TLSv1.2`,
}

enum UrlRedirectActionType {
  UrlRedirectAction: "DeliveryRuleUrlRedirectActionParameters",
}

/**
 * The redirect type the rule will use when redirecting traffic.
 */
enum RedirectType {
  Moved,
  Found,
  TemporaryRedirect,
  PermanentRedirect,
}

/**
 * Protocol to use for the redirect. The default value is MatchRequest
 */
enum DestinationProtocol {
  MatchRequest,
  Http,
  Https,
}

enum UrlSigningActionType {
  UrlSigningAction: "DeliveryRuleUrlSigningActionParameters",
}

/**
 * Algorithm to use for URL signing
 */
enum UrlSigningAlgorithm {
  SHA256,
}

/**
 * Indicates the purpose of the parameter
 */
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

/**
 * Action to perform
 */
enum HeaderAction {
  Append,
  Overwrite,
  Delete,
}

enum CacheExpirationActionType {
  CacheExpirationAction: "DeliveryRuleCacheExpirationActionParameters",
}

/**
 * Caching behavior for the requests
 */
enum CacheBehaviorSetting {
  BypassCache,
  Override,
  SetIfMissing,
}

/**
 * The level at which the content needs to be cached.
 */
enum CacheLevel {
  All,
}

enum CacheKeyQueryStringActionType {
  CacheKeyQueryStringBehaviorAction: "DeliveryRuleCacheKeyQueryStringBehaviorActionParameters",
}

/**
 * Caching behavior for the requests
 */
enum QueryStringBehavior {
  Include,
  IncludeAll,
  Exclude,
  ExcludeAll,
}

enum RouteConfigurationOverrideActionType {
  RouteConfigurationOverrideAction: "DeliveryRuleRouteConfigurationOverrideActionParameters",
}

/**
 * Defines how Frontdoor caches requests that include query strings. You can ignore any query strings when caching, ignore specific query strings, cache every request with a unique URL, or cache specific query strings.
 */
enum RuleQueryStringCachingBehavior {
  IgnoreQueryString,
  UseQueryString,
  IgnoreSpecifiedQueryStrings,
  IncludeSpecifiedQueryStrings,
}

/**
 * Indicates whether content compression is enabled. If compression is enabled, content will be served as compressed if user requests for a compressed version. Content won't be compressed on AzureFrontDoor when requested content is smaller than 1 byte or larger than 1 MB.
 */
enum RuleIsCompressionEnabled {
  Enabled,
  Disabled,
}

/**
 * Caching behavior for the requests
 */
enum RuleCacheBehavior {
  HonorOrigin,
  OverrideAlways,
  OverrideIfOriginMissing,
}

enum CdnCertificateSourceType {
  CdnCertificateSource: "CdnCertificateSourceParameters",
}

/**
 * Type of certificate used
 */
enum CdnManagedCertificateType {
  Shared,
  Dedicated,
}

enum KeyVaultCertificateSourceType {
  KeyVaultCertificateSource: "KeyVaultCertificateSourceParameters",
}

/**
 * Describes the action that shall be taken when the certificate is updated in Key Vault.
 */
enum CertificateUpdateAction {
  NoAction,
}

/**
 * Describes the action that shall be taken when the certificate is removed from Key Vault.
 */
enum CertificateDeleteAction {
  NoAction,
}

/**
 * TLS protocol version that will be used for Https
 */
@fixed
enum FrontDoorMinimumTlsVersion {
  TLS10,
  TLS12,
}

/**
 * The type of health probe request that is made.
 */
@fixed
enum HealthProbeRequestType {
  NotSet,
  GET,
  HEAD,
}

/**
 * Protocol to use for health probe.
 */
@fixed
enum HealthProbeProtocol {
  NotSet,
  Http,
  Https,
}

/**
 * Status of the shared private link resource. Can be Pending, Approved, Rejected, Disconnected, or Timeout.
 */
@fixed
enum SharedPrivateLinkResourceStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

/**
 * Type of response errors for real user requests for which origin will be deemed unhealthy
 */
@fixed
enum ResponseBasedDetectedErrorTypes {
  None,
  TcpErrorsOnly,
  TcpAndHttpErrors,
}

/**
 * TLS protocol version that will be used for Https
 */
@fixed
enum CdnMinimumTlsVersion {
  None,
  TLS10,
  TLS12,
}

/**
 * Defines how CDN caches requests that include query strings. You can ignore any query strings when caching, bypass caching to prevent requests that contain query strings from being cached, or cache every request with a unique URL.
 */
@fixed
enum QueryStringCachingBehavior {
  IgnoreQueryString,
  BypassCaching,
  UseQueryString,
  NotSet,
}

/**
 * Action of the geo filter, i.e. allow or block access.
 */
@fixed
enum GeoFilterActions {
  Block,
  Allow,
}

/**
 * Input of CheckNameAvailability API.
 */
model EndpointNameAvailabilityContent {
  /**
   * The resource name to validate.
   */
  name: string;

  /**
   * The type of the resource whose name is to be validated.
   */
  type: CdnResourceType;

  /**
   * Indicates the endpoint name reuse scope. The default value is TenantReuse.
   */
  autoGeneratedDomainNameLabelScope?: DomainNameLabelScope;
}

/**
 * Output of check name availability API.
 */
model EndpointNameAvailabilityResult {
  /**
   * Indicates whether the name is available.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * Returns the available hostname generated based on the AutoGeneratedDomainNameLabelScope when the name is available, otherwise it returns empty string
   */
  @visibility("read")
  availableHostname?: string;

  /**
   * The reason why the name is not available.
   */
  @visibility("read")
  reason?: string;

  /**
   * The detailed error message describing why the name is not available.
   */
  @visibility("read")
  message?: string;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
@error
model AfdErrorResponse {
  /**
   * The error object.
   */
  error?: ErrorDetail;
}

/**
 * The list usages operation response.
 */
model UsagesListResult is Azure.Core.Page<FrontDoorUsage>;

/**
 * Describes resource usage.
 */
model FrontDoorUsage {
  /**
   * Resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * An enum describing the unit of measurement.
   */
  unit: FrontDoorUsageUnit;

  /**
   * The current value of the usage.
   */
  currentValue: int64;

  /**
   * The limit of usage.
   */
  limit: int64;

  /**
   * The name of the type of usage.
   */
  name: FrontDoorUsageResourceName;
}

/**
 * The usage names.
 */
model FrontDoorUsageResourceName {
  /**
   * A string describing the resource name.
   */
  value?: string;

  /**
   * A localized string describing the resource name.
   */
  localizedValue?: string;
}

/**
 * Input of CheckHostNameAvailability API.
 */
model HostNameAvailabilityContent {
  /**
   * The host name to validate.
   */
  hostName: string;
}

/**
 * Output of check name availability API.
 */
model CdnNameAvailabilityResult {
  /**
   * Indicates whether the name is available.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * The reason why the name is not available.
   */
  @visibility("read")
  reason?: string;

  /**
   * The detailed error message describing why the name is not available.
   */
  @visibility("read")
  message?: string;
}

/**
 * The JSON object that contains the properties of the domain to create.
 */
model AFDDomainProperties {
  ...AFDDomainUpdatePropertiesParameters;
  ...AFDStateProperties;

  /**
   * Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step. DCV stands for DomainControlValidation.
   */
  @visibility("read")
  domainValidationState?: DomainValidationState;

  /**
   * The host name of the domain. Must be a domain name.
   */
  hostName: string;

  /**
   * Values the customer needs to validate domain ownership
   */
  @visibility("read")
  validationProperties?: DomainValidationProperties;
}

/**
 * The JSON object that contains the properties to validate a domain.
 */
model DomainValidationProperties {
  /**
   * Challenge used for DNS TXT record or file based validation
   */
  @visibility("read")
  validationToken?: string;

  /**
   * The date time that the token expires
   */
  @visibility("read")
  @projectedName("json", "expirationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresDate?: utcDateTime;
}

/**
 * The JSON object that contains the properties of the domain to create.
 */
model AFDDomainUpdatePropertiesParameters {
  /**
   * The name of the profile which holds the domain.
   */
  @visibility("read")
  profileName?: string;

  /**
   * The configuration specifying how to enable HTTPS for the domain - using AzureFrontDoor managed certificate or user's own certificate. If not specified, enabling ssl uses AzureFrontDoor managed certificate by default.
   */
  tlsSettings?: AFDDomainHttpsParameters;

  /**
   * Resource reference to the Azure DNS zone
   */
  @projectedName("json", "azureDnsZone")
  dnsZone?: ResourceReference;

  /**
   * Resource reference to the Azure resource where custom domain ownership was prevalidated
   */
  @projectedName("json", "preValidatedCustomDomainResourceId")
  preValidatedCustomDomainResource?: AFDDomainUpdatePropertiesParametersPreValidatedCustomDomainResourceId;
}

/**
 * The JSON object that contains the properties to secure a domain.
 */
model AFDDomainHttpsParameters {
  /**
   * Defines the source of the SSL certificate.
   */
  certificateType: FrontDoorCertificateType;

  /**
   * TLS protocol version that will be used for Https
   */
  minimumTlsVersion?: FrontDoorMinimumTlsVersion;

  /**
   * Resource reference to the secret. ie. subs/rg/profile/secret
   */
  secret?: AFDDomainHttpsParametersSecret;
}

/**
 * Resource reference to the secret. ie. subs/rg/profile/secret
 */
model AFDDomainHttpsParametersSecret {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Reference to another resource.
 */
model ResourceReference {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Resource reference to the Azure resource where custom domain ownership was prevalidated
 */
model AFDDomainUpdatePropertiesParametersPreValidatedCustomDomainResourceId {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * The tracking states for afd resources.
 */
model AFDStateProperties {
  /**
   * Provisioning status
   */
  @visibility("read")
  provisioningState?: FrontDoorProvisioningState;

  @visibility("read")
  deploymentStatus?: FrontDoorDeploymentStatus;
}

/**
 * The core properties of ARM resources
 */
model Resource {
  /**
   * Resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Read only system data
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The domain JSON object required for domain creation or update.
 */
model AFDDomainUpdateParameters {
  /**
   * The JSON object that contains the properties of the domain to create.
   */
  properties?: AFDDomainUpdatePropertiesParameters;
}

/**
 * The JSON object that contains the properties required to create an endpoint.
 */
model AFDEndpointProperties {
  ...AFDEndpointPropertiesUpdateParameters;
  ...AFDStateProperties;

  /**
   * The host name of the endpoint structured as {endpointName}.{DNSZone}, e.g. contoso.azureedge.net
   */
  @visibility("read")
  hostName?: string;

  /**
   * Indicates the endpoint name reuse scope. The default value is TenantReuse.
   */
  autoGeneratedDomainNameLabelScope?: DomainNameLabelScope;
}

/**
 * The JSON object containing endpoint update parameters.
 */
model AFDEndpointPropertiesUpdateParameters {
  /**
   * The name of the profile which holds the endpoint.
   */
  @visibility("read")
  profileName?: string;

  /**
   * Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'
   */
  enabledState?: EnabledState;
}

/**
 * Properties required to create or update an endpoint.
 */
model AFDEndpointUpdateParameters {
  /**
   * Endpoint tags.
   */
  tags?: Record<string>;

  /**
   * The JSON object containing endpoint update parameters.
   */
  properties?: AFDEndpointPropertiesUpdateParameters;
}

/**
 * Parameters required for content purge.
 */
model FrontDoorPurgeParameters {
  /**
   * The path to the content to be purged. Can describe a file path or a wild card directory.
   */
  contentPaths: string[];

  /**
   * List of domains.
   */
  domains?: string[];
}

/**
 * Input of the custom domain to be validated for DNS mapping.
 */
model ValidateCustomDomainContent {
  /**
   * The host name of the custom domain. Must be a domain name.
   */
  hostName: string;
}

/**
 * Output of custom domain validation.
 */
model ValidateCustomDomainResult {
  /**
   * Indicates whether the custom domain is valid or not.
   */
  @visibility("read")
  @projectedName("json", "customDomainValidated")
  isCustomDomainValid?: boolean;

  /**
   * The reason why the custom domain is not valid.
   */
  @visibility("read")
  reason?: string;

  /**
   * Error message describing why the custom domain is not valid.
   */
  @visibility("read")
  message?: string;
}

/**
 * The JSON object that contains the properties of the origin group.
 */
model AFDOriginGroupProperties {
  ...AFDOriginGroupUpdatePropertiesParameters;
  ...AFDStateProperties;
}

/**
 * The JSON object that contains the properties of the origin group.
 */
model AFDOriginGroupUpdatePropertiesParameters {
  /**
   * The name of the profile which holds the origin group.
   */
  @visibility("read")
  profileName?: string;

  /**
   * Load balancing settings for a backend pool
   */
  loadBalancingSettings?: LoadBalancingSettings;

  /**
   * Health probe settings to the origin that is used to determine the health of the origin.
   */
  healthProbeSettings?: HealthProbeSettings;

  /**
   * Time in minutes to shift the traffic to the endpoint gradually when an unhealthy endpoint comes healthy or a new endpoint is added. Default is 10 mins. This property is currently not supported.
   */
  @maxValue(50)
  @projectedName(
    "json",
    "trafficRestorationTimeToHealedOrNewEndpointsInMinutes"
  )
  trafficRestorationTimeInMinutes?: int32;

  /**
   * Whether to allow session affinity on this host. Valid options are 'Enabled' or 'Disabled'
   */
  sessionAffinityState?: EnabledState;
}

/**
 * Round-Robin load balancing settings for a backend pool
 */
model LoadBalancingSettings {
  /**
   * The number of samples to consider for load balancing decisions
   */
  sampleSize?: int32;

  /**
   * The number of samples within the sample period that must succeed
   */
  successfulSamplesRequired?: int32;

  /**
   * The additional latency in milliseconds for probes to fall into the lowest latency bucket
   */
  additionalLatencyInMilliseconds?: int32;
}

/**
 * The JSON object that contains the properties to send health probes to origin.
 */
model HealthProbeSettings {
  /**
   * The path relative to the origin that is used to determine the health of the origin.
   */
  probePath?: string;

  /**
   * The type of health probe request that is made.
   */
  probeRequestType?: HealthProbeRequestType;

  /**
   * Protocol to use for health probe.
   */
  probeProtocol?: HealthProbeProtocol;

  /**
   * The number of seconds between health probes.Default is 240sec.
   */
  @maxValue(255)
  @minValue(1)
  probeIntervalInSeconds?: int32;
}

/**
 * AFDOrigin group properties needed for origin group creation or update.
 */
model AFDOriginGroupUpdateParameters {
  /**
   * The JSON object that contains the properties of the origin group.
   */
  properties?: AFDOriginGroupUpdatePropertiesParameters;
}

/**
 * The JSON object that contains the properties of the origin.
 */
model AFDOriginProperties {
  ...AFDOriginUpdatePropertiesParameters;
  ...AFDStateProperties;
}

/**
 * The JSON object that contains the properties of the origin.
 */
model AFDOriginUpdatePropertiesParameters {
  /**
   * The name of the origin group which contains this origin.
   */
  @visibility("read")
  originGroupName?: string;

  /**
   * Resource reference to the Azure origin resource.
   */
  @projectedName("json", "azureOrigin")
  origin?: ResourceReference;

  /**
   * The address of the origin. Domain names, IPv4 addresses, and IPv6 addresses are supported.This should be unique across all origins in an endpoint.
   */
  hostName?: string;

  /**
   * The value of the HTTP port. Must be between 1 and 65535.
   */
  @maxValue(65535)
  @minValue(1)
  httpPort?: int32;

  /**
   * The value of the HTTPS port. Must be between 1 and 65535.
   */
  @maxValue(65535)
  @minValue(1)
  httpsPort?: int32;

  /**
   * The host header value sent to the origin with each request. If you leave this blank, the request hostname determines this value. Azure CDN origins, such as Web Apps, Blob Storage, and Cloud Services require this host header value to match the origin hostname by default. This overrides the host header defined at Endpoint
   */
  originHostHeader?: string;

  /**
   * Priority of origin in given origin group for load balancing. Higher priorities will not be used for load balancing if any lower priority origin is healthy.Must be between 1 and 5
   */
  @maxValue(5)
  @minValue(1)
  priority?: int32;

  /**
   * Weight of the origin in given origin group for load balancing. Must be between 1 and 1000
   */
  @maxValue(1000)
  @minValue(1)
  weight?: int32;

  /**
   * The properties of the private link resource for private origin.
   */
  sharedPrivateLinkResource?: SharedPrivateLinkResourceProperties;

  /**
   * Whether to enable health probes to be made against backends defined under backendPools. Health probes can only be disabled if there is a single enabled backend in single enabled backend pool.
   */
  enabledState?: EnabledState;

  /**
   * Whether to enable certificate name check at origin level
   */
  enforceCertificateNameCheck?: boolean = true;
}

/**
 * Describes the properties of an existing Shared Private Link Resource to use when connecting to a private origin.
 */
model SharedPrivateLinkResourceProperties {
  /**
   * The resource id of the resource the shared private link resource is for.
   */
  privateLink?: ResourceReference;

  /**
   * The location of the shared private link resource
   */
  privateLinkLocation?: string;

  /**
   * The group id from the provider of resource the shared private link resource is for.
   */
  groupId?: string;

  /**
   * The request message for requesting approval of the shared private link resource.
   */
  requestMessage?: string;

  /**
   * Status of the shared private link resource. Can be Pending, Approved, Rejected, Disconnected, or Timeout.
   */
  status?: SharedPrivateLinkResourceStatus;
}

/**
 * AFDOrigin properties needed for origin update.
 */
model AFDOriginUpdateParameters {
  /**
   * The JSON object that contains the properties of the origin.
   */
  properties?: AFDOriginUpdatePropertiesParameters;
}

/**
 * The JSON object that contains the properties of the Routes to create.
 */
model RouteProperties {
  ...RouteUpdatePropertiesParameters;
  ...AFDStateProperties;
}

/**
 * The JSON object that contains the properties of the domain to create.
 */
model RouteUpdatePropertiesParameters {
  /**
   * The name of the endpoint which holds the route.
   */
  @visibility("read")
  endpointName?: string;

  /**
   * Domains referenced by this endpoint.
   */
  customDomains?: FrontDoorActivatedResourceInfo[];

  /**
   * A reference to the origin group.
   */
  originGroup?: ResourceReference;

  /**
   * A directory path on the origin that AzureFrontDoor can use to retrieve content from, e.g. contoso.cloudapp.net/originpath.
   */
  originPath?: string;

  /**
   * rule sets referenced by this endpoint.
   */
  ruleSets?: ResourceReference[];

  /**
   * List of supported protocols for this route.
   */
  supportedProtocols?: FrontDoorEndpointProtocol[];

  /**
   * The route patterns of the rule.
   */
  patternsToMatch?: string[];

  /**
   * The caching configuration for this route. To disable caching, do not provide a cacheConfiguration object.
   */
  cacheConfiguration?: FrontDoorRouteCacheConfiguration;

  /**
   * Protocol this rule will use when forwarding traffic to backends.
   */
  forwardingProtocol?: ForwardingProtocol;

  /**
   * whether this route will be linked to the default endpoint domain.
   */
  linkToDefaultDomain?: LinkToDefaultDomain;

  /**
   * Whether to automatically redirect HTTP traffic to HTTPS traffic. Note that this is a easy way to set up this rule and it will be the first rule that gets executed.
   */
  httpsRedirect?: HttpsRedirect;

  /**
   * Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'
   */
  enabledState?: EnabledState;
}

/**
 * Reference to another resource along with its state.
 */
model FrontDoorActivatedResourceInfo {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * Whether the resource is active or inactive
   */
  @visibility("read")
  isActive?: boolean;
}

/**
 * Caching settings for a caching-type route. To disable caching, do not provide a cacheConfiguration object.
 */
model FrontDoorRouteCacheConfiguration {
  /**
   * Defines how Frontdoor caches requests that include query strings. You can ignore any query strings when caching, ignore specific query strings, cache every request with a unique URL, or cache specific query strings.
   */
  queryStringCachingBehavior?: FrontDoorQueryStringCachingBehavior;

  /**
   * query parameters to include or exclude (comma separated).
   */
  queryParameters?: string;

  /**
   * compression settings.
   */
  compressionSettings?: RouteCacheCompressionSettings;
}

/**
 * settings for compression.
 */
model RouteCacheCompressionSettings {
  /**
   * List of content types on which compression applies. The value should be a valid MIME type.
   */
  contentTypesToCompress?: string[];

  /**
   * Indicates whether content compression is enabled on AzureFrontDoor. Default value is false. If compression is enabled, content will be served as compressed if user requests for a compressed version. Content won't be compressed on AzureFrontDoor when requested content is smaller than 1 byte or larger than 1 MB.
   */
  isCompressionEnabled?: boolean;
}

/**
 * The domain JSON object required for domain creation or update.
 */
model RouteUpdateParameters {
  /**
   * The JSON object that contains the properties of the domain to create.
   */
  properties?: RouteUpdatePropertiesParameters;
}

/**
 * The JSON object that contains the properties of the Rule Set to create.
 */
model RuleSetProperties extends AFDStateProperties {
  /**
   * The name of the profile which holds the rule set.
   */
  @visibility("read")
  profileName?: string;
}

/**
 * The JSON object that contains the properties of the Rules to create.
 */
model RuleProperties {
  ...RuleUpdatePropertiesParameters;
  ...AFDStateProperties;
}

/**
 * The JSON object that contains the properties of the rule to update.
 */
model RuleUpdatePropertiesParameters {
  /**
   * The name of the rule set containing the rule.
   */
  @visibility("read")
  ruleSetName?: string;

  /**
   * The order in which the rules are applied for the endpoint. Possible values {0,1,2,3,………}. A rule with a lesser order will be applied before a rule with a greater order. Rule with order 0 is a special rule. It does not require any condition and actions listed in it will always be applied.
   */
  order?: int32;

  /**
   * A list of conditions that must be matched for the actions to be executed
   */
  conditions?: DeliveryRuleCondition[];

  /**
   * A list of actions that are executed when all the conditions of a rule are satisfied.
   */
  actions?: DeliveryRuleAction[];

  /**
   * If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.
   */
  matchProcessingBehavior?: MatchProcessingBehavior;
}

/**
 * A condition for the delivery rule.
 */
@discriminator("name")
model DeliveryRuleCondition {}

/**
 * An action for the delivery rule.
 */
@discriminator("name")
model DeliveryRuleAction {}

/**
 * The domain JSON object required for domain creation or update.
 */
model RuleUpdateParameters {
  /**
   * The JSON object that contains the properties of the rule to update.
   */
  properties?: RuleUpdatePropertiesParameters;
}

/**
 * The json object that contains properties required to create a security policy
 */
model SecurityPolicyDetails extends AFDStateProperties {
  /**
   * The name of the profile which holds the security policy.
   */
  @visibility("read")
  profileName?: string;

  /**
   * object which contains security policy parameters
   */
  @projectedName("json", "parameters")
  properties?: SecurityPolicyProperties;
}

/**
 * The json object containing security policy parameters
 */
@discriminator("type")
model SecurityPolicyProperties {}

/**
 * The JSON object containing security policy update parameters.
 */
model SecurityPolicyUpdateParameters {
  /**
   * The json object that contains properties required to update a security policy
   */
  properties?: SecurityPolicyUpdateProperties;
}

/**
 * The json object that contains properties required to update a security policy
 */
model SecurityPolicyUpdateProperties {
  /**
   * object which contains security policy parameters
   */
  @projectedName("json", "parameters")
  properties?: SecurityPolicyProperties;
}

/**
 * The JSON object that contains the properties of the Secret to create.
 */
model SecretDetails extends AFDStateProperties {
  /**
   * The name of the profile which holds the secret.
   */
  @visibility("read")
  profileName?: string;

  /**
   * object which contains secret parameters
   */
  @projectedName("json", "parameters")
  properties?: SecretProperties;
}

/**
 * The json object containing secret parameters
 */
@discriminator("type")
model SecretProperties {}

/**
 * Metrics Response
 */
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

/**
 * Rankings Response
 */
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
  value?: int64;
  percentage?: float32;
}

/**
 * Continents Response
 */
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

/**
 * Resources Response
 */
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

/**
 * Waf Metrics Response
 */
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

/**
 * Waf Rankings Response
 */
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
  value?: int64;
  percentage?: float64;
}

/**
* Standard_Verizon = The SKU name for a Standard Verizon CDN profile.
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

*/
model Sku {
  /**
   * Name of the pricing tier.
   */
  name?: SkuName;
}

/**
 * The JSON object that contains the properties required to create a profile.
 */
model ProfileProperties {
  /**
   * Resource status of the profile.
   */
  @visibility("read")
  resourceState?: ProfileResourceState;

  /**
   * Provisioning status of the profile.
   */
  @visibility("read")
  provisioningState?: ProfileProvisioningState;

  /**
   * The Id of the frontdoor.
   */
  @visibility("read")
  frontDoorId?: string;

  /**
   * Send and receive timeout on forwarding request to the origin. When timeout is reached, the request fails and returns.
   */
  @minValue(16)
  originResponseTimeoutSeconds?: int32;
}

/**
 * Properties required to update a profile.
 */
model ProfileUpdateParameters {
  /**
   * Profile tags
   */
  tags?: Record<string>;

  /**
   * The JSON object containing profile update parameters.
   */
  properties?: ProfilePropertiesUpdateParameters;
}

/**
 * The JSON object containing profile update parameters.
 */
model ProfilePropertiesUpdateParameters {
  /**
   * Send and receive timeout on forwarding request to the origin. When timeout is reached, the request fails and returns.
   */
  @minValue(16)
  originResponseTimeoutSeconds?: int32;
}

/**
 * The URI required to login to the supplemental portal from the Azure portal.
 */
model SsoUri {
  /**
   * The URI used to login to the supplemental portal.
   */
  @visibility("read")
  @projectedName("json", "ssoUriValue")
  availableSsoUri?: string;
}

/**
 * The result of the GetSupportedOptimizationTypes API
 */
model SupportedOptimizationTypesListResult {
  /**
   * Supported optimization types for a profile.
   */
  @visibility("read")
  supportedOptimizationTypes?: OptimizationType[];
}

/**
 * Output of check resource usage API.
 */
model ResourceUsageListResult is Azure.Core.Page<CdnUsage>;

/**
 * Output of check resource usage API.
 */
model CdnUsage {
  /**
   * Resource type for which the usage is provided.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * Unit of the usage. e.g. count.
   */
  @visibility("read")
  unit?: CdnUsageUnit;

  /**
   * Actual value of usage on the specified resource type.
   */
  @visibility("read")
  currentValue?: int32;

  /**
   * Quota of the specified resource type.
   */
  @visibility("read")
  limit?: int32;
}

/**
 * The JSON object that contains the properties required to create an endpoint.
 */
model EndpointProperties extends EndpointPropertiesUpdateParameters {
  /**
   * The host name of the endpoint structured as {endpointName}.{DNSZone}, e.g. contoso.azureedge.net
   */
  @visibility("read")
  hostName?: string;

  /**
   * The source of the content being delivered via CDN.
   */
  origins: DeepCreatedOrigin[];

  /**
   * The origin groups comprising of origins that are used for load balancing the traffic based on availability.
   */
  originGroups?: DeepCreatedOriginGroup[];

  /**
   * The custom domains under the endpoint.
   */
  @visibility("read")
  customDomains?: CdnCustomDomain[];

  /**
   * Resource status of the endpoint.
   */
  @visibility("read")
  resourceState?: EndpointResourceState;

  /**
   * Provisioning status of the endpoint.
   */
  @visibility("read")
  provisioningState?: CdnEndpointProvisioningState;
}

/**
 * The main origin of CDN content which is added when creating a CDN endpoint.
 */
model DeepCreatedOrigin {
  /**
   * Origin name which must be unique within the endpoint.
   */
  name: string;

  /**
   * Properties of the origin created on the CDN endpoint.
   */
  properties?: DeepCreatedOriginProperties;
}

/**
 * Properties of the origin created on the CDN endpoint.
 */
model DeepCreatedOriginProperties {
  /**
   * The address of the origin. It can be a domain name, IPv4 address, or IPv6 address. This should be unique across all origins in an endpoint.
   */
  hostName: string;

  /**
   * The value of the HTTP port. Must be between 1 and 65535.
   */
  @maxValue(65535)
  @minValue(1)
  httpPort?: int32;

  /**
   * The value of the HTTPS port. Must be between 1 and 65535.
   */
  @maxValue(65535)
  @minValue(1)
  httpsPort?: int32;

  /**
   * The host header value sent to the origin with each request. If you leave this blank, the request hostname determines this value. Azure CDN origins, such as Web Apps, Blob Storage, and Cloud Services require this host header value to match the origin hostname by default.
   */
  originHostHeader?: string;

  /**
   * Priority of origin in given origin group for load balancing. Higher priorities will not be used for load balancing if any lower priority origin is healthy.Must be between 1 and 5.
   */
  @maxValue(5)
  @minValue(1)
  priority?: int32;

  /**
   * Weight of the origin in given origin group for load balancing. Must be between 1 and 1000
   */
  @maxValue(1000)
  @minValue(1)
  weight?: int32;

  /**
   * Origin is enabled for load balancing or not. By default, origin is always enabled.
   */
  enabled?: boolean;

  /**
   * The Alias of the Private Link resource. Populating this optional field indicates that this origin is 'Private'
   */
  privateLinkAlias?: string;

  /**
   * The Resource Id of the Private Link resource. Populating this optional field indicates that this backend is 'Private'
   */
  privateLinkResourceId?: string;

  /**
   * The location of the Private Link resource. Required only if 'privateLinkResourceId' is populated
   */
  privateLinkLocation?: string;

  /**
   * A custom message to be included in the approval request to connect to the Private Link.
   */
  privateLinkApprovalMessage?: string;

  /**
   * The approval status for the connection to the Private Link
   */
  @visibility("read")
  privateEndpointStatus?: PrivateEndpointStatus;
}

/**
 * The origin group for CDN content which is added when creating a CDN endpoint. Traffic is sent to the origins within the origin group based on origin health.
 */
model DeepCreatedOriginGroup {
  /**
   * Origin group name which must be unique within the endpoint.
   */
  name: string;

  /**
   * Properties of the origin group created on the CDN endpoint.
   */
  properties?: DeepCreatedOriginGroupProperties;
}

/**
 * Properties of the origin group created on the CDN endpoint.
 */
model DeepCreatedOriginGroupProperties {
  /**
   * Health probe settings to the origin that is used to determine the health of the origin.
   */
  healthProbeSettings?: HealthProbeSettings;

  /**
   * The source of the content being delivered via CDN within given origin group.
   */
  origins: ResourceReference[];

  /**
   * Time in minutes to shift the traffic to the endpoint gradually when an unhealthy endpoint comes healthy or a new endpoint is added. Default is 10 mins. This property is currently not supported.
   */
  @maxValue(50)
  trafficRestorationTimeToHealedOrNewEndpointsInMinutes?: int32;

  /**
   * The JSON object that contains the properties to determine origin health using real requests/responses.This property is currently not supported.
   */
  responseBasedOriginErrorDetectionSettings?: ResponseBasedOriginErrorDetectionSettings;
}

/**
 * The JSON object that contains the properties to determine origin health using real requests/responses.
 */
model ResponseBasedOriginErrorDetectionSettings {
  /**
   * Type of response errors for real user requests for which origin will be deemed unhealthy
   */
  @projectedName("json", "responseBasedDetectedErrorTypes")
  responseBasedDetectedErrorType?: ResponseBasedDetectedErrorTypes;

  /**
   * The percentage of failed requests in the sample where failover should trigger.
   */
  @maxValue(100)
  responseBasedFailoverThresholdPercentage?: int32;

  /**
   * The list of Http status code ranges that are considered as server errors for origin and it is marked as unhealthy.
   */
  httpErrorRanges?: HttpErrorRange[];
}

/**
 * The JSON object that represents the range for http status codes
 */
model HttpErrorRange {
  /**
   * The inclusive start of the http status code range.
   */
  @maxValue(999)
  @minValue(100)
  begin?: int32;

  /**
   * The inclusive end of the http status code range.
   */
  @maxValue(999)
  @minValue(100)
  end?: int32;
}

/**
 * The JSON object that contains the properties of the custom domain to create.
 */
model CustomDomainProperties {
  /**
   * The host name of the custom domain. Must be a domain name.
   */
  hostName: string;

  /**
   * Resource status of the custom domain.
   */
  @visibility("read")
  resourceState?: CustomDomainResourceState;

  /**
   * Provisioning status of the custom domain.
   */
  @visibility("read")
  customHttpsProvisioningState?: CustomHttpsProvisioningState;

  /**
   * Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.
   */
  @visibility("read")
  @projectedName("json", "customHttpsProvisioningSubstate")
  customHttpsAvailabilityState?: CustomHttpsAvailabilityState;

  /**
   * Certificate parameters for securing custom HTTPS
   */
  @projectedName("json", "customHttpsParameters")
  customDomainHttpsContent?: CustomDomainHttpsParameters;

  /**
   * Special validation or data may be required when delivering CDN to some regions due to local compliance reasons. E.g. ICP license number of a custom domain is required to deliver content in China.
   */
  validationData?: string;

  /**
   * Provisioning status of Custom Https of the custom domain.
   */
  @visibility("read")
  provisioningState?: CustomHttpsProvisioningState;
}

/**
 * The JSON object that contains the properties to secure a custom domain.
 */
@discriminator("certificateSource")
model CustomDomainHttpsParameters {
  /**
   * Defines the TLS extension protocol that is used for secure delivery.
   */
  protocolType: SecureDeliveryProtocolType;

  /**
   * TLS protocol version that will be used for Https
   */
  minimumTlsVersion?: CdnMinimumTlsVersion;
}

/**
 * The JSON object containing endpoint update parameters.
 */
model EndpointPropertiesUpdateParameters {
  /**
   * A directory path on the origin that CDN can use to retrieve content from, e.g. contoso.cloudapp.net/originpath.
   */
  originPath?: string;

  /**
   * List of content types on which compression applies. The value should be a valid MIME type.
   */
  contentTypesToCompress?: string[];

  /**
   * The host header value sent to the origin with each request. This property at Endpoint is only allowed when endpoint uses single origin and can be overridden by the same property specified at origin.If you leave this blank, the request hostname determines this value. Azure CDN origins, such as Web Apps, Blob Storage, and Cloud Services require this host header value to match the origin hostname by default.
   */
  originHostHeader?: string;

  /**
   * Indicates whether content compression is enabled on CDN. Default value is false. If compression is enabled, content will be served as compressed if user requests for a compressed version. Content won't be compressed on CDN when requested content is smaller than 1 byte or larger than 1 MB.
   */
  isCompressionEnabled?: boolean;

  /**
   * Indicates whether HTTP traffic is allowed on the endpoint. Default value is true. At least one protocol (HTTP or HTTPS) must be allowed.
   */
  isHttpAllowed?: boolean;

  /**
   * Indicates whether HTTPS traffic is allowed on the endpoint. Default value is true. At least one protocol (HTTP or HTTPS) must be allowed.
   */
  isHttpsAllowed?: boolean;

  /**
   * Defines how CDN caches requests that include query strings. You can ignore any query strings when caching, bypass caching to prevent requests that contain query strings from being cached, or cache every request with a unique URL.
   */
  queryStringCachingBehavior?: QueryStringCachingBehavior;

  /**
   * Specifies what scenario the customer wants this CDN endpoint to optimize for, e.g. Download, Media services. With this information, CDN can apply scenario driven optimization.
   */
  optimizationType?: OptimizationType;

  /**
   * Path to a file hosted on the origin which helps accelerate delivery of the dynamic content and calculate the most optimal routes for the CDN. This is relative to the origin path. This property is only relevant when using a single origin.
   */
  probePath?: string;

  /**
   * List of rules defining the user's geo access within a CDN endpoint. Each geo filter defines an access rule to a specified path or content, e.g. block APAC for path /pictures/
   */
  geoFilters?: GeoFilter[];

  /**
   * A reference to the origin group.
   */
  defaultOriginGroup?: EndpointPropertiesUpdateParametersDefaultOriginGroup;

  /**
   * List of keys used to validate the signed URL hashes.
   */
  urlSigningKeys?: UrlSigningKey[];

  /**
   * A policy that specifies the delivery rules to be used for an endpoint.
   */
  deliveryPolicy?: EndpointPropertiesUpdateParametersDeliveryPolicy;

  /**
   * Defines the Web Application Firewall policy for the endpoint (if applicable)
   */
  webApplicationFirewallPolicyLink?: EndpointPropertiesUpdateParametersWebApplicationFirewallPolicyLink;
}

/**
 * Rules defining user's geo access within a CDN endpoint.
 */
model GeoFilter {
  /**
   * Relative path applicable to geo filter. (e.g. '/mypictures', '/mypicture/kitty.jpg', and etc.)
   */
  relativePath: string;

  /**
   * Action of the geo filter, i.e. allow or block access.
   */
  action: GeoFilterActions;

  /**
   * Two letter country or region codes defining user country or region access in a geo filter, e.g. AU, MX, US.
   */
  countryCodes: string[];
}

/**
 * A reference to the origin group.
 */
model EndpointPropertiesUpdateParametersDefaultOriginGroup {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Url signing key
 */
model UrlSigningKey {
  /**
   * Defines the customer defined key Id. This id will exist in the incoming request to indicate the key used to form the hash.
   */
  keyId: string;

  /**
   * Defines the parameters for using customer key vault for Url Signing Key.
   */
  keySourceParameters: KeyVaultSigningKey;
}

/**
 * Describes the parameters for using a user's KeyVault for URL Signing Key.
 */
model KeyVaultSigningKey {
  @projectedName("json", "typeName")
  type: KeyVaultSigningKeyType;

  /**
   * Subscription Id of the user's Key Vault containing the secret
   */
  subscriptionId: string;

  /**
   * Resource group of the user's Key Vault containing the secret
   */
  resourceGroupName: string;

  /**
   * The name of the user's Key Vault containing the secret
   */
  vaultName: string;

  /**
   * The name of secret in Key Vault.
   */
  secretName: string;

  /**
   * The version(GUID) of secret in Key Vault.
   */
  secretVersion: string;
}

/**
 * A policy that specifies the delivery rules to be used for an endpoint.
 */
model EndpointPropertiesUpdateParametersDeliveryPolicy {
  /**
   * User-friendly description of the policy.
   */
  description?: string;

  /**
   * A list of the delivery rules.
   */
  rules: DeliveryRule[];
}

/**
 * A rule that specifies a set of actions and conditions
 */
model DeliveryRule {
  /**
   * Name of the rule
   */
  name?: string;

  /**
   * The order in which the rules are applied for the endpoint. Possible values {0,1,2,3,………}. A rule with a lesser order will be applied before a rule with a greater order. Rule with order 0 is a special rule. It does not require any condition and actions listed in it will always be applied.
   */
  order: int32;

  /**
   * A list of conditions that must be matched for the actions to be executed
   */
  conditions?: DeliveryRuleCondition[];

  /**
   * A list of actions that are executed when all the conditions of a rule are satisfied.
   */
  actions: DeliveryRuleAction[];
}

/**
 * Defines the Web Application Firewall policy for the endpoint (if applicable)
 */
model EndpointPropertiesUpdateParametersWebApplicationFirewallPolicyLink {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Properties required to create or update an endpoint.
 */
model EndpointUpdateParameters {
  /**
   * Endpoint tags.
   */
  tags?: Record<string>;

  /**
   * The JSON object containing endpoint update parameters.
   */
  properties?: EndpointPropertiesUpdateParameters;
}

/**
 * Parameters required for content purge.
 */
model PurgeParameters {
  /**
   * The path to the content to be purged. Can describe a file path or a wild card directory.
   */
  contentPaths: string[];
}

/**
 * Parameters required for content load.
 */
model LoadParameters {
  /**
   * The path to the content to be loaded. Path should be a relative file URL of the origin.
   */
  contentPaths: string[];
}

/**
 * The JSON object that contains the properties of the origin.
 */
model OriginProperties extends OriginUpdatePropertiesParameters {
  /**
   * Resource status of the origin.
   */
  @visibility("read")
  resourceState?: OriginResourceState;

  /**
   * Provisioning status of the origin.
   */
  @visibility("read")
  provisioningState?: OriginProvisioningState;

  /**
   * The approval status for the connection to the Private Link
   */
  @visibility("read")
  privateEndpointStatus?: PrivateEndpointStatus;
}

/**
 * The JSON object that contains the properties of the origin.
 */
model OriginUpdatePropertiesParameters {
  /**
   * The address of the origin. Domain names, IPv4 addresses, and IPv6 addresses are supported.This should be unique across all origins in an endpoint.
   */
  hostName?: string;

  /**
   * The value of the HTTP port. Must be between 1 and 65535.
   */
  @maxValue(65535)
  @minValue(1)
  httpPort?: int32;

  /**
   * The value of the HTTPS port. Must be between 1 and 65535.
   */
  @maxValue(65535)
  @minValue(1)
  httpsPort?: int32;

  /**
   * The host header value sent to the origin with each request. If you leave this blank, the request hostname determines this value. Azure CDN origins, such as Web Apps, Blob Storage, and Cloud Services require this host header value to match the origin hostname by default. This overrides the host header defined at Endpoint
   */
  originHostHeader?: string;

  /**
   * Priority of origin in given origin group for load balancing. Higher priorities will not be used for load balancing if any lower priority origin is healthy.Must be between 1 and 5
   */
  @maxValue(5)
  @minValue(1)
  priority?: int32;

  /**
   * Weight of the origin in given origin group for load balancing. Must be between 1 and 1000
   */
  @maxValue(1000)
  @minValue(1)
  weight?: int32;

  /**
   * Origin is enabled for load balancing or not
   */
  enabled?: boolean;

  /**
   * The Alias of the Private Link resource. Populating this optional field indicates that this origin is 'Private'
   */
  privateLinkAlias?: string;

  /**
   * The Resource Id of the Private Link resource. Populating this optional field indicates that this backend is 'Private'
   */
  privateLinkResourceId?: string;

  /**
   * The location of the Private Link resource. Required only if 'privateLinkResourceId' is populated
   */
  privateLinkLocation?: string;

  /**
   * A custom message to be included in the approval request to connect to the Private Link.
   */
  privateLinkApprovalMessage?: string;
}

/**
 * Origin properties needed for origin update.
 */
model OriginUpdateParameters {
  /**
   * The JSON object that contains the properties of the origin.
   */
  properties?: OriginUpdatePropertiesParameters;
}

/**
 * The JSON object that contains the properties of the origin group.
 */
model OriginGroupProperties extends OriginGroupUpdatePropertiesParameters {
  /**
   * Resource status of the origin group.
   */
  @visibility("read")
  resourceState?: OriginGroupResourceState;

  /**
   * Provisioning status of the origin group.
   */
  @visibility("read")
  provisioningState?: OriginGroupProvisioningState;
}

/**
 * The JSON object that contains the properties of the origin group.
 */
model OriginGroupUpdatePropertiesParameters {
  /**
   * Health probe settings to the origin that is used to determine the health of the origin.
   */
  healthProbeSettings?: HealthProbeSettings;

  /**
   * The source of the content being delivered via CDN within given origin group.
   */
  origins?: ResourceReference[];

  /**
   * Time in minutes to shift the traffic to the endpoint gradually when an unhealthy endpoint comes healthy or a new endpoint is added. Default is 10 mins. This property is currently not supported.
   */
  @maxValue(50)
  trafficRestorationTimeToHealedOrNewEndpointsInMinutes?: int32;

  /**
   * The JSON object that contains the properties to determine origin health using real requests/responses. This property is currently not supported.
   */
  responseBasedOriginErrorDetectionSettings?: ResponseBasedOriginErrorDetectionSettings;
}

/**
 * Origin group properties needed for origin group creation or update.
 */
model OriginGroupUpdateParameters {
  /**
   * The JSON object that contains the properties of the origin group.
   */
  properties?: OriginGroupUpdatePropertiesParameters;
}

/**
 * The customDomain JSON object required for custom domain creation or update.
 */
model CustomDomainParameters {
  /**
   * The JSON object that contains the properties of the custom domain to create.
   */
  properties?: CustomDomainPropertiesParameters;
}

/**
 * The JSON object that contains the properties of the custom domain to create.
 */
model CustomDomainPropertiesParameters {
  /**
   * The host name of the custom domain. Must be a domain name.
   */
  hostName: string;
}

/**
 * Input of CheckNameAvailability API.
 */
model CdnNameAvailabilityContent {
  /**
   * The resource name to validate.
   */
  name: string;

  /**
   * The type of the resource whose name is to be validated.
   */
  type: CdnResourceType;
}

/**
 * Input of the validate probe API.
 */
model ValidateProbeInput {
  /**
   * The probe URL to validate.
   */
  probeURL: string;
}

/**
 * Output of the validate probe API.
 */
model ValidateProbeResult {
  /**
   * Indicates whether the probe URL is accepted or not.
   */
  @visibility("read")
  isValid?: boolean;

  /**
   * Specifies the error code when the probe url is not accepted.
   */
  @visibility("read")
  errorCode?: string;

  /**
   * The detailed error message describing why the probe URL is not accepted.
   */
  @visibility("read")
  message?: string;
}

/**
 * Properties of operation, include metric specifications.
 */
model OperationProperties {
  /**
   * One property of operation, include metric specifications.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * One property of operation, include log specifications.
 */
model ServiceSpecification {
  /**
   * Log specifications of operation.
   */
  logSpecifications?: LogSpecification[];

  /**
   * Metric specifications of operation.
   */
  metricSpecifications?: MetricSpecification[];
}

/**
 * Log specification of operation.
 */
model LogSpecification {
  /**
   * Name of log specification.
   */
  name?: string;

  /**
   * Display name of log specification.
   */
  displayName?: string;

  /**
   * Blob duration of specification.
   */
  blobDuration?: string;

  /**
   * Pattern to filter based on name
   */
  logFilterPattern?: string;
}

/**
 * Metric specification of operation.
 */
model MetricSpecification {
  /**
   * Name of metric specification.
   */
  name?: string;

  /**
   * Display name of metric specification.
   */
  displayName?: string;

  /**
   * Display description of metric specification.
   */
  displayDescription?: string;

  /**
   * The metric unit. Possible values include: 'Bytes', 'Count', 'Milliseconds'.
   */
  unit?: string;

  /**
   * The metric aggregation type. Possible values include: 'Average', 'Count', 'Total'.
   */
  aggregationType?: string;

  /**
   * Retention policies of a resource metric.
   */
  availabilities?: MetricAvailability[];

  /**
   * The supported time grain types for the metrics.
   */
  supportedTimeGrainTypes?: string[];

  /**
   * The dimensions of metric
   */
  dimensions?: DimensionProperties[];

  /**
   * Property to specify whether to fill gap with zero.
   */
  fillGapWithZero?: boolean;

  /**
   * Pattern to filter based on name
   */
  metricFilterPattern?: string;

  /**
   * Property to specify metric is internal or not.
   */
  isInternal?: boolean;
}

/**
 * Retention policy of a resource metric.
 */
model MetricAvailability {
  timeGrain?: string;
  blobDuration?: string;
}

/**
 * Type of operation: get, read, delete, etc.
 */
model DimensionProperties {
  /**
   * Name of dimension.
   */
  name?: string;

  /**
   * Display name of dimension.
   */
  displayName?: string;

  /**
   * Internal name of dimension.
   */
  internalName?: string;
}

/**
 * Result of the request to list CDN edgenodes. It contains a list of ip address group and a URL link to get the next set of results.
 */
model EdgenodeResult is Azure.Core.Page<EdgeNode>;

/**
 * Edgenode is a global Point of Presence (POP) location used to deliver CDN content to end users.
 */
model EdgeNode {
  /**
   * The JSON object that contains the properties required to create an edgenode.
   */
  properties?: EdgeNodeProperties;
}

/**
 * The JSON object that contains the properties required to create an edgenode.
 */
model EdgeNodeProperties {
  /**
   * List of ip address groups.
   */
  ipAddressGroups: IpAddressGroup[];
}

/**
 * CDN Ip address group
 */
model IpAddressGroup {
  /**
   * The delivery region of the ip address group
   */
  deliveryRegion?: string;

  /**
   * The list of ip v4 addresses.
   */
  ipv4Addresses?: CidrIpAddress[];

  /**
   * The list of ip v6 addresses.
   */
  ipv6Addresses?: CidrIpAddress[];
}

/**
 * CIDR Ip address
 */
model CidrIpAddress {
  /**
   * Ip address itself.
   */
  baseIpAddress?: string;

  /**
   * The length of the prefix of the ip address.
   */
  prefixLength?: int32;
}

/**
 * Defines CDN web application firewall policy properties.
 */
model CdnWebApplicationFirewallPolicyProperties {
  /**
   * Describes  policySettings for policy
   */
  policySettings?: WafPolicySettings;

  /**
   * Describes rate limit rules inside the policy.
   */
  @projectedName("json", "rateLimitRules")
  rateLimitSettings?: RateLimitRuleList;

  /**
   * Describes custom rules inside the policy.
   */
  @projectedName("json", "customRules")
  customSettings?: CustomRuleList;

  /**
   * Describes managed rules inside the policy.
   */
  managedRules?: ManagedRuleSetList;

  /**
   * Describes Azure CDN endpoints associated with this Web Application Firewall policy.
   */
  @visibility("read")
  endpointLinks?: CdnEndpointReference[];

  /**
   * Provisioning state of the WebApplicationFirewallPolicy.
   */
  @visibility("read")
  provisioningState?: WebApplicationFirewallPolicyProvisioningState;

  /**
   * Resource status of the policy.
   */
  @visibility("read")
  resourceState?: PolicyResourceState;
}

/**
 * Defines contents of a web application firewall global configuration
 */
model WafPolicySettings {
  /**
   * describes if the policy is in enabled state or disabled state
   */
  enabledState?: PolicyEnabledState;

  /**
   * Describes if it is in detection mode or prevention mode at policy level.
   */
  mode?: PolicyMode;

  /**
   * If action type is redirect, this field represents the default redirect URL for the client.
   */
  defaultRedirectUrl?: string;

  /**
   * If the action type is block, this field defines the default customer overridable http response status code.
   */
  defaultCustomBlockResponseStatusCode?: PolicySettingsDefaultCustomBlockResponseStatusCode;

  /**
   * If the action type is block, customer can override the response body. The body must be specified in base64 encoding.
   */
  @pattern("^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$")
  defaultCustomBlockResponseBody?: string;
}

/**
 * Defines contents of rate limit rules
 */
model RateLimitRuleList {
  /**
   * List of rules
   */
  rules?: RateLimitRule[];
}

/**
 * Defines a rate limiting rule that can be included in a waf policy
 */
model RateLimitRule extends CustomRule {
  /**
   * Defines rate limit threshold.
   */
  rateLimitThreshold: int32;

  /**
   * Defines rate limit duration. Default is 1 minute.
   */
  @maxValue(60)
  rateLimitDurationInMinutes: int32;
}

/**
 * Defines the common attributes for a custom rule that can be included in a waf policy
 */
model CustomRule {
  /**
   * Defines the name of the custom rule
   */
  name: string;

  /**
   * Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.
   */
  enabledState?: CustomRuleEnabledState;

  /**
   * Defines in what order this rule be evaluated in the overall list of custom rules
   */
  @maxValue(1000)
  priority: int32;

  /**
   * List of match conditions.
   */
  matchConditions: CustomRuleMatchCondition[];

  /**
   * Describes what action to be applied when rule matches
   */
  action: OverrideActionType;
}

/**
 * Define match conditions
 */
model CustomRuleMatchCondition {
  /**
   * Match variable to compare against.
   */
  matchVariable: WafMatchVariable;

  /**
   * Selector can used to match a specific key for QueryString, Cookies, RequestHeader or PostArgs.
   */
  selector?: string;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  matchOperator: MatchOperator;

  /**
   * Describes if the result of this condition should be negated.
   */
  negateCondition?: boolean;

  /**
   * List of possible match values.
   */
  matchValue: string[];

  /**
   * List of transforms.
   */
  transforms?: TransformType[];
}

/**
 * Defines contents of custom rules
 */
model CustomRuleList {
  /**
   * List of rules
   */
  rules?: CustomRule[];
}

/**
 * Defines the list of managed rule sets for the policy.
 */
model ManagedRuleSetList {
  /**
   * List of rule sets.
   */
  managedRuleSets?: WafPolicyManagedRuleSet[];
}

/**
 * Defines a managed rule set.
 */
model WafPolicyManagedRuleSet {
  /**
   * Defines the rule set type to use.
   */
  ruleSetType: string;

  /**
   * Defines the version of the rule set to use.
   */
  ruleSetVersion: string;

  /**
   * Verizon only : If the rule set supports anomaly detection mode, this describes the threshold for blocking requests.
   */
  @maxValue(20)
  anomalyScore?: int32;

  /**
   * Defines the rule overrides to apply to the rule set.
   */
  ruleGroupOverrides?: ManagedRuleGroupOverrideSetting[];
}

/**
 * Defines a managed rule group override setting.
 */
model ManagedRuleGroupOverrideSetting {
  /**
   * Describes the managed rule group within the rule set to override
   */
  ruleGroupName: string;

  /**
   * List of rules that will be disabled. If none specified, all rules in the group will be disabled.
   */
  rules?: ManagedRuleOverrideSetting[];
}

/**
 * Defines a managed rule group override setting.
 */
model ManagedRuleOverrideSetting {
  /**
   * Identifier for the managed rule.
   */
  ruleId: string;

  /**
   * Describes if the managed rule is in enabled or disabled state. Defaults to Disabled if not specified.
   */
  enabledState?: ManagedRuleSetupState;

  /**
   * Describes the override action to be applied when rule matches.
   */
  action?: OverrideActionType;
}

/**
 * Defines the ARM Resource ID for the linked endpoints
 */
model CdnEndpointReference {
  /**
   * ARM Resource ID string.
   */
  id?: string;
}

/**
 * Properties required to update a CdnWebApplicationFirewallPolicy.
 */
model CdnWebApplicationFirewallPolicyPatchParameters {
  /**
   * CdnWebApplicationFirewallPolicy tags
   */
  tags?: Record<string>;
}

/**
 * List of managed rule set definitions available for use in a policy.
 */
model ManagedRuleSetDefinitionList is Azure.Core.Page<ManagedRuleSetDefinition>;

/**
 * Describes a managed rule set definition.
 */
model ManagedRuleSetDefinition extends Resource {
  /**
   * Describes managed rule set definition properties.
   */
  properties?: ManagedRuleSetDefinitionProperties;

  /**
   * The pricing tier (defines a CDN provider, feature list and rate) of the CdnWebApplicationFirewallPolicy.
   */
  sku?: Sku;
}

/**
 * Properties for a managed rule set definition.
 */
model ManagedRuleSetDefinitionProperties {
  /**
   * Provisioning state of the managed rule set.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Type of the managed rule set.
   */
  @visibility("read")
  ruleSetType?: string;

  /**
   * Version of the managed rule set type.
   */
  @visibility("read")
  ruleSetVersion?: string;

  /**
   * Rule groups of the managed rule set.
   */
  @visibility("read")
  ruleGroups?: ManagedRuleGroupDefinition[];
}

/**
 * Describes a managed rule group.
 */
model ManagedRuleGroupDefinition {
  /**
   * Name of the managed rule group.
   */
  @visibility("read")
  ruleGroupName?: string;

  /**
   * Description of the managed rule group.
   */
  @visibility("read")
  description?: string;

  /**
   * List of rules within the managed rule group.
   */
  @visibility("read")
  rules?: ManagedRuleDefinition[];
}

/**
 * Describes a managed rule definition.
 */
model ManagedRuleDefinition {
  /**
   * Identifier for the managed rule.
   */
  @visibility("read")
  ruleId?: string;

  /**
   * Describes the functionality of the managed rule.
   */
  @visibility("read")
  description?: string;
}

/**
 * Certificate used for https
 */
model Certificate {
  /**
   * The type of the secret resource.
   */
  type?: SecretType;

  /**
   * Subject name in the certificate.
   */
  @visibility("read")
  subject?: string;

  /**
   * Certificate expiration date.
   */
  @visibility("read")
  expirationDate?: string;
}

/**
 * Managed Certificate used for https
 */
model ManagedCertificate extends Certificate {}

/**
 * Customer Certificate used for https
 */
model CustomerCertificate extends Certificate {
  /**
   * Resource reference to the Azure Key Vault certificate. Expected to be in format of /subscriptions/{​​​​​​​​​subscriptionId}​​​​​​​​​/resourceGroups/{​​​​​​​​​resourceGroupName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/providers/Microsoft.KeyVault/vaults/{vaultName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/secrets/{certificateName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
   */
  secretSource?: ResourceReference;

  /**
   * Certificate version.
   */
  secretVersion?: string;

  /**
   * Certificate issuing authority.
   */
  @visibility("read")
  certificateAuthority?: string;

  /**
   * Whether to use the latest version for the certificate
   */
  useLatestVersion?: boolean;

  /**
   * The list of SANs.
   */
  subjectAlternativeNames?: string[];

  /**
   * Certificate thumbprint.
   */
  @visibility("read")
  thumbprint?: string;
}

/**
 * Azure FirstParty Managed Certificate provided by other first party resource providers to enable HTTPS.
 */
model AzureFirstPartyManagedCertificate extends Certificate {}

/**
 * Input of the secret to be validated.
 */
model ValidateSecretInput {
  /**
   * The secret type.
   */
  secretType: SecretType;

  /**
   * Resource reference to the Azure Key Vault secret. Expected to be in format of /subscriptions/{​​​​​​​​​subscriptionId}​​​​​​​​​/resourceGroups/{​​​​​​​​​resourceGroupName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/providers/Microsoft.KeyVault/vaults/{vaultName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/secrets/{secretName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
   */
  secretSource: ResourceReference;

  /**
   * Secret version, if customer is using a specific version.
   */
  secretVersion?: string;
}

/**
 * Output of the validated secret.
 */
model ValidateSecretResult {
  /**
   * The validation status.
   */
  status?: ValidationStatus;

  /**
   * Detailed error message
   */
  message?: string;
}

/**
 * The json object containing security policy waf parameters
 */
model SecurityPolicyWebApplicationFirewall extends SecurityPolicyProperties {
  /**
   * Resource ID.
   */
  wafPolicy?: ResourceReference;

  /**
   * Waf associations
   */
  associations?: SecurityPolicyWebApplicationFirewallAssociation[];

  /**
   * The type of the Security policy to create.
   */
  type: "WebApplicationFirewall";
}

/**
 * settings for security policy patterns to match
 */
model SecurityPolicyWebApplicationFirewallAssociation {
  /**
   * List of domains.
   */
  domains?: FrontDoorActivatedResourceInfo[];

  /**
   * List of paths
   */
  patternsToMatch?: string[];
}

/**
 * Url signing key parameters
 */
model UriSigningKeyProperties extends SecretProperties {
  /**
   * Defines the customer defined key Id. This id will exist in the incoming request to indicate the key used to form the hash.
   */
  keyId: string;

  /**
   * Resource reference to the Azure Key Vault secret. Expected to be in format of /subscriptions/{​​​​​​​​​subscriptionId}​​​​​​​​​/resourceGroups/{​​​​​​​​​resourceGroupName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/providers/Microsoft.KeyVault/vaults/{vaultName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/secrets/{secretName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
   */
  secretSource: ResourceReference;

  /**
   * Version of the secret to be used
   */
  secretVersion?: string;

  /**
   * The type of the secret resource.
   */
  type: "UrlSigningKey";
}

/**
 * Managed Certificate used for https
 */
model ManagedCertificateProperties extends SecretProperties {
  /**
   * Subject name in the certificate.
   */
  @visibility("read")
  subject?: string;

  /**
   * Certificate expiration date.
   */
  @visibility("read")
  @projectedName("json", "expirationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresDate?: utcDateTime;

  /**
   * The type of the secret resource.
   */
  type: "ManagedCertificate";
}

/**
 * Customer Certificate used for https
 */
model CustomerCertificateProperties extends SecretProperties {
  /**
   * Resource reference to the Azure Key Vault certificate. Expected to be in format of /subscriptions/{​​​​​​​​​subscriptionId}​​​​​​​​​/resourceGroups/{​​​​​​​​​resourceGroupName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/providers/Microsoft.KeyVault/vaults/{vaultName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​/secrets/{certificateName}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
   */
  secretSource: ResourceReference;

  /**
   * Version of the secret to be used
   */
  secretVersion?: string;

  /**
   * Whether to use the latest version for the certificate
   */
  useLatestVersion?: boolean;

  /**
   * Subject name in the certificate.
   */
  @visibility("read")
  subject?: string;

  /**
   * Certificate expiration date.
   */
  @visibility("read")
  @projectedName("json", "expirationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresDate?: utcDateTime;

  /**
   * Certificate issuing authority.
   */
  @visibility("read")
  certificateAuthority?: string;

  /**
   * The list of SANs.
   */
  subjectAlternativeNames?: string[];

  /**
   * Certificate thumbprint.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * The type of the secret resource.
   */
  type: "CustomerCertificate";
}

/**
 * Azure FirstParty Managed Certificate provided by other first party resource providers to enable HTTPS.
 */
model AzureFirstPartyManagedCertificateProperties extends SecretProperties {
  /**
   * The type of the secret resource.
   */
  type: "AzureFirstPartyManagedCertificate";
}

/**
 * The validation token.
 */
model ValidationToken {
  @visibility("read")
  token?: string;
}

/**
 * Defines the RemoteAddress condition for the delivery rule.
 */
model DeliveryRuleRemoteAddressCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: RemoteAddressMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "RemoteAddress";
}

/**
 * Defines the parameters for RemoteAddress match conditions
 */
model RemoteAddressMatchCondition {
  @projectedName("json", "typeName")
  type: RemoteAddressMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  remoteAddressOperator: RemoteAddressOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * Match values to match against. The operator will apply to each value in here with OR semantics. If any of them match the variable with the given operator this match condition is considered a match.
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the RequestMethod condition for the delivery rule.
 */
model DeliveryRuleRequestMethodCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: RequestMethodMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "RequestMethod";
}

/**
 * Defines the parameters for RequestMethod match conditions
 */
model RequestMethodMatchCondition {
  @projectedName("json", "typeName")
  type: RequestMethodMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  requestMethodOperator: RequestMethodOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: RequestMethodMatchConditionMatchValue[];
}

/**
 * Defines the QueryString condition for the delivery rule.
 */
model DeliveryRuleQueryStringCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: QueryStringMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "QueryString";
}

/**
 * Defines the parameters for QueryString match conditions
 */
model QueryStringMatchCondition {
  @projectedName("json", "typeName")
  type: QueryStringMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  queryStringOperator: QueryStringOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the PostArgs condition for the delivery rule.
 */
model DeliveryRulePostArgsCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: PostArgsMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "PostArgs";
}

/**
 * Defines the parameters for PostArgs match conditions
 */
model PostArgsMatchCondition {
  @projectedName("json", "typeName")
  type: PostArgsMatchConditionType;

  /**
   * Name of PostArg to be matched
   */
  selector?: string;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  postArgsOperator: PostArgsOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the RequestUri condition for the delivery rule.
 */
model DeliveryRuleRequestUriCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: RequestUriMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "RequestUri";
}

/**
 * Defines the parameters for RequestUri match conditions
 */
model RequestUriMatchCondition {
  @projectedName("json", "typeName")
  type: RequestUriMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  requestUriOperator: RequestUriOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the RequestHeader condition for the delivery rule.
 */
model DeliveryRuleRequestHeaderCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: RequestHeaderMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "RequestHeader";
}

/**
 * Defines the parameters for RequestHeader match conditions
 */
model RequestHeaderMatchCondition {
  @projectedName("json", "typeName")
  type: RequestHeaderMatchConditionType;

  /**
   * Name of Header to be matched
   */
  selector?: string;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  requestHeaderOperator: RequestHeaderOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the RequestBody condition for the delivery rule.
 */
model DeliveryRuleRequestBodyCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: RequestBodyMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "RequestBody";
}

/**
 * Defines the parameters for RequestBody match conditions
 */
model RequestBodyMatchCondition {
  @projectedName("json", "typeName")
  type: RequestBodyMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  requestBodyOperator: RequestBodyOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the RequestScheme condition for the delivery rule.
 */
model DeliveryRuleRequestSchemeCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: RequestSchemeMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "RequestScheme";
}

/**
 * Defines the parameters for RequestScheme match conditions
 */
model RequestSchemeMatchCondition {
  @projectedName("json", "typeName")
  type: RequestSchemeMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  requestSchemeOperator: RequestSchemeOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: RequestSchemeMatchConditionMatchValue[];
}

/**
 * Defines the UrlPath condition for the delivery rule.
 */
model DeliveryRuleUrlPathCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: UrlPathMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "UrlPath";
}

/**
 * Defines the parameters for UrlPath match conditions
 */
model UrlPathMatchCondition {
  @projectedName("json", "typeName")
  type: UrlPathMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  urlPathOperator: UrlPathOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the UrlFileExtension condition for the delivery rule.
 */
model DeliveryRuleUrlFileExtensionCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: UrlFileExtensionMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "UrlFileExtension";
}

/**
 * Defines the parameters for UrlFileExtension match conditions
 */
model UrlFileExtensionMatchCondition {
  @projectedName("json", "typeName")
  type: UrlFileExtensionMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  urlFileExtensionOperator: UrlFileExtensionOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the UrlFileName condition for the delivery rule.
 */
model DeliveryRuleUrlFileNameCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: UrlFileNameMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "UrlFileName";
}

/**
 * Defines the parameters for UrlFilename match conditions
 */
model UrlFileNameMatchCondition {
  @projectedName("json", "typeName")
  type: UrlFileNameMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  urlFileNameOperator: UrlFileNameOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the HttpVersion condition for the delivery rule.
 */
model DeliveryRuleHttpVersionCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: HttpVersionMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "HttpVersion";
}

/**
 * Defines the parameters for HttpVersion match conditions
 */
model HttpVersionMatchCondition {
  @projectedName("json", "typeName")
  type: HttpVersionMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  httpVersionOperator: HttpVersionOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the Cookies condition for the delivery rule.
 */
model DeliveryRuleCookiesCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: CookiesMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "Cookies";
}

/**
 * Defines the parameters for Cookies match conditions
 */
model CookiesMatchCondition {
  @projectedName("json", "typeName")
  type: CookiesMatchConditionType;

  /**
   * Name of Cookies to be matched
   */
  selector?: string;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  cookiesOperator: CookiesOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the IsDevice condition for the delivery rule.
 */
model DeliveryRuleIsDeviceCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: IsDeviceMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "IsDevice";
}

/**
 * Defines the parameters for IsDevice match conditions
 */
model IsDeviceMatchCondition {
  @projectedName("json", "typeName")
  type: IsDeviceMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  IsDeviceOperator: IsDeviceOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: IsDeviceMatchConditionMatchValue[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the SocketAddress condition for the delivery rule.
 */
model DeliveryRuleSocketAddressCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: SocketAddressMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "SocketAddr";
}

/**
 * Defines the parameters for SocketAddress match conditions
 */
model SocketAddressMatchCondition {
  @projectedName("json", "typeName")
  type: SocketAddressMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  socketAddressOperator: SocketAddressOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the ClientPort condition for the delivery rule.
 */
model DeliveryRuleClientPortCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: ClientPortMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "ClientPort";
}

/**
 * Defines the parameters for ClientPort match conditions
 */
model ClientPortMatchCondition {
  @projectedName("json", "typeName")
  type: ClientPortMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  clientPortOperator: ClientPortOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the ServerPort condition for the delivery rule.
 */
model DeliveryRuleServerPortCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: ServerPortMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "ServerPort";
}

/**
 * Defines the parameters for ServerPort match conditions
 */
model ServerPortMatchCondition {
  @projectedName("json", "typeName")
  type: ServerPortMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  serverPortOperator: ServerPortOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the HostName condition for the delivery rule.
 */
model DeliveryRuleHostNameCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: HostNameMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "HostName";
}

/**
 * Defines the parameters for HostName match conditions
 */
model HostNameMatchCondition {
  @projectedName("json", "typeName")
  type: HostNameMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  hostNameOperator: HostNameOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: string[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the SslProtocol condition for the delivery rule.
 */
model DeliveryRuleSslProtocolCondition extends DeliveryRuleCondition {
  /**
   * Defines the parameters for the condition.
   */
  @projectedName("json", "parameters")
  properties: SslProtocolMatchCondition;

  /**
   * The name of the condition for the delivery rule.
   */
  name: "SslProtocol";
}

/**
 * Defines the parameters for SslProtocol match conditions
 */
model SslProtocolMatchCondition {
  @projectedName("json", "typeName")
  type: SslProtocolMatchConditionType;

  /**
   * Describes operator to be matched
   */
  @projectedName("json", "operator")
  sslProtocolOperator: SslProtocolOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * The match value for the condition of the delivery rule
   */
  matchValues?: SslProtocol[];

  /**
   * List of transforms
   */
  transforms?: PreTransformCategory[];
}

/**
 * Defines the url redirect action for the delivery rule.
 */
model UrlRedirectAction extends DeliveryRuleAction {
  /**
   * Defines the parameters for the action.
   */
  @projectedName("json", "parameters")
  properties: UrlRedirectActionProperties;

  /**
   * The name of the action for the delivery rule.
   */
  name: "UrlRedirect";
}

/**
 * Defines the parameters for the url redirect action.
 */
model UrlRedirectActionProperties {
  @projectedName("json", "typeName")
  type: UrlRedirectActionType;

  /**
   * The redirect type the rule will use when redirecting traffic.
   */
  redirectType: RedirectType;

  /**
   * Protocol to use for the redirect. The default value is MatchRequest
   */
  destinationProtocol?: DestinationProtocol;

  /**
   * The full path to redirect. Path cannot be empty and must start with /. Leave empty to use the incoming path as destination path.
   */
  customPath?: string;

  /**
   * Host to redirect. Leave empty to use the incoming host as the destination host.
   */
  customHostname?: string;

  /**
   * The set of query strings to be placed in the redirect URL. Setting this value would replace any existing query string; leave empty to preserve the incoming query string. Query string must be in <key>=<value> format. ? and & will be added automatically so do not include them.
   */
  customQueryString?: string;

  /**
   * Fragment to add to the redirect URL. Fragment is the part of the URL that comes after #. Do not include the #.
   */
  customFragment?: string;
}

/**
 * Defines the url signing action for the delivery rule.
 */
model UrlSigningAction extends DeliveryRuleAction {
  /**
   * Defines the parameters for the action.
   */
  @projectedName("json", "parameters")
  properties: UrlSigningActionProperties;

  /**
   * The name of the action for the delivery rule.
   */
  name: "UrlSigning";
}

/**
 * Defines the parameters for the Url Signing action.
 */
model UrlSigningActionProperties {
  @projectedName("json", "typeName")
  type: UrlSigningActionType;

  /**
   * Algorithm to use for URL signing
   */
  algorithm?: UrlSigningAlgorithm;

  /**
   * Defines which query string parameters in the url to be considered for expires, key id etc.
   */
  parameterNameOverride?: UrlSigningParamIdentifier[];
}

/**
 * Defines how to identify a parameter for a specific purpose e.g. expires
 */
model UrlSigningParamIdentifier {
  /**
   * Indicates the purpose of the parameter
   */
  paramIndicator: ParamIndicator;

  /**
   * Parameter name
   */
  paramName: string;
}

/**
 * Defines the origin group override action for the delivery rule.
 */
model OriginGroupOverrideAction extends DeliveryRuleAction {
  /**
   * Defines the parameters for the action.
   */
  @projectedName("json", "parameters")
  properties: OriginGroupOverrideActionProperties;

  /**
   * The name of the action for the delivery rule.
   */
  name: "OriginGroupOverride";
}

/**
 * Defines the parameters for the origin group override action.
 */
model OriginGroupOverrideActionProperties {
  @projectedName("json", "typeName")
  type: OriginGroupOverrideActionType;

  /**
   * defines the OriginGroup that would override the DefaultOriginGroup.
   */
  originGroup: ResourceReference;
}

/**
 * Defines the url rewrite action for the delivery rule.
 */
model UrlRewriteAction extends DeliveryRuleAction {
  /**
   * Defines the parameters for the action.
   */
  @projectedName("json", "parameters")
  properties: UrlRewriteActionProperties;

  /**
   * The name of the action for the delivery rule.
   */
  name: "UrlRewrite";
}

/**
 * Defines the parameters for the url rewrite action.
 */
model UrlRewriteActionProperties {
  @projectedName("json", "typeName")
  type: UrlRewriteActionType;

  /**
   * define a request URI pattern that identifies the type of requests that may be rewritten. If value is blank, all strings are matched.
   */
  sourcePattern: string;

  /**
   * Define the relative URL to which the above requests will be rewritten by.
   */
  destination: string;

  /**
   * Whether to preserve unmatched path. Default value is true.
   */
  preserveUnmatchedPath?: boolean;
}

/**
 * Defines the request header action for the delivery rule.
 */
model DeliveryRuleRequestHeaderAction extends DeliveryRuleAction {
  /**
   * Defines the parameters for the action.
   */
  @projectedName("json", "parameters")
  properties: HeaderActionProperties;

  /**
   * The name of the action for the delivery rule.
   */
  name: "ModifyRequestHeader";
}

/**
 * Defines the parameters for the request header action.
 */
model HeaderActionProperties {
  @projectedName("json", "typeName")
  type: HeaderActionType;

  /**
   * Action to perform
   */
  headerAction: HeaderAction;

  /**
   * Name of the header to modify
   */
  headerName: string;

  /**
   * Value for the specified action
   */
  value?: string;
}

/**
 * Defines the response header action for the delivery rule.
 */
model DeliveryRuleResponseHeaderAction extends DeliveryRuleAction {
  /**
   * Defines the parameters for the action.
   */
  @projectedName("json", "parameters")
  properties: HeaderActionProperties;

  /**
   * The name of the action for the delivery rule.
   */
  name: "ModifyResponseHeader";
}

/**
 * Defines the cache expiration action for the delivery rule.
 */
model DeliveryRuleCacheExpirationAction extends DeliveryRuleAction {
  /**
   * Defines the parameters for the action.
   */
  @projectedName("json", "parameters")
  properties: CacheExpirationActionProperties;

  /**
   * The name of the action for the delivery rule.
   */
  name: "CacheExpiration";
}

/**
 * Defines the parameters for the cache expiration action.
 */
model CacheExpirationActionProperties {
  @projectedName("json", "typeName")
  type: CacheExpirationActionType;

  /**
   * Caching behavior for the requests
   */
  cacheBehavior: CacheBehaviorSetting;

  /**
   * The level at which the content needs to be cached.
   */
  cacheType: CacheLevel;

  /**
   * The duration for which the content needs to be cached. Allowed format is [d.]hh:mm:ss
   */
  cacheDuration?: string;
}

/**
 * Defines the cache-key query string action for the delivery rule.
 */
model DeliveryRuleCacheKeyQueryStringAction extends DeliveryRuleAction {
  /**
   * Defines the parameters for the action.
   */
  @projectedName("json", "parameters")
  properties: CacheKeyQueryStringActionProperties;

  /**
   * The name of the action for the delivery rule.
   */
  name: "CacheKeyQueryString";
}

/**
 * Defines the parameters for the cache-key query string action.
 */
model CacheKeyQueryStringActionProperties {
  @projectedName("json", "typeName")
  type: CacheKeyQueryStringActionType;

  /**
   * Caching behavior for the requests
   */
  queryStringBehavior: QueryStringBehavior;

  /**
   * query parameters to include or exclude (comma separated).
   */
  queryParameters?: string;
}

/**
 * Defines the route configuration override action for the delivery rule. Only applicable to Frontdoor Standard/Premium Profiles.
 */
model DeliveryRuleRouteConfigurationOverrideAction extends DeliveryRuleAction {
  /**
   * Defines the parameters for the action.
   */
  @projectedName("json", "parameters")
  properties: RouteConfigurationOverrideActionProperties;

  /**
   * The name of the action for the delivery rule.
   */
  name: "RouteConfigurationOverride";
}

/**
 * Defines the parameters for the route configuration override action.
 */
model RouteConfigurationOverrideActionProperties {
  @projectedName("json", "typeName")
  type: RouteConfigurationOverrideActionType;

  /**
   * A reference to the origin group override configuration. Leave empty to use the default origin group on route.
   */
  originGroupOverride?: OriginGroupOverride;

  /**
   * The caching configuration associated with this rule. To disable caching, do not provide a cacheConfiguration object.
   */
  cacheConfiguration?: CacheConfiguration;
}

/**
 * Defines the parameters for the origin group override configuration.
 */
model OriginGroupOverride {
  /**
   * defines the OriginGroup that would override the DefaultOriginGroup on route.
   */
  originGroup?: ResourceReference;

  /**
   * Protocol this rule will use when forwarding traffic to backends.
   */
  forwardingProtocol?: ForwardingProtocol;
}

/**
 * Caching settings for a caching-type route. To disable caching, do not provide a cacheConfiguration object.
 */
model CacheConfiguration {
  /**
   * Defines how Frontdoor caches requests that include query strings. You can ignore any query strings when caching, ignore specific query strings, cache every request with a unique URL, or cache specific query strings.
   */
  queryStringCachingBehavior?: RuleQueryStringCachingBehavior;

  /**
   * query parameters to include or exclude (comma separated).
   */
  queryParameters?: string;

  /**
   * Indicates whether content compression is enabled. If compression is enabled, content will be served as compressed if user requests for a compressed version. Content won't be compressed on AzureFrontDoor when requested content is smaller than 1 byte or larger than 1 MB.
   */
  isCompressionEnabled?: RuleIsCompressionEnabled;

  /**
   * Caching behavior for the requests
   */
  cacheBehavior?: RuleCacheBehavior;

  /**
   * The duration for which the content needs to be cached. Allowed format is [d.]hh:mm:ss
   */
  cacheDuration?: string;
}

/**
 * Defines the certificate source parameters using CDN managed certificate for enabling SSL.
 */
model CdnManagedHttpsContent extends CustomDomainHttpsParameters {
  /**
   * Defines the certificate source parameters using CDN managed certificate for enabling SSL.
   */
  certificateSourceParameters: CdnCertificateSource;

  /**
   * Defines the source of the SSL certificate.
   */
  certificateSource: "Cdn";
}

/**
 * Defines the parameters for using CDN managed certificate for securing custom domain.
 */
model CdnCertificateSource {
  @projectedName("json", "typeName")
  type: CdnCertificateSourceType;

  /**
   * Type of certificate used
   */
  certificateType: CdnManagedCertificateType;
}

/**
 * Defines the certificate source parameters using user's keyvault certificate for enabling SSL.
 */
model UserManagedHttpsContent extends CustomDomainHttpsParameters {
  /**
   * Defines the certificate source parameters using user's keyvault certificate for enabling SSL.
   */
  certificateSourceParameters: KeyVaultCertificateSource;

  /**
   * Defines the source of the SSL certificate.
   */
  certificateSource: "AzureKeyVault";
}

/**
 * Describes the parameters for using a user's KeyVault certificate for securing custom domain.
 */
model KeyVaultCertificateSource {
  @projectedName("json", "typeName")
  type: KeyVaultCertificateSourceType;

  /**
   * Subscription Id of the user's Key Vault containing the SSL certificate
   */
  subscriptionId: string;

  /**
   * Resource group of the user's Key Vault containing the SSL certificate
   */
  resourceGroupName: string;

  /**
   * The name of the user's Key Vault containing the SSL certificate
   */
  vaultName: string;

  /**
   * The name of Key Vault Secret (representing the full certificate PFX) in Key Vault.
   */
  secretName: string;

  /**
   * The version(GUID) of Key Vault Secret in Key Vault.
   */
  secretVersion?: string;

  /**
   * Describes the action that shall be taken when the certificate is updated in Key Vault.
   */
  updateRule: CertificateUpdateAction;

  /**
   * Describes the action that shall be taken when the certificate is removed from Key Vault.
   */
  deleteRule: CertificateDeleteAction;
}
