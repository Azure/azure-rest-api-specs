import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MicrosoftPlanetaryComputerPro;

/**
 *
 * https://github.com/radiantearth/stac-api-spec/blob/master/api-spec.md#paging-extension
 */
/**
 * TODO: add description for PaginationRelations
 */
union PaginationRelations {
  string,

  /**
   * TODO: add description for next
   */
  next: "next",

  /**
   * TODO: add description for previous
   */
  previous: "previous",
}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/blob/master/api-spec.md#paging-extension
 */
/**
 * TODO: add description for PaginationMethods
 */
union PaginationMethods {
  string,

  /**
   * TODO: add description for GET
   */
  GET: "GET",

  /**
   * TODO: add description for POST
   */
  POST: "POST",
}

/**
 * Type
 */
/**
 * TODO: add description for PointType
 */
union PointType {
  string,

  /**
   * TODO: add description for Point
   */
  Point: "Point",
}

/**
 * An enumeration.
 */
/**
 * TODO: add description for SortDirections
 */
union SortDirections {
  string,

  /**
   * TODO: add description for asc
   */
  asc: "asc",

  /**
   * TODO: add description for desc
   */
  desc: "desc",
}

/**
 * Choices for filter-lang value in a POST request.
 *
 * Based on
 * https://github.com/stac-api-extensions/filter#queryables
 *
 * Note the addition of cql2-json, which is used by the pgstac backend,
 * but is not included in the spec above.
 */
/**
 * TODO: add description for FilterLang
 */
union FilterLang {
  string,

  /**
   * TODO: add description for cql-json
   */
  `cql-json`: "cql-json",

  /**
   * TODO: add description for cql2-json
   */
  `cql2-json`: "cql2-json",

  /**
   * TODO: add description for cql2-text
   */
  `cql2-text`: "cql2-text",
}

/**
 * TODO: add description for SearchPostRequestFilterLang
 */
union SearchPostRequestFilterLang {
  string,

  /**
   * TODO: add description for cql-json
   */
  `cql-json`: "cql-json",

  /**
   * TODO: add description for cql2-json
   */
  `cql2-json`: "cql2-json",

  /**
   * TODO: add description for cql2-text
   */
  `cql2-text`: "cql2-text",
}

/**
 * Type
 */
/**
 * TODO: add description for GeoCatalogCollectionType
 */
union GeoCatalogCollectionType {
  string,

  /**
   * TODO: add description for Collection
   */
  Collection: "Collection",
}

/**
 * An enumeration.
 */
/**
 * TODO: add description for DataType
 */
union DataType {
  string,

  /**
   * TODO: add description for number
   */
  number: "number",

  /**
   * TODO: add description for float
   */
  float64: "float",

  /**
   * TODO: add description for text
   */
  text: "text",

  /**
   * TODO: add description for array
   */
  array: "array",
}

/**
 * TODO: add description for QueryableDefinitionDataType
 */
union QueryableDefinitionDataType {
  string,

  /**
   * TODO: add description for number
   */
  number: "number",

  /**
   * TODO: add description for float
   */
  float64: "float",

  /**
   * TODO: add description for text
   */
  text: "text",

  /**
   * TODO: add description for array
   */
  array: "array",
}

/**
 * The type of render option
 */
/**
 * TODO: add description for RenderOptionType
 */
union RenderOptionType {
  string,

  /**
   * TODO: add description for raster-tile
   */
  `raster-tile`: "raster-tile",

  /**
   * TODO: add description for vt-polygon
   */
  `vt-polygon`: "vt-polygon",

  /**
   * TODO: add description for vt-line
   */
  `vt-line`: "vt-line",
}

/**
 * An enumeration.
 */
/**
 * TODO: add description for LegendTypes
 */
union LegendTypes {
  string,

  /**
   * TODO: add description for continuous
   */
  continuous: "continuous",

  /**
   * TODO: add description for classmap
   */
  classmap: "classmap",

  /**
   * TODO: add description for interval
   */
  interval: "interval",

  /**
   * TODO: add description for none
   */
  none: "none",
}

/**
* Legend type to make,
 one of: `continuous`,
 `classmap`,
 `interval` or `none`
* (note, `none` is a string literal).
*/
/**
 * TODO: add description for LegendConfigType
 */
