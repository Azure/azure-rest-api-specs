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

namespace Dynatrace.Observability;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface MonitorsOperationGroup {
  /**
   * Get the total number of connected resources for the given marketplace subscription Id
   */
  @autoRoute
  getAllConnectedResourcesCount is ArmProviderActionSync<
    Request = MarketplaceSubscriptionIdRequest,
    Response = ConnectedResourcesCountResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Get Marketplace SaaS resource details
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  getMarketplaceSaaSResourceDetails is ArmProviderActionSync<
    Request = MarketplaceSaaSResourceDetailsRequest,
    Response = MarketplaceSaaSResourceDetailsResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CreationSupportedOperationGroup {
  /**
   * Informs if the current subscription is being already monitored for selected Dynatrace environment.
   */
  @summary("Informs if the current subscription is being already monitored for selected Dynatrace environment.")
  @route("/subscriptions/{subscriptionId}/providers/Dynatrace.Observability/subscriptionStatuses/{dynatraceEnvironmentId}")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * Dynatrace Environment Id
     */
    @path
    dynatraceEnvironmentId: string,
  ): ArmResponse<CreateResourceSupportedResponse> | ErrorResponse;

  /**
   * Informs if the current subscription is being already monitored for selected Dynatrace environment.
   */
  @summary("Informs if the current subscription is being already monitored for selected Dynatrace environment.")
  @autoRoute
  @get
  @action("default")
  get is ArmProviderActionSync<
    Response = CreateResourceSupportedResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Dynatrace Environment Id
       */
      @path
      @segment("subscriptionStatuses")
      dynatraceEnvironmentId: string;
    }
  >;
}
