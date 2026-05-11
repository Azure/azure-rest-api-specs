import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(Microsoft.AlertsManagement,
  "PreviewAlertRuleMgmtClient",
  "python"
);
@@clientName(Microsoft.AlertsManagement,
  "PreviewAlertRuleManagementClient",
  "javascript"
);
@@clientName(AlertSeverity.`0`, "ZERO", "python");
@@clientName(AlertSeverity.`1`, "ONE", "python");
@@clientName(AlertSeverity.`2`, "TWO", "python");
@@clientName(AlertSeverity.`3`, "THREE", "python");
@@clientName(AlertSeverity.`4`, "FOUR", "python");

@@clientName(AlertSeverity.`0`, "Zero", "go,javascript");
@@clientName(AlertSeverity.`1`, "One", "go,javascript");
@@clientName(AlertSeverity.`2`, "Two", "go,javascript");
@@clientName(AlertSeverity.`3`, "Three", "go,javascript");
@@clientName(AlertSeverity.`4`, "Four", "go,javascript");
@@clientName(Microsoft.AlertsManagement, "Client", "go");

// C# customizations: ensure ops stay on the synthetic operation group so the
// generator can emit a proper client.
@@clientLocation(PreviewAlertRules.previewAlertRule,
  PreviewAlertRules,
  "csharp"
);

// C# customizations: rename AlertSeverity enum members to use Word names since numeric
// names produce illegal identifiers in C# field names.
@@clientName(AlertSeverity.`0`, "Sev0", "csharp");
@@clientName(AlertSeverity.`1`, "Sev1", "csharp");
@@clientName(AlertSeverity.`2`, "Sev2", "csharp");
@@clientName(AlertSeverity.`3`, "Sev3", "csharp");
@@clientName(AlertSeverity.`4`, "Sev4", "csharp");

// C# customizations: rename overly-generic model names so the SDK surface follows
// the `<Resource><Concept>` naming convention used elsewhere in azure-sdk-for-net.
@@clientName(Kind, "LogAlertRuleKind", "csharp");
@@clientName(Evaluation, "RulePreviewEvaluation", "csharp");
@@clientName(EvaluatedPeriod, "RulePreviewEvaluatedPeriod", "csharp");
@@clientName(DimensionNameAndValue,
  "RulePreviewDimensionNameAndValue",
  "csharp"
);

// C# customizations: drop the "Resource" suffix on this body model. The mgmt InheritanceCheck
// test fails for any public type ending with "Resource" that does not derive from ArmResource;
// LogAlertRuleResource is an input/request body model, not an ARM resource.
@@clientName(LogAlertRuleResource, "LogAlertRule", "csharp");

// C# customizations: rename ConditionOperator.Equals to avoid conflict with
// ValueType.Equals(object) on the generated readonly struct.
@@clientName(ConditionOperator.Equals, "EqualTo", "csharp");
