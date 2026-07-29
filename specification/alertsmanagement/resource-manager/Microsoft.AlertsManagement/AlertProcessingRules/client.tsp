import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(
  Microsoft.AlertsManagement,
  "AlertProcessingRulesMgmtClient",
  "python"
);
@@clientName(
  Microsoft.AlertsManagement,
  "AlertProcessingRulesManagementClient",
  "javascript"
);

// C# customizations: avoid name collisions with namespace and System.Object.Equals.
@@clientName(
  AlertProcessingRules,
  "AlertProcessingRulesOperationGroup",
  "csharp"
);
@@clientName(Operator.Equals, "EqualsValue", "csharp");

// C# customizations: rename overly generic public types to add resource context for
// readability and to preserve the original Azure.ResourceManager.AlertsManagement names.
@@clientName(Action, "AlertProcessingRuleAction", "csharp");
@@clientName(AddActionGroups, "AlertProcessingRuleAddGroupsAction", "csharp");
@@clientName(
  RemoveAllActionGroups,
  "AlertProcessingRuleRemoveAllGroupsAction",
  "csharp"
);
@@clientName(Condition, "AlertProcessingRuleCondition", "csharp");
@@clientName(Schedule, "AlertProcessingRuleSchedule", "csharp");
@@clientName(Recurrence, "AlertProcessingRuleRecurrence", "csharp");
@@clientName(WeeklyRecurrence, "AlertProcessingRuleWeeklyRecurrence", "csharp");
@@clientName(
  MonthlyRecurrence,
  "AlertProcessingRuleMonthlyRecurrence",
  "csharp"
);
@@clientName(Field, "AlertProcessingRuleField", "csharp");
@@clientName(Operator, "AlertProcessingRuleOperator", "csharp");
@@clientName(DaysOfWeek, "AlertsManagementDayOfWeek", "csharp");

// C# customizations: align property names with the original Azure.ResourceManager.AlertsManagement
// surface (boolean properties used the `IsEnabled` convention).
@@clientName(AlertProcessingRuleProperties.enabled, "IsEnabled", "csharp");
@@clientName(PatchProperties.enabled, "IsEnabled", "csharp");

// common-types v3 types Resource.id as `string`; map to armResourceIdentifier so the C#
// generator emits ResourceIdentifier compatible with TrackedResourceData.
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AddActionGroups.actionGroupIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);

// C# customizations: restore the original date-time / time-of-day types (the spec uses
// `string` because the values are written without timezone suffix; old SDK exposed them
// as DateTimeOffset / TimeSpan).
@@alternateType(Schedule.effectiveFrom, utcDateTime, "csharp");
@@alternateType(Schedule.effectiveUntil, utcDateTime, "csharp");
@@alternateType(Recurrence.startTime, plainTime, "csharp");
@@alternateType(Recurrence.endTime, plainTime, "csharp");
@@clientName(Recurrence.startTime, "startOn", "csharp");
@@clientName(Recurrence.endTime, "endOn", "csharp");
