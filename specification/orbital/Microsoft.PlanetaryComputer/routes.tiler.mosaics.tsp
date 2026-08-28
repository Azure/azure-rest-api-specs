// Tiles for STAC Collections Mosaics interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tiler.common.tsp";
import "./models.tiler.mosaics.tsp";
import "./models.common.versions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;

// Common signature aliases for client overrides
alias getMosaicsTileCustomizedCommonSignatures = {
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
};

alias getMosaicsTileJsonCustomizedCommonSignatures = {
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
};

alias getMosaicsWmtsCapabilitiesCustomizedCommonSignatures = {
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
};

@removed(Versions.v2026_04_15)
interface MosaicsTiles {
  /**
   * Create map tile.
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/tiles/{z}/{x}/{y}@{scale}x.{format}` endpoints instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/tiles/{z}/{x}/{y}@{scale}x.{format} endpoints instead"
  @summary("Tile (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tiles/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
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
      ...TerrainAlgorithmQueryParameters;
      ...ZxyPathParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

      /**
       * Numeric scale factor for the tile. Higher values produce larger tiles (default: "1")
       */
      @path
      scale: float32;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp) (default: "png").
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

@removed(Versions.v2026_04_15)
interface MosaicsTileMatrixSets {
  /**
   * Create map tile.
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x.{format}` endpoints instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}/ endpoints instead"
  @summary("Tile Tilematrixsetid As Path (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getMosaicsTileCustomizedCommonSignatures;
      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileResponse
  >;
}

@removed(Versions.v2026_04_15)
interface MosaicsTileJsonOperations {
  /**
   * Return TileJSON document for a searchId.
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/tilejson.json` endpoints instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/tilejson.json instead"
  @summary("TileJson (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tilejson.json")
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

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad').
       */
      @query("tileMatrixSetId")
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

@removed(Versions.v2026_04_15)
interface MosaicsTileMatrixSetsTileJson {
  /**
   * Return TileJSON document for a searchId.
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/{tileMatrixSetId}/tilejson.json` instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/{tileMatrixSetId}/tilejson.json instead"
  @summary("TileJson Tilematrixsetid As Path (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/{tileMatrixSetId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getMosaicsTileJsonCustomizedCommonSignatures;
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

@removed(Versions.v2026_04_15)
interface MosaicsWmtsMosaics {
  /**
   * OGC WMTS endpoint.
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/WMTSCapabilities.xml` instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/WMTSCapabilities.xml instead"
  @summary("Wmts (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;

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
      @query("tileMatrixSetId")
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
      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
    },
    WmtsCapabilitiesXmlResponse
  >;
}

@removed(Versions.v2026_04_15)
interface MosaicsWmtsMosaicsTileMatrixSets {
  /**
   * OGC WMTS endpoint.
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/{tileMatrixSetId}/WMTSCapabilities.xml` instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/{tileMatrixSetId}/WMTSCapabilities.xml instead"
  @summary("Wmts Tilematrixsetid As Path (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/{tileMatrixSetId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getMosaicsWmtsCapabilitiesCustomizedCommonSignatures;

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
      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
    },
    WmtsCapabilitiesXmlResponse
  >;
}

interface MosaicsRegisterSearch {
  /**
   * Register a Search query
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Register Search")
  @tag("Tiles for STAC Searches")
  @route("/data/mosaic/register")
  @post
  register is Azure.Core.Foundations.Operation<
    RegisterMosaic,
    TilerMosaicSearchRegistrationResponse
  >;
}

@removed(Versions.v2026_04_15)
interface MosaicsInfoSearch {
  /**
   * Get Search query metadata.
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/info` instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/info instead"
  @summary("Info Search (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/info")
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

@removed(Versions.v2026_04_15)
interface MosaicsAssetsForTiles {
  /**
   * Return a list of assets which overlap a given tile
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/tiles/{z}/{x}/{y}/assets` instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/tiles/{z}/{x}/{y}/assets instead"
  @summary("Assets For Tile (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tiles/{z}/{x}/{y}/assets")
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
      ...ZxyPathParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;
    },
    ApplicationJsonResponse
  >;
}

@removed(Versions.v2026_04_15)
interface MosaicsAssetsForTileMatrixSets {
  /**
   * Return a list of assets which overlap a given tile
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}/assets` instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}/assets instead"
  @summary("Assets For Tile Tilematrixsetid As Path (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}/assets")
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

@removed(Versions.v2026_04_15)
interface MosaicsAssetsForPoints {
  /**
   * Return a list of assets for a given point.
   *
   * Note: If you are using stable API version 2026-04-15, please use `/data/mosaic/searches/{searchId}/{longitude},{latitude}/assets` instead. The old endpoint is associated with the preview API version, which is deprecated and will be removed in a future release.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #deprecated "Use /data/mosaic/searches/{searchId}/{longitude},{latitude}/assets instead"
  @summary("Assets For Point (Deprecated)")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/{longitude},{latitude}/assets")
  @get
  getPointAssets is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...MosaicSearchQueryParameters;

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
      @query("coord-crs")
      coordinateReferenceSystem?: string;
    },
    StacItemPointAsset[]
  >;
}
