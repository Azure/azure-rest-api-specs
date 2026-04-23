import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./models.common.colormaps.tsp";
import "./models.common.versions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;

/**
 * Resampling algorithm to use when reading source raster data at different resolutions
 */
union Resampling {
  string,

  /**
   * Nearest neighbor - fastest method that selects the closest pixel value
   */
  nearest: "nearest",

  /**
   * Bilinear interpolation - calculates output values using a weighted average of 2x2 input cells
   */
  bilinear: "bilinear",

  /**
   * Cubic interpolation - uses a weighted average of 4x4 input cells for smoother results
   */
  cubic: "cubic",

  /**
   * Cubic spline interpolation - similar to cubic but preserves edges better
   */
  cubic_spline: "cubic_spline",

  /**
   * Lanczos windowed sinc resampling - high-quality with minimal artifacts
   */
  lanczos: "lanczos",

  /**
   * Average resampling - calculates the mean of all contributing pixels
   */
  average: "average",

  /**
   * Mode resampling - selects the most common value from contributing pixels
   */
  mode: "mode",

  /**
   * Gaussian weighted resampling - applies a gaussian weighting to contributing pixels
   */
  gauss: "gauss",

  /**
   * Root mean square resampling - useful for resampling error or deviation grids
   */
  rms: "rms",
}

/**
 * WarpKernel resampling algorithm used when doing re-projection. Defaults to `nearest`.
 */
@added(Versions.v2026_04_15)
union WarpKernelResampling {
  string,

  /** Nearest neighbor */
  nearest: "nearest",

  /** Bilinear interpolation */
  bilinear: "bilinear",

  /** Cubic interpolation */
  cubic: "cubic",

  /** Cubic spline interpolation */
  cubic_spline: "cubic_spline",

  /** Lanczos windowed sinc resampling */
  lanczos: "lanczos",

  /** Average resampling */
  average: "average",

  /** Mode resampling */
  mode: "mode",

  /** Maximum value resampling */
  max: "max",

  /** Minimum value resampling */
  min: "min",

  /** Median value resampling */
  med: "med",

  /** First quartile resampling */
  q1: "q1",

  /** Third quartile resampling */
  q3: "q3",

  /** Sum resampling */
  sum: "sum",

  /** Root mean square resampling */
  rms: "rms",
}

/**
 * Image format specifier for tile and image requests
 */
union TilerImageFormat {
  string,

  /**
   * Portable Network Graphics format - supports transparency
   */
  png: "png",

  /**
   * NumPy array format for raw data access
   */
  npy: "npy",

  /**
   * GeoTIFF format for georeferenced raster data
   */
  tif: "tif",

  /**
   * JPEG format - smaller file size but lossy compression
   */
  jpeg: "jpeg",

  /**
   * Alternate extension for JPEG format
   */
  jpg: "jpg",

  /**
   * JPEG 2000 format - supports both lossy and lossless compression
   */
  jp2: "jp2",

  /**
   * WebP format - modern image format with good compression
   */
  webp: "webp",

  /**
   * Raw PNG format for access to unprocessed data
   */
  pngraw: "pngraw",
}

/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 *
 * Standard identifier for a coordinate reference system and tiling scheme used for serving map tiles
 */
union TileMatrixSetId {
  string,

  /**
   * Canadian NAD83 Lambert Conformal Conic projection tile matrix set
   */
  CanadianNAD83_LCC: "CanadianNAD83_LCC",

  /**
   * European ETRS89 Lambert Azimuthal Equal Area Quad tile matrix set
   */
  EuropeanETRS89_LAEAQuad: "EuropeanETRS89_LAEAQuad",

  /**
   * Land Information New Zealand (LINZ) Antarctica Map tile grid matrix set
   */
  LINZAntarticaMapTilegrid: "LINZAntarticaMapTilegrid",

  /**
   * New Zealand Transverse Mercator 2000 Quad tile matrix set
   */
  NZTM2000Quad: "NZTM2000Quad",

  /**
   * Universal Polar Stereographic Antarctic WGS84 Quad tile matrix set
   */
  UPSAntarcticWGS84Quad: "UPSAntarcticWGS84Quad",

  /**
   * Universal Polar Stereographic Arctic WGS84 Quad tile matrix set
   */
  UPSArcticWGS84Quad: "UPSArcticWGS84Quad",

