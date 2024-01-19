import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
@doc("The alert rule resource.")
model AlertRuleResource is TrackedResource<AlertRule> {
  @doc("The name of the rule.")
  @path
  @key("ruleName")
  @segment("alertrules")
  name: string;
}

@armResourceOperations
interface AlertRuleResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a classic metric alert rule")
  @operationId("AlertRules_Get")
  get is ArmResourceRead<AlertRuleResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a classic metric alert rule.")
  @operationId("AlertRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AlertRuleResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing classic metric AlertRuleResource. To update other fields use the CreateOrUpdate method.")
  @operationId("AlertRules_Update")
  update is ArmCustomPatchSync<AlertRuleResource, AlertRuleResourcePatch>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a classic metric alert rule")
  @operationId("AlertRules_Delete")
  delete is ArmResourceDeleteSync<AlertRuleResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the classic metric alert rules within a resource group.")
  @operationId("AlertRules_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AlertRuleResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the classic metric alert rules within a subscription.")
  @operationId("AlertRules_ListBySubscription")
  listBySubscription is ArmListBySubscription<AlertRuleResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AlertRuleIncidents_Get")
  @doc("Gets an incident associated to an alert rule")
  // FIXME: AlertRuleIncidents_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/microsoft.insights/alertrules/{ruleName}/incidents/{incidentName}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AlertRuleIncidents_ListByAlertRule")
  @doc("Gets a list of incidents associated to an alert rule")
  // FIXME: AlertRuleIncidents_ListByAlertRule could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/microsoft.insights/alertrules/{ruleName}/incidents")
  @get
  listByAlertRule is Azure.Core.Foundations.Operation<
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

@@projectedName(AlertRuleResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AlertRuleResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AlertRuleResources.createOrUpdate::parameters.resource,
  "The parameters of the rule to create or update."
);
@@projectedName(AlertRuleResources.update::parameters.properties,
  "json",
  "alertRulesResource"
);
@@extension(AlertRuleResources.update::parameters.properties,
  "x-ms-client-name",
  "alertRulesResource"
);
@@doc(AlertRuleResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
