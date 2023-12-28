import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.VoiceServices;

interface NameAvailabilityOperations {
  @doc("Check whether the resource name is available in the given region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.VoiceServices/locations/{location}/checkNameAvailability")
  @post
  CheckLocal is Azure.Core.Foundations.Operation<
    {
      @doc("The location in which uniqueness will be verified.")
      @path
      location: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The check availability request body.")
      @body
      body: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}
