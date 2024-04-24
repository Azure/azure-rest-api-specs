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

//---------------------------------------------- LogsMetricFilters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLogsMetricFilterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLogsMetricFilter")
model AwsLogsMetricFilterProperties {
  @doc("Gets and sets the property filterName. A name for the metric filter.")
  filterName?: string;

  @doc("Gets and sets the property filterPattern. Pattern that Logs follows to interpret each entry in a log.")
  filterPattern?: string;

  @doc("Gets and sets the property logGroupName. Existing log group that you want to associate with this filter.")
  logGroupName?: string;

  @doc("Gets and sets the property metricTransformations. A collection of information that defines how metric data gets emitted.")
  @extension("x-ms-identifiers", [])
  metricTransformations?: MetricTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricTransformation")
model MetricTransformation {
  @doc("Gets and sets the property defaultValue. The value to emit when a filter pattern does not match a log event. This value can be null.")
  defaultValue?: int32;

  @doc("Gets and sets the property dimensions. Dimensions are the key-value pairs that further define a metric")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];

  @doc("Gets and sets the property metricName. The name of the CloudWatch metric. Metric name must be in ASCII format.")
  metricName?: string;

  @doc("Gets and sets the property metricNamespace. The namespace of the CloudWatch metric.")
  metricNamespace?: string;

  @doc("Gets and sets the property metricValue. The value to publish to the CloudWatch metric when a filter pattern matches a log event.")
  metricValue?: string;

  @doc("Gets and sets the property unit. The unit to assign to the metric. If you omit this, the unit is set as None.")
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
  @doc("Gets and sets the property key. The key of the dimension. Maximum length of 255.")
  key?: string;

  @doc("Gets and sets the property value. The value of the dimension. Maximum length of 255.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LogsMetricFilters {
  get is ArmResourceRead<LogsMetricFilter>;
  @doc("Create a LogsMetricFilter. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LogsMetricFilter>;
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
