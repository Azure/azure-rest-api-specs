import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Maps;

@armResourceOperations(#{ omitTags: true })
interface OperationStatusOperationGroup {
  /**
   * Gets the status of a long-running asynchronous operation.
   */
  @tag("AsyncOperations")
  get is GetResourceOperationStatus<
    Azure.ResourceManager.CommonTypes.OperationStatusResult,
    SubscriptionLocationActionScope
  >;
}

@@minLength(OperationStatusOperationGroup.get::parameters.operationId, 1);
