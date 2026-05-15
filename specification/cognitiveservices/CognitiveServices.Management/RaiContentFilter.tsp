import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Azure OpenAI Content Filter.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model RaiContentFilter
  is Azure.ResourceManager.ProxyResource<RaiContentFilterProperties> {
  ...ResourceNameParameter<
    Resource = RaiContentFilter,
    KeyName = "filterName",
    SegmentName = "raiContentFilters",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
}

@armResourceOperations
interface RaiContentFilters {
  /**
   * Get Content Filters by Name.
   */
  get is ArmResourceRead<
    RaiContentFilter,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List Content Filters types.
   */
  list is ArmResourceListByParent<
    RaiContentFilter,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = RaiContentFilterListResult
  >;
}

@@doc(RaiContentFilter.name, "The name of the RAI Content Filter.");
@@doc(RaiContentFilter.properties, "Azure OpenAI Content Filter Properties.");
