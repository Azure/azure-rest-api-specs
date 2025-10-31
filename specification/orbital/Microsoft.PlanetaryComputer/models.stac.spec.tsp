import "@typespec/rest";
import "@typespec/http";
import "./models.common.geojson.tsp";
import "./models.common.cql.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

/**
 * Defines the sorting directions for query results in STAC API.
 */
union SortDirections {
  string,

  /**
   * Sort results in ascending order.
   */
  asc: "asc",

  /**
   * Sort results in descending order.
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
 *
 * Defines the supported filter languages for STAC API queries.
 */
union FilterLang {
  string,

  /**
   * Common Query Language in JSON format.
   */
  `cql-json`: "cql-json",

  /**
   * Common Query Language 2 in JSON format
   */
  `cql2-json`: "cql2-json",

  /**
   * Common Query Language 2 in text format.
   */
  `cql2-text`: "cql2-text",
}

/**
 * Queryable data types for the queryables extension.
 * These are the data types supported by Basic CQL2.
 */
union QueryableDefinitionDataType {
  /**
   * Character strings.
   * Example: 'This is a literal string.'
   */
  string: "string",

  /**
   * Numbers including integers and floating point values.
   * Examples: -100, 3.14159
   */
  number: "number",

  /**
   * Booleans.
   * Examples: true, false
   */
  boolean: "boolean",

  /**
   * An instant with a granularity of a second or smaller.
   * Example (JSON): { "timestamp": "1969-07-20T20:17:40Z" }
   */
  timestamp: "timestamp",

  /**
   * An instant with a granularity of a day.
   * Example (JSON): { "date": "1969-07-20" }
   */
  date: "date",

  /**
   * Base scalar
   */
  string,
}

/**
 * Represents the GeoJSON feature collection type for STAC item collections.
 */
union ItemCollectionType {
  string,

