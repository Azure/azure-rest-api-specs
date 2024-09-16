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

//---------------------------------------------- ElasticLoadBalancingV2ListenerRules ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Elastic Load Balancing V2 Listener Rule",
    plural: "Elastic Load Balancing V2 Listener Rules",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Elastic",
    "Load",
    "Balancing",
    "V2",
    "Listener",
    "Rule"
  ],
})
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticLoadBalancingV2ListenerRule")
model ElasticLoadBalancingV2ListenerRuleProperties {
  @doc("AWS Properties")
  awsProperties?: AwsElasticLoadBalancingV2ListenerRuleProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticLoadBalancingV2ListenerRule")
model AwsElasticLoadBalancingV2ListenerRuleProperties {
  @doc("The actions. The rule must include exactly one of the following types of actions: ``forward``, ``fixed-response``, or ``redirect``, and it must be the last action to be performed. If the rule is for an HTTPS listener, it can also optionally include an authentication action.")
  @extension("x-ms-identifiers", [])
  actions?: Action[];

  @doc("The conditions. The rule can optionally include up to one of each of the following conditions: ``http-request-method``, ``host-header``, ``path-pattern``, and ``source-ip``. A rule can also optionally include one or more of each of the following conditions: ``http-header`` and ``query-string``.")
  @extension("x-ms-identifiers", [])
  conditions?: RuleCondition[];

  @doc("Property isDefault")
  isDefault?: boolean;

  @doc("The Amazon Resource Name (ARN) of the listener.")
  listenerArn?: string;

  @doc("The rule priority. A listener can't have multiple rules with the same priority. If you try to reorder rules by updating their priorities, do not specify a new priority if an existing rule already uses this priority, as this can cause an error. If you need to reuse a priority with a different rule, you must remove it as a priority first, and then specify it in a subsequent update.")
  priority?: int32;

  @doc("Property ruleArn")
  ruleArn?: string;
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
@doc("Definition of RuleCondition")
model RuleCondition {
  @doc("The field in the HTTP request. The following are the possible values:  +   ``http-header``   +   ``http-request-method``   +   ``host-header``   +   ``path-pattern``   +   ``query-string``   +   ``source-ip``")
  field?: string;

  @doc("Information for a host header condition. Specify only when ``Field`` is ``host-header``. Information about a host header condition.")
  hostHeaderConfig?: HostHeaderConfig;

  @doc("Information for an HTTP header condition. Specify only when ``Field`` is ``http-header``. Information about an HTTP header condition. There is a set of standard HTTP header fields. You can also define custom HTTP header fields.")
  httpHeaderConfig?: HttpHeaderConfig;

  @doc("Information for an HTTP method condition. Specify only when ``Field`` is ``http-request-method``. Information about an HTTP method condition. HTTP defines a set of request methods, also referred to as HTTP verbs. For more information, see the [HTTP Method Registry](https://docs.aws.amazon.com/https://www.iana.org/assignments/http-methods/http-methods.xhtml). You can also define custom HTTP methods.")
  httpRequestMethodConfig?: HttpRequestMethodConfig;

  @doc("Information for a path pattern condition. Specify only when ``Field`` is ``path-pattern``. Information about a path pattern condition.")
  pathPatternConfig?: PathPatternConfig;

  @doc("Information for a query string condition. Specify only when ``Field`` is ``query-string``. Information about a query string condition. The query string component of a URI starts after the first '?' character and is terminated by either a '#' character or the end of the URI. A typical query string contains key/value pairs separated by '&' characters. The allowed characters are specified by RFC 3986. Any character can be percentage encoded.")
  queryStringConfig?: QueryStringConfig;

  @doc("Information for a source IP condition. Specify only when ``Field`` is ``source-ip``. Information about a source IP condition. You can use this condition to route based on the IP address of the source that connects to the load balancer. If a client is behind a proxy, this is the IP address of the proxy not the IP address of the client.")
  sourceIpConfig?: SourceIpConfig;

  @doc("The condition value. Specify only when ``Field`` is ``host-header`` or ``path-pattern``. Alternatively, to specify multiple host names or multiple path patterns, use ``HostHeaderConfig`` or ``PathPatternConfig``. If ``Field`` is ``host-header`` and you're not using ``HostHeaderConfig``, you can specify a single host name (for example, my.example.com). A host name is case insensitive, can be up to 128 characters in length, and can contain any of the following characters.  +  A-Z, a-z, 0-9  +  - .  +  * (matches 0 or more characters)  +  ? (matches exactly 1 character)   If ``Field`` is ``path-pattern`` and you're not using ``PathPatternConfig``, you can specify a single path pattern (for example, /img/*). A path pattern is case-sensitive, can be up to 128 characters in length, and can contain any of the following characters.  +  A-Z, a-z, 0-9  +  _ - . $ / ~ ' ' @ : +  +  & (using &amp;)  +  * (matches 0 or more characters)  +  ? (matches exactly 1 character)")
  @extension("x-ms-identifiers", [])
  values?: string[];
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
  sessionTimeout?: int32;

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
  sessionTimeout?: int32;

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
@doc("Definition of HostHeaderConfig")
model HostHeaderConfig {
  @doc("The host names. The maximum size of each name is 128 characters. The comparison is case insensitive. The following wildcard characters are supported: * (matches 0 or more characters) and ? (matches exactly 1 character). If you specify multiple strings, the condition is satisfied if one of the strings matches the host name.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HttpHeaderConfig")
model HttpHeaderConfig {
  @doc("The name of the HTTP header field. The maximum size is 40 characters. The header name is case insensitive. The allowed characters are specified by RFC 7230. Wildcards are not supported.")
  httpHeaderName?: string;

  @doc("The strings to compare against the value of the HTTP header. The maximum size of each string is 128 characters. The comparison strings are case insensitive. The following wildcard characters are supported: * (matches 0 or more characters) and ? (matches exactly 1 character). If the same header appears multiple times in the request, we search them in order until a match is found. If you specify multiple strings, the condition is satisfied if one of the strings matches the value of the HTTP header. To require that all of the strings are a match, create one condition per string.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HttpRequestMethodConfig")
model HttpRequestMethodConfig {
  @doc("The name of the request method. The maximum size is 40 characters. The allowed characters are A-Z, hyphen (-), and underscore (_). The comparison is case sensitive. Wildcards are not supported; therefore, the method name must be an exact match. If you specify multiple strings, the condition is satisfied if one of the strings matches the HTTP request method. We recommend that you route GET and HEAD requests in the same way, because the response to a HEAD request may be cached.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PathPatternConfig")
model PathPatternConfig {
  @doc("The path patterns to compare against the request URL. The maximum size of each string is 128 characters. The comparison is case sensitive. The following wildcard characters are supported: * (matches 0 or more characters) and ? (matches exactly 1 character). If you specify multiple strings, the condition is satisfied if one of them matches the request URL. The path pattern is compared only to the path of the URL, not to its query string.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of QueryStringConfig")
model QueryStringConfig {
  @doc("The key/value pairs or values to find in the query string. The maximum size of each string is 128 characters. The comparison is case insensitive. The following wildcard characters are supported: * (matches 0 or more characters) and ? (matches exactly 1 character). To search for a literal '*' or '?' character in a query string, you must escape these characters in ``Values`` using a '\\' character. If you specify multiple key/value pairs or values, the condition is satisfied if one of them is found in the query string.")
  @extension("x-ms-identifiers", [])
  values?: QueryStringKeyValue[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SourceIpConfig")
model SourceIpConfig {
  @doc("The source IP addresses, in CIDR format. You can use both IPv4 and IPv6 addresses. Wildcards are not supported. If you specify multiple addresses, the condition is satisfied if the source IP address of the request matches one of the CIDR blocks. This condition is not satisfied by the addresses in the X-Forwarded-For header.")
  @extension("x-ms-identifiers", [])
  values?: string[];
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of QueryStringKeyValue")
model QueryStringKeyValue {
  @doc("The key. You can omit the key.")
  key?: string;

  @doc("The value.")
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
