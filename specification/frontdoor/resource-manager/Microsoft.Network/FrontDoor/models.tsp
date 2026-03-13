import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Network;

/**
 * Describes if the policy is in enabled or disabled state. Defaults to Enabled if not specified.
 */
union PolicyEnabledState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Describes if it is in detection mode or prevention mode at policy level.
 */
union PolicyMode {
  string,

  /**
   * Prevention
   */
  Prevention: "Prevention",

  /**
   * Detection
   */
  Detection: "Detection",
}

/**
 * Describes if policy managed rules will inspect the request body content.
 */
union PolicyRequestBodyCheck {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * State of the log scrubbing config. Default value is Enabled.
 */
union WebApplicationFirewallScrubbingState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The variable to be scrubbed from the logs.
 */
union ScrubbingRuleEntryMatchVariable {
  string,

  /**
   * RequestIPAddress
   */
  RequestIPAddress: "RequestIPAddress",

  /**
   * RequestUri
   */
  RequestUri: "RequestUri",

  /**
   * QueryStringArgNames
   */
  QueryStringArgNames: "QueryStringArgNames",

  /**
   * RequestHeaderNames
   */
  RequestHeaderNames: "RequestHeaderNames",

  /**
   * RequestCookieNames
   */
  RequestCookieNames: "RequestCookieNames",

  /**
   * RequestBodyPostArgNames
   */
  RequestBodyPostArgNames: "RequestBodyPostArgNames",

  /**
   * RequestBodyJsonArgNames
   */
  RequestBodyJsonArgNames: "RequestBodyJsonArgNames",
}

/**
 * When matchVariable is a collection, operate on the selector to specify which elements in the collection this rule applies to.
 */
union ScrubbingRuleEntryMatchOperator {
  string,

  /**
   * EqualsAny
   */
  EqualsAny: "EqualsAny",

  /**
   * Equals
   */
  Equals: "Equals",
}

/**
 * Defines the state of a log scrubbing rule. Default value is enabled.
 */
union ScrubbingRuleEntryState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.
 */
union CustomRuleEnabledState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Describes type of rule.
 */
union RuleType {
  string,

  /**
   * MatchRule
   */
  MatchRule: "MatchRule",

  /**
   * RateLimitRule
   */
  RateLimitRule: "RateLimitRule",
}

/**
 * Describes the supported variable for group by
 */
union VariableName {
  string,

  /**
   * SocketAddr
   */
  SocketAddr: "SocketAddr",

  /**
   * GeoLocation
   */
  GeoLocation: "GeoLocation",

  /**
   * None
   */
  None: "None",
}

/**
 * Request variable to compare with.
 */
union MatchVariable {
  string,

  /**
   * RemoteAddr
   */
  RemoteAddr: "RemoteAddr",

  /**
   * RequestMethod
   */
  RequestMethod: "RequestMethod",

  /**
   * QueryString
   */
  QueryString: "QueryString",

  /**
   * PostArgs
   */
  PostArgs: "PostArgs",

  /**
   * RequestUri
   */
  RequestUri: "RequestUri",

  /**
   * RequestHeader
   */
  RequestHeader: "RequestHeader",

  /**
   * RequestBody
   */
  RequestBody: "RequestBody",

  /**
   * Cookies
   */
  Cookies: "Cookies",

  /**
   * SocketAddr
   */
  SocketAddr: "SocketAddr",
}

/**
 * Comparison type to use for matching with the variable value.
 */
union Operator {
  string,

  /**
   * Any
   */
  Any: "Any",

  /**
   * IPMatch
   */
  IPMatch: "IPMatch",

  /**
   * GeoMatch
   */
  GeoMatch: "GeoMatch",

  /**
   * Equal
   */
  Equal: "Equal",

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * LessThan
   */
  LessThan: "LessThan",

  /**
   * GreaterThan
   */
  GreaterThan: "GreaterThan",

  /**
   * LessThanOrEqual
   */
  LessThanOrEqual: "LessThanOrEqual",

  /**
   * GreaterThanOrEqual
   */
  GreaterThanOrEqual: "GreaterThanOrEqual",

  /**
   * BeginsWith
   */
  BeginsWith: "BeginsWith",

  /**
   * EndsWith
   */
  EndsWith: "EndsWith",

  /**
   * RegEx
   */
  RegEx: "RegEx",

  /**
   * ServiceTagMatch
   */
  ServiceTagMatch: "ServiceTagMatch",
}

/**
 * Describes what transforms applied before matching.
 */
union TransformType {
  string,

  /**
   * Lowercase
   */
  Lowercase: "Lowercase",

  /**
   * Uppercase
   */
  Uppercase: "Uppercase",

  /**
   * Trim
   */
  Trim: "Trim",

  /**
   * UrlDecode
   */
  UrlDecode: "UrlDecode",

  /**
   * UrlEncode
   */
  UrlEncode: "UrlEncode",

  /**
   * RemoveNulls
   */
  RemoveNulls: "RemoveNulls",
}

/**
 * Defines the action to take on rule match.
 */
union ActionType {
  string,

  /**
   * Allow
   */
  Allow: "Allow",

  /**
   * Block
   */
  Block: "Block",

  /**
   * Log
   */
  Log: "Log",

  /**
   * Redirect
   */
  Redirect: "Redirect",

  /**
   * AnomalyScoring
   */
  AnomalyScoring: "AnomalyScoring",

  /**
   * JSChallenge
   */
  JSChallenge: "JSChallenge",

  /**
   * CAPTCHA
   */
  CAPTCHA: "CAPTCHA",
}

/**
 * Defines the action to take when a managed rule set score threshold is met.
 */
union ManagedRuleSetActionType {
  string,

  /**
   * Block
   */
  Block: "Block",

  /**
   * Log
   */
  Log: "Log",

  /**
   * Redirect
   */
  Redirect: "Redirect",
}

/**
 * The variable type to be excluded.
 */
union ManagedRuleExclusionMatchVariable {
  string,

  /**
   * RequestHeaderNames
   */
  RequestHeaderNames: "RequestHeaderNames",

  /**
   * RequestCookieNames
   */
  RequestCookieNames: "RequestCookieNames",

  /**
   * QueryStringArgNames
   */
  QueryStringArgNames: "QueryStringArgNames",

  /**
   * RequestBodyPostArgNames
   */
  RequestBodyPostArgNames: "RequestBodyPostArgNames",

  /**
   * RequestBodyJsonArgNames
   */
  RequestBodyJsonArgNames: "RequestBodyJsonArgNames",
}

/**
 * Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to.
 */
union ManagedRuleExclusionSelectorMatchOperator {
  string,

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * StartsWith
   */
  StartsWith: "StartsWith",

  /**
   * EndsWith
   */
  EndsWith: "EndsWith",

  /**
   * EqualsAny
   */
  EqualsAny: "EqualsAny",
}

/**
 * Describes if the managed rule is in enabled or disabled state.
 */
union ManagedRuleEnabledState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Defines the sensitivity for the rule.
 */
union SensitivityType {
  string,

  /**
   * Low Sensitivity - triggers the rule by larger spikes in traffic
   */
  Low: "Low",

  /**
   * Medium Sensitivity - triggers the rule by moderate spikes in traffic
   */
  Medium: "Medium",

