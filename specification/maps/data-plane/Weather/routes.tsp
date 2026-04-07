import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace MapsWeather;

alias ResponseFormatParameters = {
  /**
   * Desired format of the response. Only `json` format is supported.
   */
  @path
  format: JsonFormat;
};

interface Weather {
  /**
   *
   *
   * The `Get Hourly Forecast` API is an HTTP `GET` that Request detailed weather
   * forecast by the hour for the next 1, 12, 24 (1 day), 72 (3 days), 120 (5 days),
   * and 240 hours (10 days) for the given the given coordinate location.  The API
   * returns details such as temperature, humidity, wind, precipitation, and
   * ultraviolet (UV) index. For more information, see [Request hourly weather
   * forecast
   * data](/azure/azure-maps/how-to-request-weather-data#request-hourly-weather-forecast-data).
   *
   * If you are using the Gen1 S0 pricing tier, you can request hourly forecast for
   * the next 1, 12, 24 hours (1 day), and 72 hours (3 days). If you are using Gen1
   * S1 or Gen2 pricing tier, you can also request hourly forecast for the next 120
   * (5 days) and 240 hours (10 days).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get a detailed hourly weather forecast for up to 24 hours or a daily
    forecast for up to 10 days.
    """)
  @route("/weather/forecast/hourly/{format}")
  @get
  getHourlyForecast is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Specifies to return the data in either metric units or imperial units. Default
       * value is metric.
       */
      @query("unit")
      unit?: WeatherDataUnit;

