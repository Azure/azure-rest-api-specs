// Tile Matrix Sets interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.tile-matrix-sets.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;
interface TileMatrixList {
  /**
   * Return Matrix List
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Matrix List")
  @tag("Tile Matrix Sets")
  @route("/data/tile-matrix-sets")
  @get
  get is Azure.Core.Foundations.Operation<{}, string[] | NoContentResponse>;
}

interface TileMatrixDefinitions {
  /**
   * Return Matrix Definition
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Matrix Definition")
  @tag("Tile Matrix Sets")
  @route("/data/tile-matrix-sets/{tileMatrixSetId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       *  Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;
    },
    TileMatrixSet
  >;
}
