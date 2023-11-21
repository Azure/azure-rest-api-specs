import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Dynatrace.Observability;

interface MonitorsOperations {
  @summary("Gets the user account credentials for a Monitor")
  @doc("Gets the user account credentials for a Monitor")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/getAccountCredentials")
  @post
  GetAccountCredentials is Azure.Core.Foundations.Operation<
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
    AccountInfoSecure
  >;

  @summary("List the resources currently being monitored by the Dynatrace monitor resource.")
  @doc("List the resources currently being monitored by the Dynatrace monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/listMonitoredResources")
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

  @summary("""
Returns the payload that needs to be passed in the request body for installing
Dynatrace agent on a VM.
""")
  @doc("""
Returns the payload that needs to be passed in the request body for installing
Dynatrace agent on a VM.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/getVMHostPayload")
  @post
  GetVMHostPayload is Azure.Core.Foundations.Operation<
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
    VMExtensionPayload
  >;

  @summary("Get a MonitorResource")
  @doc("Get a MonitorResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}")
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
    MonitorResource
  >;

  @summary("Create a MonitorResource")
  @doc("Create a MonitorResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}")
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

      @doc("Resource create parameters.")
      @body
      resource: MonitorResource;
    },
    MonitorResource
  >;

  @summary("Update a MonitorResource")
  @doc("Update a MonitorResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}")
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

      @doc("The resource properties to be updated.")
      @body
      resource: MonitorResourceUpdate;
    },
    MonitorResource
  >;

  @summary("Delete a MonitorResource")
  @doc("Delete a MonitorResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}")
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

  @summary("List all MonitorResource by subscriptionId")
  @doc("List all MonitorResource by subscriptionId")
  @route("/subscriptions/{subscriptionId}/providers/Dynatrace.Observability/monitors")
  @get
  ListBySubscriptionId is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    MonitorResourceListResult
  >;

  @summary("List MonitorResource resources by resource group")
  @doc("List MonitorResource resources by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors")
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
    MonitorResourceListResult
  >;

  @summary("List the compute resources currently being monitored by the Dynatrace resource.")
  @doc("List the compute resources currently being monitored by the Dynatrace resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/listHosts")
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
    VMHostsListResponse
  >;

  @summary("Gets list of App Services with Dynatrace PaaS OneAgent enabled")
  @doc("Gets list of App Services with Dynatrace PaaS OneAgent enabled")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/listAppServices")
  @post
  ListAppServices is Azure.Core.Foundations.Operation<
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
    AppServiceListResponse
  >;

  @summary("Gets the SSO configuration details from the partner.")
  @doc("Gets the SSO configuration details from the partner.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/getSSODetails")
  @post
  GetSSODetails is Azure.Core.Foundations.Operation<
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

      @doc("The details of the get sso details request.")
      @body
      request: SSODetailsRequest;
    },
    SSODetailsResponse
  >;

  @summary("Gets all the Dynatrace environments that a user can link a azure resource to")
  @doc("Gets all the Dynatrace environments that a user can link a azure resource to")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/listLinkableEnvironments")
  @post
  ListLinkableEnvironments is Azure.Core.Foundations.Operation<
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

      @doc("The details of the linkable environment request.")
      @body
      request: LinkableEnvironmentRequest;
    },
    LinkableEnvironmentListResponse
  >;
}

interface OperationsOperations {
  @summary("List the operations for Dynatrace.Observability")
  @doc("List the operations for Dynatrace.Observability")
  @route("/providers/Dynatrace.Observability/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface TagRulesOperations {
  @summary("Get a TagRule")
  @doc("Get a TagRule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/tagRules/{ruleSetName}")
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

      @doc("Monitor resource name")
      @path
      ruleSetName: string;
    },
    TagRule
  >;

  @summary("Create a TagRule")
  @doc("Create a TagRule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/tagRules/{ruleSetName}")
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

      @doc("Monitor resource name")
      @path
      ruleSetName: string;

      @doc("Resource create parameters.")
      @body
      resource: TagRule;
    },
    TagRule
  >;

  @summary("Update a TagRule")
  @doc("Update a TagRule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/tagRules/{ruleSetName}")
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

      @doc("Monitor resource name")
      @path
      ruleSetName: string;

      @doc("The resource properties to be updated.")
      @body
      resource: TagRuleUpdate;
    },
    TagRule
  >;

  @summary("Delete a TagRule")
  @doc("Delete a TagRule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/tagRules/{ruleSetName}")
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

      @doc("Monitor resource name")
      @path
      ruleSetName: string;
    },
    void
  >;

  @summary("List all TagRule by monitorName")
  @doc("List all TagRule by monitorName")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/tagRules")
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
    TagRuleListResult
  >;
}

interface SingleSignOnOperations {
  @summary("Create a DynatraceSingleSignOnResource")
  @doc("Create a DynatraceSingleSignOnResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/singleSignOnConfigurations/{configurationName}")
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

      @doc("Single Sign On Configuration Name")
      @path
      configurationName: string;

      @doc("Resource create parameters.")
      @body
      resource: DynatraceSingleSignOnResource;
    },
    DynatraceSingleSignOnResource
  >;

  @summary("Get a DynatraceSingleSignOnResource")
  @doc("Get a DynatraceSingleSignOnResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/singleSignOnConfigurations/{configurationName}")
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

      @doc("Single Sign On Configuration Name")
      @path
      configurationName: string;
    },
    DynatraceSingleSignOnResource
  >;

  @summary("List all DynatraceSingleSignOnResource by monitorName")
  @doc("List all DynatraceSingleSignOnResource by monitorName")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/singleSignOnConfigurations")
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
    DynatraceSingleSignOnResourceListResult
  >;
}
