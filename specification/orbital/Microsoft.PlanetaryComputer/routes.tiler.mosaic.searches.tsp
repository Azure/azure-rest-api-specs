// Search-based Mosaic endpoints with /searches/ path segment (stable 2026-04-15 only)
// Based on: https://github.com/stac-utils/titiler-pgstac/blob/1.8.1/docs/src/endpoints/searches_endpoints.md
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tiler.common.tsp";
import "./models.tiler.mosaics.tsp";
import "./models.tiler.items.tsp";
import "./models.common.versions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;

// =====================================================================
// #1 - Tileset List
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesTileSetList {
  /**
   * Return a list of available tilesets for a mosaic search.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tileset List")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;
    },
    TileSetList
  >;
}

// =====================================================================
// #2 - Tileset Metadata
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesTileSetMetadata {
  /**
   * Return metadata for a specific tileset of a mosaic search.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tileset Metadata")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

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

// =====================================================================
// #3 - Tiles with TileMatrixSetId (4 variants)
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesTileMatrixSets {
  /**
   * Create map tile (with TileMatrixSetId, scale, and format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tile Tilematrixsetid")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

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

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicSearchesTileMatrixSetsPlain {
  /**
   * Create map tile (with TileMatrixSetId, without scale or format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tile Tilematrixsetid Plain")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      ...ZxyPathParameters;

      /** Output format for the tile or image (e.g., png, jpeg, webp) */
      @query("format")
      format?: TilerImageFormat;

      /** Numeric scale factor for the tile. Higher values produce larger tiles */
      @query("scale")
      scale?: int32;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicSearchesTileMatrixSetsFormat {
  /**
   * Create map tile (with TileMatrixSetId and format, without scale).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tile Tilematrixsetid Format")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}.{format}")
  @get
  getZxyByFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

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

      /** Numeric scale factor for the tile. Higher values produce larger tiles */
      @query("scale")
      scale?: int32;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicSearchesTileMatrixSetsScale {
  /**
   * Create map tile (with TileMatrixSetId and scale, without format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tile Tilematrixsetid Scale")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x")
  @get
  getZxyByScale is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

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

      /** Output format for the tile or image (e.g., png, jpeg, webp) */
      @query("format")
      format?: TilerImageFormat;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileResponse
  >;
}

// =====================================================================
// #7 - Assets for Tile (with TileMatrixSetId)
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesAssetsForTileMatrixSets {
  /**
   * Return a list of assets which overlap a given tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Assets For Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}/assets")
  @get
  getZxyAssets is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      /**
       * STAC Collection Identifier
       */
      @query("collection")
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      ...ZxyPathParameters;
    },
    TilerAssetGeoJson[]
  >;
}

// =====================================================================
// #5 - TileJSON with TileMatrixSetId
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesTileMatrixSetsTileJson {
  /**
   * Return TileJSON document for a search with TileMatrixSetId as path.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches TileJson Tilematrixsetid As Path")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/{tileMatrixSetId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      ...ZoomQueryParameters;

      /**
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tile_format")
      tileFormat?: TilerImageFormat;

      /**
       * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
       */
      @maxValueExclusive(4)
      @query("tile_scale")
      tileScale?: int32;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileJsonMetadata
  >;
}

// =====================================================================
// #6 - WMTS with TileMatrixSetId
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesWmtsTileMatrixSets {
  /**
   * OGC WMTS endpoint with TileMatrixSetId as path.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Wmts Tilematrixsetid As Path")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/{tileMatrixSetId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      /**
       * Output image type. Default is png.
       */
      @query("tile_format")
      tileFormat?: TilerImageFormat = TilerImageFormat.png;

      /**
       * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
       */
      @maxValueExclusive(4)
      @query("tile_scale")
      tileScale?: int32 = 1;

      ...ZoomQueryParameters;
      ...AssetQueryParameters;
    },
    WmtsCapabilitiesXmlResponse
  >;
}

