// Vector Tiles interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.common.tsp";
import "./models.tiler.vector.tsp";
import "./models.common.versions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;

@doc("This API is based on the OGC API - Tiles standard defined here: https://github.com/opengeospatial/ogcapi-tiles/tree/master/openapi")
interface VectorTilesBase {
  /**
   * Retrieve the OGC API landing page for this service.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve the OGC API landing page for this service.")
  @tag("Landing Page")
  @route("/data/vector/")
  @get
  getLandingPage is Azure.Core.Foundations.Operation<
    {
      /**
       * The format of the response. If no value is provided, the accept header is used to determine the format. Accepted values are 'json'.
       */
      @query("f")
      f?: "json";
    },
    VectorLandingPage
  >;

  /**
   * Retrieve the set of OGC API conformance classes that are supported by this service.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve the set of OGC API conformance classes that are supported by this service.")
  @tag("Conformance")
  @route("/data/vector/conformance")
  @get
  getConformance is Azure.Core.Foundations.Operation<
    {
      /**
       * The format of the response. If no value is provided, the accept header is used to determine the format. Accepted values are 'json'.
       */
      @query("f")
      f?: "json";
    },
    Conformance
  >;
}

@doc("This API is based on the OGC API - Tiles standard defined here: https://github.com/opengeospatial/ogcapi-tiles/tree/master/openapi")
interface VectorStyles {
  /**
   * Retrieve the list of dataset styles available from this API implementation & deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve the list of available dataset styles.")
  @tag("Styles")
  @route("/data/vector/styles")
  @get
  getApiStyles is Azure.Core.Foundations.Operation<
    {
      /**
       * The format of the response. If no value is provided, the accept header is used to determine the format. Accepted values are 'json'.
       */
      @query("f")
      f?: "json";
    },
    MapboxStylesList
  >;

  /**
   * Create a new style
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Create a new style")
  @tag("Styles")
  @route("/data/vector/styles")
  @post
  createStyle is Azure.Core.Foundations.Operation<
    {
      /**
       * The style to create
       */
      @body style: MapboxStyle;
    },
    MapboxStyle
  >;

  /**
   * Retrieve a style
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve a style")
  @tag("Styles")
  @route("/data/vector/styles/{styleId}")
  @get
  getStyle is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier of the style
       */
      @path
      styleId: string;
    },
    MapboxStyle
  >;

  /**
   * Update or create a style
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Update or create a style")
  @tag("Styles")
  @route("/data/vector/styles/{styleId}")
  @put
  createOrReplaceStyle is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier of the style
       */
      @path
      styleId: string;

      /**
       * The style to create or update
       */
      @body style: MapboxStyle;
    },
    MapboxStyle
  >;

  /**
   * Delete a style
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Delete a style")
  @tag("Styles")
  @route("/data/vector/styles/{styleId}")
  @delete
  deleteStyle is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier of the style
       */
      @path
      styleId: string;
    },
    void
  >;
}

@doc("This API is based on the OGC API - Tiles standard defined here: https://github.com/opengeospatial/ogcapi-tiles/tree/master/openapi")
interface VectorTileMatrixSets {
  /**
   * Retrieve the list of available tiling schemes (tile matrix sets)
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve the list of available tiling schemes (tile matrix sets)")
  @tag("Tiling Schemes")
  @route("/data/vector/tileMatrixSets")
  @get
  getTileMatrixSetsList is Azure.Core.Foundations.Operation<
    {
      /**
       * The format of the response. If no value is provided, the accept header is used to determine the format. Accepted values are 'json'.
       */
      @query("f")
      f?: "json";
    },
    TileMatrixSetsList
  >;

  /**
   * Retrieve the definition of the specified tiling scheme (tile matrix set)
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve the definition of the specified tiling scheme (tile matrix set)")
  @tag("Tiling Schemes")
  @route("/data/vector/tileMatrixSets/{tileMatrixSetId}")
  @get
  getTileMatrixSet is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier for a supported TileMatrixSet
       */
      @path
      tileMatrixSetId: string;

      /**
       * The format of the response. If no value is provided, the accept header is used to determine the format. Accepted values are 'json'.
       */
      @query("f")
      f?: "json";
    },
    TileMatrixSet
  >;
}

@doc("This API is based on the OGC API - Tiles standard defined here: https://github.com/opengeospatial/ogcapi-tiles/tree/master/openapi")
interface VectorTilesOperations {
  /**
   * Retrieve a list of available vector tilesets for the specified collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve a list of available vector tilesets for the specified collection.")
  @tag("Vector Tiles")
  @route("/data/vector/collections/{collectionId}/tiles")
  @get
  getTileSetsList is Azure.Core.Foundations.Operation<
    {
      /**
       * Local identifier of a vector tile collection
       */
      @path
      collectionId: string;

