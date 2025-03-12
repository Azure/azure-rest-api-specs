import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.tsp";
import "./models.common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MicrosoftPlanetaryComputerPro;

interface Bound {
  /**
   * Bounds
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Bounds")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/bounds")
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
    Bounds
  >;
}
interface InfoOperations {
  /**
   * Return dataset's basic info.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Info")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/info")
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

/**
 * Return dataset's basic info or the list of available assets.
 */
model InfoOperationResponse {
  /**
   * status code for info operation response
   */
  @statusCode statusCode: 200;

  /**
   * body for info operation response
   */
  @bodyRoot
  @summary("Response Info Api Collections  Collection Id  Items  Item Id  Info Get")
  body: Record<TilerInfo>;
}

/**
 * Dataset Info.
 */
@summary("TilerInfo")
model TilerInfo {
  /**
   * Bounds
   */
  @minItems(4)
  @maxItems(4)
  @summary("Bounds")
  bounds: string[];

  /**
   * Band Metadata
   */
  @summary("Band Metadata") bandMetadata: string[][];

  /**
   * Band Descriptions
   */
  @summary("Band Descriptions") bandDescriptions: string[][];

  /**
   * Band Names
   */
  @summary("Dtype") dtype: string;

  /**
   * Band Names
   */
  @summary("Nodata Type") nodataType: NoDataType;

  /**
   * Band Names
   */
  @summary("Colorinterp") colorinterp?: string[];

  /**
   * Band Names
   */
  @summary("Scales") scales?: int64[];

  /**
   * Band Names
   */
  @summary("Offsets") offsets?: int64[];

  /**
   * Band Names
   */
  @summary("Colormap") colormap?: Record<string[]>;

  /**
   * Band Names
   */
  @summary("Minzoom") minzoom?: int64;

  /**
   * Band Names
   */
  @summary("Maxzoom") maxzoom?: int64;
}

/**
 * NoDataType
 */
union NoDataType {
  string,

  /**
   * TODO: add description for Alpha
   */
  Alpha: "Alpha",

  /**
   * TODO: add description for Mask
   */
  Mask: "Mask",

  /**
   * TODO: add description for Internal
   */
  Internal: "Internal",

  /**
   * TODO: add description for Nodata
   */
  Nodata: "Nodata",

  /**
   * TODO: add description for None
   */
  None: "None",
}

interface InfoGeoJsonOperations {
  /**
   * Info Geojson
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Info Geojson")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/info.geojson")
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

      /**
       * Accept header
       */
      @header
      accept: "application/geo+json";
    },
    FeaturePolygonDictStrRioTilerModelsInfo
  >;
}
interface AvailableAssets {
  /**
   * Return a list of supported assets.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Available Assets")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/assets")
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
    AvailableAssetsResponse
  >;
}

/**
 * Return a list of supported assets.
 */
model AvailableAssetsResponse {
  /**
   * status code for available assets response
   */
  @statusCode statusCode: 200;

  /**
   * body for available assets response
   */
  @bodyRoot
  @summary("Response Available Assets Api Collections  Collection Id  Items  Item Id  Assets Get")
  body: string[];
}

interface AssetStatistics {
  /**
   * Per Asset statistics
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Asset Statistics")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/asset_statistics")
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

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Per asset band indexes
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Per asset band expression
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetExpression?: string[];

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * TODO: add description for "height"?
       */
      @query("height")
      height?: int32;

      /**
       * TODO: add description for "width"?
       */
      @query("width")
      width?: int32;

      /**
       * Return statistics for categorical dataset.
       */
      @query("categorical")
      categorical?: boolean;

      /**
       * List of values for which to report counts.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      c?: string[];

      /**
       * List of percentile values (default to [2, 98]).
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      p?: int32[];

      /**
       *
       * Defines the number of equal-width bins in the given range (10, by default).
       *
       * If bins is a sequence (comma `,` delimited values), it defines a monotonically
       * increasing array of bin edges, including the rightmost edge, allowing for
       * non-uniform bin widths.
       *
       * link: https://numpy.org/doc/stable/reference/generated/numpy.histogram.html
       *
       */
      @query("histogramBins")
      histogramBins?: string;