  /**
   * Standard GeoJSON FeatureCollection type.
   */
  FeatureCollection: "FeatureCollection",
}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/blob/master/api-spec.md#ogc-api---features-endpoints
 *
 * Represents the STAC API landing page with links to available resources.
 */
model LandingPage {
  ...MicrosoftStacProperties;
  ...StacExtensionsList;

  /**
   * Unique identifier for the STAC catalog.
   */
  @minLength(1)
  id: string;

  /**
   * Detailed description of the STAC catalog.
   */
  @minLength(1)
  description: string;

  /**
   * Human-readable title for the STAC catalog.
   */
  title?: string;

  /**
   * Stac Version
   */
  @encodedName("application/json", "stac_version")
  stacVersion?: string = "1.0.0";

  /**
   * List of OGC API conformance classes implemented by this API.
   */
  conformsTo: url[];

  /**
   * Links to related resources and endpoints.
   */
  links: Link[];

  /**
   * Type
   */
  @minLength(1)
  type?: string = "Catalog";
}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/blob/master/api-spec.md#ogc-api---features-endpoints
 *
 * Represents the OGC API conformance declaration.
 */
model ConformanceClasses {
  /**
   * List of OGC API conformance classes implemented by this API.
   */
  conformsTo: url[];
}

/**
 * Search model.
 *
 * Overrides the validation for datetime from the base request model.
 *
 * Defines parameters for a STAC search POST request.
 */
model SearchPostRequest {
  /**
   * List of collection IDs to search within.
   */
  collections?: string[];

  /**
   * List of specific item IDs to return.
   */
  ids?: string[];

  /**
   * Bounding box for spatial filtering in format [west, south, east, north].
   */
  bbox?: float64[];

  /**
   * GeoJSON geometry for spatial filtering.
   */
  intersects?: GeoJson;

  /**
   * Temporal filter in RFC 3339 format, can be a single time or range.
   */
  datetime?: string;

  /**
   * Maximum number of results to return.
   */
  @maxValue(1000)
  @minValue(1)
  limit?: int32 = 250;

  /**
   * Conf
   */
  conf?: Record<string>;

  /**
   * Whether to sign asset URLs in the response.
   */
  sign?: SignType;

  /**
   * URL signature duration in seconds.
   */
  duration?: int32;

  /**
   * https://github.com/stac-api-extensions/query
   *
   * Query
   */
  query?: Record<StringRecord>;

  /**
   * https://github.com/stac-api-extensions/sort
   *
   * Sort criteria for the search results.
   */
  sortby?: SortExtension[];

  /**
   * https://github.com/stac-api-extensions/fields
   *
   * Specifies which fields to include or exclude in the response.
   */
  fields?: SearchPostRequestFields[];

  /**
   * https://github.com/stac-api-extensions/filter
   *
   * Filter
   */
  filter?: Record<string>;

  /**
   * Coordinate reference system for the filter.
   */
  @encodedName("application/json", "filter-crs")
  filterCrs?: string;

  /**
   * Filter language to use for the filter expression.
   */
  @encodedName("application/json", "filter-lang")
  filterLang?: FilterLang = FilterLang.`cql-json`;

  /**
   * Pagination token for fetching the next set of results.
   */
  token?: string;
}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/tree/master/extensions/sort#sort-api-extension
 *
 * Represents a sort specification for STAC API queries.
 */
model SortExtension {
  /**
   * The field name to sort by.
   */
  @minLength(1)
  field: string;

  /**
   * The sort direction (ascending or descending).
   */
  direction: SortDirections;
}

/**
 * FieldsExtension.
 *
 * Attributes:
 *     include: set of fields to include.
 *     exclude: set of fields to exclude.
 *
 * Controls which fields to include or exclude from the response.
 */
model SearchPostRequestFields {
  /**
   * Array of field names to include in the response.
   */
  include?: string[] = #[];

  /**
   * Array of field names to exclude from the response.
   */
  exclude?: string[] = #[];
}

/**
 *
 * http://docs.opengeospatial.org/is/17-069r3/17-069r3.html#_feature_collections_rootcollections
 *
 * Represents a collection of STAC collections with links.
 */
model FeatureCollections {
  /**
   * Links to related resources and endpoints.
   */
  links: Link[];

  /**
   * Array of STAC collections available in the catalog.
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  collections: StacCollection[];
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md
 *
 * Represents a STAC collection.
 */
@resource("collections")
model StacCollection {
  ...MicrosoftStacProperties;
  ...StacExtensionsList;

  /**
   * Unique identifier for the collection.
   */
  @minLength(1)
  @key("collectionId")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @maxLength(500)
  @pattern(".*")
  id: string;

  /**
   * Detailed description of the collection.
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
   * Links to related resources and endpoints.
   */
  links: Link[];

  /**
   * Human-readable title for the collection.
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
   * License identifier for the collection data.
   */
  @minLength(1)
  license: string;

  /**
   * Spatial and temporal extent of the collection.
   */
  extent: Extent;

  /**
   * Keywords describing the collection.
   */
  keywords?: string[];

  /**
   * Organizations or individuals who provide the collection data.
   */
  providers?: Provider[];

  /**
   * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#summaries
   *
   * Summaries
   */
  summaries?: Record<string>;
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/item-spec/item-spec.md#asset-object
 *
 * Represents a STAC asset, which is a file or resource associated with a STAC item.
 */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" ""
model Asset {
  ...Record<unknown>;
  ...CommonMetadata;

  /**
   * Human-readable title for the asset.
   */
  title?: string;

  /**
   * Detailed description of the asset.
   */
  description?: string;

  /**
   * URL to the asset file.
   */
  @minLength(1)
  href: string;

  /**
   * Media type of the asset.
   */
  type?: string;

  /**
   * Roles of the asset within the item.
   */
  roles?: string[];
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#provider-object
 *
 * Represents information about a data provider for STAC collections and items.
 */
model Provider {
  /**
   * Name of the provider organization or individual.
   */
  @minLength(1)
  name: string;

  /**
   * Description of the provider.
   */
  description?: string;

  /**
   * Roles played by the provider (e.g., producer, processor, host).
   */
  roles?: string[];

  /**
   * URL to the provider's website.
   */
  url?: string;
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#extent-object
 *
 * Represents the spatial and temporal extent of a STAC collection.
 */
model Extent {
  /**
   *
   * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#spatial-extent-object
   *
   * Spatial extent defined by bounding boxes.
   */
  spatial: SpatialExtent;

  /**
   *
   * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#temporal-extent-object
   *
   * Temporal extent defined by time intervals.
   */
  temporal: TimeInterval;
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#spatial-extent-object
 *
 * Represents the spatial extent of a STAC collection with bounding boxes.
 */
model SpatialExtent {
  /**
   * Array of bounding boxes defining the spatial extent, in format [[west, south, east, north]].
   */
  bbox?: float64[][];
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/collection-spec/collection-spec.md#temporal-extent-object
 *
 * Represents the temporal extent of a STAC collection with time intervals.
 */
model TimeInterval {
  /**
   * Array of time intervals in format [[start_datetime, end_datetime]].
   */
  interval: string[][];
}

/**
 * QueryableDefinitionType
 */
model QueryableDefinitionType {
  /**
   * Whether to create a database index for this property.
   */
  @encodedName("application/json", "create_index")
  createIndex?: boolean;

  /**
   * Data type of the queryable property.
   */
  @encodedName("application/json", "data_type")
  dataType?: QueryableDefinitionDataType = QueryableDefinitionDataType.string;

  /**
   * Description
   */
  description?: string;
}

/**
 * Definition of a queryable field for STAC API filtering.
 */
model QueryableDefinition {
  /**
   * Name of the queryable field.
   */
  @minLength(1)
  name: string;

  /**
   * Metadata for the queryable field.
   */
  definition: QueryableDefinitionType;

  /**
   * Whether to create a database index for this field.
   */
  @encodedName("application/json", "create_index")
  createIndex?: boolean;

  /**
   * Data type of the queryable field.
   */
  @encodedName("application/json", "data_type")
  dataType?: QueryableDefinitionDataType = QueryableDefinitionDataType.string;
}

/**
 *
 * https://github.com/radiantearth/stac-api-spec/tree/master/extensions/context#context-extension-specification
 *
 * Context information for a search response including pagination details.
 */
model ContextExtension {
  /**
   * Number of items returned in the response.
   */
  returned: int32;

  /**
   * Maximum number of items requested.
   */
  limit?: int32;

  /**
   * Total number of items matching the query.
   */
  matched?: int32;
}

/**
 * Represents a STAC Item, which is a GeoJSON Feature with additional metadata.
 */
@resource("items")
@parentResource(StacCollection)
model StacItem {
  ...FeatureBase;
  ...MicrosoftStacProperties;
  ...StacExtensionsList;

  /**
   * Unique identifier for the feature
   */
  @key("itemId")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  id: string;

  /**
   * Stac Version
   */
  @minLength(1)
  @encodedName("application/json", "stac_version")
  stacVersion?: string = "1.0.0";

  /**
   * ID of the STAC collection this item belongs to.
   */
  collection?: string;

  /**
   * Attributes associated with the feature
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" ""
  properties: ItemProperties;

  /**
   * Links to related resources and endpoints.
   */
  links: Link[];

  /**
   * Assets
   */
  assets: Record<Asset>;

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
}

/**
 * Properties of a STAC Item containing metadata about the asset.
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/item-spec/item-spec.md#properties-object
 */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" ""
model ItemProperties {
  ...Record<unknown>;
  ...CommonMetadata;

  /**
   * Human-readable title for the item.
   */
  title?: string;

  /**
   * Detailed description of the item.
   */
  description?: string;

  /**
   * Datetime the asset represents in RFC 3339 format.
   */
  datetime: string;

  /**
   * Start time of the item observation period.
   */
  @encodedName("application/json", "start_datetime")
  startDatetime?: utcDateTime;

  /**
   * End time of the item observation period.
   */
  @encodedName("application/json", "end_datetime")
  endDatetime?: utcDateTime;
}

/**
 *
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0/item-spec/itemcollection-spec.md
 *
 * Represents a collection of STAC Items as a GeoJSON FeatureCollection.
 */
model ItemCollection {
  ...MicrosoftStacProperties;
  ...StacExtensionsList;

  /**
   * GeoJSON FeatureCollection type.
   */
  type: ItemCollectionType;

  /**
   * Array of STAC Items in the collection.
   */
  features: StacItem[];

  /**
   * Bounding box of all items in format [west, south, east, north].
   */
  bbox?: float64[];

  /**
   * Stac Version
   */
  @minLength(1)
  @encodedName("application/json", "stac_version")
  stacVersion?: string = "1.0.0";

  /**
   * Links to related resources and endpoints.
   */
  links?: Link[];

  /**
   * Context information for the search response.
   */
  context?: ContextExtension;
}

/**
 * Microsoft STAC Properties
 */
model MicrosoftStacProperties {
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
}

/**
 * Common Metadata
 */
model CommonMetadata {
  /**
   * Platform that acquired the data.
   */
  platform?: string;

  /**
   * Instruments that acquired the data.
   */
  instruments?: string[];

  /**
   * Constellation of satellites that acquired the data.
   */
  constellation?: string;

  /**
   * Mission associated with the data.
   */
  mission?: string;

  /**
   * Organizations or individuals who provide the data.
   */
  providers?: Provider[];

  /**
   * Ground sample distance in meters.
   */
  gsd?: float32;

  /**
   * Creation timestamp of the data.
   */
  created?: utcDateTime;

  /**
   * Last update timestamp of the data.
   */
  updated?: utcDateTime;
}

/**
 * Stac Extensions
 */
model StacExtensionsList {
  /**
   * URLs to STAC extensions implemented by this STAC resource.
   */
  @encodedName("application/json", "stac_extensions")
  stacExtensions?: string[];
}

/**
 * Link model.
 *
 * Ref:
 * http://schemas.opengis.net/ogcapi/features/part1/1.0/openapi/schemas/link.yaml
 *
 * Represents a link.
 */
model Link {
  /**
   * The relationship type of the link.
   */
  rel?: string;

  /**
   * The title of the link.
   */
  title?: string;

  /**
   * The MIME type of the linked resource.
   */
  type?: LinkType = LinkType.`application/json`;

  /**
   * The URL of the link.
   */
  href: string;

  /**
   * The language of the linked resource.
   */
  hreflang?: string;

  /**
   * The length of the linked resource.
   */
  length?: int32;

  /**
   * Specifies the HTTP method that the resource expects.
   * Default: GET.
   */
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backcompatibility with existing clients"
  method?: "GET" | "POST" | string = "GET";

  /**
   * Object key-value pairs that map to headers.
   * Example: { "Accept": "application/json" }.
   */
  headers?: Record<string>;

  /**
   * For POST requests, the resource can specify the HTTP body as a JSON object.
   */
  body?: Record<string>;

  /**
   * Indicates whether the client is expected to merge the body value into the current request body before following the link.
   * This is only valid when the server is responding to a POST request.
   * Default: false.
   */
  merge?: boolean = false;
}

/**
 * Represents a string record.
 */
@doc("String record.")
model StringRecord is Record<string>;

/**
 * MIME types for links.
 */
union LinkType {
  string,

  /**
   * Represents an image/tiff with application=geotiff.
   */
  `image/tiff; application=geotiff`: "image/tiff; application=geotiff",

  /**
   * Represents an image/jp2.
   */
  `image/jp2`: "image/jp2",

  /**
   * Represents an image/png.
   */
  `image/png`: "image/png",

  /**
   * Represents an image/jpeg.
   */
  `image/jpeg`: "image/jpeg",

  /**
   * Represents an image/jpg.
   */
  `image/jpg`: "image/jpg",

  /**
   * Represents an image/webp.
   */
  `image/webp`: "image/webp",

  /**
   * Represents an application/x-binary.
   */
  `application/x-binary`: "application/x-binary",

  /**
   * Represents an application/xml.
   */
  `application/xml`: "application/xml",

  /**
   * Represents an application/json.
   */
  `application/json`: "application/json",

  /**
   * Represents an application/geo+json.
   */
  `application/geo+json`: "application/geo+json",

  /**
   * Represents a text/html.
   */
  `text/html`: "text/html",

  /**
   * Represents a text/plain.
   */
  `text/plain`: "text/plain",

  /**
   * Represents an application/x-protobuf.
   */
  `application/x-protobuf`: "application/x-protobuf",
}

/**
 * Represent the signature type for asset URLs.
 */
union SignType {
  string,

  /**
   * Sign asset URLs in the response.
   */
  True: "true",

  /**
   * Do not sign asset URLs in the response.
   */
  False: "false",
}
