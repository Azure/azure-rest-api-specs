import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace MapsRender;

union TilesetID {
  string,

  /**
   * A base map is a standard map that displays roads, natural and artificial
   * features along with the labels for those features in a vector tile.<br>
   *
   * Supports zoom levels 0 through 22. Format: vector (pbf).
   */
  `microsoft.base`: "microsoft.base",

  /**
   * Displays labels for roads, natural and artificial features in a vector
   * tile.<br>
   *
   * Supports zoom levels 0 through 22. Format: vector (pbf).
   */
  `microsoft.base.labels`: "microsoft.base.labels",

  /**
   * Displays road, boundary and label data in a vector tile.<br>
   *
   * Supports zoom levels 0 through 22. Format: vector (pbf).
   */
  `microsoft.base.hybrid`: "microsoft.base.hybrid",

  /**
   * Shaded relief and terra layers.<br>
   *
   * Supports zoom levels 0 through 6. Format: raster (png).
   */
  `microsoft.terra.main`: "microsoft.terra.main",

  /**
   * All layers with our main style.<br>
   *
   * Supports zoom levels 0 through 22. Format: raster (png).
   */
  `microsoft.base.road`: "microsoft.base.road",

  /**
   * All layers with our dark grey style.<br>
   *
   * Supports zoom levels 0 through 22. Format: raster (png).
   */
  `microsoft.base.darkgrey`: "microsoft.base.darkgrey",

  /**
   * Label data in our main style.<br>
   *
   * Supports zoom levels 0 through 22. Format: raster (png).
   */
  `microsoft.base.labels.road`: "microsoft.base.labels.road",

  /**
   * Label data in our dark grey style.<br>
   *
   * Supports zoom levels 0 through 22. Format: raster (png).
   */
  `microsoft.base.labels.darkgrey`: "microsoft.base.labels.darkgrey",

  /**
   * Road, boundary and label data in our main style.<br>
   *
   * Supports zoom levels 0 through 22. Format: raster (png).
   */
  `microsoft.base.hybrid.road`: "microsoft.base.hybrid.road",

  /**
   * Road, boundary and label data in our dark grey style.<br>
   *
   * Supports zoom levels 0 through 22. Format: raster (png).
   */
  `microsoft.base.hybrid.darkgrey`: "microsoft.base.hybrid.darkgrey",

  /**
   * A combination of satellite or aerial imagery. Only available in S1 and G2
   * pricing SKU.<br>
   *
   * Supports zoom levels 1 through 19. Format: raster (png).
   */
  `microsoft.imagery`: "microsoft.imagery",

  /**
   * Weather radar tiles. Latest weather radar images including areas of rain, snow,
   * ice and mixed conditions. For more information on the Azure Maps Weather
   * service coverage, see [Azure Maps weather services
   * coverage](/azure/azure-maps/weather-coverage).  For more information on Radar
   * data, see [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#radar-images).
   *
   * Supports zoom levels 0 through 15. Format: raster (png).
   */
  `microsoft.weather.radar.main`: "microsoft.weather.radar.main",

  /**
   * Weather infrared tiles. Latest Infrared Satellite images shows clouds by their
   * temperature.  For more information, see [Azure Maps weather services
   * coverage](/azure/azure-maps/weather-coverage). For more information about the
   * satellite data returned, see [Weather services in Azure
   * Maps](https://learn.microsoft.com/azure/azure-maps/weather-services-concepts#satellite-images).
   *
   * Supports zoom levels 0 through 15. Format: raster (png).
   */
  `microsoft.weather.infrared.main`: "microsoft.weather.infrared.main",

  /**
   * absolute traffic tiles in vector
   */
  `microsoft.traffic.absolute`: "microsoft.traffic.absolute",

  /**
   * absolute traffic tiles in raster in our main style.
   */
  `microsoft.traffic.absolute.main`: "microsoft.traffic.absolute.main",

  /**
   * relative traffic tiles in vector
   */
  `microsoft.traffic.relative`: "microsoft.traffic.relative",

  /**
   * relative traffic tiles in raster in our main style.
   */
  `microsoft.traffic.relative.main`: "microsoft.traffic.relative.main",

  /**
   * relative traffic tiles in raster in our dark style.
   */
  `microsoft.traffic.relative.dark`: "microsoft.traffic.relative.dark",

  /**
   * traffic tiles in vector
   */
  `microsoft.traffic.delay`: "microsoft.traffic.delay",

  /**
   * traffic tiles in raster in our main style
   */
  `microsoft.traffic.delay.main`: "microsoft.traffic.delay.main",

  /**
   * reduced traffic tiles in raster in our main style
   */
  `microsoft.traffic.reduced.main`: "microsoft.traffic.reduced.main",

  /**
   * incident tiles in vector
   */
  `microsoft.traffic.incident`: "microsoft.traffic.incident",
}

union MapTileSize {
  string,

  /**
   * Return a 256 by 256 pixel tile.
   */
  size256: "256",

  /**
   * Return a 512 by 512 pixel tile.
   */
  size512: "512",
}

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

union TrafficTilesetId {
  string,

  /**
   *  Supported traffic related tilesetId.
   */
  `microsoft.traffic.relative.main`: "microsoft.traffic.relative.main",

