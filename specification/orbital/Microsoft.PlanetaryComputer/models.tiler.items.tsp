// Tiles for STAC Items interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.common.tsp";
import "./models.common.images.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

/**
 * Parameters for customizing statistical calculations on raster data
 */
model StatisticsQueryParameters {
  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Maximum dimension in pixels for the source data used to calculate statistics
   */
  @query("max_size")
  maxSize?: int32 = 1024;

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
  @query("histogram_bins")
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
  @query("histogram_range")
  histogramRange?: string;
}

/**
 * Parameters for adjusting tile matrix behavior including buffering, color adjustments, and resampling
 */
model TileMatrixSetQueryParameters {
  /**
   * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
   * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
   * 1.0 = 258x258).
   */
  @query("buffer")
  buffer?: string;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;
}

/**
 * Parameters for accessing specific subdatasets within multi-dataset raster assets
 */
model SubDatasetQueryParameters {
  /**
   * The name of a subdataset within the asset.
   */
  @query("subdataset_name")
  subdatasetName?: string;

  /**
   * The index of a subdataset band within the asset.
   */
  @query("subdataset_bands")
  subdatasetBands?: string[];
}

/**
 * Width and height parameters for specifying output image dimensions
 */
model DimensionsQueryParameters {
  /**
   * Height in pixels for the output image
   */
  @query("height")
  height?: int32;

  /**
   * Width in pixels for the output image
   */
  @query("width")
  width?: int32;
}

/**
 * Bounding box path parameters.
 */
model BoundingBoxPathParameters {
  /**
   * Bounding box min X
   */
  @path
  minx: float32;

  /**
   * Bounding box min Y
   */
  @path
  miny: float32;

  /**
   * Bounding box max X
   */
  @path
  maxx: float32;

  /**
   * Bounding box max Y
   */
  @path
  maxy: float32;
}

/**
 * Point model.
 *
 * response model for `/point` endpoints
 */
/**
 * Response model for point query operations providing values at a specific location
 */
model TitilerCoreModelsResponsesPoint {
  /**
   * Geographic coordinates [longitude, latitude] of the queried point
   */
  coordinates: float32[];

  /**
   * Array of pixel values at the queried point for each band
   */
  values: float32[];

  /**
   * Names of each band in the raster data
   */
  @encodedName("application/json", "band_names")
  bandNames: string[];
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
  @summary("Response Info Api Collections  Collection Id  Items  Item Id  Info Get")
  data: TilerInfo;
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
  bounds: float64[];

  /**
   * Band Metadata
   */
  @summary("Band Metadata")
  @encodedName("application/json", "band_metadata")
  bandMetadata?: BandMetadataElement[][];

  /**
   * Band Descriptions
   */
  @summary("Band Descriptions")
  @encodedName("application/json", "band_descriptions")
  bandDescriptions?: string[][];

  /**
   * Data type
   */
  @summary("Dtype")
  dtype: string;

  /**
   * NoData Type
   */
  @summary("Nodata Type")
  @encodedName("application/json", "nodata_type")
  nodataType?: NoDataType;

  /**
   * Color interpretation
   */
  @summary("Colorinterp")
  colorinterp?: string[];

  /**
   * Driver
   */
  @summary("Driver")
  driver?: string;

  /**
   * Count
   */
  @summary("Count")
  count?: int32;

  /**
   * Width
   */
  @summary("Width")
  width?: int32;

  /**
   * Height
   */
  @summary("Height")
  height?: int32;

  /**
   * Overviews
   */
  @summary("Overviews")
  overviews?: string[];

  /**
   * Scales
   */
  @summary("Scales")
  scales?: int64[];

  /**
   * Offsets
   */
  @summary("Offsets")
  offsets?: int64[];

  /**
   * Colormap
   */
  @summary("Colormap")
  colormap?: Record<string[]>;

  /**
   * Minzoom
   */
  @summary("Minzoom")
  minzoom?: int64;

  /**
   * Maxzoom
   */
  @summary("Maxzoom")
  maxzoom?: int64;
}
/**
 * Union type for band metadata elements
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "Unions cannot be emitted to OpenAPI v2 unless all options are literals of the same type."
union BandMetadataElement {
  string,
  Record<string>,
}

/**
 * NoDataType
 */
union NoDataType {
  string,

  /**
   * Nodata represented by alpha channel
   */
  Alpha: "Alpha",

  /**
   * Nodata represented by a mask
   */
  Mask: "Mask",

  /**
   * Nodata represented internally in the dataset
   */
  Internal: "Internal",

  /**
   * Explicit nodata value defined in the dataset
   */
  Nodata: "Nodata",

