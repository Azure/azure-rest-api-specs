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
