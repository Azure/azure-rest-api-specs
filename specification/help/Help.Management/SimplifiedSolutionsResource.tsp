import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Help;
/**
 * Simplified Solutions response.
 */
model SimplifiedSolutionsResource
  is Azure.ResourceManager.ExtensionResource<SimplifiedSolutionsResourceProperties> {
  ...ResourceNameParameter<
    Resource = SimplifiedSolutionsResource,
    KeyName = "simplifiedSolutionsResourceName",
    SegmentName = "simplifiedSolutions",
    NamePattern = "^[A-Za-z0-9-+@()_]+$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SimplifiedSolutionsResourcesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,

        /**
         * The fully qualified Azure Resource manager identifier of the resource.
         */
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path(#{ allowReserved: true })
        scope: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * Simplified Solutions Resource Name.
         */
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("simplifiedSolutions")
        @minLength(1)
        @maxLength(100)
        @pattern("^[A-Za-z0-9-+@()_]+$")
        simplifiedSolutionsResourceName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SimplifiedSolutionsResources {
  /**
   * Get the simplified Solutions using the applicable solutionResourceName while creating the simplified Solutions.
   */
  get is ArmResourceRead<SimplifiedSolutionsResource>;

  /**
   * Creates Simplified Solutions for an Azure subscription using 'solutionId' from Discovery Solutions as the input. <br/><br/> Simplified Solutions API makes the consumption of solutions APIs easier while still providing access to the same powerful solutions rendered in Solutions API. With Simplified Solutions, users don't have to worry about stitching together the article using replacement maps and can use the content in the API response to directly render as HTML content.<br/>
   */
  create is SimplifiedSolutionsResourcesOps.CreateOrUpdateAsync<
    SimplifiedSolutionsResource,
    OptionalRequestBody = true
  >;
}

@@maxLength(SimplifiedSolutionsResource.name, 100);
@@minLength(SimplifiedSolutionsResource.name, 1);
@@doc(SimplifiedSolutionsResource.name, "Simplified Solutions Resource Name.");
@@doc(SimplifiedSolutionsResource.properties, "Simplified Solutions result");
@@doc(SimplifiedSolutionsResources.create::parameters.resource,
  "The required request body for simplified Solutions resource creation."
);
