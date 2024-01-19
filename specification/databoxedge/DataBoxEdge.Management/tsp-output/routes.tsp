import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataBoxEdge;

interface AvailableSkusOperations {
  @summary("List all the available Skus and information related to them.")
  @doc("List all the available Skus and information related to them.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataBoxEdge/availableSkus")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID.")
      @path
      subscriptionId: string;
    },
    DataBoxEdgeSkuList
  >;
}
