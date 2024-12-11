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

//---------------------------------------------- Wafv2LoggingConfigurations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "WAFv2 Logging Configuration",
    plural: "WAFv2 Logging Configurations",
  },
  keywords: ["Microsoft.AwsConnector", "WAFv2", "Logging", "Configuration"],
})
@doc("A Microsoft.AwsConnector resource")
model Wafv2LoggingConfiguration
  is TrackedResource<Wafv2LoggingConfigurationProperties> {
  @doc("Name of Wafv2LoggingConfiguration")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("wafv2LoggingConfigurations")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Wafv2LoggingConfiguration")
model Wafv2LoggingConfigurationProperties {
  @doc("AWS Properties")
  awsProperties?: AwsWafv2LoggingConfigurationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsWafv2LoggingConfiguration")
model AwsWafv2LoggingConfigurationProperties {
  @doc("The Amazon Resource Names (ARNs) of the logging destinations that you want to associate with the web ACL.")
  @extension("x-ms-identifiers", [])
  logDestinationConfigs?: string[];

  @doc("Filtering that specifies which web requests are kept in the logs and which are dropped. You can filter on the rule action and on the web request labels that were applied by matching rules during web ACL evaluation.")
  loggingFilter?: LoggingFilterModelProperties;

  @doc("Indicates whether the logging configuration was created by AWS Firewall Manager, as part of an AWS WAF policy configuration. If true, only Firewall Manager can modify or delete the configuration.")
  managedByFirewallManager?: boolean;

  @doc("The parts of the request that you want to keep out of the logs. For example, if you redact the HEADER field, the HEADER field in the firehose will be xxx.")
  @extension("x-ms-identifiers", [])
  redactedFields?: FieldToMatch[];

  @doc("The Amazon Resource Name (ARN) of the web ACL that you want to associate with LogDestinationConfigs.")
  resourceArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoggingFilterModelProperties")
model LoggingFilterModelProperties {
  @doc("Default handling for logs that don't match any of the specified filtering conditions.")
  defaultBehavior?: DefaultBehavior;

  @doc("The filters that you want to apply to the logs.")
  @extension("x-ms-identifiers", [])
  filters?: Filter[];
}

@doc("DefaultBehavior enum")
union DefaultBehavior {
  @doc("DefaultBehavior enum DROP")
  DROP: "DROP",

  @doc("DefaultBehavior enum KEEP")
  KEEP: "KEEP",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FieldToMatch")
model FieldToMatch {
  @doc("Inspect the HTTP method. The method indicates the type of operation that the request is asking the origin to perform.")
  method?: unknown;

  @doc("Inspect the query string. This is the part of a URL that appears after a ? character, if any.")
  queryString?: unknown;

  @doc("Inspect a single header. Provide the name of the header to inspect, for example, User-Agent or Referer. This setting isn't case sensitive.")
  singleHeader?: SingleHeaderModelProperties;

  @doc("Inspect the request URI path. This is the part of a web request that identifies a resource, for example, /images/daily-ad.jpg.")
  uriPath?: unknown;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Filter")
model Filter {
  @doc("How to handle logs that satisfy the filter's conditions and requirement.")
  behavior?: FilterBehavior;

  @doc("Match conditions for the filter.")
  @extension("x-ms-identifiers", [])
  conditions?: Condition[];

  @doc("Logic to apply to the filtering conditions. You can specify that, in order to satisfy the filter, a log must match all conditions or must match at least one condition.")
  requirement?: FilterRequirement;
}

@doc("FilterBehavior enum")
union FilterBehavior {
  @doc("FilterBehavior enum DROP")
  DROP: "DROP",

  @doc("FilterBehavior enum KEEP")
  KEEP: "KEEP",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SingleHeaderModelProperties")
model SingleHeaderModelProperties {
  @doc("The name of the query header to inspect.")
  name?: string;
}

@doc("FilterRequirement enum")
union FilterRequirement {
  @doc("FilterRequirement enum MEETS_ALL")
  MEETS_ALL: "MEETS_ALL",

  @doc("FilterRequirement enum MEETS_ANY")
  MEETS_ANY: "MEETS_ANY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Condition")
model Condition {
  @doc("A single action condition.")
  actionCondition?: ActionConditionModelProperties;

  @doc("A single label name condition.")
  labelNameCondition?: LabelNameConditionModelProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ActionConditionModelProperties")
model ActionConditionModelProperties {
  @doc("Logic to apply to the filtering conditions. You can specify that, in order to satisfy the filter, a log must match all conditions or must match at least one condition.")
  action?: Action;
}

@doc("Action enum")
union Action {
  @doc("Action enum ALLOW")
  ALLOW: "ALLOW",

  @doc("Action enum BLOCK")
  BLOCK: "BLOCK",

  @doc("Action enum CAPTCHA")
  CAPTCHA: "CAPTCHA",

  @doc("Action enum CHALLENGE")
  CHALLENGE: "CHALLENGE",

  @doc("Action enum COUNT")
  COUNT: "COUNT",

  @doc("Action enum EXCLUDED_AS_COUNT")
  EXCLUDED_AS_COUNT: "EXCLUDED_AS_COUNT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LabelNameConditionModelProperties")
model LabelNameConditionModelProperties {
  @doc("The label name that a log record must contain in order to meet the condition. This must be a fully qualified label name. Fully qualified labels have a prefix, optional namespaces, and label name. The prefix identifies the rule group or web ACL context of the rule that added the label.")
  labelName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Wafv2LoggingConfigurations {
  get is ArmResourceRead<Wafv2LoggingConfiguration>;
  @doc("Create a Wafv2LoggingConfiguration. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Wafv2LoggingConfiguration>;
  update is ArmCustomPatchAsync<
    Wafv2LoggingConfiguration,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Wafv2LoggingConfiguration>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Wafv2LoggingConfiguration>;
  listByResourceGroup is ArmResourceListByParent<Wafv2LoggingConfiguration>;
  listBySubscription is ArmListBySubscription<Wafv2LoggingConfiguration>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::WAFv2::LoggingConfiguration
//--------------------------------------------------------------------------------------------
