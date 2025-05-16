// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Maintenance;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ScheduledEventOperationGroup {
  /**
   * Post Scheduled Event Acknowledgement
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  @summary("Post Scheduled Event Acknowledgement")
  @operationId("ScheduledEvent_Acknowledge")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Compute/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/scheduledevents/{scheduledEventId}/acknowledge")
  @post
  acknowledge(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Resource type
     */
    @path
    resourceType: string,

    /**
     * Resource Name
     */
    @path
    resourceName: string,

    /**
     * Scheduled Event Id. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)
     */
    @path
    scheduledEventId: string,
  ): ArmResponse<ScheduledEventApproveResponse> | MaintenanceError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
interface ApplyUpdatesOperationGroup {
  /**
   * Apply maintenance updates to resource with parent
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Apply Updates to resource with parent")
  @operationId("ApplyUpdates_CreateOrUpdateParent")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/applyUpdates/default")
  @put
  createOrUpdateParent(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Resource provider name
     */
    @path
    providerName: string,

    /**
     * Resource parent type
     */
    @path
    resourceParentType: string,

    /**
     * Resource parent identifier
     */
    @path
    resourceParentName: string,

    /**
     * Resource type
     */
    @path
    resourceType: string,

    /**
     * Resource identifier
     */
    @path
    resourceName: string,
  ): ArmResponse<ApplyUpdate> | ArmCreatedResponse<ApplyUpdate> | MaintenanceError;

  /**
   * Apply maintenance updates to resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Apply Updates to resource")
  @operationId("ApplyUpdates_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/applyUpdates/default")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Resource provider name
     */
    @path
    providerName: string,

    /**
     * Resource type
     */
    @path
    resourceType: string,

    /**
     * Resource identifier
     */
    @path
    resourceName: string,
  ): ArmResponse<ApplyUpdate> | ArmCreatedResponse<ApplyUpdate> | MaintenanceError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ApplyUpdateForResourceGroupOperationGroup {
  /**
   * Get Configuration records within a subscription and resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  @summary("Get Configuration records within a subscription and resource group")
  @operationId("ApplyUpdateForResourceGroup_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maintenance/applyUpdates")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
  ): ArmResponse<ListApplyUpdate> | MaintenanceError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
interface ConfigurationAssignmentForResourceGroupOperationGroup {
  /**
   * Get Configuration records within a subscription and resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get Configuration records within a subscription and resource group")
  @operationId("ConfigurationAssignments_List")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Resource provider name
     */
    @path
    providerName: string,

    /**
     * Resource type
     */
    @path
    resourceType: string,

    /**
     * Resource identifier
     */
    @path
    resourceName: string,
  ): ArmResponse<ListConfigurationAssignmentsResult> | MaintenanceError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
interface UpdatesOperationGroup {
  /**
   * Get updates to resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get Updates to resource")
  @operationId("Updates_ListParent")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/updates")
  @get
  listParent(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Resource provider name
     */
    @path
    providerName: string,

    /**
     * Resource parent type
     */
    @path
    resourceParentType: string,

    /**
     * Resource parent identifier
     */
    @path
    resourceParentName: string,

    /**
     * Resource type
     */
    @path
    resourceType: string,

    /**
     * Resource identifier
     */
    @path
    resourceName: string,
  ): ArmResponse<ListUpdatesResult> | MaintenanceError;

  /**
   * Get updates to resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get Updates to resource")
  @operationId("Updates_List")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/updates")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Resource provider name
     */
    @path
    providerName: string,

    /**
     * Resource type
     */
    @path
    resourceType: string,

    /**
     * Resource identifier
     */
    @path
    resourceName: string,
  ): ArmResponse<ListUpdatesResult> | MaintenanceError;
}
