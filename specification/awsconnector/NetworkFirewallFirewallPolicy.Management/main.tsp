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

//---------------------------------------------- NetworkFirewallFirewallPolicies ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Network Firewall Firewall Policy",
    plural: "Network Firewall Firewall Policies",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Network",
    "Firewall",
    "Firewall",
    "Policy"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model NetworkFirewallFirewallPolicy
  is TrackedResource<NetworkFirewallFirewallPolicyProperties> {
  @doc("Name of NetworkFirewallFirewallPolicy")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("networkFirewallFirewallPolicies")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkFirewallFirewallPolicy")
model NetworkFirewallFirewallPolicyProperties {
  @doc("AWS Properties")
  awsProperties?: AwsNetworkFirewallFirewallPolicyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsNetworkFirewallFirewallPolicy")
model AwsNetworkFirewallFirewallPolicyProperties {
  @doc("Property description")
  description?: string;

  @doc("Property firewallPolicy")
  firewallPolicy?: FirewallPolicy;

  @doc("A resource ARN.")
  firewallPolicyArn?: string;

  @doc("Property firewallPolicyId")
  firewallPolicyId?: string;

  @doc("Property firewallPolicyName")
  firewallPolicyName?: string;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FirewallPolicy")
model FirewallPolicy {
  @doc("Property policyVariables")
  policyVariables?: RuleVariablesModel;

  @doc("Property statefulDefaultActions")
  @extension("x-ms-identifiers", [])
  statefulDefaultActions?: string[];

  @doc("Property statefulEngineOptions")
  statefulEngineOptions?: StatefulEngineOptions;

  @doc("Property statefulRuleGroupReferences")
  @extension("x-ms-identifiers", [])
  statefulRuleGroupReferences?: StatefulRuleGroupReference[];

  @doc("Property statelessCustomActions")
  @extension("x-ms-identifiers", [])
  statelessCustomActions?: CustomAction[];

  @doc("Property statelessDefaultActions")
  @extension("x-ms-identifiers", [])
  statelessDefaultActions?: string[];

  @doc("Property statelessFragmentDefaultActions")
  @extension("x-ms-identifiers", [])
  statelessFragmentDefaultActions?: string[];

  @doc("Property statelessRuleGroupReferences")
  @extension("x-ms-identifiers", [])
  statelessRuleGroupReferences?: StatelessRuleGroupReference[];

  @doc("A resource ARN.")
  tlsInspectionConfigurationArn?: string;
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
@doc("Definition of RuleVariables")
model RuleVariablesModel {
  @doc("Property ruleVariables")
  @clientName("ruleVariablescsharp", "csharp")
  ruleVariables?: Record<IPSet>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatefulEngineOptions")
model StatefulEngineOptions {
  @doc("Property ruleOrder")
  ruleOrder?: StatefulEngineOptionsRuleOrder;

  @doc("Property streamExceptionPolicy")
  streamExceptionPolicy?: StatefulEngineOptionsStreamExceptionPolicy;
}

@doc("StatefulEngineOptionsRuleOrder enum")
union StatefulEngineOptionsRuleOrder {
  @doc("StatefulEngineOptionsRuleOrder enum DEFAULT_ACTION_ORDER")
  DEFAULT_ACTION_ORDER: "DEFAULT_ACTION_ORDER",

  @doc("StatefulEngineOptionsRuleOrder enum STRICT_ORDER")
  STRICT_ORDER: "STRICT_ORDER",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatefulRuleGroupReference")
model StatefulRuleGroupReference {
  @doc("Property override")
  override?: StatefulRuleGroupOverride;

  @doc("Property priority")
  priority?: int32;

  @doc("A resource ARN.")
  resourceArn?: string;
}

@doc("StatefulEngineOptionsStreamExceptionPolicy enum")
union StatefulEngineOptionsStreamExceptionPolicy {
  @doc("StatefulEngineOptionsStreamExceptionPolicy enum CONTINUE")
  CONTINUE: "CONTINUE",

  @doc("StatefulEngineOptionsStreamExceptionPolicy enum DROP")
  DROP: "DROP",

  @doc("StatefulEngineOptionsStreamExceptionPolicy enum REJECT")
  REJECT: "REJECT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomAction")
model CustomAction {
  @doc("Property actionDefinition")
  actionDefinition?: ActionDefinition;

  @doc("Property actionName")
  actionName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatelessRuleGroupReference")
model StatelessRuleGroupReference {
  @doc("Property priority")
  priority?: int32;

  @doc("A resource ARN.")
  resourceArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IPSet")
model IPSet {
  @doc("Property definition")
  @extension("x-ms-identifiers", [])
  definition?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StatefulRuleGroupOverride")
model StatefulRuleGroupOverride {
  @doc("Property action")
  action?: StatefulRuleGroupOverrideAction;
}

@doc("StatefulRuleGroupOverrideAction enum")
union StatefulRuleGroupOverrideAction {
  @doc("StatefulRuleGroupOverrideAction enum DROP_TO_ALERT")
  DROP_TO_ALERT: "DROP_TO_ALERT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ActionDefinition")
model ActionDefinition {
  @doc("Property publishMetricAction")
  publishMetricAction?: PublishMetricAction;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PublishMetricAction")
model PublishMetricAction {
  @doc("Property dimensions")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Dimension")
model Dimension {
  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface NetworkFirewallFirewallPolicies {
  get is ArmResourceRead<NetworkFirewallFirewallPolicy>;
  @doc("Create a NetworkFirewallFirewallPolicy. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<NetworkFirewallFirewallPolicy>;
  update is ArmCustomPatchAsync<
    NetworkFirewallFirewallPolicy,
    Azure.ResourceManager.Foundations.TagsUpdateModel<NetworkFirewallFirewallPolicy>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFirewallFirewallPolicy>;
  listByResourceGroup is ArmResourceListByParent<NetworkFirewallFirewallPolicy>;
  listBySubscription is ArmListBySubscription<NetworkFirewallFirewallPolicy>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::NetworkFirewall::FirewallPolicy
//--------------------------------------------------------------------------------------------
