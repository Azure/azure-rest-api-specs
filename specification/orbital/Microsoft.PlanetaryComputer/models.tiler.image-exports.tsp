// Image Exports for STAC Collections interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.common.images.tsp";

namespace Microsoft.PlanetaryComputer;

/**
 * Parameters for requesting a rendered image from a collection
 */
model ImageParameters {
  /**
   * Cql
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "CQL2-JSON query requires union types."
  cql: Record<unknown>;

  /**
   * Zoom
   */
  zoom?: float32;

  /**
   * Geometry
   */
  geometry?: Geometry;

  /**
   * JSON-encoded visualization parameters
   */
  @encodedName("application/json", "render_params")
  renderParameters: string;

  /**
   * Width of the output image in pixels
   */
  @encodedName("application/json", "cols")
  columns: int32;

  /**
   * Height of the output image in pixels
   */
  rows: int32;

  /**
   * Whether to include branding on the output image
   */
  showBranding?: boolean = true;

  /**
   * Image size
   */
  @pattern("^[1-9][0-9]*x[1-9][0-9]*$")
  imageSize?: string;
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
