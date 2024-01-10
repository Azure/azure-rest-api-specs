import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HybridContainerService;

interface HybridContainerServiceOperations {
  @summary("Lists the available orchestrators in a custom location")
  @doc("Lists the available orchestrators in a custom location for HybridAKS")
  @route("/{customLocationResourceUri}/providers/Microsoft.HybridContainerService/orchestrators")
  @get
  ListOrchestrators is Azure.Core.Foundations.Operation<
    {
      @doc("The fully qualified Azure Resource manager identifier of the custom location resource.")
      @path
      customLocationResourceUri: string;
    },
    OrchestratorVersionProfileListResult
  >;

  @summary("Lists the available VM SKUs in a custom location")
  @doc("Lists the available VM SKUs in a custom location for HybridAKS")
  @route("/{customLocationResourceUri}/providers/Microsoft.HybridContainerService/vmSkus")
  @get
  ListVMSkus is Azure.Core.Foundations.Operation<
    {
      @doc("The fully qualified Azure Resource manager identifier of the custom location resource.")
      @path
      customLocationResourceUri: string;
    },
    VMSkuListResult
  >;
}
