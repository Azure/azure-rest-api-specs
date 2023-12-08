import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.DeviceUpdate;

@doc("Checks ADU resource name availability.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.DeviceUpdate/checknameavailability")
@post
op CheckNameAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("The Azure subscription ID.")
    @path
    subscriptionId: string;

    @doc("Check Name Availability Request.")
    @body
    request: CheckNameAvailabilityRequest;
  },
  CheckNameAvailabilityResponse
>;
