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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Describes if it is in detection mode or prevention mode at policy level.
 */
union PolicyMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Prevention: "Prevention",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Detection: "Detection",
}

/**
 * Describes if policy managed rules will inspect the request body content.
 */
union PolicyRequestBodyCheck {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * State of the log scrubbing config. Default value is Enabled.
 */
union WebApplicationFirewallScrubbingState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The variable to be scrubbed from the logs.
 */
union ScrubbingRuleEntryMatchVariable {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestIPAddress: "RequestIPAddress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestUri: "RequestUri",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QueryStringArgNames: "QueryStringArgNames",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestHeaderNames: "RequestHeaderNames",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestCookieNames: "RequestCookieNames",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestBodyPostArgNames: "RequestBodyPostArgNames",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestBodyJsonArgNames: "RequestBodyJsonArgNames",
}

/**
 * When matchVariable is a collection, operate on the selector to specify which elements in the collection this rule applies to.
 */
union ScrubbingRuleEntryMatchOperator {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EqualsAny: "EqualsAny",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Equals: "Equals",
}

/**
 * Defines the state of a log scrubbing rule. Default value is enabled.
 */
union ScrubbingRuleEntryState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.
 */
union CustomRuleEnabledState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Describes type of rule.
 */
union RuleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MatchRule: "MatchRule",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RateLimitRule: "RateLimitRule",
}

/**
 * Describes the supported variable for group by
 */
union VariableName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SocketAddr: "SocketAddr",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GeoLocation: "GeoLocation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * Request variable to compare with.
 */
union MatchVariable {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RemoteAddr: "RemoteAddr",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestMethod: "RequestMethod",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QueryString: "QueryString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PostArgs: "PostArgs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestUri: "RequestUri",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestHeader: "RequestHeader",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestBody: "RequestBody",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cookies: "Cookies",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SocketAddr: "SocketAddr",
}

/**
 * Comparison type to use for matching with the variable value.
 */
union Operator {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Any: "Any",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPMatch: "IPMatch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GeoMatch: "GeoMatch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Equal: "Equal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Contains: "Contains",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LessThan: "LessThan",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GreaterThan: "GreaterThan",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LessThanOrEqual: "LessThanOrEqual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GreaterThanOrEqual: "GreaterThanOrEqual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BeginsWith: "BeginsWith",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EndsWith: "EndsWith",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RegEx: "RegEx",
}

/**
 * Describes what transforms applied before matching.
 */
union TransformType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Lowercase: "Lowercase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Uppercase: "Uppercase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Trim: "Trim",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UrlDecode: "UrlDecode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UrlEncode: "UrlEncode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RemoveNulls: "RemoveNulls",
}

/**
 * Defines the action to take when a managed rule set score threshold is met.
 */
union ManagedRuleSetActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Block: "Block",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Log: "Log",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Redirect: "Redirect",
}

/**
 * The variable type to be excluded.
 */
union ManagedRuleExclusionMatchVariable {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestHeaderNames: "RequestHeaderNames",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestCookieNames: "RequestCookieNames",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QueryStringArgNames: "QueryStringArgNames",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestBodyPostArgNames: "RequestBodyPostArgNames",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestBodyJsonArgNames: "RequestBodyJsonArgNames",
}

/**
 * Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to.
 */
union ManagedRuleExclusionSelectorMatchOperator {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Equals: "Equals",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Contains: "Contains",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StartsWith: "StartsWith",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EndsWith: "EndsWith",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EqualsAny: "EqualsAny",
}

/**
 * Describes if the managed rule is in enabled or disabled state.
 */
union ManagedRuleEnabledState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Resource status of the policy.
 */
union PolicyResourceState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabling: "Enabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabling: "Disabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * Name of the pricing tier.
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Classic_AzureFrontDoor: "Classic_AzureFrontDoor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_AzureFrontDoor: "Standard_AzureFrontDoor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium_AzureFrontDoor: "Premium_AzureFrontDoor",
}

/**
 * Indicates whether the name is available.
 */
union Availability {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unavailable: "Unavailable",
}

/**
 * Resource status of the Front Door or Front Door SubResource.
 */
union FrontDoorResourceState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabling: "Enabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabling: "Disabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Migrating: "Migrating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Migrated: "Migrated",
}

/**
 * Which type of manipulation to apply to the header.
 */
union HeaderActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Append: "Append",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Overwrite: "Overwrite",
}

/**
 * Match Variable
 */
union RulesEngineMatchVariable {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IsMobile: "IsMobile",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RemoteAddr: "RemoteAddr",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestMethod: "RequestMethod",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QueryString: "QueryString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PostArgs: "PostArgs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestUri: "RequestUri",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestPath: "RequestPath",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestFilename: "RequestFilename",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestFilenameExtension: "RequestFilenameExtension",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestHeader: "RequestHeader",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestBody: "RequestBody",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestScheme: "RequestScheme",
}

/**
 * Describes operator to apply to the match condition.
 */
union RulesEngineOperator {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Any: "Any",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPMatch: "IPMatch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GeoMatch: "GeoMatch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Equal: "Equal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Contains: "Contains",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LessThan: "LessThan",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GreaterThan: "GreaterThan",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LessThanOrEqual: "LessThanOrEqual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GreaterThanOrEqual: "GreaterThanOrEqual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BeginsWith: "BeginsWith",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EndsWith: "EndsWith",
}

/**
 * Describes what transforms are applied before matching
 */
union Transform {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Lowercase: "Lowercase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Uppercase: "Uppercase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Trim: "Trim",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UrlDecode: "UrlDecode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UrlEncode: "UrlEncode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RemoveNulls: "RemoveNulls",
}

/**
 * If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.
 */
union MatchProcessingBehavior {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Continue: "Continue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stop: "Stop",
}

/**
 * Accepted protocol schemes.
 */
union FrontDoorProtocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Http: "Http",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Https: "Https",
}

/**
 * Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'
 */
union RoutingRuleEnabledState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Configures which HTTP method to use to probe the backends defined under backendPools.
 */
union FrontDoorHealthProbeMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GET: "GET",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HEAD: "HEAD",
}

/**
 * Whether to enable health probes to be made against backends defined under backendPools. Health probes can only be disabled if there is a single enabled backend in single enabled backend pool.
 */
union HealthProbeEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The Approval status for the connection to the Private Link
 */
union PrivateEndpointStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Timeout: "Timeout",
}

/**
 * Whether to enable use of this backend. Permitted values are 'Enabled' or 'Disabled'
 */
union BackendEnabledState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Provisioning status of Custom Https of the frontendEndpoint.
 */
union CustomHttpsProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabling: "Enabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabling: "Disabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.
 */
union CustomHttpsProvisioningSubstate {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SubmittingDomainControlValidationRequest: "SubmittingDomainControlValidationRequest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingDomainControlValidationREquestApproval: "PendingDomainControlValidationREquestApproval",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DomainControlValidationRequestApproved: "DomainControlValidationRequestApproved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DomainControlValidationRequestRejected: "DomainControlValidationRequestRejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DomainControlValidationRequestTimedOut: "DomainControlValidationRequestTimedOut",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IssuingCertificate: "IssuingCertificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeployingCertificate: "DeployingCertificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CertificateDeployed: "CertificateDeployed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeletingCertificate: "DeletingCertificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CertificateDeleted: "CertificateDeleted",
}

/**
 * Defines the source of the SSL certificate
 */
union FrontDoorCertificateSource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureKeyVault: "AzureKeyVault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FrontDoor: "FrontDoor",
}

/**
 * Defines the TLS extension protocol that is used for secure delivery
 */
union FrontDoorTlsProtocolType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServerNameIndication: "ServerNameIndication",
}

/**
 * The minimum TLS version required from the clients to establish an SSL handshake with Front Door.
 */
union MinimumTLSVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `1.0`: "1.0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `1.2`: "1.2",
}

/**
 * Defines the type of the certificate used for secure connections to a frontendEndpoint
 */
union FrontDoorCertificateType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Dedicated: "Dedicated",
}

/**
 * Whether to allow session affinity on this host. Valid options are 'Enabled' or 'Disabled'
 */
union SessionAffinityEnabledState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Whether to enforce certificate name check on HTTPS requests to all backend pools. No effect on non-HTTPS requests.
 */
union EnforceCertificateNameCheckEnabledState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Operational status of the Front Door load balancer. Permitted values are 'Enabled' or 'Disabled'
 */
union FrontDoorEnabledState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Defines the server side resource status
 */
