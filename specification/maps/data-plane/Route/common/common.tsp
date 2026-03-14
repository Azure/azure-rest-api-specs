import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

/**
 * The status state of the request.
 */
union LroStatus {
  string,

  /**
   * The request has not started processing yet.
   */
  NotStarted: "NotStarted",

  /**
   * The request has started processing.
   */
  Running: "Running",

  /**
   * The request has one or more failures.
   */
  Failed: "Failed",

  /**
   * The request has successfully completed.
   */
  Succeeded: "Succeeded",
}

union ResponseFormat {
  string,

  /**
   * [The JavaScript Object Notation Data Interchange
   * Format](https://tools.ietf.org/html/rfc8259)
   */
  json: "json",

  /**
   * [The Extensible Markup Language](https://www.w3.org/TR/xml/)
   */
  xml: "xml",
}

union GeographicResourceLocation {
  string,

  /**
   * Used to access an Azure Maps Creator resource in the United States
   */
  us: "us",

  /**
   * Used to access an Azure Maps Creator resource in Europe
   */
  eu: "eu",
}

union LocalizedMapView {
  string,

  /**
   * United Arab Emirates (Arabic View)
   */
  AE: "AE",

  /**
   * Argentina (Argentinian View)
   */
  AR: "AR",

  /**
   * Bahrain (Arabic View)
   */
  BH: "BH",

  /**
   * India (Indian View)
   */
  IN: "IN",

  /**
   * Iraq (Arabic View)
   */
  IQ: "IQ",

  /**
   * Jordan (Arabic View)
   */
  JO: "JO",

  /**
   * Kuwait (Arabic View)
   */
  KW: "KW",

  /**
   * Lebanon (Arabic View)
   */
  LB: "LB",

  /**
   * Morocco (Moroccan View)
   */
  MA: "MA",

  /**
   * Oman (Arabic View)
   */
  OM: "OM",

  /**
   * Pakistan (Pakistani View)
   */
  PK: "PK",

  /**
   * Palestinian Authority (Arabic View)
   */
  PS: "PS",

  /**
   * Qatar (Arabic View)
   */
  QA: "QA",

  /**
   * Saudi Arabia (Arabic View)
   */
  SA: "SA",

  /**
   * Syria (Arabic View)
   */
  SY: "SY",

  /**
   * Yemen (Arabic View)
   */
  YE: "YE",

  /**
   * Return the map data based on the IP address of the request.
   */
  Auto: "Auto",

  /**
   * Unified View (Others)
   */
  Unified: "Unified",
}

union IncludeText {
  string,

  /**
   * Include all textual data in response.
   */
  yes: "yes",

  /**
   * Exclude textual data from response. Only images and country names will be in
   * response.
   */
  no: "no",
}

/**
 * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
 * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
 * GeometryCollection, Feature and FeatureCollection.
 */
enum GeoJsonObjectType {
  /**
   * `GeoJSON Point` geometry.
   */
  GeoJsonPoint: "Point",

  /**
   * `GeoJSON MultiPoint` geometry.
   */
  GeoJsonMultiPoint: "MultiPoint",

  /**
   * `GeoJSON LineString` geometry.
   */
  GeoJsonLineString: "LineString",

  /**
   * `GeoJSON MultiLineString` geometry.
   */
  GeoJsonMultiLineString: "MultiLineString",

  /**
   * `GeoJSON Polygon` geometry.
   */
  GeoJsonPolygon: "Polygon",

  /**
   * `GeoJSON MultiPolygon` geometry.
   */
  GeoJsonMultiPolygon: "MultiPolygon",

  /**
   * `GeoJSON GeometryCollection` geometry.
   */
  GeoJsonGeometryCollection: "GeometryCollection",

  /**
   * `GeoJSON Feature` object.
   */
  GeoJsonFeature: "Feature",

  /**
   * `GeoJSON FeatureCollection` object.
   */
  GeoJsonFeatureCollection: "FeatureCollection",
}

