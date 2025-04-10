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
@extensionResource
model SimplifiedSolutionsResource
  is Azure.ResourceManager.ExtensionResource<SimplifiedSolutionsResourceProperties> {
  ...ResourceNameParameter<
    Resource = SimplifiedSolutionsResource,
    KeyName = "simplifiedSolutionsResourceName",
    SegmentName = "simplifiedSolutions",
    NamePattern = "^[A-Za-z0-9-+@()_]+$"
  >;
}

@armResourceOperations
interface SimplifiedSolutionsResources {
  /**
   * Get the simplified Solutions using the applicable solutionResourceName while creating the simplified Solutions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SimplifiedSolutions_Get")
  get is ArmResourceRead<
    SimplifiedSolutionsResource,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * scope = resourceUri of affected resource.<br/> For example: /subscriptions/0d0fcd2e-c4fd-4349-8497-200edb3923c6/resourcegroups/myresourceGroup/providers/Microsoft.KeyVault/vaults/test-keyvault-non-read
       */
      @path
      scope: string;

      /**
       * Simplified Solutions Resource Name.
       */
      @maxLength(100)
      @minLength(1)
      @pattern("^[A-Za-z0-9-+@()_]+$")
      @path
      simplifiedSolutionsResourceName: string;
    }
  >;

  /**
   * Creates Simplified Solutions for an Azure subscription using 'solutionId' from Discovery Solutions as the input. <br/><br/> Simplified Solutions API makes the consumption of solutions APIs easier while still providing access to the same powerful solutions rendered in Solutions API. With Simplified Solutions, users don't have to worry about stitching together the article using replacement maps and can use the content in the API response to directly render as HTML content.<br/>
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SimplifiedSolutions_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SimplifiedSolutionsResource,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * scope = resourceUri of affected resource.<br/> For example: /subscriptions/0d0fcd2e-c4fd-4349-8497-200edb3923c6/resourcegroups/myresourceGroup/providers/Microsoft.KeyVault/vaults/test-keyvault-non-read
       */
      @path
      scope: string;

      /**
       * Simplified Solutions Resource Name.
       */
      @maxLength(100)
      @minLength(1)
      @pattern("^[A-Za-z0-9-+@()_]+$")
      @path
      simplifiedSolutionsResourceName: string;
    }
  >;
}

@@maxLength(SimplifiedSolutionsResource.name, 100);
@@minLength(SimplifiedSolutionsResource.name, 1);
@@doc(SimplifiedSolutionsResource.name, "Simplified Solutions Resource Name.");
@@doc(SimplifiedSolutionsResource.properties, "Simplified Solutions result");
@@doc(SimplifiedSolutionsResources.create::parameters.resource,
  "The required request body for simplified Solutions resource creation."
);
