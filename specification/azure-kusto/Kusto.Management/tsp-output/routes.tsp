import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;

interface SkusOperations {
  @doc("Lists eligible region SKUs for Kusto resource provider by Azure region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Kusto/locations/{location}/skus")
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
    SkuDescriptionList
  >;
}
