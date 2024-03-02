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

//---------------------------------------------- NetworkFirewallFirewallPolicies ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
@doc("Definition of NetworkFirewallFirewallPolicy")
model NetworkFirewallFirewallPolicyProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsNetworkFirewallFirewallPolicyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsNetworkFirewallFirewallPolicy")
model AwsNetworkFirewallFirewallPolicyProperties {
  @doc("Gets and sets the property description.")
  description?: string;

  @doc("Gets and sets the property firewallPolicy.")
  firewallPolicy?: FirewallPolicy;

  @doc("Gets and sets the property firewallPolicyArn. A resource ARN.")
  firewallPolicyArn?: string;

  @doc("Gets and sets the property firewallPolicyId.")
  firewallPolicyId?: string;

  @doc("Gets and sets the property firewallPolicyName.")
  firewallPolicyName?: string;

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of FirewallPolicy")
model FirewallPolicy {
  @doc("Gets and sets the property policyVariables.")
  policyVariables?: RuleVariablesModel;

  @doc("Gets and sets the property statefulDefaultActions.")
  @extension("x-ms-identifiers", [])
  statefulDefaultActions?: string[];

  @doc("Gets and sets the property statefulEngineOptions.")
  statefulEngineOptions?: StatefulEngineOptions;

  @doc("Gets and sets the property statefulRuleGroupReferences.")
  @extension("x-ms-identifiers", [])
  statefulRuleGroupReferences?: StatefulRuleGroupReference[];

  @doc("Gets and sets the property statelessCustomActions.")
  @extension("x-ms-identifiers", [])
  statelessCustomActions?: CustomAction[];

  @doc("Gets and sets the property statelessDefaultActions.")
  @extension("x-ms-identifiers", [])
  statelessDefaultActions?: string[];

  @doc("Gets and sets the property statelessFragmentDefaultActions.")
  @extension("x-ms-identifiers", [])
  statelessFragmentDefaultActions?: string[];

  @doc("Gets and sets the property statelessRuleGroupReferences.")
  @extension("x-ms-identifiers", [])
  statelessRuleGroupReferences?: StatelessRuleGroupReference[];

  @doc("Gets and sets the property tlsInspectionConfigurationArn. A resource ARN.")
  tlsInspectionConfigurationArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RuleVariables")
model RuleVariablesModel {
  @doc("Gets and sets the property ruleVariables.")
  @projectedName("csharp", "ruleVariablescsharp")
  ruleVariables?: Record<IPSet>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of StatefulEngineOptions")
model StatefulEngineOptions {
  @doc("Gets and sets the property ruleOrder.")
  ruleOrder?: string;

  @doc("Gets and sets the property streamExceptionPolicy.")
  streamExceptionPolicy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of StatefulRuleGroupReference")
model StatefulRuleGroupReference {
  @doc("Gets and sets the property override.")
  override?: StatefulRuleGroupOverride;

  @doc("Gets and sets the property priority.")
  priority?: int32;

  @doc("Gets and sets the property resourceArn. A resource ARN.")
  resourceArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of CustomAction")
model CustomAction {
  @doc("Gets and sets the property actionDefinition.")
  actionDefinition?: ActionDefinition;

  @doc("Gets and sets the property actionName.")
  actionName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of StatelessRuleGroupReference")
model StatelessRuleGroupReference {
  @doc("Gets and sets the property priority.")
  priority?: int32;

  @doc("Gets and sets the property resourceArn. A resource ARN.")
  resourceArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of IPSet")
model IPSet {
  @doc("Gets and sets the property definition.")
  @extension("x-ms-identifiers", [])
  definition?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of StatefulRuleGroupOverride")
model StatefulRuleGroupOverride {
  @doc("Gets and sets the property action.")
  action?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ActionDefinition")
model ActionDefinition {
  @doc("Gets and sets the property publishMetricAction.")
  publishMetricAction?: PublishMetricAction;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of PublishMetricAction")
model PublishMetricAction {
  @doc("Gets and sets the property dimensions.")
  @extension("x-ms-identifiers", [])
  dimensions?: Dimension[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Dimension")
model Dimension {
  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface NetworkFirewallFirewallPolicies {
  get is ArmResourceRead<NetworkFirewallFirewallPolicy>;
  @doc("Create a NetworkFirewallFirewallPolicy. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkFirewallFirewallPolicy>;
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