// =====================================================================
// #13 - Search Info
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesInfoSearch {
  /**
   * Get Search query metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Info")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/info")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;
    },
    TilerStacSearchRegistration
  >;
}

// =====================================================================
// #10 - Bbox Crop (NEW - 2 variants)
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesBbox {
  /**
   * Create an image from part of a dataset (bounding box crop).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Bbox")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/bbox/{minx},{miny},{maxx},{maxy}.{format}")
  @get
  getCroppedToBoundingBox is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...BoundingBoxPathParameters;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst_crs")
      destinationCrs?: string;

      /**
       * Image output size limit if width and height limits are not set.
       */
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicSearchesBboxWithDimensions {
  /**
   * Create an image from part of a dataset (bounding box crop with dimensions).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Bbox With Dimensions")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/bbox/{minx},{miny},{maxx},{maxy}/{width}x{height}.{format}")
  @get
  getCroppedToBoundingBoxWidthByHeight is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

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
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst_crs")
      destinationCrs?: string;

      /**
       * Image output size limit if width and height limits are not set.
       */
      @query("max_size")
      maxSize?: int32 = 1024;

      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
    },
    TileResponse
  >;
}

// =====================================================================
// Searches Mosaic Assets for Bbox
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesAssetsForBbox {
  /**
   * Return a list of assets which overlap a given bounding box for a search.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Assets For Bbox")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/bbox/{minx},{miny},{maxx},{maxy}/assets")
  @get
  getBboxAssets is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;
      ...BoundingBoxPathParameters;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;
    },
    ApplicationJsonResponse
  >;
}

// =====================================================================
// Searches Mosaic Feature GeoJson Crop (POST with Feature body)
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesFeatureGeoJson {
  /**
   * Create image from a geojson feature (without format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Geojson Feature")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/feature")
  @post
  crop is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;

      /**
       * Image output size limit if width and height limits are not set.
       */
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
      ...DstCrsQueryParameter;

      /**
       * Output image format.
       */
      @query("format")
      format?: TilerImageFormat;

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
interface MosaicSearchesFeatureGeoJsonFormat {
  /**
   * Create image from a geojson feature with format.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Geojson Feature Crop With Format")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/feature.{format}")
  @post
  cropFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;

      /**
       * Image output size limit if width and height limits are not set.
       */
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
      ...DstCrsQueryParameter;

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
interface MosaicSearchesFeatureGeoJsonWidthByHeight {
  /**
   * Create image from a geojson feature with dimensions.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Geojson Feature Crop With Dimensions")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/feature/{width}x{height}.{format}")
  @post
  cropWidthByHeightFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

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
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;

      /**
       * Image output size limit if width and height limits are not set.
       */
      @query("max_size")
      maxSize?: int32 = 1024;

      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
      ...DstCrsQueryParameter;

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
// Remaining /searches/ equivalents for consistency
// =====================================================================

// WMTS without TMS in path (TMS as query)
@added(Versions.v2026_04_15)
interface MosaicSearchesWmts {
  /**
   * OGC WMTS endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Wmts")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("TileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      /**
       * Output image type. Default is png.
       */
      @query("tile_format")
      tileFormat?: TilerImageFormat = TilerImageFormat.png;

      /**
       * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
       */
      @maxValueExclusive(4)
      @query("tile_scale")
      tileScale?: int32 = 1;

      ...ZoomQueryParameters;
      ...AssetQueryParameters;
    },
    WmtsCapabilitiesXmlResponse
  >;
}

// TileJSON without TMS in path (TMS as query)
@added(Versions.v2026_04_15)
interface MosaicSearchesTileJson {
  /**
   * Return TileJSON document for a search.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches TileJson")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad').
       */
      @query("TileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      /**
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tile_format")
      tileFormat?: TilerImageFormat;

      /**
       * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
       */
      @query("tile_scale")
      @minValueExclusive(0)
      @maxValueExclusive(4)
      tileScale?: int32;

      ...ZoomQueryParameters;

      /**
       * Padding to apply to each tile edge. Helps reduce resampling artefacts along edges. Defaults to `0`.
       */
      @query
      @minValueExclusive(0)
      padding?: int32;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      @minValueExclusive(0)
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collectionId?: string;

      /**
       * Resampling method
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixel_selection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Terrain algorithm name
       */
      @query("algorithm")
      algorithm?: TerrainAlgorithm;

      /**
       * Terrain algorithm parameters
       */
      @query("algorithm_params")
      algorithmParams?: string;

      /**
       * comma (',') delimited Min,Max range. Can set multiple time for multiple bands.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      rescale?: string[];

      /**
       * Colormap name
       */
      @query("colormap_name")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("return_mask")
      returnMask?: boolean = true;
    },
    TileJsonMetadata
  >;
}

// Tiles without TMS (4 variants)
@added(Versions.v2026_04_15)
interface MosaicSearchesTilesPlain {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tile Plain")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
      /** Search Id (pgSTAC Search Hash) */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...ZxyPathParameters;

      /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
      @query("TileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      /** Output format for the tile or image (e.g., png, jpeg, webp) */
      @query("format")
      format?: TilerImageFormat;

      /** Numeric scale factor for the tile. Higher values produce larger tiles */
      @query("scale")
      scale?: int32;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicSearchesTilesFormat {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tile Format")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{z}/{x}/{y}.{format}")
  @get
  getZxyByFormat is Azure.Core.Foundations.Operation<
    {
      /** Search Id (pgSTAC Search Hash) */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...ZxyPathParameters;

      /** Output format for the tile or image (e.g., png, jpeg, webp) */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
      @query("TileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      /** Numeric scale factor for the tile. Higher values produce larger tiles */
      @query("scale")
      scale?: int32;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicSearchesTilesScale {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tile Scale")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{z}/{x}/{y}@{scale}x")
  @get
  getZxyByScale is Azure.Core.Foundations.Operation<
    {
      /** Search Id (pgSTAC Search Hash) */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...ZxyPathParameters;

      /** Numeric scale factor for the tile. Higher values produce larger tiles */
      @path scale: float32;

      /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
      @query("TileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      /** Output format for the tile or image (e.g., png, jpeg, webp) */
      @query("format")
      format?: TilerImageFormat;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicSearchesTiles {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Tile")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
    {
      /** Search Id (pgSTAC Search Hash) */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...ZxyPathParameters;

      /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
      @query("TileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      /** Numeric scale factor for the tile. Higher values produce larger tiles */
      @path scale: float32;

      /** Output format for the tile or image (e.g., png, jpeg, webp) */
      @path
      @maxLength(500)
      @pattern(".*")
      format: string;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileResponse
  >;
}

// Assets for Tiles without TMS
@added(Versions.v2026_04_15)
interface MosaicSearchesAssetsForTiles {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Assets For Tile")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/tiles/{z}/{x}/{y}/assets")
  @get
  getZxyAssets is Azure.Core.Foundations.Operation<
    {
      /** Search Id (pgSTAC Search Hash) */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;
      ...ZxyPathParameters;

      /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
      @query("TileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;
    },
    ApplicationJsonResponse
  >;
}

// =====================================================================
// Searches Mosaic Point
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicSearchesPoint {
  /**
   * Get Point value for a search dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Point")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/point/{longitude},{latitude}")
  @get
  getPoint is Azure.Core.Foundations.Operation<
    {
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      /**
       * Longitude
       */
      @path
      longitude: float32;

      /**
       * Latitude
       */
      @path
      latitude: float32;

      ...AssetQueryParameters;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;
    },
    TilerCoreModelsResponsesPoint
  >;
}

@added(Versions.v2026_04_15)
interface MosaicSearchesPointWithAssets {
  /**
   * Return a list of assets for a given point in a search.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Searches Point Assets")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/searches/{searchId}/point/{longitude},{latitude}/assets")
  @get
  getPointAssets is Azure.Core.Foundations.Operation<
    {
      ...MosaicSearchQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      /**
       * Longitude
       */
      @path
      longitude: float32;

      /**
       * Latitude
       */
      @path
      latitude: float32;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;
    },
    StacItemPointAsset[]
  >;
}
