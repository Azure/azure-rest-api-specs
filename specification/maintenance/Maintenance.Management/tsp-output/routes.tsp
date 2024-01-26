import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Maintenance;

interface ConfigurationAssignmentsOperations {
  /**
   * Get configuration assignment for resource..
   */
  @summary("Get configuration assignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @get
  getParent is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource parent type
       */
      @path
      resourceParentType: string;

      /**
       * Resource parent identifier
       */
      @path
      resourceParentName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;

      /**
       * Configuration assignment name
       */
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment
  >;

  /**
   * Register configuration for resource.
   */
  @summary("Create configuration assignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @put
  createOrUpdateParent is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource parent type
       */
      @path
      resourceParentType: string;

      /**
       * Resource parent identifier
       */
      @path
      resourceParentName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;

      /**
       * Configuration assignment name
       */
      @path
      configurationAssignmentName: string;

      /**
       * The configurationAssignment
       */
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  /**
   * Unregister configuration for resource.
   */
  @summary("Unregister configuration for resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @delete
  deleteParent is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource parent type
       */
      @path
      resourceParentType: string;

      /**
       * Resource parent identifier
       */
      @path
      resourceParentName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;

      /**
       * Unique configuration assignment name
       */
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment | void
  >;

  /**
   * Get configuration assignment for resource..
   */
  @summary("Get configuration assignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;

      /**
       * Configuration assignment name
       */
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment
  >;

  /**
   * Register configuration for resource.
   */
  @summary("Create configuration assignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;

      /**
       * Configuration assignment name
       */
      @path
      configurationAssignmentName: string;

      /**
       * The configurationAssignment
       */
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  /**
   * Unregister configuration for resource.
   */
  @summary("Unregister configuration for resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;

      /**
       * Unique configuration assignment name
       */
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment | void
  >;

  /**
   * List configurationAssignments for resource.
   */
  @summary("List configurationAssignments for resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments")
  @get
  listParent is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource parent type
       */
      @path
      resourceParentType: string;

      /**
       * Resource parent identifier
       */
      @path
      resourceParentName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;
    },
    ListConfigurationAssignmentsResult
  >;

  /**
   * List configurationAssignments for resource.
   */
  @summary("List configurationAssignments for resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;
    },
    ListConfigurationAssignmentsResult
  >;
}

interface MaintenanceConfigurationsOperations {
  /**
   * Get Configuration record
   */
  @summary("Get Configuration record")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations/{resourceName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource Group Name
       */
      @path
      resourceGroupName: string;

      /**
       * Maintenance Configuration Name
       */
      @path
      resourceName: string;
    },
    MaintenanceConfiguration
  >;

  /**
   * Create or Update configuration record
   */
  @summary("Create or Update configuration record")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations/{resourceName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource Group Name
       */
      @path
      resourceGroupName: string;

      /**
       * Maintenance Configuration Name
       */
      @path
      resourceName: string;

      /**
       * The configuration
       */
      @body
      configuration: MaintenanceConfiguration;
    },
    MaintenanceConfiguration
  >;

  /**
   * Delete Configuration record
   */
  @summary("Delete Configuration record")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations/{resourceName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource Group Name
       */
      @path
      resourceGroupName: string;

      /**
       * Maintenance Configuration Name
       */
      @path
      resourceName: string;
    },
    void
  >;

  /**
   * Patch configuration record
   */
  @summary("Patch configuration record")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations/{resourceName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource Group Name
       */
      @path
      resourceGroupName: string;

      /**
       * Maintenance Configuration Name
       */
      @path
      resourceName: string;

      /**
       * The configuration
       */
      @body
      configuration: MaintenanceConfiguration;
    },
    MaintenanceConfiguration
  >;

  /**
   * Get Configuration records within a subscription
   */
  @summary("Get Configuration records within a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/maintenanceConfigurations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<MaintenanceConfiguration>
  >;
}

interface MaintenanceConfigurationsForResourceGroupOperations {
  /**
   * Get Configuration records within a subscription and resource group
   */
  @summary("Get Configuration records within a subscription and resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource Group Name
       */
      @path
      resourceGroupName: string;
    },
    ResourceListResult<MaintenanceConfiguration>
  >;
}

interface ApplyUpdateForResourceGroupOperations {
  /**
   * Get Configuration records within a subscription and resource group
   */
  @summary("Get Configuration records within a subscription and resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maintenance/applyUpdates")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource Group Name
       */
      @path
      resourceGroupName: string;
    },
    ResourceListResult<ApplyUpdate>
  >;
}

interface ConfigurationAssignmentsWithinSubscriptionOperations {
  /**
   * Get configuration assignment within a subscription
   */
  @summary("Get configuration assignment within a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ListConfigurationAssignmentsResult
  >;
}

interface ConfigurationAssignmentsForSubscriptionsOperations {
  /**
   * Get configuration assignment for resource..
   */
  @summary("Get configuration assignment")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Configuration assignment name
       */
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment
  >;

  /**
   * Register configuration for resource.
   */
  @summary("Create configuration assignment")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Configuration assignment name
       */
      @path
      configurationAssignmentName: string;

      /**
       * The configurationAssignment
       */
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  /**
   * Register configuration for resource.
   */
  @summary("Create configuration assignment")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Configuration assignment name
       */
      @path
      configurationAssignmentName: string;

      /**
       * The configurationAssignment
       */
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  /**
   * Unregister configuration for resource.
   */
  @summary("Unregister configuration for resource")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Unique configuration assignment name
       */
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment | void
  >;
}

interface ConfigurationAssignmentsForResourceGroupOperations {
  /**
   * Get configuration assignment for resource..
   */
  @summary("Get configuration assignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Configuration assignment name
       */
      @pattern("^.+$")
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment
  >;

  /**
   * Register configuration for resource.
   */
  @summary("Create configuration assignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Configuration assignment name
       */
      @path
      configurationAssignmentName: string;

      /**
       * The configurationAssignment
       */
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  /**
   * Register configuration for resource.
   */
  @summary("Create configuration assignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Configuration assignment name
       */
      @path
      configurationAssignmentName: string;

      /**
       * The configurationAssignment
       */
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  /**
   * Unregister configuration for resource.
   */
  @summary("Unregister configuration for resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Unique configuration assignment name
       */
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment | void
  >;
}

interface UpdatesOperations {
  /**
   * Get updates to resources.
   */
  @summary("Get Updates to resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/updates")
  @get
  listParent is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource parent type
       */
      @path
      resourceParentType: string;

      /**
       * Resource parent identifier
       */
      @path
      resourceParentName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;
    },
    ListUpdatesResult
  >;

  /**
   * Get updates to resources.
   */
  @summary("Get Updates to resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/updates")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Resource provider name
       */
      @path
      providerName: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;

      /**
       * Resource identifier
       */
      @path
      resourceName: string;
    },
    ListUpdatesResult
  >;
}
