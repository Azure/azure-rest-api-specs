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

//---------------------------------------------- ApiGatewayRestApis ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Api Gateway Rest Api",
    plural: "Api Gateway Rest Apis",
  },
  keywords: ["Microsoft.AwsConnector", "Api", "Gateway", "Rest", "Api"],
})
@doc("A Microsoft.AwsConnector resource")
model ApiGatewayRestApi is TrackedResource<ApiGatewayRestApiProperties> {
  @doc("Name of ApiGatewayRestApi")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("apiGatewayRestApis")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ApiGatewayRestApi")
model ApiGatewayRestApiProperties {
  @doc("AWS Properties")
  awsProperties?: AwsApiGatewayRestApiProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsApiGatewayRestApi")
model AwsApiGatewayRestApiProperties {
  @doc("The source of the API key for metering requests according to a usage plan. Valid values are: ``HEADER`` to read the API key from the ``X-API-Key`` header of a request. ``AUTHORIZER`` to read the API key from the ``UsageIdentifierKey`` from a custom authorizer.")
  apiKeySourceType?: string;

  @doc("The list of binary media types supported by the RestApi. By default, the RestApi supports only UTF-8-encoded text payloads.")
  @extension("x-ms-identifiers", [])
  binaryMediaTypes?: string[];

  @doc("An OpenAPI specification that defines a set of RESTful APIs in JSON format. For YAML templates, you can also provide the specification in YAML format.")
  body?: Record<unknown>;

  @doc("The Amazon Simple Storage Service (Amazon S3) location that points to an OpenAPI file, which defines a set of RESTful APIs in JSON or YAML format. ``S3Location`` is a property of the [AWS::ApiGateway::RestApi](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-restapi.html) resource that specifies the Amazon S3 location of a OpenAPI (formerly Swagger) file that defines a set of RESTful APIs in JSON or YAML. On January 1, 2016, the Swagger Specification was donated to the [OpenAPI initiative](https://docs.aws.amazon.com/https://www.openapis.org/), becoming the foundation of the OpenAPI Specification.")
  bodyS3Location?: S3Location;

  @doc("The ID of the RestApi that you want to clone from.")
  cloneFrom?: string;

  @doc("The description of the RestApi.")
  description?: string;

  @doc("Specifies whether clients can invoke your API by using the default ``execute-api`` endpoint. By default, clients can invoke your API with the default ``https://{api_id}.execute-api.{region}.amazonaws.com`` endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint")
  disableExecuteApiEndpoint?: boolean;

  @doc("A list of the endpoint types of the API. Use this property when creating an API. When importing an existing API, specify the endpoint configuration types using the ``Parameters`` property. The ``EndpointConfiguration`` property type specifies the endpoint types of a REST API. ``EndpointConfiguration`` is a property of the [AWS::ApiGateway::RestApi](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-restapi.html) resource.")
  endpointConfiguration?: EndpointConfiguration;

  @doc("A query parameter to indicate whether to rollback the API update (``true``) or not (``false``) when a warning is encountered. The default value is ``false``.")
  failOnWarnings?: boolean;

  @doc("A nullable integer that is used to enable compression (with non-negative between 0 and 10485760 (10M) bytes, inclusive) or disable compression (with a null value) on an API. When compression is enabled, compression or decompression is not applied on the payload if the payload size is smaller than this value. Setting it to zero allows compression for any payload size.")
  minimumCompressionSize?: int32;

  @doc("This property applies only when you use OpenAPI to define your REST API. The ``Mode`` determines how API Gateway handles resource updates. Valid values are ``overwrite`` or ``merge``.  For ``overwrite``, the new API definition replaces the existing one. The existing API identifier remains unchanged.  For ``merge``, the new API definition is merged with the existing API. If you don't specify this property, a default value is chosen. For REST APIs created before March 29, 2021, the default is ``overwrite``. For REST APIs created after March 29, 2021, the new API definition takes precedence, but any container types such as endpoint configurations and binary media types are merged with the existing API.  Use the default mode to define top-level ``RestApi`` properties in addition to using OpenAPI. Generally, it's preferred to use API Gateway's OpenAPI extensions to model these properties.")
  mode?: string;

  @doc("The name of the RestApi. A name is required if the REST API is not based on an OpenAPI specification.")
  name?: string;

  @doc("Custom header parameters as part of the request. For example, to exclude DocumentationParts from an imported API, set ``ignore=documentation`` as a ``parameters`` value, as in the AWS CLI command of ``aws apigateway import-rest-api --parameters ignore=documentation --body 'file:///path/to/imported-api-body.json'``.")
  parameters?: Record<string>;

  @doc("A policy document that contains the permissions for the ``RestApi`` resource. To set the ARN for the policy, use the ``!Join`` intrinsic function with ``''`` as delimiter and values of ``'execute-api:/'`` and ``'*'``.")
  policy?: string;

  @doc("Property restApiId")
  restApiId?: string;

  @doc("Property rootResourceId")
  rootResourceId?: string;

  @doc("The key-value map of strings. The valid character set is [a-zA-Z+-=._:/]. The tag key can be up to 128 characters and must not start with ``aws:``. The tag value can be up to 256 characters.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3Location")
model S3Location {
  @doc("The name of the S3 bucket where the OpenAPI file is stored.")
  bucket?: string;

  @doc("The Amazon S3 ETag (a file checksum) of the OpenAPI file. If you don't specify a value, API Gateway skips ETag validation of your OpenAPI file.")
  eTag?: string;

  @doc("The file name of the OpenAPI file (Amazon S3 object name).")
  key?: string;

  @doc("For versioning-enabled buckets, a specific version of the OpenAPI file.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EndpointConfiguration")
model EndpointConfiguration {
  @doc("A list of endpoint types of an API (RestApi) or its custom domain name (DomainName). For an edge-optimized API and its custom domain name, the endpoint type is ``'EDGE'``. For a regional API and its custom domain name, the endpoint type is ``REGIONAL``. For a private API, the endpoint type is ``PRIVATE``.")
  @extension("x-ms-identifiers", [])
  types?: string[];

  @doc("A list of VpcEndpointIds of an API (RestApi) against which to create Route53 ALIASes. It is only supported for ``PRIVATE`` endpoint type.")
  @extension("x-ms-identifiers", [])
  vpcEndpointIds?: string[];
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ApiGatewayRestApis {
  get is ArmResourceRead<ApiGatewayRestApi>;
  @doc("Create a ApiGatewayRestApi. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ApiGatewayRestApi>;
  update is ArmCustomPatchAsync<
    ApiGatewayRestApi,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ApiGatewayRestApi>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ApiGatewayRestApi>;
  listByResourceGroup is ArmResourceListByParent<ApiGatewayRestApi>;
  listBySubscription is ArmListBySubscription<ApiGatewayRestApi>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ApiGateway::RestApi
//--------------------------------------------------------------------------------------------
