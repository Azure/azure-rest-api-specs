import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * the dimension operator. Only 'Equals' and 'NotEquals' are supported. 'Equals' being equal to any of the values. 'NotEquals' being not equal to all of the values
 */
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

/**
 * The type of the diagnostic settings category.
 */
enum CategoryType {
  Metrics,
  Logs,
}

/**
 * The class of the metric.
 */
enum MetricClass {
  Availability,
  Transactions,
  Errors,
  Latency,
  Saturation,
}

/**
 * The unit of the metric.
 */
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

/**
 * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
 */
enum MetricResultType {
  Data,
  Metadata,
}

/**
 * the sensitivity of the baseline.
 */
enum BaselineSensitivity {
  Low,
  Medium,
  High,
}

/**
 * specifies the type of the alert criteria.
 */
enum Odatatype {
  `Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria`,
  `Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria`,
  `Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria`,
}

/**
 * Indicates the type of scheduled query rule. The default is LogAlert.
 */
enum Kind {
  LogAlert,
  LogToMetric,
}

/**
 * Severity of the alert. Should be an integer between [0-4]. Value of 0 is severest. Relevant and required only for rules of the kind LogAlert.
 */
enum AlertSeverity {
  `0`: 0,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
}

/**
 * Aggregation type. Relevant and required only for rules of the kind LogAlert.
 */
enum TimeAggregation {
  Count,
  Average,
  Minimum,
  Maximum,
  Total,
}

/**
 * Operator for dimension values
 */
enum DimensionOperator {
  Include,
  Exclude,
}

/**
 * Kind of namespace
 */
enum NamespaceClassification {
  Platform,
  Custom,
  Qos,
}

/**
 * The onboarding status for the resource. Note that, a higher level scope, e.g., resource group or subscription, is considered onboarded if at least one resource under it is onboarded.
 */
enum OnboardingStatus {
  onboarded,
  notOnboarded,
  `unknown`,
}

/**
 * The status of VM Insights data from the resource. When reported as `present` the data array will contain information about the data containers to which data for the specified resource is being routed.
 */
