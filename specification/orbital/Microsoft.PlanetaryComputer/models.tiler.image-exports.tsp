// Image Exports for STAC Collections interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.common.images.tsp";

namespace Microsoft.PlanetaryComputer;

/**
 * Parameters for requesting a rendered image from a collection
 */
model ImageRequest {
  /**
   * Cql
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "CQL2-JSON query requires union types."
  cql: Record<unknown>;

  /**
   * Geometry
   */
  geometry?: Geometry;

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
  format?: TilerImageExportFormat = TilerImageExportFormat.png;

  /**
   * Whether to include branding on the output image
   */
  showBranding?: boolean = true;

  /**
   * Whether to apply masking to invalid or no-data areas
   */
  mask?: boolean;
}

/**
 * Response model for image exports
 */
model ImageResponse {
  /**
   * URL of the exported image
   */
  url: url;
}
