// Tiles for STAC Items interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.common.tsp";
import "./models.tiler.items.tsp";
import "./models.common.images.tsp";

using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

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
    BoundsResponse
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
    InfoOperationResponse
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
    FeaturePolygonDictStrRioTilerModelsInfo
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
    AvailableAssetsResponse | NoContentResponse
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

      ...StatisticsQueryParameters;
    },
    StatisticsResponse
  >;
}

interface TilerGeoJsonStatistics {
  /**
   * Get Statistics from a geojson feature or featureCollection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Statistics")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/statistics")
  @post
  getAll is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;

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
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;

      ...StatisticsQueryParameters;

      /**
       * Request GeoJson body
       */
      @body
      body: GeoJson;
    },
    GeoJsonStatisticsItemCollectionResponse
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
  getZxyScalexFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...AlgorithmQueryParameters;

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
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
    },
    TileResponse | NoContentResponse
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
  getZxyScalexFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...AlgorithmQueryParameters;

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

      ...TileMatrixSetQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
    },
    TileResponse
  >;
}

interface TilerTileJsonOperations {
  /**
   * Return Tilejson
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tilejson")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...AlgorithmQueryParameters;

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
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tile_format")
      tileFormat?: ImageType;

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
    TileJsonResponse
  >;
}

interface TilerTileJsonTileMatrixSets {
  /**
   * Return the Tilejson Tilematrixsetid As a path
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tilejson Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/data/collections/{collectionId}/items/{itemId}/{tileMatrixSetId}/tilejson.json")
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

      ...AssetQueryParameters;
      ...AlgorithmQueryParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      /**
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tile_format")
      tileFormat?: ImageType;

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
    TileJsonResponse
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
      ...AlgorithmQueryParameters;

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
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Output image type. Default is png.
       */
      @query("tile_format")
      tileFormat?: ImageType = ImageType.png;

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
    WmtsCapabilitiesResponse | NoContentResponse
  >;
}

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
      ...AlgorithmQueryParameters;

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

      /**
       * Output image type. Default is png.
       */
      @query("tile_format")
      tileFormat?: ImageType = ImageType.png;

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
  @route("/data/collections/{collectionId}/items/{itemId}/point/{lon},{lat}")
  @get
  getLonLat is Azure.Core.Foundations.Operation<
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
      lon: float64;

      /**
       * Latitude
       */
      @path
      lat: float32;

      ...AssetQueryParameters;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;
    },
    TitilerCoreModelsResponsesPoint
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
      ...AlgorithmQueryParameters;

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
       * Output format for the tile or image (e.g., png, jpeg, webp).
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
      ...AlgorithmQueryParameters;

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
       * Output format for the tile or image (e.g., png, jpeg, webp).
       */
      @query("format")
      format?: ImageType;

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
  getMinxMinyMaxxMaxyWidthxHeightFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...AlgorithmQueryParameters;

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
      width: float32;

      /**
       * Height in pixels for the output image.
       */
      @path
      height: float32;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp).
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
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      dstCrs?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;

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
  getMinxMinyMaxxMaxyFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...AlgorithmQueryParameters;

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
       * Output format for the tile or image (e.g., png, jpeg, webp).
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
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      dstCrs?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;

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
  cropWidthxHeightFormat is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;
      ...AlgorithmQueryParameters;

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
      width: float32;

      /**
       * Height in pixels for the output image.
       */
      @path
      height: float32;

      /**
       * Output format for the tile or image (e.g., png, jpeg, webp).
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
      coordCrs?: string;

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
      body: GeoJson;
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
      ...AlgorithmQueryParameters;

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
       * Output format for the tile or image (e.g., png, jpeg, webp) (default: "png").
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
      coordCrs?: string;

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
      body: GeoJson;
    },
    TileResponse
  >;
}