  /**
   * High Sensitivity - triggers the rule by smaller spikes in traffic
   */
  High: "High",
}

/**
 * Resource status of the policy.
 */
union PolicyResourceState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Name of the pricing tier.
 */
union SkuName {
  string,

  /**
   * Classic_AzureFrontDoor
   */
  Classic_AzureFrontDoor: "Classic_AzureFrontDoor",

  /**
   * Standard_AzureFrontDoor
   */
  Standard_AzureFrontDoor: "Standard_AzureFrontDoor",

  /**
   * Premium_AzureFrontDoor
   */
  Premium_AzureFrontDoor: "Premium_AzureFrontDoor",
}

/**
 * Indicates whether the name is available.
 */
union Availability {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * Unavailable
   */
  Unavailable: "Unavailable",
}

/**
 * Resource status of the Front Door or Front Door SubResource.
 */
union FrontDoorResourceState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Migrating
   */
  Migrating: "Migrating",

  /**
   * Migrated
   */
  Migrated: "Migrated",
}

/**
 * Which type of manipulation to apply to the header.
 */
union HeaderActionType {
  string,

  /**
   * Append
   */
  Append: "Append",

  /**
   * Delete
   */
  Delete: "Delete",

  /**
   * Overwrite
   */
  Overwrite: "Overwrite",
}

/**
 * Match Variable
 */
union RulesEngineMatchVariable {
  string,

  /**
   * IsMobile
   */
  IsMobile: "IsMobile",

  /**
   * RemoteAddr
   */
  RemoteAddr: "RemoteAddr",

  /**
   * RequestMethod
   */
  RequestMethod: "RequestMethod",

  /**
   * QueryString
   */
  QueryString: "QueryString",

  /**
   * PostArgs
   */
  PostArgs: "PostArgs",

  /**
   * RequestUri
   */
  RequestUri: "RequestUri",

  /**
   * RequestPath
   */
  RequestPath: "RequestPath",

  /**
   * RequestFilename
   */
  RequestFilename: "RequestFilename",

  /**
   * RequestFilenameExtension
   */
  RequestFilenameExtension: "RequestFilenameExtension",

  /**
   * RequestHeader
   */
  RequestHeader: "RequestHeader",

  /**
   * RequestBody
   */
  RequestBody: "RequestBody",

  /**
   * RequestScheme
   */
  RequestScheme: "RequestScheme",
}

/**
 * Describes operator to apply to the match condition.
 */
union RulesEngineOperator {
  string,

  /**
   * Any
   */
  Any: "Any",

  /**
   * IPMatch
   */
  IPMatch: "IPMatch",

  /**
   * GeoMatch
   */
  GeoMatch: "GeoMatch",

  /**
   * Equal
   */
  Equal: "Equal",

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * LessThan
   */
  LessThan: "LessThan",

  /**
   * GreaterThan
   */
  GreaterThan: "GreaterThan",

  /**
   * LessThanOrEqual
   */
  LessThanOrEqual: "LessThanOrEqual",

  /**
   * GreaterThanOrEqual
   */
  GreaterThanOrEqual: "GreaterThanOrEqual",

  /**
   * BeginsWith
   */
  BeginsWith: "BeginsWith",

  /**
   * EndsWith
   */
  EndsWith: "EndsWith",
}

/**
 * Describes what transforms are applied before matching
 */
union Transform {
  string,

  /**
   * Lowercase
   */
  Lowercase: "Lowercase",

  /**
   * Uppercase
   */
  Uppercase: "Uppercase",

  /**
   * Trim
   */
  Trim: "Trim",

  /**
   * UrlDecode
   */
  UrlDecode: "UrlDecode",

  /**
   * UrlEncode
   */
  UrlEncode: "UrlEncode",

  /**
   * RemoveNulls
   */
  RemoveNulls: "RemoveNulls",
}

/**
 * If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.
 */
union MatchProcessingBehavior {
  string,

  /**
   * Continue
   */
  Continue: "Continue",

  /**
   * Stop
   */
  Stop: "Stop",
}

/**
 * Accepted protocol schemes.
 */
union FrontDoorProtocol {
  string,

  /**
   * Http
   */
  Http: "Http",

  /**
   * Https
   */
  Https: "Https",
}

/**
 * Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'
 */
union RoutingRuleEnabledState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Configures which HTTP method to use to probe the backends defined under backendPools.
 */
union FrontDoorHealthProbeMethod {
  string,

  /**
   * GET
   */
  GET: "GET",

  /**
   * HEAD
   */
  HEAD: "HEAD",
}

/**
 * Whether to enable health probes to be made against backends defined under backendPools. Health probes can only be disabled if there is a single enabled backend in single enabled backend pool.
 */
union HealthProbeEnabled {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The Approval status for the connection to the Private Link
 */
union PrivateEndpointStatus {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Timeout
   */
  Timeout: "Timeout",
}

/**
 * Whether to enable use of this backend. Permitted values are 'Enabled' or 'Disabled'
 */
union BackendEnabledState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Provisioning status of Custom Https of the frontendEndpoint.
 */
union CustomHttpsProvisioningState {
  string,

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.
 */
union CustomHttpsProvisioningSubstate {
  string,

  /**
   * SubmittingDomainControlValidationRequest
   */
  SubmittingDomainControlValidationRequest: "SubmittingDomainControlValidationRequest",

  /**
   * PendingDomainControlValidationREquestApproval
   */
  PendingDomainControlValidationREquestApproval: "PendingDomainControlValidationREquestApproval",

  /**
   * DomainControlValidationRequestApproved
   */
  DomainControlValidationRequestApproved: "DomainControlValidationRequestApproved",

  /**
   * DomainControlValidationRequestRejected
   */
  DomainControlValidationRequestRejected: "DomainControlValidationRequestRejected",

  /**
   * DomainControlValidationRequestTimedOut
   */
  DomainControlValidationRequestTimedOut: "DomainControlValidationRequestTimedOut",

  /**
   * IssuingCertificate
   */
  IssuingCertificate: "IssuingCertificate",

  /**
   * DeployingCertificate
   */
  DeployingCertificate: "DeployingCertificate",

  /**
   * CertificateDeployed
   */
  CertificateDeployed: "CertificateDeployed",

  /**
   * DeletingCertificate
   */
  DeletingCertificate: "DeletingCertificate",

  /**
   * CertificateDeleted
   */
  CertificateDeleted: "CertificateDeleted",
}

/**
 * Defines the source of the SSL certificate
 */
union FrontDoorCertificateSource {
  string,

  /**
   * AzureKeyVault
   */
  AzureKeyVault: "AzureKeyVault",

  /**
   * FrontDoor
   */
  FrontDoor: "FrontDoor",
}

/**
 * Defines the TLS extension protocol that is used for secure delivery
 */
union FrontDoorTlsProtocolType {
  string,

  /**
   * ServerNameIndication
   */
  ServerNameIndication: "ServerNameIndication",
}

/**
 * The minimum TLS version required from the clients to establish an SSL handshake with Front Door.
 */
union MinimumTLSVersion {
  string,

  /**
   * 1.0
   */
  `1.0`: "1.0",

  /**
   * 1.2
   */
  `1.2`: "1.2",
}

/**
 * Defines the type of the certificate used for secure connections to a frontendEndpoint
 */
union FrontDoorCertificateType {
  string,

