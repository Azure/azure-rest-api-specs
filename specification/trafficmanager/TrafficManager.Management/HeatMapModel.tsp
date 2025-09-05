import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Class representing a Traffic Manager HeatMap.
 */
@parentResource(Profile)
model HeatMapModel is Azure.ResourceManager.ProxyResource<HeatMapProperties> {
  ...ResourceNameParameter<
    Resource = HeatMapModel,
    KeyName = "heatMap",
    SegmentName = "heatMaps",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface HeatMapModels {
  /**
   * Gets latest heatmap for Traffic Manager profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @armResourceRead(HeatMapModel)
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficmanagerprofiles/{profileName}/heatMaps/{heatMapType}")
  @operationId("HeatMap_Get")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Traffic Manager profile.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    profileName?: string,

    /**
     * The type of the heatmap.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    heatMapType?: HeatMapType,

    /**
     * The top left latitude,longitude pair of the rectangular viewport to query for.
     */
    @query("topLeft")
    @minItems(2)
    @maxItems(2)
    @OpenAPI.extension("allowEmptyValue", true)
    topLeft?: float64[],

    /**
     * The bottom right latitude,longitude pair of the rectangular viewport to query for.
     */
    @query("botRight")
    @minItems(2)
    @maxItems(2)
    @OpenAPI.extension("allowEmptyValue", true)
    botRight?: float64[],
  ): ArmResponse<HeatMapModel> | CloudError;
}

@@doc(HeatMapModel.name, "");
@@doc(HeatMapModel.properties,
  "The properties of the Traffic Manager HeatMap."
);
