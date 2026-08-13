import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TenantActionGroups;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActionGroupPatchBody.properties);

@@clientLocation(TenantActionGroupResources.get, "TenantActionGroups");
@@clientLocation(
  TenantActionGroupResources.createOrUpdate,
  "TenantActionGroups"
);
@@clientName(
  TenantActionGroupResources.createOrUpdate::parameters.resource,
  "actionGroup"
);
@@clientLocation(TenantActionGroupResources.update, "TenantActionGroups");
@@clientName(
  TenantActionGroupResources.update::parameters.properties,
  "tenantActionGroupPatch"
);
@@clientLocation(TenantActionGroupResources.delete, "TenantActionGroups");
@@clientLocation(
  TenantActionGroupResources.listByManagementGroupId,
  "TenantActionGroups"
);
@@clientName(
  createNotificationsAtTenantActionGroupResourceLevel::parameters.body,
  "notificationRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TenantActionGroupResource.properties);