      /**
       * Time frame of the returned weather forecast. By default, the forecast data for
       * next hour will be returned. Available values are
       *   * `1` - Return forecast data for the next hour. Default value.
       *   * `12` - Return hourly forecast for next 12 hours.
       *   * `24` - Return hourly forecast for next 24 hours.
       *   * `72` - Return hourly forecast for next 72 hours (3 days).
       *   * `120` - Return hourly forecast for next 120 hours (5 days). Only available
       * in S1 SKU.
       *   * `240` - Return hourly forecast for next 240 hours (10 days). Only available
       * in S1 SKU.
       */
      @query("duration")
      duration?: int32;

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
    },
    HourlyForecastResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Minute Forecast` API is an HTTP `GET` request that returns
   * minute-by-minute forecasts for a given location for the next 120 minutes.
   * Users can request weather forecasts in intervals of 1, 5 and 15 minutes.  The
   * response will include details such as the type of precipitation (including
   * rain, snow, or a mixture of both), start time, and precipitation intensity
   * value (dBZ). For more information, see [Request minute-by-minute weather
   * forecast
   * data](/azure/azure-maps/how-to-request-weather-data#request-minute-by-minute-weather-forecast-data).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get a minute-by-minute forecast for the next 120 minutes in intervals of
    1, 5 and 15 minutes.
    """)
  @route("/weather/forecast/minute/{format}")
  @get
  getMinuteForecast is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Specifies time interval in minutes for the returned weather forecast. Supported
       * values are
       *   * `1` -  Retrieve forecast for 1-minute intervals. Returned by default.
       *   * `5` - Retrieve forecasts for 5-minute intervals.
       *   * `15` - Retrieve forecasts for 15-minute intervals.
       */
      @query("interval")
      interval?: int32;

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
    },
    MinuteForecastResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Quarter-Day Forecast` API is an HTTP `GET` request that returns a
   * detailed weather forecast by quarter-day for the next 1, 5, 10, or 15 days for
   * a given location. Response data is presented by quarters of the day - morning,
   * afternoon, evening, and overnight. Details such as temperature, humidity, wind,
   * precipitation, and UV index are returned.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get a Quarter-Day Forecast for the next 1, 5, 10, or 15 days.")
  @route("/weather/forecast/quarterDay/{format}")
  @get
  getQuarterDayForecast is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Specifies to return the data in either metric units or imperial units. Default
       * value is metric.
       */
      @query("unit")
      unit?: WeatherDataUnit;

      /**
       * Specifies for how many days the quester-day forecast responses are returned.
       * Supported values are:
       *   * `1` - Return forecast data for the next day. Returned by default.
       *   * `5` - Return forecast data for the next 5 days.
       *   * `10` - Return forecast data for next 10 days.
       *   * `15` - Return forecast data for the next 15 days.
       */
      @query("duration")
      duration?: int32;

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
    },
    QuarterDayForecastResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Current Conditions` API is an HTTP `GET` request that returns detailed
   * current weather conditions such as precipitation, temperature and wind for a
   * given coordinate location. Also, observations from the past 6 or 24 hours for a
   * particular location can be retrieved. The basic information returned with The
   * response includes details such as observation date and time, brief description
   * of the weather conditions, weather icon, precipitation indicator flags, and
   * temperature. Additional details such as RealFeel™ Temperature and UV index are
   * also returned. For more information, see [Request real-time weather
   * data](/azure/azure-maps/how-to-request-weather-data#request-real-time-weather-data)
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get current weather conditions.")
  @route("/weather/currentConditions/{format}")
  @get
  getCurrentConditions is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Specifies to return the data in either metric units or imperial units. Default
       * value is metric.
       */
      @query("unit")
      unit?: WeatherDataUnit;

      /**
       * Return full details for the current conditions. Available values are
       *   * `true` - Returns full details. By default all details are returned.
       *   * `false` - Returns a truncated version of the current condition data, which
       * includes observation date time, weather phrase, icon code, precipitation
       * indicator flag, and temperature.
       */
      @query("details")
      details?: string;

      /**
       * Time frame of the returned weather conditions. By default, the most current
       * weather conditions will be returned. Default value is 0. Supported values are:
       *    * `0` - Return the most current weather conditions.
       *    * `6` - Return weather conditions from past 6 hours.
       *    * `24` - Return weather conditions from past 24 hours.
       */
      @query("duration")
      duration?: int32;

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
    },
    CurrentConditionsResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Daily Forecast` API is an HTTP `GET` request that returns detailed
   * weather forecast such as temperature and wind by day for the next 1, 5, 10, 15,
   * 25, or 45 days for a given coordinate location.  The response includes details
   * such as temperature, wind, precipitation, air quality, and UV index. For more
   * information, see [Request daily weather forecast
   * data](/azure/azure-maps/how-to-request-weather-data#request-daily-weather-forecast-data).
   *
   *  If you are using the Gen1 S0 pricing tier, you can request daily forecast for
   * the next 1, 5, 10, and 15 days. If you are using Gen1 S1 or Gen2 pricing tier,
   * you can also request daily forecast for the next 25 days, and 45 days.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get a daily detailed weather forecast for the next 1, 5, 10, 15, 25, or
    45 days.
    """)
  @route("/weather/forecast/daily/{format}")
  @get
  getDailyForecast is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Specifies to return the data in either metric units or imperial units. Default
       * value is metric.
       */
      @query("unit")
      unit?: WeatherDataUnit;

      /**
       * Specifies for how many days the daily forecast responses are returned.
       * Available values are
       *   * `1` - Return forecast data for the next day. Returned by default.
       *   * `5` - Return forecast data for the next 5 days.
       *   * `10` - Return forecast data for the next 10 days.
       *   * `25` - Return forecast data for the next 25 days. Only available in S1 SKU.
       *   * `45` - Return forecast data for the next 45 days. Only available in S1 SKU.
       */
      @query("duration")
      duration?: int32;

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
    },
    DailyForecastResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Weather Along Route` API is an HTTP `GET` request that returns hyper
   * local (one kilometer or less), up-to-the-minute weather nowcasts, weather
   * hazard assessments, and notifications along a route described as a sequence of
   * waypoints.
   *  This includes a list of weather hazards affecting the waypoint or route, and
   * the aggregated hazard index for each waypoint might be used to paint each
   * portion of a route according to how safe it is for the driver. When submitting
   * the waypoints, it is recommended to stay within, or close to, the distance that
   * can be traveled within 120-mins or shortly after. Data is updated every five
   * minutes.
   *
   *  The service supplements Azure Maps [Route
   * Service](https://docs.microsoft.com/rest/api/maps/route) that allows you to
   * first request a route between an origin and a destination and use that as an
   * input for Weather Along Route endpoint.
   *
   *  In addition, the service supports scenarios to generate weather notifications
   * for waypoints that experience an increase in intensity of a weather hazard. For
   * example, if the vehicle is expected to begin experiencing heavy rain as it
   * reaches a waypoint, a weather notification for heavy rain will be generated for
   * that waypoint allowing the end product to display a heavy rain notification
   * before the driver reaches that waypoint.
   *  The trigger for when to display the notification for a waypoint could be
   * based, for example, on a
   * [geofence](https://docs.microsoft.com/azure/azure-maps/tutorial-iot-hub-maps),
   * or selectable distance to the waypoint.
   *
   *  The API covers all regions of the planet except latitudes above Greenland and
   * Antarctica.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get a locationally precise, up-to-the-minute forecast that includes
    weather hazard assessments and notifications along a route.
    """)
  @route("/weather/route/{format}")
  @get
  getWeatherAlongRoute is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * Coordinates through which the route is calculated, separated by colon (:) and
       * entered in chronological order. A minimum of two waypoints is required. A
       * single API call may contain up to 60 waypoints.
       * A waypoint indicates location, ETA, and optional heading:
       * latitude,longitude,ETA,heading, where
       *   * `Latitude` - Latitude coordinate in decimal degrees.
       *   * `Longitude` - Longitude coordinate in decimal degrees.
       *   * `ETA (estimated time of arrival)` - The number of minutes from the present
       * time that it will take for the vehicle to reach the waypoint. Allowed range is
       * from 0.0 to 120.0 minutes.
       *   * `Heading` - An optional value indicating the vehicle heading as it passes
       * the waypoint. Expressed in clockwise degrees relative to true north. This is
       * issued to calculate sun glare as a driving hazard. Allowed range is from 0.0 to
       * 360.0 degrees. If not provided, a heading will automatically be derived based
       * on the position of neighboring waypoints.
       *
       * It is recommended to stay within, or close to, the distance that can be
       * traveled within 120-mins or shortly after. This way a more accurate assessment
       * can be provided for the trip and prevent isolated events not being captured
       * between waypoints.  Information can and should be updated along the route
       * (especially for trips greater than 2 hours) to continuously pull new waypoints
       * moving forward, but also to ensure that forecast information for content such
       * as precipitation type and intensity is accurate as storms develop and dissipate
       * over time.
       */
      @query("query")
      query: string;

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
    },
    WeatherAlongRouteResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * Severe weather phenomenon can significantly impact our everyday life and
   * business operations. For example, severe weather conditions such as tropical
   * storms, high winds or flooding can close roads and force logistics companies to
   * reroute their fleet causing delays in reaching destinations and breaking the
   * cold chain of refrigerated food products.
   *
   *  The `Get Severe Weather Alerts` API is an HTTP `GET` request that returns the
   * severe weather alerts that are available worldwide from both official
   * Government Meteorological Agencies and leading global to regional weather alert
   * providers. The service can return details such as alert type, category, level
   * and detailed description about the active severe alerts for the requested
   * location, like hurricanes, thunderstorms, lightning, heat waves or forest
   * fires. For more information, see [Request severe weather
   * alerts](/azure/azure-maps/how-to-request-weather-data#request-severe-weather-alerts)
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get information about severe weather conditions such as hurricanes,
    thunderstorms, flooding, lightning, heat waves or forest fires for a given
    location.
    """)
  @route("/weather/severe/alerts/{format}")
  @get
  getSevereWeatherAlerts is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

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
       * Return full details for the severe weather alerts. Available values are
       *   * `true` - Returns full details. By default all details are returned.
       *   * `false` - Returns a truncated version of the alerts data, which excludes
       * the area-specific full description of alert details (`alertDetails`).
       */
      @query("details")
      details?: string;
    },
    SevereWeatherAlertsResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Daily Indices` API is an HTTP `GET` request returns index values that
   * provide guidance to help when planning future activities. For example, a health
   * mobile application can notify users that today is good weather for running or
   * for other outdoors activities like playing golf or flying a kite. Retail stores
   * can optimize their digital marketing campaigns based on predicted index values.
   * The service returns in daily indices values for current and next 5, 10 and 15
   * days starting from current day.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use when you want to know if the weather conditions are optimal for a specific
    activity such as outdoor sporting activities, construction, or farming (results
    includes soil moisture information).
    """)
  @route("/weather/indices/daily/{format}")
  @get
  getDailyIndices is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

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
       * Specifies for how many days the daily indices are returned. By default, the
       * indices data for the current day will be returned. When requesting future
       * indices data, the current day is included in the response as day 1. Available
       * values are
       *   * `1` - Return daily index data for the current day. Default value.
       *   * `5` - Return 5 days of daily index data starting from the current day.
       *   * `10` - Return 10 days of daily index data starting from the current day.
       *   * `15` - Return 15 days of daily index data starting from the current day.
       */
      @query("duration")
      duration?: int32;

      /**
       * Numeric index identifier that can be used for restricting returned results to
       * the corresponding index type. Cannot be paired with `indexGroupId`. Please
       * refer to [Weather services in Azure
       * Maps](/azure/azure-maps/weather-services-concepts#index-ids-and-index-groups-ids)
       * for details and to see the supported indices.
       */
      @query("indexId")
      indexId?: int32;

      /**
       * Numeric index group identifier that can be used for restricting returned
       * results to the corresponding subset of indices (index group). Cannot be paired
       * with `indexId`. Please refer to [Weather services in Azure
       * Maps](/azure/azure-maps/weather-services-concepts#index-ids-and-index-groups-ids)
       * for details and to see the supported index groups.
       */
      @query("indexGroupId")
      indexGroupId?: int32;
    },
    DailyIndicesResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Tropical Storm Active` API is an HTTP `GET` request that returns a
   * list of all government-issued active tropical storms. Information about the
   * tropical storms includes, government ID, basin ID, year of origin, name and if
   * it is subtropical.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get a list of the active tropical storms issued by national weather
    forecasting agencies.
    """)
  @route("/weather/tropical/storms/active/{format}")
  @get
  getTropicalStormActive is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
    },
    ActiveStormResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Tropical Storm Search` API is an HTTP `GET` request that returns a
   * list of government-issued tropical storms by year, basin ID, and government ID.
   * Information about the tropical storms includes, government ID, basin ID,
   * status, year, name and if it is subtropical.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get a list of storms issued by national weather forecasting agencies.")
  @route("/weather/tropical/storms/{format}")
  @get
  getTropicalStormSearch is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * Year of the cyclone(s)
       */
      @query("year")
      year: int32;

      /**
       * The `basinId` enum categorizes the different ocean basins where tropical storms
       * can originate. Each basin is assigned a unique identifier to help specify the
       * location of the storm's origin.
       */
      @query("basinId")
      basinId?: BasinId;

      /**
       * Government storm Id
       */
      @query("govId")
      governmentStormId?: int32;
    },
    StormSearchResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Tropical Storm Forecasts` API is an HTTP `GET` request that returns
   * individual government-issued tropical storm forecasts. Information about the
   * forecasted tropical storms includes, location, status, date the forecast was
   * created, window, wind speed and wind radii.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get a list of tropical storms forecasted by national weather forecasting
    agencies.
    """)
  @route("/weather/tropical/storms/forecasts/{format}")
  @get
  getTropicalStormForecast is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * Year of the cyclone(s)
       */
      @query("year")
      year: int32;

      /**
       * The `basinId` enum categorizes the different ocean basins where tropical storms
       * can originate. Each basin is assigned a unique identifier to help specify the
       * location of the storm's origin.
       */
      @query("basinId")
      basinId: BasinId;

      /**
       * Government storm Id
       */
      @query("govId")
      governmentStormId: int32;

      /**
       * Specifies to return the data in either metric units or imperial units. Default
       * value is metric.
       */
      @query("unit")
      unit?: WeatherDataUnit;

      /**
       * When true, wind radii summary data is included in the response
       */
      @query("details")
      includeDetails?: boolean;

      /**
       * When true, wind radii summary data and geoJSON details are included in the
       * response
       */
      @query("radiiGeometry")
      includeGeometricDetails?: boolean;

      /**
       * When true, window geometry data (geoJSON) is included in the response
       */
      @query("windowGeometry")
      includeWindowGeometry?: boolean;
    },
    StormForecastResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Tropical Storm Locations` API is an HTTP `GET` request that returns
   * the location of individual government-issued tropical storms. Information about
   * the tropical storms includes, location coordinates, geometry, basin ID, date,
   * wind details and wind radii.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get the location of tropical storms from individual national weather
    forecasting agencies.
    """)
  @route("/weather/tropical/storms/locations/{format}")
  @get
  getTropicalStormLocations is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * Year of the cyclone(s)
       */
      @query("year")
      year: int32;

      /**
       * The `basinId` enum categorizes the different ocean basins where tropical storms
       * can originate. Each basin is assigned a unique identifier to help specify the
       * location of the storm's origin.
       */
      @query("basinId")
      basinId: BasinId;

      /**
       * Government storm Id
       */
      @query("govId")
      governmentStormId: int32;

      /**
       * When true, wind radii summary data is included in the response
       */
      @query("details")
      includeDetails?: boolean;

      /**
       * When true, wind radii summary data and geoJSON details are included in the
       * response
       */
      @query("radiiGeometry")
      includeGeometricDetails?: boolean;

      /**
       * Specifies to return the data in either metric units or imperial units. Default
       * value is metric.
       */
      @query("unit")
      unit?: WeatherDataUnit;

      /**
       * When true, return the current storm location
       */
      @query("current")
      includeCurrentStorm?: boolean;
    },
    StormLocationsResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Current Air Quality` API is an HTTP `GET` request that returns
   * detailed information about the concentration of pollutants and overall status
   * for current air quality, including pollution levels, air quality index values,
   * the dominant pollutant, and a brief statement summarizing risk level and
   * suggested precautions.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get current air quality information that includes potential risks and
    suggested precautions.
    """)
  @route("/weather/airQuality/current/{format}")
  @get
  getCurrentAirQuality is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Boolean value that returns detailed information about each pollutant. By
       * default is True.
       */
      @query("pollutants")
      includePollutantDetails?: boolean;
    },
    AirQualityResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Air Quality Daily Forecasts` API is an HTTP `GET` request that returns
   * detailed information about the concentration of pollutants and overall status
   * of forecasted daily air quality. The service can provide forecasted daily air
   * quality information for the upcoming 1 to 7 days, including pollution levels,
   * air quality index values, the dominant pollutant, and a brief statement
   * summarizing risk level and suggested precautions.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get daily air quality forecasts for the next one to seven days that
    include pollutant levels, potential risks and suggested precautions.
    """)
  @route("/weather/airQuality/forecasts/daily/{format}")
  @get
  getAirQualityDailyForecasts is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Defines the duration for the air quality forecast, with options ranging from 1
       * to 7 days. The default duration is 1 day.
       */
      @query("duration")
      duration?: DailyDuration;
    },
    DailyAirQualityForecastResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Air Quality Hourly Forecasts` API is an HTTP `GET` request that
   * returns detailed information about the concentration of pollutants and overall
   * status for forecasted upcoming hourly air quality. The service can provide
   * forecasted hourly air quality information for the upcoming time spans of 1, 12,
   * 24, 48, 72, and 96 hours, including pollution levels, air quality index values,
   * the dominant pollutant, and a brief statement summarizing risk level and
   * suggested precautions.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get hourly air quality forecasts for the next one to 96 hours that
    include pollutant levels, potential risks and suggested precautions.
    """)
  @route("/weather/airQuality/forecasts/hourly/{format}")
  @get
  getAirQualityHourlyForecasts is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Defines the duration, in hours, for the air quality forecast. Available values
       * are 1, 12, 24, 48, 72, and 96. The default value is 1 hour.
       */
      @query("duration")
      duration?: HourlyDuration;

      /**
       * Boolean value that returns detailed information about each pollutant. By
       * default is True.
       */
      @query("pollutants")
      includePollutantDetails?: boolean;
    },
    AirQualityResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Daily Historical Actuals` API is an HTTP `GET` request that returns
   * climatology data such as past daily actual observed temperatures,
   * precipitation, snowfall, snow depth and cooling/heating degree day information,
   * for the day at a given coordinate location. The data is requested for a
   * specified date range, up to 31 days in a single API request. Generally,
   * historical data may be available as far back as the last 5 to 40+ years,
   * depending on the location.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get climatology data such as past daily actual observed temperatures,
    precipitation, snowfall and snow depth.
    """)
  @route("/weather/historical/actuals/daily/{format}")
  @get
  getDailyHistoricalActuals is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Start date in [ISO
       * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, for
       * example, 2019-10-27. The date range supported is 1 to 31 calendar days, so be
       * sure to specify a startDate and endDate that does not exceed a maximum of 31
       * days (i.e.: startDate=2012-01-01&endDate=2012-01-31).
       */
      @query("startDate")
      startDate: plainDate;

      /**
       * End date in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html)
       * format, for example, 2019-10-28. The date range supported is 1 to 31 calendar
       * days, so be sure to specify a startDate and endDate that does not exceed a
       * maximum of 31 days (i.e.: startDate=2012-01-01&endDate=2012-01-31).
       */
      @query("endDate")
      endDate: plainDate;

      /**
       * Specifies to return the data in either metric units or imperial units. Default
       * value is metric.
       */
      @query("unit")
      unit?: WeatherDataUnit;
    },
    DailyHistoricalActualsResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Daily Historical Records` API is an HTTP `GET` request that returns
   * climatology data such as past daily record temperatures, precipitation and
   * snowfall at a given coordinate location. Availability of records data will vary
   * by location. Generally, historical data may be available as far back as the
   * last 5 to 40+ years, depending on the location.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get climatology data such as past daily record temperatures,
    precipitation and snowfall at a given location.
    """)
  @route("/weather/historical/records/daily/{format}")
  @get
  getDailyHistoricalRecords is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Start date in [ISO
       * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, for
       * example, 2019-10-27. The date range supported is 1 to 31 calendar days, so be
       * sure to specify a startDate and endDate that does not exceed a maximum of 31
       * days (i.e.: startDate=2012-01-01&endDate=2012-01-31).
       */
      @query("startDate")
      startDate: plainDate;

      /**
       * End date in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html)
       * format, for example, 2019-10-28. The date range supported is 1 to 31 calendar
       * days, so be sure to specify a startDate and endDate that does not exceed a
       * maximum of 31 days (i.e.: startDate=2012-01-01&endDate=2012-01-31).
       */
      @query("endDate")
      endDate: plainDate;

      /**
       * Specifies to return the data in either metric units or imperial units. Default
       * value is metric.
       */
      @query("unit")
      unit?: WeatherDataUnit;
    },
    DailyHistoricalRecordsResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Daily Historical Normals` API is an HTTP `GET` request that returns
   * climatology data such as past daily normal temperatures, precipitation and
   * cooling/heating degree day information for the day at a given coordinate
   * location. The historical normals are a 30-year average for temperatures and
   * precipitation for a specific location. As is standard practice in climatology,
   * the 30-year average covers years 1991-2020, this data will be used for one
   * decade and then will reset in the year 2030. Generally, historical data may be
   * available as far back as the last 5 to 40+ years, depending on the location.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get climatology data such as past daily normal temperatures,
    precipitation and cooling/heating degree day information for a given location.
    """)
  @route("/weather/historical/normals/daily/{format}")
  @get
  getDailyHistoricalNormals is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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

      /**
       * The applicable query specified as a comma separated string composed by latitude
       * followed by longitude e.g. "47.641268,-122.125679".
       *
       * Weather information is generally available for locations on land, bodies of
       * water surrounded by land, and areas of the ocean that are within approximately
       * 50 nautical miles of a coastline.
       */
      @query("query")
      coordinates: float64[];

      /**
       * Start date in [ISO
       * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, for
       * example, 2019-10-27. The date range supported is 1 to 31 calendar days, so be
       * sure to specify a startDate and endDate that does not exceed a maximum of 31
       * days (i.e.: startDate=2012-01-01&endDate=2012-01-31).
       */
      @query("startDate")
      startDate: plainDate;

      /**
       * End date in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html)
       * format, for example, 2019-10-28. The date range supported is 1 to 31 calendar
       * days, so be sure to specify a startDate and endDate that does not exceed a
       * maximum of 31 days (i.e.: startDate=2012-01-01&endDate=2012-01-31).
       */
      @query("endDate")
      endDate: plainDate;

      /**
       * Specifies to return the data in either metric units or imperial units. Default
       * value is metric.
       */
      @query("unit")
      unit?: WeatherDataUnit;
    },
    DailyHistoricalNormalsResult,
    {},
    ErrorResponse
  >;
}
