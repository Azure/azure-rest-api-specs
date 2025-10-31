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

namespace Microsoft.HybridNetwork;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SiteNetworkServicesOperationGroup {
  /**
   * Cancels an ongoing long-running PUT operation for the specified Site Network Service resource. Other operations are not supported for cancellation at this time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SiteNetworkServices_CancelOperation")
  @autoRoute
  @action("cancelSiteNetworkServiceOperation")
  cancelOperation is ArmProviderActionAsync<
    Request = CancelInformation,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
