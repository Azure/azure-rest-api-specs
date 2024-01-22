import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Network;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Describes if the policy is in enabled or disabled state. Defaults to Enabled if not specified.
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
 * Describes if policy managed rules will inspect the request body content.
 */
enum PolicyRequestBodyCheck {
  Disabled,
  Enabled,
}

/**
 * Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.
 */
enum CustomRuleEnabledState {
  Disabled,
  Enabled,
}

/**
 * Describes type of rule.
 */
enum RuleType {
  MatchRule,
  RateLimitRule,
}

/**
 * Request variable to compare with.
 */
enum MatchVariable {
  RemoteAddr,
  RequestMethod,
  QueryString,
  PostArgs,
  RequestUri,
  RequestHeader,
  RequestBody,
  Cookies,
  SocketAddr,
}

/**
 * Comparison type to use for matching with the variable value.
 */
enum Operator {
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
 * Describes what transforms applied before matching.
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
 * Defines the action to take when a managed rule set score threshold is met.
 */
enum ManagedRuleSetActionType {
  Block,
  Log,
  Redirect,
}

/**
 * The variable type to be excluded.
 */
enum ManagedRuleExclusionMatchVariable {
  RequestHeaderNames,
  RequestCookieNames,
  QueryStringArgNames,
  RequestBodyPostArgNames,
  RequestBodyJsonArgNames,
}

/**
 * Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to.
 */
enum ManagedRuleExclusionSelectorMatchOperator {
  Equals,
  Contains,
  StartsWith,
  EndsWith,
  EqualsAny,
}

/**
 * Describes if the managed rule is in enabled or disabled state.
 */
enum ManagedRuleEnabledState {
  Disabled,
  Enabled,
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
 * Name of the pricing tier.
 */
enum SkuName {
  Classic_AzureFrontDoor,
  Standard_AzureFrontDoor,
  Premium_AzureFrontDoor,
}

/**
 * Indicates whether the name is available.
 */
enum Availability {
  Available,
  Unavailable,
}

/**
 * Resource status of the Front Door or Front Door SubResource.
 */
enum FrontDoorResourceState {
  Creating,
  Enabling,
  Enabled,
  Disabling,
  Disabled,
  Deleting,
  Migrating,
  Migrated,
}

/**
 * Which type of manipulation to apply to the header.
 */
enum HeaderActionType {
  Append,
  Delete,
  Overwrite,
}

/**
 * Match Variable
 */
enum RulesEngineMatchVariable {
  IsMobile,
  RemoteAddr,
  RequestMethod,
  QueryString,
  PostArgs,
  RequestUri,
  RequestPath,
  RequestFilename,
  RequestFilenameExtension,
  RequestHeader,
  RequestBody,
  RequestScheme,
}

/**
 * Describes operator to apply to the match condition.
 */
enum RulesEngineOperator {
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
}

/**
 * Describes what transforms are applied before matching
 */
enum Transform {
  Lowercase,
  Uppercase,
  Trim,
  UrlDecode,
  UrlEncode,
  RemoveNulls,
}

/**
 * If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.
 */
enum MatchProcessingBehavior {
  Continue,
  Stop,
}

/**
 * Accepted protocol schemes.
 */
enum FrontDoorProtocol {
  Http,
  Https,
}

/**
 * Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'
 */
enum RoutingRuleEnabledState {
  Enabled,
  Disabled,
}

/**
 * Configures which HTTP method to use to probe the backends defined under backendPools.
 */
enum FrontDoorHealthProbeMethod {
  GET,
  HEAD,
}

/**
 * Whether to enable health probes to be made against backends defined under backendPools. Health probes can only be disabled if there is a single enabled backend in single enabled backend pool.
 */
enum HealthProbeEnabled {
  Enabled,
  Disabled,
}

/**
 * The Approval status for the connection to the Private Link
 */
enum PrivateEndpointStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

/**
 * Whether to enable use of this backend. Permitted values are 'Enabled' or 'Disabled'
 */
enum BackendEnabledState {
  Enabled,
  Disabled,
}

/**
 * Provisioning status of Custom Https of the frontendEndpoint.
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
enum CustomHttpsProvisioningSubstate {
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
 * Defines the source of the SSL certificate
 */
enum FrontDoorCertificateSource {
  AzureKeyVault,
  FrontDoor,
}

/**
 * Defines the TLS extension protocol that is used for secure delivery
 */
enum FrontDoorTlsProtocolType {
  ServerNameIndication,
}

/**
 * The minimum TLS version required from the clients to establish an SSL handshake with Front Door.
 */
enum MinimumTLSVersion {
  `1.0`,
  `1.2`,
}

/**
 * Defines the type of the certificate used for secure connections to a frontendEndpoint
 */
enum FrontDoorCertificateType {
  Dedicated,
}

/**
 * Whether to allow session affinity on this host. Valid options are 'Enabled' or 'Disabled'
 */
enum SessionAffinityEnabledState {
  Enabled,
  Disabled,
}

/**
 * Whether to enforce certificate name check on HTTPS requests to all backend pools. No effect on non-HTTPS requests.
 */
enum EnforceCertificateNameCheckEnabledState {
  Enabled,
  Disabled,
}

/**
 * Operational status of the Front Door load balancer. Permitted values are 'Enabled' or 'Disabled'
 */
enum FrontDoorEnabledState {
  Enabled,
  Disabled,
}

/**
 * Defines the server side resource status
 */
enum NetworkExperimentResourceState {
  Creating,
  Enabling,
  Enabled,
  Disabling,
  Disabled,
  Deleting,
}

/**
 * The state of the Experiment
 */
enum State {
  Enabled,
  Disabled,
}

/**
 * The type of endpoint
 */
enum EndpointType {
  AFD,
  AzureRegion,
  CDN,
  ATM,
}

enum LatencyScorecardAggregationInterval {
  Daily,
  Weekly,
  Monthly,
}

enum TimeseriesAggregationInterval {
  Hourly,
  Daily,
}

/**
 * The type of Timeseries
 */
enum TimeseriesType {
  MeasurementCounts,
  LatencyP50,
  LatencyP75,
  LatencyP95,
}

/**
 * The aggregation interval of the Timeseries
 */
enum AggregationInterval {
  Hourly,
  Daily,
}

/**
 * Status of the Azure async operation.
 */
enum NetworkOperationStatus {
  InProgress,
  Succeeded,
  Failed,
}

/**
 * Protocol this rule will use when forwarding traffic to backends.
 */
enum FrontDoorForwardingProtocol {
  HttpOnly,
  HttpsOnly,
  MatchRequest,
}

/**
 * Treatment of URL query terms when forming the cache key.
 */
enum FrontDoorQuery {
  StripNone,
  StripAll,
  StripOnly,
  StripAllExcept,
}

/**
 * Whether to use dynamic compression for cached content
 */
enum DynamicCompressionEnabled {
  Enabled,
  Disabled,
}

/**
 * The redirect type the rule will use when redirecting traffic.
 */
enum FrontDoorRedirectType {
  Moved,
  Found,
  TemporaryRedirect,
  PermanentRedirect,
}

/**
 * The protocol of the destination to where the traffic is redirected
 */
enum FrontDoorRedirectProtocol {
  HttpOnly,
  HttpsOnly,
  MatchRequest,
}

/**
 * Type of Front Door resource used in CheckNameAvailability.
 */
@fixed
enum ResourceType {
  `Microsoft.Network/frontDoors`,
  `Microsoft.Network/frontDoors/frontendEndpoints`,
}

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
  @visibility("read")
  frontendEndpointLinks?: FrontendEndpointLink[];