union NetworkExperimentResourceState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabling: "Enabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabling: "Disabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * The state of the Experiment
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The type of endpoint
 */
union EndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AFD: "AFD",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureRegion: "AzureRegion",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CDN: "CDN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ATM: "ATM",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union LatencyScorecardAggregationInterval {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Daily: "Daily",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Weekly: "Weekly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Monthly: "Monthly",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union TimeseriesAggregationInterval {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hourly: "Hourly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Daily: "Daily",
}

/**
 * The type of Timeseries
 */
union TimeseriesType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MeasurementCounts: "MeasurementCounts",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LatencyP50: "LatencyP50",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LatencyP75: "LatencyP75",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LatencyP95: "LatencyP95",
}

/**
 * The aggregation interval of the Timeseries
 */
union AggregationInterval {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hourly: "Hourly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Daily: "Daily",
}

/**
 * Status of the Azure async operation.
 */
union NetworkOperationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Protocol this rule will use when forwarding traffic to backends.
 */
union FrontDoorForwardingProtocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HttpOnly: "HttpOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HttpsOnly: "HttpsOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MatchRequest: "MatchRequest",
}

/**
 * Treatment of URL query terms when forming the cache key.
 */
union FrontDoorQuery {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StripNone: "StripNone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StripAll: "StripAll",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StripOnly: "StripOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StripAllExcept: "StripAllExcept",
}

/**
 * Whether to use dynamic compression for cached content
 */
union DynamicCompressionEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The redirect type the rule will use when redirecting traffic.
 */
union FrontDoorRedirectType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moved: "Moved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Found: "Found",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TemporaryRedirect: "TemporaryRedirect",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PermanentRedirect: "PermanentRedirect",
}

/**
 * The protocol of the destination to where the traffic is redirected
 */
union FrontDoorRedirectProtocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HttpOnly: "HttpOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HttpsOnly: "HttpsOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MatchRequest: "MatchRequest",
}

/**
 * Type of Front Door resource used in CheckNameAvailability.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceType {
  `Microsoft.Network/frontDoors`,
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Resource status of the policy.
   */
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
   * Defines rules that scrub sensitive fields in the Web Application Firewall logs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @maxValue(5)
  rateLimitDurationInMinutes?: int32;

  /**
   * Number of allowed requests per client within the time window.
   */
  rateLimitThreshold?: int32;

  /**
   * Describes the list of variables to group the rate limit requests
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  groupBy?: GroupByVariable[];

  /**
   * List of match conditions.
   */
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
  ruleSetAction?: ManagedRuleSetActionType;

  /**
   * Describes the exclusions that are applied to all rules in the set.
   */
  exclusions?: ManagedRuleExclusion[];

  /**
   * Defines the rule group overrides to apply to the rule set.
   */
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
  exclusions?: ManagedRuleExclusion[];

  /**
   * List of rules that will be disabled. If none specified, all rules in the group will be disabled.
   */
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
   * Describes the exclusions that are applied to this specific rule.
   */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * List of managed rule set definitions available for use in a policy.
 */
model ManagedRuleSetDefinitionList is Azure.Core.Page<ManagedRuleSetDefinition>;

