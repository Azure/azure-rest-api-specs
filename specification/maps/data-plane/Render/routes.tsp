import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;

namespace MapsRender;

op MapsRenderOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model,
  TError extends TypeSpec.Reflection.Model = ErrorResponse
> is Azure.Core.Foundations.Operation<
  {
    ...clientId;
    ...TParams;
  },
  TResponse,
  {},
  TError
>;

interface Render {
  /**
   *
   *
   * The `Get Map Tiles` API enables users to request map tiles in either vector or
   * raster formats, typically for integration into a map control or SDK. Supported
   * tile types include Azure Maps road tiles and real-time Weather Radar tiles. By
   * default, the Azure Maps [Web SDK](/azure/azure-maps/about-azure-maps#web-sdk)
   * uses vector tiles for rendering its web map control.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to request map tiles in vector or raster format.")
  @route("/map/tile")
  @get
  getMapTile is MapsRenderOperation<
    {
      /**
       * A tileset is a collection of raster or vector data broken up into a uniform
       * grid of square tiles at preset zoom levels. Every tileset has a **tilesetId**
       * to use when making requests. The ready-to-use tilesets supplied by Azure Maps
       * are listed below. For example, microsoft.base.
       */
      @query("tilesetId")
      tilesetId: TilesetID;

      /**
       * Zoom level for the desired tile.
       *
       * Please see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid)
       * for details.
       */
      @query("zoom")
      z: int32;

      /**
       * X coordinate of the tile on zoom grid. Value must be in the range [0,
       * 2<sup>`zoom`</sup> -1].
       *
       * Please see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid)
       * for details.
       */
      @query("x")
      x: int32;

      /**
       * Y coordinate of the tile on zoom grid. Value must be in the range [0,
       * 2<sup>`zoom`</sup> -1].
       *
       * Please see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid)
       * for details.
       */
      @query("y")
      y: int32;

      /**
       * The desired date and time of the requested tile. This parameter must be
       * specified in the standard date-time format (e.g. 2019-11-14T16:03:00-08:00), as
       * defined by [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). This parameter
       * is only supported when tilesetId parameter is set to one of the values below.
       *
       * * microsoft.weather.infrared.main: We provide tiles up to 3 hours in the past.
       * Tiles are available in 10-minute intervals. We round the timeStamp value to the
       * nearest 10-minute time frame.
       * * microsoft.weather.radar.main: We provide tiles up to 1.5 hours in the past
       * and up to 2 hours in the future. Tiles are available in 5-minute intervals. We
       * round the timeStamp value to the nearest 5-minute time frame.
       */
      @query("timeStamp")
      timeStamp?: utcDateTime;

      /**
       * The size of the returned map tile in pixels.
       */
      @query("tileSize")
      tileSize?: MapTileSize;

      /**
       * Language in which search results should be returned. Should be one of supported
       * IETF language tags, case insensitive. When data in specified language is not
       * available for a specific field, default language is used.
       *
       * Please refer to [Supported
       * Languages](https://docs.microsoft.com/azure/azure-maps/supported-languages) for
       * details.
       */
      @query("language")
      language?: string;

