import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- CloudWatchAlarms ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Cloud Watch Alarm",
    plural: "Cloud Watch Alarms",
  },
  keywords: ["Microsoft.AwsConnector", "Cloud", "Watch", "Alarm"],
})
@doc("A Microsoft.AwsConnector resource")
model CloudWatchAlarm is TrackedResource<CloudWatchAlarmProperties> {
  @doc("Name of CloudWatchAlarm")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("cloudWatchAlarms")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CloudWatchAlarm")
model CloudWatchAlarmProperties {
  @doc("AWS Properties")
  awsProperties?: AwsCloudWatchAlarmProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCloudWatchAlarm")
model AwsCloudWatchAlarmProperties {
  @doc("Indicates whether actions should be executed during any changes to the alarm state. The default is TRUE.")
  actionsEnabled?: boolean = true;

  @doc("The list of actions to execute when this alarm transitions into an ALARM state from any other state. Specify each action as an Amazon Resource Name (ARN). For more information about creating alarms and the actions that you can specify, see [PutMetricAlarm](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_PutMetricAlarm.html) in the *API Reference*.")
  @extension("x-ms-identifiers", [])
  alarmActions?: string[];

  @doc("The description of the alarm.")
  alarmDescription?: string;

  @doc("The name of the alarm. If you don't specify a name, CFN generates a unique physical ID and uses that ID for the alarm name.   If you specify a name, you cannot perform updates that require replacement of this resource. You can perform updates that require no or some interruption. If you must replace the resource, specify a new name.")
  alarmName?: string;

  @doc("Property arn")
  arn?: string;

  @doc("The arithmetic operation to use when comparing the specified statistic and threshold. The specified statistic value is used as the first operand.")
  comparisonOperator?: string;

  @doc("The number of datapoints that must be breaching to trigger the alarm. This is used only if you are setting an 'M out of N' alarm. In that case, this value is the M, and the value that you set for ``EvaluationPeriods`` is the N value. For more information, see [Evaluating an Alarm](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarm-evaluation) in the *User Guide*. If you omit this parameter, CW uses the same value here that you set for ``EvaluationPeriods``, and the alarm goes to alarm state if that many consecutive periods are breaching.")
  datapointsToAlarm?: int32;

  @doc("The dimensions for the metric associated with the alarm. For an alarm based on a math expression, you can't specify ``Dimensions``. Instead, you use ``Metrics``.")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];

  @doc("Used only for alarms based on percentiles. If ``ignore``, the alarm state does not change during periods with too few data points to be statistically significant. If ``evaluate`` or this parameter is not used, the alarm is always evaluated and possibly changes state no matter how many data points are available.")
  evaluateLowSampleCountPercentile?: string;

  @doc("The number of periods over which data is compared to the specified threshold. If you are setting an alarm that requires that a number of consecutive data points be breaching to trigger the alarm, this value specifies that number. If you are setting an 'M out of N' alarm, this value is the N, and ``DatapointsToAlarm`` is the M. For more information, see [Evaluating an Alarm](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarm-evaluation) in the *User Guide*.")
  evaluationPeriods?: int32;

  @doc("The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100. For an alarm based on a metric, you must specify either ``Statistic`` or ``ExtendedStatistic`` but not both. For an alarm based on a math expression, you can't specify ``ExtendedStatistic``. Instead, you use ``Metrics``.")
  extendedStatistic?: string;

  @doc("The actions to execute when this alarm transitions to the ``INSUFFICIENT_DATA`` state from any other state. Each action is specified as an Amazon Resource Name (ARN).")
  @extension("x-ms-identifiers", [])
  insufficientDataActions?: string[];

  @doc("The name of the metric associated with the alarm. This is required for an alarm based on a metric. For an alarm based on a math expression, you use ``Metrics`` instead and you can't specify ``MetricName``.")
  metricName?: string;

  @doc("An array that enables you to create an alarm based on the result of a metric math expression. Each item in the array either retrieves a metric or performs a math expression. If you specify the ``Metrics`` parameter, you cannot specify ``MetricName``, ``Dimensions``, ``Period``, ``Namespace``, ``Statistic``, ``ExtendedStatistic``, or ``Unit``.")
  @extension("x-ms-identifiers", [])
  metrics?: MetricDataQuery[];

  @doc("The namespace of the metric associated with the alarm. This is required for an alarm based on a metric. For an alarm based on a math expression, you can't specify ``Namespace`` and you use ``Metrics`` instead. For a list of namespaces for metrics from AWS services, see [Services That Publish Metrics.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html)")
  `namespace`?: string;

  @doc("The actions to execute when this alarm transitions to the ``OK`` state from any other state. Each action is specified as an Amazon Resource Name (ARN).")
  @extension("x-ms-identifiers", [])
  okActions?: string[];

  @doc("The period, in seconds, over which the statistic is applied. This is required for an alarm based on a metric. Valid values are 10, 30, 60, and any multiple of 60. For an alarm based on a math expression, you can't specify ``Period``, and instead you use the ``Metrics`` parameter. *Minimum:* 10")
  period?: int32;

  @doc("The statistic for the metric associated with the alarm, other than percentile. For percentile statistics, use ``ExtendedStatistic``. For an alarm based on a metric, you must specify either ``Statistic`` or ``ExtendedStatistic`` but not both. For an alarm based on a math expression, you can't specify ``Statistic``. Instead, you use ``Metrics``.")
  statistic?: string;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The value to compare with the specified statistic.")
  threshold?: float32;

  @doc("In an alarm based on an anomaly detection model, this is the ID of the ``ANOMALY_DETECTION_BAND`` function used as the threshold for the alarm.")
  thresholdMetricId?: string;

  @doc("Sets how this alarm is to handle missing data points. Valid values are ``breaching``, ``notBreaching``, ``ignore``, and ``missing``. For more information, see [Configuring How Alarms Treat Missing Data](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarms-and-missing-data) in the *Amazon User Guide*. If you omit this parameter, the default behavior of ``missing`` is used.")
  treatMissingData?: string;

  @doc("The unit of the metric associated with the alarm. Specify this only if you are creating an alarm based on a single metric. Do not specify this if you are specifying a ``Metrics`` array.  You can specify the following values: Seconds, Microseconds, Milliseconds, Bytes, Kilobytes, Megabytes, Gigabytes, Terabytes, Bits, Kilobits, Megabits, Gigabits, Terabits, Percent, Count, Bytes/Second, Kilobytes/Second, Megabytes/Second, Gigabytes/Second, Terabytes/Second, Bits/Second, Kilobits/Second, Megabits/Second, Gigabits/Second, Terabits/Second, Count/Second, or None.")
  unit?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Dimension")
model Dimension {
  @doc("The name of the dimension, from 1–255 characters in length. This dimension name must have been included when the metric was published.")
  name?: string;

  @doc("The value for the dimension, from 1–255 characters in length.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricDataQuery")
model MetricDataQuery {
  @doc("The ID of the account where the metrics are located, if this is a cross-account alarm.")
  accountId?: string;

  @doc("The math expression to be performed on the returned data, if this object is performing a math expression. This expression can use the ``Id`` of the other metrics to refer to those metrics, and can also use the ``Id`` of other expressions to use the result of those expressions. For more information about metric math expressions, see [Metric Math Syntax and Functions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax) in the *User Guide*. Within each MetricDataQuery object, you must specify either ``Expression`` or ``MetricStat`` but not both.")
  expression?: string;

  @doc("A short name used to tie this object to the results in the response. This name must be unique within a single call to ``GetMetricData``. If you are performing math expressions on this set of data, this name represents that data and can serve as a variable in the mathematical expression. The valid characters are letters, numbers, and underscore. The first character must be a lowercase letter.")
  id?: string;

  @doc("A human-readable label for this metric or expression. This is especially useful if this is an expression, so that you know what the value represents. If the metric or expression is shown in a CW dashboard widget, the label is shown. If ``Label`` is omitted, CW generates a default.")
  label?: string;

  @doc("The metric to be returned, along with statistics, period, and units. Use this parameter only if this object is retrieving a metric and not performing a math expression on returned data. Within one MetricDataQuery object, you must specify either ``Expression`` or ``MetricStat`` but not both. This structure defines the metric to be returned, along with the statistics, period, and units.  ``MetricStat`` is a property of the [MetricDataQuery](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cloudwatch-alarm-metricdataquery.html) property type.")
  metricStat?: MetricStat;

  @doc("The granularity, in seconds, of the returned data points. For metrics with regular resolution, a period can be as short as one minute (60 seconds) and must be a multiple of 60. For high-resolution metrics that are collected at intervals of less than one minute, the period can be 1, 5, 10, 30, 60, or any multiple of 60. High-resolution metrics are those metrics stored by a ``PutMetricData`` operation that includes a ``StorageResolution of 1 second``.")
  period?: int32;

  @doc("This option indicates whether to return the timestamps and raw data values of this metric. When you create an alarm based on a metric math expression, specify ``True`` for this value for only the one math expression that the alarm is based on. You must specify ``False`` for ``ReturnData`` for all the other metrics and expressions used in the alarm. This field is required.")
  returnData?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("A unique identifier for the tag. The combination of tag keys and values can help you organize and categorize your resources.")
  key?: string;

  @doc("The value for the specified tag key.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricStat")
model MetricStat {
  @doc("The metric to return, including the metric name, namespace, and dimensions. The ``Metric`` property type represents a specific metric. ``Metric`` is a property of the [MetricStat](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cloudwatch-alarm-metricstat.html) property type.")
  metric?: Metric;

  @doc("The granularity, in seconds, of the returned data points. For metrics with regular resolution, a period can be as short as one minute (60 seconds) and must be a multiple of 60. For high-resolution metrics that are collected at intervals of less than one minute, the period can be 1, 5, 10, 30, 60, or any multiple of 60. High-resolution metrics are those metrics stored by a ``PutMetricData`` call that includes a ``StorageResolution`` of 1 second. If the ``StartTime`` parameter specifies a time stamp that is greater than 3 hours ago, you must specify the period as follows or no data points in that time range is returned:  +  Start time between 3 hours and 15 days ago - Use a multiple of 60 seconds (1 minute).  +  Start time between 15 and 63 days ago - Use a multiple of 300 seconds (5 minutes).  +  Start time greater than 63 days ago - Use a multiple of 3600 seconds (1 hour).")
  period?: int32;

  @doc("The statistic to return. It can include any CW statistic or extended statistic. For a list of valid values, see the table in [Statistics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Statistic) in the *User Guide*.")
  stat?: string;

  @doc("The unit to use for the returned data points.  Valid values are: Seconds, Microseconds, Milliseconds, Bytes, Kilobytes, Megabytes, Gigabytes, Terabytes, Bits, Kilobits, Megabits, Gigabits, Terabits, Percent, Count, Bytes/Second, Kilobytes/Second, Megabytes/Second, Gigabytes/Second, Terabytes/Second, Bits/Second, Kilobits/Second, Megabits/Second, Gigabits/Second, Terabits/Second, Count/Second, or None.")
  unit?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Metric")
model Metric {
  @doc("The metric dimensions that you want to be used for the metric that the alarm will watch.")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];

  @doc("The name of the metric that you want the alarm to watch. This is a required field.")
  metricName?: string;

  @doc("The namespace of the metric that the alarm will watch.")
  `namespace`?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CloudWatchAlarms {
  get is ArmResourceRead<CloudWatchAlarm>;
  @doc("Create a CloudWatchAlarm. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<CloudWatchAlarm>;
  update is ArmCustomPatchAsync<
    CloudWatchAlarm,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CloudWatchAlarm>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CloudWatchAlarm>;
  listByResourceGroup is ArmResourceListByParent<CloudWatchAlarm>;
  listBySubscription is ArmListBySubscription<CloudWatchAlarm>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::CloudWatch::Alarm
//--------------------------------------------------------------------------------------------
