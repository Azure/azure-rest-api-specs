import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.PlanetaryComputer;

// =============================================================================
// External Type Mappings for SDK Generation
// =============================================================================
// This file maps TypeSpec types to well-known external libraries for Python
// to provide a better developer experience with native geospatial types.
//
// Libraries used:
// - Python: shapely (geometry), geojson (features), pystac (STAC)
// =============================================================================

// ############################################################################
//                              PYTHON
// ############################################################################

// === Python SDK external type mappings ===

// ============================================================================
// GeoJSON Geometry Types - Use shapely library
// ============================================================================

// Base GeoJson union (covers all geometry types)
@@alternateType(GeoJson,
  {
    identity: "shapely.geometry.base.BaseGeometry",
    package: "shapely",
    minVersion: "2.0.6",
  },
  "python"
);

@@alternateType(Point,
  {
    identity: "shapely.Point",
    package: "shapely",
    minVersion: "2.0.6",
  },
  "python"
);

@@alternateType(Polygon,
  {
    identity: "shapely.Polygon",
    package: "shapely",
    minVersion: "2.0.6",
  },
  "python"
);

@@alternateType(MultiPolygon,
  {
    identity: "shapely.MultiPolygon",
    package: "shapely",
    minVersion: "2.0.6",
  },
  "python"
);

@@alternateType(LineString,
  {
    identity: "shapely.LineString",
    package: "shapely",
    minVersion: "2.0.6",
  },
  "python"
);

@@alternateType(MultiLineString,
  {
    identity: "shapely.MultiLineString",
    package: "shapely",
    minVersion: "2.0.6",
  },
  "python"
);

@@alternateType(MultiPoint,
  {
    identity: "shapely.MultiPoint",
    package: "shapely",
    minVersion: "2.0.6",
  },
  "python"
);

@@alternateType(GeometryCollection,
  {
    identity: "shapely.GeometryCollection",
    package: "shapely",
    minVersion: "2.0.6",
  },
  "python"
);

// ============================================================================
// GeoJSON Feature Types - Use geojson library
// ============================================================================

@@alternateType(Feature,
  {
    identity: "geojson.Feature",
    package: "geojson",
    minVersion: "2.0.0",
  },
  "python"
);

@@alternateType(FeatureBase,
  {
    identity: "geojson.Feature",
    package: "geojson",
    minVersion: "2.0.0",
  },
  "python"
);

@@alternateType(FeatureCollection,
  {
    identity: "geojson.FeatureCollection",
    package: "geojson",
    minVersion: "2.0.0",
  },
  "python"
);

// ============================================================================
// STAC Types - Use pystac library
// ============================================================================

@@alternateType(StacCollection,
  {
    identity: "pystac.Collection",
    package: "pystac",
    minVersion: "1.11.0",
  },
  "python"
);

@@alternateType(StacItem,
  {
    identity: "pystac.Item",
    package: "pystac",
    minVersion: "1.11.0",
  },
  "python"
);

// ItemCollection (STAC ItemCollection as GeoJSON FeatureCollection)
@@alternateType(ItemCollection,
  {
    identity: "pystac.ItemCollection",
    package: "pystac",
    minVersion: "1.11.0",
  },
  "python"
);

// ============================================================================
// CQL2 Filter Types - Use cql2 library (cql2-rs Python bindings)
// https://github.com/developmentseed/cql2-rs
// ============================================================================

@@alternateType(CqlFilter,
  {
    identity: "cql2.Expr",
    package: "cql2",
    minVersion: "0.4.2",
  },
  "python"
);
