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

//---------------------------------------------- ElasticLoadBalancingV2Listeners ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Elastic Load Balancing V2 Listener",
    plural: "Elastic Load Balancing V2 Listeners",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Elastic",
    "Load",
    "Balancing",
    "V2",
    "Listener"
  ],
})
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticLoadBalancingV2Listener")
model ElasticLoadBalancingV2ListenerProperties {
  @doc("AWS Properties")
  awsProperties?: AwsElasticLoadBalancingV2ListenerProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticLoadBalancingV2Listener")
model AwsElasticLoadBalancingV2ListenerProperties {
  @doc("[TLS listener] The name of the Application-Layer Protocol Negotiation (ALPN) policy.")
  @extension("x-ms-identifiers", [])
  alpnPolicy?: string[];

  @doc("The default SSL server certificate for a secure listener. You must provide exactly one certificate if the listener protocol is HTTPS or TLS. To create a certificate list for a secure listener, use [AWS::ElasticLoadBalancingV2::ListenerCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate.html).")
  @extension("x-ms-identifiers", [])
  certificates?: Certificate[];

  @doc("The actions for the default rule. You cannot define a condition for a default rule. To create additional rules for an Application Load Balancer, use [AWS::ElasticLoadBalancingV2::ListenerRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenerrule.html).")
  @extension("x-ms-identifiers", [])
  defaultActions?: Action[];

  @doc("Property listenerArn")
  listenerArn?: string;

  @doc("The Amazon Resource Name (ARN) of the load balancer.")
  loadBalancerArn?: string;

  @doc("The mutual authentication configuration information. Specifies the configuration information for mutual authentication.")
  mutualAuthentication?: MutualAuthentication;

  @doc("The port on which the load balancer is listening. You cannot specify a port for a Gateway Load Balancer.")
  port?: int32;

  @doc("The protocol for connections from clients to the load balancer. For Application Load Balancers, the supported protocols are HTTP and HTTPS. For Network Load Balancers, the supported protocols are TCP, TLS, UDP, and TCP_UDP. You can’t specify the UDP or TCP_UDP protocol if dual-stack mode is enabled. You cannot specify a protocol for a Gateway Load Balancer.")
  protocol?: string;

  @doc("[HTTPS and TLS listeners] The security policy that defines which protocols and ciphers are supported. Updating the security policy can result in interruptions if the load balancer is handling a high volume of traffic. For more information, see [Security policies](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies) in the *Application Load Balancers Guide* and [Security policies](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/create-tls-listener.html#describe-ssl-policies) in the *Network Load Balancers Guide*.")
  sslPolicy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Certificate")
model Certificate {
  @doc("The Amazon Resource Name (ARN) of the certificate.")
  certificateArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Action")
model Action {
  @doc("[HTTPS listeners] Information for using Amazon Cognito to authenticate users. Specify only when ``Type`` is ``authenticate-cognito``. Specifies information required when integrating with Amazon Cognito to authenticate users.")
  authenticateCognitoConfig?: AuthenticateCognitoConfig;

  @doc("[HTTPS listeners] Information about an identity provider that is compliant with OpenID Connect (OIDC). Specify only when ``Type`` is ``authenticate-oidc``. Specifies information required using an identity provide (IdP) that is compliant with OpenID Connect (OIDC) to authenticate users.")
  authenticateOidcConfig?: AuthenticateOidcConfig;

  @doc("[Application Load Balancer] Information for creating an action that returns a custom HTTP response. Specify only when ``Type`` is ``fixed-response``. Specifies information required when returning a custom HTTP response.")
  fixedResponseConfig?: FixedResponseConfig;

  @doc("Information for creating an action that distributes requests among one or more target groups. For Network Load Balancers, you can specify a single target group. Specify only when ``Type`` is ``forward``. If you specify both ``ForwardConfig`` and ``TargetGroupArn``, you can specify only one target group using ``ForwardConfig`` and it must be the same target group specified in ``TargetGroupArn``. Information for creating an action that distributes requests among one or more target groups. For Network Load Balancers, you can specify a single target group. Specify only when ``Type`` is ``forward``. If you specify both ``ForwardConfig`` and ``TargetGroupArn``, you can specify only one target group using ``ForwardConfig`` and it must be the same target group specified in ``TargetGroupArn``.")
  forwardConfig?: ForwardConfig;

  @doc("The order for the action. This value is required for rules with multiple actions. The action with the lowest value for order is performed first.")
  order?: int32;

  @doc("[Application Load Balancer] Information for creating a redirect action. Specify only when ``Type`` is ``redirect``. Information about a redirect action. A URI consists of the following components: protocol://hostname:port/path?query. You must modify at least one of the following components to avoid a redirect loop: protocol, hostname, port, or path. Any components that you do not modify retain their original values. You can reuse URI components using the following reserved keywords:  +  #{protocol}  +  #{host}  +  #{port}  +  #{path} (the leading '/' is removed)  +  #{query}   For example, you can change the path to '/new/#{path}', the hostname to 'example.#{host}', or the query to '#{query}&value=xyz'.")
  redirectConfig?: RedirectConfig;

  @doc("The Amazon Resource Name (ARN) of the target group. Specify only when ``Type`` is ``forward`` and you want to route to a single target group. To route to one or more target groups, use ``ForwardConfig`` instead.")
  targetGroupArn?: string;

  @doc("The type of action.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MutualAuthentication")
model MutualAuthentication {
  @doc("Indicates whether expired client certificates are ignored.")
  ignoreClientCertificateExpiry?: boolean;

  @doc("The client certificate handling method. Options are ``off``, ``passthrough`` or ``verify``. The default value is ``off``.")
  mode?: string;

  @doc("The Amazon Resource Name (ARN) of the trust store.")
  trustStoreArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AuthenticateCognitoConfig")
model AuthenticateCognitoConfig {
  @doc("The query parameters (up to 10) to include in the redirect request to the authorization endpoint.")
  authenticationRequestExtraParams?: Record<string>;

  @doc("The behavior if the user is not authenticated. The following are possible values:  +  deny```` - Return an HTTP 401 Unauthorized error.  +  allow```` - Allow the request to be forwarded to the target.  +  authenticate```` - Redirect the request to the IdP authorization endpoint. This is the default value.")
  onUnauthenticatedRequest?: string;

  @doc("The set of user claims to be requested from the IdP. The default is ``openid``. To verify which scope values your IdP supports and how to separate multiple values, see the documentation for your IdP.")
  scope?: string;

  @doc("The name of the cookie used to maintain session information. The default is AWSELBAuthSessionCookie.")
  sessionCookieName?: string;

  @doc("The maximum duration of the authentication session, in seconds. The default is 604800 seconds (7 days).")
  sessionTimeout?: string;

  @doc("The Amazon Resource Name (ARN) of the Amazon Cognito user pool.")
  userPoolArn?: string;

  @doc("The ID of the Amazon Cognito user pool client.")
  userPoolClientId?: string;

  @doc("The domain prefix or fully-qualified domain name of the Amazon Cognito user pool.")
  userPoolDomain?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AuthenticateOidcConfig")
model AuthenticateOidcConfig {
  @doc("The query parameters (up to 10) to include in the redirect request to the authorization endpoint.")
  authenticationRequestExtraParams?: Record<string>;

  @doc("The authorization endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.")
  authorizationEndpoint?: string;

  @doc("The OAuth 2.0 client identifier.")
  clientId?: string;

  @doc("The OAuth 2.0 client secret. This parameter is required if you are creating a rule. If you are modifying a rule, you can omit this parameter if you set ``UseExistingClientSecret`` to true.")
  clientSecret?: string;

  @doc("The OIDC issuer identifier of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.")
  issuer?: string;

  @doc("The behavior if the user is not authenticated. The following are possible values:  +  deny```` - Return an HTTP 401 Unauthorized error.  +  allow```` - Allow the request to be forwarded to the target.  +  authenticate```` - Redirect the request to the IdP authorization endpoint. This is the default value.")
  onUnauthenticatedRequest?: string;

  @doc("The set of user claims to be requested from the IdP. The default is ``openid``. To verify which scope values your IdP supports and how to separate multiple values, see the documentation for your IdP.")
  scope?: string;

  @doc("The name of the cookie used to maintain session information. The default is AWSELBAuthSessionCookie.")
  sessionCookieName?: string;

  @doc("The maximum duration of the authentication session, in seconds. The default is 604800 seconds (7 days).")
  sessionTimeout?: string;

  @doc("The token endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.")
  tokenEndpoint?: string;

  @doc("Indicates whether to use the existing client secret when modifying a rule. If you are creating a rule, you can omit this parameter or set it to false.")
  useExistingClientSecret?: boolean;

  @doc("The user info endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.")
  userInfoEndpoint?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FixedResponseConfig")
model FixedResponseConfig {
  @doc("The content type. Valid Values: text/plain | text/css | text/html | application/javascript | application/json")
  contentType?: string;

  @doc("The message.")
  messageBody?: string;

  @doc("The HTTP response code (2XX, 4XX, or 5XX).")
  statusCode?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ForwardConfig")
model ForwardConfig {
  @doc("Information about the target group stickiness for a rule. Information about the target group stickiness for a rule.")
  targetGroupStickinessConfig?: TargetGroupStickinessConfig;

  @doc("Information about how traffic will be distributed between multiple target groups in a forward rule.")
  @extension("x-ms-identifiers", [])
  targetGroups?: TargetGroupTuple[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedirectConfig")
model RedirectConfig {
  @doc("The hostname. This component is not percent-encoded. The hostname can contain #{host}.")
  host?: string;

  @doc("The absolute path, starting with the leading '/'. This component is not percent-encoded. The path can contain #{host}, #{path}, and #{port}.")
  path?: string;

  @doc("The port. You can specify a value from 1 to 65535 or #{port}.")
  port?: string;

  @doc("The protocol. You can specify HTTP, HTTPS, or #{protocol}. You can redirect HTTP to HTTP, HTTP to HTTPS, and HTTPS to HTTPS. You cannot redirect HTTPS to HTTP.")
  protocol?: string;

  @doc("The query parameters, URL-encoded when necessary, but not percent-encoded. Do not include the leading '?', as it is automatically added. You can specify any of the reserved keywords.")
  query?: string;

  @doc("The HTTP redirect code. The redirect is either permanent (HTTP 301) or temporary (HTTP 302).")
  statusCode?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TargetGroupStickinessConfig")
model TargetGroupStickinessConfig {
  @doc("The time period, in seconds, during which requests from a client should be routed to the same target group. The range is 1-604800 seconds (7 days).")
  durationSeconds?: int32;

  @doc("Indicates whether target group stickiness is enabled.")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TargetGroupTuple")
model TargetGroupTuple {
  @doc("The Amazon Resource Name (ARN) of the target group.")
  targetGroupArn?: string;

  @doc("The weight. The range is 0 to 999.")
  weight?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticLoadBalancingV2Listeners {
  get is ArmResourceRead<ElasticLoadBalancingV2Listener>;
  @doc("Create a ElasticLoadBalancingV2Listener. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ElasticLoadBalancingV2Listener>;
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
