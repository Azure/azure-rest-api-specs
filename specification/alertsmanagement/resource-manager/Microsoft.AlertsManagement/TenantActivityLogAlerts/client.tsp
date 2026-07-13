import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(
  Microsoft.AlertsManagement,
  "TenantActivityLogAlertsMgmtClient",
  "python"
);
@@clientName(
  Microsoft.AlertsManagement,
  "TenantActivityLogAlertsManagementClient",
  "javascript"
);

// C# customizations: keep the operations on the original interface so the synthetic
// "TenantActivityLogAlerts" operation group from back-compatible.tsp does not collide
// with the C# namespace (which would otherwise cause the generator to emit
// `Azure.ResourceManager.TenantActivityLogAlerts._TenantActivityLogAlerts`).
@@clientLocation(
  TenantActivityLogAlertResources.get,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(
  TenantActivityLogAlertResources.createOrUpdate,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(
  TenantActivityLogAlertResources.update,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(
  TenantActivityLogAlertResources.delete,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(
  TenantActivityLogAlertResources.listByManagementGroup,
  TenantActivityLogAlertResources,
  "csharp"
);
@@clientLocation(
  TenantActivityLogAlertResources.listByTenant,
  TenantActivityLogAlertResources,
  "csharp"
);

// Drop the `Resource` infix from the generated *Data/*Collection names while keeping
// the ArmResource class as TenantActivityLogAlertResource. The generator derives the
// data/collection names from the resource model name; renaming the model to
// "TenantActivityLogAlert" for C# yields TenantActivityLogAlertData /
// TenantActivityLogAlertCollection while the ArmResource class is auto-suffixed back to
// TenantActivityLogAlertResource. Aligns with sibling Azure.ResourceManager.AlertsManagement
// naming (AlertProcessingRuleData / AlertProcessingRuleCollection / AlertProcessingRuleResource).
@@clientName(
  TenantActivityLogAlertResource,
  "TenantActivityLogAlert",
  "csharp"
);

// Add service/resource context to the otherwise generic public model names.
// Aligns with sibling Azure.ResourceManager.Monitor models
// (ActivityLogAlertActionGroup / ActivityLogAlertAnyOfOrLeafCondition / ActivityLogAlertLeafCondition).
@@clientName(ActionGroup, "TenantActivityLogAlertActionGroup", "csharp");
@@clientName(
  AlertRuleLeafCondition,
  "TenantActivityLogAlertLeafCondition",
  "csharp"
);
@@clientName(
  AlertRuleAnyOfOrLeafCondition,
  "TenantActivityLogAlertAnyOfOrLeafCondition",
  "csharp"
);

// Boolean property naming: prefer the `Is*` prefix per Azure SDK guidelines
// (matches Azure.ResourceManager.Monitor.ActivityLogAlertData.IsEnabled).
@@clientName(AlertRuleProperties.enabled, "isEnabled", "csharp");
@@clientName(TenantAlertRulePatchProperties.enabled, "isEnabled", "csharp");

// Strongly-type ARM-shaped properties for the C# surface.
// TYPE003: Location should be Azure.Core.AzureLocation, not string.
@@alternateType(
  TenantActivityLogAlertResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
// TYPE001: ActionGroupId carries an ARM resource id; expose as ResourceIdentifier.
@@alternateType(
  ActionGroup.actionGroupId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Rename `equals` to avoid collision with `object.Equals` on the generated C# property.
@@clientName(AlertRuleLeafCondition.equals, "EqualTo", "csharp");
