import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;
using OpenAPI;

namespace Microsoft.BareMetal;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Locations {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Template for async post request with body"
  @doc("Update Routes on Virtual Network.")
  @autoRoute
  @OpenAPI.extension("x-ms-long-running-operation", true)
  @OpenAPI.extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @action
  @post
  updateRoutesOnVirtualNetwork(
    ...ResourceInstanceParameters<Location>,

    @doc("The updateRoutesOnVirtualNetwork object.")
    @bodyRoot
    updateRoutesOnVirtualNetworkObject: UpdateRoutesOnVirtualNetwork,
  ): ArmResponse<UpdateRoutesOnVirtualNetwork> | {
    ...AcceptedResponse;

    // @doc("Operation accepted.")
    ...Azure.Core.Foundations.RetryAfterHeader;

    ...LocationHeader;
  } | ErrorResponse;
}
