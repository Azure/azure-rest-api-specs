// Image Exports for STAC Collections interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.image-exports.tsp";
import "./models.common.images.tsp";

using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;
interface TilerStaticImages {
  /**
   * Create a new image export.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Create Static Image")
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
      body: ImageRequest;
    },
    TileResponse
  >;
  /**
   * Fetch an existing image export by ID
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Static Image")
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
    ImagePngResponse | NoContentResponse
  >;
}
