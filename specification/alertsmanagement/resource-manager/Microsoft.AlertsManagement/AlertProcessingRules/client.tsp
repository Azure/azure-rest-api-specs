import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.AlertsManagement,
  "AlertProcessingRulesMgmtClient",
  "python"
);
@@clientName(Microsoft.AlertsManagement,
  "AlertProcessingRulesManagementClient",
  "javascript"
);

// C# customizations: avoid name collisions with namespace and System.Object.Equals.
@@clientName(Microsoft.AlertsManagement.AlertProcessingRules,
  "AlertProcessingRulesOperationGroup",
  "csharp"
);
@@clientName(Microsoft.AlertsManagement.Operator.Equals, "EqualTo", "csharp");
@@clientName(Microsoft.AlertsManagement.Operator.NotEquals, "NotEqualTo", "csharp");

// C# customizations: rename overly generic public types to add resource context for
// readability and to preserve the original Azure.ResourceManager.AlertsManagement names.
@@clientName(Microsoft.AlertsManagement.Action, "AlertProcessingRuleAction", "csharp");
@@clientName(Microsoft.AlertsManagement.AddActionGroups,
  "AlertProcessingRuleAddGroupsAction",
  "csharp"
);
@@clientName(Microsoft.AlertsManagement.RemoveAllActionGroups,
  "AlertProcessingRuleRemoveAllGroupsAction",
  "csharp"
);
@@clientName(Microsoft.AlertsManagement.Condition, "AlertProcessingRuleCondition", "csharp");
@@clientName(Microsoft.AlertsManagement.Schedule, "AlertProcessingRuleSchedule", "csharp");
@@clientName(Microsoft.AlertsManagement.Recurrence, "AlertProcessingRuleRecurrence", "csharp");
@@clientName(Microsoft.AlertsManagement.WeeklyRecurrence,
  "AlertProcessingRuleWeeklyRecurrence",
  "csharp"
);
@@clientName(Microsoft.AlertsManagement.MonthlyRecurrence,
  "AlertProcessingRuleMonthlyRecurrence",
  "csharp"
);
@@clientName(Microsoft.AlertsManagement.Field, "AlertProcessingRuleField", "csharp");
@@clientName(Microsoft.AlertsManagement.Operator, "AlertProcessingRuleOperator", "csharp");
@@clientName(Microsoft.AlertsManagement.DaysOfWeek, "AlertsManagementDayOfWeek", "csharp");

// common-types v3 types Resource.id as `string`; map to armResourceIdentifier so the C#
// generator emits ResourceIdentifier compatible with TrackedResourceData.
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
