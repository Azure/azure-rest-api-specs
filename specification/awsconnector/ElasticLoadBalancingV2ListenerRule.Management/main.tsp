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

//---------------------------------------------- ElasticLoadBalancingV2ListenerRules ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model ElasticLoadBalancingV2ListenerRule
  is TrackedResource<ElasticLoadBalancingV2ListenerRuleProperties> {
  @doc("Name of ElasticLoadBalancingV2ListenerRule")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticLoadBalancingV2ListenerRules")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ElasticLoadBalancingV2ListenerRule")
model ElasticLoadBalancingV2ListenerRuleProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsElasticLoadBalancingV2ListenerRuleProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsElasticLoadBalancingV2ListenerRule")
model AwsElasticLoadBalancingV2ListenerRuleProperties {
  @doc("Gets and sets the property actions.")
  @extension("x-ms-identifiers", [])
  actions?: Action[];

  @doc("Gets and sets the property conditions.")
  @extension("x-ms-identifiers", [])
  conditions?: RuleCondition[];

  @doc("Gets and sets the property isDefault.")
  isDefault?: boolean;

  @doc("Gets and sets the property listenerArn.")
  listenerArn?: string;

  @doc("Gets and sets the property priority.")
  priority?: int32;

  @doc("Gets and sets the property ruleArn.")
  ruleArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Action")
model Action {
  @doc("Gets and sets the property authenticateCognitoConfig.")
  authenticateCognitoConfig?: AuthenticateCognitoConfig;

  @doc("Gets and sets the property authenticateOidcConfig.")
  authenticateOidcConfig?: AuthenticateOidcConfig;

  @doc("Gets and sets the property fixedResponseConfig.")
  fixedResponseConfig?: FixedResponseConfig;

  @doc("Gets and sets the property forwardConfig.")
  forwardConfig?: ForwardConfig;

  @doc("Gets and sets the property order.")
  order?: int32;

  @doc("Gets and sets the property redirectConfig.")
  redirectConfig?: RedirectConfig;

  @doc("Gets and sets the property targetGroupArn.")
  targetGroupArn?: string;

  @doc("Gets and sets the property type.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RuleCondition")
model RuleCondition {
  @doc("Gets and sets the property field.")
  field?: string;

  @doc("Gets and sets the property hostHeaderConfig.")
  hostHeaderConfig?: HostHeaderConfig;

  @doc("Gets and sets the property httpHeaderConfig.")
  httpHeaderConfig?: HttpHeaderConfig;

  @doc("Gets and sets the property httpRequestMethodConfig.")
  httpRequestMethodConfig?: HttpRequestMethodConfig;

  @doc("Gets and sets the property pathPatternConfig.")
  pathPatternConfig?: PathPatternConfig;

  @doc("Gets and sets the property queryStringConfig.")
  queryStringConfig?: QueryStringConfig;

  @doc("Gets and sets the property sourceIpConfig.")
  sourceIpConfig?: SourceIpConfig;

  @doc("Gets and sets the property values.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of AuthenticateCognitoConfig")
model AuthenticateCognitoConfig {
  @doc("Gets and sets the property authenticationRequestExtraParams.")
  authenticationRequestExtraParams?: Record<string>;

  @doc("Gets and sets the property onUnauthenticatedRequest.")
  onUnauthenticatedRequest?: string;

  @doc("Gets and sets the property scope.")
  scope?: string;

  @doc("Gets and sets the property sessionCookieName.")
  sessionCookieName?: string;

  @doc("Gets and sets the property sessionTimeout.")
  sessionTimeout?: int32;

  @doc("Gets and sets the property userPoolArn.")
  userPoolArn?: string;

  @doc("Gets and sets the property userPoolClientId.")
  userPoolClientId?: string;

  @doc("Gets and sets the property userPoolDomain.")
  userPoolDomain?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of AuthenticateOidcConfig")
model AuthenticateOidcConfig {
  @doc("Gets and sets the property authenticationRequestExtraParams.")
  authenticationRequestExtraParams?: Record<string>;

  @doc("Gets and sets the property authorizationEndpoint.")
  authorizationEndpoint?: string;

  @doc("Gets and sets the property clientId.")
  clientId?: string;

  @doc("Gets and sets the property clientSecret.")
  clientSecret?: string;

  @doc("Gets and sets the property issuer.")
  issuer?: string;

  @doc("Gets and sets the property onUnauthenticatedRequest.")
  onUnauthenticatedRequest?: string;

  @doc("Gets and sets the property scope.")
  scope?: string;

  @doc("Gets and sets the property sessionCookieName.")
  sessionCookieName?: string;

  @doc("Gets and sets the property sessionTimeout.")
  sessionTimeout?: int32;

  @doc("Gets and sets the property tokenEndpoint.")
  tokenEndpoint?: string;

  @doc("Gets and sets the property useExistingClientSecret.")
  useExistingClientSecret?: boolean;

  @doc("Gets and sets the property userInfoEndpoint.")
  userInfoEndpoint?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of FixedResponseConfig")
model FixedResponseConfig {
  @doc("Gets and sets the property contentType.")
  contentType?: string;

  @doc("Gets and sets the property messageBody.")
  messageBody?: string;

  @doc("Gets and sets the property statusCode.")
  statusCode?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ForwardConfig")
model ForwardConfig {
  @doc("Gets and sets the property targetGroupStickinessConfig.")
  targetGroupStickinessConfig?: TargetGroupStickinessConfig;

  @doc("Gets and sets the property targetGroups.")
  @extension("x-ms-identifiers", [])
  targetGroups?: TargetGroupTuple[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RedirectConfig")
model RedirectConfig {
  @doc("Gets and sets the property host.")
  host?: string;

  @doc("Gets and sets the property path.")
  path?: string;

  @doc("Gets and sets the property port.")
  port?: string;

  @doc("Gets and sets the property protocol.")
  protocol?: string;

  @doc("Gets and sets the property query.")
  query?: string;

  @doc("Gets and sets the property statusCode.")
  statusCode?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of HostHeaderConfig")
model HostHeaderConfig {
  @doc("Gets and sets the property values.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of HttpHeaderConfig")
model HttpHeaderConfig {
  @doc("Gets and sets the property httpHeaderName.")
  httpHeaderName?: string;

  @doc("Gets and sets the property values.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of HttpRequestMethodConfig")
model HttpRequestMethodConfig {
  @doc("Gets and sets the property values.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of PathPatternConfig")
model PathPatternConfig {
  @doc("Gets and sets the property values.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of QueryStringConfig")
model QueryStringConfig {
  @doc("Gets and sets the property values.")
  @extension("x-ms-identifiers", [])
  values?: QueryStringKeyValue[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of SourceIpConfig")
model SourceIpConfig {
  @doc("Gets and sets the property values.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of TargetGroupStickinessConfig")
model TargetGroupStickinessConfig {
  @doc("Gets and sets the property durationSeconds.")
  durationSeconds?: int32;

  @doc("Gets and sets the property enabled.")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of TargetGroupTuple")
model TargetGroupTuple {
  @doc("Gets and sets the property targetGroupArn.")
  targetGroupArn?: string;

  @doc("Gets and sets the property weight.")
  weight?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of QueryStringKeyValue")
model QueryStringKeyValue {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticLoadBalancingV2ListenerRules {
  get is ArmResourceRead<ElasticLoadBalancingV2ListenerRule>;
  @doc("Create a ElasticLoadBalancingV2ListenerRule. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticLoadBalancingV2ListenerRule>;
  update is ArmCustomPatchAsync<
    ElasticLoadBalancingV2ListenerRule,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticLoadBalancingV2ListenerRule>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticLoadBalancingV2ListenerRule>;
  listByResourceGroup is ArmResourceListByParent<ElasticLoadBalancingV2ListenerRule>;
  listBySubscription is ArmListBySubscription<ElasticLoadBalancingV2ListenerRule>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ElasticLoadBalancingV2::ListenerRule
//--------------------------------------------------------------------------------------------