      /**
       *
       * Comma `,` delimited range of the bins.
       *
       * The lower and upper range of the bins. If not provided, range is simply
       * (a.min(), a.max()).
       *
       * Values outside the range are ignored. The first element of the range must be
       * less than or equal to the second.
       * range affects the automatic bin computation as well.
       *
       * link: https://numpy.org/doc/stable/reference/generated/numpy.histogram.html
       *
       */
      @query("histogramRange")
      histogramRange?: string;
    },
    AssetStatisticsResponse
  >;
}

/**
 * Return dataset's statistics.
 */
model AssetStatisticsResponse {
  /**
   * Response Asset Statistics Api Collections  Collection Id  Items  Item Id  Asset Statistics Get
   */
  @statusCode statusCode: 200;

  /**
   * Response Asset Statistics Api Collections  Collection Id  Items  Item Id  Asset Statistics Get
   */
  @bodyRoot
  @summary("Response Asset Statistics Api Collections  Collection Id  Items  Item Id  Asset Statistics Get")
  body: Record<StatisticsInGeoJson>;
}

interface Statistics {
  /**
   * Merged assets statistics.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Statistics")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/statistics")
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

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * TODO: add description for "height"?
       */
      @query("height")
      height?: int32;

      /**
       * TODO: add description for "width"?
       */
      @query("width")
      width?: int32;

      /**
       * Return statistics for categorical dataset.
       */
      @query("categorical")
      categorical?: boolean;

      /**
       * List of values for which to report counts.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      c?: string[];

      /**
       * List of percentile values (default to [2, 98]).
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      p?: int32[];

      /**
       *
       * Defines the number of equal-width bins in the given range (10, by default).
       *
       * If bins is a sequence (comma `,` delimited values), it defines a monotonically
       * increasing array of bin edges, including the rightmost edge, allowing for
       * non-uniform bin widths.
       *
       * link: https://numpy.org/doc/stable/reference/generated/numpy.histogram.html
       *
       */
      @query("histogramBins")
      histogramBins?: string;

      /**
       *
       * Comma `,` delimited range of the bins.
       *
       * The lower and upper range of the bins. If not provided, range is simply
       * (a.min(), a.max()).
       *
       * Values outside the range are ignored. The first element of the range must be
       * less than or equal to the second.
       * range affects the automatic bin computation as well.
       *
       * link: https://numpy.org/doc/stable/reference/generated/numpy.histogram.html
       *
       */
      @query("histogramRange")
      histogramRange?: string;
    },
    StatisticsResponse
  >;
}

/**
 * Return dataset's statistics.
 */
model StatisticsResponse {
  /**
   * status code for statistics response
   */
  @statusCode statusCode: 200;

  /**
   * body for statistics response
   */
  @bodyRoot
  @summary("Response Statistics Api Collections  Collection Id  Items  Item Id  Statistics Get")
  body: Record<BandStatistics>;
}

interface GeoJsonStatistics {
  /**
   * Get Statistics from a geojson feature or featureCollection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Statistics")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/statistics")
  @post
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

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * TODO: add description for "height"?
       */
      @query("height")
      height?: int32;

      /**
       * TODO: add description for "width"?
       */
      @query("width")
      width?: int32;

      /**
       * Return statistics for categorical dataset.
       */
      @query("categorical")
      categorical?: boolean;

      /**
       * List of values for which to report counts.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      c?: string[];

      /**
       * List of percentile values (default to [2, 98]).
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      p?: int32[];

      /**
       *
       * Defines the number of equal-width bins in the given range (10, by default).
       *
       * If bins is a sequence (comma `,` delimited values), it defines a monotonically
       * increasing array of bin edges, including the rightmost edge, allowing for
       * non-uniform bin widths.
       *
       * link: https://numpy.org/doc/stable/reference/generated/numpy.histogram.html
       *
       */
      @query("histogramBins")
      histogramBins?: string;

