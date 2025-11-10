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

@armResourceOperations
interface SiteNetworkServicesOperationGroup {
  /**
   * Cancels an ongoing long-running PUT operation for the specified Site Network Service resource. Other operations are not supported for cancellation at this time.
   */
  @action("cancelSiteNetworkServiceOperation")
  cancelOperation is ArmProviderActionAsync<
    Request = CancelInformation,
    Response = ArmAcceptedLroResponse<
      "Accepted. The header contains Location URL to check the status of the asynchronous operation",
      ArmLroLocationHeader
    >,
    Scope = SubscriptionActionScope,
    Parameters = {},
    LroHeaders = ArmLroLocationHeader
  >;
}

@@doc(SiteNetworkServicesOperationGroup.cancelOperation::parameters.body,
  "The SiteNetworkService detail and an optional operation which defaults to 'Put'."
);
