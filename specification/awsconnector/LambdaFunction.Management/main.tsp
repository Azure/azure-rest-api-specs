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
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LambdaFunction")
model LambdaFunctionProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLambdaFunctionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLambdaFunction")
model AwsLambdaFunctionProperties {
  @doc("Gets and sets the property architectures. The instruction set architecture that the function supports. Enter a string array with one of the valid values (arm64 or x86_64). The default value is ``x86_64``.")
  @extension("x-ms-identifiers", [])
  architectures?: Architectures[];

  @doc("Gets and sets the property arn.")
  arn?: string;

  @doc("Gets and sets the property code. The code for the function. The [deployment package](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html) for a Lambda function. To deploy a function defined as a container image, you specify the location of a container image in the Amazon ECR registry. For a .zip file deployment package, you can specify the location of an object in Amazon S3. For Node.js and Python functions, you can specify the function code inline in the template. Changes to a deployment package in Amazon S3 or a container image in ECR are not detected automatically during stack updates. To update the function code, change the object key or version in the template.")
  code?: Code;

  @doc("Gets and sets the property codeSigningConfigArn. To enable code signing for this function, specify the ARN of a code-signing configuration. A code-signing configuration includes a set of signing profiles, which define the trusted publishers for this function.")
  codeSigningConfigArn?: string;

  @doc("Gets and sets the property deadLetterConfig. A dead-letter queue configuration that specifies the queue or topic where Lambda sends asynchronous events when they fail processing. For more information, see [Dead-letter queues](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-dlq). The [dead-letter queue](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#dlq) for failed asynchronous invocations.")
  deadLetterConfig?: DeadLetterConfig;

  @doc("Gets and sets the property description. A description of the function.")
  description?: string;

  @doc("Gets and sets the property environment. Environment variables that are accessible from function code during execution. A function's environment variable settings. You can use environment variables to adjust your function's behavior without updating code. An environment variable is a pair of strings that are stored in a function's version-specific configuration.")
  environment?: Environment;

  @doc("Gets and sets the property ephemeralStorage. The size of the function's ``/tmp`` directory in MB. The default value is 512, but it can be any whole number between 512 and 10,240 MB. The size of the function's ``/tmp`` directory in MB. The default value is 512, but it can be any whole number between 512 and 10,240 MB.")
  ephemeralStorage?: EphemeralStorage;

  @doc("Gets and sets the property fileSystemConfigs. Connection settings for an Amazon EFS file system. To connect a function to a file system, a mount target must be available in every Availability Zone that your function connects to. If your template contains an [AWS::EFS::MountTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-mounttarget.html) resource, you must also specify a ``DependsOn`` attribute to ensure that the mount target is created or updated before the function. For more information about using the ``DependsOn`` attribute, see [DependsOn Attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-dependson.html).")
  @extension("x-ms-identifiers", [])
  fileSystemConfigs?: FileSystemConfig[];

  @doc("Gets and sets the property functionName. The name of the Lambda function, up to 64 characters in length. If you don't specify a name, CFN generates one. If you specify a name, you cannot perform updates that require replacement of this resource. You can perform updates that require no or some interruption. If you must replace the resource, specify a new name.")
  functionName?: string;

  @doc("Gets and sets the property handler. The name of the method within your code that Lambda calls to run your function. Handler is required if the deployment package is a .zip file archive. The format includes the file name. It can also include namespaces and other qualifiers, depending on the runtime. For more information, see [Lambda programming model](https://docs.aws.amazon.com/lambda/latest/dg/foundation-progmodel.html).")
  handler?: string;

  @doc("Gets and sets the property imageConfig. Configuration values that override the container image Dockerfile settings. For more information, see [Container image settings](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-parms). Configuration values that override the container image Dockerfile settings. For more information, see [Container image settings](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-parms).")
  imageConfig?: ImageConfig;

  @doc("Gets and sets the property kmsKeyArn. The ARN of the KMSlong (KMS) customer managed key that's used to encrypt your function's [environment variables](https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html#configuration-envvars-encryption). When [Lambda SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart-security.html) is activated, Lambda also uses this key is to encrypt your function's snapshot. If you deploy your function using a container image, Lambda also uses this key to encrypt your function when it's deployed. Note that this is not the same key that's used to protect your container image in the Amazon Elastic Container Registry (Amazon ECR). If you don't provide a customer managed key, Lambda uses a default service key.")
  kmsKeyArn?: string;

  @doc("Gets and sets the property layers. A list of [function layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html) to add to the function's execution environment. Specify each layer by its ARN, including the version.")
  @extension("x-ms-identifiers", [])
  layers?: string[];

  @doc("Gets and sets the property loggingConfig. The function's Amazon CloudWatch Logs configuration settings. The function's Amazon CloudWatch Logs configuration settings.")
  loggingConfig?: LoggingConfig;

  @doc("Gets and sets the property memorySize. The amount of [memory available to the function](https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-memory-console) at runtime. Increasing the function memory also increases its CPU allocation. The default value is 128 MB. The value can be any multiple of 1 MB. Note that new AWS accounts have reduced concurrency and memory quotas. AWS raises these quotas automatically based on your usage. You can also request a quota increase.")
  memorySize?: int32;

  @doc("Gets and sets the property packageType. The type of deployment package. Set to ``Image`` for container image and set ``Zip`` for .zip file archive.")
  packageType?: PackageType;

  @doc("Gets and sets the property reservedConcurrentExecutions. The number of simultaneous executions to reserve for the function.")
  reservedConcurrentExecutions?: int32;

  @doc("Gets and sets the property role. The Amazon Resource Name (ARN) of the function's execution role.")
  role?: string;

  @doc("Gets and sets the property runtime. The identifier of the function's [runtime](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html). Runtime is required if the deployment package is a .zip file archive. The following list includes deprecated runtimes. For more information, see [Runtime deprecation policy](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtime-support-policy).")
  runtime?: string;

  @doc("Gets and sets the property runtimeManagementConfig. Sets the runtime management configuration for a function's version. For more information, see [Runtime updates](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-update.html). Sets the runtime management configuration for a function's version. For more information, see [Runtime updates](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-update.html).")
  runtimeManagementConfig?: RuntimeManagementConfig;

  @doc("Gets and sets the property snapStart. The function's [SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html) setting. The function's [SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html) setting.")
  snapStart?: SnapStart;

  @doc("Gets and sets the property snapStartResponse. The function's [SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html) setting.")
  snapStartResponse?: SnapStartResponse;

  @doc("Gets and sets the property tags. A list of [tags](https://docs.aws.amazon.com/lambda/latest/dg/tagging.html) to apply to the function.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property timeout. The amount of time (in seconds) that Lambda allows a function to run before stopping it. The default is 3 seconds. The maximum allowed value is 900 seconds. For more information, see [Lambda execution environment](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-context.html).")
  timeout?: int32;

  @doc("Gets and sets the property tracingConfig. Set ``Mode`` to ``Active`` to sample and trace a subset of incoming requests with [X-Ray](https://docs.aws.amazon.com/lambda/latest/dg/services-xray.html). The function's [](https://docs.aws.amazon.com/lambda/latest/dg/services-xray.html) tracing configuration. To sample and record incoming requests, set ``Mode`` to ``Active``.")
  tracingConfig?: TracingConfig;

  @doc("Gets and sets the property vpcConfig. For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC. When you connect a function to a VPC, it can access resources and the internet only through that VPC. For more information, see [Configuring a Lambda function to access resources in a VPC](https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html). The VPC security groups and subnets that are attached to a Lambda function. When you connect a function to a VPC, Lambda creates an elastic network interface for each combination of security group and subnet in the function's VPC configuration. The function can only access resources and the internet through that VPC. For more information, see [VPC Settings](https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html).  When you delete a function, CFN monitors the state of its network interfaces and waits for Lambda to delete them before proceeding. If the VPC is defined in the same stack, the network interfaces need to be deleted by Lambda before CFN can delete the VPC's resources. To monitor network interfaces, CFN needs the ``ec2:DescribeNetworkInterfaces`` permission. It obtains this from the user or role that modifies the stack. If you don't provide this permission, CFN does not wait for network interfaces to be deleted.")
  vpcConfig?: VpcConfig;
}

