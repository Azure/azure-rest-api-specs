import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.Maintenance;

interface ConfigurationAssignmentsOperations {
  @summary("Get configuration assignment")
  @doc("Get configuration assignment for resource..")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceParentType}/{resourceParentName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/configurationAssignments/{configurationAssignmentName}")
  @get
  GetParent is Azure.Core.Foundations.Operation<
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
  CreateOrUpdateParent is Azure.Core.Foundations.Operation<
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
  DeleteParent is Azure.Core.Foundations.Operation<
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
  Get is Azure.Core.Foundations.Operation<
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
  CreateOrUpdate is Azure.Core.Foundations.Operation<
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
  Delete is Azure.Core.Foundations.Operation<
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
  ListParent is Azure.Core.Foundations.Operation<
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
  List is Azure.Core.Foundations.Operation<
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
  Get is Azure.Core.Foundations.Operation<
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
  CreateOrUpdate is Azure.Core.Foundations.Operation<
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
  Delete is Azure.Core.Foundations.Operation<
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
  Update is Azure.Core.Foundations.Operation<
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
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ListMaintenanceConfigurationsResult
  >;
}

interface MaintenanceConfigurationsForResourceGroupOperations {
  @summary("Get Configuration records within a subscription and resource group")
  @doc("Get Configuration records within a subscription and resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maintenance/maintenanceConfigurations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource Group Name")
      @path
      resourceGroupName: string;
    },
    ListMaintenanceConfigurationsResult
  >;
}

interface ApplyUpdateForResourceGroupOperations {
  @summary("Get Configuration records within a subscription and resource group")
  @doc("Get Configuration records within a subscription and resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maintenance/applyUpdates")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Resource Group Name")
      @path
      resourceGroupName: string;
    },
    ListApplyUpdate
  >;
}

interface ConfigurationAssignmentsWithinSubscriptionOperations {
  @summary("Get configuration assignment within a subscription")
  @doc("Get configuration assignment within a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maintenance/configurationAssignments")
  @get
  List is Azure.Core.Foundations.Operation<
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
  Get is Azure.Core.Foundations.Operation<
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
  CreateOrUpdate is Azure.Core.Foundations.Operation<
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
  Update is Azure.Core.Foundations.Operation<
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
  Delete is Azure.Core.Foundations.Operation<
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
  Get is Azure.Core.Foundations.Operation<
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
  CreateOrUpdate is Azure.Core.Foundations.Operation<
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
  Update is Azure.Core.Foundations.Operation<
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
  Delete is Azure.Core.Foundations.Operation<
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
  ListParent is Azure.Core.Foundations.Operation<
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
  List is Azure.Core.Foundations.Operation<
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
