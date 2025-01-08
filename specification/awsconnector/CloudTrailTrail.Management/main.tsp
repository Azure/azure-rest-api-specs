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

//---------------------------------------------- CloudTrailTrails ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Cloud Trail Trail",
    plural: "Cloud Trail Trails",
  },
  keywords: ["Microsoft.AwsConnector", "Cloud", "Trail", "Trail"],
})
@doc("A Microsoft.AwsConnector resource")
model CloudTrailTrail is TrackedResource<CloudTrailTrailProperties> {
  @doc("Name of CloudTrailTrail")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("cloudTrailTrails")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CloudTrailTrail")
model CloudTrailTrailProperties {
  @doc("AWS Properties")
  awsProperties?: AwsCloudTrailTrailProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCloudTrailTrail")
model AwsCloudTrailTrailProperties {
  @doc("The advanced event selectors that were used to select events for the data store.")
  @extension("x-ms-identifiers", [])
  advancedEventSelectors?: AdvancedEventSelector[];

  @doc("Property arn")
  arn?: string;

  @doc("Specifies a log group name using an Amazon Resource Name (ARN), a unique identifier that represents the log group to which CloudTrail logs will be delivered. Not required unless you specify CloudWatchLogsRoleArn.")
  cloudWatchLogsLogGroupArn?: string;

  @doc("Specifies the role for the CloudWatch Logs endpoint to assume to write to a user's log group.")
  cloudWatchLogsRoleArn?: string;

  @doc("Specifies whether log file validation is enabled. The default is false.")
  enableLogFileValidation?: boolean;

  @doc("Use event selectors to further specify the management and data event settings for your trail. By default, trails created without specific event selectors will be configured to log all read and write management events, and no data events. When an event occurs in your account, CloudTrail evaluates the event selector for all trails. For each trail, if the event matches any event selector, the trail processes and logs the event. If the event doesn't match any event selector, the trail doesn't log the event. You can configure up to five event selectors for a trail.")
  @extension("x-ms-identifiers", [])
  eventSelectors?: EventSelector[];

  @doc("Specifies whether the trail is publishing events from global services such as IAM to the log files.")
  includeGlobalServiceEvents?: boolean;

  @doc("Lets you enable Insights event logging by specifying the Insights selectors that you want to enable on an existing trail.")
  @extension("x-ms-identifiers", [])
  insightSelectors?: InsightSelector[];

  @doc("Whether the CloudTrail is currently logging AWS API calls.")
  isLogging?: boolean;

  @doc("Specifies whether the trail applies only to the current region or to all regions. The default is false. If the trail exists only in the current region and this value is set to true, shadow trails (replications of the trail) will be created in the other regions. If the trail exists in all regions and this value is set to false, the trail will remain in the region where it was created, and its shadow trails in other regions will be deleted. As a best practice, consider using trails that log events in all regions.")
  isMultiRegionTrail?: boolean;

  @doc("Specifies whether the trail is created for all accounts in an organization in AWS Organizations, or only for the current AWS account. The default is false, and cannot be true unless the call is made on behalf of an AWS account that is the master account for an organization in AWS Organizations.")
  isOrganizationTrail?: boolean;

  @doc("Specifies the KMS key ID to use to encrypt the logs delivered by CloudTrail. The value can be an alias name prefixed by 'alias/', a fully specified ARN to an alias, a fully specified ARN to a key, or a globally unique identifier.")
  kmsKeyId?: string;

  @doc("Specifies the name of the Amazon S3 bucket designated for publishing log files. See Amazon S3 Bucket Naming Requirements.")
  s3BucketName?: string;

  @doc("Specifies the Amazon S3 key prefix that comes after the name of the bucket you have designated for log file delivery. For more information, see Finding Your CloudTrail Log Files. The maximum length is 200 characters.")
  s3KeyPrefix?: string;

  @doc("Property snsTopicArn")
  snsTopicArn?: string;

  @doc("Specifies the name of the Amazon SNS topic defined for notification of log file delivery. The maximum length is 256 characters.")
  snsTopicName?: string;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property trailName")
  trailName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AdvancedEventSelector")
model AdvancedEventSelector {
  @doc("Contains all selector statements in an advanced event selector.")
  @extension("x-ms-identifiers", [])
  fieldSelectors?: AdvancedFieldSelector[];

  @doc("An optional, descriptive name for an advanced event selector, such as 'Log data events for only two S3 buckets'.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EventSelector")
model EventSelector {
  @doc("Property dataResources")
  @extension("x-ms-identifiers", [])
  dataResources?: DataResource[];

  @doc("An optional list of service event sources from which you do not want management events to be logged on your trail. In this release, the list can be empty (disables the filter), or it can filter out AWS Key Management Service events by containing 'kms.amazonaws.com'. By default, ExcludeManagementEventSources is empty, and AWS KMS events are included in events that are logged to your trail.")
  @extension("x-ms-identifiers", [])
  excludeManagementEventSources?: string[];

  @doc("Specify if you want your event selector to include management events for your trail.")
  includeManagementEvents?: boolean;

  @doc("Specify if you want your trail to log read-only events, write-only events, or all. For example, the EC2 GetConsoleOutput is a read-only API operation and RunInstances is a write-only API operation.")
  readWriteType?: EventSelectorReadWriteType;
}

@doc("EventSelectorReadWriteType enum")
union EventSelectorReadWriteType {
  @doc("EventSelectorReadWriteType enum All")
  All: "All",

  @doc("EventSelectorReadWriteType enum ReadOnly")
  ReadOnly: "ReadOnly",

  @doc("EventSelectorReadWriteType enum WriteOnly")
  WriteOnly: "WriteOnly",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InsightSelector")
model InsightSelector {
  @doc("The type of insight to log on a trail.")
  insightType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key name of the tag. You can specify a value that is 1 to 127 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("The value for the tag. You can specify a value that is 1 to 255 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AdvancedFieldSelector")
model AdvancedFieldSelector {
  @doc("An operator that includes events that match the last few characters of the event record field specified as the value of Field.")
  @extension("x-ms-identifiers", [])
  endsWith?: string[];

  @doc("An operator that includes events that match the exact value of the event record field specified as the value of Field. This is the only valid operator that you can use with the readOnly, eventCategory, and resources.type fields.")
  @extension("x-ms-identifiers", [])
  equals?: string[];

  @doc("A field in an event record on which to filter events to be logged. Supported fields include readOnly, eventCategory, eventSource (for management events), eventName, resources.type, and resources.ARN.")
  field?: string;

  @doc("An operator that excludes events that match the last few characters of the event record field specified as the value of Field.")
  @extension("x-ms-identifiers", [])
  notEndsWith?: string[];

  @doc("An operator that excludes events that match the exact value of the event record field specified as the value of Field.")
  @extension("x-ms-identifiers", [])
  notEquals?: string[];

  @doc("An operator that excludes events that match the first few characters of the event record field specified as the value of Field.")
  @extension("x-ms-identifiers", [])
  notStartsWith?: string[];

  @doc("An operator that includes events that match the first few characters of the event record field specified as the value of Field.")
  @extension("x-ms-identifiers", [])
  startsWith?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DataResource")
model DataResource {
  @doc("The resource type in which you want to log data events. You can specify AWS::S3::Object or AWS::Lambda::Function resources.")
  type?: string;

  @doc("An array of Amazon Resource Name (ARN) strings or partial ARN strings for the specified objects.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CloudTrailTrails {
  get is ArmResourceRead<CloudTrailTrail>;
  @doc("Create a CloudTrailTrail. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<CloudTrailTrail>;
  update is ArmCustomPatchAsync<
    CloudTrailTrail,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CloudTrailTrail>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CloudTrailTrail>;
  listByResourceGroup is ArmResourceListByParent<CloudTrailTrail>;
  listBySubscription is ArmListBySubscription<CloudTrailTrail>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::CloudTrail::Trail
//--------------------------------------------------------------------------------------------
