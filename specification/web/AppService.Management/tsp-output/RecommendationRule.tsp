import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Represents a recommendation rule that the recommendation engine can perform.
 */
@parentResource(AppServiceEnvironmentResource)
model RecommendationRule is ProxyResource<RecommendationRuleProperties> {
  /**
   * Name of the recommendation.
   */
  @path
  @key("name")
  @segment("recommendations")
  name: string;
}

@armResourceOperations
interface RecommendationRules {
  /**
   * Description for Get a recommendation rule for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_GetRuleDetailsByHostingEnvironment")
  getRuleDetailsByHostingEnvironment is ArmResourceRead<
    RecommendationRule,
    {
      ...BaseParameters<RecommendationRule>;

      /**
       * Specify <code>true</code> to update the last-seen timestamp of the recommendation object.
       */
      @query("updateSeen")
      updateSeen?: boolean;

      /**
       * The GUID of the recommendation object if you query an expired one. You don't need to specify it to query an active entry.
       */
      @query("recommendationId")
      recommendationId?: string;
    }
  >;

  /**
   * Description for Disables the specific rule for a web site permanently.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_DisableRecommendationForHostingEnvironment")
  disableRecommendationForHostingEnvironment is ArmResourceActionSync<
    RecommendationRule,
    void,
    void,
    {
      ...BaseParameters<RecommendationRule>;

      /**
       * Site name
       */
      @query("environmentName")
      environmentName: string;
    }
  >;
}
