// Tiles for STAC Items interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tiler.common.tsp";
import "./models.common.images.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./models.stac.spec.tsp";
import "./models.common.versions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;

/**
 * Parameters specific to mosaic tile rendering for combining multiple data sources
 */
model MosaicTileQueryParameters {
  /**
   * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
   * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
   * 1.0 = 258x258).
   */
  @query("buffer")
  @typeChangedFrom(Versions.v2026_04_15, string)
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
  collection?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Pixel selection method.
   */
  @query("pixel_selection")
  pixelSelection?: PixelSelection = PixelSelection.first;
}

/**
 * Query parameters for mosaic crop/feature/bbox operations (without buffer).
 */
@added(Versions.v2026_04_15)
model MosaicCropQueryParameters {
  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @added(Versions.v2026_04_15)
  @query("color_formula")
  colorFormula?: string;

  /**
   * STAC Collection ID
   */
  @added(Versions.v2026_04_15)
  @query("collection")
  collection?: string;

  /**
   * Resampling method.
   */
  @added(Versions.v2026_04_15)
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Pixel selection method.
   */
  @added(Versions.v2026_04_15)
  @query("pixel_selection")
  pixelSelection?: PixelSelection = PixelSelection.first;
}

/**
 * Supported algorithms for terrain and index-based analysis
 */
union TerrainAlgorithm {
  string,

  /**
   * Creates hillshade visualization from elevation data
   */
  hillshade: "hillshade",

  /**
   * Generates elevation contour lines
   */
  contours: "contours",

  /**
   * Calculates normalized difference index between bands
   */
  normalizedIndex: "normalizedIndex",

  /**
   * Encodes elevation data in Mapbox Terrarium RGB format
   */
  terrarium: "terrarium",

  /**
   * Encodes elevation data in Mapbox TerrainRGB format
   */
  terrainrgb: "terrainrgb",

  /**
   * Calculates slope from elevation data
   */
  @added(Versions.v2026_04_15)
  slope: "slope",

  /**
   * Casts data to a different type
   */
  @added(Versions.v2026_04_15)
  cast: "cast",

  /**
   * Rounds values up to the nearest integer
   */
  @added(Versions.v2026_04_15)
  ceil: "ceil",

  /**
   * Rounds values down to the nearest integer
   */
  @added(Versions.v2026_04_15)
  floor: "floor",

  /**
   * Computes the minimum value across bands
   */
  @added(Versions.v2026_04_15)
  min: "min",

  /**
   * Computes the maximum value across bands
   */
  @added(Versions.v2026_04_15)
  max: "max",

  /**
   * Computes the median value across bands
   */
  @added(Versions.v2026_04_15)
  median: "median",

  /**
   * Computes the mean value across bands
   */
  @added(Versions.v2026_04_15)
  mean: "mean",

  /**
   * Computes the standard deviation across bands
   */
  @added(Versions.v2026_04_15)
  std: "std",

  /**
   * Computes the variance across bands
   */
  @added(Versions.v2026_04_15)
  var: "var",
}

/**
 * Input parameters for registering a new mosaic of STAC items
 */
model RegisterMosaic {
  /**
   * List of STAC collection IDs to include in the mosaic
   */
  collections?: string[];

  /**
   * List of specific STAC item IDs to include in the mosaic
   */
  ids?: string[];

  /**
   * Geographic bounding box to filter items [west, south, east, north]
   */
  @encodedName("application/json", "bbox")
  boundingBox?: float32[];

  /**
   * GeoJSON geometry to spatially filter items by intersection
   */
  intersects?: Geometry;

  /**
   * Query
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "STAC query requires union types."
  query?: Record<unknown>;

  /**
   * Filter
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "CQL2-JSON query requires union types."
  filter?: Record<unknown>;

  /**
   * Temporal filter in RFC 3339 format or interval
   */
  datetime?: string;

  /**
   * Criteria for ordering items in the mosaic
   */
  @encodedName("application/json", "sortby")
  sortBy?: StacSortExtension[];

  /**
   * Query language format used in the filter parameter
   */
  @encodedName("application/json", "filter-lang")
  filterLanguage?: FilterLanguage;

  /**
   * Additional metadata to associate with the mosaic
   */
  metadata?: MosaicMetadata;
}

/**
 * Metadata information for mosaic or search results
 */
