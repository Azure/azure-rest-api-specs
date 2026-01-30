import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(Microsoft.AlertsManagement,
  "PreviewAlertRuleMgmtClient",
  "python"
);
@@clientName(AlertSeverity.`0`, "ZERO", "python");
@@clientName(AlertSeverity.`1`, "ONE", "python");
@@clientName(AlertSeverity.`2`, "TWO", "python");
@@clientName(AlertSeverity.`3`, "THREE", "python");
@@clientName(AlertSeverity.`4`, "FOUR", "python");

@@clientName(AlertSeverity.`0`, "Zero", "go");
@@clientName(AlertSeverity.`1`, "One", "go");
@@clientName(AlertSeverity.`2`, "Two", "go");
@@clientName(AlertSeverity.`3`, "Three", "go");
@@clientName(AlertSeverity.`4`, "Four", "go");
@@clientName(Microsoft.AlertsManagement, "Client", "go");
