import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace MicrosoftPlanetaryComputerPro;

/**
 * Type
 */
/**
 * TODO: add description for MultiPointType
 */
union MultiPointType {
  string,

  /**
   * TODO: add description for MultiPoint
   */
  MultiPoint: "MultiPoint",
}

/**
 * Type
 */
/**
 * TODO: add description for LineStringType
 */
union LineStringType {
  string,

  /**
   * TODO: add description for LineString
   */
  LineString: "LineString",
}

/**
 * Type
 */
/**
 * TODO: add description for MultiLineStringType
 */
union MultiLineStringType {
  string,

  /**
   * TODO: add description for MultiLineString
   */
  MultiLineString: "MultiLineString",
}

/**
 * Type
 */
/**
 * TODO: add description for PolygonType
 */
union PolygonType {
  string,

  /**
   * TODO: add description for Polygon
   */
  Polygon: "Polygon",
}

/**
 * Type
 */
/**
 * TODO: add description for MultiPolygonType
 */
union MultiPolygonType {
  string,

  /**
   * TODO: add description for MultiPolygon
   */
  MultiPolygon: "MultiPolygon",
}

/**
 * Type
 */
/**
 * TODO: add description for GeometryCollectionType
 */
union GeometryCollectionType {
  string,

  /**
   * TODO: add description for GeometryCollection
   */
  GeometryCollection: "GeometryCollection",
}

/**
 * TODO: add description for LinkType
 */
union LinkType {
  string,

  /**
   * TODO: add description for image/tiff
   */
  `image/tiff; application=geotiff`: "image/tiff; application=geotiff",

  /**
   * TODO: add description for None
   */
  `image/jp2`: "image/jp2",

  /**
   * TODO: add description for None
   */
  `image/png`: "image/png",

  /**
   * TODO: add description for None
   */
  `image/jpeg`: "image/jpeg",

  /**
   * TODO: add description for None
   */
  `image/jpg`: "image/jpg",

  /**
   * TODO: add description for None
   */
  `image/webp`: "image/webp",

  /**
   * TODO: add description for None
   */
  `application/x-binary`: "application/x-binary",

  /**
   * TODO: add description for None
   */
  `application/xml`: "application/xml",

  /**
   * TODO: add description for None
   */
  `application/json`: "application/json",

  /**
   * TODO: add description for None
   */
  `application/geo+json`: "application/geo+json",

  /**
   * TODO: add description for None
   */
  `text/html`: "text/html",

  /**
   * TODO: add description for None
   */
  `text/plain`: "text/plain",

  /**
   * TODO: add description for None
   */
  `application/x-protobuf`: "application/x-protobuf",
}

/**
 * Polygon Model
 */
/**
 * TODO: add description for Polygon
 */
model Polygon {
  /**
   * Coordinates
   */
  /**
   * TODO: add description for coordinates
   */
  coordinates: string[][];

  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: PolygonType;

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * MultiPolygon Model
 */
/**
 * TODO: add description for MultiPolygon
 */
model MultiPolygon {
  /**
   * Coordinates
   */
  /**
   * TODO: add description for coordinates
   */
  coordinates: string[][][];

  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: MultiPolygonType;

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * GeometryCollection Model
 */
/**
 * TODO: add description for GeometryCollection
 */
model GeometryCollection {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: GeometryCollectionType;

  /**
   * Geometries
   */
  /**
   * TODO: add description for geometries
   */
  geometries: GeometryCollectionGeometriesItem[];

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * TODO: add description for GeometryCollectionGeometriesItem
 */
model GeometryCollectionGeometriesItem {}

/**
 * MultiLineString Model
 */
/**
 * TODO: add description for MultiLineString
 */
model MultiLineString {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: MultiLineStringType;

  /**
   * Coordinates
   */
  /**
   * TODO: add description for coordinates
   */
  coordinates: string[][];

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * LineString Model
 */
/**
 * TODO: add description for LineString
 */
model LineString {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: LineStringType;

  /**
   * Coordinates
   */
  /**
   * TODO: add description for coordinates
   */
  coordinates: string[];

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * MultiPoint Model
 */
/**
 * TODO: add description for MultiPoint
 */
model MultiPoint {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: MultiPointType;

  /**
   * Coordinates
   */
  /**
   * TODO: add description for coordinates
   */
  coordinates: string[];

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * Link model.
 *
 * Ref:
 * http://schemas.opengis.net/ogcapi/features/part1/1.0/openapi/schemas/link.yaml
 */
/**
 * TODO: add description for Link
 */
model Link {
  /**
   * Rel
   */
  /**
   * TODO: add description for rel
   */
  rel?: string;

  /**
   * Title
   */
  /**
   * TODO: add description for title
   */
  title?: string;

  /**
   * TODO: add description for type
   */
  type?: LinkType = LinkType.`application/json`;

  /**
   * Href
   */
  /**
   * TODO: add description for href
   */
  href: string;

  /**
   * Hreflang
   */
  /**
   * TODO: add description for hreflang
   */
  hreflang?: string;

  /**
   * Length
   */
  /**
   * TODO: add description for length
   */
  length?: int32;
}

/**
 * TODO: add description for Versions
 */
@doc("Versions info.")
enum Versions {
  /**
   * TODO: add description for v2024_01_31_Preview
   */
  @doc("The 2024-01-31-preview version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_01_31_Preview: "2024-01-31-preview",
}

/**
 * TODO: add description for StringRecord
 */
@doc("String record.")
model StringRecord is Record<string>;
