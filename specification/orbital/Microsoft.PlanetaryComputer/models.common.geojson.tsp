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
  bbox?: float64[];
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
   * Geometry object defining the feature's shape
   */
  geometry: Geometry;

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

  /**
   * GeoJSON type identifier for Feature
   */
  type: FeatureType;
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
@discriminator("type")
model Geometry {
  /**
   * The type of the geometry.
   */
  type: GeometryType;

  /**
   * Optional bounding box of the geometry.
   */
  bbox?: float64[];
}

union GeometryType {
  string,

  /**
   * Represents a Point geometry.
   */
  Point: "Point",

  /**
   * Represents a LineString geometry.
   */
  LineString: "LineString",

  /**
   * Represents a Polygon geometry.
   */
  Polygon: "Polygon",

  /**
   * Represents a MultiPoint geometry.
   */
  MultiPoint: "MultiPoint",

  /**
   * Represents a MultiLineString geometry.
   */
  MultiLineString: "MultiLineString",

  /**
   * Represents a MultiPolygon geometry.
   */
  MultiPolygon: "MultiPolygon",
}

/**
 * Represents a GeoJSON Point geometry.
 */
model Point extends Geometry {
  /**
   * The geometry type, always "Point" for Point geometries.
   */
  type: GeometryType.Point;

  /**
   * The coordinates of the point as [longitude, latitude].
   */
  coordinates: string;

  /**
   * Optional bounding box of the geometry.
   */
  bbox?: float64[];
}

/**
 * Represents a Polygon.
 */
model Polygon extends Geometry {
  /**
   * The coordinates of the polygon.
   */
  coordinates: float64[][][];

  /**
   * The type of the polygon.
   */
  type: GeometryType.Polygon;

  /**
   * The bounding box of the polygon.
   */
  bbox?: float64[];
}

/**
 * Represents a MultiPolygon.
 */
model MultiPolygon extends Geometry {
  /**
   * The coordinates of the multipolygon.
   */
  coordinates: float64[][][];

  /**
   * The type of the multipolygon.
   */
  type: GeometryType.MultiPolygon;

  /**
   * The bounding box of the multipolygon.
   */
  bbox?: float64[];
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
  geometries: Geometry[];

  /**
   * The bounding box of the geometry collection.
   */
  bbox?: float64[];
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
model MultiLineString extends Geometry {
  /**
   * The type of the multilinestring.
   */
  type: GeometryType.MultiLineString;

  /**
   * The coordinates of the multilinestring.
   */
  coordinates: float64[][];

  /**
   * The bounding box of the multilinestring.
   */
  bbox?: float64[];
}

/**
 * Represents a LineString.
 */
model LineString extends Geometry {
  /**
   * The type of the linestring.
   */
  type: GeometryType.LineString;

  /**
   * The coordinates of the linestring.
   */
  coordinates: float64[];

  /**
   * The bounding box of the linestring.
   */
  bbox?: float64[];
}

/**
 * Represents a MultiPoint.
 */
model MultiPoint extends Geometry {
  /**
   * The type of the multipoint.
   */
  type: GeometryType.MultiPoint;

  /**
   * The coordinates of the multipoint.
   */
  coordinates: float64[];

  /**
   * The bounding box of the multipoint.
   */
  bbox?: float64[];
}
