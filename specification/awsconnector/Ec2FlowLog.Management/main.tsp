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

//---------------------------------------------- Ec2FlowLogs ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Flow Log",
    plural: "EC2 Flow Logs",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Flow", "Log"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2FlowLog is TrackedResource<Ec2FlowLogProperties> {
  @doc("Name of Ec2FlowLog")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2FlowLogs")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2FlowLog")
model Ec2FlowLogProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2FlowLogProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2FlowLog")
model AwsEc2FlowLogProperties {
  @doc("The ARN of the IAM role that allows Amazon EC2 to publish flow logs across accounts.")
  deliverCrossAccountRole?: string;

  @doc("The ARN for the IAM role that permits Amazon EC2 to publish flow logs to a CloudWatch Logs log group in your account. If you specify LogDestinationType as s3 or kinesis-data-firehose, do not specify DeliverLogsPermissionArn or LogGroupName.")
  deliverLogsPermissionArn?: string;

  @doc("Property destinationOptions")
  destinationOptions?: DestinationOptionsModelProperties;

  @doc("The Flow Log ID")
  id?: string;

  @doc("Specifies the destination to which the flow log data is to be published. Flow log data can be published to a CloudWatch Logs log group, an Amazon S3 bucket, or a Kinesis Firehose stream. The value specified for this parameter depends on the value specified for LogDestinationType.")
  logDestination?: string;

  @doc("Specifies the type of destination to which the flow log data is to be published. Flow log data can be published to CloudWatch Logs or Amazon S3.")
  logDestinationType?: LogDestinationType;

  @doc("The fields to include in the flow log record, in the order in which they should appear.")
  logFormat?: string;

  @doc("The name of a new or existing CloudWatch Logs log group where Amazon EC2 publishes your flow logs. If you specify LogDestinationType as s3 or kinesis-data-firehose, do not specify DeliverLogsPermissionArn or LogGroupName.")
  logGroupName?: string;

  @doc("The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. You can specify 60 seconds (1 minute) or 600 seconds (10 minutes).")
  maxAggregationInterval?: int32;

  @doc("The ID of the subnet, network interface, or VPC for which you want to create a flow log.")
  resourceId?: string;

  @doc("The type of resource for which to create the flow log. For example, if you specified a VPC ID for the ResourceId property, specify VPC for this property.")
  resourceType?: ResourceType;

  @doc("The tags to apply to the flow logs.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The type of traffic to log. You can log traffic that the resource accepts or rejects, or all traffic.")
  trafficType?: TrafficType;
}

@doc("LogDestinationType enum")
union LogDestinationType {
  @doc("LogDestinationType enum cloud-watch-logs")
  CloudWatchLogs: "cloud-watch-logs",

  @doc("LogDestinationType enum kinesis-data-firehose")
  KinesisDataFirehose: "kinesis-data-firehose",

  @doc("LogDestinationType enum s3")
  s3: "s3",

  string,
}

@doc("TrafficType enum")
union TrafficType {
  @doc("TrafficType enum ACCEPT")
  ACCEPT: "ACCEPT",

  @doc("TrafficType enum ALL")
  ALL: "ALL",

  @doc("TrafficType enum REJECT")
  REJECT: "REJECT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DestinationOptionsModelProperties")
model DestinationOptionsModelProperties {
  @doc("Property fileFormat")
  fileFormat?: FileFormat;

  @doc("Property hiveCompatiblePartitions")
  hiveCompatiblePartitions?: boolean;

  @doc("Property perHourPartition")
  perHourPartition?: boolean;
}

@doc("ResourceType enum")
union ResourceType {
  @doc("ResourceType enum NetworkInterface")
  NetworkInterface: "NetworkInterface",

  @doc("ResourceType enum Subnet")
  Subnet: "Subnet",

  @doc("ResourceType enum TransitGateway")
  TransitGateway: "TransitGateway",

  @doc("ResourceType enum TransitGatewayAttachment")
  TransitGatewayAttachment: "TransitGatewayAttachment",

  @doc("ResourceType enum VPC")
  VPC: "VPC",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

@doc("FileFormat enum")
union FileFormat {
  @doc("FileFormat enum parquet")
  parquet: "parquet",

  @doc("FileFormat enum plain-text")
  PlainText: "plain-text",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2FlowLogs {
  get is ArmResourceRead<Ec2FlowLog>;
  @doc("Create a Ec2FlowLog. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2FlowLog>;
  update is ArmCustomPatchAsync<
    Ec2FlowLog,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2FlowLog>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2FlowLog>;
  listByResourceGroup is ArmResourceListByParent<Ec2FlowLog>;
  listBySubscription is ArmListBySubscription<Ec2FlowLog>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::FlowLog
//--------------------------------------------------------------------------------------------
