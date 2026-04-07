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

namespace Microsoft.insights;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AlertRuleIncidentsOperationGroup {
  /**
   * Gets an incident associated to an alert rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AlertRuleIncidents_Get")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/microsoft.insights/alertrules/{ruleName}/incidents/{incidentName}")
  @get
  @tag("AlertRuleIncidents")
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the rule.
     */
    @path
    ruleName: string,

    /**
     * The name of the incident to retrieve.
     */
    @path
    incidentName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<Incident> | ErrorResponse;

  /**
   * Gets a list of incidents associated to an alert rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AlertRuleIncidents_ListByAlertRule")
  @autoRoute
  @get
  @action("incidents")
  @tag("AlertRuleIncidents")
  @list
  listByAlertRule is ArmProviderActionSync<
    Response = IncidentListResult,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the rule.
       */
      @path
      @segment("alertrules")
      ruleName: string;
    }
  >;
}
