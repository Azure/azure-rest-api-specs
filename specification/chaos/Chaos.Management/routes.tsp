import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Chaos;

interface OperationStatuses {
  /**
   * Get the status of a long running azure asynchronous operation.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/locations/{location}/operationStatuses/{asyncOperationId}")
  @armResourceRead(OperationStatus)
  @get
  get(
    ...SubscriptionBaseParameters;
    ...LocationParameter;

    /**
     * The operation Id.
     */
    @path
    @segment("operationStatuses")
    asyncOperationId: string;
  ): ArmResponse<OperationStatus> | ErrorResponse;
}