      /**
       *
       * Comma `,` delimited range of the bins.
       *
       * The lower and upper range of the bins. If not provided, range is simply
       * (a.min(), a.max()).
       *
       * Values outside the range are ignored. The first element of the range must be
       * less than or equal to the second.
       * range affects the automatic bin computation as well.
       *
       * link: https://numpy.org/doc/stable/reference/generated/numpy.histogram.html
       *
       */
      @query("histogramRange")
      histogramRange?: string;

      /**
       * TODO: add description for "body"
       */
      @body
      body: Geojson;

      /**
       * Accept header
       */
      @header
      accept: "application/geo+json, application/json";
    },
    ResponseGeojsonStatisticsApiCollectionsCollectionIdItemsItemIdStatisticsPost
  >;
}

interface Tiles {
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScalexFormat is Azure.Core.Foundations.Operation<
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
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "scale"
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      scale: string;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * The name of a subdataset within the asset.
       */
      @query("subdatasetName")
      subdatasetName?: string;

      /**
       * The index of a subdataset band within the asset.
       */
      @query("subdatasetBands")
      subdatasetBands?: string[];
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}@{scale}x")
  @get
  getZxyScalex is Azure.Core.Foundations.Operation<
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
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "scale"
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      scale: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * The name of a subdataset within the asset.
       */
      @query("subdatasetName")
      subdatasetName?: string;

      /**
       * The index of a subdataset band within the asset.
       */
      @query("subdatasetBands")
      subdatasetBands?: string[];
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}.{format}")
  @get
  getZxyFormat is Azure.Core.Foundations.Operation<
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
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * TODO: add description for "scale"?
       */
      @query("scale")
      scale?: int32 = 1;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * The name of a subdataset within the asset.
       */
      @query("subdatasetName")
      subdatasetName?: string;

      /**
       * The index of a subdataset band within the asset.
       */
      @query("subdatasetBands")
      subdatasetBands?: string[];
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
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
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * TODO: add description for "scale"?
       */
      @query("scale")
      scale?: int32 = 1;

      /**
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * The name of a subdataset within the asset.
       */
      @query("subdatasetName")
      subdatasetName?: string;

      /**
       * The index of a subdataset band within the asset.
       */
      @query("subdatasetBands")
      subdatasetBands?: string[];
    },
    void
  >;
}
interface MosaicsTiles {
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScalexFormat is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "scale"
       */
      //@maxValue(4)
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      scale: string;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{z}/{x}/{y}@{scale}x")
  @get
  getZxyScalex is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "scale"
       */
      //@maxValue(4)
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      scale: string;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{z}/{x}/{y}.{format}")
  @get
  getZxyFormat is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * TODO: add description for "scale"?
       */
      @maxValue(4)
      @query("scale")
      scale?: int32;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * TODO: add description for "scale"?
       */
      @maxValue(4)
      @query("scale")
      scale?: int32;

      /**
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
}
interface TileMatrixSets {
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScalexFormat is Azure.Core.Foundations.Operation<
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
      tileMatrixSetId: Tilematrixsetid;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "scale"
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      scale: string;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * The name of a subdataset within the asset.
       */
      @query("subdatasetName")
      subdatasetName?: string;

      /**
       * The index of a subdataset band within the asset.
       */
      @query("subdatasetBands")
      subdatasetBands?: string[];
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x")
  @get
  getZxyScalex is Azure.Core.Foundations.Operation<
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
      tileMatrixSetId: Tilematrixsetid;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "scale"
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      scale: string;

      /**
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * The name of a subdataset within the asset.
       */
      @query("subdatasetName")
      subdatasetName?: string;