  /**
   * No nodata value defined
   */
  None: "None",
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

/**
 * Return dataset's statistics.
 */
model AssetStatisticsResponse {
  /**
   * Response Asset Statistics Api Collections  Collection Id  Items  Item Id  Asset Statistics Get
   */
  @statusCode
  statusCode: 200;

  /**
   * Response Asset Statistics Api Collections  Collection Id  Items  Item Id  Asset Statistics Get
   */
  @summary("Response Asset Statistics Api Collections  Collection Id  Items  Item Id  Asset Statistics Get")
  data: Record<BandStatistics>;
}

/**
 * Statistical information about a data band.
 */
model BandStatistics {
  /**
   * Minimum value in the band.
   */
  min: float32;

  /**
   * Maximum value in the band.
   */
  max: float32;

  /**
   * Mean value of the band.
   */
  mean: float32;

  /**
   * Count of pixels in the band.
   */
  count: float32;

  /**
   * Sum of all pixel values in the band.
   */
  sum: float32;

  /**
   * Standard deviation of pixel values in the band.
   */
  std: float32;

  /**
   * Median value of the band.
   */
  median: float32;

  /**
   * Most common value in the band.
   */
  majority: float32;

  /**
   * Least common value in the band.
   */
  minority: float32;

  /**
   * Count of unique values in the band.
   */
  unique: float32;

  /**
   * Histogram of pixel values in the band.
   */
  histogram: float32[][];

  /**
   * Percentage of valid (non-masked) pixels.
   */
  @encodedName("application/json", "valid_percent")
  validPercent: float32;

  /**
   * Count of masked pixels in the band.
   */
  @encodedName("application/json", "masked_pixels")
  maskedPixels: float32;

  /**
   * Count of valid (non-masked) pixels in the band.
   */
  @encodedName("application/json", "valid_pixels")
  validPixels: float32;

  /**
   * Percentile 2
   * The 2nd percentile value.
   */
  @encodedName("application/json", "percentile_2")
  percentile2: float32;

  /**
   * Percentile 98
   * The 98th percentile value.
   */
  @encodedName("application/json", "percentile_98")
  percentile98: float32;
}

/**
 * Return dataset's statistics.
 */
model StatisticsResponse is Record<BandStatistics>;

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

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/item-spec/itemcollection-spec.md
 */
/**
 * Collection of STAC items with statistical information
 */
model GeoJsonStatisticsItemCollectionResponse {
  /**
   * GeoJSON type identifier for ItemCollection
   */
  type: ItemCollectionType;

  /**
   * Array of STAC items with statistics
   */
  features: GeoJsonStatisticsItemResponse[];

  /**
   * Bounding box coordinates [west, south, east, north]
   */
  bbox?: float64[];

  /**
   * Stac Version
   */
  @minLength(1)
  @encodedName("application/json", "stac_version")
  stacVersion?: string = "1.0.0";

  /**
   * MSFT Created
   */
  @encodedName("application/json", "msft:_created")
  msftCreated?: string;

  /**
   * MSFT Updated
   */
  @encodedName("application/json", "msft:_updated")
  msftUpdated?: string;

  /**
   * MSFT Short Description
   */
  @maxLength(300)
  @encodedName("application/json", "msft:short_description")
  msftShortDescription?: string;

  /**
   * List of STAC extension URLs used by this item collection
   */
  @encodedName("application/json", "stac_extensions")
  stacExtensions?: url[];

  /**
   * Related links for the item collection
   */
  links?: Link[];

  /**
   *
   * https://github.com/radiantearth/stac-api-spec/tree/master/extensions/context#context-extension-specification
   *
   * Pagination context for the response
   */
  context?: ContextExtension;
}

/**
 * STAC Item representing a spatiotemporal asset with statistical information
 */
model GeoJsonStatisticsItemResponse {
  ...Feature;
  ...MicrosoftStacProperties;

  /**
   * Stac Version
   */
  @minLength(1)
  @encodedName("application/json", "stac_version")
  stacVersion?: string = "1.0.0";

  /**
   * ID of the STAC collection this item belongs to
   */
  collection?: string;

  /**
   * Properties
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" ""
  properties: ItemProperties;

  /**
   * MSFT Timestamp
   */
  @encodedName("application/json", "_msft:ts")
  msftTimestamp?: string;

  /**
   * MSFT ETag
   */
  @encodedName("application/json", "_msft:etag")
  msftEtag?: string;

  /**
   * List of STAC extension URLs used by this item
   */
  @encodedName("application/json", "stac_extensions")
  stacExtensions?: url[];
}
