import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Cache;

interface OperationsStatusOperations {
  /**
   * Gets the status of operation.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cache/locations/{location}/operationsStatus/{operationId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    OperationStatus
  >;
}

interface SkusOperations {
  /**
   * Gets information about skus in specified location for the given subscription id
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cache/locations/{location}/skus")
  @get
  list is Azure.Core.Foundations.Operation<
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
    },
    RegionSkuDetails
  >;
}
