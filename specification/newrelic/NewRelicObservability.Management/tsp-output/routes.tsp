import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace NewRelic.Observability;

interface OperationsOperations {
  @doc("List the operations for the provider")
  @route("/providers/NewRelic.Observability/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface AccountsOperations {
  @doc("List all the existing accounts")
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/accounts")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("User Email.")
      @query
      userEmail: string;

      @doc("Location for NewRelic.")
      @query
      location: string;
    },
    AccountsListResponse
  >;
}

interface MonitorsOperations {
  @doc("List NewRelicMonitorResource resources by subscription ID")
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/monitors")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    NewRelicMonitorResourceListResult
  >;

  @doc("List NewRelicMonitorResource resources by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors")
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
    NewRelicMonitorResourceListResult
  >;

  @doc("Get a NewRelicMonitorResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;
    },
    NewRelicMonitorResource
  >;

  @doc("Create a NewRelicMonitorResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("Resource create parameters.")
      @body
      resource: NewRelicMonitorResource;
    },
    NewRelicMonitorResource
  >;

  @doc("Update a NewRelicMonitorResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: NewRelicMonitorResourceUpdate;
    },
    NewRelicMonitorResource
  >;

  @doc("Delete a NewRelicMonitorResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("User Email.")
      @query
      userEmail: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;
    },
    void
  >;

  @doc("Get metric rules")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/getMetricRules")
  @post
  GetMetricRules is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("The details of the get metrics status request.")
      @body
      request: MetricsRequest;
    },
    MetricRules
  >;

  @doc("Get metric status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/getMetricStatus")
  @post
  GetMetricStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("The details of the get metrics status request.")
      @body
      request: MetricsStatusRequest;
    },
    MetricsStatusResponse
  >;

  @doc("""
List the app service resources currently being monitored by the NewRelic
resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/listAppServices")
  @post
  ListAppServices is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("The details of the app services get request.")
      @body
      request: AppServicesGetRequest;
    },
    AppServicesListResponse
  >;

  @doc("Switches the billing for NewRelic monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/switchBilling")
  @post
  SwitchBilling is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("The details of the switch billing request.")
      @body
      request: SwitchBillingRequest;
    },
    NewRelicMonitorResource | void
  >;

  @doc("""
List the compute vm resources currently being monitored by the NewRelic
resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/listHosts")
  @post
  ListHosts is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("The details of the Hosts get request.")
      @body
      request: HostsGetRequest;
    },
    VMHostsListResponse
  >;

  @doc("List the resources currently being monitored by the NewRelic monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/monitoredResources")
  @post
  ListMonitoredResources is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;
    },
    MonitoredResourceListResponse
  >;

  @doc("""
Returns the payload that needs to be passed in the request body for installing
NewRelic agent on a VM.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/vmHostPayloads")
  @post
  VmHostPayload is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;
    },
    VMExtensionPayload
  >;
}

interface OrganizationsOperations {
  @doc("List all the existing organizations")
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/organizations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("User Email.")
      @query
      userEmail: string;

      @doc("Location for NewRelic.")
      @query
      location: string;
    },
    OrganizationsListResponse
  >;
}

interface PlansOperations {
  @doc("List plans data")
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/plans")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Account Id.")
      @query
      accountId: string;

      @doc("Organization Id.")
      @query
      organizationId: string;
    },
    PlanDataListResponse
  >;
}

interface TagRulesOperations {
  @doc("List TagRule resources by NewRelicMonitorResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/tagRules")
  @get
  ListByNewRelicMonitorResource is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;
    },
    TagRuleListResult
  >;

  @doc("Get a TagRule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/tagRules/{ruleSetName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("Name of the TagRule")
      @path
      ruleSetName: string;
    },
    TagRule
  >;

  @doc("Create a TagRule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/tagRules/{ruleSetName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("Name of the TagRule")
      @path
      ruleSetName: string;

      @doc("Resource create parameters.")
      @body
      resource: TagRule;
    },
    TagRule
  >;

  @doc("Delete a TagRule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/tagRules/{ruleSetName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("Name of the TagRule")
      @path
      ruleSetName: string;
    },
    void
  >;

  @doc("Update a TagRule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NewRelic.Observability/monitors/{monitorName}/tagRules/{ruleSetName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Monitors resource")
      @path
      monitorName: string;

      @doc("Name of the TagRule")
      @path
      ruleSetName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: TagRuleUpdate;
    },
    TagRule
  >;
}