      /**
       * The index of a subdataset band within the asset.
       */
      @query("subdatasetBands")
      subdatasetBands?: string[];
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}.{format}")
  @get
  getZxyFormat is Azure.Core.Foundations.Operation<
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
      tileMatrixSetId: Tilematrixsetid;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * TODO: add description for "scale"?
       */
      @query("scale")
      scale?: int32 = 1;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * The name of a subdataset within the asset.
       */
      @query("subdatasetName")
      subdatasetName?: string;

      /**
       * The index of a subdataset band within the asset.
       */
      @query("subdatasetBands")
      subdatasetBands?: string[];
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile from a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
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
      tileMatrixSetId: Tilematrixsetid;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "scale"?
       */
      @query("scale")
      scale?: int32 = 1;

      /**
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * The name of a subdataset within the asset.
       */
      @query("subdatasetName")
      subdatasetName?: string;

      /**
       * The index of a subdataset band within the asset.
       */
      @query("subdatasetBands")
      subdatasetBands?: string[];
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
}
interface MosaicsTileMatrixSets {
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScalexFormat is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      tileMatrixSetId: Tilematrixsetid;

      /**
       * TODO: add description for "scale"
       */
      //@maxValue(4)
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      scale: string;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x")
  @get
  getZxyScalex is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      tileMatrixSetId: Tilematrixsetid;

      /**
       * TODO: add description for "scale"
       */
      //@maxValue(4)
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      scale: string;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{tileMatrixSetId}/{z}/{x}/{y}.{format}")
  @get
  getZxyFormat is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      tileMatrixSetId: Tilematrixsetid;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "scale"?
       */
      @maxValue(4)
      @query("scale")
      scale?: int32;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{tileMatrixSetId}/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      tileMatrixSetId: Tilematrixsetid;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * TODO: add description for "scale"?
       */
      @maxValue(4)
      @query("scale")
      scale?: int32;

      /**
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
}
interface TileJsonOperations {
  /**
   * Tilejson
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tilejson")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/tilejson.json")
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
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tileFormat")
      tileFormat?: ImageType;

      /**
       * Tile size scale. 1=256x256, 2=512x512...
       */
      /**
       * TODO: add description for "tileScale"?
       */
      @maxValueExclusive(4)
      @query("tileScale")
      tileScale?: int32 = 1;

      /**
       * Overwrite default minzoom.
       */
      @query("minzoom")
      minzoom?: int32;

      /**
       * Overwrite default maxzoom.
       */
      @query("maxzoom")
      maxzoom?: int32;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;
    },
    TileJson
  >;
}
interface MosaicsTileJsonOperations {
  /**
   * Return TileJSON document for a SearchId.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tilejson")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

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
      @query("tileFormat")
      tileFormat?: ImageType;

      /**
       * Tile size scale. 1=256x256, 2=512x512...
       */
      @maxValueExclusive(4)
      @query("tileScale")
      tileScale?: int32;

      /**
       * Overwrite default minzoom.
       */
      @query("minzoom")
      minzoom?: int32;

      /**
       * Overwrite default maxzoom.
       */
      @query("maxzoom")
      maxzoom?: int32;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },
    TileJson
  >;
}
interface TileJsonTileMatrixSets {
  /**
   * Tilejson Tilematrixsetid As Path
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tilejson Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/{tileMatrixSetId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      tileMatrixSetId: Tilematrixsetid;

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
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tileFormat")
      tileFormat?: ImageType;

      /**
       * Tile size scale. 1=256x256, 2=512x512...
       */
      /**
       * TODO: add description for "tileScale"?
       */
      @maxValueExclusive(4)
      @query("tileScale")
      tileScale?: int32 = 1;

      /**
       * Overwrite default minzoom.
       */
      @query("minzoom")
      minzoom?: int32;

      /**
       * Overwrite default maxzoom.
       */
      @query("maxzoom")
      maxzoom?: int32;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;
    },
    TileJson
  >;
}
interface TileJsonMosaicsTileMatrixSets {
  /**
   * Return TileJSON document for a SearchId.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tilejson Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/{tileMatrixSetId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      tileMatrixSetId: Tilematrixsetid;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tileFormat")
      tileFormat?: ImageType;

      /**
       * Tile size scale. 1=256x256, 2=512x512...
       */
      /**
       * TODO: add description for "tileScale"?
       */
      @maxValueExclusive(4)
      @query("tileScale")
      tileScale?: int32;

