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
  version: "2023-12-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AwsConnector;

//---------------------------------------------- LambdaFunctionConfigurations ----------------------------------------------
@doc("A Microsoft.AwsConnector resource")
model LambdaFunctionConfiguration
  is TrackedResource<LambdaFunctionConfigurationProperties> {
  @doc("Name of LambdaFunctionConfiguration")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("lambdaFunctionConfigurations")
  name: string;
}

@doc("Definition of LambdaFunctionConfiguration")
model LambdaFunctionConfigurationProperties extends AwsCommonProperties {
  @doc("Gets and sets the property awsProperties. ")
  awsProperties?: AwsLambdaFunctionConfigurationProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of awsLambdaFunctionConfiguration")
model AwsLambdaFunctionConfigurationProperties {
  @doc("Gets and sets the property architectures. <p>The instruction set architecture that the function supports. Architecture is a string array with one of the valid values. The default architecture value is <code>x86_64</code>.</p>")
  @extension("x-ms-identifiers", [])
  architectures?: Architecture[];

  @doc("Gets and sets the property codeSha256. <p>The SHA256 hash of the function's deployment package.</p>")
  codeSha256?: string;

  @doc("Gets and sets the property codeSize. <p>The size of the function's deployment package, in bytes.</p>")
  codeSize?: int64;

  @doc("Gets and sets the property deadLetterConfig. <p>The function's dead letter queue.</p>")
  deadLetterConfig?: DeadLetterConfig;

  @doc("Gets and sets the property description. <p>The function's description.</p>")
  description?: string;

  @doc("Gets and sets the property environment. <p>The function's <a href='https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html'>environment variables</a>. Omitted from CloudTrail logs.</p>")
  environment?: EnvironmentResponse;

  @doc("Gets and sets the property ephemeralStorage. <p>The size of the function’s <code>/tmp</code> directory in MB. The default value is 512, but it can be any whole number between 512 and 10,240 MB.</p>")
  ephemeralStorage?: EphemeralStorage;

  @doc("Gets and sets the property fileSystemConfigs. <p>Connection settings for an <a href='https://docs.aws.amazon.com/lambda/latest/dg/configuration-filesystem.html'>Amazon EFS file system</a>.</p>")
  @extension("x-ms-identifiers", [])
  fileSystemConfigs?: FileSystemConfig[];

  @doc("Gets and sets the property functionArn. <p>The function's Amazon Resource Name (ARN).</p>")
  functionArn?: string;

  @doc("Gets and sets the property functionName. <p>The name of the function.</p>")
  functionName?: string;

  @doc("Gets and sets the property handler. <p>The function that Lambda calls to begin running your function.</p>")
  handler?: string;

  @doc("Gets and sets the property imageConfigResponse. <p>The function's image configuration values.</p>")
  imageConfigResponse?: ImageConfigResponse;

  @doc("Gets and sets the property kMSKeyArn. <p>The KMS key that's used to encrypt the function's <a href='https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html#configuration-envvars-encryption'>environment variables</a>. When <a href='https://docs.aws.amazon.com/lambda/latest/dg/snapstart-security.html'>Lambda SnapStart</a> is activated, this key is also used to encrypt the function's snapshot. This key is returned only if you've configured a customer managed key.</p>")
  kMSKeyArn?: string;

  @doc("Gets and sets the property lastModified. <p>The date and time that the function was last updated, in <a href='https://www.w3.org/TR/NOTE-datetime'>ISO-8601 format</a> (YYYY-MM-DDThh:mm:ss.sTZD).</p>")
  lastModified?: string;

  @doc("Gets and sets the property lastUpdateStatus. <p>The status of the last update that was performed on the function. This is first set to <code>Successful</code> after function creation completes.</p>")
  lastUpdateStatus?: LastUpdateStatusEnumValue;

  @doc("Gets and sets the property lastUpdateStatusReason. <p>The reason for the last update that was performed on the function.</p>")
  lastUpdateStatusReason?: string;

  @doc("Gets and sets the property lastUpdateStatusReasonCode. <p>The reason code for the last update that was performed on the function.</p>")
  lastUpdateStatusReasonCode?: LastUpdateStatusReasonCodeEnumValue;

  @doc("Gets and sets the property layers. <p>The function's <a href='https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html'>layers</a>.</p>")
  @extension("x-ms-identifiers", [])
  layers?: Layer[];

  @doc("Gets and sets the property masterArn. <p>For Lambda@Edge functions, the ARN of the main function.</p>")
  masterArn?: string;

  @doc("Gets and sets the property memorySize. <p>The amount of memory available to the function at runtime.</p>")
  memorySize?: int32;

  @doc("Gets and sets the property packageType. <p>The type of deployment package. Set to <code>Image</code> for container image and set <code>Zip</code> for .zip file archive.</p>")
  packageType?: PackageTypeEnumValue;

  @doc("Gets and sets the property revisionId. <p>The latest updated revision of the function or alias.</p>")
  revisionId?: string;

  @doc("Gets and sets the property role. <p>The function's execution role.</p>")
  role?: string;

  @doc("Gets and sets the property runtime. <p>The identifier of the function's <a href='https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html'>runtime</a>. Runtime is required if the deployment package is a .zip file archive.</p> <p>The following list includes deprecated runtimes. For more information, see <a href='https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtime-support-policy'>Runtime deprecation policy</a>.</p>")
  runtime?: RuntimeEnumValue;

  @doc("Gets and sets the property runtimeVersionConfig. <p>The ARN of the runtime and any errors that occured.</p>")
  runtimeVersionConfig?: RuntimeVersionConfig;

  @doc("Gets and sets the property signingJobArn. <p>The ARN of the signing job.</p>")
  signingJobArn?: string;

  @doc("Gets and sets the property signingProfileVersionArn. <p>The ARN of the signing profile version.</p>")
  signingProfileVersionArn?: string;

  @doc("Gets and sets the property snapStart. <p>Set <code>ApplyOn</code> to <code>PublishedVersions</code> to create a snapshot of the initialized execution environment when you publish a function version. For more information, see <a href='https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html'>Improving startup performance with Lambda SnapStart</a>.</p>")
  snapStart?: SnapStartResponse;

  @doc("Gets and sets the property state. <p>The current state of the function. When the state is <code>Inactive</code>, you can reactivate the function by invoking it.</p>")
  state?: StateEnumValue;

  @doc("Gets and sets the property stateReason. <p>The reason for the function's current state.</p>")
  stateReason?: string;

  @doc("Gets and sets the property stateReasonCode. <p>The reason code for the function's current state. When the code is <code>Creating</code>, you can't invoke or modify the function.</p>")
  stateReasonCode?: StateReasonCodeEnumValue;

  @doc("Gets and sets the property timeout. <p>The amount of time in seconds that Lambda allows a function to run before stopping it.</p>")
  timeout?: int32;

  @doc("Gets and sets the property tracingConfig. <p>The function's X-Ray tracing configuration.</p>")
  tracingConfig?: TracingConfigResponse;

  @doc("Gets and sets the property version. <p>The version of the Lambda function.</p>")
  version?: string;

  @doc("Gets and sets the property vpcConfig. <p>The function's networking configuration.</p>")
  vpcConfig?: VpcConfigResponse;
}

@doc("Architecture enum")
enum Architecture {
  @doc("Architecture enum arm64")
  Arm64: "arm64",

  @doc("Architecture enum x86_64")
  X86_64: "x86_64",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of ArchitectureEnumValue")
model ArchitectureEnumValue {
  @doc("Gets and sets the property value. ")
  value?: Architecture;
}

@doc("LastUpdateStatusReasonCode enum")
enum LastUpdateStatusReasonCode {
  @doc("LastUpdateStatusReasonCode enum DisabledKMSKey")
  Disabledkmskey: "DisabledKMSKey",

  @doc("LastUpdateStatusReasonCode enum EFSIOError")
  Efsioerror: "EFSIOError",

  @doc("LastUpdateStatusReasonCode enum EFSMountConnectivityError")
  Efsmountconnectivityerror: "EFSMountConnectivityError",

  @doc("LastUpdateStatusReasonCode enum EFSMountFailure")
  Efsmountfailure: "EFSMountFailure",

  @doc("LastUpdateStatusReasonCode enum EFSMountTimeout")
  Efsmounttimeout: "EFSMountTimeout",

  @doc("LastUpdateStatusReasonCode enum EniLimitExceeded")
  Enilimitexceeded: "EniLimitExceeded",

  @doc("LastUpdateStatusReasonCode enum FunctionError")
  Functionerror: "FunctionError",

  @doc("LastUpdateStatusReasonCode enum ImageAccessDenied")
  Imageaccessdenied: "ImageAccessDenied",

  @doc("LastUpdateStatusReasonCode enum ImageDeleted")
  Imagedeleted: "ImageDeleted",

  @doc("LastUpdateStatusReasonCode enum InsufficientRolePermissions")
  Insufficientrolepermissions: "InsufficientRolePermissions",

  @doc("LastUpdateStatusReasonCode enum InternalError")
  Internalerror: "InternalError",

  @doc("LastUpdateStatusReasonCode enum InvalidConfiguration")
  Invalidconfiguration: "InvalidConfiguration",

  @doc("LastUpdateStatusReasonCode enum InvalidImage")
  Invalidimage: "InvalidImage",

  @doc("LastUpdateStatusReasonCode enum InvalidRuntime")
  Invalidruntime: "InvalidRuntime",

  @doc("LastUpdateStatusReasonCode enum InvalidSecurityGroup")
  Invalidsecuritygroup: "InvalidSecurityGroup",

  @doc("LastUpdateStatusReasonCode enum InvalidStateKMSKey")
  Invalidstatekmskey: "InvalidStateKMSKey",

  @doc("LastUpdateStatusReasonCode enum InvalidSubnet")
  Invalidsubnet: "InvalidSubnet",

  @doc("LastUpdateStatusReasonCode enum InvalidZipFileException")
  Invalidzipfileexception: "InvalidZipFileException",

  @doc("LastUpdateStatusReasonCode enum KMSKeyAccessDenied")
  Kmskeyaccessdenied: "KMSKeyAccessDenied",

  @doc("LastUpdateStatusReasonCode enum KMSKeyNotFound")
  Kmskeynotfound: "KMSKeyNotFound",

  @doc("LastUpdateStatusReasonCode enum SubnetOutOfIPAddresses")
  Subnetoutofipaddresses: "SubnetOutOfIPAddresses",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of LastUpdateStatusReasonCodeEnumValue")
model LastUpdateStatusReasonCodeEnumValue {
  @doc("Gets and sets the property value. ")
  value?: LastUpdateStatusReasonCode;
}

@doc("Runtime enum")
enum Runtime {
  @doc("Runtime enum dotnet6")
  Dotnet6: "dotnet6",

  @doc("Runtime enum dotnetcore1.0")
  Dotnetcore10: "dotnetcore1.0",

  @doc("Runtime enum dotnetcore2.0")
  Dotnetcore20: "dotnetcore2.0",

  @doc("Runtime enum dotnetcore2.1")
  Dotnetcore21: "dotnetcore2.1",

  @doc("Runtime enum dotnetcore3.1")
  Dotnetcore31: "dotnetcore3.1",

  @doc("Runtime enum go1.x")
  Go1x: "go1.x",

  @doc("Runtime enum java11")
  Java11: "java11",

  @doc("Runtime enum java17")
  Java17: "java17",

  @doc("Runtime enum java8")
  Java8: "java8",

  @doc("Runtime enum java8.al2")
  Java8al2: "java8.al2",

  @doc("Runtime enum nodejs")
  Nodejs: "nodejs",

  @doc("Runtime enum nodejs10.x")
  Nodejs10x: "nodejs10.x",

  @doc("Runtime enum nodejs12.x")
  Nodejs12x: "nodejs12.x",

  @doc("Runtime enum nodejs14.x")
  Nodejs14x: "nodejs14.x",

  @doc("Runtime enum nodejs16.x")
  Nodejs16x: "nodejs16.x",

  @doc("Runtime enum nodejs18.x")
  Nodejs18x: "nodejs18.x",

  @doc("Runtime enum nodejs4.3")
  Nodejs43: "nodejs4.3",

  @doc("Runtime enum nodejs4.3-edge")
  Nodejs43edge: "nodejs4.3-edge",

  @doc("Runtime enum nodejs6.10")
  Nodejs610: "nodejs6.10",

  @doc("Runtime enum nodejs8.10")
  Nodejs810: "nodejs8.10",

  @doc("Runtime enum provided")
  Provided: "provided",

  @doc("Runtime enum provided.al2")
  Providedal2: "provided.al2",

  @doc("Runtime enum python2.7")
  Python27: "python2.7",

  @doc("Runtime enum python3.10")
  Python310: "python3.10",

  @doc("Runtime enum python3.6")
  Python36: "python3.6",

  @doc("Runtime enum python3.7")
  Python37: "python3.7",

  @doc("Runtime enum python3.8")
  Python38: "python3.8",

  @doc("Runtime enum python3.9")
  Python39: "python3.9",

  @doc("Runtime enum ruby2.5")
  Ruby25: "ruby2.5",

  @doc("Runtime enum ruby2.7")
  Ruby27: "ruby2.7",

  @doc("Runtime enum ruby3.2")
  Ruby32: "ruby3.2",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of RuntimeEnumValue")
model RuntimeEnumValue {
  @doc("Gets and sets the property value. ")
  value?: Runtime;
}

@doc("StateReasonCode enum")
enum StateReasonCode {
  @doc("StateReasonCode enum Creating")
  Creating: "Creating",

  @doc("StateReasonCode enum DisabledKMSKey")
  Disabledkmskey: "DisabledKMSKey",

  @doc("StateReasonCode enum EFSIOError")
  Efsioerror: "EFSIOError",

  @doc("StateReasonCode enum EFSMountConnectivityError")
  Efsmountconnectivityerror: "EFSMountConnectivityError",

  @doc("StateReasonCode enum EFSMountFailure")
  Efsmountfailure: "EFSMountFailure",

  @doc("StateReasonCode enum EFSMountTimeout")
  Efsmounttimeout: "EFSMountTimeout",

  @doc("StateReasonCode enum EniLimitExceeded")
  Enilimitexceeded: "EniLimitExceeded",

  @doc("StateReasonCode enum FunctionError")
  Functionerror: "FunctionError",

  @doc("StateReasonCode enum Idle")
  Idle: "Idle",

  @doc("StateReasonCode enum ImageAccessDenied")
  Imageaccessdenied: "ImageAccessDenied",

  @doc("StateReasonCode enum ImageDeleted")
  Imagedeleted: "ImageDeleted",

  @doc("StateReasonCode enum InsufficientRolePermissions")
  Insufficientrolepermissions: "InsufficientRolePermissions",

  @doc("StateReasonCode enum InternalError")
  Internalerror: "InternalError",

  @doc("StateReasonCode enum InvalidConfiguration")
  Invalidconfiguration: "InvalidConfiguration",

  @doc("StateReasonCode enum InvalidImage")
  Invalidimage: "InvalidImage",

  @doc("StateReasonCode enum InvalidRuntime")
  Invalidruntime: "InvalidRuntime",

  @doc("StateReasonCode enum InvalidSecurityGroup")
  Invalidsecuritygroup: "InvalidSecurityGroup",

  @doc("StateReasonCode enum InvalidStateKMSKey")
  Invalidstatekmskey: "InvalidStateKMSKey",

  @doc("StateReasonCode enum InvalidSubnet")
  Invalidsubnet: "InvalidSubnet",

  @doc("StateReasonCode enum InvalidZipFileException")
  Invalidzipfileexception: "InvalidZipFileException",

  @doc("StateReasonCode enum KMSKeyAccessDenied")
  Kmskeyaccessdenied: "KMSKeyAccessDenied",

  @doc("StateReasonCode enum KMSKeyNotFound")
  Kmskeynotfound: "KMSKeyNotFound",

  @doc("StateReasonCode enum Restoring")
  Restoring: "Restoring",

  @doc("StateReasonCode enum SubnetOutOfIPAddresses")
  Subnetoutofipaddresses: "SubnetOutOfIPAddresses",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of StateReasonCodeEnumValue")
model StateReasonCodeEnumValue {
  @doc("Gets and sets the property value. ")
  value?: StateReasonCode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of DeadLetterConfig")
model DeadLetterConfig {
  @doc("Gets and sets the property targetArn. <p>The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic.</p>")
  targetArn?: string;
}

@doc("LastUpdateStatus enum")
enum LastUpdateStatus {
  @doc("LastUpdateStatus enum Failed")
  Failed: "Failed",

  @doc("LastUpdateStatus enum InProgress")
  Inprogress: "InProgress",

  @doc("LastUpdateStatus enum Successful")
  Successful: "Successful",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of LastUpdateStatusEnumValue")
model LastUpdateStatusEnumValue {
  @doc("Gets and sets the property value. ")
  value?: LastUpdateStatus;
}

@doc("State enum")
enum State {
  @doc("State enum Active")
  Active: "Active",

  @doc("State enum Failed")
  Failed: "Failed",

  @doc("State enum Inactive")
  Inactive: "Inactive",

  @doc("State enum Pending")
  Pending: "Pending",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of StateEnumValue")
model StateEnumValue {
  @doc("Gets and sets the property value. ")
  value?: State;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of EnvironmentResponse")
model EnvironmentResponse {
  @doc("Gets and sets the property error. <p>Error messages for environment variables that couldn't be applied.</p>")
  error?: EnvironmentError;

  @doc("Gets and sets the property variables. <p>Environment variable key-value pairs. Omitted from CloudTrail logs.</p>")
  variables?: Record<string>;
}

@doc("PackageType enum")
enum PackageType {
  @doc("PackageType enum Image")
  Image: "Image",

  @doc("PackageType enum Zip")
  Zip: "Zip",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of PackageTypeEnumValue")
model PackageTypeEnumValue {
  @doc("Gets and sets the property value. ")
  value?: PackageType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of EphemeralStorage")
model EphemeralStorage {
  @doc("Gets and sets the property size. <p>The size of the function's <code>/tmp</code> directory.</p>")
  size?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of FileSystemConfig")
model FileSystemConfig {
  @doc("Gets and sets the property arn. <p>The Amazon Resource Name (ARN) of the Amazon EFS access point that provides access to the file system.</p>")
  arn?: string;

  @doc("Gets and sets the property localMountPath. <p>The path where the function can access the file system, starting with <code>/mnt/</code>.</p>")
  localMountPath?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of ImageConfigResponse")
model ImageConfigResponse {
  @doc("Gets and sets the property error. <p>Error response to <code>GetFunctionConfiguration</code>.</p>")
  error?: ImageConfigError;

  @doc("Gets and sets the property imageConfig. <p>Configuration values that override the container image Dockerfile.</p>")
  imageConfig?: ImageConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of Layer")
model Layer {
  @doc("Gets and sets the property arn. <p>The Amazon Resource Name (ARN) of the function layer.</p>")
  arn?: string;

  @doc("Gets and sets the property codeSize. <p>The size of the layer archive in bytes.</p>")
  codeSize?: int64;

  @doc("Gets and sets the property signingJobArn. <p>The Amazon Resource Name (ARN) of a signing job.</p>")
  signingJobArn?: string;

  @doc("Gets and sets the property signingProfileVersionArn. <p>The Amazon Resource Name (ARN) for a signing profile version.</p>")
  signingProfileVersionArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of RuntimeVersionConfig")
model RuntimeVersionConfig {
  @doc("Gets and sets the property error. <p>Error response when Lambda is unable to retrieve the runtime version for a function.</p>")
  error?: RuntimeVersionError;

  @doc("Gets and sets the property runtimeVersionArn. <p>The ARN of the runtime version you want the function to use.</p>")
  runtimeVersionArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of SnapStartResponse")
model SnapStartResponse {
  @doc("Gets and sets the property applyOn. <p>When set to <code>PublishedVersions</code>, Lambda creates a snapshot of the execution environment when you publish a function version.</p>")
  applyOn?: SnapStartApplyOnEnumValue;

  @doc("Gets and sets the property optimizationStatus. <p>When you provide a <a href='https://docs.aws.amazon.com/lambda/latest/dg/configuration-versions.html#versioning-versions-using'>qualified Amazon Resource Name (ARN)</a>, this response element indicates whether SnapStart is activated for the specified function version.</p>")
  optimizationStatus?: SnapStartOptimizationStatusEnumValue;
}

@doc("SnapStartApplyOn enum")
enum SnapStartApplyOn {
  @doc("SnapStartApplyOn enum None")
  None: "None",

  @doc("SnapStartApplyOn enum PublishedVersions")
  Publishedversions: "PublishedVersions",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of SnapStartApplyOnEnumValue")
model SnapStartApplyOnEnumValue {
  @doc("Gets and sets the property value. ")
  value?: SnapStartApplyOn;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of TracingConfigResponse")
model TracingConfigResponse {
  @doc("Gets and sets the property mode. <p>The tracing mode.</p>")
  mode?: TracingModeEnumValue;
}

@doc("SnapStartOptimizationStatus enum")
enum SnapStartOptimizationStatus {
  @doc("SnapStartOptimizationStatus enum Off")
  Off: "Off",

  @doc("SnapStartOptimizationStatus enum On")
  On: "On",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of SnapStartOptimizationStatusEnumValue")
model SnapStartOptimizationStatusEnumValue {
  @doc("Gets and sets the property value. ")
  value?: SnapStartOptimizationStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of VpcConfigResponse")
model VpcConfigResponse {
  @doc("Gets and sets the property securityGroupIds. <p>A list of VPC security group IDs.</p>")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Gets and sets the property subnetIds. <p>A list of VPC subnet IDs.</p>")
  @extension("x-ms-identifiers", [])
  subnetIds?: string[];

  @doc("Gets and sets the property vpcId. <p>The ID of the VPC.</p>")
  vpcId?: string;
}

@doc("TracingMode enum")
enum TracingMode {
  @doc("TracingMode enum Active")
  Active: "Active",

  @doc("TracingMode enum PassThrough")
  Passthrough: "PassThrough",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of TracingModeEnumValue")
model TracingModeEnumValue {
  @doc("Gets and sets the property value. ")
  value?: TracingMode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of EnvironmentError")
model EnvironmentError {
  @doc("Gets and sets the property errorCode. <p>The error code.</p>")
  errorCode?: string;

  @doc("Gets and sets the property message. <p>The error message.</p>")
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of ImageConfigError")
model ImageConfigError {
  @doc("Gets and sets the property errorCode. <p>Error code.</p>")
  errorCode?: string;

  @doc("Gets and sets the property message. <p>Error message.</p>")
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of ImageConfig")
model ImageConfig {
  @doc("Gets and sets the property command. <p>Specifies parameters that you want to pass in with ENTRYPOINT.</p>")
  @extension("x-ms-identifiers", [])
  command?: string[];

  @doc("Gets and sets the property entryPoint. <p>Specifies the entry point to their application, which is typically the location of the runtime executable.</p>")
  @extension("x-ms-identifiers", [])
  entryPoint?: string[];

  @doc("Gets and sets the property workingDirectory. <p>Specifies the working directory.</p>")
  workingDirectory?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of RuntimeVersionError")
model RuntimeVersionError {
  @doc("Gets and sets the property errorCode. <p>The error code.</p>")
  errorCode?: string;

  @doc("Gets and sets the property message. <p>The error message.</p>")
  message?: string;
}

@armResourceOperations
interface LambdaFunctionConfigurations {
  get is ArmResourceRead<LambdaFunctionConfiguration>;
  @doc("Create a LambdaFunctionConfiguration. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LambdaFunctionConfiguration>;
  update is ArmCustomPatchAsync<
    LambdaFunctionConfiguration,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LambdaFunctionConfiguration>
  >;
  delete is ArmResourceDeleteAsync<LambdaFunctionConfiguration>;
  listByResourceGroup is ArmResourceListByParent<LambdaFunctionConfiguration>;
  listBySubscription is ArmListBySubscription<LambdaFunctionConfiguration>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2TypeSpec.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\lambda\lambda-2015-03-31.normal.json
// AWS Shape: FunctionConfiguration
//
// Related information for backend service:
// AWS Servcie : Lambda
// SDK Version : 3.7.200.1
//--------------------------------------------------------------------------------------------
