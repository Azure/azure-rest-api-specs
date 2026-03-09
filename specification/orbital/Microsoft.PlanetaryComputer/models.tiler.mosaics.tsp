// Tiles for STAC Items interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.common.tsp";
import "./models.common.images.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./models.stac.spec.tsp";

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
  @encodedName("application/json", "_where")
  where: string;

  /**
   * SQL ORDER BY clause for sorting results
   */
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
  exitWhenFull?: boolean;

  /**
   * Skip any items that would show up completely under the previous items (defaults
   * to True in PgSTAC).
   */
  @query("skipcovered")
  skipCovered?: boolean;
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
