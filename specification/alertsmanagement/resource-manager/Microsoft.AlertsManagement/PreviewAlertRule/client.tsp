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
