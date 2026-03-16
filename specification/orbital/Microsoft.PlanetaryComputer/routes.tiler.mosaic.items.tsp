// ===========================================================================================
// Tiler endpoints missing in preview, but added in stable version 2026-04-15 to /data/mosaic/
// ===========================================================================================

// Tiles for STAC Items interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tiler.common.tsp";
import "./models.tiler.items.tsp";
import "./models.common.images.tsp";
import "./models.common.versions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;

@added(Versions.v2026_04_15)
interface MosaicItemsTileSetList {
  /**
   * Return a list of available tilesets for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tileset List")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;
    },
    TileSetList
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileSetMetadata {
  /**
   * Return metadata for a specific tileset of a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tileset Metadata")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;
    },
    TileSetMetadata
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileMatrixSetsPlain {
  /**
   * Create map tile from a dataset (without scale or format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid Plain")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      ...ZxyPathParameters;
      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileMatrixSetsFormat {
  /**
   * Create map tile from a dataset (with format in path, without scale).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid Format")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}.{format}")
  @get
  getZxyByFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      ...ZxyPathParameters;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileMatrixSetsScale {
  /**
   * Create map tile from a dataset (with scale in path, without format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid Scale")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x")
  @get
  getZxyByScale is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      ...ZxyPathParameters;

      /**
       * Numeric scale factor for the tile. Higher values produce larger tiles
       */
      @path
      scale: float32;

      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTilesPlain {
  /**
   * Create map tile from a dataset (without TileMatrixSetId, scale or format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Plain")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      ...ZxyPathParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTilesFormat {
  /**
   * Create map tile from a dataset (with format in path, without TileMatrixSetId or scale).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Format")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}.{format}")
  @get
  getZxyByFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      ...ZxyPathParameters;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTilesScale {
  /**
   * Create map tile from a dataset (with scale in path, without TileMatrixSetId or format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Scale")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}@{scale}x")
  @get
  getZxyByScale is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      ...ZxyPathParameters;

      /**
       * Numeric scale factor for the tile. Higher values produce larger tiles
       */
      @path
      scale: float32;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsFeatureGeoJson {
  /**
   * Create image from a geojson feature (without format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Feature")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/feature")
  @post
  crop is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordinateReferenceSystem?: string;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Image output size limit if width and height limits are not set.
       */
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MiscTileQueryParameters;

      /**
       * Request GeoJson body.
       */
      @body
      body: Feature;
    },
    TileResponse
  >;
}

// =====================================================================
// Item Mosaic Bbox Crop
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsBbox {
  /**
   * Create an image from part of a STAC item dataset (bounding box crop).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Bbox")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/bbox/{minx},{miny},{maxx},{maxy}.{format}")
  @get
  getCroppedToBoundingBox is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      ...BoundingBoxPathParameters;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordinateReferenceSystem?: string;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      destinationCrs?: string;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Image output size limit if width and height limits are not set.
       */
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MiscTileQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsBboxWithDimensions {
  /**
   * Create an image from part of a STAC item dataset (bounding box crop with dimensions).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Bbox With Dimensions")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/bbox/{minx},{miny},{maxx},{maxy}/{width}x{height}.{format}")
  @get
  getCroppedToBoundingBoxWidthByHeight is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      ...BoundingBoxPathParameters;

      /**
       * Force output image width
       */
      @path
      width: int32;

      /**
       * Force output image height
       */
      @path
      height: int32;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordinateReferenceSystem?: string;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      destinationCrs?: string;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      ...MiscTileQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsFeatureGeoJsonFormat {
  /**
   * Create image from a geojson feature with format.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Feature Crop With Format")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/feature.{format}")
  @post
  cropFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordinateReferenceSystem?: string;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Image output size limit if width and height limits are not set.
       */
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MiscTileQueryParameters;

      /**
       * Request GeoJson body.
       */
      @body
      body: Feature;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsFeatureGeoJsonWidthByHeight {
  /**
   * Create image from a geojson feature with dimensions.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Feature Crop With Dimensions")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/feature/{width}x{height}.{format}")
  @post
  cropWidthByHeightFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Item Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      itemId: string;

      /**
       * Width in pixels for the output image.
       */
      @path
      width: int32;

      /**
       * Height in pixels for the output image.
       */
      @path
      height: int32;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordinateReferenceSystem?: string;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Image output size limit if width and height limits are not set.
       */
      @query("max_size")
      maxSize?: int32 = 1024;

      ...MiscTileQueryParameters;

      /**
       * Request GeoJson body.
       */
      @body
      body: Feature;
    },
    TileResponse
  >;
}
