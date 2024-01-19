import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ConfidentialLedger;

@doc("To check whether a resource name is available.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.ConfidentialLedger/checkNameAvailability")
@post
op checkNameAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("Name availability request payload.")
    @body
    nameAvailabilityRequest: CheckNameAvailabilityRequest;
  },
  CheckNameAvailabilityResponse
>;
