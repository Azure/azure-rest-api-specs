import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
@doc("A formula for creating a VM, specifying an image base and other parameters")
@parentResource(Lab)
model Formula is TrackedResource<FormulaProperties> {
  @doc("The name of the formula.")
  @path
  @key("name")
  @segment("formulas")
  name: string;
}

@armResourceOperations
interface Formulas {
  @doc("Get formula.")
  get is ArmResourceRead<
    Formula,
    {
      ...BaseParameters<Formula>;

      @doc("Specify the $expand query. Example: 'properties($select=description)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Create or replace an existing formula. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Formula>;

  @doc("Allows modifying tags of formulas. All other properties will be ignored.")
  update is ArmCustomPatchSync<Formula, FormulaFragment>;

  @doc("Delete formula.")
  delete is ArmResourceDeleteSync<Formula>;

  @doc("List formulas in a given lab.")
  list is ArmResourceListByParent<
    Formula,
    {
      ...BaseParameters<Formula>;

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

@@projectedName(Formulas.createOrUpdate::parameters.resource,
  "json",
  "formula"
);
@@extension(Formulas.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "formula"
);
@@doc(Formulas.createOrUpdate::parameters.resource,
  "A formula for creating a VM, specifying an image base and other parameters"
);
@@projectedName(Formulas.update::parameters.properties, "json", "formula");
@@extension(Formulas.update::parameters.properties,
  "x-ms-client-name",
  "formula"
);
@@doc(Formulas.update::parameters.properties,
  "A formula for creating a VM, specifying an image base and other parameters"
);