/**
 * Describes the a managed rule set definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ManagedRuleSetDefinition extends Resource {
  /**
   * Properties for a managed rule set definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model FrontDoorProperties extends FrontDoorUpdateParameters {
  /**
   * Resource status of the Front Door.
   */
  @visibility(Lifecycle.Read)
  resourceState?: FrontDoorResourceState;

  /**
   * Provisioning state of the Front Door.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  extendedProperties?: Record<string>;
}

/**
 * The JSON object that contains the properties required to create a Rules Engine Configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RulesEngineProperties extends RulesEngineUpdateParameters {
  /**
   * Resource status.
   */
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
  requestHeaderActions?: HeaderAction[];

  /**
   * A list of header actions to apply from the response from AFD to the client.
   */
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RoutingRule extends SubResource {
  /**
   * Properties of the Front Door Routing Rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RoutingRuleProperties extends RoutingRuleUpdateParameters {
  /**
   * Resource status.
   */
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LoadBalancingSettingsModel extends SubResource {
  /**
   * Properties of the load balancing settings
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LoadBalancingSettingsProperties
  extends LoadBalancingSettingsUpdateParameters {
  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HealthProbeSettingsModel extends SubResource {
  /**
   * Properties of the health probe settings
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HealthProbeSettingsProperties
  extends HealthProbeSettingsUpdateParameters {
  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model BackendPool extends SubResource {
  /**
   * Properties of the Front Door Backend Pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model BackendPoolProperties extends BackendPoolUpdateParameters {
  /**
   * Resource status.
   */
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model FrontendEndpointProperties extends FrontendEndpointUpdateParameters {
  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  keyVaultCertificateSourceParameters?: KeyVaultCertificateSourceParameters;

  /**
   * Parameters required for enabling SSL with Front Door-managed certificates (if certificateSource=FrontDoor)
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ProfileUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PreconfiguredEndpoint extends Resource {
  /**
   * The properties of a preconfiguredEndpoint
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  endpoint?: string;
}

/**
 * Defines modifiable attributes of an Experiment
 */
model ExperimentUpdateModel {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The properties of a Profile
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LatencyScorecard extends Resource {
  /**
   * The properties of a latency scorecard
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: LatencyScorecardProperties;
}

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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTimeUTC?: utcDateTime;

  /**
   * The end time of the Latency Scorecard in UTC
   */
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
  @visibility(Lifecycle.Read)
  aCLower95CI?: float32;

  /**
   * The upper end of the 95% confidence interval for endpoint A
   */
  @visibility(Lifecycle.Read)
  aHUpper95CI?: float32;

  /**
   * The lower end of the 95% confidence interval for endpoint B
   */
  @visibility(Lifecycle.Read)
  bCLower95CI?: float32;

  /**
   * The upper end of the 95% confidence interval for endpoint B
   */
  @visibility(Lifecycle.Read)
  bUpper95CI?: float32;
}

/**
 * Defines the Timeseries
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Timeseries extends Resource {
  /**
   * The properties of a Timeseries
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  startDateTimeUTC?: string;

  /**
   * The end DateTime of the Timeseries in UTC
   */
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
  timeseriesData?: TimeseriesDataPoint[];
}

/**
 * Defines a timeseries datapoint used in a timeseries
 */
model TimeseriesDataPoint {
  /**
   * The DateTime of the Timeseries data point in UTC
   */
  dateTimeUTC?: string;

  /**
   * The Value of the Timeseries data point
   */
  value?: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ErrorDetails {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  code?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  target?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Error {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  code?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  message?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  target?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  details?: ErrorDetails[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  error?: Error;
}

/**
 * Result of the request to list Routing Rules. It contains a list of Routing Rule objects and a URL link to get the next set of results.
 */
model RoutingRuleListResult {
  /**
   * List of Routing Rules within a Front Door.
   */
  @visibility(Lifecycle.Read)
  value?: RoutingRule[];

  /**
   * URL to get the next set of RoutingRule objects if there are any.
   */
  nextLink?: string;
}

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

  `@odata.type`: "#Microsoft.Azure.FrontDoor.Models.FrontdoorRedirectConfiguration";
}

/**
 * Result of the request to list load balancing settings. It contains a list of load balancing settings objects and a URL link to get the next set of results.
 */
model LoadBalancingSettingsListResult {
  /**
   * List of Backend Pools within a Front Door.
   */
  @visibility(Lifecycle.Read)
  value?: LoadBalancingSettingsModel[];

  /**
   * URL to get the next set of LoadBalancingSettings objects if there are any.
   */
  nextLink?: string;
}

/**
 * Result of the request to list HealthProbeSettings. It contains a list of HealthProbeSettings objects and a URL link to get the next set of results.
 */
model HealthProbeSettingsListResult {
  /**
   * List of HealthProbeSettings within a Front Door.
   */
  @visibility(Lifecycle.Read)
  value?: HealthProbeSettingsModel[];

  /**
   * URL to get the next set of HealthProbeSettings objects if there are any.
   */
  nextLink?: string;
}

/**
 * Result of the request to list Backend Pools. It contains a list of Backend Pools objects and a URL link to get the next set of results.
 */
model BackendPoolListResult {
  /**
   * List of Backend Pools within a Front Door.
   */
  @visibility(Lifecycle.Read)
  value?: BackendPool[];

  /**
   * URL to get the next set of BackendPool objects if there are any.
   */
  nextLink?: string;
}
