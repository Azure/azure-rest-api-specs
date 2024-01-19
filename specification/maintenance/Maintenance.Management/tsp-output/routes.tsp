import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Maintenance;

interface ConfigurationAssignmentsOperations {
  @summary("Get configuration assignment")
  @doc("Get configuration assignment for resource..")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @get
  getParent is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource parent type")
      @path
      resourceParentType: string;

      @doc("Resource parent identifier")
      @path
      resourceParentName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;

      @doc("Configuration assignment name")
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment
  >;

  @summary("Create configuration assignment")
  @doc("Register configuration for resource.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @put
  createOrUpdateParent is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource parent type")
      @path
      resourceParentType: string;

      @doc("Resource parent identifier")
      @path
      resourceParentName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;

      @doc("Configuration assignment name")
      @path
      configurationAssignmentName: string;

      @doc("The configurationAssignment")
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  @summary("Unregister configuration for resource")
  @doc("Unregister configuration for resource.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @delete
  deleteParent is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource parent type")
      @path
      resourceParentType: string;

      @doc("Resource parent identifier")
      @path
      resourceParentName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;

      @doc("Unique configuration assignment name")
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment | void
  >;

  @summary("Get configuration assignment")
  @doc("Get configuration assignment for resource..")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;

      @doc("Configuration assignment name")
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment
  >;

  @summary("Create configuration assignment")
  @doc("Register configuration for resource.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;

      @doc("Configuration assignment name")
      @path
      configurationAssignmentName: string;

      @doc("The configurationAssignment")
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  @summary("Unregister configuration for resource")
  @doc("Unregister configuration for resource.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;

      @doc("Unique configuration assignment name")
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment | void
  >;

  @summary("List configurationAssignments for resource")
  @doc("List configurationAssignments for resource.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments")
  @get
  listParent is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource parent type")
      @path
      resourceParentType: string;

      @doc("Resource parent identifier")
      @path
      resourceParentName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;
    },
    ListConfigurationAssignmentsResult
  >;

  @summary("List configurationAssignments for resource")
  @doc("List configurationAssignments for resource.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;
    },
    ListConfigurationAssignmentsResult
  >;
}

interface MaintenanceConfigurationsOperations {
  @summary("Get Configuration record")
  @doc("Get Configuration record")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations/{resourceName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("Maintenance Configuration Name")
      @path
      resourceName: string;
    },
    MaintenanceConfiguration
  >;

  @summary("Create or Update configuration record")
  @doc("Create or Update configuration record")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations/{resourceName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("Maintenance Configuration Name")
      @path
      resourceName: string;

      @doc("The configuration")
      @body
      configuration: MaintenanceConfiguration;
    },
    MaintenanceConfiguration
  >;

  @summary("Delete Configuration record")
  @doc("Delete Configuration record")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations/{resourceName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("Maintenance Configuration Name")
      @path
      resourceName: string;
    },
    void
  >;

  @summary("Patch configuration record")
  @doc("Patch configuration record")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations/{resourceName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("Maintenance Configuration Name")
      @path
      resourceName: string;

      @doc("The configuration")
      @body
      configuration: MaintenanceConfiguration;
    },
    MaintenanceConfiguration
  >;

  @summary("Get Configuration records within a subscription")
  @doc("Get Configuration records within a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/maintenanceConfigurations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<MaintenanceConfiguration>
  >;
}

interface MaintenanceConfigurationsForResourceGroupOperations {
  @summary("Get Configuration records within a subscription and resource group")
  @doc("Get Configuration records within a subscription and resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource Group Name")
      @path
      resourceGroupName: string;
    },
    ResourceListResult<MaintenanceConfiguration>
  >;
}

interface ApplyUpdateForResourceGroupOperations {
  @summary("Get Configuration records within a subscription and resource group")
  @doc("Get Configuration records within a subscription and resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maintenance/applyUpdates")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource Group Name")
      @path
      resourceGroupName: string;
    },
    ResourceListResult<ApplyUpdate>
  >;
}

interface ConfigurationAssignmentsWithinSubscriptionOperations {
  @summary("Get configuration assignment within a subscription")
  @doc("Get configuration assignment within a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ListConfigurationAssignmentsResult
  >;
}

interface ConfigurationAssignmentsForSubscriptionsOperations {
  @summary("Get configuration assignment")
  @doc("Get configuration assignment for resource..")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Configuration assignment name")
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment
  >;

  @summary("Create configuration assignment")
  @doc("Register configuration for resource.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Configuration assignment name")
      @path
      configurationAssignmentName: string;

      @doc("The configurationAssignment")
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  @summary("Create configuration assignment")
  @doc("Register configuration for resource.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Configuration assignment name")
      @path
      configurationAssignmentName: string;

      @doc("The configurationAssignment")
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  @summary("Unregister configuration for resource")
  @doc("Unregister configuration for resource.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Unique configuration assignment name")
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment | void
  >;
}

interface ConfigurationAssignmentsForResourceGroupOperations {
  @summary("Get configuration assignment")
  @doc("Get configuration assignment for resource..")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Configuration assignment name")
      @pattern("^.+$")
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment
  >;

  @summary("Create configuration assignment")
  @doc("Register configuration for resource.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Configuration assignment name")
      @path
      configurationAssignmentName: string;

      @doc("The configurationAssignment")
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  @summary("Create configuration assignment")
  @doc("Register configuration for resource.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Configuration assignment name")
      @path
      configurationAssignmentName: string;

      @doc("The configurationAssignment")
      @body
      configurationAssignment: ConfigurationAssignment;
    },
    ConfigurationAssignment
  >;

  @summary("Unregister configuration for resource")
  @doc("Unregister configuration for resource.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Unique configuration assignment name")
      @path
      configurationAssignmentName: string;
    },
    ConfigurationAssignment | void
  >;
}

interface UpdatesOperations {
  @summary("Get Updates to resource")
  @doc("Get updates to resources.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/updates")
  @get
  listParent is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource parent type")
      @path
      resourceParentType: string;

      @doc("Resource parent identifier")
      @path
      resourceParentName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;
    },
    ListUpdatesResult
  >;

  @summary("Get Updates to resource")
  @doc("Get updates to resources.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/updates")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Resource provider name")
      @path
      providerName: string;

      @doc("Resource type")
      @path
      resourceType: string;

      @doc("Resource identifier")
      @path
      resourceName: string;
    },
    ListUpdatesResult
  >;
}