union LegendConfigType {
  string,

  /**
   * TODO: add description for continuous
   */
  continuous: "continuous",

  /**
   * TODO: add description for classmap
   */
  classmap: "classmap",

  /**
   * TODO: add description for interval
   */
  interval: "interval",

  /**
   * TODO: add description for none
   */
  none: "none",
}

/**
 * The type of partitioning to use.
 */
/**
 * TODO: add description for PartitionTypeScheme
 */
union PartitionTypeScheme {
  string,

  /**
   * TODO: add description for year
   */
  year: "year",

  /**
   * TODO: add description for month
   */
  month: "month",

  /**
   * TODO: add description for none
   */
  none: "none",
}

/**
 * Type
 */
/**
 * TODO: add description for ItemType
 */
union ItemType {
  string,

  /**
   * TODO: add description for Feature
   */
  Feature: "Feature",
}

/**
 * Type
 */
/**
 * TODO: add description for ItemCollectionType
 */
union ItemCollectionType {
  string,

  /**
   * TODO: add description for FeatureCollection
   */
  FeatureCollection: "FeatureCollection",
}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/blob/master/api-spec.md#ogc-api---features-endpoints
 */
/**
 * TODO: add description for LandingPage
 */
model LandingPage {
  /**
   * Id
   */
  /**
   * TODO: add description for id
   */
  @minLength(1)
  id: string;

  /**
   * Description
   */
  /**
   * TODO: add description for description
   */
  @minLength(1)
  description: string;

  /**
   * Title
   */
  /**
   * TODO: add description for title
   */
  title?: string;

  /**
   * Stac Version
   */
  @encodedName("application/json", "stac_version")
  stacVersion?: string = "1.0.0";

  /**
   * Stac Extensions
   */
  /**
   * TODO: add description for stacExtensions
   */
  @encodedName("application/json", "stac_extensions")
  stacExtensions?: url[];

  /**
   * Conformsto
   */
  /**
   * TODO: add description for conformsTo
   */
  conformsTo: url[];

  /**
   * Links
   */
  /**
   * TODO: add description for links
   */
  links: LinksItem[];

  /**
   * Type
   */
  @minLength(1)
  type?: string = "Catalog";
}

/**
 * TODO: add description for LinksItem
 */
model LinksItem {}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/blob/master/api-spec.md#paging-extension
 */
/**
 * TODO: add description for PaginationLink
 */
model PaginationLink {
  /**
   * Href
   */
  /**
   * TODO: add description for href
   */
  @minLength(1)
  href: string;

  /**
   *
   * https://github.com/radiantearth/stac-api-spec/blob/master/api-spec.md#paging-extension
   */
  /**
   * TODO: add description for rel
   */
  rel: PaginationRelations;

  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type?: string;

  /**
   * Title
   */
  /**
   * TODO: add description for title
   */
  title?: string;

  /**
   * Label:Assets
   */
  /**
   * TODO: add description for labelAssets
   */
  @encodedName("application/json", "label:assets")
  labelAssets?: string;

  /**
   *
   * https://github.com/radiantearth/stac-api-spec/blob/master/api-spec.md#paging-extension
   */
  /**
   * TODO: add description for method
   */
  method: PaginationMethods;

  /**
   * Body
   */
  body?: Record<string>;

  /**
   * Merge
   */
  /**
   * TODO: add description for merge
   */
  merge?: boolean;
}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/blob/master/api-spec.md#ogc-api---features-endpoints
 */
/**
 * TODO: add description for ConformanceClasses
 */
model ConformanceClasses {
  /**
   * Conformsto
   */
  /**
   * TODO: add description for conformsTo
   */
  conformsTo: url[];
}

/**
 * Search model.
 *
 * Overrides the validation for datetime from the base request model.
 */
/**
 * TODO: add description for SearchPostRequest
 */
