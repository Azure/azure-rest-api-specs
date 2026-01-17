namespace MapsSearch;

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
 * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
 * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
 * GeometryCollection, Feature and FeatureCollection.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API contract"
enum GeoJsonGeometryObjectType {
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
