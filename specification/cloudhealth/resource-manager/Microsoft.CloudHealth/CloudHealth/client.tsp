import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.CloudHealth;

@@clientName(Microsoft.CloudHealth, "CloudHealthMgmt", "python");

// CSharp
@@clientName(AuthenticationSetting,
  "HealthModelAuthenticationSetting",
  "csharp"
);
@@clientName(AuthenticationSettingProperties,
  "HealthModelAuthenticationSettingProperties",
  "csharp"
);
@@clientName(DiscoveryRule, "HealthModelDiscoveryRule", "csharp");
@@clientName(DiscoveryRuleProperties,
  "HealthModelDiscoveryRuleProperties",
  "csharp"
);
@@clientName(Entity, "HealthModelEntity", "csharp");
@@clientName(EntityProperties, "HealthModelEntityProperties", "csharp");
@@clientName(Relationship, "HealthModelRelationship", "csharp");
@@clientName(RelationshipProperties,
  "HealthModelRelationshipProperties",
  "csharp"
);
@@clientName(SignalDefinition, "HealthModelSignalDefinition", "csharp");
@@clientName(SignalDefinitionProperties,
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