  /**
   *  Default value, no traffic flow overlay.
   */
  none: "none",
}

union MediaType {
  string,

  /**
   * Return image in png format.
   */
  `image/png`: "image/png",

  /**
   * Return image in jpeg format.
   */
  `image/jpeg`: "image/jpeg",
}

union IncludeText {
  string,

  /**
   * Include all textual data in response.
   */
  yes: "yes",

  /**
   * Exclude textual data from response. Only images and country/region names will
   * be in response.
   */
  no: "no",
}

/**
 * Common error response for all Azure Resource Manager APIs to return error
 * details for failed operations. (This also follows the OData error response
 * format.).
 */
@error
model ErrorResponse {
  /**
   * The error object.
   */
  error?: ErrorDetail;
}

/**
 * The error detail.
 */
model ErrorDetail {
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
  details?: ErrorDetail[];

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Existing API contract."
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * Metadata for a tileset in the TileJSON format.
 */
model MapTileset {
  /**
   * Describes the version of the TileJSON spec that is implemented by this JSON
   * object.
   */
  @pattern("\\d+\\.\\d+\\.\\d+\\w?[\\w\\d]*")
  tilejson?: string;

  /**
   * A name describing the tileset. The name can contain any legal character.
   * Implementations SHOULD NOT interpret the name as HTML.
   */
  name?: string;

  /**
   * Text description of the tileset. The description can contain any legal
   * character. Implementations SHOULD NOT interpret the description as HTML.
   */
  description?: string;

  /**
   * A semver.org style version number for the tiles contained within the tileset.
   * When changes across tiles are introduced, the minor version MUST change.
   */
  @pattern("\\d+\\.\\d+\\.\\d+\\w?[\\w\\d]*")
  version?: string;

  /**
   * Copyright attribution to be displayed on the map. Implementations MAY decide to
   * treat this as HTML or literal text. For security reasons, make absolutely sure
   * that this field can't be abused as a vector for XSS or beacon tracking.
   */
  attribution?: string;

  /**
   * A mustache template to be used to format data from grids for interaction.
   */
  template?: string;

  /**
   * A legend to be displayed with the map. Implementations MAY decide to treat this
   * as HTML or literal text. For security reasons, make absolutely sure that this
   * field can't be abused as a vector for XSS or beacon tracking.
   */
  legend?: string;

  /**
   * Default: "xyz". Either "xyz" or "tms". Influences the y direction of the tile
   * coordinates. The global-mercator (aka Spherical Mercator) profile is assumed.
   */
  scheme?: string;

  /**
   * An array of tile endpoints. If multiple endpoints are specified, clients may
   * use any combination of endpoints. All endpoints MUST return the same content
   * for the same URL. The array MUST contain at least one endpoint.
   */
  tiles?: string[];

  /**
   * An array of interactivity endpoints.
   */
  grids?: string[];

  /**
   * An array of data files in GeoJSON format.
   */
  data?: string[];

  /**
   * The minimum zoom level.
   */
  @minValue(0)
  @maxValue(30)
  minzoom?: int32;

  /**
   * The maximum zoom level.
   */
  @minValue(0)
  @maxValue(30)
  maxzoom?: int32;

  /**
   * The maximum extent of available map tiles. Bounds MUST define an area covered
   * by all zoom levels. The bounds are represented in WGS:84 latitude and longitude
   * values, in the order left, bottom, right, top. Values may be integers or
   * floating point numbers.
   */
  bounds?: float32[];

  /**
   * The default location of the tileset in the form [longitude, latitude, zoom].
   * The zoom level MUST be between minzoom and maxzoom. Implementations can use
   * this value to set the default location.
   */
  center?: float32[];
}

/**
 * Copyright attribution for the requested section of a tileset.
 */
model MapAttribution {
  /**
   * A list of copyright strings.
   */
  copyrights?: string[];
}

/**
 * This object is returned from a successful copyright call
 */
model CopyrightCaption {
  /**
   * Format Version property
   */
  @visibility(Lifecycle.Read)
  formatVersion?: string;

  /**
   * Copyrights Caption property
   */
  @visibility(Lifecycle.Read)
  copyrightsCaption?: string;
}

/**
 * This object is returned from a successful copyright request
 */
model Copyright {
  /**
   * Format Version property
   */
  @visibility(Lifecycle.Read)
  formatVersion?: string;

  /**
   * General Copyrights array
   */
  @visibility(Lifecycle.Read)
  generalCopyrights?: string[];

  /**
   * Regions array
   */
  @visibility(Lifecycle.Read)
  regions?: RegionCopyrights[];
}

model RegionCopyrights {
  /**
   * Copyrights array
   */
  @visibility(Lifecycle.Read)
  copyrights?: string[];

  /**
   * Country property
   */
  @visibility(Lifecycle.Read)
  country?: RegionCopyrightsCountry;
}

/**
 * Country property
 */
model RegionCopyrightsCountry {
  /**
   * ISO3 property
   */
  @visibility(Lifecycle.Read)
  ISO3?: string;

  /**
   * Label property
   */
  @visibility(Lifecycle.Read)
  label?: string;
}