      /**
       * Overwrite default minzoom.
       */
      @query("minzoom")
      minzoom?: int32;

      /**
       * Overwrite default maxzoom.
       */
      @query("maxzoom")
      maxzoom?: int32;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixelSelection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },
    TileJson
  >;
}
interface Wmts {
  /**
   * OGC WMTS endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Wmts")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
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
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Output image type. Default is png.
       */
      @query("tileFormat")
      tileFormat?: ImageType = ImageType.png;

      /**
       * Tile size scale. 1=256x256, 2=512x512...
       */
      /**
       * TODO: add description for "tileScale"?
       */
      @maxValueExclusive(4)
      @query("tileScale")
      tileScale?: int32 = 1;

      /**
       * Overwrite default minzoom.
       */
      @query("minzoom")
      minzoom?: int32;

      /**
       * Overwrite default maxzoom.
       */
      @query("maxzoom")
      maxzoom?: int32;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Accept header
       */
      @header
      accept: "application/xml";
    },
    WmtsCapabilitiesResponse
  >;
}

/**
 * Successful Response
 */
model WmtsCapabilitiesResponse {
  /**
   * status code for wmts capabilities
   */
  @statusCode statusCode: 200;

  /**
   * body for wmts capabilities
   */
  @bodyRoot body: string;

  /**
   * content type for wmts capabilities
   */
  @header contentType: "application/xml";
}

interface WmtsMosaics {
  /**
   * OGC WMTS endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Wmts")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Output image type. Default is png.
       */
      @query("tileFormat")
      tileFormat?: ImageType = ImageType.png;

      /**
       * Tile size scale. 1=256x256, 2=512x512...
       */
      /**
       * TODO: add description for "tileScale"?
       */
      @maxValueExclusive(4)
      @query("tileScale")
      tileScale?: int32 = 1;

      /**
       * Overwrite default minzoom.
       */
      @query("minzoom")
      minzoom?: int32;

      /**
       * Overwrite default maxzoom.
       */
      @query("maxzoom")
      maxzoom?: int32;

      /**
       * Accept header
       */
      @header
      accept: "application/xml";
    },
    WmtsCapabilitiesXmlResponse
  >;
}
interface WmtsTileMatrixSets {
  /**
   * OGC WMTS endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Wmts Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/{tileMatrixSetId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
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
      tileMatrixSetId: Tilematrixsetid;

      /**
       * Output image type. Default is png.
       */
      @query("tileFormat")
      tileFormat?: ImageType = ImageType.png;

      /**
       * Tile size scale. 1=256x256, 2=512x512...
       */
      /**
       * TODO: add description for "tileScale"?
       */
      @maxValueExclusive(4)
      @query("tileScale")
      tileScale?: int32 = 1;

      /**
       * Overwrite default minzoom.
       */
      @query("minzoom")
      minzoom?: int32;

      /**
       * Overwrite default maxzoom.
       */
      @query("maxzoom")
      maxzoom?: int32;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      buffer?: float32;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * Accept header
       */
      @header
      accept: "application/xml";
    },
    WmtsCapabilitiesXmlResponse
  >;
}

/**
 * Successful Response
 */
model WmtsCapabilitiesXmlResponse {
  /**
   * status code for WMTSCapabilitiesXmlResponse
   */
  @statusCode statusCode: 200;

  /**
   * body for WMTSCapabilitiesXmlResponse
   */
  @bodyRoot body: string;

  /**
   * content type for WMTSCapabilitiesXmlResponse
   */
  @header contentType: "application/xml";
}

interface WmtsMosaicsTileMatrixSets {
  /**
   * OGC WMTS endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Wmts Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/{tileMatrixSetId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      tileMatrixSetId: Tilematrixsetid;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Output image type. Default is png.
       */
      @query("tileFormat")
      tileFormat?: ImageType = ImageType.png;

