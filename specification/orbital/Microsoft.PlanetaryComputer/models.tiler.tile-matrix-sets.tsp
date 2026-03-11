// Tile Matrix Sets interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.common.tsp";
import "./models.common.images.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

/**
 * https://github.com/opengeospatial/2D-Tile-Matrix-Set/blob/master/schemas/tms/2.0/json/tileMatrixSet.json
 *
 * A definition of a tile matrix set following the Tile Matrix Set standard.
 * For tileset metadata, such a description (in `tileMatrixSet` property) is only
 * required for offline use,
 * as an alternative to a link with a
 * `http://www.opengis.net/def/rel/ogc/1.0/tiling-scheme` relation type.
 */
model TileMatrixSet {
  /**
   * Human-readable title of the tile matrix set
   */
  title?: string;

  /**
   * Brief narrative description of this tile matrix set, normally available for
   * display to a human
   */
  description?: string;

  /**
   * Unordered list of one or more commonly used or formalized word(s) or phrase(s)
   * used to describe this tile matrix set
   */
  keywords?: string[];

  /**
   * Unique identifier for the tile matrix set
   */
  @pattern("^[\\w\\d_\\-]+$")
  id?: string;

  /**
   * URI reference to the official definition
   */
  uri?: string;

  /**
   * Names of the coordinate axes in order
   */
  orderedAxes?: string[];

  /**
   * Coordinate reference system identifier
   */
  crs: string;

  /**
   * URL reference to a standardized scale set
   */
  wellKnownScaleSet?: url;

  /**
   * Geographic extent of the tile matrix set
   */
  boundingBox?: TileMatrixSetBoundingBox;

  /**
   * Array of tile matrices at different zoom levels
   */
  tileMatrices: TileMatrix[];
}

/**
 * Geographic extent of the tile matrix set expressed in the specified coordinate reference system
 */
model TileMatrixSetBoundingBox is TmsBoundingBox;

/**
 * https://github.com/opengeospatial/2D-Tile-Matrix-Set/blob/master/schemas/tms/2.0/json/2DBoundingBox.json
 *
 * Bounding box defining the spatial extent in a specific coordinate reference system
 */
model TmsBoundingBox {
  /**
   * Lower-left corner coordinates [x, y] of bounding box
   */
  lowerLeft: string[];

  /**
   * Upper-right corner coordinates [x, y] of bounding box
   */
  upperRight: string[];

  /**
   * Coordinate reference system identifier (e.g., 'http://www.opengis.net/def/crs/EPSG/0/3857')
   */
  crs?: string;

  /**
   * Explicit axis order for the CRS coordinates (e.g., ['x', 'y'])
   */
  orderedAxes?: string[];
}

/**
 * Tile Matrix Definition
 *
 * A tile matrix, usually corresponding to a particular zoom level of a
 * TileMatrixSet.
 *
 * ref:
 * https://github.com/opengeospatial/2D-Tile-Matrix-Set/blob/master/schemas/tms/2.0/json/tileMatrix.json
 *
 * Definition of a tile matrix at a specific zoom level within a tile matrix set
 */
model TileMatrix {
  /**
   * Human-readable title of the tile matrix level
   */
  title?: string;

  /**
   * Human-readable description of this tile matrix level
   */
  description?: string;

  /**
   * Unordered list of one or more commonly used or formalized word(s) or phrase(s)
   * used to describe this dataset
   */
  keywords?: string[];

  /**
   * Unique identifier for this tile matrix level, often the zoom level
   */
  @pattern("^[-]?[0-9]+$")
  id: string;

  /**
   * Scale denominator representing the scale of this tile matrix level
   */
  scaleDenominator: float32;

  /**
   * Size of a pixel in map units at this tile matrix level
   */
  cellSize: float32;

  /**
   * The corner of the tile matrix (_topLeft_ or _bottomLeft_) used as the origin
   * for numbering tile rows and columns. This corner is also a corner of the (0, 0)
   * tile.
   */
  cornerOfOrigin?: TileMatrixCornerOfOrigin;

  /**
   * Precise position in CRS coordinates of the corner of origin (e.g. the top-left
   * corner) for this tile matrix. This position is also a corner of the (0, 0)
   * tile. In previous version, this was 'topLeftCorner' and 'cornerOfOrigin' did
   * not exist.
   */
  pointOfOrigin: float64[];

  /**
   * Pixel width of each tile at this level
   */
  @minValue(1)
  tileWidth: int32;

  /**
   * Pixel height of each tile at this level
   */
  @minValue(1)
  tileHeight: int32;

  /**
   * Number of tiles horizontally at this matrix level
   */
  @minValue(1)
  matrixWidth: int32;

  /**
   * Number of tiles vertically at this matrix level
   */
  @minValue(1)
  matrixHeight: int32;

  /**
   * Describes the rows that has variable matrix width
   *
   * ref: https://github.com/opengeospatial/2D-Tile-Matrix-Set/blob/master/schemas/tms/2.0/json/variableMatrixWidth.json
   */
  variableMatrixWidths?: VariableMatrixWidth[];
}

/**
 * The corner of the tile matrix (_topLeft_ or _bottomLeft_) used as the origin
 * for numbering tile rows and columns. This corner is also a corner of the (0, 0)
 * tile.
 */
union TileMatrixCornerOfOrigin {
  string,

  /**
   * Origin at the top-left corner (Y increases downward)
   */
  topLeft: "topLeft",

  /**
   * Origin at the bottom-left corner (Y increases upward)
   */
  bottomLeft: "bottomLeft",
}

/**
 * Model for variableMatrixWidth
 */
model VariableMatrixWidth {
  /**
   * Number of tiles in width that coalesce in a single tile for these rows
   */
  coalesce: int32;

  /**
   * First tile row where the coalescence factor applies for this tilematrix
   */
  minTileRow: int32;

  /**
   * Last tile row where the coalescence factor applies for this tilematrix
   */
  maxTileRow: int32;
}
