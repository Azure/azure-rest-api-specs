import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
// FIXME: TuningOptionsResource has no properties property
/**
 * Stores property that features impact on some metric if this recommended action is applied.
 */
@parentResource(Server)
model TuningOptionsResource is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = TuningOptionsResource,
    KeyName = "tuningOption",
    SegmentName = "tuningOptions",
    NamePattern = "",
    Type = TuningOptionEnum
  >;
}

@armResourceOperations
interface TuningOptionsResources {
  /**
   * Retrieve the tuning option on a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TuningOptions_Get")
  get is ArmResourceRead<TuningOptionsResource>;

  /**
   * Retrieve the list of available tuning options.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TuningOptions_ListByServer")
  listByServer is ArmResourceListByParent<TuningOptionsResource>;

  /**
   * Retrieve the list of available tuning index recommendations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("recommendations")
  @operationId("TuningOptions_ListRecommendations")
  listRecommendations is ArmResourceActionSync<
    TuningOptionsResource,
    void,
    ArmResponse<ResourceListResult<IndexRecommendationResource>>,
    Parameters = {
      /**
       * Recommendations list filter. Retrieves recommendations based on type.
       */
      @query("$recommendationType")
      $recommendationType?: RecommendationType;
    }
  >;
}

@@doc(TuningOptionsResource.name, "The name of the tuning option.");
