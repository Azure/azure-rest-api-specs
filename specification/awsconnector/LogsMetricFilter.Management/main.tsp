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

//---------------------------------------------- LogsMetricFilters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Logs Metric Filter",
    plural: "Logs Metric Filters",
  },
  keywords: ["Microsoft.AwsConnector", "Logs", "Metric", "Filter"],
})
@doc("A Microsoft.AwsConnector resource")
model LogsMetricFilter is TrackedResource<LogsMetricFilterProperties> {
  @doc("Name of LogsMetricFilter")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("logsMetricFilters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogsMetricFilter")
model LogsMetricFilterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsLogsMetricFilterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLogsMetricFilter")
model AwsLogsMetricFilterProperties {
  @doc("The name of the metric filter.")
  filterName?: string;

  @doc("A filter pattern for extracting metric data out of ingested log events. For more information, see [Filter and Pattern Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html).")
  filterPattern?: string;

  @doc("The name of an existing log group that you want to associate with this metric filter.")
  logGroupName?: string;

  @doc("The metric transformations.")
  @extension("x-ms-identifiers", [])
  metricTransformations?: MetricTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricTransformation")
model MetricTransformation {
  @doc("(Optional) The value to emit when a filter pattern does not match a log event. This value can be null.")
  defaultValue?: int32;

  @doc("The fields to use as dimensions for the metric. One metric filter can include as many as three dimensions.  Metrics extracted from log events are charged as custom metrics. To prevent unexpected high charges, do not specify high-cardinality fields such as ``IPAddress`` or ``requestID`` as dimensions. Each different value found for a dimension is treated as a separate metric and accrues charges as a separate custom metric.  CloudWatch Logs disables a metric filter if it generates 1000 different name/value pairs for your specified dimensions within a certain amount of time. This helps to prevent accidental high charges. You can also set up a billing alarm to alert you if your charges are higher than expected. For more information, see [Creating a Billing Alarm to Monitor Your Estimated Charges](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/monitor_estimated_charges_with_cloudwatch.html).")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];

  @doc("The name of the CloudWatch metric.")
  metricName?: string;

  @doc("A custom namespace to contain your metric in CloudWatch. Use namespaces to group together metrics that are similar. For more information, see [Namespaces](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Namespace).")
  metricNamespace?: string;

  @doc("The value that is published to the CloudWatch metric. For example, if you're counting the occurrences of a particular term like ``Error``, specify 1 for the metric value. If you're counting the number of bytes transferred, reference the value that is in the log event by using $. followed by the name of the field that you specified in the filter pattern, such as ``$.size``.")
  metricValue?: string;

  @doc("The unit to assign to the metric. If you omit this, the unit is set as ``None``.")
  unit?: MetricTransformationUnit;
}

@doc("MetricTransformationUnit enum")
union MetricTransformationUnit {
  @doc("MetricTransformationUnit enum Bits")
  Bits: "Bits",

  @doc("MetricTransformationUnit enum Bits/Second")
  BitsSecond: "Bits/Second",

  @doc("MetricTransformationUnit enum Bytes")
  Bytes: "Bytes",

  @doc("MetricTransformationUnit enum Bytes/Second")
  BytesSecond: "Bytes/Second",

  @doc("MetricTransformationUnit enum Count")
  Count: "Count",

  @doc("MetricTransformationUnit enum Count/Second")
  CountSecond: "Count/Second",

  @doc("MetricTransformationUnit enum Gigabits")
  Gigabits: "Gigabits",

  @doc("MetricTransformationUnit enum Gigabits/Second")
  GigabitsSecond: "Gigabits/Second",

  @doc("MetricTransformationUnit enum Gigabytes")
  Gigabytes: "Gigabytes",

  @doc("MetricTransformationUnit enum Gigabytes/Second")
  GigabytesSecond: "Gigabytes/Second",

  @doc("MetricTransformationUnit enum Kilobits")
  Kilobits: "Kilobits",

  @doc("MetricTransformationUnit enum Kilobits/Second")
  KilobitsSecond: "Kilobits/Second",

  @doc("MetricTransformationUnit enum Kilobytes")
  Kilobytes: "Kilobytes",

  @doc("MetricTransformationUnit enum Kilobytes/Second")
  KilobytesSecond: "Kilobytes/Second",

  @doc("MetricTransformationUnit enum Megabits")
  Megabits: "Megabits",

  @doc("MetricTransformationUnit enum Megabits/Second")
  MegabitsSecond: "Megabits/Second",

  @doc("MetricTransformationUnit enum Megabytes")
  Megabytes: "Megabytes",

  @doc("MetricTransformationUnit enum Megabytes/Second")
  MegabytesSecond: "Megabytes/Second",

  @doc("MetricTransformationUnit enum Microseconds")
  Microseconds: "Microseconds",

  @doc("MetricTransformationUnit enum Milliseconds")
  Milliseconds: "Milliseconds",

  @doc("MetricTransformationUnit enum None")
  None: "None",

  @doc("MetricTransformationUnit enum Percent")
  Percent: "Percent",

  @doc("MetricTransformationUnit enum Seconds")
  Seconds: "Seconds",

  @doc("MetricTransformationUnit enum Terabits")
  Terabits: "Terabits",

  @doc("MetricTransformationUnit enum Terabits/Second")
  TerabitsSecond: "Terabits/Second",

  @doc("MetricTransformationUnit enum Terabytes")
  Terabytes: "Terabytes",

  @doc("MetricTransformationUnit enum Terabytes/Second")
  TerabytesSecond: "Terabytes/Second",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Dimension")
model Dimension {
  @doc("The name for the CW metric dimension that the metric filter creates. Dimension names must contain only ASCII characters, must include at least one non-whitespace character, and cannot start with a colon (:).")
  key?: string;

  @doc("The log event field that will contain the value for this dimension. This dimension will only be published for a metric if the value is found in the log event. For example, ``$.eventType`` for JSON log events, or ``$server`` for space-delimited log events.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LogsMetricFilters {
  get is ArmResourceRead<LogsMetricFilter>;
  @doc("Create a LogsMetricFilter. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<LogsMetricFilter>;
  update is ArmCustomPatchAsync<
    LogsMetricFilter,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LogsMetricFilter>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LogsMetricFilter>;
  listByResourceGroup is ArmResourceListByParent<LogsMetricFilter>;
  listBySubscription is ArmListBySubscription<LogsMetricFilter>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Logs::MetricFilter
//--------------------------------------------------------------------------------------------