  /**
   * Universal Transverse Mercator Zone 31 WGS84 Quad tile matrix set
   */
  UTM31WGS84Quad: "UTM31WGS84Quad",

  /**
   * WGS 1984 Quad tile matrix set
   */
  WGS1984Quad: "WGS1984Quad",

  /**
   * Web Mercator Quad tile matrix set
   */
  WebMercatorQuad: "WebMercatorQuad",

  /**
   * World CRS84 Quad tile matrix set
   */
  WorldCRS84Quad: "WorldCRS84Quad",

  /**
   * World Mercator WGS84 Quad tile matrix set
   */
  WorldMercatorWGS84Quad: "WorldMercatorWGS84Quad",
}

/**
 * Scheme for tile addressing in TileJSON specification
 */
union TileAddressingScheme {
  string,

  /**
   * XYZ tile addressing scheme with origin at top-left
   */
  xyz: "xyz",

  /**
   * TMS tile addressing scheme with origin at bottom-left
   */
  tms: "tms",
}

/**
 * Type of metadata resource in the system
 */
union MosaicMetadataType {
  string,

  /**
   * Metadata for a mosaic of multiple raster assets
   */
  mosaic: "mosaic",

  /**
   * Metadata for a search query result
   */
  search: "search",
}

/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 *  'WebMercatorQuad')
 *
 * Represents the method used to select or compute pixels when creating
 *  composites from multiple sources
 */
union PixelSelection {
  string,

  /**
   * Select pixel from the first available image
   */
  first: "first",

  /**
   * Select pixel with the highest value
   */
  highest: "highest",

  /**
   * Select pixel with the lowest value
   */
  lowest: "lowest",

  /**
   * Calculate mean of available pixels
   */
  mean: "mean",

  /**
   * Calculate median of available pixels
   */
  median: "median",

  /**
   * Calculate standard deviation of available pixels
   */
  standardDeviation: "stdev",

  /**
   * Select image with lowest value in the last band
   */
  lastBandLow: "lastbandlow",

  /**
   * Select image with highest value in the last band
   */
  lastBandHigh: "lastbandhigh",

  /**
   * Count available pixels across sources
   */
  @added(Versions.v2026_04_15)
  count: "count",
}

/**
 * Geographic extent of a dataset expressed as a bounding box
 */
