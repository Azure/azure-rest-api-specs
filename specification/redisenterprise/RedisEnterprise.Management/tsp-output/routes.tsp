import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Cache;

interface OperationsStatusOperations {
  @doc("Gets the status of operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cache/locations/{location}/operationsStatus/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("The ID of an ongoing async operation.")
      @minLength(1)
      @path
      operationId: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    OperationStatus
  >;
}

interface SkusOperations {
  @doc("Gets information about skus in specified location for the given subscription id")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cache/locations/{location}/skus")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;
    },
    RegionSkuDetails
  >;
}
