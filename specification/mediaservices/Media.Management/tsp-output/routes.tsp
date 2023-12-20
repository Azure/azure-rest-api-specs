import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;

interface LocationsOperations {
  @summary("Check Name Availability")
  @doc("Checks whether the Media Service resource name is available.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Media/locations/{locationName}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The unique identifier for a Microsoft Azure subscription.")
      @path
      subscriptionId: string;

      @doc("Location name.")
      @path
      locationName: string;

      @doc("The request parameters")
      @body
      parameters: CheckNameAvailabilityInput;
    },
    EntityNameAvailabilityCheckOutput
  >;
}
