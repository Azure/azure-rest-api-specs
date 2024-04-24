import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

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
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- CloudWatchAlarms ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsCloudWatchAlarmProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCloudWatchAlarm")
model AwsCloudWatchAlarmProperties {
  @doc("Gets and sets the property actionsEnabled. Indicates whether actions should be executed during any changes to the alarm state. The default is TRUE.")
  actionsEnabled?: boolean;

  @doc("Gets and sets the property alarmActions. The list of actions to execute when this alarm transitions into an ALARM state from any other state.")
  @extension("x-ms-identifiers", [])
  alarmActions?: string[];

  @doc("Gets and sets the property alarmDescription. The description of the alarm.")
  alarmDescription?: string;

  @doc("Gets and sets the property alarmName. The name of the alarm.")
  alarmName?: string;

  @doc("Gets and sets the property arn. Amazon Resource Name is a unique name for each resource.")
  arn?: string;

  @doc("Gets and sets the property comparisonOperator. The arithmetic operation to use when comparing the specified statistic and threshold.")
  comparisonOperator?: string;

  @doc("Gets and sets the property datapointsToAlarm. The number of datapoints that must be breaching to trigger the alarm.")
  datapointsToAlarm?: int32;

  @doc("Gets and sets the property dimensions. The dimensions for the metric associated with the alarm. For an alarm based on a math expression, you can't specify Dimensions. Instead, you use Metrics.")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];

  @doc("Gets and sets the property evaluateLowSampleCountPercentile. Used only for alarms based on percentiles.")
  evaluateLowSampleCountPercentile?: string;

  @doc("Gets and sets the property evaluationPeriods. The number of periods over which data is compared to the specified threshold.")
  evaluationPeriods?: int32;

  @doc("Gets and sets the property extendedStatistic. The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100.")
  extendedStatistic?: string;

  @doc("Gets and sets the property insufficientDataActions. The actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state.")
  @extension("x-ms-identifiers", [])
  insufficientDataActions?: string[];

  @doc("Gets and sets the property metricName. The name of the metric associated with the alarm.")
  metricName?: string;

  @doc("Gets and sets the property metrics. An array that enables you to create an alarm based on the result of a metric math expression.")
  @extension("x-ms-identifiers", [])
  metrics?: MetricDataQuery[];

  @doc("Gets and sets the property `namespace`. The namespace of the metric associated with the alarm.")
  `namespace`?: string;

  @doc("Gets and sets the property okActions. The actions to execute when this alarm transitions to the OK state from any other state.")
  @extension("x-ms-identifiers", [])
  okActions?: string[];

  @doc("Gets and sets the property period. The period in seconds, over which the statistic is applied.")
  period?: int32;

  @doc("Gets and sets the property statistic. The statistic for the metric associated with the alarm, other than percentile.")
  statistic?: string;

  @doc("Gets and sets the property threshold. In an alarm based on an anomaly detection model, this is the ID of the ANOMALY_DETECTION_BAND function used as the threshold for the alarm.")
  threshold?: int32;

  @doc("Gets and sets the property thresholdMetricId. In an alarm based on an anomaly detection model, this is the ID of the ANOMALY_DETECTION_BAND function used as the threshold for the alarm.")
  thresholdMetricId?: string;

  @doc("Gets and sets the property treatMissingData. Sets how this alarm is to handle missing data points. Valid values are breaching, notBreaching, ignore, and missing.")
  treatMissingData?: string;

  @doc("Gets and sets the property unit. The unit of the metric associated with the alarm.")
  unit?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Dimension")
model Dimension {
  @doc("Gets and sets the property name. The name of the dimension.")
  name?: string;

  @doc("Gets and sets the property value. The value for the dimension.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricDataQuery")
model MetricDataQuery {
  @doc("Gets and sets the property accountId. The ID of the account where the metrics are located, if this is a cross-account alarm.")
  accountId?: string;

  @doc("Gets and sets the property expression. The math expression to be performed on the returned data.")
  expression?: string;

  @doc("Gets and sets the property id. A short name used to tie this object to the results in the response.")
  id?: string;

  @doc("Gets and sets the property label. A human-readable label for this metric or expression.")
  label?: string;

  @doc("Gets and sets the property metricStat. The metric to be returned, along with statistics, period, and units. This structure defines the metric to be returned, along with the statistics, period, and units.")
  metricStat?: MetricStat;

  @doc("Gets and sets the property period. The period in seconds, over which the statistic is applied.")
  period?: int32;

  @doc("Gets and sets the property returnData. This option indicates whether to return the timestamps and raw data values of this metric.")
  returnData?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricStat")
model MetricStat {
  @doc("Gets and sets the property metric. The metric to return, including the metric name, namespace, and dimensions. The Metric property type represents a specific metric.")
  metric?: Metric;

  @doc("Gets and sets the property period. The granularity, in seconds, of the returned data points.")
  period?: int32;

  @doc("Gets and sets the property stat. The statistic to return.")
  stat?: string;

  @doc("Gets and sets the property unit. The unit to use for the returned data points.")
  unit?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Metric")
model Metric {
  @doc("Gets and sets the property dimensions. The dimensions for the metric.")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];

  @doc("Gets and sets the property metricName. The name of the metric.")
  metricName?: string;

  @doc("Gets and sets the property `namespace`. The namespace of the metric.")
  `namespace`?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CloudWatchAlarms {
  get is ArmResourceRead<CloudWatchAlarm>;
  @doc("Create a CloudWatchAlarm. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CloudWatchAlarm>;
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
