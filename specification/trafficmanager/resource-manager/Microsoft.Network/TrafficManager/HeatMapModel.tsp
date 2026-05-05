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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Profile)
model HeatMapModel extends ProxyResource {
  properties?: HeatMapProperties;
}

alias HeatMapModelsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<HeatMapModel>;
    ...ParentKeysOf<HeatMapModel>;

    /**
     * The name of the Traffic Manager profile.
     */
    @path
    @segment("trafficmanagerprofiles")
    profileName: string;
  },
  {
    /**
     * The type of the heatmap.
     */
    @path
    @segment("heatMaps")
    @key("heatMapType")
    heatMapType: HeatMapType;
  },
  ErrorType = CloudError
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface HeatMapModels {
  /**
   * Gets latest heatmap for Traffic Manager profile.
   */
  get is HeatMapModelsOps.Read<
    HeatMapModel,
    Parameters = {
      /**
       * The top left latitude,longitude pair of the rectangular viewport to query for.
       */
      @query("topLeft")
      @minItems(2)
      @maxItems(2)
      topLeft?: float64[];

      /**
       * The bottom right latitude,longitude pair of the rectangular viewport to query for.
       */
      @query("botRight")
      @minItems(2)
      @maxItems(2)
      botRight?: float64[];
    }
  >;
}

@@doc(HeatMapModel.properties,
  "The properties of the Traffic Manager HeatMap."
);