model MosaicMetadata {
  /**
   * Type of metadata resource
   */
  type?: MosaicMetadataType = MosaicMetadataType.mosaic;

  /**
   * Geographic bounding box in [west, south, east, north] format
   */
  bounds?: string;

  /**
   * Minimum zoom level supported
   */
  @encodedName("application/json", "minzoom")
  minZoom?: int32;

  /**
   * Maximum zoom level supported
   */
  @encodedName("application/json", "maxzoom")
  maxZoom?: int32;

  /**
   * Human-readable name for the resource
   */
  name?: string;

  /**
   * List of asset identifiers included in the resource
   */
  assets?: string[];

  /**
   * Defaults
   */
  defaults?: Record<string>;
}

/**
 * Response from a successful mosaic registration with search ID and related links
 */
model TilerMosaicSearchRegistrationResponse {
  /**
   * Unique identifier for the registered search
   */
  @encodedName("application/json", "searchid")
  searchId: string;

  /**
   * Related links for the registered mosaic
   */
  links?: StacLink[];
}

/**
 * Information about a registered STAC search query
 */
model TilerStacSearchRegistration {
  /**
   * Details of the saved search query
   *
   * See the [PgSTAC Search table definition](https://github.com/stac-utils/pgstac/blob/3499daa2bfa700ae7bb07503795c169bf2ebafc7/sql/004_search.sql#L907-L915).
   */
  search: TilerStacSearchDefinition;

  /**
   * Related links for the search query
   */
  links?: StacLink[];
}

/**
 * Stored search query
 *
 * See:
 * https://github.com/stac-utils/pgstac/blob/3499daa2bfa700ae7bb07503795c169bf2ebafc7/sql/004_search.sql#L907-L915
 */
model TilerStacSearchDefinition {
  /**
   * Unique hash identifier for the search query
   */
  hash: string;

  /**
   * Search
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "CQL2-JSON query requires union types."
  search: Record<unknown>;

  /**
   * SQL WHERE clause representing the search filters
   */
  @removed(Versions.v2026_04_15)
  @encodedName("application/json", "_where")
  where: string;

  /**
   * SQL ORDER BY clause for sorting results
   */
  @removed(Versions.v2026_04_15)
  @encodedName("application/json", "orderby")
  orderBy: string;

  /**
   * Timestamp when the search was last accessed
   */
  @encodedName("application/json", "lastused")
  lastUsed: utcDateTime;

  /**
   * Number of times the search has been accessed
   */
  @encodedName("application/json", "usecount")
  useCount: int32;

  /**
   * Additional metadata associated with the search
   */
  metadata: MosaicMetadata;
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
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Third-party API using anonymous array type."
  @bodyRoot
  @summary("Response Assets For Point Api Mosaic  searchId   Lon   Lat  Assets Get")
  body: unknown[];
}

/**
 * Parameters controlling the behavior of mosaic operations when searching and combining STAC items
 */
model MosaicSearchQueryParameters {
  /**
   * Return as soon as we scan N items (defaults to 10000).
   */
  @query("scan_limit")
  scanLimit?: int32;

  /**
   * Return as soon as we have N items per geometry (defaults to 100).
   */
  @query("items_limit")
  itemsLimit?: int32;

  /**
   * Return after N seconds to avoid long requests (defaults to 5).
   */
  @query("time_limit")
  timeLimit?: int32;

  /**
   * Return as soon as the geometry is fully covered (defaults to True).
   */
  @query("exitwhenfull")
  exitWhenFull?: boolean;

  /**
   * Skip any items that would show up completely under the previous items (defaults
   * to True).
   */
  @query("skipcovered")
  skipCovered?: boolean;
}

/**
 * Collection-level mosaic filter parameters (ids, bbox, query, sortby).
 * These apply to collection mosaic endpoints but NOT to registered search endpoints
 * (where the filter criteria are already baked into the search object).
 */
@added(Versions.v2026_04_15)
model CollectionMosaicFilterQueryParameters {
  /**
   * Array of Item ids.
   */
  @query("ids")
  ids?: string;

  /**
   * Bounding box (west, south, east, north).
   */
  @query("bbox")
  bbox?: string;

  /**
   * JSON query expression for filtering items.
   */
  @query("query")
  query?: string;

  /**
   * Sorting expression (e.g. +/-property).
   */
  @query("sortby")
  sortby?: string;

  /**
   * Datetime filter expression (single datetime or range using `/` separator).
   */
  @query("datetime")
  datetime?: string;
}

/**
 * Asset information for the specified point
 */
model StacItemPointAsset {
  /**
   * STAC item ID
   */
  id: string;

  /**
   * Bounding box coordinates for the feature
   */
  @encodedName("application/json", "bbox")
  boundingBox: float32[];

  /**
   * Asset information for the specified point
   */
  assets: Record<StacAsset>;

  /**
   * Collection ID
   */
  @minLength(1)
  @maxLength(500)
  @pattern(".*")
  @encodedName("application/json", "collection")
  collectionId: string;
}