@doc("Architectures enum")
union Architectures {
  @doc("Architectures enum arm64")
  arm64: "arm64",

  @doc("Architectures enum x86_64")
  x86_64: "x86_64",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Code")
model Code {
  @doc("Gets and sets the property imageUri. URI of a [container image](https://docs.aws.amazon.com/lambda/latest/dg/lambda-images.html) in the Amazon ECR registry.")
  imageUri?: string;

  @doc("Gets and sets the property s3Bucket. An Amazon S3 bucket in the same AWS-Region as your function. The bucket can be in a different AWS-account.")
  s3Bucket?: string;

  @doc("Gets and sets the property s3Key. The Amazon S3 key of the deployment package.")
  s3Key?: string;

  @doc("Gets and sets the property s3ObjectVersion. For versioned objects, the version of the deployment package object to use.")
  s3ObjectVersion?: string;

  @doc("Gets and sets the property zipFile. (Node.js and Python) The source code of your Lambda function. If you include your function source inline with this parameter, CFN places it in a file named ``index`` and zips it to create a [deployment package](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html). This zip file cannot exceed 4MB. For the ``Handler`` property, the first part of the handler identifier must be ``index``. For example, ``index.handler``.  For JSON, you must escape quotes and special characters such as newline (``\\n``) with a backslash. If you specify a function that interacts with an AWS CloudFormation custom resource, you don't have to write your own functions to send responses to the custom resource that invoked the function. AWS CloudFormation provides a response module ([cfn-response](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-lambda-function-code-cfnresponsemodule.html)) that simplifies sending responses. See [Using Lambda with CloudFormation](https://docs.aws.amazon.com/lambda/latest/dg/services-cloudformation.html) for details.")
  zipFile?: string;
}

@doc("PackageType enum")
union PackageType {
  @doc("PackageType enum Image")
  Image: "Image",

