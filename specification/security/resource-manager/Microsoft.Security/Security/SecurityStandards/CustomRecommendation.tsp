import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SecurityStandardsAPI;
/**
 * Custom Recommendation
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model CustomRecommendation
  is Azure.ResourceManager.ExtensionResource<CustomRecommendationProperties> {
  ...ResourceNameParameter<
    Resource = CustomRecommendation,
    KeyName = "customRecommendationName",
    SegmentName = "customRecommendations",
    NamePattern = "[{]?[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$"
  >;
}

@armResourceOperations
interface CustomRecommendations {
  /**
   * Get a specific custom recommendation for the requested scope by customRecommendationName
   */
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.ScopeParameter,
    CustomRecommendation
  >;

  /**
   * Creates or updates a custom recommendation over a given scope
   */
  createOrUpdate is Azure.ResourceManager.Extension.CreateOrReplaceSync<
    Azure.ResourceManager.Extension.ScopeParameter,
    CustomRecommendation
  >;

  /**
   * Delete a custom recommendation over a given scope
   */
  delete is Azure.ResourceManager.Extension.DeleteSync<
    Azure.ResourceManager.Extension.ScopeParameter,
    CustomRecommendation
  >;

  /**
   * Get a list of all relevant custom recommendations over a scope
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    CustomRecommendation,
    Response = ArmResponse<CustomRecommendationsList>
  >;
}

@@doc(CustomRecommendation.name, "Name of the Custom Recommendation.");
@@doc(CustomRecommendation.properties,
  "describes Custom Recommendation properties."
);
@@doc(CustomRecommendations.createOrUpdate::parameters.resource,
  "Custom Recommendation body"
);
