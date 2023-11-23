import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Maps;

interface MapsOperations {
  @doc("List operations available for the Maps Resource Provider")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maps/operations")
  @get
  ListSubscriptionOperations is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    MapsOperations
  >;
}
