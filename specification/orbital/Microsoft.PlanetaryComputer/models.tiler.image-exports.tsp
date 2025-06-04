// Image Exports for STAC Collections interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.common.images.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

/**
 * Parameters for requesting a rendered image from a collection
 */
model ImageRequest {
  /**
   * Cql
   */
  cql: Cql;

  /**
   * Geometry
   */
  geometry?: GeoJson;

  /**
   * JSON-encoded visualization parameters
   */
  @encodedName("application/json", "render_params")
  renderParams: string;

  /**
   * Width of the output image in pixels
   */
  cols: int32;

  /**
   * Height of the output image in pixels
   */
  rows: int32;

  /**
   * Output format for the generated image
   */
  format?: ImageRequestFormat = ImageRequestFormat.png;

  /**
   * Whether to include branding on the output image
   */
  showBranding?: boolean = true;

  /**
   * Whether to apply masking to invalid or no-data areas
   */
  mask?: boolean;
}
