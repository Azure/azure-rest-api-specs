import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TenantAlertRulePatchObject.properties);

@@clientLocation(TenantActivityLogAlertResources.get,
  "TenantActivityLogAlerts"
);
@@clientLocation(TenantActivityLogAlertResources.createOrUpdate,
  "TenantActivityLogAlerts"
);
@@clientName(TenantActivityLogAlertResources.createOrUpdate::parameters.resource,
  "tenantActivityLogAlertRule"
);
@@clientLocation(TenantActivityLogAlertResources.update,
  "TenantActivityLogAlerts"
);
@@clientName(TenantActivityLogAlertResources.update::parameters.properties,
  "tenantActivityLogAlertRulePatch"
);
@@clientLocation(TenantActivityLogAlertResources.delete,
  "TenantActivityLogAlerts"
);
@@clientLocation(TenantActivityLogAlertResources.listByManagementGroup,
  "TenantActivityLogAlerts"
);
@@clientLocation(TenantActivityLogAlertResources.listByTenant,
  "TenantActivityLogAlerts"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TenantActivityLogAlertResource.properties);
