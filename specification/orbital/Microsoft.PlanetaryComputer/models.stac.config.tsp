import "@typespec/rest";
import "@typespec/http";
import "./models.stac.spec.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

/**
 * Defines visualization parameters for rendering data on a map.
 */
model RenderOption {
  /**
   * Unique identifier for the render option.
   */
  @maxLength(30)
  @minLength(1)
  @pattern("^(?!\\-|_)[a-zA-Z0-9_-]*(?<!\\-|_)$")
  id: string;

  /**
   * Short descriptive name for the render option.
   */
  @maxLength(40)
  name: string;

  /**
   * A longer description of the render option that can be used to explain its
   * content.
   */
  description?: string;

  /**
   * The type of rendering to apply (raster or vector).
   */
  type?: RenderOptionType = RenderOptionType.`raster-tile`;

  /**
   * A URL query-string encoded string of TiTiler rendering options. Valid only for
   * `raster-tile` types.  See 'Query Parameters':
   * https://developmentseed.org/titiler/endpoints/cog/#description
   */
  options?: string;

  /**
   * Options for rendering vector tiles. Valid only for `vt-polygon`  and `vt-line`
   * types.
   */
  vectorOptions?: RenderOptionVectorOptions;

  /**
   * Minimum zoom level at which to display this layer.
   */
  @maxValue(24)
  minZoom?: int32 = 12;

  /**
   * Legend configuration for this render option.
   */
  legend?: RenderOptionLegend;

  /**
   * A list of property/value conditions that must be in the active mosaic CQL for
   * this render option to be enabled
   */
  conditions?: RenderOptionCondition[];
}

/**
 * Defines parameters for vector tile rendering.
 */
model RenderOptionVectorOptions {
  /**
   * Asset key containing the TileJSON URL.
   */
  tilejsonKey: string;

  /**
   * Name of the source layer in the vector tiles.
   */
  sourceLayer: string;

  /**
   * Fill color for polygon features.
   */
  fillColor?: string;

  /**
   * Stroke color for line features.
   */
  strokeColor?: string;

  /**
   * Width of line strokes in pixels.
   */
  strokeWidth?: int32;

  /**
   * MapBox GL filter expression to filter features.
   */
  filter?: string[];
}

/**
 * Configuration for generating a data legend.
 */
model RenderOptionLegend {
  /**
   * Legend type to make,
   * one of: `continuous`,
   * `classmap`,
   * `interval` or `none`
   * (note, `none` is a string literal).
   */
  type?: LegendConfigType;

  /**
   * Text labels to display on the legend.
   */
  labels?: string[];

  /**
   * The number of items to trim from the start of the legend definition. Used if
   * there are values important for rendering (e.g. nodata) that aren't desirable in
   * the legend.
   */
  trimStart?: int32;

  /**
   * Number of items to trim from the end of the legend.
   */
  trimEnd?: int32;

  /**
   * A factor to multiply interval legend labels by. Useful for scaled rasters whose
   * colormap definitions map to unscaled values, effectively showing legend labels
   * as scaled values.
   */
  scaleFactor?: float32;
}

/**
 * Defines a condition for enabling a render option.
 */
model RenderOptionCondition {
  /**
   * Property name to check in the active CQL filter.
   */
  property: string;

  /**
   * Value that the property must equal.
   */
  value?: string;
}

/**
 * Defines how data is partitioned for efficient storage and retrieval.
 */
model PartitionType {
  /**
   * Partitioning scheme to use for data organization.
   */
  scheme?: PartitionTypeScheme = PartitionTypeScheme.none;
}

/**
 * Specifies the types of render options for map visualization.
 */
union RenderOptionType {
  string,

  /**
   * Raster tile rendering type.
   */
  `raster-tile`: "raster-tile",

  /**
   * Vector tile polygon rendering type.
   */
  `vt-polygon`: "vt-polygon",

  /**
   * Vector tile line rendering type.
   */
  `vt-line`: "vt-line",
}

/**
* Legend type to make,
 one of: `continuous`,
 `classmap`,
 `interval` or `none`
* (note, `none` is a string literal).
*/
/**
 * Defines the legend configuration types for data visualization.
 */
union LegendConfigType {
  string,

  /**
   * Continuous color ramp legend.
   */
  continuous: "continuous",

  /**
   * Classified map with discrete colors for classes.
   */
  classmap: "classmap",

  /**
   * Interval-based legend with discrete ranges.
   */
  interval: "interval",

