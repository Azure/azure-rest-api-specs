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

// Customization to make subscriptionId a method parameter instead of the default client level parameter.
@@override(SubscriptionUnderManagementGroups.getSubscription,
  getSubscriptionCustomized
);
@@override(SubscriptionUnderManagementGroups.create, putSubscriptionCustomized);
@@override(SubscriptionUnderManagementGroups.delete,
  deleteSubscriptionCustomized
);

@@clientLocation(GetSubscriptionId.subscriptionId, getSubscriptionCustomized);
@@clientLocation(PutSubscriptionId.subscriptionId, putSubscriptionCustomized);
@@clientLocation(DeleteSubscriptionId.subscriptionId,
  deleteSubscriptionCustomized
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

/**
 * Retrieves details about given subscription which is associated with the management group.
 *
 */
@get
op getSubscriptionCustomized is Azure.ResourceManager.Foundations.ArmReadOperation<
  Azure.ResourceManager.Extension.ExtensionProviderNamespace<SubscriptionUnderManagementGroup> & {
    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    groupId: string;
  } & GetSubscriptionId &
    Azure.ResourceManager.ApiVersionParameter & {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    },
  Azure.ResourceManager.ArmResponse<Microsoft.Management.SubscriptionUnderManagementGroup>,
  Azure.ResourceManager.CommonTypes.ErrorResponse
>;

/**
 * Associates existing subscription with the management group.
 *
 */
@put
op putSubscriptionCustomized is Azure.ResourceManager.Legacy.CreateOperation<
  Azure.ResourceManager.Extension.ExtensionProviderNamespace<SubscriptionUnderManagementGroup> & {
    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    groupId: string;
  } & PutSubscriptionId &
    Azure.ResourceManager.ApiVersionParameter & {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    },
  void,
  Azure.ResourceManager.ArmResourceUpdatedResponse<Microsoft.Management.SubscriptionUnderManagementGroup>,
  Azure.ResourceManager.CommonTypes.ErrorResponse
>;

/**
 * De-associates subscription from the management group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For overriding with custom operation."
@delete
op deleteSubscriptionCustomized is SubscriptionUnderManagementGroupOperations.ArmDeleteOperation<
  Azure.ResourceManager.Extension.ExtensionProviderNamespace<SubscriptionUnderManagementGroup> & {
    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    groupId: string;
  } & DeleteSubscriptionId &
    Azure.ResourceManager.ApiVersionParameter & {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    },
  Azure.ResourceManager.ArmDeletedResponse,
  Azure.ResourceManager.CommonTypes.ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For customization only."
interface SubscriptionUnderManagementGroupOperations {
  /**
   * @dev The base template for Azure Resource Manager DELETE Operations.
   * @template Parameters The parameter object for the operation.
   * @template Response The response or union of responses for success.
   * @template ErrorResponse The error response.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
  @Azure.ResourceManager.armResourceDelete(SubscriptionUnderManagementGroup)
  ArmDeleteOperation<
    Parameters extends {},
    Response extends {},
    ErrorResponse extends {}
  >(...Parameters): Response | ErrorResponse;
}
