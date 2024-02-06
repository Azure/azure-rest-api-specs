import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

interface OperationStatusOperations {
  /**
   * Returns the current status of an async operation.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DeviceRegistry/locations/{location}/operationStatuses/{operationId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * The ID of an ongoing async operation.
       */
      @minLength(1)
      @path
      operationId: string;
    },
    ArmOperationStatus
  >;
}
