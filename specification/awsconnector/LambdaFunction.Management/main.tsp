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

//---------------------------------------------- LambdaFunctions ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model LambdaFunction is TrackedResource<LambdaFunctionProperties> {
  @doc("Name of LambdaFunction")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("lambdaFunctions")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of LambdaFunction")
model LambdaFunctionProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLambdaFunctionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of awsLambdaFunction")
model AwsLambdaFunctionProperties {
  @doc("Gets and sets the property architectures.")
  @extension("x-ms-identifiers", [])
  architectures?: Architectures[];

  @doc("Gets and sets the property arn. Unique identifier for function resources")
  arn?: string;

  @doc("Gets and sets the property code. The code for the function.")
  code?: Code;

  @doc("Gets and sets the property codeSigningConfigArn. A unique Arn for CodeSigningConfig resource")
  codeSigningConfigArn?: string;

  @doc("Gets and sets the property deadLetterConfig. A dead letter queue configuration that specifies the queue or topic where Lambda sends asynchronous events when they fail processing. The dead-letter queue for failed asynchronous invocations.")
  deadLetterConfig?: DeadLetterConfig;

  @doc("Gets and sets the property description. A description of the function.")
  description?: string;

  @doc("Gets and sets the property environment. Environment variables that are accessible from function code during execution. A function's environment variable settings.")
  environment?: Environment;

  @doc("Gets and sets the property ephemeralStorage. A function's ephemeral storage settings. A function's ephemeral storage settings.")
  ephemeralStorage?: EphemeralStorage;

  @doc("Gets and sets the property fileSystemConfigs. Connection settings for an Amazon EFS file system. To connect a function to a file system, a mount target must be available in every Availability Zone that your function connects to. If your template contains an AWS::EFS::MountTarget resource, you must also specify a DependsOn attribute to ensure that the mount target is created or updated before the function.")
  @extension("x-ms-identifiers", [])
  fileSystemConfigs?: FileSystemConfig[];

  @doc("Gets and sets the property functionName. The name of the Lambda function, up to 64 characters in length. If you don't specify a name, AWS CloudFormation generates one.")
  functionName?: string;

  @doc("Gets and sets the property handler. The name of the method within your code that Lambda calls to execute your function. The format includes the file name. It can also include namespaces and other qualifiers, depending on the runtime")
  handler?: string;

  @doc("Gets and sets the property imageConfig. ImageConfig")
  imageConfig?: ImageConfig;

  @doc("Gets and sets the property kmsKeyArn. The ARN of the AWS Key Management Service (AWS KMS) key that's used to encrypt your function's environment variables. If it's not provided, AWS Lambda uses a default service key.")
  kmsKeyArn?: string;

  @doc("Gets and sets the property layers. A list of function layers to add to the function's execution environment. Specify each layer by its ARN, including the version.")
  @extension("x-ms-identifiers", [])
  layers?: string[];

  @doc("Gets and sets the property loggingConfig. The logging configuration of your function The function's logging configuration.")
  loggingConfig?: LoggingConfig;

  @doc("Gets and sets the property memorySize. The amount of memory that your function has access to. Increasing the function's memory also increases its CPU allocation. The default value is 128 MB. The value must be a multiple of 64 MB.")
  memorySize?: int32;

  @doc("Gets and sets the property packageType. PackageType.")
  packageType?: PackageType;

  @doc("Gets and sets the property reservedConcurrentExecutions. The number of simultaneous executions to reserve for the function.")
  reservedConcurrentExecutions?: int32;

  @doc("Gets and sets the property role. The Amazon Resource Name (ARN) of the function's execution role.")
  role?: string;

  @doc("Gets and sets the property runtime. The identifier of the function's runtime.")
  runtime?: string;

  @doc("Gets and sets the property runtimeManagementConfig. RuntimeManagementConfig")
  runtimeManagementConfig?: RuntimeManagementConfig;

  @doc("Gets and sets the property snapStart. The SnapStart setting of your function The function's SnapStart setting. When set to PublishedVersions, Lambda creates a snapshot of the execution environment when you publish a function version.")
  snapStart?: SnapStart;

  @doc("Gets and sets the property snapStartResponse. The SnapStart response of your function The function's SnapStart Response. When set to PublishedVersions, Lambda creates a snapshot of the execution environment when you publish a function version.")
  snapStartResponse?: SnapStartResponse;

  @doc("Gets and sets the property tags. A list of tags to apply to the function.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property timeout. The amount of time that Lambda allows a function to run before stopping it. The default is 3 seconds. The maximum allowed value is 900 seconds.")
  timeout?: int32;

  @doc("Gets and sets the property tracingConfig. Set Mode to Active to sample and trace a subset of incoming requests with AWS X-Ray. The function's AWS X-Ray tracing configuration. To sample and record incoming requests, set Mode to Active.")
  tracingConfig?: TracingConfig;

  @doc("Gets and sets the property vpcConfig. For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC. The VPC security groups and subnets that are attached to a Lambda function. When you connect a function to a VPC, Lambda creates an elastic network interface for each combination of security group and subnet in the function's VPC configuration. The function can only access resources and the internet through that VPC.")
  vpcConfig?: VpcConfig;
}