  /**
   * Dedicated
   */
  Dedicated: "Dedicated",
}

/**
 * Whether to allow session affinity on this host. Valid options are 'Enabled' or 'Disabled'
 */
union SessionAffinityEnabledState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Whether to enforce certificate name check on HTTPS requests to all backend pools. No effect on non-HTTPS requests.
 */
union EnforceCertificateNameCheckEnabledState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Operational status of the Front Door load balancer. Permitted values are 'Enabled' or 'Disabled'
 */
union FrontDoorEnabledState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Defines the server side resource status
 */
union NetworkExperimentResourceState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * The state of the Experiment
 */
union State {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The type of endpoint
 */
union EndpointType {
  string,

  /**
   * AFD
   */
  AFD: "AFD",

  /**
   * AzureRegion
   */
  AzureRegion: "AzureRegion",

  /**
   * CDN
   */
  CDN: "CDN",

  /**
   * ATM
   */
  ATM: "ATM",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union LatencyScorecardAggregationInterval {
  string,

  /**
   * Daily
   */
  Daily: "Daily",

  /**
   * Weekly
   */
  Weekly: "Weekly",

  /**
   * Monthly
   */
  Monthly: "Monthly",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union TimeseriesAggregationInterval {
  string,

  /**
   * Hourly
   */
  Hourly: "Hourly",

  /**
   * Daily
   */
  Daily: "Daily",
}

/**
 * The type of Timeseries
 */
union TimeseriesType {
  string,

  /**
   * MeasurementCounts
   */
  MeasurementCounts: "MeasurementCounts",

  /**
   * LatencyP50
   */
  LatencyP50: "LatencyP50",

  /**
   * LatencyP75
   */
  LatencyP75: "LatencyP75",

  /**
   * LatencyP95
   */
  LatencyP95: "LatencyP95",
}

/**
 * The aggregation interval of the Timeseries
 */
union AggregationInterval {
  string,

  /**
   * Hourly
   */
  Hourly: "Hourly",

  /**
   * Daily
   */
  Daily: "Daily",
}

/**
 * Status of the Azure async operation.
 */
union NetworkOperationStatus {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Protocol this rule will use when forwarding traffic to backends.
 */
union FrontDoorForwardingProtocol {
  string,

  /**
   * HttpOnly
   */
  HttpOnly: "HttpOnly",

  /**
   * HttpsOnly
   */
  HttpsOnly: "HttpsOnly",

  /**
   * MatchRequest
   */
  MatchRequest: "MatchRequest",
}

/**
 * Treatment of URL query terms when forming the cache key.
 */
union FrontDoorQuery {
  string,

  /**
   * StripNone
   */
  StripNone: "StripNone",

  /**
   * StripAll
   */
  StripAll: "StripAll",

  /**
   * StripOnly
   */
  StripOnly: "StripOnly",

  /**
   * StripAllExcept
   */
  StripAllExcept: "StripAllExcept",
}

/**
 * Whether to use dynamic compression for cached content
 */
union DynamicCompressionEnabled {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The redirect type the rule will use when redirecting traffic.
 */
union FrontDoorRedirectType {
  string,

  /**
   * Moved
   */
  Moved: "Moved",

  /**
   * Found
   */
  Found: "Found",

  /**
   * TemporaryRedirect
   */
  TemporaryRedirect: "TemporaryRedirect",

  /**
   * PermanentRedirect
   */
  PermanentRedirect: "PermanentRedirect",
}

/**
 * The protocol of the destination to where the traffic is redirected
 */
union FrontDoorRedirectProtocol {
  string,

  /**
   * HttpOnly
   */
  HttpOnly: "HttpOnly",

  /**
   * HttpsOnly
   */
  HttpsOnly: "HttpsOnly",

  /**
   * MatchRequest
   */
  MatchRequest: "MatchRequest",
}

/**
 * Type of Front Door resource used in CheckNameAvailability.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceType {
  /**
   * Microsoft.Network/frontDoors
   */
  `Microsoft.Network/frontDoors`,

  /**
   * Microsoft.Network/frontDoors/frontendEndpoints
   */
  `Microsoft.Network/frontDoors/frontendEndpoints`,
}

/**
 * Defines a list of WebApplicationFirewallPolicies. It contains a list of WebApplicationFirewallPolicy objects and a URL link to get the next set of results.
 */
model WebApplicationFirewallPolicyList
  is Azure.Core.Page<WebApplicationFirewallPolicy>;

/**
 * Defines web application firewall policy properties.
 */
model WebApplicationFirewallPolicyProperties {
  /**
   * Describes settings for the policy.
   */
  policySettings?: PolicySettings;

  /**
   * Describes custom rules inside the policy.
   */
  customRules?: CustomRuleList;

  /**
   * Describes managed rules inside the policy.
   */
  managedRules?: ManagedRuleSetList;

  /**
   * Describes Frontend Endpoints associated with this Web Application Firewall policy.
   */
  @visibility(Lifecycle.Read)
  frontendEndpointLinks?: FrontendEndpointLink[];

  /**
   * Describes Routing Rules associated with this Web Application Firewall policy.
   */
  @visibility(Lifecycle.Read)
  routingRuleLinks?: RoutingRuleLink[];

  /**
   * Describes Security Policy associated with this Web Application Firewall policy.
   */
  @visibility(Lifecycle.Read)
  securityPolicyLinks?: SecurityPolicyLink[];

  /**
   * Provisioning state of the policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Resource status of the policy.
   */
  @summary("Resource status of the policy.")
  @visibility(Lifecycle.Read)
  resourceState?: PolicyResourceState;
}

/**
 * Defines top-level WebApplicationFirewallPolicy configuration settings.
 */
model PolicySettings {
  /**
   * Describes if the policy is in enabled or disabled state. Defaults to Enabled if not specified.
   */
  enabledState?: PolicyEnabledState;

  /**
   * Describes if it is in detection mode or prevention mode at policy level.
   */
  mode?: PolicyMode;

  /**
   * If action type is redirect, this field represents redirect URL for the client.
   */
  redirectUrl?: string;

  /**
   * If the action type is block, customer can override the response status code.
   */
  customBlockResponseStatusCode?: int32;

  /**
   * If the action type is block, customer can override the response body. The body must be specified in base64 encoding.
   */
  @pattern("^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$")
  customBlockResponseBody?: string;

  /**
   * Describes if policy managed rules will inspect the request body content.
   */
  requestBodyCheck?: PolicyRequestBodyCheck;

  /**
   * Defines the JavaScript challenge cookie validity lifetime in minutes. This setting is only applicable to Premium_AzureFrontDoor. Value must be an integer between 5 and 1440 with the default value being 30.
   */
  @maxValue(1440)
  @minValue(5)
  javascriptChallengeExpirationInMinutes?: int32;

  /**
   * Defines the Captcha cookie validity lifetime in minutes. This setting is only applicable to Premium_AzureFrontDoor. Value must be an integer between 5 and 1440 with the default value being 30.
   */
  @maxValue(1440)
  @minValue(5)
  captchaExpirationInMinutes?: int32;

  /**
   * Defines rules that scrub sensitive fields in the Web Application Firewall logs.
   */
  logScrubbing?: PolicySettingsLogScrubbing;
}

/**
 * Defines rules that scrub sensitive fields in the Web Application Firewall logs.
 */
model PolicySettingsLogScrubbing {
  /**
   * State of the log scrubbing config. Default value is Enabled.
   */
  state?: WebApplicationFirewallScrubbingState;

  /**
   * List of log scrubbing rules applied to the Web Application Firewall logs.
   */
  @identifiers(#[])
  scrubbingRules?: WebApplicationFirewallScrubbingRules[];
}

/**
 * Defines the contents of the log scrubbing rules.
 */
model WebApplicationFirewallScrubbingRules {
  /**
   * The variable to be scrubbed from the logs.
   */
  matchVariable: ScrubbingRuleEntryMatchVariable;

  /**
   * When matchVariable is a collection, operate on the selector to specify which elements in the collection this rule applies to.
   */
  selectorMatchOperator: ScrubbingRuleEntryMatchOperator;

  /**
   * When matchVariable is a collection, operator used to specify which elements in the collection this rule applies to.
   */
  selector?: string;

  /**
   * Defines the state of a log scrubbing rule. Default value is enabled.
   */
  state?: ScrubbingRuleEntryState;
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
 * Defines contents of a web application rule
 */
model CustomRule {
  /**
   * Describes the name of the rule.
   */
  @maxLength(128)
  name?: string;

  /**
   * Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.
   */
  priority: int32;

  /**
   * Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.
   */
  enabledState?: CustomRuleEnabledState;

  /**
   * Describes type of rule.
   */
  ruleType: RuleType;

  /**
   * Time window for resetting the rate limit count. Default is 1 minute.
   */
  @minValue(0)
  @maxValue(5)
  rateLimitDurationInMinutes?: int32;

  /**
   * Number of allowed requests per client within the time window.
   */
  @minValue(0)
  rateLimitThreshold?: int32;

  /**
   * Describes the list of variables to group the rate limit requests
   */
  @identifiers(#[])
  groupBy?: GroupByVariable[];

  /**
   * List of match conditions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  matchConditions: MatchCondition[];

  /**
   * Describes what action to be applied when rule matches.
   */
  action: ActionType;
}

/**
 * Describes the variables available to group the rate limit requests
 */
model GroupByVariable {
  /**
   * Describes the supported variable for group by
   */
  variableName: VariableName;
}

/**
 * Define a match condition.
 */
model MatchCondition {
  /**
   * Request variable to compare with.
   */
  matchVariable: MatchVariable;

  /**
   * Match against a specific key from the QueryString, PostArgs, RequestHeader or Cookies variables. Default is null.
   */
  selector?: string;

  /**
   * Comparison type to use for matching with the variable value.
   */
  operator: Operator;

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
 * Defines the list of managed rule sets for the policy.
 */
model ManagedRuleSetList {
  /**
   * List of rule sets.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  managedRuleSets?: ManagedRuleSet[];
}

/**
 * Defines a managed rule set.
 */
model ManagedRuleSet {
  /**
   * Defines the rule set type to use.
   */
  ruleSetType: string;

  /**
   * Defines the version of the rule set to use.
   */
  ruleSetVersion: string;

  /**
   * Defines the rule set action.
   */
  @summary("ruleSetAction")
  ruleSetAction?: ManagedRuleSetActionType;

  /**
   * Describes the exclusions that are applied to all rules in the set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exclusions?: ManagedRuleExclusion[];

  /**
   * Defines the rule group overrides to apply to the rule set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ruleGroupOverrides?: ManagedRuleGroupOverride[];
}

/**
 * Exclude variables from managed rule evaluation.
 */
model ManagedRuleExclusion {
  /**
   * The variable type to be excluded.
   */
  matchVariable: ManagedRuleExclusionMatchVariable;

  /**
   * Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to.
   */
  selectorMatchOperator: ManagedRuleExclusionSelectorMatchOperator;

  /**
   * Selector value for which elements in the collection this exclusion applies to.
   */
  selector: string;
}

/**
 * Defines a managed rule group override setting.
 */
model ManagedRuleGroupOverride {
  /**
   * Describes the managed rule group to override.
   */
  ruleGroupName: string;

  /**
   * Describes the exclusions that are applied to all rules in the group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exclusions?: ManagedRuleExclusion[];

  /**
   * List of rules that will be disabled. If none specified, all rules in the group will be disabled.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rules?: ManagedRuleOverride[];
}

/**
 * Defines a managed rule group override setting.
 */
model ManagedRuleOverride {
  /**
   * Identifier for the managed rule.
   */
  ruleId: string;

  /**
   * Describes if the managed rule is in enabled or disabled state. Defaults to Disabled if not specified.
   */
  enabledState?: ManagedRuleEnabledState;

  /**
   * Describes the override action to be applied when rule matches.
   */
  action?: ActionType;

  /**
   * Describes the override sensitivity to be applied when rule matches.
   */
  sensitivity?: SensitivityType;

  /**
   * Describes the exclusions that are applied to this specific rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exclusions?: ManagedRuleExclusion[];
}

/**
 * Defines the Resource ID for a Frontend Endpoint.
 */
model FrontendEndpointLink {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Defines the Resource ID for a Routing Rule.
 */
model RoutingRuleLink {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Defines the Resource ID for a Security Policy.
 */
model SecurityPolicyLink {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * The pricing tier of the web application firewall policy.
 */
model Sku {
  /**
   * Name of the pricing tier.
   */
  name?: SkuName;
}

/**
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model BasicResourceWithSettableIDName {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * Resource name.
   */
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model BasicResource {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model Resource {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ResourcewithSettableName {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Error response indicates Front Door service is not able to process the incoming request. The reason is provided in the error message.
 */
@error
model ErrorResponse {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Error response indicates Front Door service is not able to process the incoming request. The reason is provided in the error message.
 */
@error
model DefaultErrorResponse {
  /**
   * Error model.
   */
  error?: DefaultErrorResponseError;
}

/**
 * Error model.
 */
model DefaultErrorResponseError {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * List of managed rule set definitions available for use in a policy.
 */
model ManagedRuleSetDefinitionList is Azure.Core.Page<ManagedRuleSetDefinition>;

/**
 * Describes the a managed rule set definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedRuleSetDefinition extends Resource {
  /**
   * Properties for a managed rule set definition.
   */
  properties?: ManagedRuleSetDefinitionProperties;
}

/**
 * Properties for a managed rule set definition.
 */
model ManagedRuleSetDefinitionProperties {
  /**
   * Provisioning state of the managed rule set.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Id of the managed rule set.
   */
  @visibility(Lifecycle.Read)
  ruleSetId?: string;

  /**
   * Type of the managed rule set.
   */
  @visibility(Lifecycle.Read)
  ruleSetType?: string;

  /**
   * Version of the managed rule set type.
   */
  @visibility(Lifecycle.Read)
  ruleSetVersion?: string;

  /**
   * Rule groups of the managed rule set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ruleGroups?: ManagedRuleGroupDefinition[];
}

/**
 * Describes a managed rule group.
 */
model ManagedRuleGroupDefinition {
  /**
   * Name of the managed rule group.
   */
  @visibility(Lifecycle.Read)
  ruleGroupName?: string;

  /**
   * Description of the managed rule group.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * List of rules within the managed rule group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  rules?: ManagedRuleDefinition[];
}

/**
 * Describes a managed rule definition.
 */
model ManagedRuleDefinition {
  /**
   * Identifier for the managed rule.
   */
  @visibility(Lifecycle.Read)
  ruleId?: string;

  /**
   * Describes the default state for the managed rule.
   */
  @visibility(Lifecycle.Read)
  defaultState?: ManagedRuleEnabledState;

  /**
   * Describes the default action to be applied when the managed rule matches.
   */
  @visibility(Lifecycle.Read)
  defaultAction?: ActionType;

  /**
   * Describes the default sensitivity to be applied when the managed rule matches.
   */
  @visibility(Lifecycle.Read)
  defaultSensitivity?: SensitivityType;

  /**
   * Describes the functionality of the managed rule.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Input of CheckNameAvailability API.
 */
model CheckNameAvailabilityInput {
  /**
   * The resource name to validate.
   */
  name: string;

  /**
   * The type of the resource whose name is to be validated.
   */
  type: ResourceType;
}

/**
 * Output of check name availability API.
 */
model CheckNameAvailabilityOutput {
  /**
   * Indicates whether the name is available.
   */
  @visibility(Lifecycle.Read)
  nameAvailability?: Availability;

  /**
   * The reason why the name is not available.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * The detailed error message describing why the name is not available.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * The JSON object that contains the properties required to create an endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FrontDoorProperties extends FrontDoorUpdateParameters {
  /**
   * Resource status of the Front Door.
   */
  @visibility(Lifecycle.Read)
  @summary("Resource status of the Front Door or Front Door SubResource.")
  resourceState?: FrontDoorResourceState;

  /**
   * Provisioning state of the Front Door.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The host that each frontendEndpoint must CNAME to.
   */
  @visibility(Lifecycle.Read)
  cname?: string;

  /**
   * The Id of the frontdoor.
   */
  @visibility(Lifecycle.Read)
  frontdoorId?: string;

  /**
   * Rules Engine Configurations available to routing rules.
   */
  @visibility(Lifecycle.Read)
  rulesEngines?: RulesEngine[];

  /**
   * Key-Value pair representing additional properties for frontdoor.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  extendedProperties?: Record<string>;
}

/**
 * The JSON object that contains the properties required to create a Rules Engine Configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RulesEngineProperties extends RulesEngineUpdateParameters {
  /**
   * Resource status.
   */
  @summary("Resource status of the Front Door or Front Door SubResource.")
  @visibility(Lifecycle.Read)
  resourceState?: FrontDoorResourceState;
}

/**
 * Rules Engine Configuration to apply to a Routing Rule.
 */
model RulesEngineUpdateParameters {
  /**
   * A list of rules that define a particular Rules Engine Configuration.
   */
  rules?: RulesEngineRule[];
}

/**
 * Contains a list of match conditions, and an action on how to modify the request/response. If multiple rules match, the actions from one rule that conflict with a previous rule overwrite for a singular action, or append in the case of headers manipulation.
 */
model RulesEngineRule {
  /**
   * A name to refer to this specific rule.
   */
  name: string;

  /**
   * A priority assigned to this rule.
   */
  priority: int32;

  /**
   * Actions to perform on the request and response if all of the match conditions are met.
   */
  action: RulesEngineAction;

  /**
   * A list of match conditions that must meet in order for the actions of this rule to run. Having no match conditions means the actions will always run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  matchConditions?: RulesEngineMatchCondition[];

  /**
   * If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.
   */
  matchProcessingBehavior?: MatchProcessingBehavior;
}

/**
 * One or more actions that will execute, modifying the request and/or response.
 */
model RulesEngineAction {
  /**
   * A list of header actions to apply from the request from AFD to the origin.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestHeaderActions?: HeaderAction[];

  /**
   * A list of header actions to apply from the response from AFD to the client.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  responseHeaderActions?: HeaderAction[];

  /**
   * Override the route configuration.
   */
  routeConfigurationOverride?: RouteConfiguration;
}

/**
 * An action that can manipulate an http header.
 */
model HeaderAction {
  /**
   * Which type of manipulation to apply to the header.
   */
  headerActionType: HeaderActionType;

  /**
   * The name of the header this action will apply to.
   */
  headerName: string;

  /**
   * The value to update the given header name with. This value is not used if the actionType is Delete.
   */
  value?: string;
}

/**
 * Base class for all types of Route.
 */
@discriminator("@odata.type")
model RouteConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.type`: string;
}

/**
 * Define a match condition
 */
model RulesEngineMatchCondition {
  /**
   * Match Variable
   */
  rulesEngineMatchVariable: RulesEngineMatchVariable;

  /**
   * Name of selector in RequestHeader or RequestBody to be matched
   */
  selector?: string;

  /**
   * Describes operator to apply to the match condition.
   */
  rulesEngineOperator: RulesEngineOperator;

  /**
   * Describes if this is negate condition or not
   */
  negateCondition?: boolean;

  /**
   * Match values to match against. The operator will apply to each value in here with OR semantics. If any of them match the variable with the given operator this match condition is considered a match.
   */
  rulesEngineMatchValue: string[];

  /**
   * List of transforms
   */
  transforms?: Transform[];
}

/**
 * The properties needed to update a Front Door
 */
model FrontDoorUpdateParameters {
  /**
   * A friendly name for the frontDoor
   */
  friendlyName?: string;

  /**
   * Routing rules associated with this Front Door.
   */
  routingRules?: RoutingRule[];

  /**
   * Load balancing settings associated with this Front Door instance.
   */
  loadBalancingSettings?: LoadBalancingSettingsModel[];

  /**
   * Health probe settings associated with this Front Door instance.
   */
  healthProbeSettings?: HealthProbeSettingsModel[];

  /**
   * Backend pools available to routing rules.
   */
  backendPools?: BackendPool[];

  /**
   * Frontend endpoints available to routing rules.
   */
  frontendEndpoints?: FrontendEndpoint[];

  /**
   * Settings for all backendPools
   */
  backendPoolsSettings?: BackendPoolsSettings;

  /**
   * Operational status of the Front Door load balancer. Permitted values are 'Enabled' or 'Disabled'
   */
  enabledState?: FrontDoorEnabledState;
}

/**
 * A routing rule represents a specification for traffic to treat and where to send it, along with health probe information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoutingRule extends SubResource {
  /**
   * Properties of the Front Door Routing Rule
   */
  properties?: RoutingRuleProperties;

  /**
   * Resource name.
   */
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The JSON object that contains the properties required to create a routing rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoutingRuleProperties extends RoutingRuleUpdateParameters {
  /**
   * Resource status.
   */
  @summary("Resource status of the Front Door or Front Door SubResource.")
  @visibility(Lifecycle.Read)
  resourceState?: FrontDoorResourceState;
}

/**
 * Routing rules to apply to an endpoint
 */
model RoutingRuleUpdateParameters {
  /**
   * Frontend endpoints associated with this rule
   */
  frontendEndpoints?: SubResource[];

  /**
   * Protocol schemes to match for this rule
   */
  acceptedProtocols?: FrontDoorProtocol[];

  /**
   * The route patterns of the rule.
   */
  patternsToMatch?: string[];

  /**
   * Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'
   */
  enabledState?: RoutingRuleEnabledState;

  /**
   * A reference to the routing configuration.
   */
  routeConfiguration?: RouteConfiguration;

  /**
   * A reference to a specific Rules Engine Configuration to apply to this route.
   */
  rulesEngine?: SubResource;

  /**
   * Defines the Web Application Firewall policy for each routing rule (if applicable)
   */
  webApplicationFirewallPolicyLink?: RoutingRuleUpdateParametersWebApplicationFirewallPolicyLink;
}

/**
 * Reference to another subresource.
 */
model SubResource {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Defines the Web Application Firewall policy for each routing rule (if applicable)
 */
model RoutingRuleUpdateParametersWebApplicationFirewallPolicyLink {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Load balancing settings for a backend pool
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LoadBalancingSettingsModel extends SubResource {
  /**
   * Properties of the load balancing settings
   */
  properties?: LoadBalancingSettingsProperties;

  /**
   * Resource name.
   */
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The JSON object that contains the properties required to create load balancing settings
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LoadBalancingSettingsProperties
  extends LoadBalancingSettingsUpdateParameters {
  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
  @summary("Resource status of the Front Door or Front Door SubResource.")
  resourceState?: FrontDoorResourceState;
}

/**
 * Round-Robin load balancing settings for a backend pool
 */
model LoadBalancingSettingsUpdateParameters {
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
  additionalLatencyMilliseconds?: int32;
}

/**
 * Load balancing settings for a backend pool
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HealthProbeSettingsModel extends SubResource {
  /**
   * Properties of the health probe settings
   */
  properties?: HealthProbeSettingsProperties;

  /**
   * Resource name.
   */
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The JSON object that contains the properties required to create a health probe settings.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HealthProbeSettingsProperties
  extends HealthProbeSettingsUpdateParameters {
  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
  @summary("Resource status of the Front Door or Front Door SubResource.")
  resourceState?: FrontDoorResourceState;
}

/**
 * L7 health probe settings for a backend pool
 */
model HealthProbeSettingsUpdateParameters {
  /**
   * The path to use for the health probe. Default is /
   */
  path?: string;

  /**
   * Protocol scheme to use for this probe
   */
  protocol?: FrontDoorProtocol;

  /**
   * The number of seconds between health probes.
   */
  intervalInSeconds?: int32;

  /**
   * Configures which HTTP method to use to probe the backends defined under backendPools.
   */
  healthProbeMethod?: FrontDoorHealthProbeMethod = FrontDoorHealthProbeMethod.HEAD;

  /**
   * Whether to enable health probes to be made against backends defined under backendPools. Health probes can only be disabled if there is a single enabled backend in single enabled backend pool.
   */
  enabledState?: HealthProbeEnabled;
}

/**
 * A backend pool is a collection of backends that can be routed to.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackendPool extends SubResource {
  /**
   * Properties of the Front Door Backend Pool
   */
  properties?: BackendPoolProperties;

  /**
   * Resource name.
   */
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The JSON object that contains the properties required to create a Backend Pool.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackendPoolProperties extends BackendPoolUpdateParameters {
  /**
   * Resource status.
   */
  @summary("Resource status of the Front Door or Front Door SubResource.")
  @visibility(Lifecycle.Read)
  resourceState?: FrontDoorResourceState;
}

/**
 * A collection of backends that can be routed to.
 */
model BackendPoolUpdateParameters {
  /**
   * The set of backends for this pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backends?: Backend[];

  /**
   * Load balancing settings for a backend pool
   */
  loadBalancingSettings?: SubResource;

  /**
   * L7 health probe settings for a backend pool
   */
  healthProbeSettings?: SubResource;
}

/**
 * Backend address of a frontDoor load balancer.
 */
model Backend {
  /**
   * Location of the backend (IP address or FQDN)
   */
  address?: string;

  /**
   * The Alias of the Private Link resource. Populating this optional field indicates that this backend is 'Private'
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
   * The Approval status for the connection to the Private Link
   */
  @visibility(Lifecycle.Read)
  privateEndpointStatus?: PrivateEndpointStatus;

  /**
   * A custom message to be included in the approval request to connect to the Private Link
   */
  privateLinkApprovalMessage?: string;

  /**
   * The HTTP TCP port number. Must be between 1 and 65535.
   */
  @maxValue(65535)
  @minValue(1)
  httpPort?: int32;

  /**
   * The HTTPS TCP port number. Must be between 1 and 65535.
   */
  @maxValue(65535)
  @minValue(1)
  httpsPort?: int32;

  /**
   * Whether to enable use of this backend. Permitted values are 'Enabled' or 'Disabled'
   */
  enabledState?: BackendEnabledState;

  /**
   * Priority to use for load balancing. Higher priorities will not be used for load balancing if any lower priority backend is healthy.
   */
  @maxValue(5)
  @minValue(1)
  priority?: int32;

  /**
   * Weight of this endpoint for load balancing purposes.
   */
  @maxValue(1000)
  @minValue(1)
  weight?: int32;

  /**
   * The value to use as the host header sent to the backend. If blank or unspecified, this defaults to the incoming host.
   */
  backendHostHeader?: string;
}

/**
 * The JSON object that contains the properties required to create a frontend endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FrontendEndpointProperties extends FrontendEndpointUpdateParameters {
  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
  @summary("Resource status of the Front Door or Front Door SubResource.")
  resourceState?: FrontDoorResourceState;

  /**
   * Provisioning status of Custom Https of the frontendEndpoint.
   */
  @visibility(Lifecycle.Read)
  customHttpsProvisioningState?: CustomHttpsProvisioningState;

  /**
   * Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.
   */
  @visibility(Lifecycle.Read)
  customHttpsProvisioningSubstate?: CustomHttpsProvisioningSubstate;

  /**
   * The configuration specifying how to enable HTTPS
   */
  @visibility(Lifecycle.Read)
  customHttpsConfiguration?: CustomHttpsConfiguration;
}

/**
 * Https settings for a domain
 */
model CustomHttpsConfiguration {
  /**
   * Defines the source of the SSL certificate
   */
  certificateSource: FrontDoorCertificateSource;

  /**
   * Defines the TLS extension protocol that is used for secure delivery
   */
  protocolType: FrontDoorTlsProtocolType;

  /**
   * The minimum TLS version required from the clients to establish an SSL handshake with Front Door.
   */
  minimumTlsVersion: MinimumTLSVersion;

  /**
   * KeyVault certificate source parameters (if certificateSource=AzureKeyVault)
   */
  keyVaultCertificateSourceParameters?: KeyVaultCertificateSourceParameters;

  /**
   * Parameters required for enabling SSL with Front Door-managed certificates (if certificateSource=FrontDoor)
   */
  frontDoorCertificateSourceParameters?: FrontDoorCertificateSourceParameters;
}

/**
 * Parameters required for bring-your-own-certification via Key Vault
 */
model KeyVaultCertificateSourceParameters {
  /**
   * The Key Vault containing the SSL certificate
   */
  vault?: KeyVaultCertificateSourceParametersVault;

  /**
   * The name of the Key Vault secret representing the full certificate PFX
   */
  secretName?: string;

  /**
   * The version of the Key Vault secret representing the full certificate PFX
   */
  secretVersion?: string;
}

/**
 * The Key Vault containing the SSL certificate
 */
model KeyVaultCertificateSourceParametersVault {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Parameters required for enabling SSL with Front Door-managed certificates
 */
model FrontDoorCertificateSourceParameters {
  /**
   * Defines the type of the certificate used for secure connections to a frontendEndpoint
   */
  certificateType?: FrontDoorCertificateType;
}

/**
 * Frontend endpoint used in routing rule
 */
model FrontendEndpointUpdateParameters {
  /**
   * The host name of the frontendEndpoint. Must be a domain name.
   */
  hostName?: string;

  /**
   * Whether to allow session affinity on this host. Valid options are 'Enabled' or 'Disabled'
   */
  sessionAffinityEnabledState?: SessionAffinityEnabledState;

  /**
   * UNUSED. This field will be ignored. The TTL to use in seconds for session affinity, if applicable.
   */
  sessionAffinityTtlSeconds?: int32;

  /**
   * Defines the Web Application Firewall policy for each host (if applicable)
   */
  webApplicationFirewallPolicyLink?: FrontendEndpointUpdateParametersWebApplicationFirewallPolicyLink;
}

/**
 * Defines the Web Application Firewall policy for each host (if applicable)
 */
model FrontendEndpointUpdateParametersWebApplicationFirewallPolicyLink {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Settings that apply to all backend pools.
 */
model BackendPoolsSettings {
  /**
   * Whether to enforce certificate name check on HTTPS requests to all backend pools. No effect on non-HTTPS requests.
   */
  enforceCertificateNameCheck?: EnforceCertificateNameCheckEnabledState = EnforceCertificateNameCheckEnabledState.Enabled;

  /**
   * Send and receive timeout on forwarding request to the backend. When timeout is reached, the request fails and returns.
   */
  @minValue(16)
  sendRecvTimeoutSeconds?: int32;
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
 * Input of the custom domain to be validated for DNS mapping.
 */
model ValidateCustomDomainInput {
  /**
   * The host name of the custom domain. Must be a domain name.
   */
  hostName: string;
}

/**
 * Output of custom domain validation.
 */
model ValidateCustomDomainOutput {
  /**
   * Indicates whether the custom domain is valid or not.
   */
  @visibility(Lifecycle.Read)
  customDomainValidated?: boolean;

  /**
   * The reason why the custom domain is not valid.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * Error message describing why the custom domain is not valid.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Defines a list of Profiles. It contains a list of Profile objects and a URL link to get the next set of results.
 */
model ProfileList is Azure.Core.Page<Profile>;

/**
 * Defines the properties of an experiment
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProfileProperties {
  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
  resourceState?: NetworkExperimentResourceState;

  /**
   * The state of the Experiment
   */
  enabledState?: State;
}

/**
 * Defines modifiable attributes of a Profile
 */
model ProfileUpdateModel {
  /**
   * The properties of a Profile
   */
  properties?: ProfileUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Defines the properties of an experiment
 */
model ProfileUpdateProperties {
  /**
   * The enabled state of the Profile
   */
  enabledState?: State;
}

/**
 * Defines a list of preconfigured endpoints.
 */
model PreconfiguredEndpointList is Azure.Core.Page<PreconfiguredEndpoint>;

/**
 * Defines the properties of a preconfigured endpoint
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PreconfiguredEndpoint extends ResourcewithSettableName {
  /**
   * The properties of a preconfiguredEndpoint
   */
  properties?: PreconfiguredEndpointProperties;
}

/**
 * Defines the properties of a preconfigured endpoint
 */
model PreconfiguredEndpointProperties {
  /**
   * The description of the endpoint
   */
  description?: string;

  /**
   * The endpoint that is preconfigured
   */
  endpoint?: string;

  /**
   * The type of endpoint
   */
  endpointType?: EndpointType;

  /**
   * The preconfigured endpoint backend
   */
  backend?: string;
}

/**
 * Defines a list of Experiments. It contains a list of Experiment objects and a URL link to get the next set of results.
 */
model ExperimentList is Azure.Core.Page<Experiment>;

/**
 * Defines the properties of an experiment
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExperimentProperties {
  /**
   * The description of the details or intents of the Experiment
   */
  description?: string;

  /**
   * The endpoint A of an experiment
   */
  endpointA?: Endpoint;

  /**
   * The endpoint B of an experiment
   */
  endpointB?: Endpoint;

  /**
   * The state of the Experiment
   */
  enabledState?: State;

  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
  resourceState?: NetworkExperimentResourceState;

  /**
   * The description of Experiment status from the server side
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The uri to the Script used in the Experiment
   */
  @visibility(Lifecycle.Read)
  scriptFileUri?: string;
}

/**
 * Defines the endpoint properties
 */
model Endpoint {
  /**
   * The name of the endpoint
   */
  name?: string;

  /**
   * The endpoint URL
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoint?: string;
}

/**
 * Defines modifiable attributes of an Experiment
 */
model ExperimentUpdateModel {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The properties of a Profile
   */
  properties?: ExperimentUpdateProperties;
}

/**
 * Defines the properties of an experiment
 */
model ExperimentUpdateProperties {
  /**
   * The description of the intent or details of the Experiment
   */
  description?: string;

  /**
   * The state of the Experiment
   */
  enabledState?: State;
}

/**
 * Defines the LatencyScorecard
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LatencyScorecard extends Resource {
  /**
   * The properties of a latency scorecard
   */
  properties?: LatencyScorecardProperties;
}

/**
 * Defines a the properties of a Timeseries query parameters
 */
alias GetTimeseriesParameters = {
  /**
   * The start DateTime of the Timeseries in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("startDateTimeUTC")
  startDateTimeUTC: utcDateTime;

  /**
   * The end DateTime of the Timeseries in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("endDateTimeUTC")
  endDateTimeUTC: utcDateTime;

  /**
   * The aggregation interval of the Timeseries
   */
  @query("aggregationInterval")
  aggregationInterval: TimeseriesAggregationInterval;

  /**
   * The type of Timeseries
   */
  @query("timeseriesType")
  timeseriesType: TimeseriesType;

  /**
   * The specific endpoint
   */
  @query("endpoint")
  endpoint?: string;

  /**
   * The country associated with the Timeseries. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html
   */
  @query("country")
  country?: string;
};

/**
 * Defines a the properties of a Latency Scorecard query parameters
 */
alias GetLatencyScorecardsParameters = {
  /**
   * The end DateTime of the Latency Scorecard in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("endDateTimeUTC")
  endDateTimeUTC?: string;

  /**
   * The country associated with the Latency Scorecard. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html
   */
  @query("country")
  country?: string;

  /**
   * The aggregation interval of the Latency Scorecard
   */
  @query("aggregationInterval")
  aggregationInterval: LatencyScorecardAggregationInterval;
};

/**
 * Defines a the properties of a Latency Scorecard
 */
model LatencyScorecardProperties {
  /**
   * The unique identifier of the Latency Scorecard
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the Latency Scorecard
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The description of the Latency Scorecard
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The A endpoint in the scorecard
   */
  @visibility(Lifecycle.Read)
  endpointA?: string;

  /**
   * The B endpoint in the scorecard
   */
  @visibility(Lifecycle.Read)
  endpointB?: string;

  /**
   * The start time of the Latency Scorecard in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTimeUTC?: utcDateTime;

  /**
   * The end time of the Latency Scorecard in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTimeUTC?: utcDateTime;

  /**
   * The country associated with the Latency Scorecard. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html
   */
  @visibility(Lifecycle.Read)
  country?: string;

  /**
   * The latency metrics of the Latency Scorecard
   */
  latencyMetrics?: LatencyMetric[];
}

/**
 * Defines the properties of a latency metric used in the latency scorecard
 */
model LatencyMetric {
  /**
   * The name of the Latency Metric
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The end time of the Latency Scorecard in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  endDateTimeUTC?: string;

  /**
   * The metric value of the A endpoint
   */
  @visibility(Lifecycle.Read)
  aValue?: float32;

  /**
   * The metric value of the B endpoint
   */
  @visibility(Lifecycle.Read)
  bValue?: float32;

  /**
   * The difference in value between endpoint A and B
   */
  @visibility(Lifecycle.Read)
  delta?: float32;

  /**
   * The percent difference between endpoint A and B
   */
  @visibility(Lifecycle.Read)
  deltaPercent?: float32;

  /**
   * The lower end of the 95% confidence interval for endpoint A
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  aCLower95CI?: float32;

  /**
   * The upper end of the 95% confidence interval for endpoint A
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  aHUpper95CI?: float32;

  /**
   * The lower end of the 95% confidence interval for endpoint B
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  bCLower95CI?: float32;

  /**
   * The upper end of the 95% confidence interval for endpoint B
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  bUpper95CI?: float32;
}

/**
 * Defines the Timeseries
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Timeseries extends Resource {
  /**
   * The properties of a Timeseries
   */
  properties?: TimeseriesProperties;
}

/**
 * Defines the properties of a timeseries
 */
model TimeseriesProperties {
  /**
   * The endpoint associated with the Timeseries data point
   */
  endpoint?: string;

  /**
   * The start DateTime of the Timeseries in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startDateTimeUTC?: string;

  /**
   * The end DateTime of the Timeseries in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endDateTimeUTC?: string;

  /**
   * The aggregation interval of the Timeseries
   */
  aggregationInterval?: AggregationInterval;

  /**
   * The type of Timeseries
   */
  timeseriesType?: TimeseriesType;

  /**
   * The country associated with the Timeseries. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html
   */
  country?: string;

  /**
   * The set of data points for the timeseries
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeseriesData?: TimeseriesDataPoint[];
}

/**
 * Defines a timeseries datapoint used in a timeseries
 */
model TimeseriesDataPoint {
  /**
   * The DateTime of the Timeseries data point in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dateTimeUTC?: string;

  /**
   * The Value of the Timeseries data point
   */
  value?: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorDetails {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  code?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  target?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Error {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  code?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  message?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  target?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: ErrorDetails[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  innerError?: string;
}

/**
 * The response body contains the status of the specified asynchronous operation, indicating whether it has succeeded, is in progress, or has failed. Note that this status is distinct from the HTTP status code returned for the Get Operation Status operation itself. If the asynchronous operation succeeded, the response body includes the HTTP status code for the successful request. If the asynchronous operation failed, the response body includes the HTTP status code for the failed request and error information regarding the failure.
 */
model AzureAsyncOperationResult {
  /**
   * Status of the Azure async operation.
   */
  status?: NetworkOperationStatus;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  error?: Error;
}

/**
 * Result of the request to list Routing Rules. It contains a list of Routing Rule objects and a URL link to get the next set of results.
 */
model RoutingRuleListResult is Azure.Core.Page<RoutingRule>;

/**
 * Describes Forwarding Route.
 */
model ForwardingConfiguration extends RouteConfiguration {
  /**
   * A custom path used to rewrite resource paths matched by this rule. Leave empty to use incoming path.
   */
  customForwardingPath?: string;

  /**
   * Protocol this rule will use when forwarding traffic to backends.
   */
  forwardingProtocol?: FrontDoorForwardingProtocol;

  /**
   * The caching configuration associated with this rule.
   */
  cacheConfiguration?: CacheConfiguration;

  /**
   * A reference to the BackendPool which this rule routes to.
   */
  backendPool?: SubResource;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.type`: "#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration";
}

/**
 * Caching settings for a caching-type route. To disable caching, do not provide a cacheConfiguration object.
 */
model CacheConfiguration {
  /**
   * Treatment of URL query terms when forming the cache key.
   */
  queryParameterStripDirective?: FrontDoorQuery;

  /**
   * query parameters to include or exclude (comma separated).
   */
  queryParameters?: string;

  /**
   * Whether to use dynamic compression for cached content
   */
  dynamicCompression?: DynamicCompressionEnabled;

  /**
   * The duration for which the content needs to be cached. Allowed format is in ISO 8601 format (http://en.wikipedia.org/wiki/ISO_8601#Durations). HTTP requires the value to be no more than a year
   */
  cacheDuration?: duration;
}

/**
 * Describes Redirect Route.
 */
model RedirectConfiguration extends RouteConfiguration {
  /**
   * The redirect type the rule will use when redirecting traffic.
   */
  redirectType?: FrontDoorRedirectType;

  /**
   * The protocol of the destination to where the traffic is redirected
   */
  redirectProtocol?: FrontDoorRedirectProtocol;

  /**
   * Host to redirect. Leave empty to use the incoming host as the destination host.
   */
  customHost?: string;

  /**
   * The full path to redirect. Path cannot be empty and must start with /. Leave empty to use the incoming path as destination path.
   */
  customPath?: string;

  /**
   * Fragment to add to the redirect URL. Fragment is the part of the URL that comes after #. Do not include the #.
   */
  customFragment?: string;

  /**
   * The set of query strings to be placed in the redirect URL. Setting this value would replace any existing query string; leave empty to preserve the incoming query string. Query string must be in <key>=<value> format. The first ? and & will be added automatically so do not include them in the front, but do separate multiple query strings with &.
   */
  customQueryString?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `@odata.type`: "#Microsoft.Azure.FrontDoor.Models.FrontdoorRedirectConfiguration";
}

/**
 * Result of the request to list load balancing settings. It contains a list of load balancing settings objects and a URL link to get the next set of results.
 */
model LoadBalancingSettingsListResult
  is Azure.Core.Page<LoadBalancingSettingsModel>;

/**
 * Result of the request to list HealthProbeSettings. It contains a list of HealthProbeSettings objects and a URL link to get the next set of results.
 */
model HealthProbeSettingsListResult
  is Azure.Core.Page<HealthProbeSettingsModel>;

/**
 * Result of the request to list Backend Pools. It contains a list of Backend Pools objects and a URL link to get the next set of results.
 */
model BackendPoolListResult is Azure.Core.Page<BackendPool>;

model FrontendEndpointsListResult is Azure.Core.Page<FrontendEndpoint>;

model FrontDoorListResult is Azure.Core.Page<FrontDoor>;
model RulesEngineListResult is Azure.Core.Page<RulesEngine>;

@@visibility(ExperimentList.value, Lifecycle.Read);
@@visibility(FrontDoorListResult.value, Lifecycle.Read);
@@visibility(FrontendEndpointsListResult.value, Lifecycle.Read);
@@visibility(ManagedRuleSetDefinitionList.value, Lifecycle.Read);
@@visibility(PreconfiguredEndpointList.value, Lifecycle.Read);
@@visibility(ProfileList.value, Lifecycle.Read);
@@visibility(RulesEngineListResult.value, Lifecycle.Read);
@@visibility(WebApplicationFirewallPolicyList.value, Lifecycle.Read);
@@Azure.ClientGenerator.Core.clientName(ScrubbingRuleEntryMatchOperator,
  "scrubbingRuleEntryMatchOperator"
);
@@Azure.ClientGenerator.Core.clientName(ScrubbingRuleEntryState,
  "scrubbingRuleEntryState"
);