enum DataStatus {
  present,
  notPresent,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * Access mode types.
 */
enum AccessMode {
  Open,
  PrivateOnly,
}

/**
 * The configuration to set whether network access from public internet to the endpoints are allowed.
 */
enum KnownPublicNetworkAccessOptions {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

/**
 * The resource provisioning state. This property is READ-ONLY.
 */
enum KnownDataCollectionEndpointProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

/**
 * The resource provisioning state in this location.
 */
enum KnownLocationSpecProvisioningStatus {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

/**
 * The kind of the resource.
 */
enum KnownDataCollectionEndpointResourceKind {
  Linux,
  Windows,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * The resource provisioning state.
 */
enum KnownDataCollectionRuleAssociationProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

/**
 * The type of the column data.
 */
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

/**
 * The data format of the log files
 */
enum KnownLogFilesDataSourceFormat {
  text,
}

/**
 * One of the supported timestamp formats
 */
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

/**
 * The resource provisioning state.
 */
enum KnownDataCollectionRuleProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Canceled,
  Failed,
}

/**
 * The kind of the resource.
 */
enum KnownDataCollectionRuleResourceKind {
  Linux,
  Windows,
}

/**
 * The provisioning state of the Azure Monitor workspace. Set to Succeeded if everything is healthy.
 */
enum ProvisioningState {
  Creating,
  Succeeded,
  Deleting,
  Failed,
  Canceled,
}

/**
 * Gets or sets allow or disallow public network access to workspace
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * the criteria operator.
 */
enum Operator {
  Equals,
  GreaterThan,
  GreaterThanOrEqual,
  LessThan,
  LessThanOrEqual,
}

/**
 * Specifies the type of threshold criteria
 */
enum CriterionType {
  StaticThresholdCriterion,
  DynamicThresholdCriterion,
}

/**
 * the criteria time aggregation types.
 */
enum AggregationTypeEnum {
  Average,
  Count,
  Minimum,
  Maximum,
  Total,
}

/**
 * The operator used to compare the metric value against the threshold.
 */
enum DynamicThresholdOperator {
  GreaterThan,
  LessThan,
  GreaterOrLessThan,
}

/**
 * The extent of deviation required to trigger an alert. This will affect how tight the threshold is to the metric series pattern.
 */
enum DynamicThresholdSensitivity {
  Low,
  Medium,
  High,
}

/**
 * the metric statistic type. How the metrics from multiple instances are combined.
 */
@fixed
enum MetricStatisticType {
  Average,
  Min,
  Max,
  Sum,
  Count,
}

/**
 * time aggregation type. How the data that is collected should be combined over time. The default value is Average.
 */
@fixed
enum TimeAggregationType {
  Average,
  Minimum,
  Maximum,
  Total,
  Count,
  Last,
}

/**
 * the operator that is used to compare the metric data and the threshold.
 */
@fixed
enum ComparisonOperationType {
  Equals,
  NotEquals,
  GreaterThan,
  GreaterThanOrEqual,
  LessThan,
  LessThanOrEqual,
}

/**
 * the scale direction. Whether the scaling action increases or decreases the number of instances.
 */
@fixed
enum ScaleDirection {
  None,
  Increase,
  Decrease,
}

/**
 * the type of action that should occur when the scale rule fires.
 */
@fixed
enum ScaleType {
  ChangeCount,
  PercentChangeCount,
  ExactCount,
  ServiceAllowedNextValue,
}

/**
 * the recurrence frequency. How often the schedule profile should take effect. This value must be Week, meaning each week will have the same set of profiles. For example, to set a daily schedule, set **schedule** to every day of the week. The frequency property specifies that the schedule is repeated weekly.
 */
@fixed
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

/**
 * the predictive autoscale mode
 */
@fixed
enum PredictiveAutoscalePolicyScaleMode {
  Disabled,
  ForecastOnly,
  Enabled,
}

/**
 * Indicates the status of the receiver. Receivers that are not Enabled will not receive any communications.
 */
@fixed
enum ReceiverStatus {
  NotSpecified,
  Enabled,
  Disabled,
}

/**
 * the event level
 */
@fixed
enum EventLevel {
  Critical,
  Error,
  Warning,
  Informational,
  Verbose,
}

/**
 * the aggregation type of the metric.
 */
@fixed
enum AggregationType {
  None,
  Average,
  Count,
  Minimum,
  Maximum,
  Total,
}

@fixed
enum ResultType {
  Data,
  Metadata,
}

/**
 * The unit of the metric.
 */
@fixed
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

/**
 * Operators allowed in the rule condition.
 */
@fixed
enum ConditionOperator {
  GreaterThan,
  GreaterThanOrEqual,
  LessThan,
  LessThanOrEqual,
  Equals,
}

/**
 * Aggregation operators allowed in a rule.
 */
@fixed
enum TimeAggregationOperator {
  Average,
  Minimum,
  Maximum,
  Total,
  Last,
}

/**
 * A setting that contains all of the configuration for the automatic scaling of a resource.
 */
model AutoscaleSetting {
  /**
   * the collection of automatic scaling profiles that specify different scaling parameters for different time periods. A maximum of 20 profiles can be specified.
   */
  profiles: AutoscaleProfile[];

  /**
   * the collection of notifications.
   */
  notifications?: AutoscaleNotification[];

  /**
   * the enabled flag. Specifies whether automatic scaling is enabled for the resource. The default value is 'false'.
   */
  enabled?: boolean;

  /**
   * the predictive autoscale policy mode.
   */
  predictiveAutoscalePolicy?: PredictiveAutoscalePolicy;

  /**
   * the name of the autoscale setting.
   */
  name?: string;

  /**
   * the resource identifier of the resource that the autoscale setting should be added to.
   */
  targetResourceUri?: string;

  /**
   * the location of the resource that the autoscale setting should be added to.
   */
  targetResourceLocation?: string;
}

/**
 * Autoscale profile.
 */
model AutoscaleProfile {
  /**
   * the name of the profile.
   */
  name: string;

  /**
   * the number of instances that can be used during this profile.
   */
  capacity: ScaleCapacity;

  /**
   * the collection of rules that provide the triggers and parameters for the scaling action. A maximum of 10 rules can be specified.
   */
  rules: ScaleRule[];

  /**
   * the specific date-time for the profile. This element is not used if the Recurrence element is used.
   */
  fixedDate?: TimeWindow;

  /**
   * the repeating times at which this profile begins. This element is not used if the FixedDate element is used.
   */
  recurrence?: Recurrence;
}

/**
 * The number of instances that can be used during this profile.
 */
model ScaleCapacity {
  /**
   * the minimum number of instances for the resource.
   */
  minimum: string;

  /**
   * the maximum number of instances for the resource. The actual maximum number of instances is limited by the cores that are available in the subscription.
   */
  maximum: string;

  /**
   * the number of instances that will be set if metrics are not available for evaluation. The default is only used if the current instance count is lower than the default.
   */
  default: string;
}

/**
 * A rule that provide the triggers and parameters for the scaling action.
 */
model ScaleRule {
  /**
   * the trigger that results in a scaling action.
   */
  metricTrigger: MetricTrigger;

  /**
   * the parameters for the scaling action.
   */
  scaleAction: ScaleAction;
}

/**
 * The trigger that results in a scaling action.
 */
model MetricTrigger {
  /**
   * the name of the metric that defines what the rule monitors.
   */
  metricName: string;

  /**
   * the namespace of the metric that defines what the rule monitors.
   */
  metricNamespace?: string;

  /**
   * the resource identifier of the resource the rule monitors.
   */
  metricResourceUri: string;

  /**
   * the location of the resource the rule monitors.
   */
  metricResourceLocation?: string;

  /**
   * the granularity of metrics the rule monitors. Must be one of the predefined values returned from metric definitions for the metric. Must be between 12 hours and 1 minute.
   */
  timeGrain: duration;

  /**
   * the metric statistic type. How the metrics from multiple instances are combined.
   */
  statistic: MetricStatisticType;

  /**
   * the range of time in which instance data is collected. This value must be greater than the delay in metric collection, which can vary from resource-to-resource. Must be between 12 hours and 5 minutes.
   */
  timeWindow: duration;

  /**
   * time aggregation type. How the data that is collected should be combined over time. The default value is Average.
   */
  timeAggregation: TimeAggregationType;

  /**
   * the operator that is used to compare the metric data and the threshold.
   */
  operator: ComparisonOperationType;

  /**
   * the threshold of the metric that triggers the scale action.
   */
  threshold: float64;

  /**
   * List of dimension conditions. For example: [{"DimensionName":"AppName","Operator":"Equals","Values":["App1"]},{"DimensionName":"Deployment","Operator":"Equals","Values":["default"]}].
   */
  dimensions?: ScaleRuleMetricDimension[];

  /**
   * a value indicating whether metric should divide per instance.
   */
  dividePerInstance?: boolean;
}

/**
 * Specifies an auto scale rule metric dimension.
 */
model ScaleRuleMetricDimension {
  /**
   * Name of the dimension.
   */
  @projectedName("json", "DimensionName")
  dimensionName: string;

  /**
   * the dimension operator. Only 'Equals' and 'NotEquals' are supported. 'Equals' being equal to any of the values. 'NotEquals' being not equal to all of the values
   */
  @projectedName("json", "Operator")
  operator: ScaleRuleMetricDimensionOperationType;

  /**
   * list of dimension values. For example: ["App1","App2"].
   */
  @projectedName("json", "Values")
  values: string[];
}

/**
 * The parameters for the scaling action.
 */
model ScaleAction {
  /**
   * the scale direction. Whether the scaling action increases or decreases the number of instances.
   */
  direction: ScaleDirection;

  /**
   * the type of action that should occur when the scale rule fires.
   */
  type: ScaleType;

  /**
   * the number of instances that are involved in the scaling action. This value must be 1 or greater. The default value is 1.
   */
  value?: string = "1";

  /**
   * the amount of time to wait since the last scaling action before this action occurs. It must be between 1 week and 1 minute in ISO 8601 format.
   */
  cooldown: duration;
}

/**
 * A specific date-time for the profile.
 */
model TimeWindow {
  /**
   * the timezone of the start and end times for the profile. Some examples of valid time zones are: Dateline Standard Time, UTC-11, Hawaiian Standard Time, Alaskan Standard Time, Pacific Standard Time (Mexico), Pacific Standard Time, US Mountain Standard Time, Mountain Standard Time (Mexico), Mountain Standard Time, Central America Standard Time, Central Standard Time, Central Standard Time (Mexico), Canada Central Standard Time, SA Pacific Standard Time, Eastern Standard Time, US Eastern Standard Time, Venezuela Standard Time, Paraguay Standard Time, Atlantic Standard Time, Central Brazilian Standard Time, SA Western Standard Time, Pacific SA Standard Time, Newfoundland Standard Time, E. South America Standard Time, Argentina Standard Time, SA Eastern Standard Time, Greenland Standard Time, Montevideo Standard Time, Bahia Standard Time, UTC-02, Mid-Atlantic Standard Time, Azores Standard Time, Cape Verde Standard Time, Morocco Standard Time, UTC, GMT Standard Time, Greenwich Standard Time, W. Europe Standard Time, Central Europe Standard Time, Romance Standard Time, Central European Standard Time, W. Central Africa Standard Time, Namibia Standard Time, Jordan Standard Time, GTB Standard Time, Middle East Standard Time, Egypt Standard Time, Syria Standard Time, E. Europe Standard Time, South Africa Standard Time, FLE Standard Time, Turkey Standard Time, Israel Standard Time, Kaliningrad Standard Time, Libya Standard Time, Arabic Standard Time, Arab Standard Time, Belarus Standard Time, Russian Standard Time, E. Africa Standard Time, Iran Standard Time, Arabian Standard Time, Azerbaijan Standard Time, Russia Time Zone 3, Mauritius Standard Time, Georgian Standard Time, Caucasus Standard Time, Afghanistan Standard Time, West Asia Standard Time, Ekaterinburg Standard Time, Pakistan Standard Time, India Standard Time, Sri Lanka Standard Time, Nepal Standard Time, Central Asia Standard Time, Bangladesh Standard Time, N. Central Asia Standard Time, Myanmar Standard Time, SE Asia Standard Time, North Asia Standard Time, China Standard Time, North Asia East Standard Time, Singapore Standard Time, W. Australia Standard Time, Taipei Standard Time, Ulaanbaatar Standard Time, Tokyo Standard Time, Korea Standard Time, Yakutsk Standard Time, Cen. Australia Standard Time, AUS Central Standard Time, E. Australia Standard Time, AUS Eastern Standard Time, West Pacific Standard Time, Tasmania Standard Time, Magadan Standard Time, Vladivostok Standard Time, Russia Time Zone 10, Central Pacific Standard Time, Russia Time Zone 11, New Zealand Standard Time, UTC+12, Fiji Standard Time, Kamchatka Standard Time, Tonga Standard Time, Samoa Standard Time, Line Islands Standard Time
   */
  timeZone?: string;

  /**
   * the start time for the profile in ISO 8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start: utcDateTime;

  /**
   * the end time for the profile in ISO 8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end: utcDateTime;
}

/**
 * The repeating times at which this profile begins. This element is not used if the FixedDate element is used.
 */
model Recurrence {
  /**
   * the recurrence frequency. How often the schedule profile should take effect. This value must be Week, meaning each week will have the same set of profiles. For example, to set a daily schedule, set **schedule** to every day of the week. The frequency property specifies that the schedule is repeated weekly.
   */
  frequency: RecurrenceFrequency;

  /**
   * the scheduling constraints for when the profile begins.
   */
  schedule: RecurrentSchedule;
}

/**
 * The scheduling constraints for when the profile begins.
 */
model RecurrentSchedule {
  /**
   * the timezone for the hours of the profile. Some examples of valid time zones are: Dateline Standard Time, UTC-11, Hawaiian Standard Time, Alaskan Standard Time, Pacific Standard Time (Mexico), Pacific Standard Time, US Mountain Standard Time, Mountain Standard Time (Mexico), Mountain Standard Time, Central America Standard Time, Central Standard Time, Central Standard Time (Mexico), Canada Central Standard Time, SA Pacific Standard Time, Eastern Standard Time, US Eastern Standard Time, Venezuela Standard Time, Paraguay Standard Time, Atlantic Standard Time, Central Brazilian Standard Time, SA Western Standard Time, Pacific SA Standard Time, Newfoundland Standard Time, E. South America Standard Time, Argentina Standard Time, SA Eastern Standard Time, Greenland Standard Time, Montevideo Standard Time, Bahia Standard Time, UTC-02, Mid-Atlantic Standard Time, Azores Standard Time, Cape Verde Standard Time, Morocco Standard Time, UTC, GMT Standard Time, Greenwich Standard Time, W. Europe Standard Time, Central Europe Standard Time, Romance Standard Time, Central European Standard Time, W. Central Africa Standard Time, Namibia Standard Time, Jordan Standard Time, GTB Standard Time, Middle East Standard Time, Egypt Standard Time, Syria Standard Time, E. Europe Standard Time, South Africa Standard Time, FLE Standard Time, Turkey Standard Time, Israel Standard Time, Kaliningrad Standard Time, Libya Standard Time, Arabic Standard Time, Arab Standard Time, Belarus Standard Time, Russian Standard Time, E. Africa Standard Time, Iran Standard Time, Arabian Standard Time, Azerbaijan Standard Time, Russia Time Zone 3, Mauritius Standard Time, Georgian Standard Time, Caucasus Standard Time, Afghanistan Standard Time, West Asia Standard Time, Ekaterinburg Standard Time, Pakistan Standard Time, India Standard Time, Sri Lanka Standard Time, Nepal Standard Time, Central Asia Standard Time, Bangladesh Standard Time, N. Central Asia Standard Time, Myanmar Standard Time, SE Asia Standard Time, North Asia Standard Time, China Standard Time, North Asia East Standard Time, Singapore Standard Time, W. Australia Standard Time, Taipei Standard Time, Ulaanbaatar Standard Time, Tokyo Standard Time, Korea Standard Time, Yakutsk Standard Time, Cen. Australia Standard Time, AUS Central Standard Time, E. Australia Standard Time, AUS Eastern Standard Time, West Pacific Standard Time, Tasmania Standard Time, Magadan Standard Time, Vladivostok Standard Time, Russia Time Zone 10, Central Pacific Standard Time, Russia Time Zone 11, New Zealand Standard Time, UTC+12, Fiji Standard Time, Kamchatka Standard Time, Tonga Standard Time, Samoa Standard Time, Line Islands Standard Time
   */
  timeZone: string;

  /**
   * the collection of days that the profile takes effect on. Possible values are Sunday through Saturday.
   */
  days: MonitorDayOfWeek[];

  /**
   * A collection of hours that the profile takes effect on. Values supported are 0 to 23 on the 24-hour clock (AM/PM times are not supported).
   */
  hours: int32[];

  /**
   * A collection of minutes at which the profile takes effect at.
   */
  minutes: int32[];
}

/**
 * Autoscale notification.
 */
model AutoscaleNotification {
  /**
   * the operation associated with the notification and its value must be "scale"
   */
  operation: "Scale";

  /**
   * the email notification.
   */
  email?: EmailNotification;

  /**
   * the collection of webhook notifications.
   */
  webhooks?: WebhookNotification[];
}

/**
 * Email notification of an autoscale event.
 */
model EmailNotification {
  /**
   * a value indicating whether to send email to subscription administrator.
   */
  sendToSubscriptionAdministrator?: boolean;

  /**
   * a value indicating whether to send email to subscription co-administrators.
   */
  sendToSubscriptionCoAdministrators?: boolean;

  /**
   * the custom e-mails list. This value can be null or empty, in which case this attribute will be ignored.
   */
  customEmails?: string[];
}

/**
 * Webhook notification of an autoscale event.
 */
model WebhookNotification {
  /**
   * the service address to receive the notification.
   */
  serviceUri?: string;

  /**
   * a property bag of settings. This value can be empty.
   */
  properties?: Record<string>;
}

/**
 * The parameters for enabling predictive autoscale.
 */
model PredictiveAutoscalePolicy {
  /**
   * the predictive autoscale mode
   */
  scaleMode: PredictiveAutoscalePolicyScaleMode;

  /**
   * the amount of time to specify by which instances are launched in advance. It must be between 1 minute and 60 minutes in ISO 8601 format.
   */
  scaleLookAheadTime?: duration;
}

/**
 * The autoscale setting resource.
 */
model AutoScaleResource {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read", "create")
  location: string;

  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater in length than 128 characters and a value no greater in length than 256 characters.
   */
  tags?: Record<string>;

  /**
   * The system metadata related to the response.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Describes the format of Error response.
 */
@error
model AutoscaleErrorResponse {
  /**
   * The error object.
   */
  error?: AutoscaleErrorResponseError;

  /**
   * The system metadata related to the response.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The error object.
 */
model AutoscaleErrorResponseError {
  /**
   * One of a server-defined set of error codes.
   */
  code?: string;

  /**
   * A human-readable representation of the error.
   */
  message?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * A human-readable representation of the error's details.
   */
  details?: string;
}

/**
 * The autoscale setting object for patch operations.
 */
model AutoscaleSettingResourcePatch {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The autoscale setting properties of the update operation.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AutoscaleSetting;
}

/**
 * The response to a metrics query.
 */
model PredictiveResponse {
  /**
   * The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.
   */
  timespan?: string;

  /**
   * The interval (window size) for which the metric data was returned in.  This may be adjusted in the future and returned back from what was originally requested.  This is not present if a metadata request was made.
   */
  interval?: duration;

  /**
   * The metrics being queried
   */
  metricName?: string;

  /**
   * resource of the predictive metric.
   */
  targetResourceId?: string;

  /**
   * the value of the collection.
   */
  data?: PredictiveValue[];
}

/**
 * Represents a predictive metric value in the given bucket.
 */
model PredictiveValue {
  /**
   * the timestamp for the metric value in ISO 8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp: utcDateTime;

  /**
   * Predictive value in this time bucket.
   */
  value: float64;
}

/**
 * An alert incident indicates the activation status of an alert rule.
 */
model Incident {
  /**
   * Incident name.
   */
  @visibility("read")
  name?: string;

  /**
   * Rule name that is associated with the incident.
   */
  @visibility("read")
  ruleName?: string;

  /**
   * A boolean to indicate whether the incident is active or resolved.
   */
  @visibility("read")
  isActive?: boolean;

  /**
   * The time at which the incident was activated in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activatedTime?: utcDateTime;

  /**
   * The time at which the incident was resolved in ISO8601 format. If null, it means the incident is still active.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resolvedTime?: utcDateTime;
}

/**
 * The List incidents operation response.
 */
@pagedResult
model IncidentListResult {
  /**
   * the incident collection.
   */
  @items
  value?: Incident[];
}

/**
 * An alert rule.
 */
model AlertRule {
  /**
   * the name of the alert rule.
   */
  name: string;

  /**
   * the description of the alert rule that will be included in the alert email.
   */
  description?: string;

  /**
   * the provisioning state.
   */
  provisioningState?: string;

  /**
   * the flag that indicates whether the alert rule is enabled.
   */
  isEnabled: boolean;

  /**
   * the condition that results in the alert rule being activated.
   */
  condition: RuleCondition;

  /**
   * action that is performed when the alert rule becomes active, and when an alert condition is resolved.
   */
  action?: RuleAction;

  /**
   * the array of actions that are performed when the alert rule becomes active, and when an alert condition is resolved.
   */
  actions?: RuleAction[];

  /**
   * Last time the rule was updated in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;
}

/**
 * The condition that results in the alert rule being activated.
 */
@discriminator("odata.type")
model RuleCondition {
  /**
   * the resource from which the rule collects its data. For this type dataSource will always be of type RuleMetricDataSource.
   */
  dataSource?: RuleDataSource;
}

/**
 * The resource from which the rule collects its data.
 */
@discriminator("odata.type")
model RuleDataSource {
  /**
   * the resource identifier of the resource the rule monitors. **NOTE**: this property cannot be updated for an existing rule.
   */
  resourceUri?: string;

  /**
   * the legacy resource identifier of the resource the rule monitors. **NOTE**: this property cannot be updated for an existing rule.
   */
  legacyResourceId?: string;

  /**
   * the location of the resource.
   */
  resourceLocation?: string;

  /**
   * the namespace of the metric.
   */
  metricNamespace?: string;
}

/**
 * The action that is performed when the alert rule becomes active, and when an alert condition is resolved.
 */
@discriminator("odata.type")
model RuleAction {}

/**
 * An azure resource object
 */
model Resource {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read", "create")
  location: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * The alert rule object for patch operations.
 */
model AlertRuleResourcePatch {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The properties of an alert rule.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AlertRule;
}

/**
 * The log profile properties.
 */
model LogProfileProperties {
  /**
   * the resource id of the storage account to which you would like to send the Activity Log.
   */
  storageAccountId?: string;

  /**
   * The service bus rule ID of the service bus namespace in which you would like to have Event Hubs created for streaming the Activity Log. The rule ID is of the format: '{service bus resource ID}/authorizationrules/{key name}'.
   */
  serviceBusRuleId?: string;

  /**
   * List of regions for which Activity Log events should be stored or streamed. It is a comma separated list of valid ARM locations including the 'global' location.
   */
  locations: string[];

  /**
   * the categories of the logs. These categories are created as is convenient to the user. Some values are: 'Write', 'Delete', and/or 'Action.'
   */
  categories: string[];

  /**
   * the retention policy for the events in the log.
   */
  retentionPolicy: RetentionPolicy;
}

/**
 * Specifies the retention policy for the log.
 */
model RetentionPolicy {
  /**
   * a value indicating whether the retention policy is enabled.
   */
  enabled: boolean;

  /**
   * the number of days for the retention in days. A value of 0 will retain the events indefinitely.
   */
  days: int32;
}

/**
 * The log profile resource for patch operations.
 */
model LogProfileResourcePatch {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The log profile properties for an update operation.
   */
  @extension("x-ms-client-flatten", true)
  properties?: LogProfileProperties;
}

/**
 * The diagnostic settings.
 */
model DiagnosticSettings {
  /**
   * The resource ID of the storage account to which you would like to send Diagnostic Logs.
   */
  storageAccountId?: string;

  /**
   * The service bus rule Id of the diagnostic setting. This is here to maintain backwards compatibility.
   */
  serviceBusRuleId?: string;

  /**
   * The resource Id for the event hub authorization rule.
   */
  eventHubAuthorizationRuleId?: string;

  /**
   * The name of the event hub. If none is specified, the default event hub will be selected.
   */
  eventHubName?: string;

  /**
   * The list of metric settings.
   */
  metrics?: MetricSettings[];

  /**
   * The list of logs settings.
   */
  logs?: LogSettings[];

  /**
   * The full ARM resource ID of the Log Analytics workspace to which you would like to send Diagnostic Logs. Example: /subscriptions/4b9e8510-67ab-4e9a-95a9-e2f1e570ea9c/resourceGroups/insights-integration/providers/Microsoft.OperationalInsights/workspaces/viruela2
   */
  workspaceId?: string;

  /**
   * The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.
   */
  marketplacePartnerId?: string;

  /**
   * A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type constructed as follows: <normalized service identity>_<normalized category name>. Possible values are: Dedicated and null (null is default.)
   */
  logAnalyticsDestinationType?: string;
}

/**
 * Part of MultiTenantDiagnosticSettings. Specifies the settings for a particular metric.
 */
model MetricSettings {
  /**
   * the timegrain of the metric in ISO8601 format.
   */
  timeGrain?: duration;

  /**
   * Name of a Diagnostic Metric category for a resource type this setting is applied to. To obtain the list of Diagnostic metric categories for a resource, first perform a GET diagnostic settings operation.
   */
  category?: string;

  /**
   * a value indicating whether this category is enabled.
   */
  enabled: boolean;

  /**
   * the retention policy for this category.
   */
  retentionPolicy?: RetentionPolicy;
}

/**
 * Part of MultiTenantDiagnosticSettings. Specifies the settings for a particular log.
 */
model LogSettings {
  /**
   * Name of a Diagnostic Log category for a resource type this setting is applied to. To obtain the list of Diagnostic Log categories for a resource, first perform a GET diagnostic settings operation.
   */
  category?: string;

  /**
   * Name of a Diagnostic Log category group for a resource type this setting is applied to. To obtain the list of Diagnostic Log categories for a resource, first perform a GET diagnostic settings operation.
   */
  categoryGroup?: string;

  /**
   * a value indicating whether this log is enabled.
   */
  enabled: boolean;

  /**
   * the retention policy for this log.
   */
  retentionPolicy?: RetentionPolicy;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model CommonResource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * The diagnostic settings Category.
 */
model DiagnosticSettingsCategory {
  /**
   * The type of the diagnostic settings category.
   */
  categoryType?: CategoryType;

  /**
   * the collection of what category groups are supported.
   */
  categoryGroups?: string[];
}

/**
 * An Azure action group.
 */
model ActionGroup {
  /**
   * The short name of the action group. This will be used in SMS messages.
   */
  @maxLength(12)
  groupShortName: string;

  /**
   * Indicates whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications.
   */
  enabled: boolean = true;

  /**
   * The list of email receivers that are part of this action group.
   */
  emailReceivers?: EmailReceiver[];

  /**
   * The list of SMS receivers that are part of this action group.
   */
  smsReceivers?: SmsReceiver[];

  /**
   * The list of webhook receivers that are part of this action group.
   */
  webhookReceivers?: WebhookReceiver[];

  /**
   * The list of ITSM receivers that are part of this action group.
   */
  itsmReceivers?: ItsmReceiver[];

  /**
   * The list of AzureAppPush receivers that are part of this action group.
   */
  azureAppPushReceivers?: AzureAppPushReceiver[];

  /**
   * The list of AutomationRunbook receivers that are part of this action group.
   */
  automationRunbookReceivers?: AutomationRunbookReceiver[];

  /**
   * The list of voice receivers that are part of this action group.
   */
  voiceReceivers?: VoiceReceiver[];

  /**
   * The list of logic app receivers that are part of this action group.
   */
  logicAppReceivers?: LogicAppReceiver[];

  /**
   * The list of azure function receivers that are part of this action group.
   */
  azureFunctionReceivers?: AzureFunctionReceiver[];

  /**
   * The list of ARM role receivers that are part of this action group. Roles are Azure RBAC roles and only built-in roles are supported.
   */
  armRoleReceivers?: ArmRoleReceiver[];

  /**
   * The list of event hub receivers that are part of this action group.
   */
  eventHubReceivers?: EventHubReceiver[];
}

/**
 * An email receiver.
 */
model EmailReceiver {
  /**
   * The name of the email receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The email address of this receiver.
   */
  emailAddress: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean;

  /**
   * The receiver status of the e-mail.
   */
  @visibility("read")
  status?: ReceiverStatus;
}

/**
 * An SMS receiver.
 */
model SmsReceiver {
  /**
   * The name of the SMS receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The country code of the SMS receiver.
   */
  countryCode: string;

  /**
   * The phone number of the SMS receiver.
   */
  phoneNumber: string;

  /**
   * The status of the receiver.
   */
  @visibility("read")
  status?: ReceiverStatus;
}

/**
 * A webhook receiver.
 */
model WebhookReceiver {
  /**
   * The name of the webhook receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The URI where webhooks should be sent.
   */
  serviceUri: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean;

  /**
   * Indicates whether or not use AAD authentication.
   */
  useAadAuth?: boolean;

  /**
   * Indicates the webhook app object Id for aad auth.
   */
  objectId?: string;

  /**
   * Indicates the identifier uri for aad auth.
   */
  identifierUri?: string;

  /**
   * Indicates the tenant id for aad auth.
   */
  tenantId?: string;
}

/**
 * An Itsm receiver.
 */
model ItsmReceiver {
  /**
   * The name of the Itsm receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * OMS LA instance identifier.
   */
  workspaceId: string;

  /**
   * Unique identification of ITSM connection among multiple defined in above workspace.
   */
  connectionId: string;

  /**
   * JSON blob for the configurations of the ITSM action. CreateMultipleWorkItems option will be part of this blob as well.
   */
  ticketConfiguration: string;

  /**
   * Region in which workspace resides. Supported values:'centralindia','japaneast','southeastasia','australiasoutheast','uksouth','westcentralus','canadacentral','eastus','westeurope'
   */
  region: string;
}

/**
 * The Azure mobile App push notification receiver.
 */
model AzureAppPushReceiver {
  /**
   * The name of the Azure mobile app push receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The email address registered for the Azure mobile app.
   */
  emailAddress: string;
}

/**
 * The Azure Automation Runbook notification receiver.
 */
model AutomationRunbookReceiver {
  /**
   * The Azure automation account Id which holds this runbook and authenticate to Azure resource.
   */
  automationAccountId: string;

  /**
   * The name for this runbook.
   */
  runbookName: string;

  /**
   * The resource id for webhook linked to this runbook.
   */
  webhookResourceId: string;

  /**
   * Indicates whether this instance is global runbook.
   */
  isGlobalRunbook: boolean;

  /**
   * Indicates name of the webhook.
   */
  name?: string;

  /**
   * The URI where webhooks should be sent.
   */
  serviceUri?: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean;
}

/**
 * A voice receiver.
 */
model VoiceReceiver {
  /**
   * The name of the voice receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The country code of the voice receiver.
   */
  countryCode: string;

  /**
   * The phone number of the voice receiver.
   */
  phoneNumber: string;
}

/**
 * A logic app receiver.
 */
model LogicAppReceiver {
  /**
   * The name of the logic app receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The azure resource id of the logic app receiver.
   */
  resourceId: string;

  /**
   * The callback url where http request sent to.
   */
  callbackUrl: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean;
}

/**
 * An azure function receiver.
 */
model AzureFunctionReceiver {
  /**
   * The name of the azure function receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The azure resource id of the function app.
   */
  functionAppResourceId: string;

  /**
   * The function name in the function app.
   */
  functionName: string;

  /**
   * The http trigger url where http request sent to.
   */
  httpTriggerUrl: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean;
}

/**
 * An arm role receiver.
 */
model ArmRoleReceiver {
  /**
   * The name of the arm role receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The arm role id.
   */
  roleId: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean;
}

/**
 * An Event hub receiver.
 */
model EventHubReceiver {
  /**
   * The name of the Event hub receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The Event Hub namespace
   */
  eventHubNameSpace: string;

  /**
   * The name of the specific Event Hub queue
   */
  eventHubName: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean;

  /**
   * The tenant Id for the subscription containing this event hub
   */
  tenantId?: string;

  /**
   * The Id for the subscription containing this event hub
   */
  subscriptionId: string;
}

/**
 * An azure resource object
 */
model AzureResource {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read", "create")
  location: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * An action group object for the body of patch operations.
 */
model ActionGroupPatchBody {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The action group settings for an update operation.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ActionGroupPatch;
}

/**
 * An Azure action group for patch operations.
 */
model ActionGroupPatch {
  /**
   * Indicates whether this action group is enabled. If an action group is not enabled, then none of its actions will be activated.
   */
  enabled?: boolean = true;
}

/**
 * The request body which contain contact detail metadata
 */
model NotificationRequestBody {
  /**
   * The value of the supported alert type. Supported alert type values are: servicehealth, metricstaticthreshold, metricsdynamicthreshold, logalertv2, smartalert, webtestalert, logalertv1numresult, logalertv1metricmeasurement, resourcehealth, activitylog, actualcostbudget, forecastedbudget
   */
  @maxLength(30)
  alertType: string;

  /**
   * The list of email receivers that are part of this action group.
   */
  emailReceivers?: EmailReceiver[];

  /**
   * The list of SMS receivers that are part of this action group.
   */
  smsReceivers?: SmsReceiver[];

  /**
   * The list of webhook receivers that are part of this action group.
   */
  webhookReceivers?: WebhookReceiver[];

  /**
   * The list of ITSM receivers that are part of this action group.
   */
  itsmReceivers?: ItsmReceiver[];

  /**
   * The list of AzureAppPush receivers that are part of this action group.
   */
  azureAppPushReceivers?: AzureAppPushReceiver[];

  /**
   * The list of AutomationRunbook receivers that are part of this action group.
   */
  automationRunbookReceivers?: AutomationRunbookReceiver[];

  /**
   * The list of voice receivers that are part of this action group.
   */
  voiceReceivers?: VoiceReceiver[];

  /**
   * The list of logic app receivers that are part of this action group.
   */
  logicAppReceivers?: LogicAppReceiver[];

  /**
   * The list of azure function receivers that are part of this action group.
   */
  azureFunctionReceivers?: AzureFunctionReceiver[];

  /**
   * The list of ARM role receivers that are part of this action group. Roles are Azure RBAC roles and only built-in roles are supported.
   */
  armRoleReceivers?: ArmRoleReceiver[];

  /**
   * The list of event hub receivers that are part of this action group.
   */
  eventHubReceivers?: EventHubReceiver[];
}

/**
 * The details of the test notification results.
 */
model TestNotificationDetailsResponse {
  /**
   * The context info
   */
  context?: Context;

  /**
   * The overall state
   */
  state: string;

  /**
   * The completed time
   */
  completedTime?: string;

  /**
   * The created time
   */
  createdTime?: string;

  /**
   * The list of action detail
   */
  actionDetails?: ActionDetail[];
}

/**
 * The context info
 */
model Context {
  /**
   * The source of the notification request
   */
  notificationSource?: string;

  /**
   * The context id type
   */
  contextType?: string;
}

/**
 * The action detail
 */
model ActionDetail {
  /**
   * The mechanism type
   */
  @projectedName("json", "MechanismType")
  mechanismType?: string;

  /**
   * The name of the action
   */
  @projectedName("json", "Name")
  name?: string;

  /**
   * The status of the action
   */
  @projectedName("json", "Status")
  status?: string;

  /**
   * The substatus of the action
   */
  @projectedName("json", "SubState")
  subState?: string;

  /**
   * The send time
   */
  @projectedName("json", "SendTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sendTime?: utcDateTime;

  /**
   * The detail of the friendly error message
   */
  @projectedName("json", "Detail")
  detail?: string;
}

/**
 * Describes a receiver that should be resubscribed.
 */
model EnableRequest {
  /**
   * The name of the receiver to resubscribe.
   */
  receiverName: string;
}

/**
 * Represents collection of events.
 */
model EventDataCollection is Azure.Core.Page<EventData>;

/**
 * The Azure event log entries are of type EventData
 */
model EventData {
  /**
   * The sender authorization information.
   */
  @visibility("read")
  authorization?: SenderAuthorization;

  /**
   * key value pairs to identify ARM permissions.
   */
  @visibility("read")
  claims?: Record<string>;

  /**
   * the email address of the user who has performed the operation, the UPN claim or SPN claim based on availability.
   */
  @visibility("read")
  caller?: string;

  /**
   * the description of the event.
   */
  @visibility("read")
  description?: string;

  /**
   * the Id of this event as required by ARM for RBAC. It contains the EventDataID and a timestamp information.
   */
  @visibility("read")
  id?: string;

  /**
   * the event data Id. This is a unique identifier for an event.
   */
  @visibility("read")
  eventDataId?: string;

  /**
   * the correlation Id, usually a GUID in the string format. The correlation Id is shared among the events that belong to the same uber operation.
   */
  @visibility("read")
  correlationId?: string;

  /**
   * the event name. This value should not be confused with OperationName. For practical purposes, OperationName might be more appealing to end users.
   */
  @visibility("read")
  eventName?: LocalizableString;

  /**
   * the event category.
   */
  @visibility("read")
  category?: LocalizableString;

  /**
   * the HTTP request info. Usually includes the 'clientRequestId', 'clientIpAddress' (IP address of the user who initiated the event) and 'method' (HTTP method e.g. PUT).
   */
  @visibility("read")
  httpRequest?: HttpRequestInfo;

  /**
   * the event level
   */
  @visibility("read")
  level?: EventLevel;

  /**
   * the resource group name of the impacted resource.
   */
  @visibility("read")
  resourceGroupName?: string;

  /**
   * the resource provider name of the impacted resource.
   */
  @visibility("read")
  resourceProviderName?: LocalizableString;

  /**
   * the resource uri that uniquely identifies the resource that caused this event.
   */
  @visibility("read")
  resourceId?: string;

  /**
   * the resource type
   */
  @visibility("read")
  resourceType?: LocalizableString;

  /**
   * It is usually a GUID shared among the events corresponding to single operation. This value should not be confused with EventName.
   */
  @visibility("read")
  operationId?: string;

  /**
   * the operation name.
   */
  @visibility("read")
  operationName?: LocalizableString;

  /**
   * the set of <Key, Value> pairs (usually a Dictionary<String, String>) that includes details about the event.
   */
  @visibility("read")
  properties?: Record<string>;

  /**
   * a string describing the status of the operation. Some typical values are: Started, In progress, Succeeded, Failed, Resolved.
   */
  @visibility("read")
  status?: LocalizableString;

  /**
   * the event sub status. Most of the time, when included, this captures the HTTP status code of the REST call. Common values are: OK (HTTP Status Code: 200), Created (HTTP Status Code: 201), Accepted (HTTP Status Code: 202), No Content (HTTP Status Code: 204), Bad Request(HTTP Status Code: 400), Not Found (HTTP Status Code: 404), Conflict (HTTP Status Code: 409), Internal Server Error (HTTP Status Code: 500), Service Unavailable (HTTP Status Code:503), Gateway Timeout (HTTP Status Code: 504)
   */
  @visibility("read")
  subStatus?: LocalizableString;

  /**
   * the timestamp of when the event was generated by the Azure service processing the request corresponding the event. It in ISO 8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTimestamp?: utcDateTime;

  /**
   * the timestamp of when the event became available for querying via this API. It is in ISO 8601 format. This value should not be confused eventTimestamp. As there might be a delay between the occurrence time of the event, and the time that the event is submitted to the Azure logging infrastructure.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submissionTimestamp?: utcDateTime;

  /**
   * the Azure subscription Id usually a GUID.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * the Azure tenant Id
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * the authorization used by the user who has performed the operation that led to this event. This captures the RBAC properties of the event. These usually include the 'action', 'role' and the 'scope'
 */
model SenderAuthorization {
  /**
   * the permissible actions. For instance: microsoft.support/supporttickets/write
   */
  action?: string;

  /**
   * the role of the user. For instance: Subscription Admin
   */
  role?: string;

  /**
   * the scope.
   */
  scope?: string;
}

/**
 * The localizable string class.
 */
model LocalizableString {
  /**
   * the invariant value.
   */
  value: string;

  /**
   * the locale specific value.
   */
  localizedValue?: string;
}

/**
 * The Http request info.
 */
model HttpRequestInfo {
  /**
   * the client request id.
   */
  clientRequestId?: string;

  /**
   * the client Ip Address
   */
  clientIpAddress?: string;

  /**
   * the Http request method.
   */
  method?: string;

  /**
   * the Uri.
   */
  uri?: string;
}

/**
 * A collection of event categories. Currently possible values are: Administrative, Security, ServiceHealth, Alert, Recommendation, Policy.
 */
@pagedResult
model EventCategoryCollection {
  /**
   * the list that includes the Azure event categories.
   */
  @items
  value: LocalizableString[];
}

/**
 * Represents collection of metric definitions.
 */
@pagedResult
model MetricDefinitionCollection {
  /**
   * the values for the metric definitions.
   */
  @items
  value: MetricDefinition[];
}

/**
 * Metric definition class specifies the metadata for a metric.
 */
model MetricDefinition {
  /**
   * Flag to indicate whether the dimension is required.
   */
  isDimensionRequired?: boolean;

  /**
   * the resource identifier of the resource that emitted the metric.
   */
  resourceId?: string;

  /**
   * the namespace the metric belongs to.
   */
  `namespace`?: string;

  /**
   * the name and the display name of the metric, i.e. it is a localizable string.
   */
  name?: LocalizableString;

  /**
   * Detailed description of this metric.
   */
  displayDescription?: string;

  /**
   * Custom category name for this metric.
   */
  category?: string;

  /**
   * The class of the metric.
   */
  metricClass?: MetricClass;

  /**
   * The unit of the metric.
   */
  unit?: MetricUnit;

  /**
   * the primary aggregation type value defining how to use the values for display.
   */
  primaryAggregationType?: AggregationType;

  /**
   * the collection of what aggregation types are supported.
   */
  supportedAggregationTypes?: AggregationType[];

  /**
   * the collection of what aggregation intervals are available to be queried.
   */
  metricAvailabilities?: MetricAvailability[];

  /**
   * the resource identifier of the metric definition.
   */
  id?: string;

  /**
   * the name and the display name of the dimension, i.e. it is a localizable string.
   */
  dimensions?: LocalizableString[];
}

/**
 * Metric availability specifies the time grain (aggregation interval or frequency) and the retention period for that time grain.
 */
model MetricAvailability {
  /**
   * the time grain specifies the aggregation interval for the metric. Expressed as a duration 'PT1M', 'P1D', etc.
   */
  timeGrain?: duration;

  /**
   * the retention period for the metric at the specified timegrain.  Expressed as a duration 'PT1M', 'P1D', etc.
   */
  retention?: duration;
}

/**
 * The response to a subscription scope metrics query.
 */
model SubscriptionScopeMetricResponse {
  /**
   * The integer value representing the relative cost of the query.
   */
  cost?: int32;

  /**
   * The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.
   */
  timespan: string;

  /**
   * The interval (window size) for which the metric data was returned in.  This may be adjusted in the future and returned back from what was originally requested.  This is not present if a metadata request was made.
   */
  interval?: duration;

  /**
   * The namespace of the metrics being queried
   */
  `namespace`?: string;

  /**
   * The region of the resource being queried for metrics.
   */
  resourceregion?: string;

  /**
   * the value of the collection.
   */
  value: SubscriptionScopeMetric[];
}

/**
 * The result data of a query.
 */
model SubscriptionScopeMetric {
  /**
   * the metric Id.
   */
  id: string;

  /**
   * the resource type of the metric resource.
   */
  type: string;

  /**
   * the name and the display name of the metric, i.e. it is localizable string.
   */
  name: LocalizableString;

  /**
   * Detailed description of this metric.
   */
  displayDescription?: string;

  /**
   * 'Success' or the error details on query failures for this metric.
   */
  errorCode?: string;

  /**
   * Error message encountered querying this specific metric.
   */
  errorMessage?: string;

  /**
   * The unit of the metric.
   */
  unit: MetricUnit;

  /**
   * the time series returned when a data query is performed.
   */
  timeseries: TimeSeriesElement[];
}

/**
 * A time series result type. The discriminator value is always TimeSeries in this case.
 */
model TimeSeriesElement {
  /**
   * the metadata values returned if $filter was specified in the call.
   */
  metadatavalues?: MetadataValue[];

  /**
   * An array of data points representing the metric values.  This is only returned if a result type of data is specified.
   */
  data?: MetricValue[];
}

/**
 * Represents a metric metadata value.
 */
model MetadataValue {
  /**
   * the name of the metadata.
   */
  name?: LocalizableString;

  /**
   * the value of the metadata.
   */
  value?: string;
}

/**
 * Represents a metric value.
 */
model MetricValue {
  /**
   * the timestamp for the metric value in ISO 8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp: utcDateTime;

  /**
   * the average value in the time range.
   */
  average?: float64;

  /**
   * the least value in the time range.
   */
  minimum?: float64;

  /**
   * the greatest value in the time range.
   */
  maximum?: float64;

  /**
   * the sum of all of the values in the time range.
   */
  total?: float64;

  /**
   * the number of samples in the time range. Can be used to determine the number of values that contributed to the average value.
   */
  count?: float64;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)
 */
@error
model CommonErrorContract {
  /**
   * The error object.
   */
  error?: ErrorResponse;
}

/**
 * Query parameters can also be specified in the body, specifying the same parameter in both the body and query parameters will result in an error.
 */
model SubscriptionScopeMetricsRequestBodyParameters {
  /**
   * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
   */
  timespan?: plainTime;

  /**
   * The interval (i.e. timegrain) of the query.
   */
  interval?: duration;

  /**
   * The names of the metrics (comma separated) to retrieve.
   */
  metricNames?: string;

  /**
   * The list of aggregation types (comma separated) to retrieve.
   */
  aggregation?: string;

  /**
   * The **$filter** is used to reduce the set of metric data returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all time series of C where A = a1 and B = b1 or b2<br>**$filter=A eq ‘a1’ and B eq ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical or operator cannot separate two different metadata names.<br>- Return all time series where A = a1, B = b1 and C = c1:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘c1’**<br>- Return all time series where A = a1<br>**$filter=A eq ‘a1’ and B eq ‘*’ and C eq ‘*’**.
   */
  filter?: string;

  /**
   * The maximum number of records to retrieve.
   * Valid only if $filter is specified.
   * Defaults to 10.
   */
  top?: int32;

  /**
   * The aggregation to use for sorting results and the direction of the sort.
   * Only one order can be specified.
   * Examples: sum asc.
   */
  orderBy?: string;

  /**
   * Dimension name(s) to rollup results by. For example if you only want to see metric values with a filter like 'City eq Seattle or City eq Tacoma' but don't want to see separate values for each city, you can specify 'RollUpBy=City' to see the results for Seattle and Tacoma rolled up into one timeseries.
   */
  rollUpBy?: string;

  /**
   * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
   */
  resultType?: MetricResultType;

  /**
   * Metric namespace where the metrics you want reside.
   */
  metricNamespace?: string;

  /**
   * When set to true, if the timespan passed in is not supported by this metric, the API will return the result using the closest supported timespan. When set to false, an error is returned for invalid timespan parameters. Defaults to false.
   */
  autoAdjustTimegrain?: boolean;

  /**
   * When set to false, invalid filter parameter values will be ignored. When set to true, an error is returned for invalid filter parameters. Defaults to true.
   */
  validateDimensions?: boolean;
}

/**
 * The response to a metrics query.
 */
model Response {
  /**
   * The integer value representing the relative cost of the query.
   */
  cost?: int32;

  /**
   * The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.
   */
  timespan: string;

  /**
   * The interval (window size) for which the metric data was returned in.  This may be adjusted in the future and returned back from what was originally requested.  This is not present if a metadata request was made.
   */
  interval?: duration;

  /**
   * The namespace of the metrics being queried
   */
  `namespace`?: string;

  /**
   * The region of the resource being queried for metrics.
   */
  resourceregion?: string;

  /**
   * the value of the collection.
   */
  value: Metric[];
}

/**
 * The result data of a query.
 */
model Metric {
  /**
   * the metric Id.
   */
  id: string;

  /**
   * the resource type of the metric resource.
   */
  type: string;

  /**
   * the name and the display name of the metric, i.e. it is localizable string.
   */
  name: LocalizableString;

  /**
   * Detailed description of this metric.
   */
  displayDescription?: string;

  /**
   * 'Success' or the error details on query failures for this metric.
   */
  errorCode?: string;

  /**
   * Error message encountered querying this specific metric.
   */
  errorMessage?: string;

  /**
   * The unit of the metric.
   */
  unit: Unit;

  /**
   * the time series returned when a data query is performed.
   */
  timeseries: TimeSeriesElement[];
}

/**
 * A list of metric baselines.
 */
@pagedResult
model MetricBaselinesResponse {
  /**
   * The list of metric baselines.
   */
  @items
  value?: SingleMetricBaseline[];
}

/**
 * The baseline results of a single metric.
 */
model SingleMetricBaseline {
  /**
   * The metric baseline Id.
   */
  id: string;

  /**
   * The resource type of the metric baseline resource.
   */
  type: string;

  /**
   * The name of the metric for which the baselines were retrieved.
   */
  name: string;

  /**
   * The metric baseline properties of the metric.
   */
  @extension("x-ms-client-flatten", true)
  properties: MetricBaselinesProperties;
}

/**
 * The response to a metric baselines query.
 */
model MetricBaselinesProperties {
  /**
   * The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.
   */
  timespan: string;

  /**
   * The interval (window size) for which the metric data was returned in.  This may be adjusted in the future and returned back from what was originally requested.  This is not present if a metadata request was made.
   */
  interval: duration;

  /**
   * The namespace of the metrics been queried.
   */
  `namespace`?: string;

  /**
   * The baseline for each time series that was queried.
   */
  baselines: TimeSeriesBaseline[];
}

/**
 * The baseline values for a single time series.
 */
model TimeSeriesBaseline {
  /**
   * The aggregation type of the metric.
   */
  aggregation: string;

  /**
   * The dimensions of this time series.
   */
  dimensions?: MetricSingleDimension[];

  /**
   * The list of timestamps of the baselines.
   */
  timestamps: utcDateTime[];

  /**
   * The baseline values for each sensitivity.
   */
  data: SingleBaseline[];

  /**
   * The baseline metadata values.
   */
  metadataValues?: BaselineMetadata[];
}

/**
 * The metric dimension name and value.
 */
model MetricSingleDimension {
  /**
   * Name of the dimension.
   */
  name: string;

  /**
   * Value of the dimension.
   */
  value: string;
}

/**
 * The baseline values for a single sensitivity value.
 */
model SingleBaseline {
  /**
   * the sensitivity of the baseline.
   */
  sensitivity: BaselineSensitivity;

  /**
   * The low thresholds of the baseline.
   */
  lowThresholds: float64[];

  /**
   * The high thresholds of the baseline.
   */
  highThresholds: float64[];
}

/**
 * Represents a baseline metadata value.
 */
model BaselineMetadata {
  /**
   * Name of the baseline metadata.
   */
  name: string;

  /**
   * Value of the baseline metadata.
   */
  value: string;
}

/**
 * An alert rule.
 */
model MetricAlertProperties {
  /**
   * the description of the metric alert that will be included in the alert email.
   */
  description?: string;

  /**
   * Alert severity {0, 1, 2, 3, 4}
   */
  severity: int32;

  /**
   * the flag that indicates whether the metric alert is enabled.
   */
  enabled: boolean;

  /**
   * the list of resource id's that this metric alert is scoped to.
   */
  scopes: string[];

  /**
   * how often the metric alert is evaluated represented in ISO 8601 duration format.
   */
  evaluationFrequency: duration;

  /**
   * the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.
   */
  windowSize: duration;

  /**
   * the resource type of the target resource(s) on which the alert is created/updated. Mandatory if the scope contains a subscription, resource group, or more than one resource.
   */
  targetResourceType?: string;

  /**
   * the region of the target resource(s) on which the alert is created/updated. Mandatory if the scope contains a subscription, resource group, or more than one resource.
   */
  targetResourceRegion?: string;

  /**
   * defines the specific alert criteria information.
   */
  criteria: MetricAlertCriteria;

  /**
   * the flag that indicates whether the alert should be auto resolved or not. The default is true.
   */
  autoMitigate?: boolean;

  /**
   * the array of actions that are performed when the alert rule becomes active, and when an alert condition is resolved.
   */
  actions?: MetricAlertAction[];

  /**
   * Last time the rule was updated in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * the value indicating whether this alert rule is migrated.
   */
  @visibility("read")
  isMigrated?: boolean;
}

/**
 * The rule criteria that defines the conditions of the alert rule.
 */
@discriminator("odata.type")
model MetricAlertCriteria extends Record<Record<unknown>> {}

/**
 * An alert action.
 */
model MetricAlertAction {
  /**
   * the id of the action group to use.
   */
  actionGroupId?: string;

  /**
   * This field allows specifying custom properties, which would be appended to the alert payload sent as input to the webhook.
   */
  webHookProperties?: Record<string>;
}

/**
 * The metric alert resource for patch operations.
 */
model MetricAlertResourcePatch {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The alert rule properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MetricAlertPropertiesPatch;
}

/**
 * An alert rule properties for patch.
 */
model MetricAlertPropertiesPatch {
  /**
   * the description of the metric alert that will be included in the alert email.
   */
  description?: string;

  /**
   * Alert severity {0, 1, 2, 3, 4}
   */
  severity?: int32;

  /**
   * the flag that indicates whether the metric alert is enabled.
   */
  enabled?: boolean;

  /**
   * the list of resource id's that this metric alert is scoped to.
   */
  scopes?: string[];

  /**
   * how often the metric alert is evaluated represented in ISO 8601 duration format.
   */
  evaluationFrequency?: duration;

  /**
   * the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.
   */
  windowSize?: duration;

  /**
   * the resource type of the target resource(s) on which the alert is created/updated. Mandatory for MultipleResourceMultipleMetricCriteria.
   */
  targetResourceType?: string;

  /**
   * the region of the target resource(s) on which the alert is created/updated. Mandatory for MultipleResourceMultipleMetricCriteria.
   */
  targetResourceRegion?: string;

  /**
   * defines the specific alert criteria information.
   */
  criteria?: MetricAlertCriteria;

  /**
   * the flag that indicates whether the alert should be auto resolved or not. The default is true.
   */
  autoMitigate?: boolean;

  /**
   * the array of actions that are performed when the alert rule becomes active, and when an alert condition is resolved.
   */
  actions?: MetricAlertAction[];

  /**
   * Last time the rule was updated in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * the value indicating whether this alert rule is migrated.
   */
  @visibility("read")
  isMigrated?: boolean;
}

/**
 * Represents a collection of alert rule resources.
 */
model MetricAlertStatusCollection {
  /**
   * the values for the alert rule resources.
   */
  value?: MetricAlertStatus[];
}

/**
 * An alert status.
 */
model MetricAlertStatus {
  /**
   * The status name.
   */
  name?: string;

  /**
   * The alert rule arm id.
   */
  id?: string;

  /**
   * The extended resource type name.
   */
  type?: string;

  /**
   * The alert status properties of the metric alert status.
   */
  properties?: MetricAlertStatusProperties;
}

/**
 * An alert status properties.
 */
model MetricAlertStatusProperties {
  /**
   * An object describing the type of the dimensions.
   */
  dimensions?: Record<string>;

  /**
   * status value
   */
  status?: string;

  /**
   * UTC time when the status was checked.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;
}

/**
 * scheduled query rule Definition
 */
model ScheduledQueryRuleProperties {
  /**
   * The api-version used when creating this alert rule
   */
  @visibility("read")
  createdWithApiVersion?: string;

  /**
   * True if alert rule is legacy Log Analytic rule
   */
  @visibility("read")
  isLegacyLogAnalyticsRule?: boolean;

  /**
   * The description of the scheduled query rule.
   */
  description?: string;

  /**
   * The display name of the alert rule
   */
  displayName?: string;

  /**
   * Severity of the alert. Should be an integer between [0-4]. Value of 0 is severest. Relevant and required only for rules of the kind LogAlert.
   */
  severity?: AlertSeverity;

  /**
   * The flag which indicates whether this scheduled query rule is enabled. Value should be true or false
   */
  enabled?: boolean;

  /**
   * The list of resource id's that this scheduled query rule is scoped to.
   */
  scopes?: string[];

  /**
   * How often the scheduled query rule is evaluated represented in ISO 8601 duration format. Relevant and required only for rules of the kind LogAlert.
   */
  evaluationFrequency?: duration;

  /**
   * The period of time (in ISO 8601 duration format) on which the Alert query will be executed (bin size). Relevant and required only for rules of the kind LogAlert.
   */
  windowSize?: duration;

  /**
   * If specified then overrides the query time range (default is WindowSize*NumberOfEvaluationPeriods). Relevant only for rules of the kind LogAlert.
   */
  overrideQueryTimeRange?: duration;

  /**
   * List of resource type of the target resource(s) on which the alert is created/updated. For example if the scope is a resource group and targetResourceTypes is Microsoft.Compute/virtualMachines, then a different alert will be fired for each virtual machine in the resource group which meet the alert criteria. Relevant only for rules of the kind LogAlert
   */
  targetResourceTypes?: string[];

  /**
   * The rule criteria that defines the conditions of the scheduled query rule.
   */
  criteria?: ScheduledQueryRuleCriteria;

  /**
   * Mute actions for the chosen period of time (in ISO 8601 duration format) after the alert is fired. Relevant only for rules of the kind LogAlert.
   */
  muteActionsDuration?: duration;

  /**
   * Actions to invoke when the alert fires.
   */
  actions?: Actions;

  /**
   * The flag which indicates whether this scheduled query rule has been configured to be stored in the customer's storage. The default is false.
   */
  @visibility("read")
  isWorkspaceAlertsStorageConfigured?: boolean;

  /**
   * The flag which indicates whether this scheduled query rule should be stored in the customer's storage. The default is false. Relevant only for rules of the kind LogAlert.
   */
  checkWorkspaceAlertsStorageConfigured?: boolean;

  /**
   * The flag which indicates whether the provided query should be validated or not. The default is false. Relevant only for rules of the kind LogAlert.
   */
  skipQueryValidation?: boolean;

  /**
   * The flag that indicates whether the alert should be automatically resolved or not. The default is true. Relevant only for rules of the kind LogAlert.
   */
  autoMitigate?: boolean;
}

/**
 * The rule criteria that defines the conditions of the scheduled query rule.
 */
model ScheduledQueryRuleCriteria {
  /**
   * A list of conditions to evaluate against the specified scopes
   */
  allOf?: Condition[];
}

/**
 * A condition of the scheduled query rule.
 */
model Condition {
  /**
   * Log query alert
   */
  query?: string;

  /**
   * Aggregation type. Relevant and required only for rules of the kind LogAlert.
   */
  timeAggregation?: TimeAggregation;

  /**
   * The column containing the metric measure number. Relevant only for rules of the kind LogAlert.
   */
  metricMeasureColumn?: string;

  /**
   * The column containing the resource id. The content of the column must be a uri formatted as resource id. Relevant only for rules of the kind LogAlert.
   */
  resourceIdColumn?: string;

  /**
   * List of Dimensions conditions
   */
  dimensions?: Dimension[];

  /**
   * The criteria operator. Relevant and required only for rules of the kind LogAlert.
   */
  operator?: ConditionOperator;

  /**
   * the criteria threshold value that activates the alert. Relevant and required only for rules of the kind LogAlert.
   */
  threshold?: float64;

  /**
   * The minimum number of violations required within the selected lookback time window required to raise an alert. Relevant only for rules of the kind LogAlert.
   */
  failingPeriods?: ConditionFailingPeriods;

  /**
   * The name of the metric to be sent. Relevant and required only for rules of the kind LogToMetric.
   */
  metricName?: string;
}

/**
 * Dimension splitting and filtering definition
 */
model Dimension {
  /**
   * Name of the dimension
   */
  name: string;

  /**
   * Operator for dimension values
   */
  operator: DimensionOperator;

  /**
   * List of dimension values
   */
  values: string[];
}

/**
 * The minimum number of violations required within the selected lookback time window required to raise an alert. Relevant only for rules of the kind LogAlert.
 */
model ConditionFailingPeriods {
  /**
   * The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (windowSize) and the selected number of aggregated points. Default value is 1
   */
  numberOfEvaluationPeriods?: int64 = 1;

  /**
   * The number of violations to trigger an alert. Should be smaller or equal to numberOfEvaluationPeriods. Default value is 1
   */
  minFailingPeriodsToAlert?: int64 = 1;
}

/**
 * Actions to invoke when the alert fires.
 */
model Actions {
  /**
   * Action Group resource Ids to invoke when the alert fires.
   */
  actionGroups?: string[];

  /**
   * The properties of an alert payload.
   */
  customProperties?: Record<string>;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorContract {
  /**
   * The error details.
   */
  error?: ErrorResponseDetails;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)
 */
model ErrorResponseDetails {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error target.
   */
  @visibility("read")
  target?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: ErrorResponseDetails[];

  /**
   * The error additional info.
   */
  @visibility("read")
  additionalInfo?: ErrorResponseAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorResponseAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility("read")
  type?: string;

  /**
   * The additional info.
   */
  @visibility("read")
  info?: Record<unknown>;
}

/**
 * The scheduled query rule resource for patch operations.
 */
model ScheduledQueryRuleResourcePatch {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The scheduled query rule properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ScheduledQueryRuleProperties;
}

/**
 * Represents collection of metric namespaces.
 */
@pagedResult
model MetricNamespaceCollection {
  /**
   * The values for the metric namespaces.
   */
  @items
  value: MetricNamespace[];
}

/**
 * Metric namespace class specifies the metadata for a metric namespace.
 */
model MetricNamespace {
  /**
   * The ID of the metric namespace.
   */
  id?: string;

  /**
   * The type of the namespace.
   */
  type?: string;

  /**
   * The escaped name of the namespace.
   */
  name?: string;

  /**
   * Kind of namespace
   */
  classification?: NamespaceClassification;

  /**
   * Properties which include the fully qualified namespace name.
   */
  properties?: MetricNamespaceName;
}

/**
 * The fully qualified metric namespace name.
 */
model MetricNamespaceName {
  /**
   * The metric namespace name.
   */
  metricNamespaceName?: string;
}

/**
 * Resource properties.
 */
model VMInsightsOnboardingStatusProperties {
  /**
   * Azure Resource Manager identifier of the resource whose onboarding status is being represented.
   */
  resourceId: string;

  /**
   * The onboarding status for the resource. Note that, a higher level scope, e.g., resource group or subscription, is considered onboarded if at least one resource under it is onboarded.
   */
  onboardingStatus: OnboardingStatus;

  /**
   * The status of VM Insights data from the resource. When reported as `present` the data array will contain information about the data containers to which data for the specified resource is being routed.
   */
  dataStatus: DataStatus;

  /**
   * Containers that currently store VM Insights data for the specified resource.
   */
  data?: DataContainer[];
}

/**
 * Information about a container with data for a given resource.
 */
model DataContainer {
  /**
   * Log Analytics workspace information.
   */
  workspace: WorkspaceInfo;
}

/**
 * Information about a Log Analytics Workspace.
 */
model WorkspaceInfo {
  /**
   * Azure Resource Manager identifier of the Log Analytics Workspace.
   */
  id: string;

  /**
   * Location of the Log Analytics workspace.
   */
  location: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: WorkspaceInfoProperties;
}

/**
 * Resource properties.
 */
model WorkspaceInfoProperties {
  /**
   * Log Analytics workspace identifier.
   */
  customerId: string;
}

/**
 * An error response from the API.
 */
@error
model ResponseWithError {
  /**
   * Error information.
   */
  error: Error;
}

/**
 * Error details.
 */
model Error {
  /**
   * Error code identifying the specific error.
   */
  code: string;

  /**
   * Error message in the caller's locale.
   */
  message?: string;
}

/**
 * Properties that define a Azure Monitor PrivateLinkScope resource.
 */
model AzureMonitorPrivateLinkScopeProperties {
  /**
   * Current state of this PrivateLinkScope: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Provisioning ,Succeeded, Canceled and Failed.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * List of private endpoint connections.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Access mode settings
   */
  accessModeSettings: AccessModeSettings;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Properties that define the scope private link mode settings.
 */
model AccessModeSettings {
  /**
   * Specifies the default access mode of queries through associated private endpoints in scope. If not specified default value is 'Open'. You can override this default setting for a specific private endpoint connection by adding an exclusion in the 'exclusions' array.
   */
  queryAccessMode: AccessMode;

  /**
   * Specifies the default access mode of ingestion through associated private endpoints in scope. If not specified default value is 'Open'. You can override this default setting for a specific private endpoint connection by adding an exclusion in the 'exclusions' array.
   */
  ingestionAccessMode: AccessMode;

  /**
   * List of exclusions that override the default access mode settings for specific private endpoint connections.
   */
  exclusions?: AccessModeSettingsExclusion[];
}

/**
 * Properties that define the scope private link mode settings exclusion item. This setting applies to a specific private endpoint connection and overrides the default settings for that private endpoint connection.
 */
model AccessModeSettingsExclusion {
  /**
   * The private endpoint connection name associated to the private endpoint on which we want to apply the specific access mode settings.
   */
  privateEndpointConnectionName?: string;

  /**
   * Specifies the access mode of queries through the specified private endpoint connection in the exclusion.
   */
  queryAccessMode?: AccessMode;

  /**
   * Specifies the access mode of ingestion through the specified private endpoint connection in the exclusion.
   */
  ingestionAccessMode?: AccessMode;
}

/**
 * The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location'
 */
model CommonTrackedResource extends CommonResource {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility("read", "create")
  location: string;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
@error
model DefaultErrorResponse {
  /**
   * The error object.
   */
  error?: CommonErrorDetail;
}

/**
 * The error detail.
 */
model CommonErrorDetail {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error target.
   */
  @visibility("read")
  target?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: CommonErrorDetail[];

  /**
   * The error additional info.
   */
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a PrivateLinkScope instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * The status of operation.
 */
model OperationStatus {
  /**
   * The operation Id.
   */
  id?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * Start time of the job in standard ISO8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the job in standard ISO8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The error detail of the operation if any.
   */
  error?: CommonErrorDetail;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Properties of a private link scoped resource.
 */
model ScopedResourceProperties {
  /**
   * The resource id of the scoped Azure monitor resource.
   */
  linkedResourceId?: string;

  /**
   * State of the private endpoint connection.
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * The resource model definition for a Azure Resource Manager proxy resource. It will not have tags and a location
 */
model CommonProxyResource extends CommonResource {}

/**
 * An Azure Activity Log Alert rule.
 */
model AlertRuleProperties {
  /**
   * A list of resource IDs that will be used as prefixes. The alert will only apply to Activity Log events with resource IDs that fall under one of these prefixes. This list must include at least one item.
   */
  scopes: string[];

  /**
   * The condition that will cause this alert to activate.
   */
  condition: AlertRuleAllOfCondition;

  /**
   * The actions that will activate when the condition is met.
   */
  actions: ActionList;

  /**
   * Indicates whether this Activity Log Alert rule is enabled. If an Activity Log Alert rule is not enabled, then none of its actions will be activated.
   */
  enabled?: boolean = true;

  /**
   * A description of this Activity Log Alert rule.
   */
  description?: string;
}

/**
 * An Activity Log Alert rule condition that is met when all its member conditions are met.
 */
model AlertRuleAllOfCondition {
  /**
   * The list of Activity Log Alert rule conditions.
   */
  allOf: AlertRuleAnyOfOrLeafCondition[];
}

/**
 * An Activity Log Alert rule condition that is met when all its member conditions are met.
 * Each condition can be of one of the following types:
 * __Important__: Each type has its unique subset of properties. Properties from different types CANNOT exist in one condition.
 *    * __Leaf Condition -__ must contain 'field' and either 'equals' or 'containsAny'.
 *   _Please note, 'anyOf' should __not__ be set in a Leaf Condition._
 *   * __AnyOf Condition -__ must contain __only__ 'anyOf' (which is an array of Leaf Conditions).
 *   _Please note, 'field', 'equals' and 'containsAny' should __not__ be set in an AnyOf Condition._
 *
 */
model AlertRuleAnyOfOrLeafCondition extends AlertRuleLeafCondition {
  /**
   * An Activity Log Alert rule condition that is met when at least one of its member leaf conditions are met.
   */
  anyOf?: AlertRuleLeafCondition[];
}

/**
 * An Activity Log Alert rule condition that is met by comparing the field and value of an Activity Log event.
 * This condition must contain 'field' and either 'equals' or 'containsAny'.
 */
model AlertRuleLeafCondition {
  /**
   * The name of the Activity Log event's field that this condition will examine.
   * The possible values for this field are (case-insensitive): 'resourceId', 'category', 'caller', 'level', 'operationName', 'resourceGroup', 'resourceProvider', 'status', 'subStatus', 'resourceType', or anything beginning with 'properties'.
   */
  field?: string;

  /**
   * The value of the event's field will be compared to this value (case-insensitive) to determine if the condition is met.
   */
  equals?: string;

  /**
   * The value of the event's field will be compared to the values in this array (case-insensitive) to determine if the condition is met.
   */
  containsAny?: string[];
}

/**
 * A list of Activity Log Alert rule actions.
 */
model ActionList {
  /**
   * The list of the Action Groups.
   */
  actionGroups?: ActivityLogAlertActionGroup[];
}

/**
 * A pointer to an Azure Action Group.
 */
model ActivityLogAlertActionGroup {
  /**
   * The resource ID of the Action Group. This cannot be null or empty.
   */
  actionGroupId: string;

  /**
   * the dictionary of custom properties to include with the post operation. These data are appended to the webhook payload.
   */
  webhookProperties?: Record<string>;
}

/**
 * An Azure resource object.
 */
model ActivityLogAlertsResource {
  /**
   * The resource Id.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * The location of the resource. Since Azure Activity Log Alerts is a global service, the location of the rules should always be 'global'.
   */
  @visibility("read", "create")
  location?: string = "global";

  /**
   * The tags of the resource.
   */
  tags?: Record<string>;
}

/**
 * The error response.
 */
@error
model ActivityLogAlertErrorResponse {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message indicating why the operation failed.
   */
  @visibility("read")
  message?: string;
}

/**
 * An Activity Log Alert rule object for the body of patch operations.
 */
model AlertRulePatchObject {
  /**
   * The resource tags
   */
  tags?: Record<string>;

  /**
   * The activity log alert settings for an update operation.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AlertRulePatchProperties;
}

/**
 * An Activity Log Alert rule properties for patch operations.
 */
model AlertRulePatchProperties {
  /**
   * Indicates whether this Activity Log Alert rule is enabled. If an Activity Log Alert rule is not enabled, then none of its actions will be activated.
   */
  enabled?: boolean = true;
}

/**
 * Resource properties.
 */
model DataCollectionEndpointResourceProperties extends DataCollectionEndpoint {}

/**
 * Definition of data collection endpoint.
 */
model DataCollectionEndpoint {
  /**
   * Description of the data collection endpoint.
   */
  description?: string;

  /**
   * The immutable ID of this data collection endpoint resource. This property is READ-ONLY.
   */
  immutableId?: string;

  /**
   * The endpoint used by clients to access their configuration.
   */
  configurationAccess?: DataCollectionEndpointConfigurationAccess;

  /**
   * The endpoint used by clients to ingest logs.
   */
  logsIngestion?: DataCollectionEndpointLogsIngestion;

  /**
   * The endpoint used by clients to ingest metrics.
   */
  metricsIngestion?: DataCollectionEndpointMetricsIngestion;

  /**
   * Network access control rules for the endpoints.
   */
  networkAcls?: DataCollectionEndpointNetworkAcls;

  /**
   * The resource provisioning state. This property is READ-ONLY.
   */
  @visibility("read")
  provisioningState?: KnownDataCollectionEndpointProvisioningState;

  /**
   * List of Azure Monitor Private Link Scope Resources to which this data collection endpoint resource is associated. This property is READ-ONLY.
   */
  @visibility("read")
  privateLinkScopedResources?: PrivateLinkScopedResource[];

  /**
   * Failover configuration on this endpoint. This property is READ-ONLY.
   */
  @visibility("read")
  failoverConfiguration?: DataCollectionEndpointFailoverConfiguration;

  /**
   * Metadata for the resource. This property is READ-ONLY.
   */
  @visibility("read")
  metadata?: DataCollectionEndpointMetadata;
}

/**
 * The endpoint used by clients to access their configuration.
 */
model DataCollectionEndpointConfigurationAccess
  extends ConfigurationAccessEndpointSpec {}

/**
 * Definition of the endpoint used for accessing configuration.
 */
model ConfigurationAccessEndpointSpec {
  /**
   * The endpoint. This property is READ-ONLY.
   */
  @visibility("read")
  endpoint?: string;
}

/**
 * The endpoint used by clients to ingest logs.
 */
model DataCollectionEndpointLogsIngestion extends LogsIngestionEndpointSpec {}

/**
 * Definition of the endpoint used for ingesting logs.
 */
model LogsIngestionEndpointSpec {
  /**
   * The endpoint. This property is READ-ONLY.
   */
  @visibility("read")
  endpoint?: string;
}

/**
 * The endpoint used by clients to ingest metrics.
 */
model DataCollectionEndpointMetricsIngestion
  extends MetricsIngestionEndpointSpec {}

/**
 * Definition of the endpoint used for ingesting metrics.
 */
model MetricsIngestionEndpointSpec {
  /**
   * The endpoint. This property is READ-ONLY.
   */
  @visibility("read")
  endpoint?: string;
}

/**
 * Network access control rules for the endpoints.
 */
model DataCollectionEndpointNetworkAcls extends NetworkRuleSet {}

/**
 * Definition of the network rules.
 */
model NetworkRuleSet {
  /**
   * The configuration to set whether network access from public internet to the endpoints are allowed.
   */
  publicNetworkAccess?: KnownPublicNetworkAccessOptions;
}

model PrivateLinkScopedResource {
  /**
   * The resourceId of the Azure Monitor Private Link Scope Scoped Resource through which this DCE is associated with a Azure Monitor Private Link Scope.
   */
  resourceId?: string;

  /**
   * The immutableId of the Azure Monitor Private Link Scope Resource to which the association is.
   */
  scopeId?: string;
}

/**
 * Failover configuration on this endpoint. This property is READ-ONLY.
 */
model DataCollectionEndpointFailoverConfiguration
  extends FailoverConfigurationSpec {}

model FailoverConfigurationSpec {
  /**
   * Active location where data flow will occur.
   */
  activeLocation?: string;

  /**
   * Locations that are configured for failover.
   */
  locations?: LocationSpec[];
}

model LocationSpec {
  /**
   * Name of location.
   */
  location?: string;

  /**
   * The resource provisioning state in this location.
   */
  provisioningStatus?: KnownLocationSpecProvisioningStatus;
}

/**
 * Metadata for the resource. This property is READ-ONLY.
 */
model DataCollectionEndpointMetadata extends Metadata {}

/**
 * Metadata about the resource
 */
model Metadata {
  /**
   * Azure offering managing this resource on-behalf-of customer.
   */
  @visibility("read")
  provisionedBy?: string;

  /**
   * Resource Id of azure offering managing this resource on-behalf-of customer.
   */
  @visibility("read")
  provisionedByResourceId?: string;
}

/**
 * Managed service identity of the resource.
 */
model DataCollectionEndpointResourceIdentity extends ManagedServiceIdentity {}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model DataCollectionEndpointResourceSystemData extends SystemData {}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
@error
model ErrorResponseCommonV2 {
  /**
   * The error object.
   */
  error?: CommonErrorDetail;
}

/**
 * Definition of ARM tracked top level resource properties for update operation.
 */
model ResourceForUpdate {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * Managed Service Identity.
   */
  identity?: ResourceForUpdateIdentity;
}

/**
 * Managed Service Identity.
 */
model ResourceForUpdateIdentity extends ManagedServiceIdentity {}

/**
 * Resource properties.
 */
model DataCollectionRuleAssociationProxyOnlyResourceProperties
  extends DataCollectionRuleAssociation {}

/**
 * Definition of association of a data collection rule with a monitored Azure resource.
 */
model DataCollectionRuleAssociation {
  /**
   * Description of the association.
   */
  description?: string;

  /**
   * The resource ID of the data collection rule that is to be associated.
   */
  dataCollectionRuleId?: string;

  /**
   * The resource ID of the data collection endpoint that is to be associated.
   */
  dataCollectionEndpointId?: string;

  /**
   * The resource provisioning state.
   */
  @visibility("read")
  provisioningState?: KnownDataCollectionRuleAssociationProvisioningState;

  /**
   * Metadata about the resource
   */
  @visibility("read")
  metadata?: DataCollectionRuleAssociationMetadata;
}

/**
 * Metadata about the resource
 */
model DataCollectionRuleAssociationMetadata extends Metadata {}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model DataCollectionRuleAssociationProxyOnlyResourceSystemData
  extends SystemData {}

/**
 * Resource properties.
 */
model DataCollectionRuleResourceProperties extends DataCollectionRule {}

/**
 * Definition of what monitoring data to collect and where that data should be sent.
 */
model DataCollectionRule {
  /**
   * Description of the data collection rule.
   */
  description?: string;

  /**
   * The immutable ID of this data collection rule. This property is READ-ONLY.
   */
  @visibility("read")
  immutableId?: string;

  /**
   * The resource ID of the data collection endpoint that this rule can be used with.
   */
  dataCollectionEndpointId?: string;

  /**
   * Metadata about the resource
   */
  @visibility("read")
  metadata?: DataCollectionRuleMetadata;

  /**
   * Declaration of custom streams used in this rule.
   */
  streamDeclarations?: Record<StreamDeclaration>;

  /**
   * The specification of data sources.
   * This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint.
   */
  dataSources?: DataCollectionRuleDataSources;

  /**
   * The specification of destinations.
   */
  destinations?: DataCollectionRuleDestinations;

  /**
   * The specification of data flows.
   */
  dataFlows?: DataFlow[];

  /**
   * The resource provisioning state.
   */
  @visibility("read")
  provisioningState?: KnownDataCollectionRuleProvisioningState;
}

/**
 * Metadata about the resource
 */
model DataCollectionRuleMetadata extends Metadata {}

/**
 * Declaration of a custom stream.
 */
model StreamDeclaration {
  /**
   * List of columns used by data in this stream.
   */
  columns?: ColumnDefinition[];
}

/**
 * Definition of custom data column.
 */
model ColumnDefinition {
  /**
   * The name of the column.
   */
  name?: string;

  /**
   * The type of the column data.
   */
  type?: KnownColumnDefinitionType;
}

/**
 * The specification of data sources.
 * This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint.
 */
model DataCollectionRuleDataSources extends DataSourcesSpec {}

/**
 * Specification of data sources that will be collected.
 */
model DataSourcesSpec {
  /**
   * The list of performance counter data source configurations.
   */
  performanceCounters?: PerfCounterDataSource[];

  /**
   * The list of Windows Event Log data source configurations.
   */
  windowsEventLogs?: WindowsEventLogDataSource[];

  /**
   * The list of Syslog data source configurations.
   */
  syslog?: SyslogDataSource[];

  /**
   * The list of Azure VM extension data source configurations.
   */
  extensions?: ExtensionDataSource[];

  /**
   * The list of Log files source configurations.
   */
  logFiles?: LogFilesDataSource[];

  /**
   * The list of IIS logs source configurations.
   */
  iisLogs?: IisLogsDataSource[];

  /**
   * The list of Windows Firewall logs source configurations.
   */
  windowsFirewallLogs?: WindowsFirewallLogsDataSource[];

  /**
   * The list of Prometheus forwarder data source configurations.
   */
  prometheusForwarder?: PrometheusForwarderDataSource[];

  /**
   * The list of platform telemetry configurations
   */
  platformTelemetry?: PlatformTelemetryDataSource[];

  /**
   * Specifications of pull based data sources
   */
  dataImports?: DataSourcesSpecDataImports;
}

/**
 * Definition of which performance counters will be collected and how they will be collected by this data collection rule.
 * Collected from both Windows and Linux machines where the counter is present.
 */
model PerfCounterDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams?: KnownPerfCounterDataSourceStreams[];

  /**
   * The number of seconds between consecutive counter measurements (samples).
   */
  samplingFrequencyInSeconds?: int32;

  /**
   * A list of specifier names of the performance counters you want to collect.
   * Use a wildcard (*) to collect a counter for all instances.
   * To get a list of performance counters on Windows, run the command 'typeperf'.
   */
  counterSpecifiers?: string[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which Windows Event Log events will be collected and how they will be collected.
 * Only collected from Windows machines.
 */
model WindowsEventLogDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams?: KnownWindowsEventLogDataSourceStreams[];

  /**
   * A list of Windows Event Log queries in XPATH format.
   */
  xPathQueries?: string[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which syslog data will be collected and how it will be collected.
 * Only collected from Linux machines.
 */
model SyslogDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams?: KnownSyslogDataSourceStreams[];

  /**
   * The list of facility names.
   */
  facilityNames?: KnownSyslogDataSourceFacilityNames[];

  /**
   * The log levels to collect.
   */
  logLevels?: KnownSyslogDataSourceLogLevels[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which data will be collected from a separate VM extension that integrates with the Azure Monitor Agent.
 * Collected from either Windows and Linux machines, depending on which extension is defined.
 */
model ExtensionDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams?: KnownExtensionDataSourceStreams[];

  /**
   * The name of the VM extension.
   */
  extensionName: string;

  /**
   * The extension settings. The format is specific for particular extension.
   */
  extensionSettings?: Record<unknown>;

  /**
   * The list of data sources this extension needs data from.
   */
  inputDataSources?: string[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which custom log files will be collected by this data collection rule
 */
model LogFilesDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data source
   */
  streams: string[];

  /**
   * File Patterns where the log files are located
   */
  filePatterns: string[];

  /**
   * The data format of the log files
   */
  format: KnownLogFilesDataSourceFormat;

  /**
   * The log files specific settings.
   */
  settings?: LogFilesDataSourceSettings;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * The log files specific settings.
 */
model LogFilesDataSourceSettings extends LogFileSettings {}

/**
 * Settings for different log file formats
 */
model LogFileSettings {
  /**
   * Text settings
   */
  text?: LogFileSettingsText;
}

/**
 * Text settings
 */
model LogFileSettingsText extends LogFileTextSettings {}

/**
 * Settings for text log files
 */
model LogFileTextSettings {
  /**
   * One of the supported timestamp formats
   */
  recordStartTimestampFormat: KnownLogFileTextSettingsRecordStartTimestampFormat;
}

/**
 * Enables IIS logs to be collected by this data collection rule.
 */
model IisLogsDataSource {
  /**
   * IIS streams
   */
  streams: string[];

  /**
   * Absolute paths file location
   */
  logDirectories?: string[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Enables Firewall logs to be collected by this data collection rule.
 */
model WindowsFirewallLogsDataSource {
  /**
   * Firewall logs streams
   */
  streams: string[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of Prometheus metrics forwarding configuration.
 */
model PrometheusForwarderDataSource {
  /**
   * List of streams that this data source will be sent to.
   */
  streams?: KnownPrometheusForwarderDataSourceStreams[];

  /**
   * The list of label inclusion filters in the form of label "name-value" pairs.
   * Currently only one label is supported: 'microsoft_metrics_include_label'.
   * Label values are matched case-insensitively.
   */
  labelIncludeFilter?: Record<string>;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of platform telemetry data source configuration
 */
model PlatformTelemetryDataSource {
  /**
   * List of platform telemetry streams to collect
   */
  streams: string[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Specifications of pull based data sources
 */
model DataSourcesSpecDataImports extends DataImportSources {}

model DataImportSources {
  /**
   * Definition of Event Hub configuration.
   */
  eventHub?: DataImportSourcesEventHub;
}

/**
 * Definition of Event Hub configuration.
 */
model DataImportSourcesEventHub extends EventHubDataSource {}

model EventHubDataSource {
  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;

  /**
   * Event Hub consumer group name
   */
  consumerGroup?: string;

  /**
   * The stream to collect from EventHub
   */
  stream?: string;
}

/**
 * The specification of destinations.
 */
model DataCollectionRuleDestinations extends DestinationsSpec {}

/**
 * Specification of destinations that can be used in data flows.
 */
model DestinationsSpec {
  /**
   * List of Log Analytics destinations.
   */
  logAnalytics?: LogAnalyticsDestination[];

  /**
   * List of monitoring account destinations.
   */
  monitoringAccounts?: MonitoringAccountDestination[];

  /**
   * Azure Monitor Metrics destination.
   */
  azureMonitorMetrics?: DestinationsSpecAzureMonitorMetrics;

  /**
   * List of Event Hubs destinations.
   */
  eventHubs?: EventHubDestination[];

  /**
   * List of Event Hubs Direct destinations.
   */
  eventHubsDirect?: EventHubDirectDestination[];

  /**
   * List of Storage Blob Direct destinations. To be used only for sending data directly to store from the agent.
   */
  storageBlobsDirect?: StorageBlobDestination[];

  /**
   * List of Storage Table Direct destinations.
   */
  storageTablesDirect?: StorageTableDestination[];

  /**
   * List of storage accounts destinations.
   */
  storageAccounts?: StorageBlobDestination[];
}

/**
 * Log Analytics destination.
 */
model LogAnalyticsDestination {
  /**
   * The resource ID of the Log Analytics workspace.
   */
  workspaceResourceId?: string;

  /**
   * The Customer ID of the Log Analytics workspace.
   */
  @visibility("read")
  workspaceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Monitoring account destination.
 */
model MonitoringAccountDestination {
  /**
   * The resource ID of the monitoring account.
   */
  accountResourceId?: string;

  /**
   * The immutable ID  of the account.
   */
  @visibility("read")
  accountId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Azure Monitor Metrics destination.
 */
model DestinationsSpecAzureMonitorMetrics
  extends AzureMonitorMetricsDestination {}

/**
 * Azure Monitor Metrics destination.
 */
model AzureMonitorMetricsDestination {
  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

model EventHubDestination {
  /**
   * The resource ID of the event hub.
   */
  eventHubResourceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

model EventHubDirectDestination {
  /**
   * The resource ID of the event hub.
   */
  eventHubResourceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

model StorageBlobDestination {
  /**
   * The container name of the Storage Blob.
   */
  containerName?: string;

  /**
   * The resource ID of the storage account.
   */
  storageAccountResourceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

model StorageTableDestination {
  /**
   * The name of the Storage Table.
   */
  tableName?: string;

  /**
   * The resource ID of the storage account.
   */
  storageAccountResourceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which streams are sent to which destinations.
 */
model DataFlow {
  /**
   * List of streams for this data flow.
   */
  streams?: KnownDataFlowStreams[];

  /**
   * List of destinations for this data flow.
   */
  destinations?: string[];

  /**
   * The KQL query to transform stream data.
   */
  transformKql?: string;

  /**
   * The output stream of the transform. Only required if the transform changes data to a different stream.
   */
  outputStream?: string;

  /**
   * The builtIn transform to transform stream data
   */
  builtInTransform?: string;
}

/**
 * Managed service identity of the resource.
 */
model DataCollectionRuleResourceIdentity extends ManagedServiceIdentity {}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model DataCollectionRuleResourceSystemData extends SystemData {}

/**
 * Resource properties
 */
model AzureMonitorWorkspaceResourceProperties extends AzureMonitorWorkspace {}

/**
 * Properties of an Azure Monitor workspace
 */
model AzureMonitorWorkspace {
  /**
   * The immutable ID of the Azure Monitor workspace. This property is read-only.
   */
  @visibility("read")
  accountId?: string;

  /**
   * Information about metrics for the Azure Monitor workspace
   */
  @visibility("read")
  metrics?: AzureMonitorWorkspaceMetrics;

  /**
   * The provisioning state of the Azure Monitor workspace. Set to Succeeded if everything is healthy.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The Data Collection Rule and Endpoint used for ingestion by default.
   */
  @visibility("read")
  defaultIngestionSettings?: AzureMonitorWorkspaceDefaultIngestionSettings;

  /**
   * List of private endpoint connections
   */
  @visibility("read")
  privateEndpointConnections?: MonitorWorkspacePrivateEndpointConnection[];

  /**
   * Gets or sets allow or disallow public network access to workspace
   */
  @visibility("read")
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Information about metrics for the Azure Monitor workspace
 */
model AzureMonitorWorkspaceMetrics extends Metrics {}

/**
 * Information about metrics for the workspace
 */
model Metrics {
  /**
   * The Prometheus query endpoint for the workspace
   */
  @visibility("read")
  prometheusQueryEndpoint?: string;

  /**
   * An internal identifier for the metrics container. Only to be used by the system
   */
  @visibility("read")
  internalId?: string;
}

/**
 * The Data Collection Rule and Endpoint used for ingestion by default.
 */
model AzureMonitorWorkspaceDefaultIngestionSettings extends IngestionSettings {}

/**
 * Settings for data ingestion
 */
model IngestionSettings {
  /**
   * The Azure resource Id of the default data collection rule for this workspace.
   */
  @visibility("read")
  dataCollectionRuleResourceId?: string;

  /**
   * The Azure resource Id of the default data collection endpoint for this workspace.
   */
  @visibility("read")
  dataCollectionEndpointResourceId?: string;
}

/**
 * The private endpoint connection resource.
 */
model MonitorWorkspacePrivateEndpointConnection extends CommonResourceV4 {
  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MonitorWorkspacePrivateEndpointConnectionProperties;
}

/**
 * Properties of the private endpoint connection.
 */
model MonitorWorkspacePrivateEndpointConnectionProperties {
  /**
   * The group ids for the private endpoint resource.
   */
  @visibility("read")
  groupIds?: string[];

  /**
   * The private endpoint resource.
   */
  privateEndpoint?: MonitorWorkspacePrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The private endpoint resource.
 */
model MonitorWorkspacePrivateEndpoint {
  /**
   * The ARM identifier for private endpoint.
   */
  @visibility("read")
  id?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model CommonResourceV4 {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location'
 */
model CommonTrackedResourceV3 extends CommonResourceV3 {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility("read", "create")
  location: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model CommonResourceV3 {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
@error
model CommonErrorResponseV3 {
  /**
   * The error object.
   */
  error?: CommonErrorDetailV3;
}

/**
 * The error detail.
 */
model CommonErrorDetailV3 {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error target.
   */
  @visibility("read")
  target?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: CommonErrorDetailV3[];

  /**
   * The error additional info.
   */
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * Definition of ARM tracked top level resource properties for update operation
 */
model AzureMonitorWorkspaceResourceForUpdate {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * A rule metric data source. The discriminator value is always RuleMetricDataSource in this case.
 */
model RuleMetricDataSource extends RuleDataSource {
  /**
   * the name of the metric that defines what the rule monitors.
   */
  metricName?: string;

  /**
   * specifies the type of data source. There are two types of rule data sources: RuleMetricDataSource and RuleManagementEventDataSource
   */
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.RuleMetricDataSource";
}

/**
 * The claims for a rule management event data source.
 */
model RuleManagementEventClaimsDataSource {
  /**
   * the email address.
   */
  emailAddress?: string;
}

/**
 * A rule management event data source. The discriminator fields is always RuleManagementEventDataSource in this case.
 */
model RuleManagementEventDataSource extends RuleDataSource {
  /**
   * the event name.
   */
  eventName?: string;

  /**
   * the event source.
   */
  eventSource?: string;

  /**
   * the level.
   */
  level?: string;

  /**
   * The name of the operation that should be checked for. If no name is provided, any operation will match.
   */
  operationName?: string;

  /**
   * the resource group name.
   */
  resourceGroupName?: string;

  /**
   * the resource provider name.
   */
  resourceProviderName?: string;

  /**
   * The status of the operation that should be checked for. If no status is provided, any status will match.
   */
  status?: string;

  /**
   * the substatus.
   */
  subStatus?: string;

  /**
   * the claims.
   */
  claims?: RuleManagementEventClaimsDataSource;

  /**
   * specifies the type of data source. There are two types of rule data sources: RuleMetricDataSource and RuleManagementEventDataSource
   */
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.RuleManagementEventDataSource";
}

/**
 * A rule condition based on a metric crossing a threshold.
 */
model ThresholdRuleCondition extends RuleCondition {
  /**
   * the operator used to compare the data and the threshold.
   */
  operator: ConditionOperator;

  /**
   * the threshold value that activates the alert.
   */
  threshold: float64;

  /**
   * the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold. If specified then it must be between 5 minutes and 1 day.
   */
  windowSize?: duration;

  /**
   * the time aggregation operator. How the data that are collected should be combined over time. The default value is the PrimaryAggregationType of the Metric.
   */
  timeAggregation?: TimeAggregationOperator;

  /**
   * specifies the type of condition. This can be one of three types: ManagementEventRuleCondition (occurrences of management events), LocationThresholdRuleCondition (based on the number of failures of a web test), and ThresholdRuleCondition (based on the threshold of a metric).
   */
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.ThresholdRuleCondition";
}

/**
 * A rule condition based on a certain number of locations failing.
 */
model LocationThresholdRuleCondition extends RuleCondition {
  /**
   * the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold. If specified then it must be between 5 minutes and 1 day.
   */
  windowSize?: duration;

  /**
   * the number of locations that must fail to activate the alert.
   */
  failedLocationCount: int32;

  /**
   * specifies the type of condition. This can be one of three types: ManagementEventRuleCondition (occurrences of management events), LocationThresholdRuleCondition (based on the number of failures of a web test), and ThresholdRuleCondition (based on the threshold of a metric).
   */
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.LocationThresholdRuleCondition";
}

/**
 * How the data that is collected should be combined over time.
 */
model ManagementEventAggregationCondition {
  /**
   * the condition operator.
   */
  operator?: ConditionOperator;

  /**
   * The threshold value that activates the alert.
   */
  threshold?: float64;

  /**
   * the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold. If specified then it must be between 5 minutes and 1 day.
   */
  windowSize?: duration;
}

/**
 * A management event rule condition.
 */
model ManagementEventRuleCondition extends RuleCondition {
  /**
   * How the data that is collected should be combined over time and when the alert is activated. Note that for management event alerts aggregation is optional – if it is not provided then any event will cause the alert to activate.
   */
  aggregation?: ManagementEventAggregationCondition;

  /**
   * specifies the type of condition. This can be one of three types: ManagementEventRuleCondition (occurrences of management events), LocationThresholdRuleCondition (based on the number of failures of a web test), and ThresholdRuleCondition (based on the threshold of a metric).
   */
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.ManagementEventRuleCondition";
}

/**
 * Specifies the action to send email when the rule condition is evaluated. The discriminator is always RuleEmailAction in this case.
 */
model RuleEmailAction extends RuleAction {
  /**
   * Whether the administrators (service and co-administrators) of the service should be notified when the alert is activated.
   */
  sendToServiceOwners?: boolean;

  /**
   * the list of administrator's custom email addresses to notify of the activation of the alert.
   */
  customEmails?: string[];

  /**
   * specifies the type of the action. There are two types of actions: RuleEmailAction and RuleWebhookAction.
   */
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.RuleEmailAction";
}

/**
 * Specifies the action to post to service when the rule condition is evaluated. The discriminator is always RuleWebhookAction in this case.
 */
model RuleWebhookAction extends RuleAction {
  /**
   * the service uri to Post the notification when the alert activates or resolves.
   */
  serviceUri?: string;

  /**
   * the dictionary of custom properties to include with the post operation. These data are appended to the webhook payload.
   */
  properties?: Record<string>;

  /**
   * specifies the type of the action. There are two types of actions: RuleEmailAction and RuleWebhookAction.
   */
  `odata.type`: "Microsoft.Azure.Management.Insights.Models.RuleWebhookAction";
}

/**
 * Specifies the metric alert criteria for a single resource that has multiple metric criteria.
 */
model MetricAlertSingleResourceMultipleMetricCriteria
  extends MetricAlertCriteria {
  /**
   * The list of metric criteria for this 'all of' operation.
   */
  allOf?: MetricCriteria[];

  /**
   * specifies the type of the alert criteria.
   */
  `odata.type`: "Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria";
}

/**
 * Criterion to filter metrics.
 */
model MetricCriteria extends MultiMetricCriteria {
  /**
   * the criteria operator.
   */
  operator: Operator;

  /**
   * the criteria threshold value that activates the alert.
   */
  threshold: float64;

  /**
   * Specifies the type of threshold criteria
   */
  criterionType: "StaticThresholdCriterion";
}

/**
 * The types of conditions for a multi resource alert.
 */
@discriminator("criterionType")
model MultiMetricCriteria extends Record<Record<unknown>> {
  /**
   * Name of the criteria.
   */
  name: string;

  /**
   * Name of the metric.
   */
  metricName: string;

  /**
   * Namespace of the metric.
   */
  metricNamespace?: string;

  /**
   * the criteria time aggregation types.
   */
  timeAggregation: AggregationTypeEnum;

  /**
   * List of dimension conditions.
   */
  dimensions?: MetricDimension[];

  /**
   * Allows creating an alert rule on a custom metric that isn't yet emitted, by causing the metric validation to be skipped.
   */
  skipMetricValidation?: boolean;
}

/**
 * Specifies a metric dimension.
 */
model MetricDimension {
  /**
   * Name of the dimension.
   */
  name: string;

  /**
   * the dimension operator. Only 'Include' and 'Exclude' are supported
   */
  operator: string;

  /**
   * list of dimension values.
   */
  values: string[];
}

/**
 * Specifies the metric alert rule criteria for a web test resource.
 */
model WebtestLocationAvailabilityCriteria extends MetricAlertCriteria {
  /**
   * The Application Insights web test Id.
   */
  webTestId: string;

  /**
   * The Application Insights resource Id.
   */
  componentId: string;

  /**
   * The number of failed locations.
   */
  failedLocationCount: float32;

  /**
   * specifies the type of the alert criteria.
   */
  `odata.type`: "Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria";
}

/**
 * Specifies the metric alert criteria for multiple resource that has multiple metric criteria.
 */
model MetricAlertMultipleResourceMultipleMetricCriteria
  extends MetricAlertCriteria {
  /**
   * the list of multiple metric criteria for this 'all of' operation.
   */
  allOf?: MultiMetricCriteria[];

  /**
   * specifies the type of the alert criteria.
   */
  `odata.type`: "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria";
}

/**
 * Criterion for dynamic threshold.
 */
model DynamicMetricCriteria extends MultiMetricCriteria {
  /**
   * The operator used to compare the metric value against the threshold.
   */
  operator: DynamicThresholdOperator;

  /**
   * The extent of deviation required to trigger an alert. This will affect how tight the threshold is to the metric series pattern.
   */
  alertSensitivity: DynamicThresholdSensitivity;

  /**
   * The minimum number of violations required within the selected lookback time window required to raise an alert.
   */
  failingPeriods: DynamicThresholdFailingPeriods;

  /**
   * Use this option to set the date from which to start learning the metric historical data and calculate the dynamic thresholds (in ISO8601 format)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  ignoreDataBefore?: utcDateTime;

  /**
   * Specifies the type of threshold criteria
   */
  criterionType: "DynamicThresholdCriterion";
}

/**
 * The minimum number of violations required within the selected lookback time window required to raise an alert.
 */
model DynamicThresholdFailingPeriods {
  /**
   * The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (windowSize) and the selected number of aggregated points.
   */
  numberOfEvaluationPeriods: float32;

  /**
   * The number of violations to trigger an alert. Should be smaller or equal to numberOfEvaluationPeriods.
   */
  minFailingPeriodsToAlert: float32;
}
