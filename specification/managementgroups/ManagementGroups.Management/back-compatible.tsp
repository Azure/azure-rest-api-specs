import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Management;

@@clientName(ManagementGroupListResult.`@nextLink`, "NextLink");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagementGroupInfo.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CreateManagementGroupRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureAsyncOperationResults.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DescendantInfo.properties);

@@clientName(HierarchySettingsList.`@nextLink`, "NextLink");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HierarchySettingsInfo.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CreateOrUpdateSettingsRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EntityInfo.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OperationResults.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EntityHierarchyItem.properties);

@@clientName(ManagementGroups.createOrUpdate::parameters.resource,
  "createManagementGroupRequest"
);
@@clientName(ManagementGroups.update::parameters.properties,
  "patchGroupRequest"
);
@@clientLocation(ManagementGroups.list, "HierarchySettings");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagementGroup.properties);

@@clientLocation(SubscriptionUnderManagementGroups.getSubscription,
  "ManagementGroupSubscriptions"
);
@@clientLocation(SubscriptionUnderManagementGroups.create,
  "ManagementGroupSubscriptions"
);
@@clientLocation(SubscriptionUnderManagementGroups.delete,
  "ManagementGroupSubscriptions"
);
@@clientLocation(SubscriptionUnderManagementGroups.getSubscriptionsUnderManagementGroup,
  "ManagementGroupSubscriptions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SubscriptionUnderManagementGroup.properties);

@@clientLocation(HierarchySettingsOperationGroup.get, "HierarchySettings");
@@clientLocation(HierarchySettingsOperationGroup.createOrUpdate,
  "HierarchySettings"
);
@@clientName(HierarchySettingsOperationGroup.createOrUpdate::parameters.resource,
  "CreateTenantSettingsRequest"
);
@@clientLocation(HierarchySettingsOperationGroup.update, "HierarchySettings");
@@clientName(HierarchySettingsOperationGroup.update::parameters.properties,
  "CreateTenantSettingsRequest"
);
@@clientLocation(HierarchySettingsOperationGroup.delete, "HierarchySettings");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HierarchySettings.properties);

@@clientLocation(ManagementGroupsOperationGroup.list, ManagementGroups);

@@clientLocation(EntitiesOperationGroup.list, "Entities");

@@clientName(checkNameAvailability::parameters.body,
  "checkNameAvailabilityRequest"
);