      /**
       * Tile size scale. 1=256x256, 2=512x512...
       */
      /**
       * TODO: add description for "tileScale"?
       */
      @maxValueExclusive(4)
      @query("tileScale")
      tileScale?: int32 = 1;

      /**
       * Overwrite default minzoom.
       */
      @query("minzoom")
      minzoom?: int32;

      /**
       * Overwrite default maxzoom.
       */
      @query("maxzoom")
      maxzoom?: int32;

      /**
       * Accept header
       */
      @header
      accept: "application/xml";
    },
    WmtsCapabilitiesXmlResponse
  >;
}
interface Points {
  /**
   * Get Point value for a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Point")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/point/{lon},{lat}")
  @get
  getLonLat is Azure.Core.Foundations.Operation<
    {
      /**
       * Longitude
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      lon: string;

      /**
       * Latitude
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      lat: string;

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

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;
    },
    TitilerCoreModelsResponsesPoint
  >;
}
interface Previews {
  /**
   * Create preview of a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Preview")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/preview.{format}")
  @get
  getFormat is Azure.Core.Foundations.Operation<
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
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      dstCrs?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * TODO: add description for "height"?
       */
      @query("height")
      height?: int32;

      /**
       * TODO: add description for "width"?
       */
      @query("width")
      width?: int32;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create preview of a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Preview")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/preview")
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
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Output Coordinate Reference System.
       */
      @query("dst-crs")
      dstCrs?: string;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * TODO: add description for "height"?
       */
      @query("height")
      height?: int32;

      /**
       * TODO: add description for "width"?
       */
      @query("width")
      width?: int32;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
}
interface Parts {
  /**
   * Create image from part of a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Part")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/crop/{minx},{miny},{maxx},{maxy}/{width}x{height}.{format}")
  @get
  getMinxMinyMaxxMaxyWidthxHeightFormat is Azure.Core.Foundations.Operation<
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
       * Bounding box min X
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      minx: string;

      /**
       * Bounding box min Y
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      miny: string;

      /**
       * Bounding box max X
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      maxx: string;

      /**
       * Bounding box max Y
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      maxy: string;

      /**
       * TODO: add description for "width"
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      width: string;

      /**
       * TODO: add description for "height"
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      height: string;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
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
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create image from part of a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Part")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/crop/{minx},{miny},{maxx},{maxy}.{format}")
  @get
  getMinxMinyMaxxMaxyFormat is Azure.Core.Foundations.Operation<
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
       * Bounding box min X
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      minx: string;

      /**
       * Bounding box min Y
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      miny: string;

      /**
       * Bounding box max X
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      maxx: string;

      /**
       * Bounding box max Y
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      maxy: string;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
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
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * TODO: add description for "height"?
       */
      @query("height")
      height?: int32;

      /**
       * TODO: add description for "width"?
       */
      @query("width")
      width?: int32;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
}
interface GeoJsons {
  /**
   * Create image from a geojson feature.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Crop")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/crop/{width}x{height}.{format}")
  @post
  cropWidthxHeightFormat is Azure.Core.Foundations.Operation<
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
       * TODO: add description for "width"
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      width: string;

      /**
       * TODO: add description for "height"
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      height: string;

      /**
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * TODO: add description for "body"
       */
      @body
      body: Geojson;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create image from a geojson feature.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Crop")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/crop.{format}")
  @post
  cropFormat is Azure.Core.Foundations.Operation<
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
       * TODO: add description for "format"
       */
      @path
      format: ImageType;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * TODO: add description for "height"?
       */
      @query("height")
      height?: int32;

      /**
       * TODO: add description for "width"?
       */
      @query("width")
      width?: int32;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * TODO: add description for "body"
       */
      @body
      body: Geojson;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
  /**
   * Create image from a geojson feature.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Crop")
  @tag("Tiles for STAC Items")
  @route("/api/collections/{collectionId}/items/{itemId}/crop")
  @post
  cropPost is Azure.Core.Foundations.Operation<
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
       * TODO: add description for "format"?
       */
      @query("format")
      format?: ImageType;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("colorFormula")
      colorFormula?: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Band math expression between assets
       */
      @query("expression")
      expression?: string;

      /**
       * Per asset band indexes (coma separated indexes)
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assetBidx?: string[];

      /**
       * Asset as Band
       */
      @query("assetAsBand")
      assetAsBand?: boolean;

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      nodata?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * Resampling method.
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * TODO: add description for "maxSize"?
       */
      @query("maxSize")
      maxSize?: int32 = 1024;

      /**
       * TODO: add description for "height"?
       */
      @query("height")
      height?: int32;

      /**
       * TODO: add description for "width"?
       */
      @query("width")
      width?: int32;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithmParams")
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
      @query("colormapName")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("returnMask")
      returnMask?: boolean = true;

      /**
       * TODO: add description for "body"
       */
      @body
      body: Geojson;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
  >;
}