  /**
   * Describes Routing Rules associated with this Web Application Firewall policy.
   */
  @visibility("read")
  routingRuleLinks?: RoutingRuleLink[];

  /**
   * Describes Security Policy associated with this Web Application Firewall policy.
   */
  @visibility("read")
  securityPolicyLinks?: SecurityPolicyLink[];

  /**
   * Provisioning state of the policy.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Resource status of the policy.
   */
  @visibility("read")
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
   * List of match conditions.
   */
  matchConditions: MatchCondition[];

  /**
   * Describes what action to be applied when rule matches.
   */
  action: ActionType;
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
model FrontDoorResourceModel {
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
   * Resource location.
   */
  location?: string;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * List of managed rule set definitions available for use in a policy.
 */
model ManagedRuleSetDefinitionList is Azure.Core.Page<ManagedRuleSetDefinition>;

/**
 * Describes the a managed rule set definition.
 */
model ManagedRuleSetDefinition extends FrontDoorResourceModel {
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
  @visibility("read")
  provisioningState?: string;

  /**
   * Id of the managed rule set.
   */
  @visibility("read")
  ruleSetId?: string;

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
   * Describes the default state for the managed rule.
   */
  @visibility("read")
  defaultState?: ManagedRuleEnabledState;

  /**
   * Describes the default action to be applied when the managed rule matches.
   */
  @visibility("read")
  defaultAction?: ActionType;

  /**
   * Describes the functionality of the managed rule.
   */
  @visibility("read")
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
  @visibility("read")
  nameAvailability?: Availability;

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
 * The JSON object that contains the properties required to create an endpoint.
 */
model FrontDoorProperties extends FrontDoorUpdateParameters {
  /**
   * Resource status of the Front Door.
   */
  @visibility("read")
  resourceState?: FrontDoorResourceState;

  /**
   * Provisioning state of the Front Door.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The host that each frontendEndpoint must CNAME to.
   */
  @visibility("read")
  cname?: string;

  /**
   * The Id of the frontdoor.
   */
  @visibility("read")
  frontdoorId?: string;

  /**
   * Rules Engine Configurations available to routing rules.
   */
  @visibility("read")
  rulesEngines?: RulesEngine[];

  /**
   * Key-Value pair representing additional properties for frontdoor.
   */
  @visibility("read")
  extendedProperties?: Record<string>;
}

/**
 * The JSON object that contains the properties required to create a Rules Engine Configuration.
 */
model RulesEngineProperties extends RulesEngineUpdateParameters {
  /**
   * Resource status.
   */
  @visibility("read")
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
model RouteConfiguration {}

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
model RoutingRule extends FrontDoorResourceData {
  /**
   * Properties of the Front Door Routing Rule
   */
  properties?: RoutingRuleProperties;
}

/**
 * The JSON object that contains the properties required to create a routing rule.
 */
model RoutingRuleProperties extends RoutingRuleUpdateParameters {
  /**
   * Resource status.
   */
  @visibility("read")
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
 * Common resource representation.
 */
model FrontDoorResourceData {
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
  @visibility("read")
  type?: string;
}

/**
 * Load balancing settings for a backend pool
 */
model LoadBalancingSettingsModel extends FrontDoorResourceData {
  /**
   * Properties of the load balancing settings
   */
  properties?: LoadBalancingSettingsProperties;
}

/**
 * The JSON object that contains the properties required to create load balancing settings
 */
model LoadBalancingSettingsProperties
  extends LoadBalancingSettingsUpdateParameters {
  /**
   * Resource status.
   */
  @visibility("read")
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
model HealthProbeSettingsModel extends FrontDoorResourceData {
  /**
   * Properties of the health probe settings
   */
  properties?: HealthProbeSettingsProperties;
}

/**
 * The JSON object that contains the properties required to create a health probe settings.
 */
model HealthProbeSettingsProperties
  extends HealthProbeSettingsUpdateParameters {
  /**
   * Resource status.
   */
  @visibility("read")
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
model BackendPool extends FrontDoorResourceData {
  /**
   * Properties of the Front Door Backend Pool
   */
  properties?: BackendPoolProperties;
}

/**
 * The JSON object that contains the properties required to create a Backend Pool.
 */
model BackendPoolProperties extends BackendPoolUpdateParameters {
  /**
   * Resource status.
   */
  @visibility("read")
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
  @visibility("read")
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
model FrontendEndpointProperties extends FrontendEndpointUpdateParameters {
  /**
   * Resource status.
   */
  @visibility("read")
  resourceState?: FrontDoorResourceState;

  /**
   * Provisioning status of Custom Https of the frontendEndpoint.
   */
  @visibility("read")
  customHttpsProvisioningState?: CustomHttpsProvisioningState;

  /**
   * Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.
   */
  @visibility("read")
  customHttpsProvisioningSubstate?: CustomHttpsProvisioningSubstate;

  /**
   * The configuration specifying how to enable HTTPS
   */
  @visibility("read")
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
  @projectedName("json", "sessionAffinityTtlSeconds")
  sessionAffinityTtlInSeconds?: int32;

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
  @visibility("read")
  customDomainValidated?: boolean;

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
 * Defines the properties of an experiment
 */
model ProfileProperties {
  /**
   * Resource status.
   */
  @visibility("read")
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
model PreconfiguredEndpoint extends FrontDoorResourceModel {
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
 * Defines the properties of an experiment
 */
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
  @visibility("read")
  resourceState?: NetworkExperimentResourceState;

  /**
   * The description of Experiment status from the server side
   */
  @visibility("read")
  status?: string;

  /**
   * The uri to the Script used in the Experiment
   */
  @visibility("read")
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
model LatencyScorecard extends FrontDoorResourceModel {
  /**
   * The properties of a latency scorecard
   */
  properties?: LatencyScorecardProperties;
}

/**
 * Defines a the properties of a Latency Scorecard
 */
model LatencyScorecardProperties {
  /**
   * The unique identifier of the Latency Scorecard
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the Latency Scorecard
   */
  @visibility("read")
  name?: string;

  /**
   * The description of the Latency Scorecard
   */
  @visibility("read")
  description?: string;

  /**
   * The A endpoint in the scorecard
   */
  @visibility("read")
  endpointA?: string;

  /**
   * The B endpoint in the scorecard
   */
  @visibility("read")
  endpointB?: string;

  /**
   * The start time of the Latency Scorecard in UTC
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTimeUTC?: utcDateTime;

  /**
   * The end time of the Latency Scorecard in UTC
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTimeUTC?: utcDateTime;

  /**
   * The country associated with the Latency Scorecard. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html
   */
  @visibility("read")
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
  @visibility("read")
  name?: string;

  /**
   * The end time of the Latency Scorecard in UTC
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTimeUTC?: utcDateTime;

  /**
   * The metric value of the A endpoint
   */
  @visibility("read")
  aValue?: float32;

  /**
   * The metric value of the B endpoint
   */
  @visibility("read")
  bValue?: float32;

  /**
   * The difference in value between endpoint A and B
   */
  @visibility("read")
  delta?: float32;

  /**
   * The percent difference between endpoint A and B
   */
  @visibility("read")
  deltaPercent?: float32;

  /**
   * The lower end of the 95% confidence interval for endpoint A
   */
  @visibility("read")
  aCLower95CI?: float32;

  /**
   * The upper end of the 95% confidence interval for endpoint A
   */
  @visibility("read")
  aHUpper95CI?: float32;

  /**
   * The lower end of the 95% confidence interval for endpoint B
   */
  @visibility("read")
  bCLower95CI?: float32;

  /**
   * The upper end of the 95% confidence interval for endpoint B
   */
  @visibility("read")
  bUpper95CI?: float32;
}

/**
 * Defines the Timeseries
 */
model Timeseries extends FrontDoorResourceModel {
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTimeUTC?: utcDateTime;

  /**
   * The end DateTime of the Timeseries in UTC
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTimeUTC?: utcDateTime;

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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeUTC?: utcDateTime;

  /**
   * The Value of the Timeseries data point
   */
  value?: float32;
}

model ErrorDetails {
  code?: string;
  target?: string;
  message?: string;
}

model Error {
  code?: string;
  message?: string;
  target?: string;
  details?: ErrorDetails[];
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

  error?: Error;
}

/**
 * Result of the request to list Routing Rules. It contains a list of Routing Rule objects and a URL link to get the next set of results.
 */
model RoutingRuleListResult {
  /**
   * List of Routing Rules within a Front Door.
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  value?: BackendPool[];

  /**
   * URL to get the next set of BackendPool objects if there are any.
   */
  nextLink?: string;
}
