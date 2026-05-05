// Map Legends interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.common.images.tsp";
import "./models.tiler.map-legends.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

interface MapsIntervalLegends {
  /**
   * Generate values and color swatches mapping for a given interval classmap.
   *
   * Returns a color map for intervals, where each interval is defined by:
   * - A numeric range `[min, max]` representing the interval boundaries.
   * - An RGBA color `[red, green, blue, alpha]` associated with the interval.
   *
   * The response is a 2D array of interval definitions, where each element is a pair:
   * - The first element is an array of two numbers `[min, max]` defining the interval.
   * - The second element is an array of four numbers `[red, green, blue, alpha]` defining the RGBA color.
   *
   * Example:
   * ```json
   * [
   *   [
   *     [-2, 0], [0, 0, 0, 0]
   *   ],
   *   [
   *     [1, 32], [255, 255, 178, 255]
   *   ]
   * ]
   * ```
   * This example defines two intervals:
   * - The interval `[-2, 0]` is mapped to the color `[0, 0, 0, 0]` (transparent black).
   * - The interval `[1, 32]` is mapped to the color `[255, 255, 178, 255]` (opaque yellow).
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
    ClassMapLegendResponse
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
