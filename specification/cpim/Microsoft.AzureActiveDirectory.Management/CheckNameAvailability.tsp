import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureActiveDirectory;

@armResourceOperations
@doc("Check Name Availability")
interface CheckNameApi {
  @doc("Checks that the trusted signing account name is valid and is not already in use.")
  checkGlobalName is checkGlobalNameAvailability<
    CustomCheckNameAvailabilityRequest,
    CheckNameAvailabilityResponse
  >;
}

@doc("The check availability request body.")
model CustomCheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The country code where the resource will be in")
  countryCode?: string;
}
