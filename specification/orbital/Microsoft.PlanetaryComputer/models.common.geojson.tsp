/**
 * GeoJSON FeatureCollection containing multiple Feature objects
 */
model FeatureCollection {
  /**
   * GeoJSON type identifier for FeatureCollection
   */
  type: FeatureCollectionType;

  /**
   * Array of GeoJSON Feature objects
   */
  features: Feature[];

  /**
   * Bounding box coordinates for the collection
   */
  bbox?: float64;
}

/**
 * Type identifier for GeoJSON FeatureCollection objects
 */
union FeatureCollectionType {
  string,

  /**
   * Standard GeoJSON FeatureCollection type identifier
   */
  FeatureCollection: "FeatureCollection",
}

/**
 * GeoJSON Feature object representing a geographic entity
 */
model FeatureBase {
  /**
   * GeoJSON type identifier for Feature
   */
  type: FeatureType;

  /**
   * Geometry object defining the feature's shape
   */
  geometry: GeoJson;

  /**
   * Bounding box coordinates for the feature
   */
  bbox: float64[];
}
/**
 * GeoJSON Feature object representing a geographic entity
 */
model Feature {
  ...FeatureBase;

  /**
   * Unique identifier for the feature
   */
  id: string;
}

/**
 * Type identifier for GeoJSON Feature objects
 */
union FeatureType {
  string,

  /**
   * Standard GeoJSON Feature type identifier
   */
  Feature: "Feature",
}

/**
 * GeoJSON Feature or FeatureCollection.
 *
 * Represents a GeoJSON geometry object as defined by RFC 7946.
 *
 * Supported geometry types include:
 * - **Point**: A single geographic coordinate.
 * - **LineString**: A sequence of geographic coordinates forming a line.
 * - **Polygon**: A closed shape defined by linear rings.
 * - **MultiPoint**: A collection of Points.
 * - **MultiLineString**: A collection of LineStrings.
 * - **MultiPolygon**: A collection of Polygons.
 *
 * Used for spatial filtering in STAC.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "Unions cannot be emitted to OpenAPI v2 unless all options are literals of the same type."
union GeoJson {
  Point,
  LineString,
  Polygon,
  MultiPoint,
  MultiLineString,
  MultiPolygon,
}

/**
 * Represents a GeoJSON Point geometry.
 */
model Point {
  /**
   * The geometry type, always "Point" for Point geometries.
   */
  type: PointType;

  /**
   * The coordinates of the point as [longitude, latitude].
   */
  coordinates: string;

  /**
   * Optional bounding box of the geometry.
   */
  bbox?: float64;
}

/**
 * Represents the GeoJSON Point geometry type.
 */
union PointType {
  string,

  /**
   * Standard GeoJSON Point geometry type.
   */
  Point: "Point",
}

/**
 * Represents a Polygon.
 */
model Polygon {
  /**
   * The coordinates of the polygon.
   */
  coordinates: float64[][][];

  /**
   * The type of the polygon.
   */
  type: PolygonType;

  /**
   * The bounding box of the polygon.
   */
  bbox?: float64;
}

/**
 * Represents a Polygon type.
 */
union PolygonType {
  string,

  /**
   * Represents a Polygon.
   */
  Polygon: "Polygon",
}

/**
 * Represents a MultiPolygon.
 */
model MultiPolygon {
  /**
   * The coordinates of the multipolygon.
   */
  coordinates: float64[][][];

  /**
   * The type of the multipolygon.
   */
  type: MultiPolygonType;

  /**
   * The bounding box of the multipolygon.
   */
  bbox?: float64;
}

/**
 * Represents a MultiPolygon type.
 */
union MultiPolygonType {
  string,

  /**
   * Represents a MultiPolygon.
   */
  MultiPolygon: "MultiPolygon",
}

/**
 * Represents a GeometryCollection.
 */
model GeometryCollection {
  /**
   * The type of the geometry collection.
   */
  type: GeometryCollectionType;

  /**
   * The geometries in the collection.
   */
  geometries: GeoJson[];

  /**
   * The bounding box of the geometry collection.
   */
  bbox?: float64;
}

/**
 * Represents a GeometryCollection type.
 */
union GeometryCollectionType {
  string,

  /**
   * Represents a GeometryCollection.
   */
  GeometryCollection: "GeometryCollection",
}

/**
 * Represents a MultiLineString.
 */
model MultiLineString {
  /**
   * The type of the multilinestring.
   */
  type: MultiLineStringType;

  /**
   * The coordinates of the multilinestring.
   */
  coordinates: float64[][];

  /**
   * The bounding box of the multilinestring.
   */
  bbox?: float64;
}

/**
 * Represents a LineString.
 */
model LineString {
  /**
   * The type of the linestring.
   */
  type: LineStringType;

  /**
   * The coordinates of the linestring.
   */
  coordinates: float64[];

  /**
   * The bounding box of the linestring.
   */
  bbox?: float64;
}

/**
 * Represents a LineString type.
 */
union LineStringType {
  string,

  /**
   * Represents a LineString.
   */
  LineString: "LineString",
}

/**
 * Represents a MultiLineString type.
 */
union MultiLineStringType {
  string,

  /**
   * Represents a MultiLineString.
   */
  MultiLineString: "MultiLineString",
}

/**
 * Represents a MultiPoint.
 */
model MultiPoint {
  /**
   * The type of the multipoint.
   */
  type: MultiPointType;

  /**
   * The coordinates of the multipoint.
   */
  coordinates: float64[];

  /**
   * The bounding box of the multipoint.
   */
  bbox?: float64;
}

/**
 * Represents a MultiPoint type.
 */
union MultiPointType {
  string,

  /**
   * Represents a MultiPoint.
   */
  MultiPoint: "MultiPoint",
}
