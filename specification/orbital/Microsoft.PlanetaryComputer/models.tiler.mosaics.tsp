// Tiles for STAC Items interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.common.tsp";
import "./models.common.images.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

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
  buffer?: string;

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
 * Supported algorithms for terrain and index-based analysis
 */
union Algorithm {
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
  bbox?: float64;

  /**
   * GeoJSON geometry to spatially filter items by intersection
   */
  intersects?: GeoJson;

  /**
   * Query
   */
  query?: Record<StringRecord>;

  /**
   * Filter
   */
  filter?: CqlFilter;

  /**
   * Temporal filter in RFC 3339 format or interval
   */
  datetime?: string;

  /**
   * Criteria for ordering items in the mosaic
   */
  sortby?: SortExtension[];

  /**
   * Query language format used in the filter parameter
   */
  @encodedName("application/json", "filter-lang")
  filterLang?: FilterLang;

  /**
   * Additional metadata to associate with the mosaic
   */
  metadata?: Metadata;
}

/**
 * Metadata information for mosaic or search results
 */
model Metadata {
  /**
   * Type of metadata resource
   */
  type?: MetadataType = MetadataType.mosaic;

  /**
   * Geographic bounding box in [west, south, east, north] format
   */
  bounds?: string;

  /**
   * Minimum zoom level supported
   */
  minzoom?: int32;

  /**
   * Maximum zoom level supported
   */
  maxzoom?: int32;

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
model RegisterResponse {
  /**
   * Unique identifier for the registered search
   */
  searchId: string;

  /**
   * Related links for the registered mosaic
   */
  links?: Link[];
}

/**
 * Information about a registered STAC search query
 */
model TitilerPgstacModelInfo {
  /**
   * PgSTAC Search entry.
   *
   * ref:
   * https://github.com/stac-utils/pgstac/blob/3499daa2bfa700ae7bb07503795c169bf2ebafc7/sql/004_search.sql#L907-L915
   *
   * Details of the saved search query
   */
  search: PgStacSearch;

  /**
   * Related links for the search query
   */
  links?: Link[];
}

/**
 * PgSTAC Search entry.
 *
 * ref:
 * https://github.com/stac-utils/pgstac/blob/3499daa2bfa700ae7bb07503795c169bf2ebafc7/sql/004_search.sql#L907-L915
 */
/**
 * Stored search query in the PgSTAC database
 */
model PgStacSearch {
  /**
   * Unique hash identifier for the search query
   */
  hash: string;

  /**
   * Search
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  search: Cql;

  /**
   * SQL WHERE clause representing the search filters
   */
  @encodedName("application/json", "_where")
  where: string;

  /**
   * SQL ORDER BY clause for sorting results
   */
  orderby: string;

  /**
   * Timestamp when the search was last accessed
   */
  lastused: utcDateTime;

  /**
   * Number of times the search has been accessed
   */
  usecount: int32;

  /**
   * Additional metadata associated with the search
   */
  metadata: Metadata;
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
  @summary("Response Assets For Point Api Mosaic  searchId   Lon   Lat  Assets Get")
  body: {}[];
}

/**
 * Parameters controlling the behavior of mosaic operations when searching and combining STAC items
 */
model MosaicSearchQueryParameters {
  /**
   * Return as soon as we scan N items (defaults to 10000 in PgSTAC).
   */
  @query("scan_limit")
  scanLimit?: int32;

  /**
   * Return as soon as we have N items per geometry (defaults to 100 in PgSTAC).
   */
  @query("items_limit")
  itemsLimit?: int32;

  /**
   * Return after N seconds to avoid long requests (defaults to 5 in PgSTAC).
   */
  @query("time_limit")
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
}
