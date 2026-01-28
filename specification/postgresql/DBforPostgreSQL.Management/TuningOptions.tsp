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

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(IncludeMetadata)
model BaseProxyResource<IncludeMetadata extends valueof boolean = false>
  extends Foundations.ProxyResource {}
/**
 * Impact on some metric if this recommended action is applied.
 */
@parentResource(Server)
model TuningOptions is BaseProxyResource {
  ...ResourceNameParameter<
    Resource = TuningOptions,
    KeyName = "tuningOption",
    SegmentName = "tuningOptions",
    NamePattern = "",
    Type = TuningOptionParameterEnum
  >;
}

@armResourceOperations
interface TuningOptionsOperationGroup {
  /**
   * Gets the tuning options of a server.
   */
  get is ArmResourceRead<TuningOptions>;

  /**
   * Lists the tuning options of a server.
   */
  listByServer is ArmResourceListByParent<
    TuningOptions,
    Response = ArmResponse<TuningOptionsList>
  >;

  /**
   * Lists available object recommendations.
   */
  @get
  @list
  @action("recommendations")
  listRecommendations is ArmResourceActionSync<
    TuningOptions,
    void,
    ArmResponse<ObjectRecommendationList>,
    Parameters = {
      /**
       * Recommendations list filter. Retrieves recommendations based on type.
       */
      @query("recommendationType")
      recommendationType?: RecommendationTypeParameterEnum;
    }
  >;
}

@@doc(TuningOptions.name, "The name of the tuning option.");
