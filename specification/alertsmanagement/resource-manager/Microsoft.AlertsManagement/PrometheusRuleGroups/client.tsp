import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.AlertsManagement,
  "PrometheusRuleGroupsMgmtClient",
  "python"
);
@@clientName(Microsoft.AlertsManagement,
  "PrometheusRuleGroupsManagementClient",
  "javascript"
);
