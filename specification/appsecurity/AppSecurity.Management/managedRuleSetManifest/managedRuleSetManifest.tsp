import "../policy/managedRules.tsp";
import "../policy/managedRulesCustomization.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AppSecurity;

// Should be based on:
// 1. https://learn.microsoft.com/en-us/rest/api/application-gateway/application-gateway-waf-dynamic-manifests/get?view=rest-application-gateway-2023-09-01&viewFallbackFrom=rest-application-gateway-2023-06-01&tabs=HTTP
// 2. ManagedRuleSetDefinitionList: https://github.com/Azure/azure-rest-api-specs/blob/700bd7b4e10d2bd83672ee56fd6aedcf7e195a06/specification/frontdoor/resource-manager/Microsoft.Network/stable/2022-05-01/webapplicationfirewall.json#L796C6-L796C34
@doc("Manifest containing the available managed rule sets.")
model AppProtectManagedRuleSetManifestProperties {
  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The version of the manifest.")
  @visibility("read")
  version: string;

  @doc("Default managed rule set ID.")
  @visibility("read")
  defaultRuleSet: ManagedRuleSetId;

  @doc("List of available managed rule set definitions.")
  @visibility("read")
  @extension("x-ms-identifiers", ["ruleSetType", "ruleSetVersion"])
  availableRuleSets: ManagedRuleSetDefinition[];
}
@doc("Definition of managed rule set.")
model ManagedRuleSetDefinition {
  ...ManagedRuleSetId;

  @doc("List of managed rule groups in the rule set.")
  @visibility("read")
  @extension("x-ms-identifiers", ["ruleGroupName"])
  ruleGroups: ManagedRuleGroupDefinition[];
}

@doc("Definition of a managed rule group.")
model ManagedRuleGroupDefinition {
  @doc("The managed rule group name.")
  @visibility("read")
  ruleGroupName: string;

  @doc("Description of the managed rule group.")
  @visibility("read")
  description: string;

  @doc("List of rules within the managed rule group.")
  @visibility("read")
  @extension("x-ms-identifiers", ["ruleId"])
  rules: ManagedRuleDefinition[];
}

@doc("Definition of a managed rule definition.")
model ManagedRuleDefinition {
  @doc("The managed rule ID")
  @visibility("read")
  ruleId: string;

  @doc("Describes the functionality of the managed rule.")
  @visibility("read")
  description: string;

  @doc("Describes the default state for the managed rule.")
  @visibility("read")
  defaultState: EnabledState;

  @doc("Describes the default action to be applied when the managed rule matches.")
  @visibility("read")
  defaultAction: ManagedRuleActionType;
}

// See example of a similar resource (singleton and subscription-level resource) in:
// /azure-rest-api-specs-pr/specification/microsoftinventory/Inventory.Management/resources/subscriptionInternalProperties.tsp

@subscriptionResource
@singleton
@doc("The managed rule set manifest resource definition.")
model AppProtectManagedRuleSetManifest
  is ProxyResource<AppProtectManagedRuleSetManifestProperties> {
  @pattern("^default$")
  @doc("The default managed rule set manifest name")
  @segment("appProtectManagedRuleSetManifests")
  @key("managedRuleSetManifestName")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations
interface AppProtectManagedRuleSetManifests {
  get is ArmResourceRead<AppProtectManagedRuleSetManifest>;
  listByParent is ArmResourceListByParent<AppProtectManagedRuleSetManifest>;
  //   listBySubscription is ArmListBySubscription<ManagedRuleSetManifest>;
}
