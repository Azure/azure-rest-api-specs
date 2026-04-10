// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Common;

namespace AlertsAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AlertsOperationGroup {
  /**
   * List all the alerts that are associated with the subscription
   */
  @tag("Alerts")
  @autoRoute
  @get
  @list
  @action("alerts")
  list is ArmProviderActionSync<
    Response = AlertList,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
  /**
   * List all the alerts that are associated with the resource group
   */
  @tag("Alerts")
  @autoRoute
  @get
  @action("alerts")
  @list
  listByResourceGroup is ArmProviderActionSync<
    Response = AlertList,
    Scope = Azure.ResourceManager.Extension.ResourceGroup,
    Error = CloudError
  >;
  /**
   * Simulate security alerts
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Alerts")
  @post
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/alerts/default/simulate")
  @Azure.Core.useFinalStateVia("original-uri")
  simulate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The location where ASC stores the data of the subscription. can be retrieved from Get locations
     */
    @path
    ascLocation: string,

    /**
     * The request body
     */
    @bodyRoot
    alertSimulatorRequestBody: AlertSimulatorRequestBody,
  ): ArmAcceptedLroResponse | CloudError;
}