model SearchPostRequest {
  /**
   * Collections
   */
  /**
   * TODO: add description for collections
   */
  collections?: string[];

  /**
   * Ids
   */
  /**
   * TODO: add description for ids
   */
  ids?: string[];

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;

  /**
   * Intersects
   */
  /**
   * TODO: add description for intersects
   */
  intersects?: SearchPostRequestIntersects;

  /**
   * Datetime
   */
  /**
   * TODO: add description for datetime
   */
  datetime?: string;

  /**
   * Limit
   */
  /**
   * TODO: add description for limit
   */
  @maxValue(1000)
  @minValue(1)
  limit?: int32 = 250;

  /**
   * Conf
   */
  conf?: Record<string>;

  /**
   * Sign
   */
  /**
   * TODO: add description for sign
   */
  sign?: boolean;

  /**
   * Duration
   */
  /**
   * TODO: add description for duration
   */
  duration?: int32;

  /**
   * Query
   */
  query?: Record<StringRecord>;

  /**
   * Sortby
   */
  /**
   * TODO: add description for sortby
   */
  sortby?: SortExtension[];

  /**
   * Fields
   */
  /**
   * TODO: add description for fields
   */
  fields?: SearchPostRequestFields[];

  /**
   * Filter
   */
  filter?: Record<string>;

  /**
   * Filter-Crs
   */
  /**
   * TODO: add description for filterCrs
   */
  @encodedName("application/json", "filter-crs")
  filterCrs?: string;

  /**
   * TODO: add description for filterLang
   */
  @encodedName("application/json", "filter-lang")
  filterLang?: SearchPostRequestFilterLang = SearchPostRequestFilterLang.`cql-json`;

  /**
   * Token
   */
  /**
   * TODO: add description for token
   */
  token?: string;
}

/**
 * Intersects
 */
/**
 * TODO: add description for SearchPostRequestIntersects
 */
model SearchPostRequestIntersects {}

/**
 * Point Model
 */
/**
 * TODO: add description for Point
 */
