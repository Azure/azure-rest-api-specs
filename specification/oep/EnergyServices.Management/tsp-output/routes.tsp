import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.EnergyServices;

interface LocationsOperations {
  @doc("Checks the name availability of the resource with requested resource name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.OpenEnergyPlatform/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("NameAvailabilityRequest object.")
      @body
      body: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}
