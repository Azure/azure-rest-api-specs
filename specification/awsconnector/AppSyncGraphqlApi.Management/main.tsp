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

//---------------------------------------------- AppSyncGraphqlApis ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "App Sync Graphql Api",
    plural: "App Sync Graphql Apis",
  },
  keywords: ["Microsoft.AwsConnector", "App", "Sync", "Graphql", "Api"],
})
@doc("A Microsoft.AwsConnector resource")
model AppSyncGraphqlApi is TrackedResource<AppSyncGraphqlApiProperties> {
  @doc("Name of AppSyncGraphqlApi")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("appSyncGraphqlApis")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AppSyncGraphqlApi")
model AppSyncGraphqlApiProperties {
  @doc("AWS Properties")
  awsProperties?: AwsAppSyncGraphqlApiProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsAppSyncGraphqlApi")
model AwsAppSyncGraphqlApiProperties {
  @doc("<p>A list of additional authentication providers for the <code>GraphqlApi</code> API.</p>")
  @extension("x-ms-identifiers", [])
  additionalAuthenticationProviders?: AdditionalAuthenticationProvider[];

  @doc("<p>The API ID.</p>")
  apiId?: string;

  @doc("<p>The value that indicates whether the GraphQL API is a standard API (<code>GRAPHQL</code>) or merged API (<code>MERGED</code>).</p>")
  apiType?: GraphQLApiTypeEnumValue;

  @doc("<p>The Amazon Resource Name (ARN).</p>")
  arn?: string;

  @doc("<p>The authentication type.</p>")
  authenticationType?: AuthenticationTypeEnumValue;

  @doc("<p>The DNS records for the API.</p>")
  dns?: Record<string>;

  @doc("<p>The <code>enhancedMetricsConfig</code> object.</p>")
  enhancedMetricsConfig?: EnhancedMetricsConfig;

  @doc("<p>Sets the value of the GraphQL API to enable (<code>ENABLED</code>) or disable (<code>DISABLED</code>) introspection. If no value is provided, the introspection configuration will be set to <code>ENABLED</code> by default. This field will produce an error if the operation attempts to use the introspection feature while this field is disabled.</p> <p>For more information about introspection, see <a href='https://graphql.org/learn/introspection/'>GraphQL introspection</a>.</p>")
  introspectionConfig?: GraphQLApiIntrospectionConfigEnumValue;

  @doc("<p>Configuration for Lambda function authorization.</p>")
  lambdaAuthorizerConfig?: LambdaAuthorizerConfig;

  @doc("<p>The Amazon CloudWatch Logs configuration.</p>")
  logConfig?: LogConfig;

  @doc("<p>The Identity and Access Management service role ARN for a merged API. The AppSync service assumes this role on behalf of the Merged API to validate access to source APIs at runtime and to prompt the <code>AUTO_MERGE</code> to update the merged API endpoint with the source API changes automatically.</p>")
  mergedApiExecutionRoleArn?: string;

  @doc("<p>The API name.</p>")
  name?: string;

  @doc("<p>The OpenID Connect configuration.</p>")
  openIDConnectConfig?: OpenIDConnectConfig;

  @doc("<p>The account owner of the GraphQL API.</p>")
  owner?: string;

  @doc("<p>The owner contact information for an API resource.</p> <p>This field accepts any string input with a length of 0 - 256 characters.</p>")
  ownerContact?: string;

  @doc("<p>The maximum depth a query can have in a single request. Depth refers to the amount of nested levels allowed in the body of query. The default value is <code>0</code> (or unspecified), which indicates there's no depth limit. If you set a limit, it can be between <code>1</code> and <code>75</code> nested levels. This field will produce a limit error if the operation falls out of bounds.</p> <p>Note that fields can still be set to nullable or non-nullable. If a non-nullable field produces an error, the error will be thrown upwards to the first nullable field available.</p>")
  queryDepthLimit?: int32;

  @doc("<p>The maximum number of resolvers that can be invoked in a single request. The default value is <code>0</code> (or unspecified), which will set the limit to <code>10000</code>. When specified, the limit value can be between <code>1</code> and <code>10000</code>. This field will produce a limit error if the operation falls out of bounds.</p>")
  resolverCountLimit?: int32;

  @doc("<p>The tags.</p>")
  tags?: Record<string>;

  @doc("<p>The URIs.</p>")
  uris?: Record<string>;

  @doc("<p>The Amazon Cognito user pool configuration.</p>")
  userPoolConfig?: UserPoolConfig;

  @doc("<p>Sets the value of the GraphQL API to public (<code>GLOBAL</code>) or private (<code>PRIVATE</code>). If no value is provided, the visibility will be set to <code>GLOBAL</code> by default. This value cannot be changed once the API has been created.</p>")
  visibility?: GraphQLApiVisibilityEnumValue;

  @doc("<p>The ARN of the WAF access control list (ACL) associated with this <code>GraphqlApi</code>, if one exists.</p>")
  wafWebAclArn?: string;

  @doc("<p>A flag indicating whether to use X-Ray tracing for this <code>GraphqlApi</code>.</p>")
  xrayEnabled?: boolean;
}

@doc("GraphQLApiType enum")
union GraphQLApiType {
  @doc("GraphQLApiType enum GRAPHQL")
  GRAPHQL: "GRAPHQL",

  @doc("GraphQLApiType enum MERGED")
  MERGED: "MERGED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GraphQLApiTypeEnumValue")
model GraphQLApiTypeEnumValue {
  @doc("Property value")
  value?: GraphQLApiType;
}

@doc("GraphQLApiIntrospectionConfig enum")
union GraphQLApiIntrospectionConfig {
  @doc("GraphQLApiIntrospectionConfig enum DISABLED")
  DISABLED: "DISABLED",

  @doc("GraphQLApiIntrospectionConfig enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GraphQLApiIntrospectionConfigEnumValue")
model GraphQLApiIntrospectionConfigEnumValue {
  @doc("Property value")
  value?: GraphQLApiIntrospectionConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AdditionalAuthenticationProvider")
model AdditionalAuthenticationProvider {
  @doc("<p>The authentication type: API key, Identity and Access Management (IAM), OpenID Connect (OIDC), Amazon Cognito user pools, or Lambda.</p>")
  authenticationType?: AuthenticationTypeEnumValue;

  @doc("<p>Configuration for Lambda function authorization.</p>")
  lambdaAuthorizerConfig?: LambdaAuthorizerConfig;

  @doc("<p>The OIDC configuration.</p>")
  openIDConnectConfig?: OpenIDConnectConfig;

  @doc("<p>The Amazon Cognito user pool configuration.</p>")
  userPoolConfig?: CognitoUserPoolConfig;
}

@doc("AuthenticationType enum")
union AuthenticationType {
  @doc("AuthenticationType enum AMAZON_COGNITO_USER_POOLS")
  AMAZON_COGNITO_USER_POOLS: "AMAZON_COGNITO_USER_POOLS",

  @doc("AuthenticationType enum API_KEY")
  API_KEY: "API_KEY",

  @doc("AuthenticationType enum AWS_IAM")
  AWS_IAM: "AWS_IAM",

  @doc("AuthenticationType enum AWS_LAMBDA")
  AWS_LAMBDA: "AWS_LAMBDA",

  @doc("AuthenticationType enum OPENID_CONNECT")
  OPENID_CONNECT: "OPENID_CONNECT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AuthenticationTypeEnumValue")
model AuthenticationTypeEnumValue {
  @doc("Property value")
  value?: AuthenticationType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnhancedMetricsConfig")
model EnhancedMetricsConfig {
  @doc("<p>Controls how data source metrics will be emitted to CloudWatch. Data source metrics include:</p> <ul> <li> <p>Requests: The number of invocations that occured during a request.</p> </li> <li> <p>Latency: The time to complete a data source invocation.</p> </li> <li> <p>Errors: The number of errors that occurred during a data source invocation.</p> </li> </ul> <p>These metrics can be emitted to CloudWatch per data source or for all data sources in the request. Metrics will be recorded by API ID and data source name. <code>dataSourceLevelMetricsBehavior</code> accepts one of these values at a time:</p> <ul> <li> <p> <code>FULL_REQUEST_DATA_SOURCE_METRICS</code>: Records and emits metric data for all data sources in the request.</p> </li> <li> <p> <code>PER_DATA_SOURCE_METRICS</code>: Records and emits metric data for data sources that have the <code>metricsConfig</code> value set to <code>ENABLED</code>.</p> </li> </ul>")
  dataSourceLevelMetricsBehavior?: DataSourceLevelMetricsBehaviorEnumValue;

  @doc("<p> Controls how operation metrics will be emitted to CloudWatch. Operation metrics include:</p> <ul> <li> <p>Requests: The number of times a specified GraphQL operation was called.</p> </li> <li> <p>GraphQL errors: The number of GraphQL errors that occurred during a specified GraphQL operation.</p> </li> </ul> <p>Metrics will be recorded by API ID and operation name. You can set the value to <code>ENABLED</code> or <code>DISABLED</code>.</p>")
  operationLevelMetricsConfig?: OperationLevelMetricsConfigEnumValue;

  @doc("<p>Controls how resolver metrics will be emitted to CloudWatch. Resolver metrics include:</p> <ul> <li> <p>GraphQL errors: The number of GraphQL errors that occurred.</p> </li> <li> <p>Requests: The number of invocations that occurred during a request. </p> </li> <li> <p>Latency: The time to complete a resolver invocation.</p> </li> <li> <p>Cache hits: The number of cache hits during a request.</p> </li> <li> <p>Cache misses: The number of cache misses during a request.</p> </li> </ul> <p>These metrics can be emitted to CloudWatch per resolver or for all resolvers in the request. Metrics will be recorded by API ID and resolver name. <code>resolverLevelMetricsBehavior</code> accepts one of these values at a time:</p> <ul> <li> <p> <code>FULL_REQUEST_RESOLVER_METRICS</code>: Records and emits metric data for all resolvers in the request.</p> </li> <li> <p> <code>PER_RESOLVER_METRICS</code>: Records and emits metric data for resolvers that have the <code>metricsConfig</code> value set to <code>ENABLED</code>.</p> </li> </ul>")
  resolverLevelMetricsBehavior?: ResolverLevelMetricsBehaviorEnumValue;
}

@doc("GraphQLApiVisibility enum")
union GraphQLApiVisibility {
  @doc("GraphQLApiVisibility enum GLOBAL")
  GLOBAL: "GLOBAL",

  @doc("GraphQLApiVisibility enum PRIVATE")
  PRIVATE: "PRIVATE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GraphQLApiVisibilityEnumValue")
model GraphQLApiVisibilityEnumValue {
  @doc("Property value")
  value?: GraphQLApiVisibility;
}

@doc("OperationLevelMetricsConfig enum")
union OperationLevelMetricsConfig {
  @doc("OperationLevelMetricsConfig enum DISABLED")
  DISABLED: "DISABLED",

  @doc("OperationLevelMetricsConfig enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OperationLevelMetricsConfigEnumValue")
model OperationLevelMetricsConfigEnumValue {
  @doc("Property value")
  value?: OperationLevelMetricsConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LambdaAuthorizerConfig")
model LambdaAuthorizerConfig {
  @doc("<p>The number of seconds a response should be cached for. The default is 0 seconds, which disables caching. If you don't specify a value for <code>authorizerResultTtlInSeconds</code>, the default value is used. The maximum value is one hour (3600 seconds). The Lambda function can override this by returning a <code>ttlOverride</code> key in its response.</p>")
  authorizerResultTtlInSeconds?: int32;

  @doc("<p>The Amazon Resource Name (ARN) of the Lambda function to be called for authorization. This can be a standard Lambda ARN, a version ARN (<code>.../v3</code>), or an alias ARN. </p> <p> <b>Note</b>: This Lambda function must have the following resource-based policy assigned to it. When configuring Lambda authorizers in the console, this is done for you. To use the Command Line Interface (CLI), run the following:</p> <p> <code>aws lambda add-permission --function-name 'arn:aws:lambda:us-east-2:111122223333:function:my-function' --statement-id 'appsync' --principal appsync.amazonaws.com --action lambda:InvokeFunction</code> </p>")
  authorizerUri?: string;

  @doc("<p>A regular expression for validation of tokens before the Lambda function is called.</p>")
  identityValidationExpression?: string;
}

@doc("DataSourceLevelMetricsBehavior enum")
union DataSourceLevelMetricsBehavior {
  @doc("DataSourceLevelMetricsBehavior enum FULL_REQUEST_DATA_SOURCE_METRICS")
  FULL_REQUEST_DATA_SOURCE_METRICS: "FULL_REQUEST_DATA_SOURCE_METRICS",

  @doc("DataSourceLevelMetricsBehavior enum PER_DATA_SOURCE_METRICS")
  PER_DATA_SOURCE_METRICS: "PER_DATA_SOURCE_METRICS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DataSourceLevelMetricsBehaviorEnumValue")
model DataSourceLevelMetricsBehaviorEnumValue {
  @doc("Property value")
  value?: DataSourceLevelMetricsBehavior;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogConfig")
model LogConfig {
  @doc("<p>The service role that AppSync assumes to publish to CloudWatch logs in your account.</p>")
  cloudWatchLogsRoleArn?: string;

  @doc("<p>Set to TRUE to exclude sections that contain information such as headers, context, and evaluated mapping templates, regardless of logging level.</p>")
  excludeVerboseContent?: boolean;

  @doc("<p>The field logging level. Values can be NONE, ERROR, or ALL.</p> <ul> <li> <p> <b>NONE</b>: No field-level logs are captured.</p> </li> <li> <p> <b>ERROR</b>: Logs the following information only for the fields that are in error:</p> <ul> <li> <p>The error section in the server response.</p> </li> <li> <p>Field-level errors.</p> </li> <li> <p>The generated request/response functions that got resolved for error fields.</p> </li> </ul> </li> <li> <p> <b>ALL</b>: The following information is logged for all fields in the query:</p> <ul> <li> <p>Field-level tracing information.</p> </li> <li> <p>The generated request/response functions that got resolved for each field.</p> </li> </ul> </li> </ul>")
  fieldLogLevel?: FieldLogLevelEnumValue;
}

@doc("ResolverLevelMetricsBehavior enum")
union ResolverLevelMetricsBehavior {
  @doc("ResolverLevelMetricsBehavior enum FULL_REQUEST_RESOLVER_METRICS")
  FULL_REQUEST_RESOLVER_METRICS: "FULL_REQUEST_RESOLVER_METRICS",

  @doc("ResolverLevelMetricsBehavior enum PER_RESOLVER_METRICS")
  PER_RESOLVER_METRICS: "PER_RESOLVER_METRICS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResolverLevelMetricsBehaviorEnumValue")
model ResolverLevelMetricsBehaviorEnumValue {
  @doc("Property value")
  value?: ResolverLevelMetricsBehavior;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenIDConnectConfig")
model OpenIDConnectConfig {
  @doc("<p>The number of milliseconds that a token is valid after being authenticated.</p>")
  authTTL?: int64;

  @doc("<p>The client identifier of the relying party at the OpenID identity provider. This identifier is typically obtained when the relying party is registered with the OpenID identity provider. You can specify a regular expression so that AppSync can validate against multiple client identifiers at a time.</p>")
  clientId?: string;

  @doc("<p>The number of milliseconds that a token is valid after it's issued to a user.</p>")
  iatTTL?: int64;

  @doc("<p>The issuer for the OIDC configuration. The issuer returned by discovery must exactly match the value of <code>iss</code> in the ID token.</p>")
  issuer?: string;
}

@doc("FieldLogLevel enum")
union FieldLogLevel {
  @doc("FieldLogLevel enum ALL")
  ALL: "ALL",

  @doc("FieldLogLevel enum ERROR")
  ERROR: "ERROR",

  @doc("FieldLogLevel enum NONE")
  NONE: "NONE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FieldLogLevelEnumValue")
model FieldLogLevelEnumValue {
  @doc("Property value")
  value?: FieldLogLevel;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of UserPoolConfig")
model UserPoolConfig {
  @doc("<p>A regular expression for validating the incoming Amazon Cognito user pool app client ID. If this value isn't set, no filtering is applied.</p>")
  appIdClientRegex?: string;

  @doc("<p>The Amazon Web Services Region in which the user pool was created.</p>")
  awsRegion?: string;

  @doc("<p>The action that you want your GraphQL API to take when a request that uses Amazon Cognito user pool authentication doesn't match the Amazon Cognito user pool configuration.</p>")
  defaultAction?: DefaultActionEnumValue;

  @doc("<p>The user pool ID.</p>")
  userPoolId?: string;
}

@doc("DefaultAction enum")
union DefaultAction {
  @doc("DefaultAction enum ALLOW")
  ALLOW: "ALLOW",

  @doc("DefaultAction enum DENY")
  DENY: "DENY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DefaultActionEnumValue")
model DefaultActionEnumValue {
  @doc("Property value")
  value?: DefaultAction;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CognitoUserPoolConfig")
model CognitoUserPoolConfig {
  @doc("<p>A regular expression for validating the incoming Amazon Cognito user pool app client ID. If this value isn't set, no filtering is applied.</p>")
  appIdClientRegex?: string;

  @doc("<p>The Amazon Web Services Region in which the user pool was created.</p>")
  awsRegion?: string;

  @doc("<p>The user pool ID.</p>")
  userPoolId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface AppSyncGraphqlApis {
  get is ArmResourceRead<AppSyncGraphqlApi>;
  @doc("Create a AppSyncGraphqlApi. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<AppSyncGraphqlApi>;
  update is ArmCustomPatchAsync<
    AppSyncGraphqlApi,
    Azure.ResourceManager.Foundations.TagsUpdateModel<AppSyncGraphqlApi>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AppSyncGraphqlApi>;
  listByResourceGroup is ArmResourceListByParent<AppSyncGraphqlApi>;
  listBySubscription is ArmListBySubscription<AppSyncGraphqlApi>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\appsync\appsync-2017-07-25.normal.json
// AWS Shape: GraphqlApi
//
// Related information for backend service:
// AWS Servcie : AppSync
// Product Version : 3.7.798.0
// SDK Version : 3.7.305.1
//--------------------------------------------------------------------------------------------