/**
 * Return an image.
 */
model ImagePngResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/png";

  /**
   * TODO: add description for "body"
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageJpegResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/jpeg";

  /**
   * TODO: add description for "body"
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageJpgResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/jpg";

  /**
   * TODO: add description for "body"
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageJp2Response {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/jp2";

  /**
   * TODO: add description for "body"
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ApplicationXbinaryResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "application/x-binary";

  /**
   * TODO: add description for "body"
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageWebpResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/webp";

  /**
   * TODO: add description for "body"
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageTiffResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/tiff; application=geotiff";

  /**
   * TODO: add description for "body"
   */
  @body
  body: bytes;
}

interface RegisterSearch {
  /**
   * Register a Search query.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Register Search")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/register")
  @post
  register is Azure.Core.Foundations.Operation<
    RegisterMosaic,
    RegisterResponse
  >;
}
interface InfoSearch {
  /**
   * Get Search query metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Info Search")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/info")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;
    },
    TitilerPgstacModelInfo
  >;
}
interface AssetsForTiles {
  /**
   * Return a list of assets which overlap a given tile
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Assets For Tile")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{z}/{x}/{y}/assets")
  @get
  getZxyAssets is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },
    ApplicationJsonResponse
  >;
}
interface AssetsForTileMatrixSets {
  /**
   * Return a list of assets which overlap a given tile
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Assets For Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/tiles/{tileMatrixSetId}/{z}/{x}/{y}/assets")
  @get
  getZxyAssets is Azure.Core.Foundations.Operation<
    {
      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      tileMatrixSetId: Tilematrixsetid;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
       * representing the scaleDenominator the tile.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      z: string;

      /**
       * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixHeight-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      x: string;

      /**
       * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
       * MatrixWidth-1 for the selected TileMatrix.
       */
      @path
      @maxLength(500)
      @pattern("^[-+]?[0-9]+$")
      y: string;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },
    ApplicationJsonResponse
  >;
}
interface AssetsForPoints {
  /**
   * Return a list of assets for a given point.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Assets For Point")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/api/mosaic/{searchid}/{lon},{lat}/assets")
  @get
  getLonLatAssets is Azure.Core.Foundations.Operation<
    {
      /**
       * Longitude
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      lon: string;

      /**
       * Latitude
       */
      @path
      @maxLength(500)
      @pattern("[+-]?([0-9]*[.])?[0-9]+")
      lat: string;

      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchid: string;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;

      /**
       * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
       */
      @query("scanLimit")
      scanLimit?: int32;

      /**
       * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
       */
      @query("itemsLimit")
      itemsLimit?: int32;

      /**
       * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
       */
      @query("timeLimit")
      timeLimit?: int32;

      /**
       * Return as soon as the geometry is fully covered (defaults to True in PgSTAC).
       */
      @query("exitwhenfull")
      exitwhenfull?: boolean;

      /**
       * Skip any items that would show up completely under the previous items (defaults
       * to True in PgSTAC).
       */
      @query("skipcovered")
      skipcovered?: boolean;
    },
    ApplicationJsonResponse
  >;
}

