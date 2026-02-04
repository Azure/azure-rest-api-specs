// Vector Tiles models
import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./models.stac.spec.tsp";
import "./models.tiler.tile-matrix-sets.tsp";

using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

/**
 * Landing page for vector tiles.
 */
model VectorLandingPage {
  /**
   * Title of the API.
   */
  title?: string;

  /**
   * Description of the API.
   */
  description?: string;

  /**
   * Attribution information.
   */
  attribution?: string;

  /**
   * Links to related resources.
   */
  links: Link[];
}

/**
 * Conformance declaration.
 */
model Conformance {
  /**
   * List of conformance classes.
   */
  conformsTo: string[];
}

/**
 * Mapbox Style definition.
 */
model MapboxStyle {
  /**
   * Style identifier.
   */
  @pattern("^[A-Za-z0-9_-]+$")
  @maxLength(128)
  id: string;

  /**
   * Style version.
   */
  version: 8;

  /**
   * Style name.
   */
  @maxLength(256)
  name?: string;

  /**
   * Default camera center [longitude, latitude].
   */
  center?: float64[];

  /**
   * Default zoom level.
   */
  zoom?: float64;

  /**
   * Default bearing (rotation).
   */
  bearing?: float64;

  /**
   * Default pitch (tilt).
   */
  pitch?: float64;

  /**
   * Sprite URL.
   */
  sprite?: string;

  /**
   * Glyphs URL template.
   */
  glyphs?: string;

  /**
   * Sources specification.
   */
  sources?: Record<MapboxSource>;

  /**
   * Layers specification.
   */
  layers?: MapboxLayer[];
}

/**
 * Mapbox Source definition.
 */
model MapboxSource {
  /**
   * Source type.
   */
  type: string;

  /**
   * Source URL.
   */
  url?: string;

  /**
   * Tile size.
   */
  tileSize?: int32;

  /**
   * Data URL (for GeoJSON).
   */
  data?: string;
}

/**
 * Mapbox Layer definition.
 */
model MapboxLayer {
  /**
   * Layer identifier.
   */
  id: string;

  /**
   * Layer type.
   */
  type: string;

  /**
   * Source identifier.
   */
  source?: string;

  /**
   * Source layer identifier.
   */
  @encodedName("application/json", "source-layer")
  sourceLayer?: string;

  /**
   * Minimum zoom level.
   */
  minzoom?: float64;

  /**
   * Maximum zoom level.
   */
  maxzoom?: float64;
}

/**
 * List of Mapbox styles.
 */
model MapboxStylesList {
  /**
   * List of styles.
   */
  value: MapboxStyle[];
}

/**
 * List of available tilesets.
 */
model TileSetsList {
  /**
   * Links to related resources.
   */
  links?: Link[];

  /**
   * List of tilesets.
   */
  tilesets: TileSetItem[];
}

/**
 * Summary information about a tileset.
 */
model TileSetItem {
  /**
   * Title of the tileset.
   */
  title?: string;

  /**
   * Description of the tileset.
   */
  description?: string;

  /**
   * Data type of the tileset.
   */
  dataType: string;

  /**
   * Coordinate Reference System.
   */
  crs: Crs;

  /**
   * URI of the TileMatrixSet.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "The name is defined in OGC API - Tiles standard"
  tileMatrixSetURI?: url;

  /**
   * Links to related resources.
   */
  links: Link[];
}

/**
 * Detailed information about a tileset.
 */
model TileSet {
  /**
   * Title of the tileset.
   */
  title?: string;

  /**
   * Description of the tileset.
   */
  description?: string;

  /**
   * Keywords describing the tileset.
   */
  keywords?: string[];

  /**
   * Version of the tileset.
   */
  version?: string;

  /**
   * Creation timestamp.
   */
  created?: string;

  /**
   * Last update timestamp.
   */
  updated?: string;

  /**
   * Point of contact.
   */
  pointOfContact?: string;

  /**
   * Supported media types.
   */
  mediaTypes?: string[];

  /**
   * Data type of the tileset.
   */
  dataType: string;

  /**
   * Coordinate Reference System.
   */
  crs: Crs;

  /**
   * URI of the TileMatrixSet.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "The name is defined in OGC API - Tiles standard"
  tileMatrixSetURI?: url;

  /**
   * Links to related resources.
   */
  links: Link[];

  /**
   * TileMatrixSet definition.
   */
  tileMatrixSet?: TileMatrixSet;

  /**
   * Tile URL templates.
   */
  tiles?: string[];
}

/**
 * Vector tile response.
 */
model VectorTile {
  /**
   * Content type header.
   */
  @header contentType: "application/vnd.mapbox-vector-tile";

  /**
   * Binary tile data.
   */
  @body _: bytes;
}

/**
 * List of available TileMatrixSets.
 */
model TileMatrixSetsList {
  /**
   * List of TileMatrixSet items.
   */
  tileMatrixSets: TileMatrixSetItem[];
}

/**
 * Summary information about a TileMatrixSet.
 */
model TileMatrixSetItem {
  /**
   * Identifier of the TileMatrixSet.
   */
  id?: string;

  /**
   * Title of the TileMatrixSet.
   */
  title?: string;

  /**
   * URI of the TileMatrixSet.
   */
  uri?: url;

  /**
   * Coordinate Reference System.
   */
  crs?: Crs;

  /**
   * Links to related resources.
   */
  links?: Link[];
}

/**
 * Coordinate Reference System definition.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This is defined in the OGC API - Tiles spec"
union Crs {
  /**
   * CRS Identifier, e.g. http://www.opengis.net/def/crs/EPSG/0/4326
   */
  url,

  CrsObject,
}

/**
 * Coordinate Reference System object.
 */
model CrsObject {
  /**
   * CRS Identifier.
   */
  id?: string;

  /**
   * Well-known text representation of coordinate reference systems.
   */
  wkt: string;
}
