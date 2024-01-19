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

@doc("Describes if the policy is in enabled or disabled state. Defaults to Enabled if not specified.")
enum PolicyEnabledState {
  Disabled,
  Enabled,
}

@doc("Describes if it is in detection mode or prevention mode at policy level.")
enum PolicyMode {
  Prevention,
  Detection,
}

@doc("Describes if policy managed rules will inspect the request body content.")
enum PolicyRequestBodyCheck {
  Disabled,
  Enabled,
}

@doc("Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.")
enum CustomRuleEnabledState {
  Disabled,
  Enabled,
}

@doc("Describes type of rule.")
enum RuleType {
  MatchRule,
  RateLimitRule,
}

@doc("Request variable to compare with.")
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

@doc("Comparison type to use for matching with the variable value.")
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

@doc("Describes what transforms applied before matching.")
enum TransformType {
  Lowercase,
  Uppercase,
  Trim,
  UrlDecode,
  UrlEncode,
  RemoveNulls,
}

@doc("Defines the action to take when a managed rule set score threshold is met.")
enum ManagedRuleSetActionType {
  Block,
  Log,
  Redirect,
}

@doc("The variable type to be excluded.")
enum ManagedRuleExclusionMatchVariable {
  RequestHeaderNames,
  RequestCookieNames,
  QueryStringArgNames,
  RequestBodyPostArgNames,
  RequestBodyJsonArgNames,
}

@doc("Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to.")
enum ManagedRuleExclusionSelectorMatchOperator {
  Equals,
  Contains,
  StartsWith,
  EndsWith,
  EqualsAny,
}

