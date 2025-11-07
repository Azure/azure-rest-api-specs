// Map Legends interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.map-legends.tsp";
import "./models.common.images.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

interface MapsIntervalLegends {
  /**
   * Generate values and color swatches mapping for a given interval classmap.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Interval Legend")
  @tag("Map Legends")
  @route("/data/legend/interval/{classmapName}")
  @get
  getByClassMapName is Azure.Core.Foundations.Operation<
    {
      /**
       * classmap name
       */
      @path
      @maxLength(500)
      @pattern(".*")
      classmapName: string;

      /**
       * Number of items to trim from the start of the cmap
       */
      @query("trim_start")
      trimStart?: int32;

      /**
       * Number of items to trim from the end of the cmap
       */
      @query("trim_end")
      trimEnd?: int32;
    },
    IntervalLegendsResponse
  >;
}

interface MapsClassMapLegends {
  /**
   * Generate values and color swatches mapping for a given classmap.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get ClassMap Legend")
  @tag("Map Legends")
  @route("/data/legend/classmap/{classmapName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * classmap name
       */
      @path
      @maxLength(500)
      @pattern(".*")
      classmapName: string;

      /**
       * Number of items to trim from the start of the cmap
       */
      @query("trim_start")
      trimStart?: int32;

      /**
       * Number of items to trim from the end of the cmap
       */
      @query("trim_end")
      trimEnd?: int32;
    },
    Record<unknown>
  >;
}

interface MapsLegends {
  /**
   * Generate a legend image for a given colormap.
   *
   * If the colormap has non-contiguous values at the beginning or end,
   * which aren't desired in the output image, they can be trimmed by specifying
   * the number of values to trim.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Legend")
  @tag("Map Legends")
  @route("/data/legend/colormap/{colorMapName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the registered colormap to generate a legend for
       */
      @path
      @maxLength(500)
      @pattern(".*")
      colorMapName: string;

      /**
       * The output height of the legend image
       */
      @query("height")
      height?: float32 = 0.15;

      /**
       * The output width of the legend image
       */
      @query("width")
      width?: float32 = 5;

      /**
       * Number of items to trim from the start of the cmap
       */
      @query("trim_start")
      trimStart?: int32;

      /**
       * Number of items to trim from the end of the cmap
       */
      @query("trim_end")
      trimEnd?: int32;
    },
    ImagePngResponse
  >;
}
