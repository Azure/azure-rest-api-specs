import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Management;

@@clientName(ManagementGroupListResult.`@nextLink`, "NextLink");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagementGroupInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateManagementGroupRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureAsyncOperationResults.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DescendantInfo.properties);

@@clientName(HierarchySettingsList.`@nextLink`, "NextLink");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HierarchySettingsInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateOrUpdateSettingsRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EntityInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationResults.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EntityHierarchyItem.properties);

@@clientName(ManagementGroups.createOrUpdate::parameters.resource,
  "createManagementGroupRequest"
);
@@clientName(ManagementGroups.update::parameters.properties,
  "patchGroupRequest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagementGroup.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionUnderManagementGroup.properties);

@@clientName(HierarchySettingsOperationGroup, "HierarchySettings");
@@clientName(HierarchySettingsOperationGroup.createOrUpdate::parameters.resource,
  "CreateTenantSettingsRequest"
);
@@clientName(HierarchySettingsOperationGroup.update::parameters.properties,
  "CreateTenantSettingsRequest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HierarchySettings.properties);
