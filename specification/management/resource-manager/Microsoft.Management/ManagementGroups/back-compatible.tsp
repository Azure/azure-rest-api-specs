import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";

using Azure.ClientGenerator.Core;
using Microsoft.Management;
using Http;
using Rest;

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

@@clientName(
  ManagementGroups.createOrUpdate::parameters.resource,
  "createManagementGroupRequest"
);
@@clientName(
  ManagementGroups.update::parameters.properties,
  "patchGroupRequest"
);
@@clientLocation(ManagementGroups.list, "HierarchySettings");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagementGroup.properties);

@@clientLocation(
  SubscriptionUnderManagementGroups.getSubscription,
  "ManagementGroupSubscriptions"
);
@@clientLocation(
  SubscriptionUnderManagementGroups.create,
  "ManagementGroupSubscriptions"
);
@@clientLocation(
  SubscriptionUnderManagementGroups.delete,
  "ManagementGroupSubscriptions"
);
@@clientLocation(
  SubscriptionUnderManagementGroups.getSubscriptionsUnderManagementGroup,
  "ManagementGroupSubscriptions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SubscriptionUnderManagementGroup.properties);

@@clientLocation(HierarchySettingsOperationGroup.get, "HierarchySettings");
@@clientLocation(
  HierarchySettingsOperationGroup.createOrUpdate,
  "HierarchySettings"
);
@@clientName(
  HierarchySettingsOperationGroup.createOrUpdate::parameters.resource,
  "CreateTenantSettingsRequest"
);
@@clientLocation(HierarchySettingsOperationGroup.update, "HierarchySettings");
@@clientName(
  HierarchySettingsOperationGroup.update::parameters.properties,
  "CreateTenantSettingsRequest"
);
@@clientLocation(HierarchySettingsOperationGroup.delete, "HierarchySettings");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HierarchySettings.properties);

@@clientLocation(ManagementGroupsOperationGroup.list, ManagementGroups);

@@clientLocation(EntitiesOperationGroup.list, "Entities");

@@clientName(
  checkNameAvailability::parameters.body,
  "checkNameAvailabilityRequest"
);

// Customization to make subscriptionId a method parameter instead of the default client level parameter.
@@override(
  SubscriptionUnderManagementGroups.getSubscription,
  reorderParameters(
    replaceParameter(
      SubscriptionUnderManagementGroups.getSubscription,
      "subscriptionId",
      GetSubscriptionId.subscriptionId
    ),
    #[
      "extensionProvider",
      "groupId",
      "subscriptionId",
      "apiVersion",
      "Cache-Control"
    ]
  )
);

@@override(
  SubscriptionUnderManagementGroups.create,
  reorderParameters(
    replaceParameter(
      SubscriptionUnderManagementGroups.create,
      "subscriptionId",
      PutSubscriptionId.subscriptionId
    ),
    #[
      "extensionProvider",
      "groupId",
      "subscriptionId",
      "apiVersion",
      "Cache-Control",
      "resource"
    ]
  )
);

@@override(
  SubscriptionUnderManagementGroups.delete,
  reorderParameters(
    replaceParameter(
      SubscriptionUnderManagementGroups.delete,
      "subscriptionId",
      DeleteSubscriptionId.subscriptionId
    ),
    #[
      "extensionProvider",
      "groupId",
      "subscriptionId",
      "apiVersion",
      "Cache-Control"
    ]
  )
);

@@clientLocation(
  GetSubscriptionId.subscriptionId,
  SubscriptionUnderManagementGroups.getSubscription
);

@@clientLocation(
  PutSubscriptionId.subscriptionId,
  SubscriptionUnderManagementGroups.create
);

@@clientLocation(
  DeleteSubscriptionId.subscriptionId,
  SubscriptionUnderManagementGroups.delete
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For customization only."
model SubscriptionIdParameter {
  /** The subscription ID. */
  @path
  @minLength(1)
  @segment("subscriptions")
  subscriptionId: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For customization only."
model GetSubscriptionId is SubscriptionIdParameter;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For customization only."
model PutSubscriptionId is SubscriptionIdParameter;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For customization only."
model DeleteSubscriptionId is SubscriptionIdParameter;
