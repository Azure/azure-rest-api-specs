import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.MixedReality;

@doc("Check Name Availability for local uniqueness")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.MixedReality/locations/{location}/checkNameAvailability")
@post
op checkNameAvailabilityLocal is Azure.Core.Foundations.Operation<
  {
    @doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)")
    @path
    subscriptionId: string;

    @doc("The location in which uniqueness will be verified.")
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    location: string;

    @doc("Check Name Availability Request.")
    @body
    checkNameAvailability: CheckNameAvailabilityRequest;
  },
  CheckNameAvailabilityResponse
>;
