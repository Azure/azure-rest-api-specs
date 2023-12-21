import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A cost item.")
@parentResource(Lab)
model LabCost is TrackedResource<LabCostProperties> {
  @doc("The name of the cost.")
  @path
  @key("name")
  @segment("costs")
  name: string;
}

@armResourceOperations
interface Costs {
  @doc("Get cost.")
  get is ArmResourceRead<
    LabCost,
    {
      ...BaseParameters<LabCost>;

      @doc("Specify the $expand query. Example: 'properties($expand=labCostDetails)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing cost.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LabCost>;
}
