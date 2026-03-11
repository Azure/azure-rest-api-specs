import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A formula for creating a VM, specifying an image base and other parameters
 */
@parentResource(Lab)
model Formula is Azure.ResourceManager.ProxyResource<FormulaProperties, false> {
  ...ResourceNameParameter<
    Resource = Formula,
    KeyName = "formulaName",
    SegmentName = "formulas",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Formulas {
  /**
   * Get formula.
   */
  get is ArmResourceRead<
    Formula,
    Parameters = {
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Formula,
    LroHeaders = ArmLroLocationHeader<FinalResult = Formula> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of formulas. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FormulaFragment contains tags as expected by the patch operation."
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Formula, PatchModel = FormulaFragment>;

  /**
   * Delete formula.
   */
  delete is ArmResourceDeleteSync<Formula>;

  /**
   * List formulas in a given lab.
   */
  list is ArmResourceListByParent<
    Formula,
    Parameters = {
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
    },
    Response = ArmResponse<FormulaList>
  >;
}

@@doc(Formula.name, "The name of the formula.");
@@doc(Formula.properties, "The properties of the formula.");
@@doc(Formulas.createOrUpdate::parameters.resource,
  "A formula for creating a VM, specifying an image base and other parameters"
);
@@doc(Formulas.update::parameters.properties,
  "A formula for creating a VM, specifying an image base and other parameters"
);
