import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface RecommendationRuleOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the hosting environment. */
        @path
        @segment("hostingEnvironments")
        @key
        hostingEnvironmentName: string,
      },
      {
        /** Name of the recommendation. */
        @path
        @segment("recommendations")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface RecommendationRules {
  /**
   * Description for Get a recommendation rule for an app.
   */
  @summary("Get a recommendation rule for an app.")
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Disables the specific rule for a web site permanently.
   */
  @summary("Disables the specific rule for a web site permanently.")
  @action("disable")
  disableRecommendationForHostingEnvironment is RecommendationRuleOps.ActionSync<
    RecommendationRule,
    void,
    {
      @body body: void;
    },
    Parameters = {
      /**
       * Site name
       */
      @query("environmentName")
      environmentName: string;
    },
    OverrideErrorType = DefaultErrorResponse
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

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        siteName: string,
      },
      {
        /** Name of the recommendation. */
        @path
        @segment("recommendations")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface Recommendations {
  /**
   * Description for Get a recommendation rule for an app.
   */
  @summary("Get a recommendation rule for an app.")
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Disables the specific rule for a web site permanently.
   */
  @summary("Disables the specific rule for a web site permanently.")
  @action("disable")
  disableRecommendationForSite is RecommendationOps.ActionSync<
    RecommendationRule,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(RecommendationRule.name, "Name of the recommendation.");
@@doc(RecommendationRule.properties,
  "RecommendationRule resource specific properties"
);