/**
 * The response model for a Long-Running Operations API.
 */
model LongRunningOperationResult {
  /**
   * The Id for this long-running operation.
   */
  operationId?: string;

  /**
   * The status state of the request.
   */
  @visibility(Lifecycle.Read)
  status?: LroStatus;

  /**
   * The created timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The error detail.
   */
  error?: CommonErrorDetail;

  /**
   * The error detail.
   */
  warning?: CommonErrorDetail;
}

/**
 * The error detail.
 */
model CommonErrorDetail {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: CommonErrorDetail[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * This type represents the request body for the Batch service.
 */
model BatchRequest {
  /**
   * The list of queries to process.
   */
  batchItems?: BatchRequestItem[];
}

/**
 * Batch request object
 */
model BatchRequestItem {
  /**
   * This parameter contains a query string used to perform an unstructured
   * geocoding operation. The query string will be passed verbatim to the search API
   * for processing.
   */
  query?: string;
}

/**
 * This object is returned from a successful Batch service call. Extend with
 * 'batchItems' property.
 */
model BatchResult {
  /**
   * Summary of the results for the batch request
   */
  @visibility(Lifecycle.Read)
  summary?: BatchResultSummary;
}

/**
 * Summary of the results for the batch request
 */
model BatchResultSummary {
  /**
   * Number of successful requests in the batch
   */
  @visibility(Lifecycle.Read)
  successfulRequests?: int32;

  /**
   * Total number of requests in the batch
   */
  @visibility(Lifecycle.Read)
  totalRequests?: int32;
}

/**
 * An item returned from Batch API. Extend with 'response' property.
 */
model BatchResultItem {
  /**
   * HTTP request status code.
   */
  @visibility(Lifecycle.Read)
  statusCode?: int32;
}

/**
 * A location represented as a latitude and longitude.
 */
model LatLongPair {
  /**
   * Latitude property
   */
  latitude?: float64;

  /**
   * Longitude property
   */
  longitude?: float64;
}

/**
 * A location represented as a latitude and longitude using short names 'lat' &
 * 'lon'.
 */
model LatLongPairAbbreviated {
  /**
   * Latitude property
   */
  lat?: float64;

  /**
   * Longitude property
   */
  lon?: float64;
}

/**
 * A valid `GeoJSON` object. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3) for details.
 */
@discriminator("type")
model GeoJsonObject {
  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  objectType: GeoJsonObjectType;

  /**
   * Bounding box. Projection used - EPSG:3857. Please refer to [RFC
   * 7946](https://datatracker.ietf.org/doc/html/rfc7946#section-5) for details.
   */
  bbox?: float64[];
}

/**
 * A valid `GeoJSON` geometry object. The type must be one of the seven valid
 * GeoJSON geometry types - Point, MultiPoint, LineString, MultiLineString,
 * Polygon, MultiPolygon and GeometryCollection. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1) for details.
 */
@discriminator("type")
model GeoJsonGeometry extends GeoJsonObject {}

/**
 * A valid `GeoJSON Point` geometry type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
 */
model GeoJsonPoint extends GeoJsonGeometry {
  ...GeoJsonPointData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: "Point";
}

/**
 * Data contained by a `GeoJson Point`.
 */
model GeoJsonPointData {
  /**
   * A `Position` is an array of numbers with two or more elements. The first two
   * elements are _longitude_ and _latitude_, precisely in that order.
   * _Altitude/Elevation_ is an optional third element. Please refer to [RFC
   * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.1) for details.
   */
  coordinates: float64[];
}

/**
 * A valid `GeoJSON MultiPoint` geometry type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.3) for details.
 */
model GeoJsonMultiPoint extends GeoJsonGeometry {
  ...GeoJsonMultiPointData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: "MultiPoint";
}

/**
 * Data contained by a `GeoJson MultiPoint`.
 */
model GeoJsonMultiPointData {
  /**
   * Coordinates for the `GeoJson MultiPoint` geometry.
   */
  coordinates: float64[][];
}

/**
 * A valid `GeoJSON LineString` geometry type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.4) for details.
 */
model GeoJsonLineString extends GeoJsonGeometry {
  ...GeoJsonLineStringData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: "LineString";
}

model GeoJsonLineStringData {
  /**
   * Coordinates for the `GeoJson LineString` geometry.
   */
  coordinates: float64[][];
}

/**
 * A valid `GeoJSON MultiLineString` geometry type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.5) for details.
 */
model GeoJsonMultiLineString extends GeoJsonGeometry {
  ...GeoJsonMultiLineStringData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: "MultiLineString";
}

model GeoJsonMultiLineStringData {
  /**
   * Coordinates for the `GeoJson MultiLineString` geometry.
   */
  coordinates: float64[][][];
}

/**
 * A valid `GeoJSON Polygon` geometry type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.6) for details.
 */
model GeoJsonPolygon extends GeoJsonGeometry {
  ...GeoJsonPolygonData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: "Polygon";
}

model GeoJsonPolygonData {
  /**
   * Coordinates for the `GeoJson Polygon` geometry type.
   */
  coordinates: float64[][][];
}

/**
 * A valid `GeoJSON MultiPolygon` object type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.7) for details.
 */
model GeoJsonMultiPolygon extends GeoJsonGeometry {
  ...GeoJsonMultiPolygonData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: "MultiPolygon";
}

model GeoJsonMultiPolygonData {
  /**
   * Contains a list of valid `GeoJSON Polygon` objects. **Note** that coordinates
   * in GeoJSON are in x, y order (longitude, latitude).
   */
  coordinates: float64[][][][];
}

/**
 * A valid `GeoJSON GeometryCollection` object type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.8) for details.
 */
model GeoJsonGeometryCollection extends GeoJsonGeometry {
  ...GeoJsonGeometryCollectionData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: "GeometryCollection";
}

model GeoJsonGeometryCollectionData {
  /**
   * Contains a list of valid `GeoJSON` geometry objects. **Note** that coordinates
   * in GeoJSON are in x, y order (longitude, latitude).
   */
  geometries: GeoJsonGeometry[];
}

/**
 * A valid `GeoJSON Feature` object type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.2) for details.
 */
model GeoJsonFeature extends GeoJsonObject {
  ...GeoJsonFeatureData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: "Feature";
}

model GeoJsonFeatureData {
  /**
   * A valid `GeoJSON` geometry object. The type must be one of the seven valid
   * GeoJSON geometry types - Point, MultiPoint, LineString, MultiLineString,
   * Polygon, MultiPolygon and GeometryCollection. Please refer to [RFC
   * 7946](https://tools.ietf.org/html/rfc7946#section-3.1) for details.
   */
  geometry: GeoJsonGeometry;

  /**
   * Properties can contain any additional metadata about the `Feature`. Value can
   * be any JSON object or a JSON null value
   */
  properties?: unknown;

  /**
   * Identifier for the feature.
   */
  id?: string;

  /**
   * The type of the feature. The value depends on the data model the current
   * feature is part of. Some data models may have an empty value.
   */
  featureType?: string;
}

/**
 * A valid `GeoJSON FeatureCollection` object type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.3) for details.
 */
model GeoJsonFeatureCollection extends GeoJsonObject {
  ...GeoJsonFeatureCollectionData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: "FeatureCollection";
}

model GeoJsonFeatureCollectionData {
  /**
   * Contains a list of valid `GeoJSON Feature` objects.
   */
  features: GeoJsonFeature[];
}

/**
 * Common error response for all Azure Resource Manager APIs to return error
 * details for failed operations. (This also follows the OData error response
 * format.).
 */
model ErrorResponse {
  /**
   * The error object.
   */
  error?: CommonErrorDetail;
}
