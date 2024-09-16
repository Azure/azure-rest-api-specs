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

//---------------------------------------------- Wafv2WebACLS ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "WAFv2 Web ACL",
    plural: "WAFv2 Web ACLS",
  },
  keywords: ["Microsoft.AwsConnector", "WAFv2", "Web", "ACL"],
})
@doc("A Microsoft.AwsConnector resource")
model Wafv2WebACL is TrackedResource<Wafv2WebACLProperties> {
  @doc("Name of Wafv2WebACL")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("wafv2WebACLS")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Wafv2WebACL")
model Wafv2WebACLProperties {
  @doc("AWS Properties")
  awsProperties?: AwsWafv2WebACLProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsWafv2WebACL")
model AwsWafv2WebACLProperties {
  @doc("ARN of the WAF entity.")
  arn?: string;

  @doc("AssociationConfig for body inspection")
  associationConfig?: AssociationConfig;

  @doc("Property capacity")
  capacity?: int32;

  @doc("Property captchaConfig")
  captchaConfig?: CaptchaConfig;

  @doc("Property challengeConfig")
  challengeConfig?: ChallengeConfig;

  @doc("Custom response key and body map.")
  customResponseBodies?: Record<CustomResponseBody>;

  @doc("Default Action WebACL will take against ingress traffic when there is no matching Rule.")
  defaultAction?: DefaultAction;

  @doc("Description of the entity.")
  description?: string;

  @doc("Id of the WebACL")
  id?: string;

  @doc("Name of the Label.")
  labelNamespace?: string;

  @doc("Name of the WebACL.")
  name?: string;

  @doc("Collection of Rules.")
  @extension("x-ms-identifiers", [])
  rules?: Rule[];

  @doc("Use CLOUDFRONT for CloudFront WebACL, use REGIONAL for Application Load Balancer and API Gateway.")
  scope?: Scope;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("List of domains to accept in web request tokens, in addition to the domain of the protected resource.")
  @extension("x-ms-identifiers", [])
  tokenDomains?: string[];

  @doc("Visibility Metric of the WebACL.")
  visibilityConfig?: VisibilityConfig;
}

@doc("Scope enum")
union Scope {
  @doc("Scope enum CLOUDFRONT")
  CLOUDFRONT: "CLOUDFRONT",

  @doc("Scope enum REGIONAL")
  REGIONAL: "REGIONAL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AssociationConfig")
model AssociationConfig {
  @doc("Map of AssociatedResourceType and RequestBodyAssociatedResourceTypeConfig")
  requestBody?: Record<RequestBodyAssociatedResourceTypeConfig>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CaptchaConfig")
model CaptchaConfig {
  @doc("Property immunityTimeProperty")
  immunityTimeProperty?: ImmunityTimeProperty;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ChallengeConfig")
model ChallengeConfig {
  @doc("Property immunityTimeProperty")
  immunityTimeProperty?: ImmunityTimeProperty;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomResponseBody")
model CustomResponseBody {
  @doc("Response content.")
  content?: string;

  @doc("Valid values are TEXT_PLAIN, TEXT_HTML, and APPLICATION_JSON.")
  contentType?: CustomResponseBodyContentType;
}

@doc("CustomResponseBodyContentType enum")
union CustomResponseBodyContentType {
  @doc("CustomResponseBodyContentType enum APPLICATION_JSON")
  APPLICATION_JSON: "APPLICATION_JSON",

  @doc("CustomResponseBodyContentType enum TEXT_HTML")
  TEXT_HTML: "TEXT_HTML",

  @doc("CustomResponseBodyContentType enum TEXT_PLAIN")
  TEXT_PLAIN: "TEXT_PLAIN",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DefaultAction")
model DefaultAction {
  @doc("Allow traffic towards application.")
  allow?: AllowAction;

  @doc("Block traffic towards application.")
  block?: BlockAction;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Rule")
model Rule {
  @doc("Action taken when Rule matches its condition.")
  action?: RuleAction;

  @doc("Property captchaConfig")
  captchaConfig?: CaptchaConfig;

  @doc("Property challengeConfig")
  challengeConfig?: ChallengeConfig;

  @doc("Name of the WebACL.")
  name?: string;

  @doc("Override a RuleGroup or ManagedRuleGroup behavior. This can only be applied to Rule that has RuleGroupReferenceStatement or ManagedRuleGroupReferenceStatement.")
  overrideAction?: OverrideAction;

  @doc("Priority of the Rule, Rules get evaluated from lower to higher priority.")
  priority?: int32;

  @doc("Collection of Rule Labels.")
  @extension("x-ms-identifiers", [])
  ruleLabels?: Label[];

  @doc("First level statement that contains conditions, such as ByteMatch, SizeConstraint, etc")
  statement?: Statement;

  @doc("Visibility Metric of the WebACL.")
  visibilityConfig?: VisibilityConfig;
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VisibilityConfig")
model VisibilityConfig {
  @doc("Property cloudWatchMetricsEnabled")
  cloudWatchMetricsEnabled?: boolean;

  @doc("Property metricName")
  metricName?: string;

  @doc("Property sampledRequestsEnabled")
  sampledRequestsEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RequestBodyAssociatedResourceTypeConfig")
model RequestBodyAssociatedResourceTypeConfig {
  @doc("Property defaultSizeInspectionLimit")
  defaultSizeInspectionLimit?: RequestBodyAssociatedResourceTypeConfigDefaultSizeInspectionLimit;
}

@doc("RequestBodyAssociatedResourceTypeConfigDefaultSizeInspectionLimit enum")
union RequestBodyAssociatedResourceTypeConfigDefaultSizeInspectionLimit {
  @doc("RequestBodyAssociatedResourceTypeConfigDefaultSizeInspectionLimit enum KB_16")
  KB_16: "KB_16",

  @doc("RequestBodyAssociatedResourceTypeConfigDefaultSizeInspectionLimit enum KB_32")
  KB_32: "KB_32",

  @doc("RequestBodyAssociatedResourceTypeConfigDefaultSizeInspectionLimit enum KB_48")
  KB_48: "KB_48",

  @doc("RequestBodyAssociatedResourceTypeConfigDefaultSizeInspectionLimit enum KB_64")
  KB_64: "KB_64",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImmunityTimeProperty")
model ImmunityTimeProperty {
  @doc("Property immunityTime")
  immunityTime?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AllowAction")
model AllowAction {
  @doc("Custom request handling.")
  customRequestHandling?: CustomRequestHandling;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BlockAction")
model BlockAction {
  @doc("Custom response.")
  customResponse?: CustomResponse;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuleAction")
model RuleAction {
  @doc("Allow traffic towards application.")
  allow?: AllowAction;

  @doc("Block traffic towards application.")
  block?: BlockAction;

  @doc("Checks valid token exists with request.")
  captcha?: CaptchaAction;

  @doc("Checks that the request has a valid token with an unexpired challenge timestamp and, if not, returns a browser challenge to the client.")
  challenge?: ChallengeAction;

  @doc("Allow traffic towards application.")
  count?: CountAction;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OverrideAction")
model OverrideAction {
  @doc("Count traffic towards application.")
  count?: unknown;

  @doc("Keep the RuleGroup or ManagedRuleGroup behavior as is.")
  none?: unknown;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Label")
model Label {
  @doc("Name of the Label.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Statement")
model Statement {
  @doc("Property andStatement")
  andStatement?: AndStatement;

  @doc("Byte Match statement.")
  byteMatchStatement?: ByteMatchStatement;

  @doc("Property geoMatchStatement")
  geoMatchStatement?: GeoMatchStatement;

  @doc("Property ipSetReferenceStatement")
  ipSetReferenceStatement?: IPSetReferenceStatement;

  @doc("Property labelMatchStatement")
  labelMatchStatement?: LabelMatchStatement;

  @doc("Property managedRuleGroupStatement")
  managedRuleGroupStatement?: ManagedRuleGroupStatement;

  @doc("Property notStatement")
  notStatement?: NotStatement;

  @doc("Property orStatement")
  orStatement?: OrStatement;

  @doc("Property rateBasedStatement")
  rateBasedStatement?: RateBasedStatement;

  @doc("Property regexMatchStatement")
  regexMatchStatement?: RegexMatchStatement;

  @doc("Property regexPatternSetReferenceStatement")
  regexPatternSetReferenceStatement?: RegexPatternSetReferenceStatement;

  @doc("Property ruleGroupReferenceStatement")
  ruleGroupReferenceStatement?: RuleGroupReferenceStatement;

  @doc("Size Constraint statement.")
  sizeConstraintStatement?: SizeConstraintStatement;

  @doc("Sqli Match Statement.")
  sqliMatchStatement?: SqliMatchStatement;

  @doc("Xss Match Statement.")
  xssMatchStatement?: XssMatchStatement;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomRequestHandling")
model CustomRequestHandling {
  @doc("Collection of HTTP headers.")
  @extension("x-ms-identifiers", [])
  insertHeaders?: CustomHTTPHeader[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomResponse")
model CustomResponse {
  @doc("Custom response body key.")
  customResponseBodyKey?: string;

  @doc("Custom response code.")
  responseCode?: int32;

  @doc("Collection of HTTP headers.")
  @extension("x-ms-identifiers", [])
  responseHeaders?: CustomHTTPHeader[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CaptchaAction")
model CaptchaAction {
  @doc("Custom request handling.")
  customRequestHandling?: CustomRequestHandling;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ChallengeAction")
model ChallengeAction {
  @doc("Custom request handling.")
  customRequestHandling?: CustomRequestHandling;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CountAction")
model CountAction {
  @doc("Custom request handling.")
  customRequestHandling?: CustomRequestHandling;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AndStatement")
model AndStatement {
  @doc("Property statements")
  @extension("x-ms-identifiers", [])
  statements?: Statement[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ByteMatchStatement")
model ByteMatchStatement {
  @doc("Field of the request to match.")
  fieldToMatch?: FieldToMatch;

  @doc("Position of the evaluation in the FieldToMatch of request.")
  positionalConstraint?: ByteMatchStatementPositionalConstraint;

  @doc("String that is searched to find a match.")
  searchString?: string;

  @doc("Base64 encoded string that is searched to find a match.")
  searchStringBase64?: string;

  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

@doc("ByteMatchStatementPositionalConstraint enum")
union ByteMatchStatementPositionalConstraint {
  @doc("ByteMatchStatementPositionalConstraint enum CONTAINS")
  CONTAINS: "CONTAINS",

  @doc("ByteMatchStatementPositionalConstraint enum CONTAINS_WORD")
  CONTAINS_WORD: "CONTAINS_WORD",

  @doc("ByteMatchStatementPositionalConstraint enum ENDS_WITH")
  ENDS_WITH: "ENDS_WITH",

  @doc("ByteMatchStatementPositionalConstraint enum EXACTLY")
  EXACTLY: "EXACTLY",

  @doc("ByteMatchStatementPositionalConstraint enum STARTS_WITH")
  STARTS_WITH: "STARTS_WITH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GeoMatchStatement")
model GeoMatchStatement {
  @doc("Property countryCodes")
  @extension("x-ms-identifiers", [])
  countryCodes?: string[];

  @doc("Property forwardedIPConfig")
  forwardedIPConfig?: ForwardedIPConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IPSetReferenceStatement")
model IPSetReferenceStatement {
  @doc("ARN of the WAF entity.")
  arn?: string;

  @doc("Property ipSetForwardedIPConfig")
  ipSetForwardedIPConfig?: IPSetForwardedIPConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LabelMatchStatement")
model LabelMatchStatement {
  @doc("Property key")
  key?: string;

  @doc("Property scope")
  scope?: LabelMatchStatementScope;
}

@doc("LabelMatchStatementScope enum")
union LabelMatchStatementScope {
  @doc("LabelMatchStatementScope enum LABEL")
  LABEL: "LABEL",

  @doc("LabelMatchStatementScope enum NAMESPACE")
  NAMESPACE: "NAMESPACE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ManagedRuleGroupStatement")
model ManagedRuleGroupStatement {
  @doc("Property excludedRules")
  @extension("x-ms-identifiers", [])
  excludedRules?: ExcludedRule[];

  @doc("Collection of ManagedRuleGroupConfig.")
  @extension("x-ms-identifiers", [])
  managedRuleGroupConfigs?: ManagedRuleGroupConfig[];

  @doc("Name of the WebACL.")
  name?: string;

  @doc("Action overrides for rules in the rule group.")
  @extension("x-ms-identifiers", [])
  ruleActionOverrides?: RuleActionOverride[];

  @doc("First level statement that contains conditions, such as ByteMatch, SizeConstraint, etc")
  scopeDownStatement?: Statement;

  @doc("Property vendorName")
  vendorName?: string;

  @doc("Property version")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NotStatement")
model NotStatement {
  @doc("First level statement that contains conditions, such as ByteMatch, SizeConstraint, etc")
  statement?: Statement;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OrStatement")
model OrStatement {
  @doc("Property statements")
  @extension("x-ms-identifiers", [])
  statements?: Statement[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RateBasedStatement")
model RateBasedStatement {
  @doc("Property aggregateKeyType")
  aggregateKeyType?: RateBasedStatementAggregateKeyType;

  @doc("Specifies the aggregate keys to use in a rate-base rule.")
  @extension("x-ms-identifiers", [])
  customKeys?: RateBasedStatementCustomKey[];

  @doc("Property evaluationWindowSec")
  evaluationWindowSec?: int32;

  @doc("Property forwardedIPConfig")
  forwardedIPConfig?: ForwardedIPConfiguration;

  @doc("Property limit")
  limit?: int32;

  @doc("First level statement that contains conditions, such as ByteMatch, SizeConstraint, etc")
  scopeDownStatement?: Statement;
}

@doc("RateBasedStatementAggregateKeyType enum")
union RateBasedStatementAggregateKeyType {
  @doc("RateBasedStatementAggregateKeyType enum CONSTANT")
  CONSTANT: "CONSTANT",

  @doc("RateBasedStatementAggregateKeyType enum CUSTOM_KEYS")
  CUSTOM_KEYS: "CUSTOM_KEYS",

  @doc("RateBasedStatementAggregateKeyType enum FORWARDED_IP")
  FORWARDED_IP: "FORWARDED_IP",

  @doc("RateBasedStatementAggregateKeyType enum IP")
  IP: "IP",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RegexMatchStatement")
model RegexMatchStatement {
  @doc("Field of the request to match.")
  fieldToMatch?: FieldToMatch;

  @doc("Property regexString")
  regexString?: string;

  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RegexPatternSetReferenceStatement")
model RegexPatternSetReferenceStatement {
  @doc("ARN of the WAF entity.")
  arn?: string;

  @doc("Field of the request to match.")
  fieldToMatch?: FieldToMatch;

  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuleGroupReferenceStatement")
model RuleGroupReferenceStatement {
  @doc("ARN of the WAF entity.")
  arn?: string;

  @doc("Property excludedRules")
  @extension("x-ms-identifiers", [])
  excludedRules?: ExcludedRule[];

  @doc("Action overrides for rules in the rule group.")
  @extension("x-ms-identifiers", [])
  ruleActionOverrides?: RuleActionOverride[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SizeConstraintStatement")
model SizeConstraintStatement {
  @doc("Property comparisonOperator")
  comparisonOperator?: SizeConstraintStatementComparisonOperator;

  @doc("Field of the request to match.")
  fieldToMatch?: FieldToMatch;

  @doc("Property size")
  size?: int32;

  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

@doc("SizeConstraintStatementComparisonOperator enum")
union SizeConstraintStatementComparisonOperator {
  @doc("SizeConstraintStatementComparisonOperator enum EQ")
  EQ: "EQ",

  @doc("SizeConstraintStatementComparisonOperator enum GE")
  GE: "GE",

  @doc("SizeConstraintStatementComparisonOperator enum GT")
  GT: "GT",

  @doc("SizeConstraintStatementComparisonOperator enum LE")
  LE: "LE",

  @doc("SizeConstraintStatementComparisonOperator enum LT")
  LT: "LT",

  @doc("SizeConstraintStatementComparisonOperator enum NE")
  NE: "NE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SqliMatchStatement")
model SqliMatchStatement {
  @doc("Field of the request to match.")
  fieldToMatch?: FieldToMatch;

  @doc("Sensitivity Level current only used for sqli match statements.")
  sensitivityLevel?: SqliMatchStatementSensitivityLevel;

  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

@doc("SqliMatchStatementSensitivityLevel enum")
union SqliMatchStatementSensitivityLevel {
  @doc("SqliMatchStatementSensitivityLevel enum HIGH")
  HIGH: "HIGH",

  @doc("SqliMatchStatementSensitivityLevel enum LOW")
  LOW: "LOW",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of XssMatchStatement")
model XssMatchStatement {
  @doc("Field of the request to match.")
  fieldToMatch?: FieldToMatch;

  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomHTTPHeader")
model CustomHTTPHeader {
  @doc("HTTP header name.")
  name?: string;

  @doc("HTTP header value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FieldToMatch")
model FieldToMatch {
  @doc("All query arguments of a web request.")
  allQueryArguments?: unknown;

  @doc("The body of a web request. This immediately follows the request headers.")
  body?: Body;

  @doc("Includes cookies of a web request.")
  cookies?: Cookies;

  @doc("Includes headers of a web request.")
  headers?: Headers;

  @doc("Includes the JA3 fingerprint of a web request.")
  jA3Fingerprint?: JA3Fingerprint;

  @doc("Inspect the request body as JSON. The request body immediately follows the request headers.")
  jsonBody?: JsonBody;

  @doc("The HTTP method of a web request. The method indicates the type of operation that the request is asking the origin to perform.")
  method?: unknown;

  @doc("The query string of a web request. This is the part of a URL that appears after a ? character, if any.")
  queryString?: unknown;

  @doc("Property singleHeader")
  singleHeader?: SingleHeaderModelProperties;

  @doc("One query argument in a web request, identified by name, for example UserName or SalesRegion. The name can be up to 30 characters long and isn't case sensitive.")
  singleQueryArgument?: SingleQueryArgumentModelProperties;

  @doc("The path component of the URI of a web request. This is the part of a web request that identifies a resource, for example, /images/daily-ad.jpg.")
  uriPath?: unknown;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TextTransformation")
model TextTransformation {
  @doc("Priority of Rule being evaluated.")
  priority?: int32;

  @doc("Type of text transformation.")
  type?: TextTransformationType;
}

@doc("TextTransformationType enum")
union TextTransformationType {
  @doc("TextTransformationType enum BASE64_DECODE")
  BASE64_DECODE: "BASE64_DECODE",

  @doc("TextTransformationType enum BASE64_DECODE_EXT")
  BASE64_DECODE_EXT: "BASE64_DECODE_EXT",

  @doc("TextTransformationType enum CMD_LINE")
  CMD_LINE: "CMD_LINE",

  @doc("TextTransformationType enum COMPRESS_WHITE_SPACE")
  COMPRESS_WHITE_SPACE: "COMPRESS_WHITE_SPACE",

  @doc("TextTransformationType enum CSS_DECODE")
  CSS_DECODE: "CSS_DECODE",

  @doc("TextTransformationType enum ESCAPE_SEQ_DECODE")
  ESCAPE_SEQ_DECODE: "ESCAPE_SEQ_DECODE",

  @doc("TextTransformationType enum HEX_DECODE")
  HEX_DECODE: "HEX_DECODE",

  @doc("TextTransformationType enum HTML_ENTITY_DECODE")
  HTML_ENTITY_DECODE: "HTML_ENTITY_DECODE",

  @doc("TextTransformationType enum JS_DECODE")
  JS_DECODE: "JS_DECODE",

  @doc("TextTransformationType enum LOWERCASE")
  LOWERCASE: "LOWERCASE",

  @doc("TextTransformationType enum MD5")
  MD5: "MD5",

  @doc("TextTransformationType enum NONE")
  NONE: "NONE",

  @doc("TextTransformationType enum NORMALIZE_PATH")
  NORMALIZE_PATH: "NORMALIZE_PATH",

  @doc("TextTransformationType enum NORMALIZE_PATH_WIN")
  NORMALIZE_PATH_WIN: "NORMALIZE_PATH_WIN",

  @doc("TextTransformationType enum REMOVE_NULLS")
  REMOVE_NULLS: "REMOVE_NULLS",

  @doc("TextTransformationType enum REPLACE_COMMENTS")
  REPLACE_COMMENTS: "REPLACE_COMMENTS",

  @doc("TextTransformationType enum REPLACE_NULLS")
  REPLACE_NULLS: "REPLACE_NULLS",

  @doc("TextTransformationType enum SQL_HEX_DECODE")
  SQL_HEX_DECODE: "SQL_HEX_DECODE",

  @doc("TextTransformationType enum URL_DECODE")
  URL_DECODE: "URL_DECODE",

  @doc("TextTransformationType enum URL_DECODE_UNI")
  URL_DECODE_UNI: "URL_DECODE_UNI",

  @doc("TextTransformationType enum UTF8_TO_UNICODE")
  UTF8_TO_UNICODE: "UTF8_TO_UNICODE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ForwardedIPConfiguration")
model ForwardedIPConfiguration {
  @doc("Property fallbackBehavior")
  fallbackBehavior?: ForwardedIPConfigurationFallbackBehavior;

  @doc("Property headerName")
  headerName?: string;
}

@doc("ForwardedIPConfigurationFallbackBehavior enum")
union ForwardedIPConfigurationFallbackBehavior {
  @doc("ForwardedIPConfigurationFallbackBehavior enum MATCH")
  MATCH: "MATCH",

  @doc("ForwardedIPConfigurationFallbackBehavior enum NO_MATCH")
  NO_MATCH: "NO_MATCH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IPSetForwardedIPConfiguration")
model IPSetForwardedIPConfiguration {
  @doc("Property fallbackBehavior")
  fallbackBehavior?: IPSetForwardedIPConfigurationFallbackBehavior;

  @doc("Property headerName")
  headerName?: string;

  @doc("Property position")
  position?: IPSetForwardedIPConfigurationPosition;
}

@doc("IPSetForwardedIPConfigurationFallbackBehavior enum")
union IPSetForwardedIPConfigurationFallbackBehavior {
  @doc("IPSetForwardedIPConfigurationFallbackBehavior enum MATCH")
  MATCH: "MATCH",

  @doc("IPSetForwardedIPConfigurationFallbackBehavior enum NO_MATCH")
  NO_MATCH: "NO_MATCH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ExcludedRule")
model ExcludedRule {
  @doc("Name of the WebACL.")
  name?: string;
}

@doc("IPSetForwardedIPConfigurationPosition enum")
union IPSetForwardedIPConfigurationPosition {
  @doc("IPSetForwardedIPConfigurationPosition enum ANY")
  ANY: "ANY",

  @doc("IPSetForwardedIPConfigurationPosition enum FIRST")
  FIRST: "FIRST",

  @doc("IPSetForwardedIPConfigurationPosition enum LAST")
  LAST: "LAST",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ManagedRuleGroupConfig")
model ManagedRuleGroupConfig {
  @doc("Configures how to use the Account creation fraud prevention managed rule group in the web ACL")
  awsManagedRulesACFPRuleSet?: AWSManagedRulesACFPRuleSet;

  @doc("Configures how to use the Account Takeover Prevention managed rule group in the web ACL")
  awsManagedRulesATPRuleSet?: AWSManagedRulesATPRuleSet;

  @doc("Configures how to use the Bot Control managed rule group in the web ACL")
  awsManagedRulesBotControlRuleSet?: AWSManagedRulesBotControlRuleSet;

  @doc("Property loginPath")
  loginPath?: string;

  @doc("Property passwordField")
  passwordField?: FieldIdentifier;

  @doc("Property payloadType")
  payloadType?: ManagedRuleGroupConfigPayloadType;

  @doc("Property usernameField")
  usernameField?: FieldIdentifier;
}

@doc("ManagedRuleGroupConfigPayloadType enum")
union ManagedRuleGroupConfigPayloadType {
  @doc("ManagedRuleGroupConfigPayloadType enum FORM_ENCODED")
  FORM_ENCODED: "FORM_ENCODED",

  @doc("ManagedRuleGroupConfigPayloadType enum JSON")
  JSON: "JSON",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuleActionOverride")
model RuleActionOverride {
  @doc("Action taken when Rule matches its condition.")
  actionToUse?: RuleAction;

  @doc("Name of the WebACL.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RateBasedStatementCustomKey")
model RateBasedStatementCustomKey {
  @doc("Specifies a cookie as an aggregate key for a rate-based rule.")
  cookie?: RateLimitCookie;

  @doc("Specifies the first IP address in an HTTP header as an aggregate key for a rate-based rule.")
  forwardedIP?: unknown;

  @doc("Specifies the request's HTTP method as an aggregate key for a rate-based rule.")
  httpMethod?: unknown;

  @doc("Specifies a header as an aggregate key for a rate-based rule.")
  header?: RateLimitHeader;

  @doc("Specifies the IP address in the web request as an aggregate key for a rate-based rule.")
  ip?: unknown;

  @doc("Specifies a label namespace to use as an aggregate key for a rate-based rule.")
  labelNamespace?: RateLimitLabelNamespace;

  @doc("Specifies a query argument in the request as an aggregate key for a rate-based rule.")
  queryArgument?: RateLimitQueryArgument;

  @doc("Specifies the request's query string as an aggregate key for a rate-based rule.")
  queryString?: RateLimitQueryString;

  @doc("Specifies the request's URI Path as an aggregate key for a rate-based rule.")
  uriPath?: RateLimitUriPath;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Body")
model Body {
  @doc("Handling of requests containing oversize fields")
  oversizeHandling?: BodyOversizeHandling;
}

@doc("BodyOversizeHandling enum")
union BodyOversizeHandling {
  @doc("BodyOversizeHandling enum CONTINUE")
  CONTINUE: "CONTINUE",

  @doc("BodyOversizeHandling enum MATCH")
  MATCH: "MATCH",

  @doc("BodyOversizeHandling enum NO_MATCH")
  NO_MATCH: "NO_MATCH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Cookies")
model Cookies {
  @doc("The pattern to look for in the request cookies.")
  matchPattern?: CookieMatchPattern;

  @doc("The parts of the request to match against using the MatchPattern.")
  matchScope?: CookiesMatchScope;

  @doc("Handling of requests containing oversize fields")
  oversizeHandling?: CookiesOversizeHandling;
}

@doc("CookiesMatchScope enum")
union CookiesMatchScope {
  @doc("CookiesMatchScope enum ALL")
  ALL: "ALL",

  @doc("CookiesMatchScope enum KEY")
  KEY: "KEY",

  @doc("CookiesMatchScope enum VALUE")
  VALUE: "VALUE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Headers")
model Headers {
  @doc("The pattern to look for in the request headers.")
  matchPattern?: HeaderMatchPattern;

  @doc("The parts of the request to match against using the MatchPattern.")
  matchScope?: HeadersMatchScope;

  @doc("Handling of requests containing oversize fields")
  oversizeHandling?: HeadersOversizeHandling;
}

@doc("CookiesOversizeHandling enum")
union CookiesOversizeHandling {
  @doc("CookiesOversizeHandling enum CONTINUE")
  CONTINUE: "CONTINUE",

  @doc("CookiesOversizeHandling enum MATCH")
  MATCH: "MATCH",

  @doc("CookiesOversizeHandling enum NO_MATCH")
  NO_MATCH: "NO_MATCH",

  string,
}

@doc("HeadersOversizeHandling enum")
union HeadersOversizeHandling {
  @doc("HeadersOversizeHandling enum CONTINUE")
  CONTINUE: "CONTINUE",

  @doc("HeadersOversizeHandling enum MATCH")
  MATCH: "MATCH",

  @doc("HeadersOversizeHandling enum NO_MATCH")
  NO_MATCH: "NO_MATCH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of JA3Fingerprint")
model JA3Fingerprint {
  @doc("Property fallbackBehavior")
  fallbackBehavior?: JA3FingerprintFallbackBehavior;
}

@doc("HeadersMatchScope enum")
union HeadersMatchScope {
  @doc("HeadersMatchScope enum ALL")
  ALL: "ALL",

  @doc("HeadersMatchScope enum KEY")
  KEY: "KEY",

  @doc("HeadersMatchScope enum VALUE")
  VALUE: "VALUE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of JsonBody")
model JsonBody {
  @doc("The inspection behavior to fall back to if the JSON in the request body is invalid.")
  invalidFallbackBehavior?: JsonBodyInvalidFallbackBehavior;

  @doc("The pattern to look for in the JSON body.")
  matchPattern?: JsonMatchPattern;

  @doc("The parts of the JSON to match against using the MatchPattern.")
  matchScope?: JsonBodyMatchScope;

  @doc("Handling of requests containing oversize fields")
  oversizeHandling?: JsonBodyOversizeHandling;
}

@doc("JA3FingerprintFallbackBehavior enum")
union JA3FingerprintFallbackBehavior {
  @doc("JA3FingerprintFallbackBehavior enum MATCH")
  MATCH: "MATCH",

  @doc("JA3FingerprintFallbackBehavior enum NO_MATCH")
  NO_MATCH: "NO_MATCH",

  string,
}

@doc("JsonBodyMatchScope enum")
union JsonBodyMatchScope {
  @doc("JsonBodyMatchScope enum ALL")
  ALL: "ALL",

  @doc("JsonBodyMatchScope enum KEY")
  KEY: "KEY",

  @doc("JsonBodyMatchScope enum VALUE")
  VALUE: "VALUE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SingleHeaderModelProperties")
model SingleHeaderModelProperties {
  @doc("Property name")
  name?: string;
}

@doc("JsonBodyInvalidFallbackBehavior enum")
union JsonBodyInvalidFallbackBehavior {
  @doc("JsonBodyInvalidFallbackBehavior enum EVALUATE_AS_STRING")
  EVALUATE_AS_STRING: "EVALUATE_AS_STRING",

  @doc("JsonBodyInvalidFallbackBehavior enum MATCH")
  MATCH: "MATCH",

  @doc("JsonBodyInvalidFallbackBehavior enum NO_MATCH")
  NO_MATCH: "NO_MATCH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SingleQueryArgumentModelProperties")
model SingleQueryArgumentModelProperties {
  @doc("Property name")
  name?: string;
}

@doc("JsonBodyOversizeHandling enum")
union JsonBodyOversizeHandling {
  @doc("JsonBodyOversizeHandling enum CONTINUE")
  CONTINUE: "CONTINUE",

  @doc("JsonBodyOversizeHandling enum MATCH")
  MATCH: "MATCH",

  @doc("JsonBodyOversizeHandling enum NO_MATCH")
  NO_MATCH: "NO_MATCH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AWSManagedRulesACFPRuleSet")
model AWSManagedRulesACFPRuleSet {
  @doc("Property creationPath")
  creationPath?: string;

  @doc("Property enableRegexInPath")
  enableRegexInPath?: boolean;

  @doc("Property registrationPagePath")
  registrationPagePath?: string;

  @doc("Configures the inspection of sign-up requests")
  requestInspection?: RequestInspectionACFP;

  @doc("Configures the inspection of login responses")
  responseInspection?: ResponseInspection;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AWSManagedRulesATPRuleSet")
model AWSManagedRulesATPRuleSet {
  @doc("Property enableRegexInPath")
  enableRegexInPath?: boolean;

  @doc("Property loginPath")
  loginPath?: string;

  @doc("Configures the inspection of login requests")
  requestInspection?: RequestInspection;

  @doc("Configures the inspection of login responses")
  responseInspection?: ResponseInspection;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AWSManagedRulesBotControlRuleSet")
model AWSManagedRulesBotControlRuleSet {
  @doc("Property enableMachineLearning")
  enableMachineLearning?: boolean;

  @doc("Property inspectionLevel")
  inspectionLevel?: AWSManagedRulesBotControlRuleSetInspectionLevel;
}

@doc("AWSManagedRulesBotControlRuleSetInspectionLevel enum")
union AWSManagedRulesBotControlRuleSetInspectionLevel {
  @doc("AWSManagedRulesBotControlRuleSetInspectionLevel enum COMMON")
  COMMON: "COMMON",

  @doc("AWSManagedRulesBotControlRuleSetInspectionLevel enum TARGETED")
  TARGETED: "TARGETED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FieldIdentifier")
model FieldIdentifier {
  @doc("Property identifier")
  identifier?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RateLimitCookie")
model RateLimitCookie {
  @doc("The name of the cookie to use.")
  name?: string;

  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RateLimitHeader")
model RateLimitHeader {
  @doc("The name of the header to use.")
  name?: string;

  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RateLimitLabelNamespace")
model RateLimitLabelNamespace {
  @doc("The namespace to use for aggregation.")
  `namespace`?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RateLimitQueryArgument")
model RateLimitQueryArgument {
  @doc("The name of the query argument to use.")
  name?: string;

  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RateLimitQueryString")
model RateLimitQueryString {
  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RateLimitUriPath")
model RateLimitUriPath {
  @doc("Property textTransformations")
  @extension("x-ms-identifiers", [])
  textTransformations?: TextTransformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CookieMatchPattern")
model CookieMatchPattern {
  @doc("Inspect all parts of the web request cookies.")
  all?: unknown;

  @doc("Property excludedCookies")
  @extension("x-ms-identifiers", [])
  excludedCookies?: string[];

  @doc("Property includedCookies")
  @extension("x-ms-identifiers", [])
  includedCookies?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HeaderMatchPattern")
model HeaderMatchPattern {
  @doc("Inspect all parts of the web request headers.")
  all?: unknown;

  @doc("Property excludedHeaders")
  @extension("x-ms-identifiers", [])
  excludedHeaders?: string[];

  @doc("Property includedHeaders")
  @extension("x-ms-identifiers", [])
  includedHeaders?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of JsonMatchPattern")
model JsonMatchPattern {
  @doc("Inspect all parts of the web request's JSON body.")
  all?: unknown;

  @doc("Property includedPaths")
  @extension("x-ms-identifiers", [])
  includedPaths?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RequestInspectionACFP")
model RequestInspectionACFP {
  @doc("Property addressFields")
  @extension("x-ms-identifiers", [])
  addressFields?: AddressField[];

  @doc("Property emailField")
  emailField?: FieldIdentifier;

  @doc("Property passwordField")
  passwordField?: FieldIdentifier;

  @doc("Property payloadType")
  payloadType?: RequestInspectionACFPPayloadType;

  @doc("Property phoneNumberFields")
  @extension("x-ms-identifiers", [])
  phoneNumberFields?: PhoneNumberField[];

  @doc("Property usernameField")
  usernameField?: FieldIdentifier;
}

@doc("RequestInspectionACFPPayloadType enum")
union RequestInspectionACFPPayloadType {
  @doc("RequestInspectionACFPPayloadType enum FORM_ENCODED")
  FORM_ENCODED: "FORM_ENCODED",

  @doc("RequestInspectionACFPPayloadType enum JSON")
  JSON: "JSON",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResponseInspection")
model ResponseInspection {
  @doc("Response body contents that indicate success or failure of a login request")
  bodyContains?: ResponseInspectionBodyContains;

  @doc("Response headers that indicate success or failure of a login request")
  header?: ResponseInspectionHeader;

  @doc("Response JSON that indicate success or failure of a login request")
  json?: ResponseInspectionJson;

  @doc("Response status codes that indicate success or failure of a login request")
  statusCode?: ResponseInspectionStatusCode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RequestInspection")
model RequestInspection {
  @doc("Property passwordField")
  passwordField?: FieldIdentifier;

  @doc("Property payloadType")
  payloadType?: RequestInspectionPayloadType;

  @doc("Property usernameField")
  usernameField?: FieldIdentifier;
}

@doc("RequestInspectionPayloadType enum")
union RequestInspectionPayloadType {
  @doc("RequestInspectionPayloadType enum FORM_ENCODED")
  FORM_ENCODED: "FORM_ENCODED",

  @doc("RequestInspectionPayloadType enum JSON")
  JSON: "JSON",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AddressField")
model AddressField {
  @doc("Property addressField")
  @clientName("addressFieldcsharp", "csharp")
  addressField?: FieldIdentifier;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PhoneNumberField")
model PhoneNumberField {
  @doc("Property phoneNumberField")
  @clientName("phoneNumberFieldcsharp", "csharp")
  phoneNumberField?: FieldIdentifier;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResponseInspectionBodyContains")
model ResponseInspectionBodyContains {
  @doc("Property failureStrings")
  @extension("x-ms-identifiers", [])
  failureStrings?: string[];

  @doc("Property successStrings")
  @extension("x-ms-identifiers", [])
  successStrings?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResponseInspectionHeader")
model ResponseInspectionHeader {
  @doc("Property failureValues")
  @extension("x-ms-identifiers", [])
  failureValues?: string[];

  @doc("Property name")
  name?: string;

  @doc("Property successValues")
  @extension("x-ms-identifiers", [])
  successValues?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResponseInspectionJson")
model ResponseInspectionJson {
  @doc("Property failureValues")
  @extension("x-ms-identifiers", [])
  failureValues?: string[];

  @doc("Property identifier")
  identifier?: string;

  @doc("Property successValues")
  @extension("x-ms-identifiers", [])
  successValues?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResponseInspectionStatusCode")
model ResponseInspectionStatusCode {
  @doc("Property failureCodes")
  @extension("x-ms-identifiers", [])
  failureCodes?: int32[];

  @doc("Property successCodes")
  @extension("x-ms-identifiers", [])
  successCodes?: int32[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Wafv2WebACLS {
  get is ArmResourceRead<Wafv2WebACL>;
  @doc("Create a Wafv2WebACL. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Wafv2WebACL>;
  update is ArmCustomPatchAsync<
    Wafv2WebACL,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Wafv2WebACL>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Wafv2WebACL>;
  listByResourceGroup is ArmResourceListByParent<Wafv2WebACL>;
  listBySubscription is ArmListBySubscription<Wafv2WebACL>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::WAFv2::WebACL
//--------------------------------------------------------------------------------------------