@doc("Describes if the managed rule is in enabled or disabled state.")
enum ManagedRuleEnabledState {
  Disabled,
  Enabled,
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

@doc("Name of the pricing tier.")
enum SkuName {
  Classic_AzureFrontDoor,
  Standard_AzureFrontDoor,
  Premium_AzureFrontDoor,
}

@doc("Indicates whether the name is available.")
enum Availability {
  Available,
  Unavailable,
}

@doc("Resource status of the Front Door or Front Door SubResource.")
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

@doc("Which type of manipulation to apply to the header.")
enum HeaderActionType {
  Append,
  Delete,
  Overwrite,
}

@doc("Match Variable")
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

@doc("Describes operator to apply to the match condition.")
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

@doc("Describes what transforms are applied before matching")
enum Transform {
  Lowercase,
  Uppercase,
  Trim,
  UrlDecode,
  UrlEncode,
  RemoveNulls,
}

@doc("If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.")
enum MatchProcessingBehavior {
  Continue,
  Stop,
}

@doc("Accepted protocol schemes.")
enum FrontDoorProtocol {
  Http,
  Https,
}

@doc("Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'")
enum RoutingRuleEnabledState {
  Enabled,
  Disabled,
}

@doc("Configures which HTTP method to use to probe the backends defined under backendPools.")
enum FrontDoorHealthProbeMethod {
  GET,
  HEAD,
}

@doc("Whether to enable health probes to be made against backends defined under backendPools. Health probes can only be disabled if there is a single enabled backend in single enabled backend pool.")
enum HealthProbeEnabled {
  Enabled,
  Disabled,
}

@doc("The Approval status for the connection to the Private Link")
enum PrivateEndpointStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

@doc("Whether to enable use of this backend. Permitted values are 'Enabled' or 'Disabled'")
enum BackendEnabledState {
  Enabled,
  Disabled,
}

@doc("Provisioning status of Custom Https of the frontendEndpoint.")
enum CustomHttpsProvisioningState {
  Enabling,
  Enabled,
  Disabling,
  Disabled,
  Failed,
}

@doc("Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.")
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

@doc("Defines the source of the SSL certificate")
enum FrontDoorCertificateSource {
  AzureKeyVault,
  FrontDoor,
}

@doc("Defines the TLS extension protocol that is used for secure delivery")
enum FrontDoorTlsProtocolType {
  ServerNameIndication,
}

@doc("The minimum TLS version required from the clients to establish an SSL handshake with Front Door.")
enum MinimumTLSVersion {
  `1.0`,
  `1.2`,
}

@doc("Defines the type of the certificate used for secure connections to a frontendEndpoint")
enum FrontDoorCertificateType {
  Dedicated,
}

@doc("Whether to allow session affinity on this host. Valid options are 'Enabled' or 'Disabled'")
enum SessionAffinityEnabledState {
  Enabled,
  Disabled,
}

@doc("Whether to enforce certificate name check on HTTPS requests to all backend pools. No effect on non-HTTPS requests.")
enum EnforceCertificateNameCheckEnabledState {
  Enabled,
  Disabled,
}

@doc("Operational status of the Front Door load balancer. Permitted values are 'Enabled' or 'Disabled'")
enum FrontDoorEnabledState {
  Enabled,
  Disabled,
}

@doc("Defines the server side resource status")
enum NetworkExperimentResourceState {
  Creating,
  Enabling,
  Enabled,
  Disabling,
  Disabled,
  Deleting,
}

@doc("The state of the Experiment")
enum State {
  Enabled,
  Disabled,
}

@doc("The type of endpoint")
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

@doc("The type of Timeseries")
enum TimeseriesType {
  MeasurementCounts,
  LatencyP50,
  LatencyP75,
  LatencyP95,
}

@doc("The aggregation interval of the Timeseries")
enum AggregationInterval {
  Hourly,
  Daily,
}

@doc("Status of the Azure async operation.")
enum NetworkOperationStatus {
  InProgress,
  Succeeded,
  Failed,
}

@doc("Protocol this rule will use when forwarding traffic to backends.")
enum FrontDoorForwardingProtocol {
  HttpOnly,
  HttpsOnly,
  MatchRequest,
}

@doc("Treatment of URL query terms when forming the cache key.")
enum FrontDoorQuery {
  StripNone,
  StripAll,
  StripOnly,
  StripAllExcept,
}

@doc("Whether to use dynamic compression for cached content")
enum DynamicCompressionEnabled {
  Enabled,
  Disabled,
}

@doc("The redirect type the rule will use when redirecting traffic.")
enum FrontDoorRedirectType {
  Moved,
  Found,
  TemporaryRedirect,
  PermanentRedirect,
}

@doc("The protocol of the destination to where the traffic is redirected")
enum FrontDoorRedirectProtocol {
  HttpOnly,
  HttpsOnly,
  MatchRequest,
}

@doc("Type of Front Door resource used in CheckNameAvailability.")
@fixed
enum ResourceType {
  `Microsoft.Network/frontDoors`,
  `Microsoft.Network/frontDoors/frontendEndpoints`,
}

@doc("Defines web application firewall policy properties.")
model WebApplicationFirewallPolicyProperties {
  @doc("Describes settings for the policy.")
  policySettings?: PolicySettings;

  @doc("Describes custom rules inside the policy.")
  customRules?: CustomRuleList;

  @doc("Describes managed rules inside the policy.")
  managedRules?: ManagedRuleSetList;

  @doc("Describes Frontend Endpoints associated with this Web Application Firewall policy.")
  @visibility("read")
  frontendEndpointLinks?: FrontendEndpointLink[];

  @doc("Describes Routing Rules associated with this Web Application Firewall policy.")
  @visibility("read")
  routingRuleLinks?: RoutingRuleLink[];

  @doc("Describes Security Policy associated with this Web Application Firewall policy.")
  @visibility("read")
  securityPolicyLinks?: SecurityPolicyLink[];

  @doc("Provisioning state of the policy.")
  @visibility("read")
  provisioningState?: string;

  @doc("Resource status of the policy.")
  @visibility("read")
  resourceState?: PolicyResourceState;
}

@doc("Defines top-level WebApplicationFirewallPolicy configuration settings.")
model PolicySettings {
  @doc("Describes if the policy is in enabled or disabled state. Defaults to Enabled if not specified.")
  enabledState?: PolicyEnabledState;

  @doc("Describes if it is in detection mode or prevention mode at policy level.")
  mode?: PolicyMode;

  @doc("If action type is redirect, this field represents redirect URL for the client.")
  redirectUrl?: string;

  @doc("If the action type is block, customer can override the response status code.")
  customBlockResponseStatusCode?: int32;

  @doc("If the action type is block, customer can override the response body. The body must be specified in base64 encoding.")
  @pattern("^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$")
  customBlockResponseBody?: string;

  @doc("Describes if policy managed rules will inspect the request body content.")
  requestBodyCheck?: PolicyRequestBodyCheck;
}

@doc("Defines contents of custom rules")
model CustomRuleList {
  @doc("List of rules")
  rules?: CustomRule[];
}

@doc("Defines contents of a web application rule")
model CustomRule {
  @doc("Describes the name of the rule.")
  @maxLength(128)
  name?: string;

  @doc("Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.")
  priority: int32;

  @doc("Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.")
  enabledState?: CustomRuleEnabledState;

  @doc("Describes type of rule.")
  ruleType: RuleType;

  @doc("Time window for resetting the rate limit count. Default is 1 minute.")
  @maxValue(5)
  rateLimitDurationInMinutes?: int32;

  @doc("Number of allowed requests per client within the time window.")
  rateLimitThreshold?: int32;

  @doc("List of match conditions.")
  matchConditions: MatchCondition[];

  @doc("Describes what action to be applied when rule matches.")
  action: ActionType;
}

@doc("Define a match condition.")
model MatchCondition {
  @doc("Request variable to compare with.")
  matchVariable: MatchVariable;

  @doc("Match against a specific key from the QueryString, PostArgs, RequestHeader or Cookies variables. Default is null.")
  selector?: string;

  @doc("Comparison type to use for matching with the variable value.")
  operator: Operator;

  @doc("Describes if the result of this condition should be negated.")
  negateCondition?: boolean;

  @doc("List of possible match values.")
  matchValue: string[];

  @doc("List of transforms.")
  transforms?: TransformType[];
}

@doc("Defines the list of managed rule sets for the policy.")
model ManagedRuleSetList {
  @doc("List of rule sets.")
  managedRuleSets?: ManagedRuleSet[];
}

@doc("Defines a managed rule set.")
model ManagedRuleSet {
  @doc("Defines the rule set type to use.")
  ruleSetType: string;

  @doc("Defines the version of the rule set to use.")
  ruleSetVersion: string;

  @doc("Defines the rule set action.")
  ruleSetAction?: ManagedRuleSetActionType;

  @doc("Describes the exclusions that are applied to all rules in the set.")
  exclusions?: ManagedRuleExclusion[];

  @doc("Defines the rule group overrides to apply to the rule set.")
  ruleGroupOverrides?: ManagedRuleGroupOverride[];
}

@doc("Exclude variables from managed rule evaluation.")
model ManagedRuleExclusion {
  @doc("The variable type to be excluded.")
  matchVariable: ManagedRuleExclusionMatchVariable;

  @doc("Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to.")
  selectorMatchOperator: ManagedRuleExclusionSelectorMatchOperator;

  @doc("Selector value for which elements in the collection this exclusion applies to.")
  selector: string;
}

@doc("Defines a managed rule group override setting.")
model ManagedRuleGroupOverride {
  @doc("Describes the managed rule group to override.")
  ruleGroupName: string;

  @doc("Describes the exclusions that are applied to all rules in the group.")
  exclusions?: ManagedRuleExclusion[];

  @doc("List of rules that will be disabled. If none specified, all rules in the group will be disabled.")
  rules?: ManagedRuleOverride[];
}

@doc("Defines a managed rule group override setting.")
model ManagedRuleOverride {
  @doc("Identifier for the managed rule.")
  ruleId: string;

  @doc("Describes if the managed rule is in enabled or disabled state. Defaults to Disabled if not specified.")
  enabledState?: ManagedRuleEnabledState;

  @doc("Describes the override action to be applied when rule matches.")
  action?: ActionType;

  @doc("Describes the exclusions that are applied to this specific rule.")
  exclusions?: ManagedRuleExclusion[];
}

@doc("Defines the Resource ID for a Frontend Endpoint.")
model FrontendEndpointLink {
  @doc("Resource ID.")
  id?: string;
}

@doc("Defines the Resource ID for a Routing Rule.")
model RoutingRuleLink {
  @doc("Resource ID.")
  id?: string;
}

@doc("Defines the Resource ID for a Security Policy.")
model SecurityPolicyLink {
  @doc("Resource ID.")
  id?: string;
}

@doc("The pricing tier of the web application firewall policy.")
model Sku {
  @doc("Name of the pricing tier.")
  name?: SkuName;
}

@doc("Common resource representation.")
model FrontDoorResourceModel {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("Resource location.")
  location?: string;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Tags object for patch operations.")
model TagsObject {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("List of managed rule set definitions available for use in a policy.")
model ManagedRuleSetDefinitionList is Azure.Core.Page<ManagedRuleSetDefinition>;

@doc("Describes the a managed rule set definition.")
model ManagedRuleSetDefinition extends FrontDoorResourceModel {
  @doc("Properties for a managed rule set definition.")
  properties?: ManagedRuleSetDefinitionProperties;
}

@doc("Properties for a managed rule set definition.")
model ManagedRuleSetDefinitionProperties {
  @doc("Provisioning state of the managed rule set.")
  @visibility("read")
  provisioningState?: string;

  @doc("Id of the managed rule set.")
  @visibility("read")
  ruleSetId?: string;

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

  @doc("Describes the default state for the managed rule.")
  @visibility("read")
  defaultState?: ManagedRuleEnabledState;

  @doc("Describes the default action to be applied when the managed rule matches.")
  @visibility("read")
  defaultAction?: ActionType;

  @doc("Describes the functionality of the managed rule.")
  @visibility("read")
  description?: string;
}

@doc("Input of CheckNameAvailability API.")
model CheckNameAvailabilityInput {
  @doc("The resource name to validate.")
  name: string;

  @doc("The type of the resource whose name is to be validated.")
  type: ResourceType;
}

@doc("Output of check name availability API.")
model CheckNameAvailabilityOutput {
  @doc("Indicates whether the name is available.")
  @visibility("read")
  nameAvailability?: Availability;

  @doc("The reason why the name is not available.")
  @visibility("read")
  reason?: string;

  @doc("The detailed error message describing why the name is not available.")
  @visibility("read")
  message?: string;
}

@doc("The JSON object that contains the properties required to create an endpoint.")
model FrontDoorProperties extends FrontDoorUpdateParameters {
  @doc("Resource status of the Front Door.")
  @visibility("read")
  resourceState?: FrontDoorResourceState;

  @doc("Provisioning state of the Front Door.")
  @visibility("read")
  provisioningState?: string;

  @doc("The host that each frontendEndpoint must CNAME to.")
  @visibility("read")
  cname?: string;

  @doc("The Id of the frontdoor.")
  @visibility("read")
  frontdoorId?: string;

  @doc("Rules Engine Configurations available to routing rules.")
  @visibility("read")
  rulesEngines?: RulesEngine[];

  @doc("Key-Value pair representing additional properties for frontdoor.")
  @visibility("read")
  extendedProperties?: Record<string>;
}

@doc("The JSON object that contains the properties required to create a Rules Engine Configuration.")
model RulesEngineProperties extends RulesEngineUpdateParameters {
  @doc("Resource status.")
  @visibility("read")
  resourceState?: FrontDoorResourceState;
}

@doc("Rules Engine Configuration to apply to a Routing Rule.")
model RulesEngineUpdateParameters {
  @doc("A list of rules that define a particular Rules Engine Configuration.")
  rules?: RulesEngineRule[];
}

@doc("Contains a list of match conditions, and an action on how to modify the request/response. If multiple rules match, the actions from one rule that conflict with a previous rule overwrite for a singular action, or append in the case of headers manipulation.")
model RulesEngineRule {
  @doc("A name to refer to this specific rule.")
  name: string;

  @doc("A priority assigned to this rule. ")
  priority: int32;

  @doc("Actions to perform on the request and response if all of the match conditions are met.")
  action: RulesEngineAction;

  @doc("A list of match conditions that must meet in order for the actions of this rule to run. Having no match conditions means the actions will always run.")
  matchConditions?: RulesEngineMatchCondition[];

  @doc("If this rule is a match should the rules engine continue running the remaining rules or stop. If not present, defaults to Continue.")
  matchProcessingBehavior?: MatchProcessingBehavior;
}

@doc("One or more actions that will execute, modifying the request and/or response.")
model RulesEngineAction {
  @doc("A list of header actions to apply from the request from AFD to the origin.")
  requestHeaderActions?: HeaderAction[];

  @doc("A list of header actions to apply from the response from AFD to the client.")
  responseHeaderActions?: HeaderAction[];

  @doc("Override the route configuration.")
  routeConfigurationOverride?: RouteConfiguration;
}

@doc("An action that can manipulate an http header.")
model HeaderAction {
  @doc("Which type of manipulation to apply to the header.")
  headerActionType: HeaderActionType;

  @doc("The name of the header this action will apply to.")
  headerName: string;

  @doc("The value to update the given header name with. This value is not used if the actionType is Delete.")
  value?: string;
}

@doc("Base class for all types of Route.")
@discriminator("@odata.type")
model RouteConfiguration {}

@doc("Define a match condition")
model RulesEngineMatchCondition {
  @doc("Match Variable")
  rulesEngineMatchVariable: RulesEngineMatchVariable;

  @doc("Name of selector in RequestHeader or RequestBody to be matched")
  selector?: string;

  @doc("Describes operator to apply to the match condition.")
  rulesEngineOperator: RulesEngineOperator;

  @doc("Describes if this is negate condition or not")
  negateCondition?: boolean;

  @doc("Match values to match against. The operator will apply to each value in here with OR semantics. If any of them match the variable with the given operator this match condition is considered a match.")
  rulesEngineMatchValue: string[];

  @doc("List of transforms")
  transforms?: Transform[];
}

@doc("The properties needed to update a Front Door")
model FrontDoorUpdateParameters {
  @doc("A friendly name for the frontDoor")
  friendlyName?: string;

  @doc("Routing rules associated with this Front Door.")
  routingRules?: RoutingRule[];

  @doc("Load balancing settings associated with this Front Door instance.")
  loadBalancingSettings?: LoadBalancingSettingsModel[];

  @doc("Health probe settings associated with this Front Door instance.")
  healthProbeSettings?: HealthProbeSettingsModel[];

  @doc("Backend pools available to routing rules.")
  backendPools?: BackendPool[];

  @doc("Frontend endpoints available to routing rules.")
  frontendEndpoints?: FrontendEndpoint[];

  @doc("Settings for all backendPools")
  backendPoolsSettings?: BackendPoolsSettings;

  @doc("Operational status of the Front Door load balancer. Permitted values are 'Enabled' or 'Disabled'")
  enabledState?: FrontDoorEnabledState;
}

@doc("A routing rule represents a specification for traffic to treat and where to send it, along with health probe information.")
model RoutingRule extends FrontDoorResourceData {
  @doc("Properties of the Front Door Routing Rule")
  properties?: RoutingRuleProperties;
}

@doc("The JSON object that contains the properties required to create a routing rule.")
model RoutingRuleProperties extends RoutingRuleUpdateParameters {
  @doc("Resource status.")
  @visibility("read")
  resourceState?: FrontDoorResourceState;
}

@doc("Routing rules to apply to an endpoint")
model RoutingRuleUpdateParameters {
  @doc("Frontend endpoints associated with this rule")
  frontendEndpoints?: SubResource[];

  @doc("Protocol schemes to match for this rule")
  acceptedProtocols?: FrontDoorProtocol[];

  @doc("The route patterns of the rule.")
  patternsToMatch?: string[];

  @doc("Whether to enable use of this rule. Permitted values are 'Enabled' or 'Disabled'")
  enabledState?: RoutingRuleEnabledState;

  @doc("A reference to the routing configuration.")
  routeConfiguration?: RouteConfiguration;

  @doc("A reference to a specific Rules Engine Configuration to apply to this route.")
  rulesEngine?: SubResource;

  @doc("Defines the Web Application Firewall policy for each routing rule (if applicable)")
  webApplicationFirewallPolicyLink?: RoutingRuleUpdateParametersWebApplicationFirewallPolicyLink;
}

@doc("Reference to another subresource.")
model SubResource {
  @doc("Resource ID.")
  id?: string;
}

@doc("Defines the Web Application Firewall policy for each routing rule (if applicable)")
model RoutingRuleUpdateParametersWebApplicationFirewallPolicyLink {
  @doc("Resource ID.")
  id?: string;
}

@doc("Common resource representation.")
model FrontDoorResourceData {
  @doc("Resource ID.")
  id?: string;

  @doc("Resource name.")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;
}

@doc("Load balancing settings for a backend pool")
model LoadBalancingSettingsModel extends FrontDoorResourceData {
  @doc("Properties of the load balancing settings")
  properties?: LoadBalancingSettingsProperties;
}

@doc("The JSON object that contains the properties required to create load balancing settings")
model LoadBalancingSettingsProperties
  extends LoadBalancingSettingsUpdateParameters {
  @doc("Resource status.")
  @visibility("read")
  resourceState?: FrontDoorResourceState;
}

@doc("Round-Robin load balancing settings for a backend pool")
model LoadBalancingSettingsUpdateParameters {
  @doc("The number of samples to consider for load balancing decisions")
  sampleSize?: int32;

  @doc("The number of samples within the sample period that must succeed")
  successfulSamplesRequired?: int32;

  @doc("The additional latency in milliseconds for probes to fall into the lowest latency bucket")
  additionalLatencyMilliseconds?: int32;
}

@doc("Load balancing settings for a backend pool")
model HealthProbeSettingsModel extends FrontDoorResourceData {
  @doc("Properties of the health probe settings")
  properties?: HealthProbeSettingsProperties;
}

@doc("The JSON object that contains the properties required to create a health probe settings.")
model HealthProbeSettingsProperties
  extends HealthProbeSettingsUpdateParameters {
  @doc("Resource status.")
  @visibility("read")
  resourceState?: FrontDoorResourceState;
}

@doc("L7 health probe settings for a backend pool")
model HealthProbeSettingsUpdateParameters {
  @doc("The path to use for the health probe. Default is /")
  path?: string;

  @doc("Protocol scheme to use for this probe")
  protocol?: FrontDoorProtocol;

  @doc("The number of seconds between health probes.")
  intervalInSeconds?: int32;

  @doc("Configures which HTTP method to use to probe the backends defined under backendPools.")
  healthProbeMethod?: FrontDoorHealthProbeMethod;

  @doc("Whether to enable health probes to be made against backends defined under backendPools. Health probes can only be disabled if there is a single enabled backend in single enabled backend pool.")
  enabledState?: HealthProbeEnabled;
}

@doc("A backend pool is a collection of backends that can be routed to.")
model BackendPool extends FrontDoorResourceData {
  @doc("Properties of the Front Door Backend Pool")
  properties?: BackendPoolProperties;
}

@doc("The JSON object that contains the properties required to create a Backend Pool.")
model BackendPoolProperties extends BackendPoolUpdateParameters {
  @doc("Resource status.")
  @visibility("read")
  resourceState?: FrontDoorResourceState;
}

@doc("A collection of backends that can be routed to.")
model BackendPoolUpdateParameters {
  @doc("The set of backends for this pool")
  backends?: Backend[];

  @doc("Load balancing settings for a backend pool")
  loadBalancingSettings?: SubResource;

  @doc("L7 health probe settings for a backend pool")
  healthProbeSettings?: SubResource;
}

@doc("Backend address of a frontDoor load balancer.")
model Backend {
  @doc("Location of the backend (IP address or FQDN)")
  address?: string;

  @doc("The Alias of the Private Link resource. Populating this optional field indicates that this backend is 'Private'")
  privateLinkAlias?: string;

  @doc("The Resource Id of the Private Link resource. Populating this optional field indicates that this backend is 'Private'")
  privateLinkResourceId?: string;

  @doc("The location of the Private Link resource. Required only if 'privateLinkResourceId' is populated")
  privateLinkLocation?: string;

  @doc("The Approval status for the connection to the Private Link")
  @visibility("read")
  privateEndpointStatus?: PrivateEndpointStatus;

  @doc("A custom message to be included in the approval request to connect to the Private Link")
  privateLinkApprovalMessage?: string;

  @doc("The HTTP TCP port number. Must be between 1 and 65535.")
  @maxValue(65535)
  @minValue(1)
  httpPort?: int32;

  @doc("The HTTPS TCP port number. Must be between 1 and 65535.")
  @maxValue(65535)
  @minValue(1)
  httpsPort?: int32;

  @doc("Whether to enable use of this backend. Permitted values are 'Enabled' or 'Disabled'")
  enabledState?: BackendEnabledState;

  @doc("Priority to use for load balancing. Higher priorities will not be used for load balancing if any lower priority backend is healthy.")
  @maxValue(5)
  @minValue(1)
  priority?: int32;

  @doc("Weight of this endpoint for load balancing purposes.")
  @maxValue(1000)
  @minValue(1)
  weight?: int32;

  @doc("The value to use as the host header sent to the backend. If blank or unspecified, this defaults to the incoming host.")
  backendHostHeader?: string;
}

@doc("The JSON object that contains the properties required to create a frontend endpoint.")
model FrontendEndpointProperties extends FrontendEndpointUpdateParameters {
  @doc("Resource status.")
  @visibility("read")
  resourceState?: FrontDoorResourceState;

  @doc("Provisioning status of Custom Https of the frontendEndpoint.")
  @visibility("read")
  customHttpsProvisioningState?: CustomHttpsProvisioningState;

  @doc("Provisioning substate shows the progress of custom HTTPS enabling/disabling process step by step.")
  @visibility("read")
  customHttpsProvisioningSubstate?: CustomHttpsProvisioningSubstate;

  @doc("The configuration specifying how to enable HTTPS")
  @visibility("read")
  customHttpsConfiguration?: CustomHttpsConfiguration;
}

@doc("Https settings for a domain")
model CustomHttpsConfiguration {
  @doc("Defines the source of the SSL certificate")
  certificateSource: FrontDoorCertificateSource;

  @doc("Defines the TLS extension protocol that is used for secure delivery")
  protocolType: FrontDoorTlsProtocolType;

  @doc("The minimum TLS version required from the clients to establish an SSL handshake with Front Door.")
  minimumTlsVersion: MinimumTLSVersion;

  @doc("KeyVault certificate source parameters (if certificateSource=AzureKeyVault)")
  keyVaultCertificateSourceParameters?: KeyVaultCertificateSourceParameters;

  @doc("Parameters required for enabling SSL with Front Door-managed certificates (if certificateSource=FrontDoor)")
  frontDoorCertificateSourceParameters?: FrontDoorCertificateSourceParameters;
}

@doc("Parameters required for bring-your-own-certification via Key Vault")
model KeyVaultCertificateSourceParameters {
  @doc("The Key Vault containing the SSL certificate")
  vault?: KeyVaultCertificateSourceParametersVault;

  @doc("The name of the Key Vault secret representing the full certificate PFX")
  secretName?: string;

  @doc("The version of the Key Vault secret representing the full certificate PFX")
  secretVersion?: string;
}

@doc("The Key Vault containing the SSL certificate")
model KeyVaultCertificateSourceParametersVault {
  @doc("Resource ID.")
  id?: string;
}

@doc("Parameters required for enabling SSL with Front Door-managed certificates")
model FrontDoorCertificateSourceParameters {
  @doc("Defines the type of the certificate used for secure connections to a frontendEndpoint")
  certificateType?: FrontDoorCertificateType;
}

@doc("Frontend endpoint used in routing rule")
model FrontendEndpointUpdateParameters {
  @doc("The host name of the frontendEndpoint. Must be a domain name.")
  hostName?: string;

  @doc("Whether to allow session affinity on this host. Valid options are 'Enabled' or 'Disabled'")
  sessionAffinityEnabledState?: SessionAffinityEnabledState;

  @doc("UNUSED. This field will be ignored. The TTL to use in seconds for session affinity, if applicable.")
  @projectedName("json", "sessionAffinityTtlSeconds")
  sessionAffinityTtlInSeconds?: int32;

  @doc("Defines the Web Application Firewall policy for each host (if applicable)")
  webApplicationFirewallPolicyLink?: FrontendEndpointUpdateParametersWebApplicationFirewallPolicyLink;
}

@doc("Defines the Web Application Firewall policy for each host (if applicable)")
model FrontendEndpointUpdateParametersWebApplicationFirewallPolicyLink {
  @doc("Resource ID.")
  id?: string;
}

@doc("Settings that apply to all backend pools.")
model BackendPoolsSettings {
  @doc("Whether to enforce certificate name check on HTTPS requests to all backend pools. No effect on non-HTTPS requests.")
  enforceCertificateNameCheck?: EnforceCertificateNameCheckEnabledState;

  @doc("Send and receive timeout on forwarding request to the backend. When timeout is reached, the request fails and returns.")
  @minValue(16)
  sendRecvTimeoutSeconds?: int32;
}

@doc("Parameters required for content purge.")
model PurgeParameters {
  @doc("The path to the content to be purged. Can describe a file path or a wild card directory.")
  contentPaths: string[];
}

@doc("Input of the custom domain to be validated for DNS mapping.")
model ValidateCustomDomainInput {
  @doc("The host name of the custom domain. Must be a domain name.")
  hostName: string;
}

@doc("Output of custom domain validation.")
model ValidateCustomDomainOutput {
  @doc("Indicates whether the custom domain is valid or not.")
  @visibility("read")
  customDomainValidated?: boolean;

  @doc("The reason why the custom domain is not valid.")
  @visibility("read")
  reason?: string;

  @doc("Error message describing why the custom domain is not valid.")
  @visibility("read")
  message?: string;
}

@doc("Defines the properties of an experiment")
model ProfileProperties {
  @doc("Resource status.")
  @visibility("read")
  resourceState?: NetworkExperimentResourceState;

  @doc("The state of the Experiment")
  enabledState?: State;
}

@doc("Defines modifiable attributes of a Profile")
model ProfileUpdateModel {
  @doc("The properties of a Profile")
  properties?: ProfileUpdateProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Defines the properties of an experiment")
model ProfileUpdateProperties {
  @doc("The enabled state of the Profile")
  enabledState?: State;
}

@doc("Defines a list of preconfigured endpoints.")
model PreconfiguredEndpointList is Azure.Core.Page<PreconfiguredEndpoint>;

@doc("Defines the properties of a preconfigured endpoint")
model PreconfiguredEndpoint extends FrontDoorResourceModel {
  @doc("The properties of a preconfiguredEndpoint")
  properties?: PreconfiguredEndpointProperties;
}

@doc("Defines the properties of a preconfigured endpoint")
model PreconfiguredEndpointProperties {
  @doc("The description of the endpoint")
  description?: string;

  @doc("The endpoint that is preconfigured")
  endpoint?: string;

  @doc("The type of endpoint")
  endpointType?: EndpointType;

  @doc("The preconfigured endpoint backend")
  backend?: string;
}

@doc("Defines the properties of an experiment")
model ExperimentProperties {
  @doc("The description of the details or intents of the Experiment")
  description?: string;

  @doc("The endpoint A of an experiment")
  endpointA?: Endpoint;

  @doc("The endpoint B of an experiment")
  endpointB?: Endpoint;

  @doc("The state of the Experiment")
  enabledState?: State;

  @doc("Resource status.")
  @visibility("read")
  resourceState?: NetworkExperimentResourceState;

  @doc("The description of Experiment status from the server side")
  @visibility("read")
  status?: string;

  @doc("The uri to the Script used in the Experiment")
  @visibility("read")
  scriptFileUri?: string;
}

@doc("Defines the endpoint properties")
model Endpoint {
  @doc("The name of the endpoint")
  name?: string;

  @doc("The endpoint URL")
  endpoint?: string;
}

@doc("Defines modifiable attributes of an Experiment")
model ExperimentUpdateModel {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The properties of a Profile")
  properties?: ExperimentUpdateProperties;
}

@doc("Defines the properties of an experiment")
model ExperimentUpdateProperties {
  @doc("The description of the intent or details of the Experiment")
  description?: string;

  @doc("The state of the Experiment")
  enabledState?: State;
}

@doc("Defines the LatencyScorecard")
model LatencyScorecard extends FrontDoorResourceModel {
  @doc("The properties of a latency scorecard")
  properties?: LatencyScorecardProperties;
}

@doc("Defines a the properties of a Latency Scorecard")
model LatencyScorecardProperties {
  @doc("The unique identifier of the Latency Scorecard")
  @visibility("read")
  id?: string;

  @doc("The name of the Latency Scorecard")
  @visibility("read")
  name?: string;

  @doc("The description of the Latency Scorecard")
  @visibility("read")
  description?: string;

  @doc("The A endpoint in the scorecard")
  @visibility("read")
  endpointA?: string;

  @doc("The B endpoint in the scorecard")
  @visibility("read")
  endpointB?: string;

  @doc("The start time of the Latency Scorecard in UTC")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTimeUTC?: utcDateTime;

  @doc("The end time of the Latency Scorecard in UTC")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTimeUTC?: utcDateTime;

  @doc("The country associated with the Latency Scorecard. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html")
  @visibility("read")
  country?: string;

  @doc("The latency metrics of the Latency Scorecard")
  latencyMetrics?: LatencyMetric[];
}

@doc("Defines the properties of a latency metric used in the latency scorecard")
model LatencyMetric {
  @doc("The name of the Latency Metric")
  @visibility("read")
  name?: string;

  @doc("The end time of the Latency Scorecard in UTC")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTimeUTC?: utcDateTime;

  @doc("The metric value of the A endpoint")
  @visibility("read")
  aValue?: float32;

  @doc("The metric value of the B endpoint")
  @visibility("read")
  bValue?: float32;

  @doc("The difference in value between endpoint A and B")
  @visibility("read")
  delta?: float32;

  @doc("The percent difference between endpoint A and B")
  @visibility("read")
  deltaPercent?: float32;

  @doc("The lower end of the 95% confidence interval for endpoint A")
  @visibility("read")
  aCLower95CI?: float32;

  @doc("The upper end of the 95% confidence interval for endpoint A")
  @visibility("read")
  aHUpper95CI?: float32;

  @doc("The lower end of the 95% confidence interval for endpoint B")
  @visibility("read")
  bCLower95CI?: float32;

  @doc("The upper end of the 95% confidence interval for endpoint B")
  @visibility("read")
  bUpper95CI?: float32;
}

@doc("Defines the Timeseries")
model Timeseries extends FrontDoorResourceModel {
  @doc("The properties of a Timeseries")
  properties?: TimeseriesProperties;
}

@doc("Defines the properties of a timeseries")
model TimeseriesProperties {
  @doc("The endpoint associated with the Timeseries data point")
  endpoint?: string;

  @doc("The start DateTime of the Timeseries in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTimeUTC?: utcDateTime;

  @doc("The end DateTime of the Timeseries in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTimeUTC?: utcDateTime;

  @doc("The aggregation interval of the Timeseries")
  aggregationInterval?: AggregationInterval;

  @doc("The type of Timeseries")
  timeseriesType?: TimeseriesType;

  @doc("The country associated with the Timeseries. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html")
  country?: string;

  @doc("The set of data points for the timeseries")
  timeseriesData?: TimeseriesDataPoint[];
}

@doc("Defines a timeseries datapoint used in a timeseries")
model TimeseriesDataPoint {
  @doc("The DateTime of the Timeseries data point in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTimeUTC?: utcDateTime;

  @doc("The Value of the Timeseries data point")
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

@doc("The response body contains the status of the specified asynchronous operation, indicating whether it has succeeded, is in progress, or has failed. Note that this status is distinct from the HTTP status code returned for the Get Operation Status operation itself. If the asynchronous operation succeeded, the response body includes the HTTP status code for the successful request. If the asynchronous operation failed, the response body includes the HTTP status code for the failed request and error information regarding the failure.")
model AzureAsyncOperationResult {
  @doc("Status of the Azure async operation.")
  status?: NetworkOperationStatus;

  error?: Error;
}

@doc("Result of the request to list Routing Rules. It contains a list of Routing Rule objects and a URL link to get the next set of results.")
model RoutingRuleListResult {
  @doc("List of Routing Rules within a Front Door.")
  @visibility("read")
  value?: RoutingRule[];

  @doc("URL to get the next set of RoutingRule objects if there are any.")
  nextLink?: string;
}

@doc("Describes Forwarding Route.")
model ForwardingConfiguration extends RouteConfiguration {
  @doc("A custom path used to rewrite resource paths matched by this rule. Leave empty to use incoming path.")
  customForwardingPath?: string;

  @doc("Protocol this rule will use when forwarding traffic to backends.")
  forwardingProtocol?: FrontDoorForwardingProtocol;

  @doc("The caching configuration associated with this rule.")
  cacheConfiguration?: CacheConfiguration;

  @doc("A reference to the BackendPool which this rule routes to.")
  backendPool?: SubResource;

  `@odata.type`: "#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration";
}

@doc("Caching settings for a caching-type route. To disable caching, do not provide a cacheConfiguration object.")
model CacheConfiguration {
  @doc("Treatment of URL query terms when forming the cache key.")
  queryParameterStripDirective?: FrontDoorQuery;

  @doc("query parameters to include or exclude (comma separated).")
  queryParameters?: string;

  @doc("Whether to use dynamic compression for cached content")
  dynamicCompression?: DynamicCompressionEnabled;

  @doc("The duration for which the content needs to be cached. Allowed format is in ISO 8601 format (http://en.wikipedia.org/wiki/ISO_8601#Durations). HTTP requires the value to be no more than a year")
  cacheDuration?: duration;
}

@doc("Describes Redirect Route.")
model RedirectConfiguration extends RouteConfiguration {
  @doc("The redirect type the rule will use when redirecting traffic.")
  redirectType?: FrontDoorRedirectType;

  @doc("The protocol of the destination to where the traffic is redirected")
  redirectProtocol?: FrontDoorRedirectProtocol;

  @doc("Host to redirect. Leave empty to use the incoming host as the destination host.")
  customHost?: string;

  @doc("The full path to redirect. Path cannot be empty and must start with /. Leave empty to use the incoming path as destination path.")
  customPath?: string;

  @doc("Fragment to add to the redirect URL. Fragment is the part of the URL that comes after #. Do not include the #.")
  customFragment?: string;

  @doc("The set of query strings to be placed in the redirect URL. Setting this value would replace any existing query string; leave empty to preserve the incoming query string. Query string must be in <key>=<value> format. The first ? and & will be added automatically so do not include them in the front, but do separate multiple query strings with &.")
  customQueryString?: string;

  `@odata.type`: "#Microsoft.Azure.FrontDoor.Models.FrontdoorRedirectConfiguration";
}

@doc("Result of the request to list load balancing settings. It contains a list of load balancing settings objects and a URL link to get the next set of results.")
model LoadBalancingSettingsListResult {
  @doc("List of Backend Pools within a Front Door.")
  @visibility("read")
  value?: LoadBalancingSettingsModel[];

  @doc("URL to get the next set of LoadBalancingSettings objects if there are any.")
  nextLink?: string;
}

@doc("Result of the request to list HealthProbeSettings. It contains a list of HealthProbeSettings objects and a URL link to get the next set of results.")
model HealthProbeSettingsListResult {
  @doc("List of HealthProbeSettings within a Front Door.")
  @visibility("read")
  value?: HealthProbeSettingsModel[];

  @doc("URL to get the next set of HealthProbeSettings objects if there are any.")
  nextLink?: string;
}

@doc("Result of the request to list Backend Pools. It contains a list of Backend Pools objects and a URL link to get the next set of results.")
model BackendPoolListResult {
  @doc("List of Backend Pools within a Front Door.")
  @visibility("read")
  value?: BackendPool[];

  @doc("URL to get the next set of BackendPool objects if there are any.")
  nextLink?: string;
}
