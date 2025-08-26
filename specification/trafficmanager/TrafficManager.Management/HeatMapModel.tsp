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
@singleton("default")
@parentResource(Profile)
model HeatMapModel is Azure.ResourceManager.ProxyResource<HeatMapProperties> {
  ...ResourceNameParameter<
    Resource = HeatMapModel,
    KeyName = "heatMap",
    SegmentName = "heatMaps",
    NamePattern = ""
  >;
}

@armResourceOperations
interface HeatMapModels {
  /**
   * Gets latest heatmap for Traffic Manager profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HeatMap_Get")
  get is ArmResourceRead<
    HeatMapModel,
    Parameters = {
      /**
       * The top left latitude,longitude pair of the rectangular viewport to query for.
       */
      @query("topLeft")
      topLeft?: float64[];

      /**
       * The bottom right latitude,longitude pair of the rectangular viewport to query for.
       */
      @query("botRight")
      botRight?: float64[];
    }
  >;
}

@@doc(HeatMapModel.name, "");
@@doc(HeatMapModel.properties,
  "The properties of the Traffic Manager HeatMap."
);