model Point {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: PointType;

  /**
   * Coordinates
   */
  /**
   * TODO: add description for coordinates
   */
  coordinates: string;

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/tree/master/extensions/sort#sort-api-extension
 */
/**
 * TODO: add description for SortExtension
 */
model SortExtension {
  /**
   * Field
   */
  /**
   * TODO: add description for field
   */
  @minLength(1)
  field: string;

  /**
   * An enumeration.
   */
  /**
   * TODO: add description for direction
   */
  direction: SortDirections;
}

/**
 * Fields
 */
/**
 * TODO: add description for SearchPostRequestFields
 */
model SearchPostRequestFields is PostFieldsExtension;

/**
 * FieldsExtension.
 *
 * Attributes:
 *     include: set of fields to include.
 *     exclude: set of fields to exclude.
 */
/**
 * TODO: add description for PostFieldsExtension
 */
model PostFieldsExtension {
  /**
   * Include
   */
  include?: string[] = #[];

  /**
   * Exclude
   */
  exclude?: string[] = #[];
}

/**
 *
 * http://docs.opengeospatial.org/is/17-069r3/17-069r3.html#_feature_collections_rootcollections
 */
/**
 * TODO: add description for Collections
 */
model Collections {
  /**
   * Links
   */
  /**
   * TODO: add description for links
   */
  links: Link[];

  /**
   * Collections
   */
  /**
   * TODO: add description for collections
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  collections: Collection[];
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md
 */
/**
 * TODO: add description for Collection
 */
model Collection {
  /**
   * Id
   */
  /**
   * TODO: add description for id
   */
  @minLength(1)
  id: string;

  /**
   * Description
   */
  /**
   * TODO: add description for description
   */
  @minLength(1)
  description: string;

  /**
   * Stac Version
   */
  @minLength(1)
  @encodedName("application/json", "stac_version")
  stacVersion?: string = "1.0.0";

  /**
   * Links
   */
  /**
   * TODO: add description for links
   */
  links: LinksItem[];

  /**
   * Stac Extensions
   */
  /**
   * TODO: add description for stacExtensions
   */
  @encodedName("application/json", "stac_extensions")
  stacExtensions?: url[];

  /**
   * Title
   */
  /**
   * TODO: add description for title
   */
  title?: string;

  /**
   * Type
   */
  @minLength(1)
  type?: string = "Collection";

  /**
   * Assets
   */
  assets?: Record<Asset>;

  /**
   * License
   */
  /**
   * TODO: add description for license
   */
  @minLength(1)
  license: string;

  /**
   *
   * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#extent-object
   */
  /**
   * TODO: add description for extent
   */
  extent: Extent;

  /**
   * Keywords
   */
  /**
   * TODO: add description for keywords
   */
  keywords?: string[];

  /**
   * Providers
   */
  /**
   * TODO: add description for providers
   */
  providers?: Provider[];

  /**
   * Summaries
   */
  summaries?: Record<string>;
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/item-spec/item-spec.md#asset-object
 */
/**
 * TODO: add description for Asset
 */
model Asset {
  /**
   * Title
   */
  /**
   * TODO: add description for title
   */
  title?: string;

  /**
   * Description
   */
  /**
   * TODO: add description for description
   */
  description?: string;

  /**
   * Start Datetime
   */
  /**
   * TODO: add description for startDatetime
   */
  @encodedName("application/json", "start_datetime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDatetime?: utcDateTime;

  /**
   * End Datetime
   */
  /**
   * TODO: add description for endDatetime
   */
  @encodedName("application/json", "end_datetime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDatetime?: utcDateTime;

  /**
   * Created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  /**
   * TODO: add description for created
   */
  created?: utcDateTime;

  /**
   * Updated
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  /**
   * TODO: add description for updated
   */
  updated?: utcDateTime;

  /**
   * Platform
   */
  /**
   * TODO: add description for platform
   */
  platform?: string;

  /**
   * Instruments
   */
  /**
   * TODO: add description for instruments
   */
  instruments?: string[];

  /**
   * Constellation
   */
  /**
   * TODO: add description for constellation
   */
  constellation?: string;

  /**
   * Mission
   */
  /**
   * TODO: add description for mission
   */
  mission?: string;

  /**
   * Providers
   */
  /**
   * TODO: add description for providers
   */
  providers?: Provider[];

  /**
   * Gsd
   */
  /**
   * TODO: add description for gsd
   */
  gsd?: float32;

  /**
   * Href
   */
  /**
   * TODO: add description for href
   */
  @minLength(1)
  href: string;

  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type?: string;

  /**
   * Roles
   */
  /**
   * TODO: add description for roles
   */
  roles?: string[];
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#provider-object
 */
/**
 * TODO: add description for Provider
 */
model Provider {
  /**
   * Name
   */
  /**
   * TODO: add description for name
   */
  @minLength(1)
  name: string;

  /**
   * Description
   */
  /**
   * TODO: add description for description
   */
  description?: string;

  /**
   * Roles
   */
  /**
   * TODO: add description for roles
   */
  roles?: string[];

  /**
   * Url
   */
  /**
   * TODO: add description for url
   */
  url?: string;
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#extent-object
 */
/**
 * TODO: add description for Extent
 */
model Extent {
  /**
   *
   * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#spatial-extent-object
   */
  /**
   * TODO: add description for spatial
   */
  spatial: SpatialExtent;

  /**
   *
   * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#temporal-extent-object
   */
  /**
   * TODO: add description for temporal
   */
  temporal: TimeInterval;
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#spatial-extent-object
 */
/**
 * TODO: add description for SpatialExtent
 */
model SpatialExtent {
  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox: string[][];
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#temporal-extent-object
 */
/**
 * TODO: add description for TimeInterval
 */
model TimeInterval {
  /**
   * Interval
   */
  /**
   * TODO: add description for interval
   */
  interval: string[][];
}

/**
 * GeoCatalogCollection
 */
/**
 * TODO: add description for GeoCatalogCollection
 */
model GeoCatalogCollection {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: GeoCatalogCollectionType;

  /**
   * Stac Version
   */
  /**
   * TODO: add description for stacVersion
   */
  @encodedName("application/json", "stac_version")
  stacVersion: string;

  /**
   * Id
   */
  /**
   * TODO: add description for id
   */
  id: string;

  /**
   * Description
   */
  /**
   * TODO: add description for description
   */
  description: string;

  /**
   * Links
   */
  links: Record<string>[];

  /**
   * License
   */
  /**
   * TODO: add description for license
   */
  license: string;

  /**
   * Extent
   */
  extent: Record<string>;

  /**
   * Stac Extensions
   */
  /**
   * TODO: add description for stacExtensions
   */
  @encodedName("application/json", "stac_extensions")
  stacExtensions?: string[];

  /**
   * Title
   */
  /**
   * TODO: add description for title
   */
  title?: string;

  /**
   * Keywords
   */
  /**
   * TODO: add description for keywords
   */
  keywords?: string[];

  /**
   * Providers
   */
  providers?: Record<string>[];

  /**
   * Assets
   */
  assets?: Record<string>;

  /**
   * Summaries
   */
  summaries?: Record<string>;

  /**
   * Msft:Short Description
   */
  /**
   * TODO: add description for msftShortDescription
   */
  @maxLength(300)
  @encodedName("application/json", "msft:short_description")
  msftShortDescription?: string;
}

/**
 * QueryableDefinition
 */
/**
 * TODO: add description for QueryableDefinition
 */
model QueryableDefinition {
  /**
   * Name
   */
  /**
   * TODO: add description for name
   */
  @minLength(1)
  name: string;

  /**
   * Definition
   */
  definition: Record<string>;

  /**
   * Create Index
   */
  /**
   * TODO: add description for createIndex
   */
  @encodedName("application/json", "create_index")
  createIndex?: boolean;

  /**
   * TODO: add description for dataType
   */
  @encodedName("application/json", "data_type")
  dataType?: QueryableDefinitionDataType = QueryableDefinitionDataType.text;
}

/**
 * AzMapsToken
 */
/**
 * TODO: add description for AzMapsToken
 */
model AzMapsToken {
  /**
   * Token
   */
  /**
   * TODO: add description for token
   */
  token: string;

  /**
   * Expires On
   */
  /**
   * TODO: add description for expiresOn
   */
  @encodedName("application/json", "expires_on")
  expiresOn: int32;
}

/**
 * AzMapsClientId
 */
/**
 * TODO: add description for AzMapsClientId
 */
model AzMapsClientId {
  /**
   * Client Id
   */
  /**
   * TODO: add description for clientId
   */
  @encodedName("application/json", "client_id")
  clientId: string;
}

/**
 * Configuration for MSAL authentication in frontend application.
 */
/**
 * TODO: add description for AuthConfig
 */
model AuthConfig {
  /**
   * Authn App Id
   */
  /**
   * TODO: add description for authnAppId
   */
  @encodedName("application/json", "authn_app_id")
  authnAppId: string;

  /**
   * Tenant Id
   */
  /**
   * TODO: add description for tenantId
   */
  @encodedName("application/json", "tenant_id")
  tenantId: string;

  /**
   * Instance
   */
  /**
   * TODO: add description for instance
   */
  instance: url;

  /**
   * Redirect Uri
   */
  /**
   * TODO: add description for redirectUri
   */
  @encodedName("application/json", "redirect_uri")
  redirectUri?: url;
}

/**
 * UserCollectionSettings
 */
/**
 * TODO: add description for UserCollectionSettings
 */
model UserCollectionSettings {
  /**
   * TileSettings
   */
  /**
   * TODO: add description for tileSettings
   */
  tileSettings: TileSettings;

  /**
   * MosaicInfo
   */
  /**
   * TODO: add description for mosaicInfo
   */
  mosaicInfo: MosaicInfo;
}

/**
 * TileSettings
 */
/**
 * TODO: add description for TileSettings
 */
model TileSettings {
  /**
   * The minimum zoom level that can be requested for this collection. Provides a
   * hard limit for the tile servers to ensure they don't get requests for low zoom
   * levels, which would cause many files to be fetched and the tile servers to
   * hang.
   */
  /**
   * TODO: add description for minZoom
   */
  @maxValue(24)
  minZoom: int32;

  /**
   * The maximum number of items that will be fetched while generating a raster tile.
   */
  /**
   * TODO: add description for maxItemsPerTile
   */
  maxItemsPerTile: int32;

  /**
   * Defines a default location for showcasing a collection.
   */
  /**
   * TODO: add description for defaultLocation
   */
  defaultLocation?: DefaultLocation;
}

/**
 * Defines a default location for showcasing a collection.
 */
/**
 * TODO: add description for DefaultLocation
 */
model DefaultLocation {
  /**
   * Zoom level at which to center the map.
   */
  /**
   * TODO: add description for zoom
   */
  @maxValueExclusive(24)
  zoom: int32;

  /**
   * Coordinates at which to center the map, [latitude, longitude]
   */
  /**
   * TODO: add description for coordinates
   */
  coordinates: float32[];
}

/**
 * MosaicInfo
 */
/**
 * TODO: add description for MosaicInfo
 */
model MosaicInfo {
  /**
   * Mosaics
   */
  /**
   * TODO: add description for mosaics
   */
  mosaics: Mosaic[];

  /**
   * Renderoptions
   */
  /**
   * TODO: add description for renderOptions
   */
  renderOptions: RenderOption[];

  /**
   * Defines a default location for showcasing a collection.
   */
  /**
   * TODO: add description for defaultLocation
   */
  defaultLocation?: DefaultLocation;

  /**
   * A list of CQL-JSON expressions to use as the default for  this collection.
   */
  defaultCustomQuery?: Record<string>;
}

/**
 * A single predefined CQL2-JSON query representing a named mosaic.
 */
/**
 * TODO: add description for Mosaic
 */
model Mosaic {
  /**
   * A unique identifier for this mosaic.
   */
  /**
   * TODO: add description for id
   */
  @maxLength(30)
  @minLength(1)
  @pattern("^(?!\\-|_)[a-zA-Z0-9_-]*(?<!\\-|_)$")
  id: string;

  /**
   * A short name for this mosaic that describes its content.
   */
  /**
   * TODO: add description for name
   */
  @maxLength(30)
  name: string;

  /**
   * A longer description of the mosaic contents.
   */
  /**
   * TODO: add description for description
   */
  description?: string;

  /**
   * A list of valid CQL2-JSON expressions used to filter the collection to moasic.
   */
  cql: Record<string>[];
}

/**
 * Defines a set of map-tile render options for a collection.
 */
/**
 * TODO: add description for RenderOption
 */
model RenderOption {
  /**
   * A unique identifier for this render option.
   */
  /**
   * TODO: add description for id
   */
  @maxLength(30)
  @minLength(1)
  @pattern("^(?!\\-|_)[a-zA-Z0-9_-]*(?<!\\-|_)$")
  id: string;

  /**
   * A short name for this render option that describes its content.
   */
  /**
   * TODO: add description for name
   */
  @maxLength(40)
  name: string;

  /**
   * A longer description of the render option that can be used to explain its
   * content.
   */
  /**
   * TODO: add description for description
   */
  description?: string;

  /**
   * The type of render option
   */
  /**
   * TODO: add description for type
   */
  type?: RenderOptionType = RenderOptionType.`raster-tile`;

  /**
   * A URL query-string encoded string of TiTiler rendering options. Valid only for
   * `raster-tile` types.  See 'Query Parameters':
   * https://developmentseed.org/titiler/endpoints/cog/#description
   */
  /**
   * TODO: add description for options
   */
  options?: string;

  /**
   * Options for rendering vector tiles. Valid only for `vt-polygon`  and `vt-line`
   * types.
   */
  /**
   * TODO: add description for vectorOptions
   */
  vectorOptions?: RenderOptionVectorOptions;

  /**
   * Zoom level at which to start rendering the layer.
   */
  /**
   * TODO: add description for minZoom
   */
  @maxValue(24)
  minZoom?: int32 = 12;

  /**
   * An optional legend configuration.
   */
  /**
   * TODO: add description for legend
   */
  legend?: RenderOptionLegend;

  /**
   * A list of property/value conditions that must be in the active mosaic CQL for
   * this render option to be enabled
   */
  /**
   * TODO: add description for conditions
   */
  conditions?: RenderOptionCondition[];
}

/**
 * Options for rendering vector tiles. Valid only for `vt-polygon`  and `vt-line`
 * types.
 */
/**
 * TODO: add description for RenderOptionVectorOptions
 */
model RenderOptionVectorOptions is VectorTileOptions;

/**
 * Defines a set of vector tile render options for a collection.
 */
/**
 * TODO: add description for VectorTileOptions
 */
model VectorTileOptions {
  /**
   * The key in the collection-level assets which contains the tilejson URL.
   */
  /**
   * TODO: add description for tilejsonKey
   */
  tilejsonKey: string;

  /**
   * The source layer name to render from the associated vector tiles.
   */
  /**
   * TODO: add description for sourceLayer
   */
  sourceLayer: string;

  /**
   * The css-style fill color for polygons. Can be hex or rgba()
   */
  /**
   * TODO: add description for fillColor
   */
  fillColor?: string;

  /**
   * The css-style stroke color for lines. Can be hex or rgba()
   */
  /**
   * TODO: add description for strokeColor
   */
  strokeColor?: string;

  /**
   * The stroke width for lines.
   */
  /**
   * TODO: add description for strokeWidth
   */
  strokeWidth?: int32;

  /**
   * MapBox Filter Expression to filter vector features by.
   */
  /**
   * TODO: add description for filter
   */
  filter?: string[];
}

/**
 * An optional legend configuration.
 */
/**
 * TODO: add description for RenderOptionLegend
 */
model RenderOptionLegend is LegendConfig;

/**
 * Defines settings to customize legend generation.
 */
/**
 * TODO: add description for LegendConfig
 */
model LegendConfig {
  /**
* Legend type to make,
 one of: `continuous`,
 `classmap`,
 `interval` or `none`
* (note, `none` is a string literal).
*/
  /**
   * TODO: add description for type
   */
  type?: LegendConfigType;

  /**
   * List of string labels that will be flex spaced-between under the legend image.
   */
  /**
   * TODO: add description for labels
   */
  labels?: string[];

  /**
   * The number of items to trim from the start of the legend definition. Used if
   * there are values important for rendering (e.g. nodata) that aren't desirable in
   * the legend.
   */
  /**
   * TODO: add description for trimStart
   */
  trimStart?: int32;

  /**
   * Same as trim_start, but for the end of the legend definition.
   */
  /**
   * TODO: add description for trimEnd
   */
  trimEnd?: int32;

  /**
   * A factor to multiply interval legend labels by. Useful for scaled rasters whose
   * colormap definitions map to unscaled values, effectively showing legend labels
   * as scaled values.
   */
  /**
   * TODO: add description for scaleFactor
   */
  scaleFactor?: float32;
}

/**
 * Defines a property/value condition for a render config to be enabled
 */
/**
 * TODO: add description for RenderOptionCondition
 */
model RenderOptionCondition {
  /**
   * The property attribute name to check.
   */
  /**
   * TODO: add description for property
   */
  property: string;

  /**
   * The value on which to perform an equality check.
   */
  /**
   * TODO: add description for value
   */
  value?: string;
}

/**
 * PartitionType
 */
/**
 * TODO: add description for PartitionType
 */
model PartitionType {
  /**
   * The type of partitioning to use.
   */
  /**
   * TODO: add description for scheme
   */
  scheme?: PartitionTypeScheme = PartitionTypeScheme.none;
}

/**
 * Body_create_collection_asset
 */
/**
 * TODO: add description for BodyCreateCollectionAsset
 */
model BodyCreateCollectionAsset {
  /**
   * File
   */
  /**
   * TODO: add description for file
   */
  file: bytes;

  /**
   * Data
   */
  /**
   * TODO: add description for data
   */
  data: string;
}

/**
 * Body_update_collection_asset
 */
/**
 * TODO: add description for BodyUpdateCollectionAsset
 */
model BodyUpdateCollectionAsset {
  /**
   * File
   */
  /**
   * TODO: add description for file
   */
  file?: bytes;

  /**
   * Data
   */
  /**
   * TODO: add description for data
   */
  data: string;
}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/tree/master/extensions/context#context-extension-specification
 */
/**
 * TODO: add description for ContextExtension
 */
model ContextExtension {
  /**
   * Returned
   */
  /**
   * TODO: add description for returned
   */
  returned: int32;

  /**
   * Limit
   */
  /**
   * TODO: add description for limit
   */
  limit?: int32;

  /**
   * Matched
   */
  /**
   * TODO: add description for matched
   */
  matched?: int32;
}

/**
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/item-spec/item-spec.md
 */
/**
 * TODO: add description for Item
 */
model Item {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: ItemType;

  /**
   * Geometry
   */
  /**
   * TODO: add description for geometry
   */
  geometry: ItemGeometry;

  /**
   *
   * https://github.com/radiantearth/stac-spec/blob/v1.0.0/item-spec/item-spec.md#properties-object
   */
  /**
   * TODO: add description for properties
   */
  properties: ItemProperties;

  /**
   * Id
   */
  /**
   * TODO: add description for id
   */
  @minLength(1)
  id: string;

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;

  /**
   * Stac Version
   */
  @minLength(1)
  @encodedName("application/json", "stac_version")
  stacVersion?: string = "1.0.0";

  /**
   * Assets
   */
  assets: Record<Asset>;

  /**
   * Links
   */
  /**
   * TODO: add description for links
   */
  links: LinksItem[];

  /**
   * Stac Extensions
   */
  /**
   * TODO: add description for stacExtensions
   */
  @encodedName("application/json", "stac_extensions")
  stacExtensions?: url[];

  /**
   * Collection
   */
  /**
   * TODO: add description for collection
   */
  collection?: string;
}

/**
 * Geometry
 */
/**
 * TODO: add description for ItemGeometry
 */
model ItemGeometry {}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/item-spec/item-spec.md#properties-object
 */
/**
 * TODO: add description for ItemProperties
 */
model ItemProperties {
  /**
   * Title
   */
  /**
   * TODO: add description for title
   */
  title?: string;

  /**
   * Description
   */
  /**
   * TODO: add description for description
   */
  description?: string;

  /**
   * Start Datetime
   */
  /**
   * TODO: add description for startDatetime
   */
  @encodedName("application/json", "start_datetime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDatetime?: utcDateTime;

  /**
   * End Datetime
   */
  /**
   * TODO: add description for endDatetime
   */
  @encodedName("application/json", "end_datetime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDatetime?: utcDateTime;

  /**
   * Created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  /**
   * TODO: add description for created
   */
  created?: utcDateTime;

  /**
   * Updated
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  /**
   * TODO: add description for updated
   */
  updated?: utcDateTime;

  /**
   * Platform
   */
  /**
   * TODO: add description for platform
   */
  platform?: string;

  /**
   * Instruments
   */
  /**
   * TODO: add description for instruments
   */
  instruments?: string[];

  /**
   * Constellation
   */
  /**
   * TODO: add description for constellation
   */
  constellation?: string;

  /**
   * Mission
   */
  /**
   * TODO: add description for mission
   */
  mission?: string;

  /**
   * Providers
   */
  /**
   * TODO: add description for providers
   */
  providers?: Provider[];

  /**
   * Gsd
   */
  /**
   * TODO: add description for gsd
   */
  gsd?: float32;

  /**
   * Datetime
   */
  /**
   * TODO: add description for datetime
   */
  datetime: string;
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/item-spec/itemcollection-spec.md
 */
/**
 * TODO: add description for ItemCollection
 */
model ItemCollection {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: ItemCollectionType;

  /**
   * Features
   */
  /**
   * TODO: add description for features
   */
  features: Item[];

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;

  /**
   * Stac Version
   */
  @minLength(1)
  @encodedName("application/json", "stac_version")
  stacVersion?: string = "1.0.0";

  /**
   * Stac Extensions
   */
  /**
   * TODO: add description for stacExtensions
   */
  @encodedName("application/json", "stac_extensions")
  stacExtensions?: url[];

  /**
   * Links
   */
  /**
   * TODO: add description for links
   */
  links: LinksItem[];

  /**
   *
   * https://github.com/radiantearth/stac-api-spec/tree/master/extensions/context#context-extension-specification
   */
  /**
   * TODO: add description for context
   */
  context?: ContextExtension;
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#stats-object
 */
/**
 * TODO: add description for Range
 */
model Range {
  /**
   * Minimum
   */
  /**
   * TODO: add description for minimum
   */
  minimum: string;

  /**
   * Maximum
   */
  /**
   * TODO: add description for maximum
   */
  maximum: string;
}
