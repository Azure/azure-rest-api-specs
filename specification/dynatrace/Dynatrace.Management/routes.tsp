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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface MonitorsOperationGroup {
  /**
   * Get Marketplace SaaS resource details of a tenant under a specific subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_GetMarketplaceSaaSResourceDetails")
  @autoRoute
  getMarketplaceSaaSResourceDetails is ArmProviderActionSync<
    Request = MarketplaceSaaSResourceDetailsRequest,
    Response = MarketplaceSaaSResourceDetailsResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
