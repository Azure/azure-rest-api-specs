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
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model Formula extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("formulas")
  name: string;

  properties: FormulaProperties;
}

@armResourceOperations
interface FormulaOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = Formula,
        KeyName = "name",
        SegmentName = "formulas",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Formulas {
  /**
   * Get formula.
   */
  get is FormulaOps.Read<
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
  createOrUpdate is FormulaOps.CreateOrUpdateAsync<
    Formula,
    LroHeaders = ArmLroLocationHeader<FinalResult = Formula> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of formulas. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FormulaFragment contains tags as expected by the patch operation."
  @patch(#{ implicitOptionality: false })
  update is FormulaOps.CustomPatchSync<Formula, PatchModel = FormulaFragment>;

  /**
   * Delete formula.
   */
  delete is FormulaOps.DeleteSync<Formula>;

  /**
   * List formulas in a given lab.
   */
  list is FormulaOps.List<
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
