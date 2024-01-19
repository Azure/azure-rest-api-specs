import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Kusto;

interface SkusOperations {
  @doc("Lists eligible region SKUs for Kusto resource provider by Azure region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Kusto/locations/{location}/skus")
  @get
  list is Azure.Core.Foundations.Operation<
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
    ResourceListResult<Cluster>
  >;
}