      /**
       * The View parameter (also called the "user region" parameter) allows you to show
       * the correct maps for a certain country/region for geopolitically disputed
       * regions. Different countries/regions have different views of such regions, and
       * the View parameter allows your application to comply with the view required by
       * the country/region your application will be serving. By default, the View
       * parameter is set to “Unified” even if you haven’t defined it in  the request.
       * It is your responsibility to determine the location of your users, and then set
       * the View parameter correctly for that location. Alternatively, you have the
       * option to set ‘View=Auto’, which will return the map data based on the IP
       * address of the request. The View parameter in Azure Maps must be used in
       * compliance with applicable laws, including those  regarding mapping, of the
       * country/region where maps, images and other data and third party content that
       * you are authorized to  access via Azure Maps is made available. Example:
       * view=IN.
       *
       * Please refer to [Supported Views](https://aka.ms/AzureMapsLocalizationViews)
       * for details and to see the available Views.
       */
      @query("view")
      localizedMapView?: LocalizedMapView;
    },
    {
      /**
       * The media type of the response.
       */
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Specifying response content-types."
      @header("Content-Type")
      contentType:
        | "application/json"
        | "image/jpeg"
        | "image/png"
        | "image/pbf"
        | "application/vnd.mapbox-vector-tile";

      /**
       * The tile returned from a successful API call.
       */
      @bodyRoot
      body?: bytes;
    }
  >;

  /**
   *
   *
   * The Get Map Tileset API allows users to request metadata for a tileset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get metadata for a tileset.")
  @route("/map/tileset")
  @get
  getMapTileset is MapsRenderOperation<
    {
      /**
       * A tileset is a collection of raster or vector data broken up into a uniform
       * grid of square tiles at preset zoom levels. Every tileset has a **tilesetId**
       * to use when making requests. The ready-to-use tilesets supplied by Azure Maps
       * are listed below. For example, microsoft.base.
       */
      @query("tilesetId")
      tilesetId: TilesetID;
    },
    MapTileset
  >;

  /**
   *
   *
   * The `Get Map Attribution` API allows users to request map copyright attribution
   * information for a section of a tileset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get map copyright attribution information.")
  @route("/map/attribution")
  @get
  getMapAttribution is MapsRenderOperation<
    {
      /**
       * A tileset is a collection of raster or vector data broken up into a uniform
       * grid of square tiles at preset zoom levels. Every tileset has a **tilesetId**
       * to use when making requests. The ready-to-use tilesets supplied by Azure Maps
       * are listed below. For example, microsoft.base.
       */
      @query("tilesetId")
      tilesetId: TilesetID;

      /**
       * Zoom level for the desired map attribution.
       */
      @query("zoom")
      zoom: int32;

      /**
       * The string that represents the rectangular area of a bounding box. The bounds
       * parameter is defined by the 4 bounding box coordinates, with WGS84 longitude
       * and latitude of the southwest corner followed by  WGS84 longitude and latitude
       * of the northeast corner. The string is presented in the following  format:
       * `[SouthwestCorner_Longitude, SouthwestCorner_Latitude, NortheastCorner_Longitude,  NortheastCorner_Latitude]`.
       */
      @query("bounds")
      bounds: float64[];
    },
    MapAttribution
  >;

  /**
   *
   *
   * Fetches state tiles in vector format typically to be integrated into indoor
   * maps module of map control or SDK. The map control will call this API after
   * user turns on dynamic styling. For more information, see [Zoom Levels and Tile
   * Grid](/azure/location-based-services/zoom-levels-and-tile-grid).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get state tiles in vector format that can then be used to display
    feature state information in an indoor map.
    """)
  @route("/map/statetile")
  @get
  getMapStateTile is MapsRenderOperation<
    {
      /**
       * Zoom level for the desired tile.
       *
       * Please see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid)
       * for details.
       */
      @query("zoom")
      z: int32;

      /**
       * X coordinate of the tile on zoom grid. Value must be in the range [0,
       * 2<sup>`zoom`</sup> -1].
       *
       * Please see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid)
       * for details.
       */
      @query("x")
      x: int32;

      /**
       * Y coordinate of the tile on zoom grid. Value must be in the range [0,
       * 2<sup>`zoom`</sup> -1].
       *
       * Please see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid)
       * for details.
       */
      @query("y")
      y: int32;

      /**
       * The stateset id.
       */
      @query("statesetId")
      statesetId: string;
    },
    {
      /**
       * The media type of the response.
       */
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Specifying response content-types."
      @header("Content-Type")
      contentType: "application/json" | "application/vnd.mapbox-vector-tile";

      /**
       * The tile returned from a successful API call.
       */
      @bodyRoot
      body?: bytes;
    }
  >;

  /**
   * The `Get Copyright Caption` API is an HTTP GET request designed to serve
   * copyright information to be used with tiles requested from the Render service.
   * In addition to a basic copyright for the whole map, it can serve specific
   * groups of copyrights for some countries/regions.
   *
   * As an alternative to copyrights for map request, it can also return captions
   * for displaying provider information on the map.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get copyright information to use when rendering a tile.")
  @route("/map/copyright/caption/{format}")
  @get
  getCopyrightCaption is MapsRenderOperation<
    {
      /**
       * Desired format of the response. Value can be either _json_ or _xml_.
       */
      @path
      format: ResponseFormat;
    },
    CopyrightCaption
  >;

  /**
   * This rendering API produces static, rasterized map views of a user-defined
   * area. It's suitable for lightweight web applications, when the desired user
   * experience doesn't require interactive map controls, or when bandwidth is
   * limited. This API is also useful for embedding maps in applications outside of
   * the browser, in backend services, report generation, or desktop applications.
   *
   *  This API includes parameters for basic data visualization:
   *
   * - Labeled pushpins in multiple styles.
   * - Render circle, path, and polygon geometry types.
   *
   * For more information and detailed examples, see [Render custom data on a raster
   * map](/azure/azure-maps/how-to-render-custom-data).
   * <br><br>
   * The dimensions of the bbox parameter are constrained, depending on the zoom
   * level. This ensures the resulting image has an appropriate level of detail.
   * <br><br>
   *
   *   |Zoom Level | Min Lon Range   | Max Lon Range   | Min Lat Range| Max Lat
   * Range|
   *
   * |:----------|:----------------|:----------------|:----------------|:-------------|
   *   |0          | 56.25     | 360.0       | 30.1105585173    | 180.0        |
   *   |1          | 28.125         | 360.0       | 14.87468995    | 180.0        |
   *   |2         | 14.063       | 351.5625      |  7.4130741851    | 137.9576312246
   *       |
   *   |3     | 7.03125     | 175.78125    |  3.7034501005    |   73.6354071932
   * |
   *   |4     | 3.515625    | 87.890625  | 1.8513375155  | 35.4776115315  |
   *   |5          | 1.7578125  | 43.9453125  | 0.925620264 | 17.4589959239  |
   *   |6       | 0.87890625 | 21.97265625 | 0.4628040687  | 8.6907788223  |
   *   |7      | 0.439453125 |  10.986328125 | 0.2314012764  | 4.3404320789 |
   *   |8       | 0.2197265625 | 5.4931640625 | 0.1157005434  | 2.1695927024  |
   *   |9      | 0.1098632812 | 2.7465820312  |  0.0578502599  | 1.0847183194  |
   *   |10    | 0.0549316406  | 1.3732910156 | 0.0289251285  | 0.5423494021  |
   *   |11     | 0.0274658203 | 0.6866455078 | 0.014462564 | 0.2711734813 |
   *   |12      |  0.0137329102  | 0.3433227539 | 0.007231282 | 0.1355865882  |
   *   |13    | 0.0068664551 | 0.171661377 | 0.003615641 | 0.067793275 |
   *   |14     |  0.0034332275  | 0.0858306885 | 0.0018078205 | 0.0338966351 |
   *   |15     |  0.0017166138 | 0.0429153442 | 0.0009039102 | 0.0169483173 |
   *   |16   |  0.0008583069  | 0.0214576721  |  0.0004519551  | 0.0084741586 |
   *   |17  | 0.0004291534 |  0.0107288361  |  0.0002259776 | 0.0042370793 |
   *   |18    | 0.0002145767 | 0.005364418 | 0.0001129888 | 0.0021185396 |
   *   |19    | 0.0001072884  |  0.002682209  | 5.64944E-05 | 0.0010592698 |
   *   |20    |  5.36442E-05  | 0.0013411045 | 2.82472E-05  | 0.0005296349 |
   *
   * _Note_ : Either **center** or **bbox** parameter must be supplied to the API.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @route("/map/static")
  @get
  getMapStaticImage is MapsRenderOperation<
    {
      /**
       * Map style to be returned. Possible values are microsoft.base.road,
       * microsoft.base.darkgrey, and microsoft.imagery.  Default value is set to be
       * microsoft.base.road. For more information, see [Render
       * TilesetId](https://learn.microsoft.com/en-us/rest/api/maps/render/get-map-tileset?view=rest-maps-2023-06-01&tabs=HTTP#tilesetid).
       */
      @query("tilesetId")
      tilesetId?: Tileset;

      /**
       * Optional Value, indicating no traffic flow overlaid on the image result.
       * Possible values are microsoft.traffic.relative.main and none. Default value is
       * none, indicating no traffic flow returned. If traffic related tilesetId is
       * provided, will return map image with corresponding traffic layer. For more
       * information, see [Render
       * TilesetId](https://learn.microsoft.com/en-us/rest/api/maps/render/get-map-tileset?view=rest-maps-2023-06-01&tabs=HTTP#tilesetid).
       */
      @query("trafficLayer")
      trafficLayer?: TrafficTilesetId;

      /**
       * Desired zoom level of the map. Support zoom value range from 0-20 (inclusive)
       * for tilesetId being microsoft.base.road or microsoft.base.darkgrey. Support
       * zoom value range from 0-19 (inclusive) for tilesetId being microsoft.imagery.
       * Default value is 12.<br><br>For more information, see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid).
       */
      @maxValue(20)
      @query("zoom")
      zoom?: int32;

      /**
       * Coordinates of the center point in double. Format: 'lon,lat'. Longitude range:
       * -180 to 180. Latitude range: -90 to 90.
       *
       * Note: Either center or bbox are required parameters. They are
       * mutually exclusive.
       */
      @query("center")
      center?: float64[];

      /**
       * A bounding box is defined by two latitudes and two longitudes that represent
       * the four sides of a rectangular area on the Earth. Format : 'minLon, minLat,
       * maxLon, maxLat' (in double).
       *
       * Note: Either bbox or center are required
       * parameters. They are mutually exclusive. bbox shouldn’t be used with
       * height or width.
       *
       * The maximum and minimum allowed ranges for Lat and Lon are defined for each
       * zoom level
       * in the table at the top of this page.
       */
      @query("bbox")
      boundingBoxPrivate?: float64[];

      /**
       * Height of the resulting image in pixels. Range from 80 to 1500. Default
       * is 512. It shouldn’t be used with bbox.
       */
      @maxValue(1500)
      @minValue(80)
      @query("height")
      height?: int32;

      /**
       * Width of the resulting image in pixels. Range from 80 to 2000. Default is 512.
       * It should not be used with bbox.
       */
      @maxValue(2000)
      @minValue(80)
      @query("width")
      width?: int32;

      /**
       * Language in which search results should be returned. Should be one of supported
       * IETF language tags, case insensitive. When data in specified language is not
       * available for a specific field, default language is used.
       *
       * Please refer to [Supported
       * Languages](https://docs.microsoft.com/azure/azure-maps/supported-languages) for
       * details.
       */
      @query("language")
      language?: string;

      /**
       * The View parameter (also called the "user region" parameter) allows you to show
       * the correct maps for a certain country/region for geopolitically disputed
       * regions. Different countries/regions have different views of such regions, and
       * the View parameter allows your application to comply with the view required by
       * the country/region your application will be serving. By default, the View
       * parameter is set to “Unified” even if you haven’t defined it in  the request.
       * It is your responsibility to determine the location of your users, and then set
       * the View parameter correctly for that location. Alternatively, you have the
       * option to set ‘View=Auto’, which will return the map data based on the IP
       * address of the request. The View parameter in Azure Maps must be used in
       * compliance with applicable laws, including those  regarding mapping, of the
       * country/region where maps, images and other data and third party content that
       * you are authorized to  access via Azure Maps is made available. Example:
       * view=IN.
       *
       * Please refer to [Supported Views](https://aka.ms/AzureMapsLocalizationViews)
       * for details and to see the available Views.
       */
      @query("view")
      localizedMapView?: LocalizedMapView;

      /**
       * Pushpin style and instances. Use this parameter to optionally add pushpins to
       * the image.
       * The pushpin style describes the appearance of the pushpins, and the instances
       * specify
       * the coordinates of the pushpins (in double) and optional labels for each pin.
       * (Be sure to properly URL-encode values of this
       * parameter since it will contain reserved characters such as pipes and
       * punctuation.)
       *
       * The Azure Maps account S0 SKU only supports a single instance of the pins
       * parameter and the number of locations is limited to 5 per pin. Other SKUs
       * allow up to 25 instances of the pins parameter to specify multiple pin styles,
       * and the number of locations is limited to 50 per pin.
       *
       * To render a pushpin at latitude 45°N and longitude 122°W using the default
       * built-in pushpin style, add the
       * querystring parameter
       *
       * `pins=default||-122 45`
       *
       * Note that the longitude comes before the latitude.
       * After URL encoding this will look like
       *
       * `pins=default%7C%7C-122+45`
       *
       * All of the examples here show the pins
       * parameter without URL encoding, for clarity.
       *
       * To render a pin at multiple locations, separate each location with a pipe
       * character. For example, use
       *
       * `pins=default||-122 45|-119.5 43.2|-121.67 47.12`
       *
       * The S0 Azure Maps account SKU only allows five pushpins. Other account SKUs do
       * not have this limitation.
       *
       * ### Style Modifiers
       *
       * You can modify the appearance of the pins by adding style modifiers. These are
       * added after the style but before
       * the locations and labels. Style modifiers each have a two-letter name. These
       * abbreviated names are used to help
       * reduce the length of the URL.
       *
       * To change the color of the pushpin, use the 'co' style modifier and specify the
       * color using the HTML/CSS RGB color
       * format which is a six-digit hexadecimal number (the three-digit form is not
       * supported). For example, to use
       * a deep pink color which you would specify as #FF1493 in CSS, use
       *
       * `pins=default|coFF1493||-122 45`
       *
       * ### Pushpin Labels
       *
       * To add a label to the pins, put the label in single quotes just before the
       * coordinates. Avoid using special character such as `|` or `||` in label. For
       * example, to label
       * three pins with the values '1', '2', and '3', use
       *
       * `pins=default||'1'-122 45|'2'-119.5 43.2|'3'-121.67 47.12`
       *
       * There is a built-in pushpin style called 'none' that does not display a pushpin
       * image. You can use this if
       * you want to display labels without any pin image. For example,
       *
       * `pins=none||'A'-122 45|'B'-119.5 43.2`
       *
       * To change the color of the pushpin labels, use the 'lc' label color style
       * modifier. For example, to use pink
       * pushpins with black labels, use
       *
       * `pins=default|coFF1493|lc000000||-122 45`
       *
       * To change the size of the labels, use the 'ls' label size style modifier. The
       * label size represents the approximate
       * height of the label text in pixels. For example, to increase the label size to
       * 12, use
       *
       * `pins=default|ls12||'A'-122 45|'B'-119 43`
       *
       * The labels are centered at the pushpin 'label anchor.' The anchor location is
       * predefined for built-in pushpins and
       * is at the top center of custom pushpins (see below). To override the label
       * anchor, using the 'la' style modifier
       * and provide X and Y pixel coordinates for the anchor. These coordinates are
       * relative to the top left corner of the
       * pushpin image. Positive X values move the anchor to the right, and positive Y
       * values move the anchor down. For example,
       * to position the label anchor 10 pixels right and 4 pixels above the top left
       * corner of the pushpin image,
       * use
       *
       * `pins=default|la10 -4||'A'-122 45|'B'-119 43`
       *
       * ### Custom Pushpins
       *
       * To use a custom pushpin image, use the word 'custom' as the pin style name, and
       * then specify a URL after the
       * location and label information. The maximum allowed size for a customized label
       * image is 65,536 pixels. Use two pipe characters to indicate that you're done
       * specifying locations and are
       * starting the URL. For example,
       *
       * `pins=custom||-122 45||http://contoso.com/pushpins/red.png`
       *
       * After URL encoding, this would look like
       *
       * `pins=custom%7C%7C-122+45%7C%7Chttp%3A%2F%2Fcontoso.com%2Fpushpins%2Fred.png`
       *
       * By default, custom pushpin images are drawn centered at the pin coordinates.
       * This usually isn't ideal as it obscures
       * the location that you're trying to highlight. To override the anchor location
       * of the pin image, use the 'an'
       * style modifier. This uses the same format as the 'la' label anchor style
       * modifier. For example, if your custom
       * pin image has the tip of the pin at the top left corner of the image, you can
       * set the anchor to that spot by
       * using
       *
       * `pins=custom|an0 0||-122 45||http://contoso.com/pushpins/red.png`
       *
       * Note: If you use the 'co' color modifier with a custom pushpin image, the
       * specified color will replace the RGB
       * channels of the pixels in the image but will leave the alpha (opacity) channel
       * unchanged. This would usually
       * only be done with a solid-color custom image.
       *
       * ### Scale, Rotation, and Opacity
       *
       * You can make pushpins and their labels larger or smaller by using the 'sc'
       * scale style modifier. This is a
       * value greater than zero. A value of 1 is the standard scale. Values larger than
       * 1 will make the pins larger, and
       * values smaller than 1 will make them smaller. For example, to draw the pushpins
       * 50% larger than normal, use
       *
       * `pins=default|sc1.5||-122 45`
       *
       * You can rotate pushpins and their labels by using the 'ro' rotation style
       * modifier. This is a number of degrees
       * of clockwise rotation. Use a negative number to rotate counter-clockwise. For
       * example, to rotate the pushpins
       * 90 degrees clockwise and double their size, use
       *
       * `pins=default|ro90|sc2||-122 45`
       *
       * You can make pushpins and their labels partially transparent by specifying the
       * 'al' alpha style modifier.
       * This is a number between 0 and 1 indicating the opacity of the pushpins. Zero
       * makes them completely transparent
       * (and not visible) and 1 makes them completely opaque (which is the default).
       * For example, to make pushpins
       * and their labels only 67% opaque, use
       *
       * `pins=default|al.67||-122 45`
       *
       * ### Style Modifier Summary
       *
       * Modifier  | Description    | Type    | Range
       * :--------:|---------------|--------|----------
       * al        | Alpha (opacity) |  float | 0 to 1
       * an        | Pin anchor    | <int32, int32>  | *
       * co        | Pin color      | string | 000000 to FFFFFF
       * la        | Label anchor   | <int32, int32> | *
       * lc        | Label color   | string  | 000000 to FFFFFF
       * ls        | Label size      | float | Greater than 0
       * ro        | Rotation    | float    | -360 to 360
       * sc        | Scale         | float  | Greater than 0
       *
       * * X and Y coordinates can be anywhere within pin image or a margin around it.
       * The margin size is the minimum of the pin width and height.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Existing API contract."
      @query(#{ name: "pins", explode: true })
      pins?: string[];

      /**
       * Path style and locations (in double). Use this parameter to optionally add
       * lines, polygons or circles to the image.
       * The path style describes the appearance of the line and fill. (Be sure to
       * properly URL-encode values of this
       * parameter since it will contain reserved characters such as pipes and
       * punctuation.)
       *
       * Path parameter is supported in Azure Maps account SKU starting with S1.
       * Multiple instances of the path parameter
       * allow to specify multiple geometries with their styles. Number of parameters
       * per request is limited to 10 and
       * number of locations is limited to 100 per path.
       *
       * To render a circle with radius 100 meters and center point at latitude 45°N and
       * longitude 122°W using the default style, add the
       * querystring parameter
       *
       * `path=ra100||-122 45`
       *
       * Note that the longitude comes before the latitude.
       * After URL encoding this will look like
       *
       * `path=ra100%7C%7C-122+45`
       *
       * All of the examples here show the path parameter without URL encoding, for
       * clarity.
       *
       * To render a line, separate each location with a pipe character. For example,
       * use
       *
       * `path=||-122 45|-119.5 43.2|-121.67 47.12`
       *
       * A polygon is specified with a closed path, where the first and last points are
       * equal. For example, use
       *
       * `path=||-122 45|-119.5 43.2|-121.67 47.12|-122 45`
       *
       * Longitude value for locations of lines and polygons can be in the range from
       * -360 to 360 to allow for rendering of geometries crossing the anti-meridian.
       *
       * ### Style Modifiers
       *
       * You can modify the appearance of the path by adding style modifiers. These are
       * added before the locations.
       * Style modifiers each have a two-letter name. These abbreviated names are used
       * to help reduce the length
       * of the URL.
       *
       * To change the color of the outline, use the 'lc' style modifier and specify the
       * color using the HTML/CSS RGB color
       * format which is a six-digit hexadecimal number (the three-digit form is not
       * supported). For example, to use
       * a deep pink color which you would specify as #FF1493 in CSS, use
       *
       * `path=lcFF1493||-122 45|-119.5 43.2`
       *
       * Multiple style modifiers may be combined to create a more complex visual style.
       *
       * `lc0000FF|lw3|la0.60|fa0.50||-122.2 47.6|-122.2 47.7|-122.3 47.7|-122.3 47.6|-122.2 47.6`
       *
       * ### Style Modifier Summary
       *
       * Modifier  | Description       | Type     | Range
       * :--------:|---------------|--------|----------
       * lc        | Line color      | string       | 000000 to FFFFFF
       * fc        | Fill color        | string       | 000000 to FFFFFF
       * la    | Line alpha (opacity)     |  float     | 0 to 1
       * fa  | Fill alpha (opacity)   |     float       | 0 to 1
       * lw   | Line width     |int32        | (0, 50]
       * ra        | Circle radius (meters) |   float  | Greater than 0
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Existing API contract."
      @query(#{ name: "path", explode: true })
      path?: string[];

      /**
       * The Accept header field can be used to specify preferences regarding response
       * media types. Allowed media types include image/jpeg and image/png. Return image
       * in image/png if Accept header is not specified.
       */
      @header("Accept")
      accept?: MediaType;
    },
    {
      /**
       * The Content-Type header field indicates the media type of the resource. The
       * media type will be image/png or image/jpeg depending on the Accept header in
       * the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Specifying response content-types which are only allowed to be closed."
      @header("Content-Type")
      contentType: "image/png" | "image/jpeg";

      /**
       * This image is returned from a successful Get Map Static Image call.
       */
      @bodyRoot
      body?: bytes;
    }
  >;

  /**
   *
   *
   * Returns copyright information for a given bounding box. Bounding-box requests
   * should specify the minimum and maximum longitude and latitude (EPSG-3857)
   * coordinates
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get copyright information for the specified bounding box.")
  @route("/map/copyright/bounding/{format}")
  @get
  getCopyrightFromBoundingBox is MapsRenderOperation<
    {
      /**
       * Minimum coordinates (south-west point) of bounding box in latitude longitude
       * coordinate system. E.g. 52.41064,4.84228
       */
      @query("mincoordinates")
      southWest: float64[];

      /**
       * Maximum coordinates (north-east point) of bounding box in latitude longitude
       * coordinate system. E.g. 52.41064,4.84228
       */
      @query("maxcoordinates")
      northEast: float64[];

      /**
       * Desired format of the response. Value can be either _json_ or _xml_.
       */
      @path
      format: ResponseFormat;

      /**
       * Yes/no value to exclude textual data from response. Only images and
       * country/region names will be in response.
       */
      @query("text")
      includeText?: IncludeText;
    },
    Copyright
  >;

  /**
   *
   *
   * To obtain the copyright information for a particular tile, the request should
   * specify the tile's zoom level and x and y coordinates. For more information,
   * see [Zoom Levels and Tile Grid](/azure/azure-maps/zoom-levels-and-tile-grid).
   *
   * Copyrights API is designed to serve copyright information for Render service.
   * In addition to basic copyright for the whole map, API is serving specific
   * groups of copyrights for some countries/regions.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get copyright information.")
  @route("/map/copyright/tile/{format}")
  @get
  getCopyrightForTile is MapsRenderOperation<
    {
      /**
       * Zoom level for the desired tile.
       *
       * Please see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid)
       * for details.
       */
      @query("zoom")
      z: int32;

      /**
       * X coordinate of the tile on zoom grid. Value must be in the range [0,
       * 2<sup>`zoom`</sup> -1].
       *
       * Please see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid)
       * for details.
       */
      @query("x")
      x: int32;

      /**
       * Y coordinate of the tile on zoom grid. Value must be in the range [0,
       * 2<sup>`zoom`</sup> -1].
       *
       * Please see [Zoom Levels and Tile
       * Grid](https://docs.microsoft.com/azure/location-based-services/zoom-levels-and-tile-grid)
       * for details.
       */
      @query("y")
      y: int32;

      /**
       * Desired format of the response. Value can be either _json_ or _xml_.
       */
      @path
      format: ResponseFormat;

      /**
       * Yes/no value to exclude textual data from response. Only images and
       * country/region names will be in response.
       */
      @query("text")
      includeText?: IncludeText;
    },
    Copyright
  >;

  /**
   *
   *
   * Returns the copyright information for the world. To obtain the default
   * copyright information for the whole world, don't specify a tile or bounding
   * box.
   *
   * Copyrights API is designed to serve copyright information for Render service.
   * In addition to basic copyright for the whole map, API is serving specific
   * groups of copyrights for some countries/regions.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get copyright information for for the world.")
  @route("/map/copyright/world/{format}")
  @get
  getCopyrightForWorld is MapsRenderOperation<
    {
      /**
       * Desired format of the response. Value can be either _json_ or _xml_.
       */
      @path
      format: ResponseFormat;

      /**
       * Yes/no value to exclude textual data from response. Only images and
       * country/region names will be in response.
       */
      @query("text")
      includeText?: IncludeText;
    },
    Copyright
  >;
}
