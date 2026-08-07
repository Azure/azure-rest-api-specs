import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.DocumentDB;

interface MongoClustersOperations {
  @doc("Check the availability of name for resource")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/checkMongoClusterNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("The required parameters for checking if resource name is available.")
      @body
      parameters: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}
