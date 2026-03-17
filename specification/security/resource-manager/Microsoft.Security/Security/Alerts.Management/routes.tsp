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

namespace Microsoft.Security;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AlertsOperationGroup {
  /**
   * List all the alerts that are associated with the subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_List")
  @autoRoute
  @get
  @action("alerts")
  list is ArmProviderActionSync<
    Response = AlertList,
    Scope = SubscriptionActionScope
  >;
  /**
   * List all the alerts that are associated with the resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_ListByResourceGroup")
  @autoRoute
  @get
  @action("alerts")
  listByResourceGroup is ArmProviderActionSync<
    Response = AlertList,
    Scope = Extension.ResourceGroup
  >;
  /**
   * Simulate security alerts
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_Simulate")
  @autoRoute
  @action("alerts/default/simulate")
  simulate is ArmProviderActionAsync<
    Request = AlertSimulatorRequestBody,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The location where ASC stores the data of the subscription. can be retrieved from Get locations
       */
      @path
      @segment("locations")
      ascLocation: string;
    }
  >;
}
