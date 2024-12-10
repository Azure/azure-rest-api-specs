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

//---------------------------------------------- ApiGatewayStages ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Api Gateway Stage",
    plural: "Api Gateway Stages",
  },
  keywords: ["Microsoft.AwsConnector", "Api", "Gateway", "Stage"],
})
@doc("A Microsoft.AwsConnector resource")
model ApiGatewayStage is TrackedResource<ApiGatewayStageProperties> {
  @doc("Name of ApiGatewayStage")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("apiGatewayStages")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ApiGatewayStage")
model ApiGatewayStageProperties {
  @doc("AWS Properties")
  awsProperties?: AwsApiGatewayStageProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsApiGatewayStage")
model AwsApiGatewayStageProperties {
  @doc("Access log settings, including the access log format and access log destination ARN. The ``AccessLogSetting`` property type specifies settings for logging access in this stage.  ``AccessLogSetting`` is a property of the [AWS::ApiGateway::Stage](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-stage.html) resource.")
  accessLogSetting?: AccessLogSetting;

  @doc("Specifies whether a cache cluster is enabled for the stage.")
  cacheClusterEnabled?: boolean;

  @doc("The stage's cache capacity in GB. For more information about choosing a cache size, see [Enabling API caching to enhance responsiveness](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html).")
  cacheClusterSize?: string;

  @doc("Settings for the canary deployment in this stage. Configuration settings of a canary deployment.")
  canarySetting?: CanarySetting;

  @doc("The identifier of a client certificate for an API stage.")
  clientCertificateId?: string;

  @doc("The identifier of the Deployment that the stage points to.")
  deploymentId?: string;

  @doc("The stage's description.")
  description?: string;

  @doc("The version of the associated API documentation.")
  documentationVersion?: string;

  @doc("A map that defines the method settings for a Stage resource. Keys (designated as ``/{method_setting_key`` below) are method paths defined as ``{resource_path}/{http_method}`` for an individual method override, or ``/\\*/\\*`` for overriding all methods in the stage.")
  @extension("x-ms-identifiers", [])
  methodSettings?: MethodSetting[];

  @doc("The string identifier of the associated RestApi.")
  restApiId?: string;

  @doc("The name of the stage is the first path segment in the Uniform Resource Identifier (URI) of a call to API Gateway. Stage names can only contain alphanumeric characters, hyphens, and underscores. Maximum length is 128 characters.")
  stageName?: string;

  @doc("The collection of tags. Each tag element is associated with a given resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Specifies whether active tracing with X-ray is enabled for the Stage.")
  tracingEnabled?: boolean;

  @doc("A map (string-to-string map) that defines the stage variables, where the variable name is the key and the variable value is the value. Variable names are limited to alphanumeric characters. Values must match the following regular expression: ``[A-Za-z0-9-._~:/?#&=,]+``.")
  variables?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AccessLogSetting")
model AccessLogSetting {
  @doc("The Amazon Resource Name (ARN) of the CloudWatch Logs log group or Kinesis Data Firehose delivery stream to receive access logs. If you specify a Kinesis Data Firehose delivery stream, the stream name must begin with ``amazon-apigateway-``. This parameter is required to enable access logging.")
  destinationArn?: string;

  @doc("A single line format of the access logs of data, as specified by selected [$context variables](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-mapping-template-reference.html#context-variable-reference). The format must include at least ``$context.requestId``. This parameter is required to enable access logging.")
  format?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CanarySetting")
model CanarySetting {
  @doc("The ID of the canary deployment.")
  deploymentId?: string;

  @doc("The percent (0-100) of traffic diverted to a canary deployment.")
  percentTraffic?: int32;

  @doc("Stage variables overridden for a canary release deployment, including new stage variables introduced in the canary. These stage variables are represented as a string-to-string map between stage variable names and their values.")
  stageVariableOverrides?: Record<string>;

  @doc("A Boolean flag to indicate whether the canary deployment uses the stage cache or not.")
  useStageCache?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MethodSetting")
model MethodSetting {
  @doc("Specifies whether the cached responses are encrypted.")
  cacheDataEncrypted?: boolean;

  @doc("Specifies the time to live (TTL), in seconds, for cached responses. The higher the TTL, the longer the response will be cached.")
  cacheTtlInSeconds?: int32;

  @doc("Specifies whether responses should be cached and returned for requests. A cache cluster must be enabled on the stage for responses to be cached.")
  cachingEnabled?: boolean;

  @doc("Specifies whether data trace logging is enabled for this method, which affects the log entries pushed to Amazon CloudWatch Logs. This can be useful to troubleshoot APIs, but can result in logging sensitive data. We recommend that you don't enable this option for production APIs.")
  dataTraceEnabled?: boolean;

  @doc("The HTTP method. To apply settings to multiple resources and methods, specify an asterisk (``*``) for the ``HttpMethod`` and ``/*`` for the ``ResourcePath``. This parameter is required when you specify a ``MethodSetting``.")
  httpMethod?: string;

  @doc("Specifies the logging level for this method, which affects the log entries pushed to Amazon CloudWatch Logs. Valid values are ``OFF``, ``ERROR``, and ``INFO``. Choose ``ERROR`` to write only error-level entries to CloudWatch Logs, or choose ``INFO`` to include all ``ERROR`` events as well as extra informational events.")
  loggingLevel?: string;

  @doc("Specifies whether Amazon CloudWatch metrics are enabled for this method.")
  metricsEnabled?: boolean;

  @doc("The resource path for this method. Forward slashes (``/``) are encoded as ``~1`` and the initial slash must include a forward slash. For example, the path value ``/resource/subresource`` must be encoded as ``/~1resource~1subresource``. To specify the root path, use only a slash (``/``). To apply settings to multiple resources and methods, specify an asterisk (``*``) for the ``HttpMethod`` and ``/*`` for the ``ResourcePath``. This parameter is required when you specify a ``MethodSetting``.")
  resourcePath?: string;

  @doc("Specifies the throttling burst limit.")
  throttlingBurstLimit?: int32;

  @doc("Specifies the throttling rate limit.")
  throttlingRateLimit?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:.")
  key?: string;

  @doc("The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ApiGatewayStages {
  get is ArmResourceRead<ApiGatewayStage>;
  @doc("Create a ApiGatewayStage. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ApiGatewayStage>;
  update is ArmCustomPatchAsync<
    ApiGatewayStage,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ApiGatewayStage>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ApiGatewayStage>;
  listByResourceGroup is ArmResourceListByParent<ApiGatewayStage>;
  listBySubscription is ArmListBySubscription<ApiGatewayStage>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ApiGateway::Stage
//--------------------------------------------------------------------------------------------
