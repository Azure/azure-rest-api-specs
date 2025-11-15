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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ScheduledEventOperationGroup {
  /**
   * Post Scheduled Event Acknowledgement
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Post Scheduled Event Acknowledgement")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ApplyUpdatesOperationGroup {
  /**
   * Apply maintenance updates to resource with parent
   */
  @summary("Apply Updates to resource with parent")
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
  @summary("Apply Updates to resource")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ApplyUpdateForResourceGroupOperationGroup {
  /**
   * Get Configuration records within a subscription and resource group
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get Configuration records within a subscription and resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maintenance/applyUpdates")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
  ): ArmResponse<ListApplyUpdate> | MaintenanceError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ConfigurationAssignmentForResourceGroupOperationGroup {
  /**
   * Get Configuration records within a subscription and resource group
   */
  @summary("Get Configuration records within a subscription and resource group")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments")
  @get
  @list
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface UpdatesOperationGroup {
  /**
   * Get updates to resources.
   */
  @summary("Get Updates to resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/updates")
  @get
  @list
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
  @summary("Get Updates to resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/updates")
  @get
  @list
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
