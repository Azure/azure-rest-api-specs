import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

/**
 * the dimension operator. Only 'Equals' and 'NotEquals' are supported. 'Equals' being equal to any of the values. 'NotEquals' being not equal to all of the values
 */
union ScaleRuleMetricDimensionOperationType {
  string,

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * NotEquals
   */
  NotEquals: "NotEquals",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * the metric statistic type. How the metrics from multiple instances are combined.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum MetricStatisticType {
  /**
   * Average
   */
  Average,

  /**
   * Min
   */
  Min,

  /**
   * Max
   */
  Max,

  /**
   * Sum
   */
  Sum,

  /**
   * Count
   */
  Count,
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperationType {
  /**
   * Scale
   */
  Scale,
}

/**
 * time aggregation type. How the data that is collected should be combined over time. The default value is Average.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum TimeAggregationType {
  /**
   * Average
   */
  Average,

  /**
   * Minimum
   */
  Minimum,

  /**
   * Maximum
   */
  Maximum,

  /**
   * Total
   */
  Total,

  /**
   * Count
   */
  Count,

  /**
   * Last
   */
  Last,
}

/**
 * the operator that is used to compare the metric data and the threshold.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ComparisonOperationType {
  /**
   * Equals
   */
  Equals,

  /**
   * NotEquals
   */
  NotEquals,

  /**
   * GreaterThan
   */
  GreaterThan,

  /**
   * GreaterThanOrEqual
   */
  GreaterThanOrEqual,

  /**
   * LessThan
   */
  LessThan,

  /**
   * LessThanOrEqual
   */
  LessThanOrEqual,
}

/**
 * the scale direction. Whether the scaling action increases or decreases the number of instances.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ScaleDirection {
  /**
   * None
   */
  None,

  /**
   * Increase
   */
  Increase,

  /**
   * Decrease
   */
  Decrease,
}

/**
 * the type of action that should occur when the scale rule fires.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ScaleType {
  /**
   * ChangeCount
   */
  ChangeCount,

  /**
   * PercentChangeCount
   */
  PercentChangeCount,

  /**
   * ExactCount
   */
  ExactCount,

  /**
   * ServiceAllowedNextValue
   */
  ServiceAllowedNextValue,
}

/**
 * the recurrence frequency. How often the schedule profile should take effect. This value must be Week, meaning each week will have the same set of profiles. For example, to set a daily schedule, set **schedule** to every day of the week. The frequency property specifies that the schedule is repeated weekly.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RecurrenceFrequency {
  /**
   * None
   */
  None,

  /**
   * Second
   */
  Second,

  /**
   * Minute
   */
  Minute,

  /**
   * Hour
   */
  Hour,

  /**
   * Day
   */
  Day,

  /**
   * Week
   */
  Week,

  /**
   * Month
   */
  Month,

  /**
   * Year
   */
  Year,
}

/**
 * the predictive autoscale mode
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum PredictiveAutoscalePolicyScaleMode {
  /**
   * Disabled
   */
  Disabled,

  /**
   * ForecastOnly
   */
  ForecastOnly,

  /**
   * Enabled
   */
  Enabled,
}

/**
 * Represents a collection of autoscale setting resources.
 */
model AutoscaleSettingResourceCollection
  is Azure.Core.Page<AutoscaleSettingResource>;

/**
 * A setting that contains all of the configuration for the automatic scaling of a resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AutoscaleSetting {
  /**
   * the collection of automatic scaling profiles that specify different scaling parameters for different time periods. A maximum of 20 profiles can be specified.
   */
  @identifiers(#[])
  @maxItems(20)
  profiles: AutoscaleProfile[];

  /**
   * the collection of notifications.
   */
  @identifiers(#[])
  notifications?: AutoscaleNotification[];

  /**
   * the enabled flag. Specifies whether automatic scaling is enabled for the resource. The default value is 'false'.
   */
  enabled?: boolean = false;

  /**
   * the predictive autoscale policy mode.
   */
  predictiveAutoscalePolicy?: PredictiveAutoscalePolicy;

  /**
   * the name of the autoscale setting.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#[])
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
  @identifiers(#[])
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DimensionName: string;

  /**
   * the dimension operator. Only 'Equals' and 'NotEquals' are supported. 'Equals' being equal to any of the values. 'NotEquals' being not equal to all of the values
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Operator: ScaleRuleMetricDimensionOperationType;

  /**
   * list of dimension values. For example: ["App1","App2"].
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Values: string[];
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
  days: string[];

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
  operation: OperationType;

  /**
   * the email notification.
   */
  email?: EmailNotification;

  /**
   * the collection of webhook notifications.
   */
  @identifiers(#[])
  webhooks?: WebhookNotification[];
}

/**
 * Email notification of an autoscale event.
 */
model EmailNotification {
  /**
   * a value indicating whether to send email to subscription administrator.
   */
  sendToSubscriptionAdministrator?: boolean = false;

  /**
   * a value indicating whether to send email to subscription co-administrators.
   */
  sendToSubscriptionCoAdministrators?: boolean = false;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
model Resource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater in length than 128 characters and a value no greater in length than 256 characters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The system metadata related to the response.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The autoscale setting properties of the update operation.
   */
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
  @identifiers(#[])
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