/**
 * Return list of assets
 */
model ApplicationJsonResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * body
   */
  @bodyRoot
  @summary("Response Assets For Point Api Mosaic  Searchid   Lon   Lat  Assets Get")
  body: {}[];
}

interface IntervalLegends {
  /**
   * Generate values and color swatches mapping for a given interval classmap.
   *
   * Args:
   *     trim_start (int, optional): Number of items to trim from
   *         the start of the cmap
   *     trim_end (int, optional): Number of items to trim from the end of the cmap
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Interval Legend")
  @tag("Map Legends")
  @route("/api/legend/interval/{classmapName}")
  @get
  getByClassmapName is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "classmapName"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      classmapName: string;

      /**
       * TODO: add description for "trimStart"?
       */
      @query("trimStart")
      trimStart?: int32;

      /**
       * TODO: add description for "trimEnd"?
       */
      @query("trimEnd")
      trimEnd?: int32;
    },
    void
  >;
}
interface ClassmapLegends {
  /**
   * Generate values and color swatches mapping for a given classmap.
   *
   * Args:
   *     trim_start (int, optional): Number of items to trim
   *         from the start of the cmap
   *     trim_end (int, optional): Number of items to trim from the end of the cmap
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Classmap Legend")
  @tag("Map Legends")
  @route("/api/legend/classmap/{classmapName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "classmapName"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      classmapName: string;

      /**
       * TODO: add description for "trimStart"?
       */
      @query("trimStart")
      trimStart?: int32;

      /**
       * TODO: add description for "trimEnd"?
       */
      @query("trimEnd")
      trimEnd?: int32;
    },
    void
  >;
}
interface Legends {
  /**
   * Generate a legend image for a given colormap.
   *
   * If the colormap has non-contiguous values at the beginning or end,
   * which aren't desired in the output image, they can be trimmed by specifying
   * the number of values to trim.
   *
   * Args:
   *     cmap_name (string): The name of the registered colormap to generate
   *         a legend for
   *     height (float, optional): The output height of the legend image
   *     width (float, optional): The output width of the legend image
   *     trim_start (int, optional): Number of items to trim from
   *         the start of the cmap
   *     trim_end (int, optional): Number of items to trim from the end of the cmap
   *
   * Returns:
   *     HTTP response with jpeg encoded image data
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Legend")
  @tag("Map Legends")
  @route("/api/legend/colormap/{cmapName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "cmapName"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      cmapName: string;

      /**
       * TODO: add description for "height"?
       */
      @query("height")
      height?: float64 = 0.15;

      /**
       * TODO: add description for "width"?
       */
      @query("width")
      width?: float32 = 5;

      /**
       * TODO: add description for "trimStart"?
       */
      @query("trimStart")
      trimStart?: int32;

      /**
       * TODO: add description for "trimEnd"?
       */
      @query("trimEnd")
      trimEnd?: int32;
    },
    void
  >;
}
interface StaticImages {
  /**
   * Create a new image export.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Create Static Image")
  @tag("Image Exports for STAC Collections")
  @route("/api/collections/{collectionId}/image/static")
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
       * TODO: add description for "body"
       */
      @body
      body: ImageRequest;
    },
    ImageResponse
  >;
  /**
   * Fetch an existing image export by ID
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Static Image")
  @tag("Image Exports for STAC Collections")
  @route("/api/collections/{collectionId}/image/static/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Image export ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      id: string;

      /**
       * STAC Collection ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    void
  >;
}
interface MatrixList {
  /**
   * Matrix List
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Matrix List")
  @tag("Tile Matrix Sets")
  @route("/api/tile-matrix-sets")
  @get
  get is Azure.Core.Foundations.Operation<{}, void>;
}
interface MatrixDefinitions {
  /**
   * Matrix Definition
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Matrix Definition")
  @tag("Tile Matrix Sets")
  @route("/api/tile-matrix-sets/{tileMatrixSetId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "tileMatrixSetId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;
    },
    TileMatrixSet
  >;
}
