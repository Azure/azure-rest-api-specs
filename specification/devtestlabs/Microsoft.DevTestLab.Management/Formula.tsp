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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model Formula extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("formulas")
  formulaName: string;

  properties: FormulaProperties;
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
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
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

@@doc(Formula.formulaName, "The name of the formula.");
@@doc(Formula.properties, "The properties of the resource.");
@@doc(Formulas.createOrUpdate::parameters.resource,
  "A formula for creating a VM, specifying an image base and other parameters"
);
@@doc(Formulas.update::parameters.properties,
  "A formula for creating a VM, specifying an image base and other parameters"
);

@@doc(Formula.tags, "The tags of the resource.");
@@doc(Formula.location, "The location of the resource.");