      /**
       * The format of the response. If no value is provided, the accept header is used to determine the format. Accepted values are 'json'.
       */
      @query("f")
      f?: "json";
    },
    TileSetsList
  >;

  /**
   * Retrieve the vector tileset metadata for the specified collection and tiling scheme (tile matrix set)
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve the vector tileset metadata.")
  @tag("Vector Tiles")
  @route("/data/vector/collections/{collectionId}/tiles/{tileMatrixSetId}")
  @get
  getTileSet is Azure.Core.Foundations.Operation<
    {
      /**
       * Local identifier of a vector tile collection
       */
      @path
      collectionId: string;

      /**
       * Identifier for a supported TileMatrixSet
       */
      @path
      tileMatrixSetId: string;

      /**
       * The format of the response. If no value is provided, the accept header is used to determine the format. Accepted values are 'json'.
       */
      @query("f")
      f?: "json";
    },
    TileSet
  >;

  /**
   * Retrieve a vector tile from a collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve a vector tile from a collection.")
  @tag("Vector Tiles")
  @route("/data/vector/collections/{collectionId}/tiles/{tileMatrixSetId}/{tileMatrix}/{tileRow}/{tileCol}")
  @get
  getTile is Azure.Core.Foundations.Operation<
    {
      /**
       * Local identifier of a vector tile collection
       */
      @path
      collectionId: string;

      /**
       * Identifier for a supported TileMatrixSet
       */
      @path
      tileMatrixSetId: string;

      /**
       * Identifier selecting one of the scales defined in the TileMatrixSet
       */
      @path
      tileMatrix: string;

      /**
       * Row index of the tile on the selected TileMatrix
       */
      @path
      @minValue(0)
      tileRow: int32;

      /**
       * Column index of the tile on the selected TileMatrix
       */
      @path
      @minValue(0)
      tileCol: int32;

      /**
       * The format of the vector tile response. Accepted values are 'mvt' (Mapbox Vector Tiles).
       */
      @query("f")
      f?: "mvt";
    },
    VectorTile
  >;
}

@doc("This API is based on the OGC API - Tiles standard defined here: https://github.com/opengeospatial/ogcapi-tiles/tree/master/openapi")
interface VectorSearchTilesOperations {
  /**
   * Retrieve a list of available vector tilesets for the specified search.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve a list of available vector tilesets for the specified search.")
  @tag("Vector Tiles")
  @route("/data/vector/{searchId}/tiles")
  @get
  getSearchTileSetsList is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier of a search
       */
      @path
      searchId: string;

      /**
       * The format of the response. If no value is provided, the accept header is used to determine the format. Accepted values are 'json'.
       */
      @query("f")
      f?: "json";
    },
    TileSetsList
  >;

  /**
   * Retrieve the vector tileset metadata for the specified search and tiling scheme (tile matrix set)
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve the vector tileset metadata.")
  @tag("Vector Tiles")
  @route("/data/vector/{searchId}/tiles/{tileMatrixSetId}")
  @get
  getSearchTileSet is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier of a search
       */
      @path
      searchId: string;

      /**
       * Identifier for a supported TileMatrixSet
       */
      @path
      tileMatrixSetId: string;

      /**
       * The format of the response. If no value is provided, the accept header is used to determine the format. Accepted values are 'json'.
       */
      @query("f")
      f?: "json";
    },
    TileSet
  >;

  /**
   * Retrieve a vector tile from a search.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @added(Versions.v2025_04_30_Preview)
  @summary("Retrieve a vector tile from a search.")
  @tag("Vector Tiles")
  @route("/data/vector/{searchId}/tiles/{tileMatrixSetId}/{tileMatrix}/{tileRow}/{tileCol}")
  @get
  getSearchTile is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier of a search
       */
      @path
      searchId: string;

      /**
       * Identifier for a supported TileMatrixSet
       */
      @path
      tileMatrixSetId: string;

      /**
       * Identifier selecting one of the scales defined in the TileMatrixSet
       */
      @path
      tileMatrix: string;

      /**
       * Row index of the tile on the selected TileMatrix
       */
      @path
      @minValue(0)
      tileRow: int32;

      /**
       * Column index of the tile on the selected TileMatrix
       */
      @path
      @minValue(0)
      tileCol: int32;

      /**
       * The format of the vector tile response. Accepted values are 'mvt' (Mapbox Vector Tiles).
       */
      @query("f")
      f?: "mvt";
    },
    VectorTile
  >;
}
