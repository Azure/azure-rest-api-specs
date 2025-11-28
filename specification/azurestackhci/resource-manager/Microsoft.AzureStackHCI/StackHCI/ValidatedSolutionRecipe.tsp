import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Represents a validated solution recipe resource.
 */
@subscriptionResource
model ValidatedSolutionRecipe
  is Azure.ResourceManager.ProxyResource<ValidatedSolutionRecipeProperties> {
  ...ResourceNameParameter<
    Resource = ValidatedSolutionRecipe,
    KeyName = "validatedSolutionRecipeName",
    SegmentName = "validatedSolutionRecipes",
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
interface ValidatedSolutionRecipesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...Azure.ResourceManager.LocationParameter,
      },
      {
        /** Represents a validated solution recipe resource. */
        @path
        @segment("validatedSolutionRecipes")
        @key
        @pattern("^[a-zA-Z0-9-.]{3,50}$")
        validatedSolutionRecipeName: string,
      }
    > {}

@armResourceOperations
interface ValidatedSolutionRecipes {
  /**
   * Get a validated solution recipe.
   */
  get is ValidatedSolutionRecipesOps.Read<ValidatedSolutionRecipe>;

  /**
   * List all validated solution recipes.
   */
  listBySubscriptionLocationResource is ValidatedSolutionRecipesOps.List<ValidatedSolutionRecipe>;
}

@@doc(ValidatedSolutionRecipe.name, "The name of the ValidatedSolutionRecipe");
@@doc(ValidatedSolutionRecipe.properties,
  "The resource-specific properties for this resource."
);
