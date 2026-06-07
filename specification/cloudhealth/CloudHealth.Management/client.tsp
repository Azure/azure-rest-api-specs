import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.CloudHealth;

@@clientName(Microsoft.CloudHealth, "CloudHealthMgmtClient", "python");

// CSharp
@@clientName(
  AuthenticationSetting,
  "HealthModelAuthenticationSetting",
  "csharp"
);
@@clientName(
  AuthenticationSettingProperties,
  "HealthModelAuthenticationSettingProperties",
  "csharp"
);
@@clientName(DiscoveryRule, "HealthModelDiscoveryRule", "csharp");
@@clientName(
  DiscoveryRuleProperties,
  "HealthModelDiscoveryRuleProperties",
  "csharp"
);
@@clientName(Entity, "HealthModelEntity", "csharp");
@@clientName(EntityProperties, "HealthModelEntityProperties", "csharp");
@@clientName(Relationship, "HealthModelRelationship", "csharp");
@@clientName(
  RelationshipProperties,
  "HealthModelRelationshipProperties",
  "csharp"
);
@@clientName(SignalDefinition, "HealthModelSignalDefinition", "csharp");
@@clientName(
  SignalDefinitionProperties,
  "HealthModelSignalDefinitionProperties",
  "csharp"
);

@@clientName(AlertConfiguration, "EntityAlertConfiguration", "csharp");
@@clientName(AlertSeverity, "EntityAlertSeverity", "csharp");
@@clientName(AuthenticationKind, "HealthModelAuthenticationKind", "csharp");
@@clientName(EvaluationRule, "EntitySignalEvaluationRule", "csharp");
@@clientName(HealthState, "EntityHealthState", "csharp");
@@clientName(ThresholdRule, "EntitySignalThresholdRule", "csharp");
@@clientName(IconDefinition, "EntityIcon", "csharp");
@@clientName(RefreshInterval, "EntitySignalRefreshInterval", "csharp");
@@clientName(SignalAssignment, "EntitySignalAssignment", "csharp");
@@clientName(SignalGroup, "EntitySignalGroup", "csharp");
@@clientName(SignalKind, "EntitySignalKind", "csharp");
@@clientName(SignalOperator, "EntitySignalOperator", "csharp");

@@clientName(SignalOperator.Equals, "EqualsValue", "csharp");

@@clientName(
  DynamicThresholdSensitivity,
  "EntityDynamicThresholdSensitivity",
  "csharp"
);

@@clientName(DataAnnotation, "EntityDataAnnotation", "csharp");
@@clientName(
  GetDataAnnotationsRequest,
  "EntityGetDataAnnotationsContent",
  "csharp"
);
@@clientName(
  GetDataAnnotationsResponse,
  "EntityGetDataAnnotationsResult",
  "csharp"
);
@@clientName(EntityHistoryRequest, "EntityHistoryContent", "csharp");
@@clientName(EntityHistoryResponse, "EntityHistoryResult", "csharp");
@@clientName(SignalHistoryRequest, "EntitySignalHistoryContent", "csharp");
@@clientName(SignalHistoryResponse, "EntitySignalHistoryResult", "csharp");
@@clientName(
  AddDataAnnotationRequest,
  "EntityAddDataAnnotationContent",
  "csharp"
);
@@clientName(
  GetSignalRecommendationsResponse,
  "EntityGetSignalRecommendationsResult",
  "csharp"
);
@@clientName(HealthReportRequest, "EntityHealthReportContent", "csharp");
@@clientName(ThresholdRuleV2, "EntitySignalThresholdRuleV2", "csharp");
@@clientName(ThresholdRuleV2.operator, "SignalOperator", "csharp");
@@clientName(SignalGroups, "EntitySignalGroups", "csharp");
@@clientName(AzureResourceSignal, "ResourceSignal", "csharp");
@@clientName(AzureResourceSignals, "ResourceSignals", "csharp");
@@clientName(AzureMonitorWorkspaceSignals, "MonitorWorkspaceSignals", "csharp");
@@clientName(
  AzureResourceHealthSignalStatus,
  "ResourceHealthSignalStatus",
  "csharp"
);
@@clientName(AzureResourceHealthSignal, "ResourceHealthSignal", "csharp");
@@clientName(
  DependenciesSignalGroupV2.ignoreUnknown,
  "shouldIgnoreUnknown",
  "csharp"
);
@@clientName(LookBackWindow, "DynamicThresholdLookBackWindow", "csharp");

// JavaScript SDK visibility workaround:
// For write operations whose body models contain server-side read-only properties
// that are also required, provide write-specific models that omit those fields so
// JS SDK users are not forced to supply server-computed values.
// Pattern: https://github.com/Azure/azure-rest-api-specs/pull/42784
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Write-only helper models for JS SDK alternate types; operations are defined on the original resources in main.tsp"
namespace Microsoft.CloudHealth {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
  @doc("Discovery rule properties for create/update operations, omitting server-side read-only fields (entityName is required+read-only in the canonical model).")
  model DiscoveryRulePropertiesCreate {
    @doc("Display name")
    @minLength(1)
    @maxLength(260)
    displayName?: string;

    @removed(Versions.v2026_01_01_preview)
    @doc("Azure Resource Graph query text in KQL syntax. The query must return at least a column named 'id' which contains the resource ID of the discovered resources.")
    @minLength(1)
    @maxLength(5000)
    resourceGraphQuery: string;

    @doc("Reference to the name of the authentication setting which is used for querying Azure Resource Graph. The same authentication setting will also be assigned to any discovered entities.")
    authenticationSetting: authenticationSettingName;

    @doc("Whether to create relationships between the discovered entities based on a set of built-in rules. These relationships cannot be manually deleted.")
    discoverRelationships: DiscoveryRuleRelationshipDiscoveryBehavior;

    @doc("Whether to add all recommended signals to the discovered entities.")
    addRecommendedSignals: DiscoveryRuleRecommendedSignalsBehavior;

    @added(Versions.v2026_01_01_preview)
    @doc("Specification of the discovery rule defining how entities are discovered.")
    specification: DiscoveryRuleSpecification;

    @added(Versions.v2026_05_01_preview)
    @doc("Whether to automatically add a signal for the Azure resource's availability state from Azure Resource Health to the discovered entities. Defaults to `Enabled`.")
    addResourceHealthSignal?: ResourceHealthAvailabilityStateSignalBehavior;
  }

  @parentResource(HealthModel)
  @doc("Discovery rule resource for create/update operations.")
  model DiscoveryRuleResourceCreate
    is Azure.ResourceManager.ProxyResource<DiscoveryRulePropertiesCreate> {
    @doc("Name of the discovery rule. Must be unique within a health model.")
    @key("discoveryRuleName")
    @segment("discoveryrules")
    @path
    name: discoveryRuleName;
  }
}

@@alternateType(
  DiscoveryRules.createOrUpdateV1::parameters.resource,
  DiscoveryRuleResourceCreate,
  "javascript"
);
@@alternateType(
  DiscoveryRules.createOrUpdate::parameters.resource,
  DiscoveryRuleResourceCreate,
  "javascript"
);
