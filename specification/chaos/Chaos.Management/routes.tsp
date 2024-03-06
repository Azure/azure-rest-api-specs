import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Chaos;

interface OperationStatusesOperations {
  /**
   * Get the status of a long running azure asynchronous operation.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/locations/{location}/operationStatuses/{asyncOperationId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * The operation Id.
       */
      @path
      asyncOperationId: string;

      /**
       * GUID that represents an Azure subscription ID.
       */
      @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
      @path
      subscriptionId: string;
    },
    OperationStatus
  >;
}