model StacItemBounds {
  /**
   * Array of coordinates defining the bounding box [west, south, east, north]
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  bounds: float32[];
}

/**
 * GeoJSON Feature object containing rio-tiler model information
 */
model TilerInfoGeoJsonFeature {
  /**
   * GeoJSON type identifier
   */
  type: FeatureType;

  /**
   * Geometry object defining the feature's shape
   */
  geometry: Geometry;

  /**
   * Properties
   */
  properties: Record<TilerInfo>;

  /**
   * Unique identifier for the feature
   */
  id?: string;

  /**
   * Bounding box coordinates for the feature
   */
  @encodedName("application/json", "bbox")
  boundingBox?: float32[];
}

/**
 * Represents GeoJSON with feature with an asset property
 */
model TilerAssetGeoJson {
  /**
   * Unique identifier for the feature
   */
  id: string;

  /**
   * ID of the STAC collection this item belongs to.
   */
  collection?: string;

  /**
   * Bounding box coordinates for the feature
   */
  @encodedName("application/json", "bbox")
  boundingBox: float32[];

  /**
   * Assets
   */
  assets: Record<StacAsset>;
}

/**
 * TileJSON metadata describing a tile set according to the TileJSON specification
 *
 * Based on https://github.com/mapbox/tilejson-spec/tree/master/2.2.0
 */
model TileJsonMetadata {
  /**
   * TileJson
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  @encodedName("application/json", "tilejson")
  tileJson?: string = "2.2.0";

  /**
   * Human-readable name of the tile set
   */
  name?: string;

  /**
   * Human-readable description of the tile set
   */
  description?: string;

  /**
   * Version
   */
  version?: string = "1.0.0";

  /**
   * Attribution text for the data sources
   */
  attribution?: string;

  /**
   * URL template for feature info queries
   */
  template?: string;

  /**
   * URL to legend content for the tile set
   */
  legend?: string;

  /**
   * Tile addressing scheme (xyz or tms)
   */
  scheme?: TileAddressingScheme = TileAddressingScheme.xyz;

  /**
   * Array of tile URL templates
   */
  tiles: string[];

  /**
   * Array of UTFGrid URL templates
   */
  grids?: string[];

  /**
   * Array of data file URL templates
   */
  data?: string[];

  /**
   * Minimum zoom level available in the tile set
   */
  @maxValue(30)
  @encodedName("application/json", "minzoom")
  minZoom?: int32;

  /**
   * Maximum zoom level available in the tile set
   */
  @maxValue(30)
  @encodedName("application/json", "maxzoom")
  maxZoom?: int32 = 30;

  /**
   * Bounds
   */
  bounds?: float32[] = #[-180, -90, 180, 90];

  /**
   * Default center point [longitude, latitude, zoom] for the tile set
   */
  center?: float32[];
}

/**
 * Successful Response
 */
model WmtsCapabilitiesXmlResponse {
  /**
   * status code for WMTSCapabilitiesXmlResponse
   */
  @statusCode statusCode: 200;

  /**
   * body for WMTSCapabilitiesXmlResponse
   */
  @body body: bytes;

  /**
   * content type for WMTSCapabilitiesXmlResponse
   */
  @header contentType: "application/xml";
}

/**
 * Parameters for selecting and manipulating assets (raster data) from STAC items
 */
model AssetQueryParameters {
  /**
   * Dataset band indexes
   */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @added(Versions.v2026_04_15)
  @query(#{ explode: true })
  bidx?: int32[];

  /**
   * Asset's names.
   */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query(#{ explode: true })
  assets?: string[];

  /**
   * Band math expression between assets
   */
  @query("expression")
  expression?: string;

  /**
   * Per asset band indexes (coma separated indexes, e.g. "image|1,2,3" means use the bands 1, 2, and 3 from the asset named "image")
   */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query("asset_bidx")
  @typeChangedFrom(Versions.v2026_04_15, string)
  assetBandIndices?: string[];

  /**
   * Asset as Band
   */
  @query("asset_as_band")
  assetAsBand?: boolean;

  /**
   * Overwrite internal Nodata value
   */
  @query("nodata")
  @typeChangedFrom(Versions.v2026_04_15, float32)
  noData?: string;

  /**
   * Apply internal Scale or Offset
   */
  @query("unscale")
  unscale?: boolean;

  /**
   * WarpKernel resampling algorithm (only used when doing re-projection). Defaults to `nearest`.
   */
  @added(Versions.v2026_04_15)
  @query("reproject")
  reproject?: WarpKernelResampling;
}

/**
 * Parameters for specifying which algorithm to apply to raster data and its configuration
 */
model TerrainAlgorithmQueryParameters {
  /**
   * Terrain algorithm name
   */
  @query("algorithm")
  algorithm?: TerrainAlgorithm;

  /**
   * Terrain algorithm parameters
   */
  @query("algorithm_params")
  algorithmParams?: string;
}

/**
 * Visual rendering parameters for tiles including rescaling, colormaps, and masking options
 */
model MiscTileQueryParameters {
  /**
   * comma (',') delimited Min,Max range. Can set multiple time for multiple bands.
   */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query(#{ explode: true })
  rescale?: string[];

  /**
   * Colormap name
   */
  @query("colormap_name")
  colorMapName?: ColorMapNames;

  /**
   * JSON encoded custom Colormap
   */
  @query("colormap")
  colorMap?: string;

  /**
   * Add mask to the output data.
   */
  @query("return_mask")
  returnMask?: boolean = true;
}

/**
 * Padding parameter for tile rendering endpoints only.
 * Separated from MiscTileQueryParameters because padding applies to tiles/tilejson but not to bbox/feature/preview/WMTS.
 */
@added(Versions.v2026_04_15)
model TilePaddingQueryParameters {
  /**
   * Padding to apply to each tile edge. Helps reduce resampling artefacts along edges. Defaults to `0`.
   */
  @added(Versions.v2026_04_15)
  @query
  @minValueExclusive(0)
  padding?: int32;
}

/**
 * Standard tile coordinates (zoom, x, y) that identify a specific tile in a tile pyramid
 */
model ZxyPathParameters {
  /**
   * Identifier (Z) selecting one of the scales defined in the TileMatrixSet and
   * representing the scaleDenominator the tile.
   */
  @path
  z: float32;

  /**
   * Column (X) index of the tile on the selected TileMatrix. It cannot exceed the
   * MatrixHeight-1 for the selected TileMatrix.
   */
  @path
  x: float32;

  /**
   * Row (Y) index of the tile on the selected TileMatrix. It cannot exceed the
   * MatrixWidth-1 for the selected TileMatrix.
   */
  @path
  y: float32;
}

/**
 * Parameters for overriding the default zoom level constraints
 */
model ZoomQueryParameters {
  /**
   * Overwrite default minzoom.
   */
  @query("minzoom")
  minZoom?: int32;

  /**
   * Overwrite default maxzoom.
   */
  @query("maxzoom")
  maxZoom?: int32;
}

/**
 * STAC Collection Identifier as a query parameter
 */
@added(Versions.v2026_04_15)
model CollectionQueryParameter {
  /**
   * STAC Collection Identifier
   */
  @added(Versions.v2026_04_15)
  @query("collection")
  collection?: string;
}

/**
 * Output Coordinate Reference System query parameter
 */
@added(Versions.v2026_04_15)
model DstCrsQueryParameter {
  /**
   * Output Coordinate Reference System.
   */
  @added(Versions.v2026_04_15)
  @query("dst_crs")
  destinationCrs?: string;
}

alias TileResponse =
  | ImagePngResponse
  | ImageJpegResponse
  | ImageJpgResponse
  | ImageWebpResponse
  | ImageJp2Response
  | ImageTiffResponse
  | ApplicationXbinaryResponse;

/**
 * A link object used in OGC tile resources
 */
@added(Versions.v2026_04_15)
model TileSetLink {
  /**
   * The URL target of the link
   */
  href: string;

  /**
   * The relationship type of the link
   */
  rel: string;

  /**
   * The media type of the linked resource
   */
  type?: string;

  /**
   * Human-readable title of the link
   */
  title?: string;
}

/**
 * Bounding box for a tile set
 */
@added(Versions.v2026_04_15)
model TileSetBoundingBox {
  /**
   * Lower-left corner coordinates [x, y]
   */
  lowerLeft: float64[];

  /**
   * Upper-right corner coordinates [x, y]
   */
  upperRight: float64[];

  /**
   * Coordinate reference system identifier
   */
  crs?: string;
}

/**
 * Summary information about a single tileset within a list of available tilesets
 */
@added(Versions.v2026_04_15)
model TileSetEntry {
  /**
   * Human-readable title of the tileset
   */
  title?: string;

  /**
   * Type of data in the tiles (e.g., 'map', 'vector')
   */
  dataType?: string;

  /**
   * Coordinate reference system identifier
   */
  crs?: string;

  /**
   * Links related to this tileset
   */
  links?: TileSetLink[];

  /**
   * Bounding box of the tileset
   */
  boundingBox?: TileSetBoundingBox;

  /**
   * Access constraints for the tileset
   */
  accessConstraints?: string;
}

/**
 * Response containing a list of available tilesets
 */
@added(Versions.v2026_04_15)
model TileSetList {
  /**
   * Array of available tilesets
   */
  tilesets: TileSetEntry[];
}

/**
 * Limits for a specific tile matrix within a tileset, defining the valid row/column range
 */
@added(Versions.v2026_04_15)
model TileMatrixSetLimitsEntry {
  /**
   * Identifier of the tile matrix level
   */
  tileMatrix: string;

  /**
   * Minimum tile row index at this zoom level
   */
  minTileRow: int32;

  /**
   * Maximum tile row index at this zoom level
   */
  maxTileRow: int32;

  /**
   * Minimum tile column index at this zoom level
   */
  minTileCol: int32;

  /**
   * Maximum tile column index at this zoom level
   */
  maxTileCol: int32;
}

/**
 * Detailed metadata about a specific tileset, including tile matrix set limits
 */
@added(Versions.v2026_04_15)
model TileSetMetadata {
  /**
   * Human-readable title of the tileset
   */
  title?: string;

  /**
   * Type of data in the tiles
   */
  dataType?: string;

  /**
   * Coordinate reference system identifier
   */
  crs?: string;

  /**
   * Links related to this tileset
   */
  links?: TileSetLink[];

  /**
   * Bounding box of the tileset
   */
  boundingBox?: TileSetBoundingBox;

  /**
   * Access constraints for the tileset
   */
  accessConstraints?: string;

  /**
   * Limits for each tile matrix level in the tileset
   */
  tileMatrixSetLimits?: TileMatrixSetLimitsEntry[];
}
