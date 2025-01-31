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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Cannot use @armResourceOperations decorator here, the auto-generated routes do not match feature requirements"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This is the API"
interface LocationsUtilization {
  /**
   * Get the Utilization for all clusters in the given location
   * New API route starting from 2025-02-01-preview
   */
  @armResourceList(ClusterProperties)
  @route("/providers/Microsoft.BareMetal/locations/{location}/utilization")
  @get
  list(
    ...ApiVersionParameter,
    ...LocationResourceParameter,
  ): ArmResponse<ClusterList> | ErrorResponse;
}

@armResourceOperations
interface Locations {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Template for async post request with body"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Decorator exists as previously approved by ARM"
  @doc("Update Routes on Virtual Network.")
  @autoRoute
  @action
  @post
  updateRoutesOnVirtualNetwork(
    ...ResourceInstanceParameters<Location>,

    @doc("The updateRoutesOnVirtualNetwork object.")
    @bodyRoot
    updateRoutesOnVirtualNetworkObject: UpdateRoutesOnVirtualNetwork,
  ): ArmResponse<UpdateRoutesOnVirtualNetwork> | {
    ...AcceptedResponse;
    ...Azure.Core.Foundations.RetryAfterHeader;
    ...ArmLroLocationHeader<FinalResult = UpdateRoutesOnVirtualNetwork>;
  } | ErrorResponse;
}
