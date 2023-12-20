import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevTestLab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A cost item.")
@parentResource(DevTestLab)
model DevTestLabCost is TrackedResource<LabCostProperties> {
  @doc("The name of the cost.")
  @path
  @key("name")
  @segment("costs")
  name: string;
}

@armResourceOperations
interface DevTestLabCosts {
  @doc("Get cost.")
  get is ArmResourceRead<
    DevTestLabCost,
    {
      ...BaseParameters<DevTestLabCost>;

      @doc("Specify the $expand query. Example: 'properties($expand=labCostDetails)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing cost.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DevTestLabCost>;
}
