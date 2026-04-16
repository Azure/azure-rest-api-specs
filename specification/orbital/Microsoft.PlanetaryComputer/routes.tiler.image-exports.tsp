// Image Exports for STAC Collections interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tiler.image-exports.tsp";
import "./models.common.images.tsp";
import "./models.common.versions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;
@removed(Versions.v2026_04_15)
interface TilerStaticImages {
  /**
   * Create a new image export.
   *
   * Note: This endpoint has been deprecated and will be removed in a future API version.
   * Please use `/data/collections/{collectionId}/bbox` for image generation instead.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "The Image Exports endpoints have been deprecated and will be removed in a future API version. Please use `/data/collections/{collectionId}/bbox` for image generation instead."
  @summary("Create Static Image (Deprecated)")
  @tag("Image Exports for STAC Collections")
  @route("/data/collections/{collectionId}/image/static")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * STAC Collection ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Image request body
       */
      @body
      body: ImageParameters;
    },
    ImageResponse
  >;
  /**
   * Fetch an existing image export by ID.
   *
   * Note: This endpoint has been deprecated and will be removed in a future API version.
   * Please use `/data/collections/{collectionId}/bbox` for image generation instead.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "The Image Exports endpoints have been deprecated and will be removed in a future API version. Please use `/data/collections/{collectionId}/bbox` for image generation instead."
  @summary("Get Static Image (Deprecated)")
  @tag("Image Exports for STAC Collections")
  @route("/data/collections/{collectionId}/image/static/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * STAC Collection ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Image export ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      id: string;
    },
    ImagePngResponse
  >;
}
