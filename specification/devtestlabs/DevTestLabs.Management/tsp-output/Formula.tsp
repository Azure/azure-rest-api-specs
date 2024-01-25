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
/**
 * A formula for creating a VM, specifying an image base and other parameters
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Lab)
@includeInapplicableMetadataInPayload(false)
model Formula extends Resource {
  /**
   * The name of the formula.
   */
  @path
  @key("name")
  @segment("formulas")
  @visibility("read")
  name: string;

  /**
   * The properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: FormulaProperties;
}

@armResourceOperations
interface Formulas {
  /**
   * Get formula.
   */
  get is ArmResourceRead<
    Formula,
    {
      ...BaseParameters<Formula>;

      /**
       * Specify the $expand query. Example: 'properties($select=description)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing formula. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Formula>;

  /**
   * Allows modifying tags of formulas. All other properties will be ignored.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Formula, FormulaFragment>;

  /**
   * Delete formula.
   */
  delete is ArmResourceDeleteSync<Formula>;

  /**
   * List formulas in a given lab.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Formulas_List")
  list is ArmResourceListByParent<
    Formula,
    {
      ...BaseParameters<Formula>;

      /**
       * Specify the $expand query. Example: 'properties($select=description)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
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
