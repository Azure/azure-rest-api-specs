import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DeviceUpdate;

@doc("Checks ADU resource name availability.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.DeviceUpdate/checknameavailability")
@post
op checkNameAvailability is Azure.Core.Foundations.Operation<
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