  /**
   * No legend.
   */
  none: "none",
}

/**
 * Defines partitioning schemes for temporal data organization.
 */
union PartitionTypeScheme {
  string,

  /**
   * Partition data by year.
   */
  year: "year",

  /**
   * Partition data by month.
   */
  month: "month",

  /**
   * No partitioning.
   */
  none: "none",
}

/**
 * Configuration for data mosaic visualization.
 */
model MosaicInfo {
  /**
   * Predefined data mosaics available for this collection.
   */
  mosaics: Mosaic[];

  /**
   * Available render options for visualizing the data.
   */
  renderOptions: RenderOption[];

  /**
   * Default map location when displaying this collection.
   */
  defaultLocation?: DefaultLocation;

  /**
   * A list of CQL-JSON expressions to use as the default for  this collection.
   */
  defaultCustomQuery?: Record<string>;
}

/**
 * Defines a named mosaic with filtering criteria.
 */
model Mosaic {
  /**
   * Unique identifier for the mosaic.
   */
  @maxLength(30)
  @minLength(1)
  @pattern("^(?!\\-|_)[a-zA-Z0-9_-]*(?<!\\-|_)$")
  id: string;

  /**
   * Short descriptive name for the mosaic.
   */
  @maxLength(30)
  name: string;

  /**
   * Detailed description of the mosaic.
   */
  description?: string;

  /**
   * A list of valid CQL2-JSON expressions used to filter the collection to moasic.
   */
  cql: Cql[];
}

/**
 * User-specific collection settings for visualization.
 */
model UserCollectionSettings {
  /**
   * Settings for map tile visualization.
   */
  tileSettings: TileSettings;

  /**
   * Settings for data mosaic visualization.
   */
  mosaicInfo: MosaicInfo;
}

/**
 * Configuration for map tile visualization.
 */
model TileSettings {
  /**
   * The minimum zoom level that can be requested for this collection. Provides a
   * hard limit for the tile servers to ensure they don't get requests for low zoom
   * levels, which would cause many files to be fetched and the tile servers to
   * hang.
   */
  @maxValue(24)
  minZoom: int32;

  /**
   * Maximum number of items to include in a single tile.
   */
  maxItemsPerTile: int32;

  /**
   * Default map location when displaying this collection.
   */
  defaultLocation?: DefaultLocation;
}

/**
 * Defines a default geographic location for map visualization.
 */
model DefaultLocation {
  /**
   * Default zoom level for the map.
   */
  @maxValueExclusive(24)
  zoom: int32;

  /**
   * Default center coordinates [latitude, longitude] for the map.
   */
  coordinates: float32[];
}

/**
 * Represents an Azure Maps token for map visualization.
 */
model AzMapsToken {
  /**
   * The authentication token for Azure Maps.
   */
  token: string;

  /**
   * Expiration timestamp of the token in Unix time.
   */
  @encodedName("application/json", "expires_on")
  expiresOn: int32;
}

/**
 * Represents an Azure Maps client ID for authentication.
 */
model AzMapsClientId {
  /**
   * The client ID for Azure Maps authentication.
   */
  @encodedName("application/json", "client_id")
  clientId: string;
}

/**
 * Microsoft Authentication Library (MSAL) configuration for frontend authentication.
 */
model AuthConfig {
  /**
   * Application ID for authentication.
   */
  @encodedName("application/json", "authn_app_id")
  authnAppId: string;

  /**
   * Azure Active Directory tenant ID.
   */
  @encodedName("application/json", "tenant_id")
  tenantId: string;

  /**
   * Azure AD instance URL.
   */
  instance: url;

  /**
   * Redirect URI after authentication.
   */
  @encodedName("application/json", "redirect_uri")
  redirectUri?: url;
}

/**
 * FormData model for file upload.
 */
model FormData {
  /**
   * Asset metadata
   */
  data: HttpPart<AssetMetadata>;

  /**
   * Binary file content to be uploaded.
   */
  file: HttpPart<bytes>;
}

/**
 * Asset metadata model.
 */
#suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "Multipart parts can only be represented as primitive types in swagger 2.0. Information is lost for part 'data'"
model AssetMetadata {
  /**
   * The key of the asset.
   */
  key: string;

  /**
   * The type of the asset.
   */
  type: string;

  /**
   * The roles of the asset.
   */
  roles: string[];

  /**
   * The title of the asset.
   */
  title: string;

  /**
   * The description of the asset.
   */
  description: string;
}
