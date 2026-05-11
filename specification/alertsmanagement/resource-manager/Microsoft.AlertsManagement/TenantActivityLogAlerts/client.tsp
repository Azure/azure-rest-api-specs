import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(Microsoft.AlertsManagement,
  "TenantActivityLogAlertsMgmtClient",
  "python"
);
@@clientName(Microsoft.AlertsManagement,
  "TenantActivityLogAlertsManagementClient",
  "javascript"
);

// C# customizations: keep the operations on the original interface so the synthetic
// "TenantActivityLogAlerts" operation group from back-compatible.tsp does not collide
// with the C# namespace (which would otherwise cause the generator to emit
// `Azure.ResourceManager.TenantActivityLogAlerts._TenantActivityLogAlerts`).
@@clientLocation(TenantActivityLogAlertResources.get,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(TenantActivityLogAlertResources.createOrUpdate,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(TenantActivityLogAlertResources.update,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(TenantActivityLogAlertResources.delete,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(TenantActivityLogAlertResources.listByManagementGroup,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(TenantActivityLogAlertResources.listByTenant,
  TenantActivityLogAlertResources,
  "csharp"
);

// Rename `equals` to avoid collision with `object.Equals` on the generated C# property.
@@clientName(AlertRuleLeafCondition.equals, "equalTo", "csharp");
