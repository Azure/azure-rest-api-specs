import "@typespec/rest";
import "@typespec/http";
import "./models.common.colormaps.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

/**
 * Type identifying Feature Polygon objects containing rio-tiler model information
 */
union FeaturePolygonDictStrRioTilerModelsInfoType {
  string,

  /**
   * Standard GeoJSON Feature type identifier
   */
  Feature: "Feature",
}

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
 * Image format specifier for tile and image requests
 */
union ImageType {
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
 */
/**
 * Standard identifier for a coordinate reference system and tiling scheme used for serving map tiles
 */
union Tilematrixsetid {
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
union TileJsonScheme {
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
union MetadataType {
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
 * 'WebMercatorQuad')
 */
/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Method used to select or compute pixels when creating composites from multiple sources
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
  stdev: "stdev",

  /**
   * Select image with lowest value in the last band
   */
  lastbandlow: "lastbandlow",

  /**
   * Select image with highest value in the last band
   */
  lastbandhight: "lastbandhight",
}

/**
 * Format specification for image request outputs
 */
union ImageRequestFormat {
  string,

  /**
   * Portable Network Graphics format
   */
  png: "png",

  /**
   * Cloud Optimized GeoTIFF format
   */
  cog: "cog",
}

/**
 * Geographic extent of a dataset expressed as a bounding box
 */
model BoundsResponse {
  /**
   * Array of coordinates defining the bounding box [west, south, east, north]
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  bounds: float64[];
}

/**
 * GeoJSON Feature object containing rio-tiler model information
 */
model FeaturePolygonDictStrRioTilerModelsInfo {
  /**
   * GeoJSON type identifier
   */
  type: FeaturePolygonDictStrRioTilerModelsInfoType;

  /**
   * Geometry object defining the feature's shape
   */
  geometry: GeoJson;

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
  bbox?: float64;
}

/**
 * TileJSON model.
 *
 * Based on https://github.com/mapbox/tilejson-spec/tree/master/2.2.0
 */
/**
 * TileJSON metadata describing a tile set according to the TileJSON specification
 */
model TileJsonResponse {
  /**
   * Tilejson
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  tilejson?: string = "2.2.0";

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
  scheme?: TileJsonScheme = TileJsonScheme.xyz;

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
  minzoom?: int32;

  /**
   * Maximum zoom level available in the tile set
   */
  @maxValue(30)
  maxzoom?: int32 = 30;

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
  @bodyRoot body: string;

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
   * Per asset band indexes (coma separated indexes)
   */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query(#{ explode: true })
  @query("asset_bidx")
  assetBidx?: string[];

  /**
   * Asset as Band
   */
  @query("asset_as_band")
  assetAsBand?: boolean;

  /**
   * Overwrite internal Nodata value
   */
  @query("nodata")
  nodata?: float32;

  /**
   * Apply internal Scale or Offset
   */
  @query("unscale")
  unscale?: boolean;
}

/**
 * Parameters for specifying which algorithm to apply to raster data and its configuration
 */
model AlgorithmQueryParameters {
  /**
   * Algorithm name
   */
  @query("algorithm")
  algorithm?: Algorithm;

  /**
   * Algorithm parameter
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
  colormapName?: ColorMapNames;

  /**
   * JSON encoded custom Colormap
   */
  @query("colormap")
  colormap?: string;

  /**
   * Add mask to the output data.
   */
  @query("return_mask")
  returnMask?: boolean = true;
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
  minzoom?: int32;

  /**
   * Overwrite default maxzoom.
   */
  @query("maxzoom")
  maxzoom?: int32;
}

alias TileResponse =
  | ImagePngResponse
  | ImageJpegResponse
  | ImageJpgResponse
  | ImageWebpResponse
  | ImageJp2Response
  | ImageTiffResponse
  | ApplicationXbinaryResponse;
