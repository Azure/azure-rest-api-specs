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

//---------------------------------------------- LogsSubscriptionFilters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Logs Subscription Filter",
    plural: "Logs Subscription Filters",
  },
  keywords: ["Microsoft.AwsConnector", "Logs", "Subscription", "Filter"],
})
@doc("A Microsoft.AwsConnector resource")
model LogsSubscriptionFilter
  is TrackedResource<LogsSubscriptionFilterProperties> {
  @doc("Name of LogsSubscriptionFilter")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("logsSubscriptionFilters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogsSubscriptionFilter")
model LogsSubscriptionFilterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsLogsSubscriptionFilterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLogsSubscriptionFilter")
model AwsLogsSubscriptionFilterProperties {
  @doc("The Amazon Resource Name (ARN) of the destination.")
  destinationArn?: string;

  @doc("The method used to distribute log data to the destination, which can be either random or grouped by log stream.")
  distribution?: Distribution;

  @doc("The name of the subscription filter.")
  filterName?: string;

  @doc("The filtering expressions that restrict what gets delivered to the destination AWS resource. For more information about the filter pattern syntax, see [Filter and Pattern Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html).")
  filterPattern?: string;

  @doc("The log group to associate with the subscription filter. All log events that are uploaded to this log group are filtered and delivered to the specified AWS resource if the filter pattern matches the log events.")
  logGroupName?: string;

  @doc("The ARN of an IAM role that grants CWL permissions to deliver ingested log events to the destination stream. You don't need to provide the ARN when you are working with a logical destination for cross-account delivery.")
  roleArn?: string;
}

@doc("Distribution enum")
union Distribution {
  @doc("Distribution enum ByLogStream")
  ByLogStream: "ByLogStream",

  @doc("Distribution enum Random")
  Random: "Random",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LogsSubscriptionFilters {
  get is ArmResourceRead<LogsSubscriptionFilter>;
  @doc("Create a LogsSubscriptionFilter. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<LogsSubscriptionFilter>;
  update is ArmCustomPatchAsync<
    LogsSubscriptionFilter,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LogsSubscriptionFilter>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LogsSubscriptionFilter>;
  listByResourceGroup is ArmResourceListByParent<LogsSubscriptionFilter>;
  listBySubscription is ArmListBySubscription<LogsSubscriptionFilter>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Logs::SubscriptionFilter
//--------------------------------------------------------------------------------------------
