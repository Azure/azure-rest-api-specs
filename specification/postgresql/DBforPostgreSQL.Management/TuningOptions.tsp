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
// FIXME: TuningOptions has no properties property
/**
 * Impact on some metric if this recommended action is applied.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Server)
model TuningOptions is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = TuningOptions,
    KeyName = "tuningOption",
    SegmentName = "tuningOptions",
    NamePattern = "",
    Type = TuningOption
  >;
}

@armResourceOperations
interface TuningOptionsOperationGroup {
  /**
   * Gets the tuning options of a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("TuningOptions_Get")
  get is ArmResourceRead<TuningOptions>;

  /**
   * Lists the tuning options of a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("TuningOptions_ListByServer")
  listByServer is ArmResourceListByParent<
    TuningOptions,
    Response = ArmResponse<TuningOptionsList>
  >;

  /**
   * Lists available object recommendations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("TuningOptions_ListRecommendations")
  @get
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
      recommendationType?: RecommendationType;
    }
  >;
}

@@doc(TuningOptions.name, "The name of the tuning option.");
