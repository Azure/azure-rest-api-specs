import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Insights;
@doc("The alert rule resource.")
model AlertRuleResource is TrackedResource<AlertRule> {
  @doc("The name of the rule.")
  @key("ruleName")
  @segment("alertrules")
  name: string;
}

@armResourceOperations
@projectedName("client", "AlertRules")
interface AlertRuleResources_AlertRules {
  @doc("Gets a classic metric alert rule")
  get is ArmResourceRead<AlertRuleResource>;

  @doc("Creates or updates a classic metric alert rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AlertRuleResource>;

  @doc("Updates an existing classic metric AlertRuleResource. To update other fields use the CreateOrUpdate method.")
  update is ArmCustomPatchSync<AlertRuleResource, AlertRuleResourcePatch>;

  @doc("Deletes a classic metric alert rule")
  delete is ArmResourceDeleteSync<AlertRuleResource>;

  @doc("List the classic metric alert rules within a resource group.")
  listByResourceGroup is ArmResourceListByParent<AlertRuleResource>;

  @doc("List the classic metric alert rules within a subscription.")
  listBySubscription is ArmListBySubscription<AlertRuleResource>;
}

@armResourceOperations
@projectedName("client", "AlertRuleIncidents")
interface AlertRuleResources_AlertRuleIncidents {
  @doc("Gets an incident associated to an alert rule")
  // FIXME: AlertRuleIncidents_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/microsoft.insights/alertrules/{ruleName}/incidents/{incidentName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the rule.")
      @path
      ruleName: string;

      @doc("The name of the incident to retrieve.")
      @path
      incidentName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    Incident
  >;

  @doc("Gets a list of incidents associated to an alert rule")
  // FIXME: AlertRuleIncidents_ListByAlertRule could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/microsoft.insights/alertrules/{ruleName}/incidents")
  @get
  ListByAlertRule is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the rule.")
      @path
      ruleName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    IncidentListResult
  >;
}
