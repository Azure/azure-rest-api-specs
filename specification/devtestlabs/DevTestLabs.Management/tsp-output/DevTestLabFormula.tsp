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
@doc("A formula for creating a VM, specifying an image base and other parameters")
@parentResource(DevTestLab)
model DevTestLabFormula is TrackedResource<FormulaProperties> {
  @doc("The name of the formula.")
  @path
  @key("name")
  @segment("formulas")
  name: string;
}

@armResourceOperations
interface DevTestLabFormulas {
  @doc("Get formula.")
  get is ArmResourceRead<
    DevTestLabFormula,
    {
      ...BaseParameters<DevTestLabFormula>;

      @doc("Specify the $expand query. Example: 'properties($select=description)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing formula. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevTestLabFormula>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of formulas. All other properties will be ignored.")
  update is ArmCustomPatchSync<DevTestLabFormula, FormulaFragment>;
  @doc("Delete formula.")
  delete is ArmResourceDeleteSync<DevTestLabFormula>;
  @doc("List formulas in a given lab.")
  list is ArmResourceListByParent<
    DevTestLabFormula,
    {
      ...BaseParameters<DevTestLabFormula>;

      @doc("Specify the $expand query. Example: 'properties($select=description)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}
