import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Represents a recommendation rule that the recommendation engine can perform.
 */
model RecommendationRule
  is Azure.ResourceManager.ProxyResource<RecommendationRuleProperties> {
  ...ResourceNameParameter<
    Resource = RecommendationRule,
    KeyName = "name",
    SegmentName = "recommendations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RecommendationRuleOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** hostingEnvironments */
        @path @segment("hostingEnvironments") hostingEnvironmentName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = RecommendationRule,
        KeyName = "name",
        SegmentName = "recommendations",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface RecommendationRules {
  /**
   * Description for Get a recommendation rule for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Recommendations_GetRuleDetailsByHostingEnvironment")
  getRuleDetailsByHostingEnvironment is RecommendationRuleOps.Read<
    RecommendationRule,
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("disable")
  @operationId("Recommendations_DisableRecommendationForHostingEnvironment")
  disableRecommendationForHostingEnvironment is RecommendationRuleOps.ActionSync<
    RecommendationRule,
    void,
    OkResponse,
    Parameters = {
      /**
       * Site name
       */
      @query("environmentName")
      environmentName: string;
    }
  >;
}
@armResourceOperations
interface RecommendationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** sites */
        @path @segment("sites") siteName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = RecommendationRule,
        KeyName = "name",
        SegmentName = "recommendations",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Recommendations {
  /**
   * Description for Get a recommendation rule for an app.
   */
  getRuleDetailsByWebApp is RecommendationOps.Read<
    RecommendationRule,
    Parameters = {
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
  @action("disable")
  disableRecommendationForSite is RecommendationOps.ActionSync<
    RecommendationRule,
    void,
    OkResponse
  >;
}

@@doc(RecommendationRule.name, "Name of the recommendation.");
@@doc(RecommendationRule.properties,
  "RecommendationRule resource specific properties"
);
