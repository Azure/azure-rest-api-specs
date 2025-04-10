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

namespace Microsoft.StreamAnalytics;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SubscriptionsOperationGroup {
  /**
   * Retrieves the subscription's current quota information in a particular region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscriptions_ListQuotas")
  @autoRoute
  @get
  @action("quotas")
  listQuotas is ArmProviderActionSync<
    Response = SubscriptionQuotasListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
