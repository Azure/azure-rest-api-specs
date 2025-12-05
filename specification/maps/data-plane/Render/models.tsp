import "@typespec/http";

using TypeSpec.Http;

namespace MapsRender;

/**
 * A tileset is a collection of raster or vector data broken up into a uniform grid of square tiles at preset zoom levels. Every tileset has a **tilesetId** to use when making requests. The ready-to-use tilesets supplied by Azure Maps are listed below. For example, microsoft.base.
 */
union Tileset {
  string,

  /** microsoft.base.road */
  `microsoft.base.road`: "microsoft.base.road",

  /** microsoft.base.darkgrey */
  `microsoft.base.darkgrey`: "microsoft.base.darkgrey",

  /** microsoft.imagery */
  `microsoft.imagery`: "microsoft.imagery",
}

/**
 * A tileset is a collection of raster or vector data broken up into a uniform grid of square tiles at preset zoom levels. Every tileset has a **tilesetId** to use when making requests. The ready-to-use tilesets supplied by Azure Maps are listed below. For example, microsoft.base.
 */
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

/** The size of the returned map tile in pixels. */
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

/** The View parameter (also called the \"user region\" parameter) allows you to show the correct maps for a certain country/region for geopolitically disputed regions. Different countries/regions have different views of such regions, and the View parameter allows your application to comply with the view required by the country/region your application will be serving. By default, the View parameter is set to “Unified” even if you haven’t defined it in  the request. It is your responsibility to determine the location of your users, and then set the View parameter correctly for that location. Alternatively, you have the option to set ‘View=Auto’, which will return the map data based on the IP  address of the request. The View parameter in Azure Maps must be used in compliance with applicable laws, including those  regarding mapping, of the country/region where maps, images and other data and third party content that you are authorized to  access via Azure Maps is made available. Example: view=IN.\n\nPlease refer to [Supported Views](https://aka.ms/AzureMapsLocalizationViews) for details and to see the available Views. */
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

/** Desired format of the response. Value can be either _json_ or _xml_. */
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

/** Value indicating no traffic flow overlaid on the image result. */
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

/** The desired media type of the response. */
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

/** Include textual data in response. */
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
  details?: ErrorDetail[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract."
  @visibility(Lifecycle.Read)
  info?: Record<unknown>;
}

/**
 * Metadata for a tileset in the TileJSON format.
 */
model MapTileset {
  /**
   * Describes the version of the TileJSON spec that is implemented by this JSON
   * object.
   */
  @visibility(Lifecycle.Read)
  @pattern("\\d+\\.\\d+\\.\\d+\\w?[\\w\\d]*")
  tilejson?: string;

  /**
   * A name describing the tileset. The name can contain any legal character.
   * Implementations SHOULD NOT interpret the name as HTML.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Text description of the tileset. The description can contain any legal
   * character. Implementations SHOULD NOT interpret the description as HTML.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * A semver.org style version number for the tiles contained within the tileset.
   * When changes across tiles are introduced, the minor version MUST change.
   */
  @visibility(Lifecycle.Read)
  @pattern("\\d+\\.\\d+\\.\\d+\\w?[\\w\\d]*")
  version?: string;

  /**
   * Copyright attribution to be displayed on the map. Implementations MAY decide to
   * treat this as HTML or literal text. For security reasons, make absolutely sure
   * that this field can't be abused as a vector for XSS or beacon tracking.
   */
  @visibility(Lifecycle.Read)
  attribution?: string;

  /**
   * A mustache template to be used to format data from grids for interaction.
   */
  @visibility(Lifecycle.Read)
  template?: string;

  /**
   * A legend to be displayed with the map. Implementations MAY decide to treat this
   * as HTML or literal text. For security reasons, make absolutely sure that this
   * field can't be abused as a vector for XSS or beacon tracking.
   */
  @visibility(Lifecycle.Read)
  legend?: string;

  /**
   * Default: "xyz". Either "xyz" or "tms". Influences the y direction of the tile
   * coordinates. The global-mercator (aka Spherical Mercator) profile is assumed.
   */
  @visibility(Lifecycle.Read)
  scheme?: string;

  /**
   * An array of tile endpoints. If multiple endpoints are specified, clients may
   * use any combination of endpoints. All endpoints MUST return the same content
   * for the same URL. The array MUST contain at least one endpoint.
   */
  @visibility(Lifecycle.Read)
  tiles?: string[];

  /**
   * An array of interactivity endpoints.
   */
  @visibility(Lifecycle.Read)
  grids?: string[];

  /**
   * An array of data files in GeoJSON format.
   */
  @visibility(Lifecycle.Read)
  data?: string[];

  /**
   * The minimum zoom level.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(30)
  minzoom?: int32;

  /**
   * The maximum zoom level.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(30)
  maxzoom?: int32;

  /**
   * The maximum extent of available map tiles. Bounds MUST define an area covered
   * by all zoom levels. The bounds are represented in WGS:84 latitude and longitude
   * values, in the order left, bottom, right, top. Values may be integers or
   * floating point numbers.
   */
  @visibility(Lifecycle.Read)
  bounds?: float32[];

  /**
   * The default location of the tileset in the form [longitude, latitude, zoom].
   * The zoom level MUST be between minzoom and maxzoom. Implementations can use
   * this value to set the default location.
   */
  @visibility(Lifecycle.Read)
  center?: float32[];
}

/**
 * Copyright attribution for the requested section of a tileset.
 */
model MapAttribution {
  /**
   * A list of copyright strings.
   */
  @visibility(Lifecycle.Read)
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

/**
 * Region copyrights
 */
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract."
  @visibility(Lifecycle.Read)
  ISO3?: string;

  /**
   * Label property
   */
  @visibility(Lifecycle.Read)
  label?: string;
}

alias clientId = {
  /**
   * Indicates the account intended for use with the Microsoft Entra ID security
   * model. This unique ID for the Azure Maps account can be obtained from the
   * [Azure Maps management plane Account API](/rest/api/maps-management/accounts).
   * For more information on using Microsoft Entra ID security in Azure Maps, see
   * [Manage authentication in Azure
   * Maps](/azure/azure-maps/how-to-manage-authentication).
   */
  @header("x-ms-client-id")
  clientId?: string;
};
