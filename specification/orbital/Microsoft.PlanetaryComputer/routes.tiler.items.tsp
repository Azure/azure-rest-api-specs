// Tiles for STAC Items interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.common.tsp";
import "./models.tiler.items.tsp";
import "./models.common.images.tsp";

using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

@doc("Map of band names to their statistics.")
model BandStatisticsMap is Record<BandStatistics>;

@doc("Return dataset's statistics.")
model AssetStatisticsResponse is Record<BandStatisticsMap>;

@doc("Return dataset's basic info.")
model TilerInfoMapResponse is Record<TilerInfo>;

interface TilerBound {
  /**
   * Return all Bounds
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Bounds")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/bounds")
  @get
  getAll is Azure.Core.Foundations.Operation<
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
    StacItemBounds
  >;
}

interface TilerInfoOperations {
  /**
   * Return dataset's basic info.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Info")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/info")
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
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];
    },
    TilerInfoMapResponse
  >;
}

interface TilerInfoGeoJsonOperations {
  /**
   * Return Info Geojson
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Info Geojson")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/info.geojson")
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
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];
    },
    TilerInfoGeoJsonFeature
  >;
}

interface TilerAvailableAssets {
  /**
   * Return a list of supported assets.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Available Assets")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/assets")
  @get
  getAll is Azure.Core.Foundations.Operation<
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
    AvailableAssets
  >;
}

interface TilerAssetStatistics {
  /**
   * Per Asset statistics
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Asset Statistics")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/asset_statistics")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...getAssetStatisticsCustomizedCommonSignatures;
      ...StatisticsQueryParameters;
    },
    AssetStatisticsResponse
  >;
}

interface TilerStatistics {
  /**
   * Merged assets statistics.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Statistics")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/statistics")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...listStatisticsCustomizedCommonSignatures;
      ...StatisticsQueryParameters;
    },
    TilerStacItemStatistics
  >;
}

interface TilerGeoJsonStatistics {
  /**
   * Get Statistics from a geojson feature.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Statistics")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/statistics")
  @post
  get is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...getGeoJsonStatisticsCustomizedCommonSignatures;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordinateReferenceSystem?: string;

      ...StatisticsQueryParameters;

      /**
       * Request GeoJson body
       */
      @body
      body: Feature;
    },
    StacItemStatisticsGeoJson
  >;
}

interface TilerTiles {
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
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

interface TilerTileMatrixSets {
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getTileCustomizedCommonSignatures;
      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
    },
    TileResponse
  >;
}

interface TilerTileJsonOperations {
  /**
   * Return TileJson
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("TileJson")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
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
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
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
      @maxValueExclusive(4)
      @query("tile_scale")
      tileScale?: int32 = 1;

      ...ZoomQueryParameters;
      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
    },
    TileJsonMetadata
  >;
}

interface TilerTileJsonTileMatrixSets {
  /**
   * Return the TileJson Tilematrixsetid As a path
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("TileJson Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/{tileMatrixSetId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getTileJsonCustomizedCommonSignatures;

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
      tileScale?: int32 = 1;

      ...ZoomQueryParameters;
      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
    },
    TileJsonMetadata
  >;
}

interface TilerWmts {
  /**
   * OGC WMTS endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Wmts")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
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
    WmtsCapabilities
  >;
}

// Common signature aliases for client overrides
alias getWmtsCapabilitiesCustomizedCommonSignatures = {
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
};

alias getTileCustomizedCommonSignatures = {
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

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;
};

alias getAssetStatisticsCustomizedCommonSignatures = {
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
};

alias cropGeoJsonCustomizedCommonSignatures = {
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
};

alias cropGeoJsonWithDimensionsCustomizedCommonSignatures = {
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
};

alias getGeoJsonStatisticsCustomizedCommonSignatures = {
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
};

alias getPartCustomizedCommonSignatures = {
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
};

alias getPartWithDimensionsCustomizedCommonSignatures = {
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
};

alias getPreviewCustomizedCommonSignatures = {
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
};

alias getPreviewWithFormatCustomizedCommonSignatures = {
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
};

alias listStatisticsCustomizedCommonSignatures = {
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
};

alias getTileJsonCustomizedCommonSignatures = {
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
};

interface TilerWmtsTileMatrixSets {
  /**
   * OGC WMTS endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Wmts Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/{tileMatrixSetId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getWmtsCapabilitiesCustomizedCommonSignatures;

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

interface TilerPoints {
  /**
   * Get Point value for a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Point")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/point/{longitude},{latitude}")
  @get
  getPoint is Azure.Core.Foundations.Operation<
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
      @query("coord-crs")
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

interface TilerPreviews {
  /**
   * Create preview of a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Preview")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/preview.{format}")
  @get
  getFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getPreviewWithFormatCustomizedCommonSignatures;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      dstCrs?: string;

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
  /**
   * Create preview of a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Preview")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/preview")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getPreviewCustomizedCommonSignatures;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp).
       */
      @query("format")
      format?: TilerImageFormat;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      dstCrs?: string;

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

interface TilerParts {
  /**
   * Create image from part of a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Part")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/crop/{minx},{miny},{maxx},{maxy}/{width}x{height}.{format}")
  @get
  getCroppedToBoundingBoxWidthByHeight is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getPartWithDimensionsCustomizedCommonSignatures;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      dstCrs?: string;

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
    },
    TileResponse
  >;
  /**
   * Create image from part of a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Part")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/crop/{minx},{miny},{maxx},{maxy}.{format}")
  @get
  getCroppedToBoundingBox is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...getPartCustomizedCommonSignatures;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      dstCrs?: string;

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
    },
    TileResponse
  >;
}

interface TilerGeoJsons {
  /**
   * Create image from a geojson feature.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Crop")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/crop/{width}x{height}.{format}")
  @post
  cropWidthByHeightFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...cropGeoJsonWithDimensionsCustomizedCommonSignatures;

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
  /**
   * Create image from a geojson feature.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Crop")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/crop.{format}")
  @post
  cropFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...TerrainAlgorithmQueryParameters;
      ...cropGeoJsonCustomizedCommonSignatures;

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
