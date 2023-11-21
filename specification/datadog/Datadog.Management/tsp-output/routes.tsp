import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MicrosoftDatadogClient;

interface MarketplaceAgreementsOperations {
  @summary("List Datadog marketplace agreements in the subscription.")
  @doc("List Datadog marketplace agreements in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Datadog/agreements")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    DatadogAgreementResourceListResponse
  >;

  @summary("Create Datadog marketplace agreement in the subscription.")
  @doc("Create Datadog marketplace agreement in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Datadog/agreements/default")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @body body: DatadogAgreementResource;
    },
    DatadogAgreementResource
  >;
}

interface MonitorsOperations {
  @summary("List the api keys for a given monitor resource.")
  @doc("List the api keys for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/listApiKeys")
  @post
  ListApiKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    DatadogApiKeyListResponse
  >;

  @summary("Get the default api key.")
  @doc("Get the default api key.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/getDefaultKey")
  @post
  GetDefaultKey is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    DatadogApiKey
  >;

  @summary("Set the default api key.")
  @doc("Set the default api key.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/setDefaultKey")
  @post
  SetDefaultKey is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @body body: DatadogApiKey;
    },
    void
  >;

  @summary("List the hosts for a given monitor resource.")
  @doc("List the hosts for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/listHosts")
  @post
  ListHosts is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    DatadogHostListResponse
  >;

  @summary("""
List all Azure resources associated to the same Datadog organization as the
target resource.
""")
  @doc("""
List all Azure resources associated to the same Datadog organization as the
target resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/listLinkedResources")
  @post
  ListLinkedResources is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    LinkedResourceListResponse
  >;

  @summary("List the resources currently being monitored by the Datadog monitor resource.")
  @doc("List the resources currently being monitored by the Datadog monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/listMonitoredResources")
  @post
  ListMonitoredResources is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    MonitoredResourceListResponse
  >;

  @summary("List all monitors under the specified subscription.")
  @doc("List all monitors under the specified subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Datadog/monitors")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    DatadogMonitorResourceListResponse
  >;

  @summary("List all monitors under the specified resource group.")
  @doc("List all monitors under the specified resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    DatadogMonitorResourceListResponse
  >;

  @summary("Get the properties of a specific monitor resource.")
  @doc("Get the properties of a specific monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    DatadogMonitorResource
  >;

  @summary("Create a monitor resource.")
  @doc("Create a monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @body body: DatadogMonitorResource;
    },
    DatadogMonitorResource
  >;

  @summary("Update a monitor resource.")
  @doc("Update a monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @body body: DatadogMonitorResourceUpdateParameters;
    },
    DatadogMonitorResource
  >;

  @summary("Delete a monitor resource.")
  @doc("Delete a monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    void
  >;

  @summary("Refresh the set password link and return a latest one.")
  @doc("Refresh the set password link and return a latest one.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/refreshSetPasswordLink")
  @post
  RefreshSetPasswordLink is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    DatadogSetPasswordLink
  >;
}

interface OperationsOperations {
  @summary("""
List all operations provided by Microsoft.Datadog for the 2021-03-01 api
version.
""")
  @doc("""
List all operations provided by Microsoft.Datadog for the 2021-03-01 api
version.
""")
  @route("/providers/Microsoft.Datadog/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface TagRulesOperations {
  @summary("List the tag rules for a given monitor resource.")
  @doc("List the tag rules for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/tagRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    MonitoringTagRulesListResponse
  >;

  @summary("Create or update a tag rule set for a given monitor resource.")
  @doc("Create or update a tag rule set for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/tagRules/{ruleSetName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("Rule set name")
      @path
      ruleSetName: string;

      @body body: MonitoringTagRules;
    },
    MonitoringTagRules
  >;

  @summary("Get a tag rule set for a given monitor resource.")
  @doc("Get a tag rule set for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/tagRules/{ruleSetName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("Rule set name")
      @path
      ruleSetName: string;
    },
    MonitoringTagRules
  >;
}

interface SingleSignOnConfigurationsOperations {
  @summary("List the single sign-on configurations for a given monitor resource.")
  @doc("List the single sign-on configurations for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/singleSignOnConfigurations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    DatadogSingleSignOnResourceListResponse
  >;

  @summary("Configures single-sign-on for this resource.")
  @doc("Configures single-sign-on for this resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/singleSignOnConfigurations/{configurationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("Configuration name")
      @path
      configurationName: string;

      @body body: DatadogSingleSignOnResource;
    },
    DatadogSingleSignOnResource
  >;

  @summary("Gets the datadog single sign-on resource for the given Monitor.")
  @doc("Gets the datadog single sign-on resource for the given Monitor.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Datadog/monitors/{monitorName}/singleSignOnConfigurations/{configurationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("Configuration name")
      @path
      configurationName: string;
    },
    DatadogSingleSignOnResource
  >;
}
