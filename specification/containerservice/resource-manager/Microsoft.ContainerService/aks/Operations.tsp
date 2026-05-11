import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./CommonModels.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

// =============================================================================
// Operations (provider-level, not location-scoped)
// =============================================================================

interface Operations {
  /**
   * Gets a list of operations.
   */
  @tag("ManagedClusters")
  @autoRoute
  @segment("operations")
  @list
  list(
    ...CommonTypes.ApiVersionParameter,

    @doc("Microsoft.ContainerService provider")
    @path
    @segment("providers")
    provider: "Microsoft.ContainerService",
  ): ArmResponse<OperationListResult> | ErrorResponse;
}