  @doc("PackageType enum Zip")
  Zip: "Zip",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeadLetterConfig")
model DeadLetterConfig {
  @doc("Gets and sets the property targetArn. The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic.")
  targetArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Environment")
model Environment {
  @doc("Gets and sets the property variables. Environment variable key-value pairs. For more information, see [Using Lambda environment variables](https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html).")
  variables?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EphemeralStorage")
model EphemeralStorage {
  @doc("Gets and sets the property size. The size of the function's ``/tmp`` directory.")
  size?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FileSystemConfig")
model FileSystemConfig {
  @doc("Gets and sets the property arn. The Amazon Resource Name (ARN) of the Amazon EFS access point that provides access to the file system.")
  arn?: string;

  @doc("Gets and sets the property localMountPath. The path where the function can access the file system, starting with ``/mnt/``.")
  localMountPath?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageConfig")
model ImageConfig {
  @doc("Gets and sets the property command. Specifies parameters that you want to pass in with ENTRYPOINT. You can specify a maximum of 1,500 parameters in the list.")
  @extension("x-ms-identifiers", [])
  command?: string[];

  @doc("Gets and sets the property entryPoint. Specifies the entry point to their application, which is typically the location of the runtime executable. You can specify a maximum of 1,500 string entries in the list.")
  @extension("x-ms-identifiers", [])
  entryPoint?: string[];

  @doc("Gets and sets the property workingDirectory. Specifies the working directory. The length of the directory string cannot exceed 1,000 characters.")
  workingDirectory?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoggingConfig")
model LoggingConfig {
  @doc("Gets and sets the property applicationLogLevel. Set this property to filter the application logs for your function that Lambda sends to CloudWatch. Lambda only sends application logs at the selected level of detail and lower, where ``TRACE`` is the highest level and ``FATAL`` is the lowest.")
  applicationLogLevel?: LoggingConfigApplicationLogLevel;

  @doc("Gets and sets the property logFormat. The format in which Lambda sends your function's application and system logs to CloudWatch. Select between plain text and structured JSON.")
  logFormat?: LoggingConfigLogFormat;

  @doc("Gets and sets the property logGroup. The name of the Amazon CloudWatch log group the function sends logs to. By default, Lambda functions send logs to a default log group named ``/aws/lambda/<function name>``. To use a different log group, enter an existing log group or enter a new log group name.")
  logGroup?: string;

  @doc("Gets and sets the property systemLogLevel. Set this property to filter the system logs for your function that Lambda sends to CloudWatch. Lambda only sends system logs at the selected level of detail and lower, where ``DEBUG`` is the highest level and ``WARN`` is the lowest.")
  systemLogLevel?: LoggingConfigSystemLogLevel;
}

@doc("LoggingConfigApplicationLogLevel enum")
union LoggingConfigApplicationLogLevel {
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

  string,
}

@doc("LoggingConfigSystemLogLevel enum")
union LoggingConfigSystemLogLevel {
  @doc("LoggingConfigSystemLogLevel enum DEBUG")
  DEBUG: "DEBUG",

  @doc("LoggingConfigSystemLogLevel enum INFO")
  INFO: "INFO",

  @doc("LoggingConfigSystemLogLevel enum WARN")
  WARN: "WARN",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuntimeManagementConfig")
model RuntimeManagementConfig {
  @doc("Gets and sets the property runtimeVersionArn. The ARN of the runtime version you want the function to use.  This is only required if you're using the *Manual* runtime update mode.")
  runtimeVersionArn?: string;

  @doc("Gets and sets the property updateRuntimeOn. Specify the runtime update mode.  +   *Auto (default)* - Automatically update to the most recent and secure runtime version using a [Two-phase runtime version rollout](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-update.html#runtime-management-two-phase). This is the best choice for most customers to ensure they always benefit from runtime updates.  +   *FunctionUpdate* - LAM updates the runtime of you function to the most recent and secure runtime version when you update your function. This approach synchronizes runtime updates with function deployments, giving you control over when runtime updates are applied and allowing you to detect and mitigate rare runtime update incompatibilities early. When using this setting, you need to regularly update your functions to keep their runtime up-to-date.  +   *Manual* - You specify a runtime version in your function configuration. The function will use this runtime version indefinitely. In the rare case where a new runtime version is incompatible with an existing function, this allows you to roll back your function to an earlier runtime version. For more information, see [Roll back a runtime version](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-update.html#runtime-management-rollback).    *Valid Values*: ``Auto`` | ``FunctionUpdate`` | ``Manual``")
  updateRuntimeOn?: RuntimeManagementConfigUpdateRuntimeOn;
}

@doc("LoggingConfigLogFormat enum")
union LoggingConfigLogFormat {
  @doc("LoggingConfigLogFormat enum JSON")
  JSON: "JSON",

  @doc("LoggingConfigLogFormat enum Text")
  Text: "Text",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SnapStart")
model SnapStart {
  @doc("Gets and sets the property applyOn. Set ``ApplyOn`` to ``PublishedVersions`` to create a snapshot of the initialized execution environment when you publish a function version.")
  applyOn?: SnapStartApplyOn;
}

@doc("RuntimeManagementConfigUpdateRuntimeOn enum")
union RuntimeManagementConfigUpdateRuntimeOn {
  @doc("RuntimeManagementConfigUpdateRuntimeOn enum Auto")
  Auto: "Auto",

  @doc("RuntimeManagementConfigUpdateRuntimeOn enum FunctionUpdate")
  FunctionUpdate: "FunctionUpdate",

  @doc("RuntimeManagementConfigUpdateRuntimeOn enum Manual")
  Manual: "Manual",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SnapStartResponse")
model SnapStartResponse {
  @doc("Gets and sets the property applyOn. When set to ``PublishedVersions``, Lambda creates a snapshot of the execution environment when you publish a function version.")
  applyOn?: SnapStartResponseApplyOn;

  @doc("Gets and sets the property optimizationStatus. When you provide a [qualified Amazon Resource Name (ARN)](https://docs.aws.amazon.com/lambda/latest/dg/configuration-versions.html#versioning-versions-using), this response element indicates whether SnapStart is activated for the specified function version.")
  optimizationStatus?: SnapStartResponseOptimizationStatus;
}

@doc("SnapStartApplyOn enum")
union SnapStartApplyOn {
  @doc("SnapStartApplyOn enum None")
  None: "None",

  @doc("SnapStartApplyOn enum PublishedVersions")
  PublishedVersions: "PublishedVersions",

  string,
}

@doc("SnapStartResponseOptimizationStatus enum")
union SnapStartResponseOptimizationStatus {
  @doc("SnapStartResponseOptimizationStatus enum Off")
  Off: "Off",

  @doc("SnapStartResponseOptimizationStatus enum On")
  On: "On",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

@doc("SnapStartResponseApplyOn enum")
union SnapStartResponseApplyOn {
  @doc("SnapStartResponseApplyOn enum None")
  None: "None",

  @doc("SnapStartResponseApplyOn enum PublishedVersions")
  PublishedVersions: "PublishedVersions",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TracingConfig")
model TracingConfig {
  @doc("Gets and sets the property mode. The tracing mode.")
  mode?: TracingConfigMode;
}

@doc("TracingConfigMode enum")
union TracingConfigMode {
  @doc("TracingConfigMode enum Active")
  Active: "Active",

  @doc("TracingConfigMode enum PassThrough")
  PassThrough: "PassThrough",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VpcConfig")
model VpcConfig {
  @doc("Gets and sets the property ipv6AllowedForDualStack. Allows outbound IPv6 traffic on VPC functions that are connected to dual-stack subnets.")
  ipv6AllowedForDualStack?: boolean;

  @doc("Gets and sets the property securityGroupIds. A list of VPC security group IDs.")
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
