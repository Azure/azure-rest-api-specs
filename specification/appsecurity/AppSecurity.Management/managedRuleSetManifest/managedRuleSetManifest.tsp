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
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The version of the manifest.")
  @visibility("read")
  version: string;

  @doc("Defines the default managed rule sets for all supported pillar types.")
  @visibility("read")
  @extension("x-ms-identifiers", ["pillarType"])
  defaultRuleSets: PillarTypeDefaultRuleSet[];

  @doc("List of available managed rule set definitions.")
  @visibility("read")
  @extension("x-ms-identifiers", ["ruleSetType", "ruleSetVersion"])
  availableRuleSets: ManagedRuleSetDefinition[];
}

@doc("Defines the default managed rule set of a pillar type.")
model PillarTypeDefaultRuleSet {
  @doc("The pillar type.")
  pillarType: PillarType;

  @doc("The default rule set of the specified pillar type.")
  defaultRuleSet: ManagedRuleSetId;
}

@doc("Definition of managed rule set.")
model ManagedRuleSetDefinition {
  ...ManagedRuleSetId;

  @doc("List of managed rule groups in the rule set.")
  @visibility("read")
  @extension("x-ms-identifiers", ["ruleGroupName"])
  ruleGroups: ManagedRuleGroupDefinition[];

  @doc("Define the rule set pillar type")
  pillarType: PillarType;

  @doc("Define the supported actions for the rule set.")
  supportedActions: ManagedRuleActionType[];

  @doc("Define the default action for the rule set.")
  defaultAction: ManagedRuleActionType;

  @doc("Describes the anomaly scoring default configuration, where it is a supported action.")
  @visibility("read")
  anomalyScoring?: AnomalyScoringDefaultConfiguration;
}

@doc("Defines a managed rule set pillar type")
union PillarType {
  string,

  @doc("Defines the web pillar type")
  Web: "Web",

  @doc("Defines the bot pillar type")
  Bot: "Bot",

  @doc("Defines the api pillar type")
  Api: "Api",

  @doc("Defines the DDoS pillar type")
  Ddos: "Ddos",
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

  @doc("The default severity level assigned to a rule in anomaly scoring mode. Required for managed rules that support the anomaly scoring action type. When a rule matches, this severity value is added to the total anomaly score.")
  @visibility("read")
  defaultAnomalyScoringSeverity?: AnomalyScoringSeverity;
}

@doc("The set of supported severity levels for anomaly scoring, representing the importance and impact of a rule match. Each level corresponds to a default anomaly score added when a rule matches.")
union AnomalyScoringSeverity {
  int32,

  @doc("Represents a critical severity level. Indicates severe anomalies that require immediate attention and contribute significantly to the anomaly score.")
  CRITICAL: 5,

  @doc("Represents an error severity level. Indicates significant issues that need prompt resolution and contribute notably to the anomaly score.")
  ERROR: 4,

  @doc("Represents a warning severity level. Indicates potential issues that should be monitored and contribute moderately to the anomaly score.")
  WARNING: 3,

  @doc("Represents a notice severity level. Indicates minor issues or informational messages that contribute minimally to the anomaly score.")
  NOTICE: 2,
}

@doc("Defines default configuration for anomaly scoring mode.")
model AnomalyScoringDefaultConfiguration {
  @doc("The default threshold for anomaly scoring. If anomaly scoring is enabled, this value determines the threshold score. When the calculated score exceeds this value, the specified anomaly scoring action will be applied.")
  @visibility("read")
  defaultThreshold: int32;

  @doc("The default action to be triggered when the anomaly scoring threshold is exceeded. This action defines how the system responds to detected anomalies.")
  @visibility("read")
  defaultAction: AnomalyScoringActionType;
}

@doc("Defines the set of supported actions that can be triggered when anomaly scoring exceeds the threshold.")
union AnomalyScoringActionType {
  string,

  @doc("Allow the request")
  Allow: "Allow",

  @doc("Block the request")
  Block: "Block",

  @doc("Log the request and allow it")
  Log: "Log",
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
