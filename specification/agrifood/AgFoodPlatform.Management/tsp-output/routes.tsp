import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AgFoodPlatform;

interface LocationsOperations {
  @doc("Checks the name availability of the resource with requested resource name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AgFoodPlatform/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
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