@doc("Architectures enum")
enum Architectures {
  @doc("Architectures enum arm64")
  arm64: "arm64",

  @doc("Architectures enum x86_64")
  x86_64: "x86_64",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of Code")
model Code {
  @doc("Gets and sets the property imageUri. ImageUri.")
  imageUri?: string;

  @doc("Gets and sets the property s3Bucket. An Amazon S3 bucket in the same AWS Region as your function. The bucket can be in a different AWS account.")
  s3Bucket?: string;

  @doc("Gets and sets the property s3Key. The Amazon S3 key of the deployment package.")
  s3Key?: string;

  @doc("Gets and sets the property s3ObjectVersion. For versioned objects, the version of the deployment package object to use.")
  s3ObjectVersion?: string;

  @doc("Gets and sets the property zipFile. The source code of your Lambda function. If you include your function source inline with this parameter, AWS CloudFormation places it in a file named index and zips it to create a deployment package..")
  zipFile?: string;
}

@doc("PackageType enum")
enum PackageType {
  @doc("PackageType enum Image")
  Image: "Image",

  @doc("PackageType enum Zip")
  Zip: "Zip",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of DeadLetterConfig")
model DeadLetterConfig {
  @doc("Gets and sets the property targetArn. The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic.")
  targetArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of Environment")
model Environment {
  @doc("Gets and sets the property variables. Environment variable key-value pairs.")
  variables?: object;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of EphemeralStorage")
model EphemeralStorage {
  @doc("Gets and sets the property size. The amount of ephemeral storage that your function has access to.")
  size?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of FileSystemConfig")
model FileSystemConfig {
  @doc("Gets and sets the property arn. The Amazon Resource Name (ARN) of the Amazon EFS access point that provides access to the file system.")
  arn?: string;

  @doc("Gets and sets the property localMountPath. The path where the function can access the file system, starting with /mnt/.")
  localMountPath?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of ImageConfig")
model ImageConfig {
  @doc("Gets and sets the property command. Command.")
  @extension("x-ms-identifiers", [])
  command?: string[];

  @doc("Gets and sets the property entryPoint. EntryPoint.")
  @extension("x-ms-identifiers", [])
  entryPoint?: string[];

  @doc("Gets and sets the property workingDirectory. WorkingDirectory.")
  workingDirectory?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of LoggingConfig")
model LoggingConfig {
  @doc("Gets and sets the property applicationLogLevel. Application log granularity level, can only be used when LogFormat is set to JSON")
  applicationLogLevel?: LoggingConfigApplicationLogLevel;

  @doc("Gets and sets the property logFormat. Log delivery format for the lambda function")
  logFormat?: LoggingConfigLogFormat;

  @doc("Gets and sets the property logGroup. The log group name.")
  logGroup?: string;

  @doc("Gets and sets the property systemLogLevel. System log granularity level, can only be used when LogFormat is set to JSON")
  systemLogLevel?: LoggingConfigSystemLogLevel;
}

@doc("LoggingConfigApplicationLogLevel enum")
enum LoggingConfigApplicationLogLevel {
  @doc("LoggingConfigApplicationLogLevel enum DEBUG")
  DEBUG: "DEBUG",

  @doc("LoggingConfigApplicationLogLevel enum ERROR")
  ERROR: "ERROR",

  @doc("LoggingConfigApplicationLogLevel enum FATAL")
  FATAL: "FATAL",

  @doc("LoggingConfigApplicationLogLevel enum INFO")
  INFO: "INFO",

  @doc("LoggingConfigApplicationLogLevel enum TRACE")
  TRACE: "TRACE",

  @doc("LoggingConfigApplicationLogLevel enum WARN")
  WARN: "WARN",
}

@doc("LoggingConfigSystemLogLevel enum")
enum LoggingConfigSystemLogLevel {
  @doc("LoggingConfigSystemLogLevel enum DEBUG")
  DEBUG: "DEBUG",

  @doc("LoggingConfigSystemLogLevel enum INFO")
  INFO: "INFO",

  @doc("LoggingConfigSystemLogLevel enum WARN")
  WARN: "WARN",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of RuntimeManagementConfig")
model RuntimeManagementConfig {
  @doc("Gets and sets the property runtimeVersionArn. Unique identifier for a runtime version arn")
  runtimeVersionArn?: string;

  @doc("Gets and sets the property updateRuntimeOn. Trigger for runtime update")
  updateRuntimeOn?: RuntimeManagementConfigUpdateRuntimeOn;
}

@doc("LoggingConfigLogFormat enum")
enum LoggingConfigLogFormat {
  @doc("LoggingConfigLogFormat enum JSON")
  JSON: "JSON",

  @doc("LoggingConfigLogFormat enum Text")
  Text: "Text",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of SnapStart")
model SnapStart {
  @doc("Gets and sets the property applyOn. Applying SnapStart setting on function resource type.")
  applyOn?: SnapStartApplyOn;
}

@doc("RuntimeManagementConfigUpdateRuntimeOn enum")
enum RuntimeManagementConfigUpdateRuntimeOn {
  @doc("RuntimeManagementConfigUpdateRuntimeOn enum Auto")
  Auto: "Auto",

  @doc("RuntimeManagementConfigUpdateRuntimeOn enum FunctionUpdate")
  FunctionUpdate: "FunctionUpdate",

  @doc("RuntimeManagementConfigUpdateRuntimeOn enum Manual")
  Manual: "Manual",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of SnapStartResponse")
model SnapStartResponse {
  @doc("Gets and sets the property applyOn. Applying SnapStart setting on function resource type.")
  applyOn?: SnapStartResponseApplyOn;

  @doc("Gets and sets the property optimizationStatus. Indicates whether SnapStart is activated for the specified function version.")
  optimizationStatus?: SnapStartResponseOptimizationStatus;
}

@doc("SnapStartApplyOn enum")
enum SnapStartApplyOn {
  @doc("SnapStartApplyOn enum None")
  None: "None",

  @doc("SnapStartApplyOn enum PublishedVersions")
  PublishedVersions: "PublishedVersions",
}

@doc("SnapStartResponseOptimizationStatus enum")
enum SnapStartResponseOptimizationStatus {
  @doc("SnapStartResponseOptimizationStatus enum Off")
  Off: "Off",

  @doc("SnapStartResponseOptimizationStatus enum On")
  On: "On",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

@doc("SnapStartResponseApplyOn enum")
enum SnapStartResponseApplyOn {
  @doc("SnapStartResponseApplyOn enum None")
  None: "None",

  @doc("SnapStartResponseApplyOn enum PublishedVersions")
  PublishedVersions: "PublishedVersions",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of TracingConfig")
model TracingConfig {
  @doc("Gets and sets the property mode. The tracing mode.")
  mode?: TracingConfigMode;
}

@doc("TracingConfigMode enum")
enum TracingConfigMode {
  @doc("TracingConfigMode enum Active")
  Active: "Active",

  @doc("TracingConfigMode enum PassThrough")
  PassThrough: "PassThrough",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of VpcConfig")
model VpcConfig {
  @doc("Gets and sets the property ipv6AllowedForDualStack. A boolean indicating whether IPv6 protocols will be allowed for dual stack subnets")
  ipv6AllowedForDualStack?: boolean;

  @doc("Gets and sets the property securityGroupIds. A list of VPC security groups IDs.")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Gets and sets the property subnetIds. A list of VPC subnet IDs.")
  @extension("x-ms-identifiers", [])
  subnetIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LambdaFunctions {
  get is ArmResourceRead<LambdaFunction>;
  @doc("Create a LambdaFunction. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LambdaFunction>;
  update is ArmCustomPatchAsync<
    LambdaFunction,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LambdaFunction>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LambdaFunction>;
  listByResourceGroup is ArmResourceListByParent<LambdaFunction>;
  listBySubscription is ArmListBySubscription<LambdaFunction>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Lambda::Function
//--------------------------------------------------------------------------------------------
