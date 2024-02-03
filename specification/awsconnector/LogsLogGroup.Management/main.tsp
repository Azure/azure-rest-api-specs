import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
  version: "2024-08-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

//---------------------------------------------- LogsLogGroups ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model LogsLogGroup is TrackedResource<LogsLogGroupProperties> {
  @doc("Name of LogsLogGroup")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("logsLogGroups")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of LogsLogGroup")
model LogsLogGroupProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLogsLogGroupProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of awsLogsLogGroup")
model AwsLogsLogGroupProperties {
  @doc("Gets and sets the property arn. The CloudWatch log group ARN.")
  arn?: string;

  @doc("Gets and sets the property dataProtectionPolicy. The body of the policy document you want to use for this topic.You can only add one policy per topic.The policy must be in JSON string format.Length Constraints: Maximum length of 30720")
  dataProtectionPolicy?: object;

  @doc("Gets and sets the property kmsKeyId. The Amazon Resource Name (ARN) of the CMK to use when encrypting log data.")
  kmsKeyId?: string;

  @doc("Gets and sets the property logGroupClass. The class of the log group. Possible values are: STANDARD and INFREQUENT_ACCESS, with STANDARD being the default class")
  logGroupClass?: LogGroupClass;

  @doc("Gets and sets the property logGroupName. The name of the log group. If you don't specify a name, AWS CloudFormation generates a unique ID for the log group.")
  logGroupName?: string;

  @doc("Gets and sets the property retentionInDays. The number of days to retain the log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, and 3653.")
  retentionInDays?: int32;

  @doc("Gets and sets the property tags. An array of key-value pairs to apply to this resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("LogGroupClass enum")
enum LogGroupClass {
  @doc("LogGroupClass enum INFREQUENT_ACCESS")
  INFREQUENT_ACCESS: "INFREQUENT_ACCESS",

  @doc("LogGroupClass enum STANDARD")
  STANDARD: "STANDARD",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., :, /, =, +, - and @.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., :, /, =, +, - and @.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LogsLogGroups {
  get is ArmResourceRead<LogsLogGroup>;
  @doc("Create a LogsLogGroup. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LogsLogGroup>;
  update is ArmCustomPatchAsync<
    LogsLogGroup,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LogsLogGroup>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LogsLogGroup>;
  listByResourceGroup is ArmResourceListByParent<LogsLogGroup>;
  listBySubscription is ArmListBySubscription<LogsLogGroup>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Logs::LogGroup
//--------------------------------------------------------------------------------------------
