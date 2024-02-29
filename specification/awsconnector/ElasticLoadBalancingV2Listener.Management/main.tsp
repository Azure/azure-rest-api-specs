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

//---------------------------------------------- ElasticLoadBalancingV2Listeners ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model ElasticLoadBalancingV2Listener
  is TrackedResource<ElasticLoadBalancingV2ListenerProperties> {
  @doc("Name of ElasticLoadBalancingV2Listener")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticLoadBalancingV2Listeners")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ElasticLoadBalancingV2Listener")
model ElasticLoadBalancingV2ListenerProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsElasticLoadBalancingV2ListenerProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsElasticLoadBalancingV2Listener")
model AwsElasticLoadBalancingV2ListenerProperties {
  @doc("Gets and sets the property alpnPolicy.")
  @extension("x-ms-identifiers", [])
  alpnPolicy?: string[];

  @doc("Gets and sets the property certificates.")
  @extension("x-ms-identifiers", [])
  certificates?: Certificate[];

  @doc("Gets and sets the property defaultActions.")
  @extension("x-ms-identifiers", [])
  defaultActions?: Action[];

  @doc("Gets and sets the property listenerArn.")
  listenerArn?: string;

  @doc("Gets and sets the property loadBalancerArn.")
  loadBalancerArn?: string;

  @doc("Gets and sets the property mutualAuthentication.")
  mutualAuthentication?: MutualAuthentication;

  @doc("Gets and sets the property port.")
  port?: int32;

  @doc("Gets and sets the property protocol.")
  protocol?: string;

  @doc("Gets and sets the property sslPolicy.")
  sslPolicy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Certificate")
model Certificate {
  @doc("Gets and sets the property certificateArn.")
  certificateArn?: string;
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
@doc("Definition of MutualAuthentication")
model MutualAuthentication {
  @doc("Gets and sets the property ignoreClientCertificateExpiry.")
  ignoreClientCertificateExpiry?: boolean;

  @doc("Gets and sets the property mode.")
  mode?: string;

  @doc("Gets and sets the property trustStoreArn.")
  trustStoreArn?: string;
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
  sessionTimeout?: string;

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
  sessionTimeout?: string;

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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticLoadBalancingV2Listeners {
  get is ArmResourceRead<ElasticLoadBalancingV2Listener>;
  @doc("Create a ElasticLoadBalancingV2Listener. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticLoadBalancingV2Listener>;
  update is ArmCustomPatchAsync<
    ElasticLoadBalancingV2Listener,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticLoadBalancingV2Listener>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticLoadBalancingV2Listener>;
  listByResourceGroup is ArmResourceListByParent<ElasticLoadBalancingV2Listener>;
  listBySubscription is ArmListBySubscription<ElasticLoadBalancingV2Listener>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ElasticLoadBalancingV2::Listener
//--------------------------------------------------------------------------------------------
