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

/** Desired format of the response. Only `json` format is supported. */
union JsonFormat {
  string,

  /**
   * [The JavaScript Object Notation Data Interchange
   * Format](https://tools.ietf.org/html/rfc8259)
   */
  json: "json",
}

/**
 * The response format.
 */
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

/**
 * This parameter specifies where the Azure Maps Account is located. Valid values are us (East US, West Central US, West US 2) and eu (North Europe, West Europe).
 */
union MapsAccountGeographicResourceLocation {
  string,

  /**
   * Used to access an Azure Maps resource in the United States (East US, West Central US, West US 2)
   */
  us: "us",

  /**
   * Used to access an Azure Maps resource in Europe (North Europe, West Europe)
   */
  eu: "eu",
}

/**
 * The geographic location of the resource.
 */
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

/**
 * The localized map view to return the route geometry in.
 */
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
   * United States of America
   */
  US: "US",

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

/**
 * Yes/no value to exclude textual data from response.
 */
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
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API contract"
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
  info?: Record<string>;
}

/**
 * Common error response for Azure Maps APIs to return error details for failed operations.
 */
@error
model MapsErrorResponse {
  /**
   * The error detail.
   */
  @visibility(Lifecycle.Read)
  error: MapsErrorDetail;
}

/**
 * The error detail.
 */
model MapsErrorDetail {
  /**
   * One of a server-defined set of error codes.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A human-readable representation of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The target of the error.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * An array of details about specific errors that led to this reported error.
   */
  @visibility(Lifecycle.Read)
  details?: MapsErrorDetail[];

  /**
   * An object containing more specific information than the current object about the error.
   */
  @visibility(Lifecycle.Read)
  innererror?: MapsInnerError;
}

/**
 * An object containing more specific information than the current object about the error.
 */
model MapsInnerError {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * An object containing more specific information than the current object about the error.
   */
  @visibility(Lifecycle.Read)
  innererror?: MapsInnerError;
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
 * A valid `GeoJSON` geometry object. The type must be one of the seven valid
 * GeoJSON geometry types - Point, MultiPoint, LineString, MultiLineString,
 * Polygon, MultiPolygon and GeometryCollection. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1) for details.
 */
model GeoJsonGeometry is GeoJsonObject;

/**
 * A valid `GeoJSON` object. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3) for details.
 */
// FIXME The warning for type looks like a bug
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing API contract"
@discriminator("type")
model GeoJsonObject {
  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: GeoJsonObjectType;
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
// FIXME: the discriminator is deeply nested, probably incorrectly reported warning
model GeoJsonMultiPoint extends GeoJsonGeometry {
  ...GeoJsonMultiPointData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: GeoJsonObjectType.GeoJsonMultiPoint;
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

/** GeoJson MultiLineString data */
model GeoJsonMultiLineStringData {
  /**
   * Coordinates for the `GeoJson MultiLineString` geometry.
   */
  coordinates: float64[][][];
}

/** GeoJson Polygon data */
model GeoJsonPolygonData {
  /**
   * Coordinates for the `GeoJson Polygon` geometry type.
   */
  coordinates: float64[][][];
}

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
  type: GeoJsonObjectType.GeoJsonPoint;
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
  type: GeoJsonObjectType.GeoJsonLineString;
}

/** GeoJson LineString data */
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
  type: GeoJsonObjectType.GeoJsonMultiLineString;
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
  type: GeoJsonObjectType.GeoJsonPolygon;
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
  type: GeoJsonObjectType.GeoJsonMultiPolygon;
}

/** GeoJson MultiPolygon data */
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
  type: GeoJsonObjectType.GeoJsonGeometryCollection;
}

/**
 * GeoJson GeometryCollection data.
 */
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
  type: GeoJsonObjectType.GeoJsonFeature;
}

/**
 * GeoJson Feature data.
 */
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
  // FIXME: should this be specified as optional?
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract"
  properties?: Record<unknown> | null;

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
  type: GeoJsonObjectType.GeoJsonFeatureCollection;
}

/**
 * GeoJson FeatureCollection data.
 */
model GeoJsonFeatureCollectionData {
  /**
   * Contains a list of valid `GeoJSON Feature` objects.
   */
  features: GeoJsonFeature[];
}
