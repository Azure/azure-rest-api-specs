import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;

using TypeSpec.Http;


// @@alternateType(HeatMapType, "default", "go");
// @@alternateType(HeatMapType, string, "go");


  /**
   * Gets latest heatmap for Traffic Manager profile.
   */
  op get is HeatMapModelsOps.Read<
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

  @@override(HeatMapModels.get, get, "go")
  @@alternateType(get::parameters.heatMapType, "default", "go");