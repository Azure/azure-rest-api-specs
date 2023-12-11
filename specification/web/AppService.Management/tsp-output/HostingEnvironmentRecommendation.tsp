import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Represents a recommendation rule that the recommendation engine can perform.")
@parentResource(AppServiceEnvironment)
model HostingEnvironmentRecommendation
  is ProxyResource<RecommendationRuleProperties> {
  @doc("Name of the recommendation.")
  @path
  @key("name")
  @segment("recommendations")
  name: string;
}

@armResourceOperations
interface HostingEnvironmentRecommendations {
  @doc("Description for Get a recommendation rule for an app.")
  getRuleDetailsByHostingEnvironment is ArmResourceRead<
    HostingEnvironmentRecommendation,
    {
      ...BaseParameters<HostingEnvironmentRecommendation>;

      @doc("Specify <code>true</code> to update the last-seen timestamp of the recommendation object.")
      @query("updateSeen")
      updateSeen?: boolean;

      @doc("The GUID of the recommendation object if you query an expired one. You don't need to specify it to query an active entry.")
      @query("recommendationId")
      recommendationId?: string;
    }
  >;
  @doc("Description for Disables the specific rule for a web site permanently.")
  disableRecommendationForHostingEnvironment is ArmResourceActionSync<
    HostingEnvironmentRecommendation,
    {},
    {},
    {
      ...BaseParameters<HostingEnvironmentRecommendation>;

      @doc("Site name")
      @query("environmentName")
      environmentName: string;
    }
  >;
}
