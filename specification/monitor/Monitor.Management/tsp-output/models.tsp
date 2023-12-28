import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.Monitor;

interface Operations extends Azure.ResourceManager.Operations {}

enum ScaleRuleMetricDimensionOperationType {
  Equals,
  NotEquals,
}

enum MonitorDayOfWeek {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum CategoryType {
  Metrics,
  Logs,
}

enum MetricClass {
  Availability,
  Transactions,
  Errors,
  Latency,
  Saturation,
}

enum MetricUnit {
  Count,
  Bytes,
  Seconds,
  CountPerSecond,
  BytesPerSecond,
  Percent,
  MilliSeconds,
  ByteSeconds,
  Unspecified,
  Cores,
  MilliCores,
  NanoCores,
  BitsPerSecond,
}

enum MetricResultType {
  Data,
  Metadata,
}

enum BaselineSensitivity {
  Low,
  Medium,
  High,
}

enum Odatatype {
  `Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria`,
  `Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria`,
  `Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria`,
}

enum Kind {
  LogAlert,
  LogToMetric,
}

enum AlertSeverity {
  `0`: 0,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
}

enum TimeAggregation {
  Count,
  Average,
  Minimum,
  Maximum,
  Total,
}

enum DimensionOperator {
  Include,
  Exclude,
}

enum NamespaceClassification {
  Platform,
  Custom,
  Qos,
}

enum OnboardingStatus {
  onboarded,
  notOnboarded,
  `unknown`,
}

enum DataStatus {
  present,
  notPresent,
}

enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

enum AccessMode {
  Open,
  PrivateOnly,
}

enum KnownPublicNetworkAccessOptions {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

enum KnownDataCollectionEndpointProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

enum KnownLocationSpecProvisioningStatus {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

enum KnownDataCollectionEndpointResourceKind {
  Linux,
  Windows,
}

enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

enum KnownDataCollectionRuleAssociationProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

enum KnownColumnDefinitionType {
  string,
  int,
  long,
  real,
  boolean,
  datetime,
  dynamic,
}

enum KnownPerfCounterDataSourceStreams {
  `Microsoft-Perf`,
  `Microsoft-InsightsMetrics`,
}

enum KnownWindowsEventLogDataSourceStreams {
  `Microsoft-WindowsEvent`,
  `Microsoft-Event`,
}

enum KnownSyslogDataSourceStreams {
  `Microsoft-Syslog`,
}

enum KnownSyslogDataSourceFacilityNames {
  auth,
  authpriv,
  cron,
  daemon,
  kern,
  lpr,
  mail,
  mark,
  news,
  syslog,
  user,
  uucp,
  local0,
  local1,
  local2,
  local3,
  local4,
  local5,
  local6,
  local7,
  Asterisk: "*",
}

enum KnownSyslogDataSourceLogLevels {
  Debug,
  Info,
  Notice,
  Warning,
  Error,
  Critical,
  Alert,
  Emergency,
  Asterisk: "*",
}

enum KnownExtensionDataSourceStreams {
  `Microsoft-Event`,
  `Microsoft-InsightsMetrics`,
  `Microsoft-Perf`,
  `Microsoft-Syslog`,
  `Microsoft-WindowsEvent`,
}

enum KnownLogFilesDataSourceFormat {
  text,
}

enum KnownLogFileTextSettingsRecordStartTimestampFormat {
  `ISO 8601`,
  `YYYY-MM-DD HH:MM:SS`,
  `M/D/YYYY HH:MM:SS AM/PM`,
  `Mon DD, YYYY HH:MM:SS`,
  `yyMMdd HH:mm:ss`,
  `ddMMyy HH:mm:ss`,
  `MMM d hh:mm:ss`,
  `dd/MMM/yyyy:HH:mm:ss zzz`,
  `yyyy-MM-ddTHH:mm:ssK`,
}

enum KnownPrometheusForwarderDataSourceStreams {
  `Microsoft-PrometheusMetrics`,
}

enum KnownDataFlowStreams {
  `Microsoft-Event`,
  `Microsoft-InsightsMetrics`,
  `Microsoft-Perf`,
  `Microsoft-Syslog`,
  `Microsoft-WindowsEvent`,
}

enum KnownDataCollectionRuleProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

enum KnownDataCollectionRuleResourceKind {
  Linux,
  Windows,
}

enum ProvisioningState {
  Creating,
  Succeeded,
  Deleting,
  Failed,
  Canceled,
}

enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

enum Operator {
  Equals,
  GreaterThan,
  GreaterThanOrEqual,
  LessThan,
  LessThanOrEqual,
}

enum CriterionType {
  StaticThresholdCriterion,
  DynamicThresholdCriterion,
}

enum AggregationTypeEnum {
  Average,
  Count,
  Minimum,
  Maximum,
  Total,
}

enum DynamicThresholdOperator {
  GreaterThan,
  LessThan,
  GreaterOrLessThan,
}

enum DynamicThresholdSensitivity {
  Low,
  Medium,
  High,
}
@Azure.Core.fixed
enum MetricStatisticType {
  Average,
  Min,
  Max,
  Sum,
  Count,
}
@Azure.Core.fixed
enum TimeAggregationType {
  Average,
  Minimum,
  Maximum,
  Total,
  Count,
  Last,
}
@Azure.Core.fixed
enum ComparisonOperationType {
  Equals,
  NotEquals,
  GreaterThan,
  GreaterThanOrEqual,
  LessThan,
  LessThanOrEqual,
}
@Azure.Core.fixed
enum ScaleDirection {
  None,
  Increase,
  Decrease,
}
@Azure.Core.fixed
enum ScaleType {
  ChangeCount,
  PercentChangeCount,
  ExactCount,
  ServiceAllowedNextValue,
}
@Azure.Core.fixed
enum RecurrenceFrequency {
  None,
  Second,
  Minute,
  Hour,
  Day,
  Week,
  Month,
  Year,
}
@Azure.Core.fixed
enum PredictiveAutoscalePolicyScaleMode {
  Disabled,
  ForecastOnly,
  Enabled,
}
@Azure.Core.fixed
enum ReceiverStatus {
  NotSpecified,
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum EventLevel {
  Critical,
  Error,
  Warning,
  Informational,
  Verbose,
}
@Azure.Core.fixed
enum AggregationType {
  None,
  Average,
  Count,
  Minimum,
  Maximum,
  Total,
}
@Azure.Core.fixed
enum ResultType {
  Data,
  Metadata,
}
@Azure.Core.fixed
enum Unit {
  Count,
  Bytes,
  Seconds,
  CountPerSecond,
  BytesPerSecond,
  Percent,
  MilliSeconds,
  ByteSeconds,
  Unspecified,
  Cores,
  MilliCores,
  NanoCores,
  BitsPerSecond,
}
@Azure.Core.fixed
enum ConditionOperator {
  GreaterThan,
  GreaterThanOrEqual,
  LessThan,
  LessThanOrEqual,
  Equals,
}
@Azure.Core.fixed
enum TimeAggregationOperator {
  Average,
  Minimum,
  Maximum,
  Total,
  Last,
}

@doc("A setting that contains all of the configuration for the automatic scaling of a resource.")
model AutoscaleSetting {
  @doc("the collection of automatic scaling profiles that specify different scaling parameters for different time periods. A maximum of 20 profiles can be specified.")
  profiles: AutoscaleProfile[];

  @doc("the collection of notifications.")
  notifications?: AutoscaleNotification[];

  @doc("the enabled flag. Specifies whether automatic scaling is enabled for the resource. The default value is 'false'.")
  enabled?: boolean;

  @doc("the predictive autoscale policy mode.")
  predictiveAutoscalePolicy?: PredictiveAutoscalePolicy;

  @doc("the name of the autoscale setting.")
  name?: string;

  @doc("the resource identifier of the resource that the autoscale setting should be added to.")
  targetResourceUri?: string;

  @doc("the location of the resource that the autoscale setting should be added to.")
  targetResourceLocation?: string;
}

@doc("Autoscale profile.")
model AutoscaleProfile {
  @doc("the name of the profile.")
  name: string;

  @doc("the number of instances that can be used during this profile.")
  capacity: ScaleCapacity;

  @doc("the collection of rules that provide the triggers and parameters for the scaling action. A maximum of 10 rules can be specified.")
  rules: ScaleRule[];

  @doc("the specific date-time for the profile. This element is not used if the Recurrence element is used.")
  fixedDate?: TimeWindow;

  @doc("the repeating times at which this profile begins. This element is not used if the FixedDate element is used.")
  recurrence?: Recurrence;
}

@doc("The number of instances that can be used during this profile.")
model ScaleCapacity {
  @doc("the minimum number of instances for the resource.")
  minimum: string;

  @doc("the maximum number of instances for the resource. The actual maximum number of instances is limited by the cores that are available in the subscription.")
  maximum: string;

  @doc("the number of instances that will be set if metrics are not available for evaluation. The default is only used if the current instance count is lower than the default.")
  default: string;
}

@doc("A rule that provide the triggers and parameters for the scaling action.")
model ScaleRule {
  @doc("the trigger that results in a scaling action.")
  metricTrigger: MetricTrigger;

  @doc("the parameters for the scaling action.")
  scaleAction: ScaleAction;
}

@doc("The trigger that results in a scaling action.")
model MetricTrigger {
  @doc("the name of the metric that defines what the rule monitors.")
  metricName: string;

  @doc("the namespace of the metric that defines what the rule monitors.")
  metricNamespace?: string;

  @doc("the resource identifier of the resource the rule monitors.")
  metricResourceUri: string;

  @doc("the location of the resource the rule monitors.")
  metricResourceLocation?: string;

  @doc("the granularity of metrics the rule monitors. Must be one of the predefined values returned from metric definitions for the metric. Must be between 12 hours and 1 minute.")
  timeGrain: duration;

  @doc("the metric statistic type. How the metrics from multiple instances are combined.")
  statistic: MetricStatisticType;

  @doc("the range of time in which instance data is collected. This value must be greater than the delay in metric collection, which can vary from resource-to-resource. Must be between 12 hours and 5 minutes.")
  timeWindow: duration;

  @doc("time aggregation type. How the data that is collected should be combined over time. The default value is Average.")
  timeAggregation: TimeAggregationType;

  @doc("the operator that is used to compare the metric data and the threshold.")
  operator: ComparisonOperationType;

  @doc("the threshold of the metric that triggers the scale action.")
  threshold: float32;

  @doc("List of dimension conditions. For example: [{\"DimensionName\":\"AppName\",\"Operator\":\"Equals\",\"Values\":[\"App1\"]},{\"DimensionName\":\"Deployment\",\"Operator\":\"Equals\",\"Values\":[\"default\"]}].")
  dimensions?: ScaleRuleMetricDimension[];

  @doc("a value indicating whether metric should divide per instance.")
  dividePerInstance?: boolean;
}

@doc("Specifies an auto scale rule metric dimension.")
model ScaleRuleMetricDimension {
  @doc("Name of the dimension.")
  @projectedName("json", "DimensionName")
  dimensionName: string;

  @doc("the dimension operator. Only 'Equals' and 'NotEquals' are supported. 'Equals' being equal to any of the values. 'NotEquals' being not equal to all of the values")
  @projectedName("json", "Operator")
  operator: ScaleRuleMetricDimensionOperationType;

  @doc("list of dimension values. For example: [\"App1\",\"App2\"].")
  @projectedName("json", "Values")
  values: string[];
}

@doc("The parameters for the scaling action.")
model ScaleAction {
  @doc("the scale direction. Whether the scaling action increases or decreases the number of instances.")
  direction: ScaleDirection;

  @doc("the type of action that should occur when the scale rule fires.")
  type: ScaleType;

  @doc("the number of instances that are involved in the scaling action. This value must be 1 or greater. The default value is 1.")
  value?: string;

  @doc("the amount of time to wait since the last scaling action before this action occurs. It must be between 1 week and 1 minute in ISO 8601 format.")
  cooldown: duration;
}

@doc("A specific date-time for the profile.")
model TimeWindow {
  @doc("the timezone of the start and end times for the profile. Some examples of valid time zones are: Dateline Standard Time, UTC-11, Hawaiian Standard Time, Alaskan Standard Time, Pacific Standard Time (Mexico), Pacific Standard Time, US Mountain Standard Time, Mountain Standard Time (Mexico), Mountain Standard Time, Central America Standard Time, Central Standard Time, Central Standard Time (Mexico), Canada Central Standard Time, SA Pacific Standard Time, Eastern Standard Time, US Eastern Standard Time, Venezuela Standard Time, Paraguay Standard Time, Atlantic Standard Time, Central Brazilian Standard Time, SA Western Standard Time, Pacific SA Standard Time, Newfoundland Standard Time, E. South America Standard Time, Argentina Standard Time, SA Eastern Standard Time, Greenland Standard Time, Montevideo Standard Time, Bahia Standard Time, UTC-02, Mid-Atlantic Standard Time, Azores Standard Time, Cape Verde Standard Time, Morocco Standard Time, UTC, GMT Standard Time, Greenwich Standard Time, W. Europe Standard Time, Central Europe Standard Time, Romance Standard Time, Central European Standard Time, W. Central Africa Standard Time, Namibia Standard Time, Jordan Standard Time, GTB Standard Time, Middle East Standard Time, Egypt Standard Time, Syria Standard Time, E. Europe Standard Time, South Africa Standard Time, FLE Standard Time, Turkey Standard Time, Israel Standard Time, Kaliningrad Standard Time, Libya Standard Time, Arabic Standard Time, Arab Standard Time, Belarus Standard Time, Russian Standard Time, E. Africa Standard Time, Iran Standard Time, Arabian Standard Time, Azerbaijan Standard Time, Russia Time Zone 3, Mauritius Standard Time, Georgian Standard Time, Caucasus Standard Time, Afghanistan Standard Time, West Asia Standard Time, Ekaterinburg Standard Time, Pakistan Standard Time, India Standard Time, Sri Lanka Standard Time, Nepal Standard Time, Central Asia Standard Time, Bangladesh Standard Time, N. Central Asia Standard Time, Myanmar Standard Time, SE Asia Standard Time, North Asia Standard Time, China Standard Time, North Asia East Standard Time, Singapore Standard Time, W. Australia Standard Time, Taipei Standard Time, Ulaanbaatar Standard Time, Tokyo Standard Time, Korea Standard Time, Yakutsk Standard Time, Cen. Australia Standard Time, AUS Central Standard Time, E. Australia Standard Time, AUS Eastern Standard Time, West Pacific Standard Time, Tasmania Standard Time, Magadan Standard Time, Vladivostok Standard Time, Russia Time Zone 10, Central Pacific Standard Time, Russia Time Zone 11, New Zealand Standard Time, UTC+12, Fiji Standard Time, Kamchatka Standard Time, Tonga Standard Time, Samoa Standard Time, Line Islands Standard Time")
  timeZone?: string;

  @doc("the start time for the profile in ISO 8601 format.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start: utcDateTime;

  @doc("the end time for the profile in ISO 8601 format.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end: utcDateTime;
}

@doc("The repeating times at which this profile begins. This element is not used if the FixedDate element is used.")
model Recurrence {
  @doc("the recurrence frequency. How often the schedule profile should take effect. This value must be Week, meaning each week will have the same set of profiles. For example, to set a daily schedule, set **schedule** to every day of the week. The frequency property specifies that the schedule is repeated weekly.")
  frequency: RecurrenceFrequency;

  @doc("the scheduling constraints for when the profile begins.")
  schedule: RecurrentSchedule;
}

@doc("The scheduling constraints for when the profile begins.")
model RecurrentSchedule {
  @doc("the timezone for the hours of the profile. Some examples of valid time zones are: Dateline Standard Time, UTC-11, Hawaiian Standard Time, Alaskan Standard Time, Pacific Standard Time (Mexico), Pacific Standard Time, US Mountain Standard Time, Mountain Standard Time (Mexico), Mountain Standard Time, Central America Standard Time, Central Standard Time, Central Standard Time (Mexico), Canada Central Standard Time, SA Pacific Standard Time, Eastern Standard Time, US Eastern Standard Time, Venezuela Standard Time, Paraguay Standard Time, Atlantic Standard Time, Central Brazilian Standard Time, SA Western Standard Time, Pacific SA Standard Time, Newfoundland Standard Time, E. South America Standard Time, Argentina Standard Time, SA Eastern Standard Time, Greenland Standard Time, Montevideo Standard Time, Bahia Standard Time, UTC-02, Mid-Atlantic Standard Time, Azores Standard Time, Cape Verde Standard Time, Morocco Standard Time, UTC, GMT Standard Time, Greenwich Standard Time, W. Europe Standard Time, Central Europe Standard Time, Romance Standard Time, Central European Standard Time, W. Central Africa Standard Time, Namibia Standard Time, Jordan Standard Time, GTB Standard Time, Middle East Standard Time, Egypt Standard Time, Syria Standard Time, E. Europe Standard Time, South Africa Standard Time, FLE Standard Time, Turkey Standard Time, Israel Standard Time, Kaliningrad Standard Time, Libya Standard Time, Arabic Standard Time, Arab Standard Time, Belarus Standard Time, Russian Standard Time, E. Africa Standard Time, Iran Standard Time, Arabian Standard Time, Azerbaijan Standard Time, Russia Time Zone 3, Mauritius Standard Time, Georgian Standard Time, Caucasus Standard Time, Afghanistan Standard Time, West Asia Standard Time, Ekaterinburg Standard Time, Pakistan Standard Time, India Standard Time, Sri Lanka Standard Time, Nepal Standard Time, Central Asia Standard Time, Bangladesh Standard Time, N. Central Asia Standard Time, Myanmar Standard Time, SE Asia Standard Time, North Asia Standard Time, China Standard Time, North Asia East Standard Time, Singapore Standard Time, W. Australia Standard Time, Taipei Standard Time, Ulaanbaatar Standard Time, Tokyo Standard Time, Korea Standard Time, Yakutsk Standard Time, Cen. Australia Standard Time, AUS Central Standard Time, E. Australia Standard Time, AUS Eastern Standard Time, West Pacific Standard Time, Tasmania Standard Time, Magadan Standard Time, Vladivostok Standard Time, Russia Time Zone 10, Central Pacific Standard Time, Russia Time Zone 11, New Zealand Standard Time, UTC+12, Fiji Standard Time, Kamchatka Standard Time, Tonga Standard Time, Samoa Standard Time, Line Islands Standard Time")
  timeZone: string;

  @doc("the collection of days that the profile takes effect on. Possible values are Sunday through Saturday.")
  days: MonitorDayOfWeek[];

  @doc("A collection of hours that the profile takes effect on. Values supported are 0 to 23 on the 24-hour clock (AM/PM times are not supported).")
  hours: int32[];

  @doc("A collection of minutes at which the profile takes effect at.")
  minutes: int32[];
}

@doc("Autoscale notification.")
model AutoscaleNotification {
  @doc("the operation associated with the notification and its value must be \"scale\"")
  operation: "Scale";

  @doc("the email notification.")
  email?: EmailNotification;

  @doc("the collection of webhook notifications.")
  webhooks?: WebhookNotification[];
}

@doc("Email notification of an autoscale event.")
model EmailNotification {
  @doc("a value indicating whether to send email to subscription administrator.")
  sendToSubscriptionAdministrator?: boolean;

  @doc("a value indicating whether to send email to subscription co-administrators.")
  sendToSubscriptionCoAdministrators?: boolean;

  @doc("the custom e-mails list. This value can be null or empty, in which case this attribute will be ignored.")
  customEmails?: string[];
}

@doc("Webhook notification of an autoscale event.")
model WebhookNotification {
  @doc("the service address to receive the notification.")
  serviceUri?: string;

  @doc("a property bag of settings. This value can be empty.")
  properties?: Record<string>;
}

@doc("The parameters for enabling predictive autoscale.")
model PredictiveAutoscalePolicy {
  @doc("the predictive autoscale mode")
  scaleMode: PredictiveAutoscalePolicyScaleMode;

  @doc("the amount of time to specify by which instances are launched in advance. It must be between 1 minute and 60 minutes in ISO 8601 format.")
  scaleLookAheadTime?: duration;
}

@doc("The autoscale setting resource.")
model AutoScaleResource {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Azure resource name")
  @visibility("read")
  name?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("Resource location")
  @visibility("read", "create")
  location: string;

  @doc("Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater in length than 128 characters and a value no greater in length than 256 characters.")
  tags?: Record<string>;

  @doc("The system metadata related to the response.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Describes the format of Error response.")
@error
model AutoscaleErrorResponse {
  @doc("The error object.")
  error?: AutoscaleErrorResponseError;

  @doc("The system metadata related to the response.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The error object.")
model AutoscaleErrorResponseError {
  @doc("One of a server-defined set of error codes.")
  code?: string;

  @doc("A human-readable representation of the error.")
  message?: string;

  @doc("The target of the particular error.")
  target?: string;

  @doc("A human-readable representation of the error's details.")
  details?: string;
}

@doc("The autoscale setting object for patch operations.")
model AutoscaleSettingResourcePatch {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The autoscale setting properties of the update operation.")
  properties?: AutoscaleSetting;
}

@doc("The response to a metrics query.")
model PredictiveResponse {
  @doc("The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.")
  timespan?: string;

  @doc("The interval (window size) for which the metric data was returned in.  This may be adjusted in the future and returned back from what was originally requested.  This is not present if a metadata request was made.")
  interval?: duration;

  @doc("The metrics being queried")
  metricName?: string;

  @doc("resource of the predictive metric.")
  targetResourceId?: string;

  @doc("the value of the collection.")
  data?: PredictiveValue[];
}

@doc("Represents a predictive metric value in the given bucket.")
model PredictiveValue {
  @doc("the timestamp for the metric value in ISO 8601 format.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp: utcDateTime;

  @doc("Predictive value in this time bucket.")
  value: float32;
}

@doc("An alert incident indicates the activation status of an alert rule.")
model Incident {
  @doc("Incident name.")
  @visibility("read")
  name?: string;

  @doc("Rule name that is associated with the incident.")
  @visibility("read")
  ruleName?: string;

  @doc("A boolean to indicate whether the incident is active or resolved.")
  @visibility("read")
  isActive?: boolean;

  @doc("The time at which the incident was activated in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activatedTime?: utcDateTime;

  @doc("The time at which the incident was resolved in ISO8601 format. If null, it means the incident is still active.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resolvedTime?: utcDateTime;
}

@doc("The List incidents operation response.")
@pagedResult
model IncidentListResult {
  @doc("the incident collection.")
  @items
  value?: Incident[];
}

@doc("An alert rule.")
model AlertRule {
  @doc("the name of the alert rule.")
  name: string;

  @doc("the description of the alert rule that will be included in the alert email.")
  description?: string;

  @doc("the provisioning state.")
  provisioningState?: string;

  @doc("the flag that indicates whether the alert rule is enabled.")
  isEnabled: boolean;

  @doc("the condition that results in the alert rule being activated.")
  condition: RuleCondition;

  @doc("action that is performed when the alert rule becomes active, and when an alert condition is resolved.")
  action?: RuleAction;

  @doc("the array of actions that are performed when the alert rule becomes active, and when an alert condition is resolved.")
  actions?: RuleAction[];

  @doc("Last time the rule was updated in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;
}

@doc("The condition that results in the alert rule being activated.")
@discriminator("odata.type")
model RuleCondition {
  @doc("the resource from which the rule collects its data. For this type dataSource will always be of type RuleMetricDataSource.")
  dataSource?: RuleDataSource;
}

@doc("The resource from which the rule collects its data.")
@discriminator("odata.type")
model RuleDataSource {
  @doc("the resource identifier of the resource the rule monitors. **NOTE**: this property cannot be updated for an existing rule.")
  resourceUri?: string;

  @doc("the legacy resource identifier of the resource the rule monitors. **NOTE**: this property cannot be updated for an existing rule.")
  legacyResourceId?: string;

  @doc("the location of the resource.")
  resourceLocation?: string;

  @doc("the namespace of the metric.")
  metricNamespace?: string;
}

@doc("The action that is performed when the alert rule becomes active, and when an alert condition is resolved.")
@discriminator("odata.type")
model RuleAction {}

@doc("An azure resource object")
model Resource {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Azure resource name")
  @visibility("read")
  name?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("Resource location")
  @visibility("read", "create")
  location: string;

  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("The alert rule object for patch operations.")
model AlertRuleResourcePatch {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The properties of an alert rule.")
  properties?: AlertRule;
}

@doc("The log profile properties.")
model LogProfileProperties {
  @doc("the resource id of the storage account to which you would like to send the Activity Log.")
  storageAccountId?: string;

  @doc("The service bus rule ID of the service bus namespace in which you would like to have Event Hubs created for streaming the Activity Log. The rule ID is of the format: '{service bus resource ID}/authorizationrules/{key name}'.")
  serviceBusRuleId?: string;

  @doc("List of regions for which Activity Log events should be stored or streamed. It is a comma separated list of valid ARM locations including the 'global' location.")
  locations: string[];

  @doc("the categories of the logs. These categories are created as is convenient to the user. Some values are: 'Write', 'Delete', and/or 'Action.'")
  categories: string[];

  @doc("the retention policy for the events in the log.")
  retentionPolicy: RetentionPolicy;
}

@doc("Specifies the retention policy for the log.")
model RetentionPolicy {
  @doc("a value indicating whether the retention policy is enabled.")
  enabled: boolean;

  @doc("the number of days for the retention in days. A value of 0 will retain the events indefinitely.")
  days: int32;
}

@doc("The log profile resource for patch operations.")
model LogProfileResourcePatch {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The log profile properties for an update operation.")
  properties?: LogProfileProperties;
}

@doc("The diagnostic settings.")
model DiagnosticSettings {
  @doc("The resource ID of the storage account to which you would like to send Diagnostic Logs.")
  storageAccountId?: string;

  @doc("The service bus rule Id of the diagnostic setting. This is here to maintain backwards compatibility.")
  serviceBusRuleId?: string;

  @doc("The resource Id for the event hub authorization rule.")
  eventHubAuthorizationRuleId?: string;

  @doc("The name of the event hub. If none is specified, the default event hub will be selected.")
  eventHubName?: string;

  @doc("The list of metric settings.")
  metrics?: MetricSettings[];

  @doc("The list of logs settings.")
  logs?: LogSettings[];

  @doc("The full ARM resource ID of the Log Analytics workspace to which you would like to send Diagnostic Logs. Example: /subscriptions/4b9e8510-67ab-4e9a-95a9-e2f1e570ea9c/resourceGroups/insights-integration/providers/Microsoft.OperationalInsights/workspaces/viruela2")
  workspaceId?: string;

  @doc("The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.")
  marketplacePartnerId?: string;

  @doc("A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type constructed as follows: <normalized service identity>_<normalized category name>. Possible values are: Dedicated and null (null is default.)")
  logAnalyticsDestinationType?: string;
}

@doc("Part of MultiTenantDiagnosticSettings. Specifies the settings for a particular metric.")
model MetricSettings {
  @doc("the timegrain of the metric in ISO8601 format.")
  timeGrain?: duration;

  @doc("Name of a Diagnostic Metric category for a resource type this setting is applied to. To obtain the list of Diagnostic metric categories for a resource, first perform a GET diagnostic settings operation.")
  category?: string;

  @doc("a value indicating whether this category is enabled.")
  enabled: boolean;

  @doc("the retention policy for this category.")
  retentionPolicy?: RetentionPolicy;
}

@doc("Part of MultiTenantDiagnosticSettings. Specifies the settings for a particular log.")
model LogSettings {
  @doc("Name of a Diagnostic Log category for a resource type this setting is applied to. To obtain the list of Diagnostic Log categories for a resource, first perform a GET diagnostic settings operation.")
  category?: string;

  @doc("Name of a Diagnostic Log category group for a resource type this setting is applied to. To obtain the list of Diagnostic Log categories for a resource, first perform a GET diagnostic settings operation.")
  categoryGroup?: string;

  @doc("a value indicating whether this log is enabled.")
  enabled: boolean;

  @doc("the retention policy for this log.")
  retentionPolicy?: RetentionPolicy;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model CommonResource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("The diagnostic settings Category.")
model DiagnosticSettingsCategory {
  @doc("The type of the diagnostic settings category.")
  categoryType?: CategoryType;

  @doc("the collection of what category groups are supported.")
  categoryGroups?: string[];
}

@doc("An Azure action group.")
model ActionGroup {
  @doc("The short name of the action group. This will be used in SMS messages.")
  @maxLength(12)
  groupShortName: string;

  @doc("Indicates whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications.")
  enabled: boolean;

  @doc("The list of email receivers that are part of this action group.")
  emailReceivers?: EmailReceiver[];

  @doc("The list of SMS receivers that are part of this action group.")
  smsReceivers?: SmsReceiver[];

  @doc("The list of webhook receivers that are part of this action group.")
  webhookReceivers?: WebhookReceiver[];

  @doc("The list of ITSM receivers that are part of this action group.")
  itsmReceivers?: ItsmReceiver[];

  @doc("The list of AzureAppPush receivers that are part of this action group.")
  azureAppPushReceivers?: AzureAppPushReceiver[];

  @doc("The list of AutomationRunbook receivers that are part of this action group.")
  automationRunbookReceivers?: AutomationRunbookReceiver[];

  @doc("The list of voice receivers that are part of this action group.")
  voiceReceivers?: VoiceReceiver[];

  @doc("The list of logic app receivers that are part of this action group.")
  logicAppReceivers?: LogicAppReceiver[];

  @doc("The list of azure function receivers that are part of this action group.")
  azureFunctionReceivers?: AzureFunctionReceiver[];

  @doc("The list of ARM role receivers that are part of this action group. Roles are Azure RBAC roles and only built-in roles are supported.")
  armRoleReceivers?: ArmRoleReceiver[];

  @doc("The list of event hub receivers that are part of this action group.")
  eventHubReceivers?: EventHubReceiver[];
}

@doc("An email receiver.")
model EmailReceiver {
  @doc("The name of the email receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("The email address of this receiver.")
  emailAddress: string;

  @doc("Indicates whether to use common alert schema.")
  useCommonAlertSchema?: boolean;

  @doc("The receiver status of the e-mail.")
  @visibility("read")
  status?: ReceiverStatus;
}

@doc("An SMS receiver.")
model SmsReceiver {
  @doc("The name of the SMS receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("The country code of the SMS receiver.")
  countryCode: string;

  @doc("The phone number of the SMS receiver.")
  phoneNumber: string;

  @doc("The status of the receiver.")
  @visibility("read")
  status?: ReceiverStatus;
}

@doc("A webhook receiver.")
model WebhookReceiver {
  @doc("The name of the webhook receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("The URI where webhooks should be sent.")
  serviceUri: string;

  @doc("Indicates whether to use common alert schema.")
  useCommonAlertSchema?: boolean;

  @doc("Indicates whether or not use AAD authentication.")
  useAadAuth?: boolean;

  @doc("Indicates the webhook app object Id for aad auth.")
  objectId?: string;

  @doc("Indicates the identifier uri for aad auth.")
  identifierUri?: string;

  @doc("Indicates the tenant id for aad auth.")
  tenantId?: string;
}

@doc("An Itsm receiver.")
model ItsmReceiver {
  @doc("The name of the Itsm receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("OMS LA instance identifier.")
  workspaceId: string;

  @doc("Unique identification of ITSM connection among multiple defined in above workspace.")
  connectionId: string;

  @doc("JSON blob for the configurations of the ITSM action. CreateMultipleWorkItems option will be part of this blob as well.")
  ticketConfiguration: string;

  @doc("Region in which workspace resides. Supported values:'centralindia','japaneast','southeastasia','australiasoutheast','uksouth','westcentralus','canadacentral','eastus','westeurope'")
  region: string;
}

@doc("The Azure mobile App push notification receiver.")
model AzureAppPushReceiver {
  @doc("The name of the Azure mobile app push receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("The email address registered for the Azure mobile app.")
  emailAddress: string;
}

@doc("The Azure Automation Runbook notification receiver.")
model AutomationRunbookReceiver {
  @doc("The Azure automation account Id which holds this runbook and authenticate to Azure resource.")
  automationAccountId: string;

  @doc("The name for this runbook.")
  runbookName: string;

  @doc("The resource id for webhook linked to this runbook.")
  webhookResourceId: string;

  @doc("Indicates whether this instance is global runbook.")
  isGlobalRunbook: boolean;

  @doc("Indicates name of the webhook.")
  name?: string;

  @doc("The URI where webhooks should be sent.")
  serviceUri?: string;

  @doc("Indicates whether to use common alert schema.")
  useCommonAlertSchema?: boolean;
}

@doc("A voice receiver.")
model VoiceReceiver {
  @doc("The name of the voice receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("The country code of the voice receiver.")
  countryCode: string;

  @doc("The phone number of the voice receiver.")
  phoneNumber: string;
}

@doc("A logic app receiver.")
model LogicAppReceiver {
  @doc("The name of the logic app receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("The azure resource id of the logic app receiver.")
  resourceId: string;

  @doc("The callback url where http request sent to.")
  callbackUrl: string;

  @doc("Indicates whether to use common alert schema.")
  useCommonAlertSchema?: boolean;
}

@doc("An azure function receiver.")
model AzureFunctionReceiver {
  @doc("The name of the azure function receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("The azure resource id of the function app.")
  functionAppResourceId: string;

  @doc("The function name in the function app.")
  functionName: string;

  @doc("The http trigger url where http request sent to.")
  httpTriggerUrl: string;

  @doc("Indicates whether to use common alert schema.")
  useCommonAlertSchema?: boolean;
}

@doc("An arm role receiver.")
model ArmRoleReceiver {
  @doc("The name of the arm role receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("The arm role id.")
  roleId: string;

  @doc("Indicates whether to use common alert schema.")
  useCommonAlertSchema?: boolean;
}

@doc("An Event hub receiver.")
model EventHubReceiver {
  @doc("The name of the Event hub receiver. Names must be unique across all receivers within an action group.")
  name: string;

  @doc("The Event Hub namespace")
  eventHubNameSpace: string;

  @doc("The name of the specific Event Hub queue")
  eventHubName: string;

  @doc("Indicates whether to use common alert schema.")
  useCommonAlertSchema?: boolean;

  @doc("The tenant Id for the subscription containing this event hub")
  tenantId?: string;

  @doc("The Id for the subscription containing this event hub")
  subscriptionId: string;
}

@doc("An azure resource object")
model AzureResource {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Azure resource name")
  @visibility("read")
  name?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("Resource location")
  @visibility("read", "create")
  location: string;

  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("An action group object for the body of patch operations.")
model ActionGroupPatchBody {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The action group settings for an update operation.")
  properties?: ActionGroupPatch;
}

@doc("An Azure action group for patch operations.")
model ActionGroupPatch {
  @doc("Indicates whether this action group is enabled. If an action group is not enabled, then none of its actions will be activated.")
  enabled?: boolean;
}

@doc("The request body which contain contact detail metadata")
model NotificationRequestBody {
  @doc("The value of the supported alert type. Supported alert type values are: servicehealth, metricstaticthreshold, metricsdynamicthreshold, logalertv2, smartalert, webtestalert, logalertv1numresult, logalertv1metricmeasurement, resourcehealth, activitylog, actualcostbudget, forecastedbudget")
  @maxLength(30)
  alertType: string;

  @doc("The list of email receivers that are part of this action group.")
  emailReceivers?: EmailReceiver[];

  @doc("The list of SMS receivers that are part of this action group.")
  smsReceivers?: SmsReceiver[];

  @doc("The list of webhook receivers that are part of this action group.")
  webhookReceivers?: WebhookReceiver[];

  @doc("The list of ITSM receivers that are part of this action group.")
  itsmReceivers?: ItsmReceiver[];

  @doc("The list of AzureAppPush receivers that are part of this action group.")
  azureAppPushReceivers?: AzureAppPushReceiver[];

  @doc("The list of AutomationRunbook receivers that are part of this action group.")
  automationRunbookReceivers?: AutomationRunbookReceiver[];

  @doc("The list of voice receivers that are part of this action group.")
  voiceReceivers?: VoiceReceiver[];

  @doc("The list of logic app receivers that are part of this action group.")
  logicAppReceivers?: LogicAppReceiver[];

  @doc("The list of azure function receivers that are part of this action group.")
  azureFunctionReceivers?: AzureFunctionReceiver[];

  @doc("The list of ARM role receivers that are part of this action group. Roles are Azure RBAC roles and only built-in roles are supported.")
  armRoleReceivers?: ArmRoleReceiver[];

  @doc("The list of event hub receivers that are part of this action group.")
  eventHubReceivers?: EventHubReceiver[];
}

@doc("The details of the test notification results.")
model TestNotificationDetailsResponse {
  @doc("The context info")
  context?: Context;

  @doc("The overall state")
  state: string;

  @doc("The completed time")
  completedTime?: string;

  @doc("The created time")
  createdTime?: string;

  @doc("The list of action detail")
  actionDetails?: ActionDetail[];
}

@doc("The context info")
model Context {
  @doc("The source of the notification request")
  notificationSource?: string;

  @doc("The context id type")
  contextType?: string;
}

@doc("The action detail")
model ActionDetail {
  @doc("The mechanism type")
  @projectedName("json", "MechanismType")
  mechanismType?: string;

  @doc("The name of the action")
  @projectedName("json", "Name")
  name?: string;

  @doc("The status of the action")
  @projectedName("json", "Status")
  status?: string;

  @doc("The substatus of the action")
  @projectedName("json", "SubState")
  subState?: string;

  @doc("The send time")
  @projectedName("json", "SendTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sendTime?: utcDateTime;

  @doc("The detail of the friendly error message")
  @projectedName("json", "Detail")
  detail?: string;
}

@doc("Describes a receiver that should be resubscribed.")
model EnableRequest {
  @doc("The name of the receiver to resubscribe.")
  receiverName: string;
}

@doc("Represents collection of events.")
model EventDataCollection is Azure.Core.Page<EventData>;

@doc("The Azure event log entries are of type EventData")
model EventData {
  @doc("The sender authorization information.")
  @visibility("read")
  authorization?: SenderAuthorization;

  @doc("key value pairs to identify ARM permissions.")
  @visibility("read")
  claims?: Record<string>;

  @doc("the email address of the user who has performed the operation, the UPN claim or SPN claim based on availability.")
  @visibility("read")
  caller?: string;

  @doc("the description of the event.")
  @visibility("read")
  description?: string;

  @doc("the Id of this event as required by ARM for RBAC. It contains the EventDataID and a timestamp information.")
  @visibility("read")
  id?: string;

  @doc("the event data Id. This is a unique identifier for an event.")
  @visibility("read")
  eventDataId?: string;

  @doc("the correlation Id, usually a GUID in the string format. The correlation Id is shared among the events that belong to the same uber operation.")
  @visibility("read")
  correlationId?: string;

  @doc("the event name. This value should not be confused with OperationName. For practical purposes, OperationName might be more appealing to end users.")
  @visibility("read")
  eventName?: LocalizableString;

  @doc("the event category.")
  @visibility("read")
  category?: LocalizableString;

  @doc("the HTTP request info. Usually includes the 'clientRequestId', 'clientIpAddress' (IP address of the user who initiated the event) and 'method' (HTTP method e.g. PUT).")
  @visibility("read")
  httpRequest?: HttpRequestInfo;

  @doc("the event level")
  @visibility("read")
  level?: EventLevel;

  @doc("the resource group name of the impacted resource.")
  @visibility("read")
  resourceGroupName?: string;

  @doc("the resource provider name of the impacted resource.")
  @visibility("read")
  resourceProviderName?: LocalizableString;

  @doc("the resource uri that uniquely identifies the resource that caused this event.")
  @visibility("read")
  resourceId?: string;

  @doc("the resource type")
  @visibility("read")
  resourceType?: LocalizableString;

  @doc("It is usually a GUID shared among the events corresponding to single operation. This value should not be confused with EventName.")
  @visibility("read")
  operationId?: string;

  @doc("the operation name.")
  @visibility("read")
  operationName?: LocalizableString;

  @doc("the set of <Key, Value> pairs (usually a Dictionary<String, String>) that includes details about the event.")
  @visibility("read")
  properties?: Record<string>;

  @doc("a string describing the status of the operation. Some typical values are: Started, In progress, Succeeded, Failed, Resolved.")
  @visibility("read")
  status?: LocalizableString;

  @doc("the event sub status. Most of the time, when included, this captures the HTTP status code of the REST call. Common values are: OK (HTTP Status Code: 200), Created (HTTP Status Code: 201), Accepted (HTTP Status Code: 202), No Content (HTTP Status Code: 204), Bad Request(HTTP Status Code: 400), Not Found (HTTP Status Code: 404), Conflict (HTTP Status Code: 409), Internal Server Error (HTTP Status Code: 500), Service Unavailable (HTTP Status Code:503), Gateway Timeout (HTTP Status Code: 504)")
  @visibility("read")
  subStatus?: LocalizableString;

  @doc("the timestamp of when the event was generated by the Azure service processing the request corresponding the event. It in ISO 8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTimestamp?: utcDateTime;

  @doc("the timestamp of when the event became available for querying via this API. It is in ISO 8601 format. This value should not be confused eventTimestamp. As there might be a delay between the occurrence time of the event, and the time that the event is submitted to the Azure logging infrastructure.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submissionTimestamp?: utcDateTime;

  @doc("the Azure subscription Id usually a GUID.")
  @visibility("read")
  subscriptionId?: string;

  @doc("the Azure tenant Id")
  @visibility("read")
  tenantId?: string;
}

@doc("the authorization used by the user who has performed the operation that led to this event. This captures the RBAC properties of the event. These usually include the 'action', 'role' and the 'scope'")
model SenderAuthorization {
  @doc("the permissible actions. For instance: microsoft.support/supporttickets/write")
  action?: string;

  @doc("the role of the user. For instance: Subscription Admin")
  role?: string;

  @doc("the scope.")
  scope?: string;
}

@doc("The localizable string class.")
model LocalizableString {
  @doc("the invariant value.")
  value: string;

  @doc("the locale specific value.")
  localizedValue?: string;
}

@doc("The Http request info.")
model HttpRequestInfo {
  @doc("the client request id.")
  clientRequestId?: string;

  @doc("the client Ip Address")
  clientIpAddress?: string;

  @doc("the Http request method.")
  method?: string;

  @doc("the Uri.")
  uri?: string;
}

@doc("A collection of event categories. Currently possible values are: Administrative, Security, ServiceHealth, Alert, Recommendation, Policy.")
@pagedResult
model EventCategoryCollection {
  @doc("the list that includes the Azure event categories.")
  @items
  value: LocalizableString[];
}

@doc("Represents collection of metric definitions.")
@pagedResult
model MetricDefinitionCollection {
  @doc("the values for the metric definitions.")
  @items
  value: MetricDefinition[];
}

@doc("Metric definition class specifies the metadata for a metric.")
model MetricDefinition {
  @doc("Flag to indicate whether the dimension is required.")
  isDimensionRequired?: boolean;

  @doc("the resource identifier of the resource that emitted the metric.")
  resourceId?: string;

  @doc("the namespace the metric belongs to.")
  `namespace`?: string;

  @doc("the name and the display name of the metric, i.e. it is a localizable string.")
  name?: LocalizableString;

  @doc("Detailed description of this metric.")
  displayDescription?: string;

  @doc("Custom category name for this metric.")
  category?: string;

  @doc("The class of the metric.")
  metricClass?: MetricClass;

  @doc("The unit of the metric.")
  unit?: MetricUnit;

  @doc("the primary aggregation type value defining how to use the values for display.")
  primaryAggregationType?: AggregationType;

  @doc("the collection of what aggregation types are supported.")
  supportedAggregationTypes?: AggregationType[];

  @doc("the collection of what aggregation intervals are available to be queried.")
  metricAvailabilities?: MetricAvailability[];

  @doc("the resource identifier of the metric definition.")
  id?: string;

  @doc("the name and the display name of the dimension, i.e. it is a localizable string.")
  dimensions?: LocalizableString[];
}

@doc("Metric availability specifies the time grain (aggregation interval or frequency) and the retention period for that time grain.")
model MetricAvailability {
  @doc("the time grain specifies the aggregation interval for the metric. Expressed as a duration 'PT1M', 'P1D', etc.")
  timeGrain?: duration;

  @doc("the retention period for the metric at the specified timegrain.  Expressed as a duration 'PT1M', 'P1D', etc.")
  retention?: duration;
}

@doc("The response to a subscription scope metrics query.")
model SubscriptionScopeMetricResponse {
  @doc("The integer value representing the relative cost of the query.")
  cost?: int32;

  @doc("The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.")
  timespan: string;

  @doc("The interval (window size) for which the metric data was returned in.  This may be adjusted in the future and returned back from what was originally requested.  This is not present if a metadata request was made.")
  interval?: duration;

  @doc("The namespace of the metrics being queried")
  `namespace`?: string;

  @doc("The region of the resource being queried for metrics.")
  resourceregion?: string;

  @doc("the value of the collection.")
  value: SubscriptionScopeMetric[];
}

@doc("The result data of a query.")
model SubscriptionScopeMetric {
  @doc("the metric Id.")
  id: string;

  @doc("the resource type of the metric resource.")
  type: string;

  @doc("the name and the display name of the metric, i.e. it is localizable string.")
  name: LocalizableString;

  @doc("Detailed description of this metric.")
  displayDescription?: string;

  @doc("'Success' or the error details on query failures for this metric.")
  errorCode?: string;

  @doc("Error message encountered querying this specific metric.")
  errorMessage?: string;

  @doc("The unit of the metric.")
  unit: MetricUnit;

  @doc("the time series returned when a data query is performed.")
  timeseries: TimeSeriesElement[];
}

@doc("A time series result type. The discriminator value is always TimeSeries in this case.")
model TimeSeriesElement {
  @doc("the metadata values returned if $filter was specified in the call.")
  metadatavalues?: MetadataValue[];

  @doc("An array of data points representing the metric values.  This is only returned if a result type of data is specified.")
  data?: MetricValue[];
}

@doc("Represents a metric metadata value.")
model MetadataValue {
  @doc("the name of the metadata.")
  name?: LocalizableString;

  @doc("the value of the metadata.")
  value?: string;
}

@doc("Represents a metric value.")
model MetricValue {
  @doc("the timestamp for the metric value in ISO 8601 format.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp: utcDateTime;

  @doc("the average value in the time range.")
  average?: float32;

  @doc("the least value in the time range.")
  minimum?: float32;

  @doc("the greatest value in the time range.")
  maximum?: float32;

  @doc("the sum of all of the values in the time range.")
  total?: float32;

  @doc("the number of samples in the time range. Can be used to determine the number of values that contributed to the average value.")
  count?: float32;
}

@doc("Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)")
@error
model CommonErrorContract {
  @doc("The error object.")
  error?: ErrorResponse;
}

@doc("Query parameters can also be specified in the body, specifying the same parameter in both the body and query parameters will result in an error.")
model SubscriptionScopeMetricsRequestBodyParameters {
  @doc("The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.")
  timespan?: plainTime;

  @doc("The interval (i.e. timegrain) of the query.")
  interval?: duration;

  @doc("The names of the metrics (comma separated) to retrieve.")
  metricNames?: string;

  @doc("The list of aggregation types (comma separated) to retrieve.")
  aggregation?: string;

  @doc("The **$filter** is used to reduce the set of metric data returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all time series of C where A = a1 and B = b1 or b2<br>**$filter=A eq ‘a1’ and B eq ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical or operator cannot separate two different metadata names.<br>- Return all time series where A = a1, B = b1 and C = c1:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘c1’**<br>- Return all time series where A = a1<br>**$filter=A eq ‘a1’ and B eq ‘*’ and C eq ‘*’**.")
  filter?: string;

  @doc("""
The maximum number of records to retrieve.
Valid only if $filter is specified.
Defaults to 10.
""")
  top?: int32;

  @doc("""
The aggregation to use for sorting results and the direction of the sort.
Only one order can be specified.
Examples: sum asc.
""")
  orderBy?: string;

  @doc("Dimension name(s) to rollup results by. For example if you only want to see metric values with a filter like 'City eq Seattle or City eq Tacoma' but don't want to see separate values for each city, you can specify 'RollUpBy=City' to see the results for Seattle and Tacoma rolled up into one timeseries.")
  rollUpBy?: string;

  @doc("Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.")
  resultType?: MetricResultType;

  @doc("Metric namespace where the metrics you want reside.")
  metricNamespace?: string;

  @doc("When set to true, if the timespan passed in is not supported by this metric, the API will return the result using the closest supported timespan. When set to false, an error is returned for invalid timespan parameters. Defaults to false.")
  autoAdjustTimegrain?: boolean;

  @doc("When set to false, invalid filter parameter values will be ignored. When set to true, an error is returned for invalid filter parameters. Defaults to true.")
  validateDimensions?: boolean;
}

@doc("The response to a metrics query.")
model Response {
  @doc("The integer value representing the relative cost of the query.")
  cost?: int32;

  @doc("The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.")
  timespan: string;

  @doc("The interval (window size) for which the metric data was returned in.  This may be adjusted in the future and returned back from what was originally requested.  This is not present if a metadata request was made.")
  interval?: duration;

  @doc("The namespace of the metrics being queried")
  `namespace`?: string;

  @doc("The region of the resource being queried for metrics.")
  resourceregion?: string;

  @doc("the value of the collection.")
  value: Metric[];
}

@doc("The result data of a query.")
model Metric {
  @doc("the metric Id.")
  id: string;

  @doc("the resource type of the metric resource.")
  type: string;

  @doc("the name and the display name of the metric, i.e. it is localizable string.")
  name: LocalizableString;

  @doc("Detailed description of this metric.")
  displayDescription?: string;

  @doc("'Success' or the error details on query failures for this metric.")
  errorCode?: string;

  @doc("Error message encountered querying this specific metric.")
  errorMessage?: string;

  @doc("The unit of the metric.")
  unit: Unit;

  @doc("the time series returned when a data query is performed.")
  timeseries: TimeSeriesElement[];
}

@doc("A list of metric baselines.")
@pagedResult
model MetricBaselinesResponse {
  @doc("The list of metric baselines.")
  @items
  value?: SingleMetricBaseline[];
}

@doc("The baseline results of a single metric.")
model SingleMetricBaseline {
  @doc("The metric baseline Id.")
  id: string;

  @doc("The resource type of the metric baseline resource.")
  type: string;

  @doc("The name of the metric for which the baselines were retrieved.")
  name: string;

  @doc("The metric baseline properties of the metric.")
  properties: MetricBaselinesProperties;
}

@doc("The response to a metric baselines query.")
model MetricBaselinesProperties {
  @doc("The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.")
  timespan: string;

  @doc("The interval (window size) for which the metric data was returned in.  This may be adjusted in the future and returned back from what was originally requested.  This is not present if a metadata request was made.")
  interval: duration;

  @doc("The namespace of the metrics been queried.")
  `namespace`?: string;

  @doc("The baseline for each time series that was queried.")
  baselines: TimeSeriesBaseline[];
}

@doc("The baseline values for a single time series.")
model TimeSeriesBaseline {
  @doc("The aggregation type of the metric.")
  aggregation: string;

  @doc("The dimensions of this time series.")
  dimensions?: MetricSingleDimension[];

  @doc("The list of timestamps of the baselines.")
  timestamps: utcDateTime[];

  @doc("The baseline values for each sensitivity.")
  data: SingleBaseline[];

  @doc("The baseline metadata values.")
  metadataValues?: BaselineMetadata[];
}

@doc("The metric dimension name and value.")
model MetricSingleDimension {
  @doc("Name of the dimension.")
  name: string;

  @doc("Value of the dimension.")
  value: string;
}

@doc("The baseline values for a single sensitivity value.")
model SingleBaseline {
  @doc("the sensitivity of the baseline.")
  sensitivity: BaselineSensitivity;

  @doc("The low thresholds of the baseline.")
  lowThresholds: float32[];

  @doc("The high thresholds of the baseline.")
  highThresholds: float32[];
}

@doc("Represents a baseline metadata value.")
model BaselineMetadata {
  @doc("Name of the baseline metadata.")
  name: string;

  @doc("Value of the baseline metadata.")
  value: string;
}

@doc("An alert rule.")
model MetricAlertProperties {
  @doc("the description of the metric alert that will be included in the alert email.")
  description?: string;

  @doc("Alert severity {0, 1, 2, 3, 4}")
  severity: int32;

  @doc("the flag that indicates whether the metric alert is enabled.")
  enabled: boolean;

  @doc("the list of resource id's that this metric alert is scoped to.")
  scopes: string[];

  @doc("how often the metric alert is evaluated represented in ISO 8601 duration format.")
  evaluationFrequency: duration;

  @doc("the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.")
  windowSize: duration;

  @doc("the resource type of the target resource(s) on which the alert is created/updated. Mandatory if the scope contains a subscription, resource group, or more than one resource.")
  targetResourceType?: string;

  @doc("the region of the target resource(s) on which the alert is created/updated. Mandatory if the scope contains a subscription, resource group, or more than one resource.")
  targetResourceRegion?: string;

  @doc("defines the specific alert criteria information.")
  criteria: MetricAlertCriteria;

  @doc("the flag that indicates whether the alert should be auto resolved or not. The default is true.")
  autoMitigate?: boolean;

  @doc("the array of actions that are performed when the alert rule becomes active, and when an alert condition is resolved.")
  actions?: MetricAlertAction[];

  @doc("Last time the rule was updated in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  @doc("the value indicating whether this alert rule is migrated.")
  @visibility("read")
  isMigrated?: boolean;
}

@doc("The rule criteria that defines the conditions of the alert rule.")
@discriminator("odata.type")
model MetricAlertCriteria extends Record<Record<unknown>> {}

@doc("An alert action.")
model MetricAlertAction {
  @doc("the id of the action group to use.")
  actionGroupId?: string;

  @doc("This field allows specifying custom properties, which would be appended to the alert payload sent as input to the webhook.")
  webHookProperties?: Record<string>;
}

@doc("The metric alert resource for patch operations.")
model MetricAlertResourcePatch {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The alert rule properties of the resource.")
  properties?: MetricAlertPropertiesPatch;
}

@doc("An alert rule properties for patch.")
model MetricAlertPropertiesPatch {
  @doc("the description of the metric alert that will be included in the alert email.")
  description?: string;

  @doc("Alert severity {0, 1, 2, 3, 4}")
  severity?: int32;

  @doc("the flag that indicates whether the metric alert is enabled.")
  enabled?: boolean;

  @doc("the list of resource id's that this metric alert is scoped to.")
  scopes?: string[];

  @doc("how often the metric alert is evaluated represented in ISO 8601 duration format.")
  evaluationFrequency?: duration;

  @doc("the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.")
  windowSize?: duration;

  @doc("the resource type of the target resource(s) on which the alert is created/updated. Mandatory for MultipleResourceMultipleMetricCriteria.")
  targetResourceType?: string;

  @doc("the region of the target resource(s) on which the alert is created/updated. Mandatory for MultipleResourceMultipleMetricCriteria.")
  targetResourceRegion?: string;

  @doc("defines the specific alert criteria information.")
  criteria?: MetricAlertCriteria;

  @doc("the flag that indicates whether the alert should be auto resolved or not. The default is true.")
  autoMitigate?: boolean;

  @doc("the array of actions that are performed when the alert rule becomes active, and when an alert condition is resolved.")
  actions?: MetricAlertAction[];

  @doc("Last time the rule was updated in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  @doc("the value indicating whether this alert rule is migrated.")
  @visibility("read")
  isMigrated?: boolean;
}

@doc("Represents a collection of alert rule resources.")
model MetricAlertStatusCollection {
  @doc("the values for the alert rule resources.")
  value?: MetricAlertStatus[];
}

@doc("An alert status.")
model MetricAlertStatus {
  @doc("The status name.")
  name?: string;

  @doc("The alert rule arm id.")
  id?: string;

  @doc("The extended resource type name.")
  type?: string;

  @doc("The alert status properties of the metric alert status.")
  properties?: MetricAlertStatusProperties;
}

@doc("An alert status properties.")
model MetricAlertStatusProperties {
  @doc("An object describing the type of the dimensions.")
  dimensions?: Record<string>;

  @doc("status value")
  status?: string;

  @doc("UTC time when the status was checked.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;
}

@doc("scheduled query rule Definition")
model ScheduledQueryRuleProperties {
  @doc("The api-version used when creating this alert rule")
  @visibility("read")
  createdWithApiVersion?: string;

  @doc("True if alert rule is legacy Log Analytic rule")
  @visibility("read")
  isLegacyLogAnalyticsRule?: boolean;

  @doc("The description of the scheduled query rule.")
  description?: string;

  @doc("The display name of the alert rule")
  displayName?: string;

  @doc("Severity of the alert. Should be an integer between [0-4]. Value of 0 is severest. Relevant and required only for rules of the kind LogAlert.")
  severity?: AlertSeverity;

  @doc("The flag which indicates whether this scheduled query rule is enabled. Value should be true or false")
  enabled?: boolean;

  @doc("The list of resource id's that this scheduled query rule is scoped to.")
  scopes?: string[];

  @doc("How often the scheduled query rule is evaluated represented in ISO 8601 duration format. Relevant and required only for rules of the kind LogAlert.")
  evaluationFrequency?: duration;

  @doc("The period of time (in ISO 8601 duration format) on which the Alert query will be executed (bin size). Relevant and required only for rules of the kind LogAlert.")
  windowSize?: duration;

  @doc("If specified then overrides the query time range (default is WindowSize*NumberOfEvaluationPeriods). Relevant only for rules of the kind LogAlert.")
  overrideQueryTimeRange?: duration;

  @doc("List of resource type of the target resource(s) on which the alert is created/updated. For example if the scope is a resource group and targetResourceTypes is Microsoft.Compute/virtualMachines, then a different alert will be fired for each virtual machine in the resource group which meet the alert criteria. Relevant only for rules of the kind LogAlert")
  targetResourceTypes?: string[];

  @doc("The rule criteria that defines the conditions of the scheduled query rule.")
  criteria?: ScheduledQueryRuleCriteria;

  @doc("Mute actions for the chosen period of time (in ISO 8601 duration format) after the alert is fired. Relevant only for rules of the kind LogAlert.")
  muteActionsDuration?: duration;

  @doc("Actions to invoke when the alert fires.")
  actions?: Actions;

  @doc("The flag which indicates whether this scheduled query rule has been configured to be stored in the customer's storage. The default is false.")
  @visibility("read")
  isWorkspaceAlertsStorageConfigured?: boolean;

  @doc("The flag which indicates whether this scheduled query rule should be stored in the customer's storage. The default is false. Relevant only for rules of the kind LogAlert.")
  checkWorkspaceAlertsStorageConfigured?: boolean;

  @doc("The flag which indicates whether the provided query should be validated or not. The default is false. Relevant only for rules of the kind LogAlert.")
  skipQueryValidation?: boolean;

  @doc("The flag that indicates whether the alert should be automatically resolved or not. The default is true. Relevant only for rules of the kind LogAlert.")
  autoMitigate?: boolean;
}

@doc("The rule criteria that defines the conditions of the scheduled query rule.")
model ScheduledQueryRuleCriteria {
  @doc("A list of conditions to evaluate against the specified scopes")
  allOf?: Condition[];
}

@doc("A condition of the scheduled query rule.")
model Condition {
  @doc("Log query alert")
  query?: string;

  @doc("Aggregation type. Relevant and required only for rules of the kind LogAlert.")
  timeAggregation?: TimeAggregation;

  @doc("The column containing the metric measure number. Relevant only for rules of the kind LogAlert.")
  metricMeasureColumn?: string;

  @doc("The column containing the resource id. The content of the column must be a uri formatted as resource id. Relevant only for rules of the kind LogAlert.")
  resourceIdColumn?: string;

  @doc("List of Dimensions conditions")
  dimensions?: Dimension[];

  @doc("The criteria operator. Relevant and required only for rules of the kind LogAlert.")
  operator?: ConditionOperator;

  @doc("the criteria threshold value that activates the alert. Relevant and required only for rules of the kind LogAlert.")
  threshold?: float32;

  @doc("The minimum number of violations required within the selected lookback time window required to raise an alert. Relevant only for rules of the kind LogAlert.")
  failingPeriods?: ConditionFailingPeriods;

  @doc("The name of the metric to be sent. Relevant and required only for rules of the kind LogToMetric.")
  metricName?: string;
}

@doc("Dimension splitting and filtering definition")
model Dimension {
  @doc("Name of the dimension")
  name: string;

  @doc("Operator for dimension values")
  operator: DimensionOperator;

  @doc("List of dimension values")
  values: string[];
}

@doc("The minimum number of violations required within the selected lookback time window required to raise an alert. Relevant only for rules of the kind LogAlert.")
model ConditionFailingPeriods {
  @doc("The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (windowSize) and the selected number of aggregated points. Default value is 1")
  numberOfEvaluationPeriods?: int32;

  @doc("The number of violations to trigger an alert. Should be smaller or equal to numberOfEvaluationPeriods. Default value is 1")
  minFailingPeriodsToAlert?: int32;
}

@doc("Actions to invoke when the alert fires.")
model Actions {
  @doc("Action Group resource Ids to invoke when the alert fires.")
  actionGroups?: string[];

  @doc("The properties of an alert payload.")
  customProperties?: Record<string>;
}

@doc("Describes the format of Error response.")
@error
model ErrorContract {
  @doc("The error details.")
  error?: ErrorResponseDetails;
}

@doc("Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)")
model ErrorResponseDetails {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorResponseDetails[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorResponseAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorResponseAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: Record<unknown>;
}

@doc("The scheduled query rule resource for patch operations.")
model ScheduledQueryRuleResourcePatch {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The scheduled query rule properties of the resource.")
  properties?: ScheduledQueryRuleProperties;
}

@doc("Represents collection of metric namespaces.")
@pagedResult
model MetricNamespaceCollection {
  @doc("The values for the metric namespaces.")
  @items
  value: MetricNamespace[];
}

@doc("Metric namespace class specifies the metadata for a metric namespace.")
model MetricNamespace {
  @doc("The ID of the metric namespace.")
  id?: string;

  @doc("The type of the namespace.")
  type?: string;

  @doc("The escaped name of the namespace.")
  name?: string;

  @doc("Kind of namespace")
  classification?: NamespaceClassification;

  @doc("Properties which include the fully qualified namespace name.")
  properties?: MetricNamespaceName;
}

@doc("The fully qualified metric namespace name.")
model MetricNamespaceName {
  @doc("The metric namespace name.")
  metricNamespaceName?: string;
}

@doc("Resource properties.")
model VMInsightsOnboardingStatusProperties {
  @doc("Azure Resource Manager identifier of the resource whose onboarding status is being represented.")
  resourceId: string;

  @doc("The onboarding status for the resource. Note that, a higher level scope, e.g., resource group or subscription, is considered onboarded if at least one resource under it is onboarded.")
  onboardingStatus: OnboardingStatus;

  @doc("The status of VM Insights data from the resource. When reported as `present` the data array will contain information about the data containers to which data for the specified resource is being routed.")
  dataStatus: DataStatus;

  @doc("Containers that currently store VM Insights data for the specified resource.")
  data?: DataContainer[];
}

@doc("Information about a container with data for a given resource.")
model DataContainer {
  @doc("Log Analytics workspace information.")
  workspace: WorkspaceInfo;
}

@doc("Information about a Log Analytics Workspace.")
model WorkspaceInfo {
  @doc("Azure Resource Manager identifier of the Log Analytics Workspace.")
  id: string;

  @doc("Location of the Log Analytics workspace.")
  location: string;

  @doc("Resource properties.")
  properties: WorkspaceInfoProperties;
}

@doc("Resource properties.")
model WorkspaceInfoProperties {
  @doc("Log Analytics workspace identifier.")
  customerId: string;
}

@doc("An error response from the API.")
@error
model ResponseWithError {
  @doc("Error information.")
  error: Error;
}

@doc("Error details.")
model Error {
  @doc("Error code identifying the specific error.")
  code: string;

  @doc("Error message in the caller's locale.")
  message?: string;
}

@doc("Properties that define a Azure Monitor PrivateLinkScope resource.")
model AzureMonitorPrivateLinkScopeProperties {
  @doc("Current state of this PrivateLinkScope: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Provisioning ,Succeeded, Canceled and Failed.")
  @visibility("read")
  provisioningState?: string;

  @doc("List of private endpoint connections.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Access mode settings")
  accessModeSettings: AccessModeSettings;
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The Private Endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint")
  @visibility("read")
  id?: string;
}

@doc("A collection of information about the state of the connection between service consumer and provider.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("Properties that define the scope private link mode settings.")
model AccessModeSettings {
  @doc("Specifies the default access mode of queries through associated private endpoints in scope. If not specified default value is 'Open'. You can override this default setting for a specific private endpoint connection by adding an exclusion in the 'exclusions' array.")
  queryAccessMode: AccessMode;

  @doc("Specifies the default access mode of ingestion through associated private endpoints in scope. If not specified default value is 'Open'. You can override this default setting for a specific private endpoint connection by adding an exclusion in the 'exclusions' array.")
  ingestionAccessMode: AccessMode;

  @doc("List of exclusions that override the default access mode settings for specific private endpoint connections.")
  exclusions?: AccessModeSettingsExclusion[];
}

@doc("Properties that define the scope private link mode settings exclusion item. This setting applies to a specific private endpoint connection and overrides the default settings for that private endpoint connection.")
model AccessModeSettingsExclusion {
  @doc("The private endpoint connection name associated to the private endpoint on which we want to apply the specific access mode settings.")
  privateEndpointConnectionName?: string;

  @doc("Specifies the access mode of queries through the specified private endpoint connection in the exclusion.")
  queryAccessMode?: AccessMode;

  @doc("Specifies the access mode of ingestion through the specified private endpoint connection in the exclusion.")
  ingestionAccessMode?: AccessMode;
}

@doc("The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location'")
model CommonTrackedResource extends CommonResource {
  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  @visibility("read", "create")
  location: string;
}

@doc("Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).")
@error
model DefaultErrorResponse {
  @doc("The error object.")
  error?: CommonErrorDetail;
}

@doc("The error detail.")
model CommonErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: CommonErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("A container holding only the Tags for a resource, allowing the user to update the tags on a PrivateLinkScope instance.")
model TagsResource {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("The status of operation.")
model OperationStatus {
  @doc("The operation Id.")
  id?: string;

  @doc("The operation name.")
  name?: string;

  @doc("Start time of the job in standard ISO8601 format.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the job in standard ISO8601 format.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The status of the operation.")
  status?: string;

  @doc("The error detail of the operation if any.")
  error?: CommonErrorDetail;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("Properties of a private link scoped resource.")
model ScopedResourceProperties {
  @doc("The resource id of the scoped Azure monitor resource.")
  linkedResourceId?: string;

  @doc("State of the private endpoint connection.")
  @visibility("read")
  provisioningState?: string;
}

@doc("The resource model definition for a Azure Resource Manager proxy resource. It will not have tags and a location")
model CommonProxyResource extends CommonResource {}

@doc("An Azure Activity Log Alert rule.")
model AlertRuleProperties {
  @doc("A list of resource IDs that will be used as prefixes. The alert will only apply to Activity Log events with resource IDs that fall under one of these prefixes. This list must include at least one item.")
  scopes: string[];

  @doc("The condition that will cause this alert to activate.")
  condition: AlertRuleAllOfCondition;

  @doc("The actions that will activate when the condition is met.")
  actions: ActionList;

  @doc("Indicates whether this Activity Log Alert rule is enabled. If an Activity Log Alert rule is not enabled, then none of its actions will be activated.")
  enabled?: boolean;

  @doc("A description of this Activity Log Alert rule.")
  description?: string;
}

@doc("An Activity Log Alert rule condition that is met when all its member conditions are met.")
model AlertRuleAllOfCondition {
  @doc("The list of Activity Log Alert rule conditions.")
  allOf: AlertRuleAnyOfOrLeafCondition[];
}

@doc("""
An Activity Log Alert rule condition that is met when all its member conditions are met.
Each condition can be of one of the following types:
__Important__: Each type has its unique subset of properties. Properties from different types CANNOT exist in one condition.
   * __Leaf Condition -__ must contain 'field' and either 'equals' or 'containsAny'.
  _Please note, 'anyOf' should __not__ be set in a Leaf Condition._
  * __AnyOf Condition -__ must contain __only__ 'anyOf' (which is an array of Leaf Conditions).
  _Please note, 'field', 'equals' and 'containsAny' should __not__ be set in an AnyOf Condition._

""")
model AlertRuleAnyOfOrLeafCondition extends AlertRuleLeafCondition {
  @doc("An Activity Log Alert rule condition that is met when at least one of its member leaf conditions are met.")
  anyOf?: AlertRuleLeafCondition[];
}

@doc("""
An Activity Log Alert rule condition that is met by comparing the field and value of an Activity Log event.
This condition must contain 'field' and either 'equals' or 'containsAny'.
""")
model AlertRuleLeafCondition {
  @doc("""
The name of the Activity Log event's field that this condition will examine.
The possible values for this field are (case-insensitive): 'resourceId', 'category', 'caller', 'level', 'operationName', 'resourceGroup', 'resourceProvider', 'status', 'subStatus', 'resourceType', or anything beginning with 'properties'.
""")
  field?: string;

  @doc("The value of the event's field will be compared to this value (case-insensitive) to determine if the condition is met.")
  equals?: string;

  @doc("The value of the event's field will be compared to the values in this array (case-insensitive) to determine if the condition is met.")
  containsAny?: string[];
}

@doc("A list of Activity Log Alert rule actions.")
model ActionList {
  @doc("The list of the Action Groups.")
  actionGroups?: ActivityLogAlertActionGroup[];
}

@doc("A pointer to an Azure Action Group.")
model ActivityLogAlertActionGroup {
  @doc("The resource ID of the Action Group. This cannot be null or empty.")
  actionGroupId: string;

  @doc("the dictionary of custom properties to include with the post operation. These data are appended to the webhook payload.")
  webhookProperties?: Record<string>;
}

@doc("An Azure resource object.")
model ActivityLogAlertsResource {
  @doc("The resource Id.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;

  @doc("The location of the resource. Since Azure Activity Log Alerts is a global service, the location of the rules should always be 'global'.")
  @visibility("read", "create")
  location?: string;

  @doc("The tags of the resource.")
  tags?: Record<string>;
}

@doc("The error response.")
@error
model ActivityLogAlertErrorResponse {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message indicating why the operation failed.")
  @visibility("read")
  message?: string;
}

@doc("An Activity Log Alert rule object for the body of patch operations.")
model AlertRulePatchObject {
  @doc("The resource tags")
  tags?: Record<string>;

  @doc("The activity log alert settings for an update operation.")
  properties?: AlertRulePatchProperties;
}

@doc("An Activity Log Alert rule properties for patch operations.")
model AlertRulePatchProperties {
  @doc("Indicates whether this Activity Log Alert rule is enabled. If an Activity Log Alert rule is not enabled, then none of its actions will be activated.")
  enabled?: boolean;
}

@doc("Resource properties.")
model DataCollectionEndpointResourceProperties extends DataCollectionEndpoint {}

@doc("Definition of data collection endpoint.")
model DataCollectionEndpoint {
  @doc("Description of the data collection endpoint.")
  description?: string;

  @doc("The immutable ID of this data collection endpoint resource. This property is READ-ONLY.")
  immutableId?: string;

  @doc("The endpoint used by clients to access their configuration.")
  configurationAccess?: DataCollectionEndpointConfigurationAccess;

  @doc("The endpoint used by clients to ingest logs.")
  logsIngestion?: DataCollectionEndpointLogsIngestion;

  @doc("The endpoint used by clients to ingest metrics.")
  metricsIngestion?: DataCollectionEndpointMetricsIngestion;

  @doc("Network access control rules for the endpoints.")
  networkAcls?: DataCollectionEndpointNetworkAcls;

  @doc("The resource provisioning state. This property is READ-ONLY.")
  @visibility("read")
  provisioningState?: KnownDataCollectionEndpointProvisioningState;

  @doc("List of Azure Monitor Private Link Scope Resources to which this data collection endpoint resource is associated. This property is READ-ONLY.")
  @visibility("read")
  privateLinkScopedResources?: PrivateLinkScopedResource[];

  @doc("Failover configuration on this endpoint. This property is READ-ONLY.")
  @visibility("read")
  failoverConfiguration?: DataCollectionEndpointFailoverConfiguration;

  @doc("Metadata for the resource. This property is READ-ONLY.")
  @visibility("read")
  metadata?: DataCollectionEndpointMetadata;
}

@doc("The endpoint used by clients to access their configuration.")
model DataCollectionEndpointConfigurationAccess
  extends ConfigurationAccessEndpointSpec {}

@doc("Definition of the endpoint used for accessing configuration.")
model ConfigurationAccessEndpointSpec {
  @doc("The endpoint. This property is READ-ONLY.")
  @visibility("read")
  endpoint?: string;
}

@doc("The endpoint used by clients to ingest logs.")
model DataCollectionEndpointLogsIngestion extends LogsIngestionEndpointSpec {}

@doc("Definition of the endpoint used for ingesting logs.")
model LogsIngestionEndpointSpec {
  @doc("The endpoint. This property is READ-ONLY.")
  @visibility("read")
  endpoint?: string;
}

@doc("The endpoint used by clients to ingest metrics.")
model DataCollectionEndpointMetricsIngestion
  extends MetricsIngestionEndpointSpec {}

@doc("Definition of the endpoint used for ingesting metrics.")
model MetricsIngestionEndpointSpec {
  @doc("The endpoint. This property is READ-ONLY.")
  @visibility("read")
  endpoint?: string;
}

@doc("Network access control rules for the endpoints.")
model DataCollectionEndpointNetworkAcls extends NetworkRuleSet {}

@doc("Definition of the network rules.")
model NetworkRuleSet {
  @doc("The configuration to set whether network access from public internet to the endpoints are allowed.")
  publicNetworkAccess?: KnownPublicNetworkAccessOptions;
}

model PrivateLinkScopedResource {
  @doc("The resourceId of the Azure Monitor Private Link Scope Scoped Resource through which this DCE is associated with a Azure Monitor Private Link Scope.")
  resourceId?: string;

  @doc("The immutableId of the Azure Monitor Private Link Scope Resource to which the association is.")
  scopeId?: string;
}

@doc("Failover configuration on this endpoint. This property is READ-ONLY.")
model DataCollectionEndpointFailoverConfiguration
  extends FailoverConfigurationSpec {}

model FailoverConfigurationSpec {
  @doc("Active location where data flow will occur.")
  activeLocation?: string;

  @doc("Locations that are configured for failover.")
  locations?: LocationSpec[];
}

model LocationSpec {
  @doc("Name of location.")
  location?: string;

  @doc("The resource provisioning state in this location.")
  provisioningStatus?: KnownLocationSpecProvisioningStatus;
}

@doc("Metadata for the resource. This property is READ-ONLY.")
model DataCollectionEndpointMetadata extends Metadata {}

@doc("Metadata about the resource")
model Metadata {
  @doc("Azure offering managing this resource on-behalf-of customer.")
  @visibility("read")
  provisionedBy?: string;

  @doc("Resource Id of azure offering managing this resource on-behalf-of customer.")
  @visibility("read")
  provisionedByResourceId?: string;
}

@doc("Managed service identity of the resource.")
model DataCollectionEndpointResourceIdentity extends ManagedServiceIdentity {}

@doc("Metadata pertaining to creation and last modification of the resource.")
model DataCollectionEndpointResourceSystemData extends SystemData {}

@doc("Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).")
@error
model ErrorResponseCommonV2 {
  @doc("The error object.")
  error?: CommonErrorDetail;
}

@doc("Definition of ARM tracked top level resource properties for update operation.")
model ResourceForUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Managed Service Identity.")
  identity?: ResourceForUpdateIdentity;
}

@doc("Managed Service Identity.")
model ResourceForUpdateIdentity extends ManagedServiceIdentity {}

@doc("Resource properties.")
model DataCollectionRuleAssociationProxyOnlyResourceProperties
  extends DataCollectionRuleAssociation {}

@doc("Definition of association of a data collection rule with a monitored Azure resource.")
model DataCollectionRuleAssociation {
  @doc("Description of the association.")
  description?: string;

  @doc("The resource ID of the data collection rule that is to be associated.")
  dataCollectionRuleId?: string;

  @doc("The resource ID of the data collection endpoint that is to be associated.")
  dataCollectionEndpointId?: string;

  @doc("The resource provisioning state.")
  @visibility("read")
  provisioningState?: KnownDataCollectionRuleAssociationProvisioningState;

  @doc("Metadata about the resource")
  @visibility("read")
  metadata?: DataCollectionRuleAssociationMetadata;
}

@doc("Metadata about the resource")
model DataCollectionRuleAssociationMetadata extends Metadata {}

@doc("Metadata pertaining to creation and last modification of the resource.")
model DataCollectionRuleAssociationProxyOnlyResourceSystemData
  extends SystemData {}

@doc("Resource properties.")
model DataCollectionRuleResourceProperties extends DataCollectionRule {}

@doc("Definition of what monitoring data to collect and where that data should be sent.")
model DataCollectionRule {
  @doc("Description of the data collection rule.")
  description?: string;

  @doc("The immutable ID of this data collection rule. This property is READ-ONLY.")
  @visibility("read")
  immutableId?: string;

  @doc("The resource ID of the data collection endpoint that this rule can be used with.")
  dataCollectionEndpointId?: string;

  @doc("Metadata about the resource")
  @visibility("read")
  metadata?: DataCollectionRuleMetadata;

  @doc("Declaration of custom streams used in this rule.")
  streamDeclarations?: Record<StreamDeclaration>;

  @doc("""
The specification of data sources. 
This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint.
""")
  dataSources?: DataCollectionRuleDataSources;

  @doc("The specification of destinations.")
  destinations?: DataCollectionRuleDestinations;

  @doc("The specification of data flows.")
  dataFlows?: DataFlow[];

  @doc("The resource provisioning state.")
  @visibility("read")
  provisioningState?: KnownDataCollectionRuleProvisioningState;
}

@doc("Metadata about the resource")
model DataCollectionRuleMetadata extends Metadata {}

@doc("Declaration of a custom stream.")
model StreamDeclaration {
  @doc("List of columns used by data in this stream.")
  columns?: ColumnDefinition[];
}

@doc("Definition of custom data column.")
model ColumnDefinition {
  @doc("The name of the column.")
  name?: string;

  @doc("The type of the column data.")
  type?: KnownColumnDefinitionType;
}

@doc("""
The specification of data sources. 
This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint.
""")
model DataCollectionRuleDataSources extends DataSourcesSpec {}

@doc("Specification of data sources that will be collected.")
model DataSourcesSpec {
  @doc("The list of performance counter data source configurations.")
  performanceCounters?: PerfCounterDataSource[];

  @doc("The list of Windows Event Log data source configurations.")
  windowsEventLogs?: WindowsEventLogDataSource[];

  @doc("The list of Syslog data source configurations.")
  syslog?: SyslogDataSource[];

  @doc("The list of Azure VM extension data source configurations.")
  extensions?: ExtensionDataSource[];

  @doc("The list of Log files source configurations.")
  logFiles?: LogFilesDataSource[];

  @doc("The list of IIS logs source configurations.")
  iisLogs?: IisLogsDataSource[];

  @doc("The list of Windows Firewall logs source configurations.")
  windowsFirewallLogs?: WindowsFirewallLogsDataSource[];

  @doc("The list of Prometheus forwarder data source configurations.")
  prometheusForwarder?: PrometheusForwarderDataSource[];

  @doc("The list of platform telemetry configurations")
  platformTelemetry?: PlatformTelemetryDataSource[];

  @doc("Specifications of pull based data sources")
  dataImports?: DataSourcesSpecDataImports;
}

@doc("""
Definition of which performance counters will be collected and how they will be collected by this data collection rule.
Collected from both Windows and Linux machines where the counter is present.
""")
model PerfCounterDataSource {
  @doc("""
List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
""")
  streams?: KnownPerfCounterDataSourceStreams[];

  @doc("The number of seconds between consecutive counter measurements (samples).")
  samplingFrequencyInSeconds?: int32;

  @doc("""
A list of specifier names of the performance counters you want to collect.
Use a wildcard (*) to collect a counter for all instances.
To get a list of performance counters on Windows, run the command 'typeperf'.
""")
  counterSpecifiers?: string[];

  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("""
Definition of which Windows Event Log events will be collected and how they will be collected.
Only collected from Windows machines.
""")
model WindowsEventLogDataSource {
  @doc("""
List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
""")
  streams?: KnownWindowsEventLogDataSourceStreams[];

  @doc("A list of Windows Event Log queries in XPATH format.")
  xPathQueries?: string[];

  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("""
Definition of which syslog data will be collected and how it will be collected.
Only collected from Linux machines.
""")
model SyslogDataSource {
  @doc("""
List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
""")
  streams?: KnownSyslogDataSourceStreams[];

  @doc("The list of facility names.")
  facilityNames?: KnownSyslogDataSourceFacilityNames[];

  @doc("The log levels to collect.")
  logLevels?: KnownSyslogDataSourceLogLevels[];

  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("""
Definition of which data will be collected from a separate VM extension that integrates with the Azure Monitor Agent.
Collected from either Windows and Linux machines, depending on which extension is defined.
""")
model ExtensionDataSource {
  @doc("""
List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
""")
  streams?: KnownExtensionDataSourceStreams[];

  @doc("The name of the VM extension.")
  extensionName: string;

  @doc("The extension settings. The format is specific for particular extension.")
  extensionSettings?: Record<unknown>;

  @doc("The list of data sources this extension needs data from.")
  inputDataSources?: string[];

  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("Definition of which custom log files will be collected by this data collection rule")
model LogFilesDataSource {
  @doc("""
List of streams that this data source will be sent to.
A stream indicates what schema will be used for this data source
""")
  streams: string[];

  @doc("File Patterns where the log files are located")
  filePatterns: string[];

  @doc("The data format of the log files")
  format: KnownLogFilesDataSourceFormat;

  @doc("The log files specific settings.")
  settings?: LogFilesDataSourceSettings;

  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("The log files specific settings.")
model LogFilesDataSourceSettings extends LogFileSettings {}

@doc("Settings for different log file formats")
model LogFileSettings {
  @doc("Text settings")
  text?: LogFileSettingsText;
}

@doc("Text settings")
model LogFileSettingsText extends LogFileTextSettings {}

@doc("Settings for text log files")
model LogFileTextSettings {
  @doc("One of the supported timestamp formats")
  recordStartTimestampFormat: KnownLogFileTextSettingsRecordStartTimestampFormat;
}

@doc("Enables IIS logs to be collected by this data collection rule.")
model IisLogsDataSource {
  @doc("IIS streams")
  streams: string[];

  @doc("Absolute paths file location")
  logDirectories?: string[];

  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("Enables Firewall logs to be collected by this data collection rule.")
model WindowsFirewallLogsDataSource {
  @doc("Firewall logs streams")
  streams: string[];

  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("Definition of Prometheus metrics forwarding configuration.")
model PrometheusForwarderDataSource {
  @doc("List of streams that this data source will be sent to.")
  streams?: KnownPrometheusForwarderDataSourceStreams[];

  @doc("""
The list of label inclusion filters in the form of label \"name-value\" pairs.
Currently only one label is supported: 'microsoft_metrics_include_label'.
Label values are matched case-insensitively.
""")
  labelIncludeFilter?: Record<string>;

  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("Definition of platform telemetry data source configuration")
model PlatformTelemetryDataSource {
  @doc("List of platform telemetry streams to collect")
  streams: string[];

  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("Specifications of pull based data sources")
model DataSourcesSpecDataImports extends DataImportSources {}

model DataImportSources {
  @doc("Definition of Event Hub configuration.")
  eventHub?: DataImportSourcesEventHub;
}

@doc("Definition of Event Hub configuration.")
model DataImportSourcesEventHub extends EventHubDataSource {}

model EventHubDataSource {
  @doc("""
A friendly name for the data source. 
This name should be unique across all data sources (regardless of type) within the data collection rule.
""")
  name?: string;

  @doc("Event Hub consumer group name")
  consumerGroup?: string;

  @doc("The stream to collect from EventHub")
  stream?: string;
}

@doc("The specification of destinations.")
model DataCollectionRuleDestinations extends DestinationsSpec {}

@doc("Specification of destinations that can be used in data flows.")
model DestinationsSpec {
  @doc("List of Log Analytics destinations.")
  logAnalytics?: LogAnalyticsDestination[];

  @doc("List of monitoring account destinations.")
  monitoringAccounts?: MonitoringAccountDestination[];

  @doc("Azure Monitor Metrics destination.")
  azureMonitorMetrics?: DestinationsSpecAzureMonitorMetrics;

  @doc("List of Event Hubs destinations.")
  eventHubs?: EventHubDestination[];

  @doc("List of Event Hubs Direct destinations.")
  eventHubsDirect?: EventHubDirectDestination[];

  @doc("List of Storage Blob Direct destinations. To be used only for sending data directly to store from the agent.")
  storageBlobsDirect?: StorageBlobDestination[];

  @doc("List of Storage Table Direct destinations.")
  storageTablesDirect?: StorageTableDestination[];

  @doc("List of storage accounts destinations.")
  storageAccounts?: StorageBlobDestination[];
}

@doc("Log Analytics destination.")
model LogAnalyticsDestination {
  @doc("The resource ID of the Log Analytics workspace.")
  workspaceResourceId?: string;

  @doc("The Customer ID of the Log Analytics workspace.")
  @visibility("read")
  workspaceId?: string;

  @doc("""
A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("Monitoring account destination.")
model MonitoringAccountDestination {
  @doc("The resource ID of the monitoring account.")
  accountResourceId?: string;

  @doc("The immutable ID  of the account.")
  @visibility("read")
  accountId?: string;

  @doc("""
A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("Azure Monitor Metrics destination.")
model DestinationsSpecAzureMonitorMetrics
  extends AzureMonitorMetricsDestination {}

@doc("Azure Monitor Metrics destination.")
model AzureMonitorMetricsDestination {
  @doc("""
A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.
""")
  name?: string;
}

model EventHubDestination {
  @doc("The resource ID of the event hub.")
  eventHubResourceId?: string;

  @doc("""
A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.
""")
  name?: string;
}

model EventHubDirectDestination {
  @doc("The resource ID of the event hub.")
  eventHubResourceId?: string;

  @doc("""
A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.
""")
  name?: string;
}

model StorageBlobDestination {
  @doc("The container name of the Storage Blob.")
  containerName?: string;

  @doc("The resource ID of the storage account.")
  storageAccountResourceId?: string;

  @doc("""
A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.
""")
  name?: string;
}

model StorageTableDestination {
  @doc("The name of the Storage Table.")
  tableName?: string;

  @doc("The resource ID of the storage account.")
  storageAccountResourceId?: string;

  @doc("""
A friendly name for the destination. 
This name should be unique across all destinations (regardless of type) within the data collection rule.
""")
  name?: string;
}

@doc("Definition of which streams are sent to which destinations.")
model DataFlow {
  @doc("List of streams for this data flow.")
  streams?: KnownDataFlowStreams[];

  @doc("List of destinations for this data flow.")
  destinations?: string[];

  @doc("The KQL query to transform stream data.")
  transformKql?: string;

  @doc("The output stream of the transform. Only required if the transform changes data to a different stream.")
  outputStream?: string;

  @doc("The builtIn transform to transform stream data")
  builtInTransform?: string;
}

@doc("Managed service identity of the resource.")
model DataCollectionRuleResourceIdentity extends ManagedServiceIdentity {}

@doc("Metadata pertaining to creation and last modification of the resource.")
model DataCollectionRuleResourceSystemData extends SystemData {}

@doc("Resource properties")
model AzureMonitorWorkspaceResourceProperties extends AzureMonitorWorkspace {}

@doc("Properties of an Azure Monitor workspace")
model AzureMonitorWorkspace {
  @doc("The immutable ID of the Azure Monitor workspace. This property is read-only.")
  @visibility("read")
  accountId?: string;

  @doc("Information about metrics for the Azure Monitor workspace")
  @visibility("read")
  metrics?: AzureMonitorWorkspaceMetrics;

  @doc("The provisioning state of the Azure Monitor workspace. Set to Succeeded if everything is healthy.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The Data Collection Rule and Endpoint used for ingestion by default.")
  @visibility("read")
  defaultIngestionSettings?: AzureMonitorWorkspaceDefaultIngestionSettings;

  @doc("List of private endpoint connections")
  @visibility("read")
  privateEndpointConnections?: MonitorWorkspacePrivateEndpointConnection[];

  @doc("Gets or sets allow or disallow public network access to workspace")
  @visibility("read")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("Information about metrics for the Azure Monitor workspace")
model AzureMonitorWorkspaceMetrics extends Metrics {}

@doc("Information about metrics for the workspace")
model Metrics {
  @doc("The Prometheus query endpoint for the workspace")
  @visibility("read")
  prometheusQueryEndpoint?: string;

  @doc("An internal identifier for the metrics container. Only to be used by the system")
  @visibility("read")
  internalId?: string;
}

@doc("The Data Collection Rule and Endpoint used for ingestion by default.")
model AzureMonitorWorkspaceDefaultIngestionSettings extends IngestionSettings {}

@doc("Settings for data ingestion")
model IngestionSettings {
  @doc("The Azure resource Id of the default data collection rule for this workspace.")
  @visibility("read")
  dataCollectionRuleResourceId?: string;

  @doc("The Azure resource Id of the default data collection endpoint for this workspace.")
  @visibility("read")
  dataCollectionEndpointResourceId?: string;
}

@doc("The private endpoint connection resource.")
model MonitorWorkspacePrivateEndpointConnection extends CommonResourceV4 {
  @doc("Resource properties.")
  properties?: MonitorWorkspacePrivateEndpointConnectionProperties;
}

@doc("Properties of the private endpoint connection.")
model MonitorWorkspacePrivateEndpointConnectionProperties {
  @doc("The group ids for the private endpoint resource.")
  @visibility("read")
  groupIds?: string[];

  @doc("The private endpoint resource.")
  privateEndpoint?: MonitorWorkspacePrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The private endpoint resource.")
model MonitorWorkspacePrivateEndpoint {
  @doc("The ARM identifier for private endpoint.")
  @visibility("read")
  id?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model CommonResourceV4 {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
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

@doc("The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location'")
model CommonTrackedResourceV3 extends CommonResourceV3 {
  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  @visibility("read", "create")
  location: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model CommonResourceV3 {
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

@doc("Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).")
@error
model CommonErrorResponseV3 {
  @doc("The error object.")
  error?: CommonErrorDetailV3;
}

@doc("The error detail.")
model CommonErrorDetailV3 {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: CommonErrorDetailV3[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("Definition of ARM tracked top level resource properties for update operation")
model AzureMonitorWorkspaceResourceForUpdate {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("A rule metric data source. The discriminator value is always RuleMetricDataSource in this case.")
model RuleMetricDataSource extends RuleDataSource {
  @doc("the name of the metric that defines what the rule monitors.")
  metricName?: string;

  @doc("specifies the type of data source. There are two types of rule data sources: RuleMetricDataSource and RuleManagementEventDataSource")
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.RuleMetricDataSource";
}

@doc("The claims for a rule management event data source.")
model RuleManagementEventClaimsDataSource {
  @doc("the email address.")
  emailAddress?: string;
}

@doc("A rule management event data source. The discriminator fields is always RuleManagementEventDataSource in this case.")
model RuleManagementEventDataSource extends RuleDataSource {
  @doc("the event name.")
  eventName?: string;

  @doc("the event source.")
  eventSource?: string;

  @doc("the level.")
  level?: string;

  @doc("The name of the operation that should be checked for. If no name is provided, any operation will match.")
  operationName?: string;

  @doc("the resource group name.")
  resourceGroupName?: string;

  @doc("the resource provider name.")
  resourceProviderName?: string;

  @doc("The status of the operation that should be checked for. If no status is provided, any status will match.")
  status?: string;

  @doc("the substatus.")
  subStatus?: string;

  @doc("the claims.")
  claims?: RuleManagementEventClaimsDataSource;

  @doc("specifies the type of data source. There are two types of rule data sources: RuleMetricDataSource and RuleManagementEventDataSource")
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.RuleManagementEventDataSource";
}

@doc("A rule condition based on a metric crossing a threshold.")
model ThresholdRuleCondition extends RuleCondition {
  @doc("the operator used to compare the data and the threshold.")
  operator: ConditionOperator;

  @doc("the threshold value that activates the alert.")
  threshold: float32;

  @doc("the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold. If specified then it must be between 5 minutes and 1 day.")
  windowSize?: duration;

  @doc("the time aggregation operator. How the data that are collected should be combined over time. The default value is the PrimaryAggregationType of the Metric.")
  timeAggregation?: TimeAggregationOperator;

  @doc("specifies the type of condition. This can be one of three types: ManagementEventRuleCondition (occurrences of management events), LocationThresholdRuleCondition (based on the number of failures of a web test), and ThresholdRuleCondition (based on the threshold of a metric).")
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.ThresholdRuleCondition";
}

@doc("A rule condition based on a certain number of locations failing.")
model LocationThresholdRuleCondition extends RuleCondition {
  @doc("the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold. If specified then it must be between 5 minutes and 1 day.")
  windowSize?: duration;

  @doc("the number of locations that must fail to activate the alert.")
  failedLocationCount: int32;

  @doc("specifies the type of condition. This can be one of three types: ManagementEventRuleCondition (occurrences of management events), LocationThresholdRuleCondition (based on the number of failures of a web test), and ThresholdRuleCondition (based on the threshold of a metric).")
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.LocationThresholdRuleCondition";
}

@doc("How the data that is collected should be combined over time.")
model ManagementEventAggregationCondition {
  @doc("the condition operator.")
  operator?: ConditionOperator;

  @doc("The threshold value that activates the alert.")
  threshold?: float32;

  @doc("the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold. If specified then it must be between 5 minutes and 1 day.")
  windowSize?: duration;
}

@doc("A management event rule condition.")
model ManagementEventRuleCondition extends RuleCondition {
  @doc("How the data that is collected should be combined over time and when the alert is activated. Note that for management event alerts aggregation is optional – if it is not provided then any event will cause the alert to activate.")
  aggregation?: ManagementEventAggregationCondition;

  @doc("specifies the type of condition. This can be one of three types: ManagementEventRuleCondition (occurrences of management events), LocationThresholdRuleCondition (based on the number of failures of a web test), and ThresholdRuleCondition (based on the threshold of a metric).")
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.ManagementEventRuleCondition";
}

@doc("Specifies the action to send email when the rule condition is evaluated. The discriminator is always RuleEmailAction in this case.")
model RuleEmailAction extends RuleAction {
  @doc("Whether the administrators (service and co-administrators) of the service should be notified when the alert is activated.")
  sendToServiceOwners?: boolean;

  @doc("the list of administrator's custom email addresses to notify of the activation of the alert.")
  customEmails?: string[];

  @doc("specifies the type of the action. There are two types of actions: RuleEmailAction and RuleWebhookAction.")
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.RuleEmailAction";
}

@doc("Specifies the action to post to service when the rule condition is evaluated. The discriminator is always RuleWebhookAction in this case.")
model RuleWebhookAction extends RuleAction {
  @doc("the service uri to Post the notification when the alert activates or resolves.")
  serviceUri?: string;

  @doc("the dictionary of custom properties to include with the post operation. These data are appended to the webhook payload.")
  properties?: Record<string>;

  @doc("specifies the type of the action. There are two types of actions: RuleEmailAction and RuleWebhookAction.")
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.RuleWebhookAction";
}

@doc("Specifies the metric alert criteria for a single resource that has multiple metric criteria.")
model MetricAlertSingleResourceMultipleMetricCriteria
  extends MetricAlertCriteria {
  @doc("The list of metric criteria for this 'all of' operation. ")
  allOf?: MetricCriteria[];

  @doc("specifies the type of the alert criteria.")
  `odata.type`: "Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria";
}

@doc("Criterion to filter metrics.")
model MetricCriteria extends MultiMetricCriteria {
  @doc("the criteria operator.")
  operator: Operator;

  @doc("the criteria threshold value that activates the alert.")
  threshold: float32;

  @doc("Specifies the type of threshold criteria")
  criterionType: "StaticThresholdCriterion";
}

@doc("The types of conditions for a multi resource alert.")
@discriminator("criterionType")
model MultiMetricCriteria extends Record<Record<unknown>> {
  @doc("Name of the criteria.")
  name: string;

  @doc("Name of the metric.")
  metricName: string;

  @doc("Namespace of the metric.")
  metricNamespace?: string;

  @doc("the criteria time aggregation types.")
  timeAggregation: AggregationTypeEnum;

  @doc("List of dimension conditions.")
  dimensions?: MetricDimension[];

  @doc("Allows creating an alert rule on a custom metric that isn't yet emitted, by causing the metric validation to be skipped.")
  skipMetricValidation?: boolean;
}

@doc("Specifies a metric dimension.")
model MetricDimension {
  @doc("Name of the dimension.")
  name: string;

  @doc("the dimension operator. Only 'Include' and 'Exclude' are supported")
  operator: string;

  @doc("list of dimension values.")
  values: string[];
}

@doc("Specifies the metric alert rule criteria for a web test resource.")
model WebtestLocationAvailabilityCriteria extends MetricAlertCriteria {
  @doc("The Application Insights web test Id.")
  webTestId: string;

  @doc("The Application Insights resource Id.")
  componentId: string;

  @doc("The number of failed locations.")
  failedLocationCount: float32;

  @doc("specifies the type of the alert criteria.")
  `odata.type`: "Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria";
}

@doc("Specifies the metric alert criteria for multiple resource that has multiple metric criteria.")
model MetricAlertMultipleResourceMultipleMetricCriteria
  extends MetricAlertCriteria {
  @doc("the list of multiple metric criteria for this 'all of' operation. ")
  allOf?: MultiMetricCriteria[];

  @doc("specifies the type of the alert criteria.")
  `odata.type`: "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria";
}

@doc("Criterion for dynamic threshold.")
model DynamicMetricCriteria extends MultiMetricCriteria {
  @doc("The operator used to compare the metric value against the threshold.")
  operator: DynamicThresholdOperator;

  @doc("The extent of deviation required to trigger an alert. This will affect how tight the threshold is to the metric series pattern.")
  alertSensitivity: DynamicThresholdSensitivity;

  @doc("The minimum number of violations required within the selected lookback time window required to raise an alert.")
  failingPeriods: DynamicThresholdFailingPeriods;

  @doc("Use this option to set the date from which to start learning the metric historical data and calculate the dynamic thresholds (in ISO8601 format)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  ignoreDataBefore?: utcDateTime;

  @doc("Specifies the type of threshold criteria")
  criterionType: "DynamicThresholdCriterion";
}

@doc("The minimum number of violations required within the selected lookback time window required to raise an alert.")
model DynamicThresholdFailingPeriods {
  @doc("The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (windowSize) and the selected number of aggregated points.")
  numberOfEvaluationPeriods: float32;

  @doc("The number of violations to trigger an alert. Should be smaller or equal to numberOfEvaluationPeriods.")
  minFailingPeriodsToAlert: float32;
}
