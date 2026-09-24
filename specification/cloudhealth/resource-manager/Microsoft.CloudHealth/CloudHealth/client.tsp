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
@@clientName(AggregationType, "HealthStateAggregationType", "csharp");
@@clientName(AggregationUnit, "HealthStateAggregationUnit", "csharp");
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
  SignalAggregationGroup.ignoreUnknown,
  "shouldIgnoreUnknown",
  "csharp"
);
@@clientName(
  DependenciesSignalGroupV2.ignoreUnknown,
  "shouldIgnoreUnknown",
  "csharp"
);
@@clientName(LookBackWindow, "DynamicThresholdLookBackWindow", "csharp");
