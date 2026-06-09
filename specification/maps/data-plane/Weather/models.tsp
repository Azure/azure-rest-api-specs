import "@typespec/rest";
import "@typespec/http";
import "./common/common.tsp";

namespace MapsWeather;

/**
 * Specifies whether to return data in metric or imperial units, with metric as
 * the default. For example:
 *
 * - Metric: millimeter (mm), meter (m), kilometer (km), Celsius (C)
 * - Imperial: inch (in), foot (ft), mile (mi), Fahrenheit (F)
 */
union WeatherDataUnit {
  string,

  /**
   * Return data using imperial units such as Fahrenheit (F) for temperature and
   * miles (mi) for distance.
   */
  imperial: "imperial",

  /**
   * Return data using metric units such as Celsius (C) for temperature and
   * kilometer (km) for distance.
   */
  metric: "metric",
}

/**
 * The numeric weather-condition code that identifies which icon to display.
 * Each value in this enumeration corresponds to an Azure Maps weather icon
 * (such as Sunny, Cloudy, or Thunderstorms) and pairs with a human-readable
 * `iconPhrase` returned alongside it. The same code can appear in current,
 * hourly, daily, quarter-day, and minute-by-minute responses, allowing
 * applications to render a consistent icon set across all weather services.
 *
 * For the complete list of codes, the icons they map to, and example
 * imagery, see [Weather services in Azure
 * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
 */
union IconCode {
  integer,

  /** Sunny */
  Sunny: 1,

  /** Mostly Sunny */
  MostlySunny: 2,

  /** Partly Sunny */
  PartlySunny: 3,

  /** Intermittent Clouds */
  IntermittentClouds: 4,

  /** Hazy Sunshine */
  HazySunshine: 5,

  /** Mostly Cloudy */
  MostlyCloudy: 6,

  /** Cloudy */
  Cloudy: 7,

  /** Dreary (Overcast) */
  Dreary: 8,

  /** Fog */
  Fog: 11,

  /** Showers */
  Showers: 12,

  /** Mostly Cloudy with Showers */
  MostlyCloudyWithShowers: 13,

  /** Partly Sunny with Showers */
  PartlySunnyWithShowers: 14,

  /** Thunderstorms */
  Thunderstorms: 15,

  /** Mostly Cloudy with Thunderstorms */
  MostlyCloudyWithThunderstorms: 16,

  /** Partly Sunny with Thunderstorms */
  PartlySunnyWithThunderstorms: 17,

  /** Rain */
  Rain: 18,

  /** Flurries */
  Flurries: 19,

  /** Mostly Cloudy with Flurries */
  MostlyCloudyWithFlurries: 20,

  /** Partly Sunny with Flurries */
  PartlySunnyWithFlurries: 21,

  /** Snow */
  Snow: 22,

  /** Mostly Cloudy with Snow */
  MostlyCloudyWithSnow: 23,

  /** Ice */
  Ice: 24,

  /** Sleet */
  Sleet: 25,

  /** Freezing Rain */
  FreezingRain: 26,

  /** Rain and Snow */
  RainAndSnow: 29,

  /** Hot */
  Hot: 30,

  /** Cold */
  Cold: 31,

  /** Windy */
  Windy: 32,

  /** Clear */
  Clear: 33,

  /** Mostly Clear */
  `Mostly Clear`: 34,

  /** Partly Cloudy */
  `Partly Cloudy`: 35,

  /** Intermittent Clouds */
  IntermittentCloudsNight: 36,

  /** Hazy Moonlight */
  HazyMoonlight: 37,

  /** Mostly Cloudy */
  MostlyCloudyNight: 38,

  /** Partly Cloudy with Showers */
  PartlyCloudyWithShowers: 39,

  /** Mostly Cloudy with Showers */
  MostlyCloudyWithShowersNight: 40,

  /** Partly Cloudy with Thunderstorms */
  `Partly Cloudy with Thunderstorms`: 41,

  /** Mostly Cloudy with Thunderstorms */
  MostlyCloudyWithThunderstormsNight: 42,

  /** Mostly Cloudy with Flurries */
  MostlyCloudyWithFlurriesNight: 43,

  /** Mostly Cloudy with Snow */
  MostlyCloudyWithSnowNight: 44,
}

/**
 * An integer value associated with the type of unit being displayed.
 * For example, 17 for Celsius, 18 for Fahrenheit. Can be used for unit
 * translation. For more information, see [Weather services in
 * Azure Maps](/azure/azure-maps/weather-services-concepts#unit-types).
 */
union UnitType {
  integer,

  /**
   * feet
   */
  Feet: 0,

  /**
   * inches
   */
  Inches: 1,

  /**
   * miles
   */
  Miles: 2,

  /**
   * millimeter
   */
  Millimeter: 3,

  /**
   * centimeter
   */
  Centimeter: 4,

  /**
   * meter
   */
  Meter: 5,

  /**
   * kilometer
   */
  Kilometer: 6,

  /**
   * kilometersPerHour
   */
  KilometersPerHour: 7,

  /**
   * knots
   */
  Knots: 8,

  /**
   * milesPerHour
   */
  MilesPerHour: 9,

  /**
   * metersPerSecond
   */
  MetersPerSecond: 10,

  /**
   * hectoPascals
   */
  HectoPascals: 11,

  /**
   * inchesOfMercury
   */
  InchesOfMercury: 12,

  /**
   * kiloPascals
   */
  KiloPascals: 13,

  /**
   * millibars
   */
  Millibars: 14,

  /**
   * millimetersOfMercury
   */
  MillimetersOfMercury: 15,

  /**
   * poundsPerSquareInch
   */
  PoundsPerSquareInch: 16,

  /**
   * Celsius
   */
  Celsius: 17,

  /**
   * Fahrenheit
   */
  Fahrenheit: 18,

  /**
   * kelvin
   */
  Kelvin: 19,

  /**
   * percent
   */
  Percent: 20,

  /**
   * float
   */
  Float: 21,

  /**
   * integer
   */
  Integer: 22,

  /**
   * MicrogramsPerCubicMeterOfAir
   */
  MicrogramsPerCubicMeterOfAir: 31,
}

/**
 * Specifies the type of precipitation. Valid values are *Rain*, *Snow*, *Ice*, or
 * *Mix*. This property is included in the response when dBZ is greater than zero.
 */
union PrecipitationType {
  string,

  /** Ice */
  Ice: "Ice",

  /** Mix */
  Mix: "Mix",

  /** Rain */
  Rain: "Rain",

  /** Snow */
  Snow: "Snow",
}

/**
 * Divides the day into four 6-hour quarters. Valid values are 0-3:
 *
 * - 0: Morning (7am - 1pm)
 * - 1: Afternoon (1pm - 7pm)
 * - 2: Evening (7pm - 1am)
 * - 3: Overnight (1am - 7am)
 */
union DayQuarter {
  integer,

  /** 7:00 am - 1:00 pm / 07:00 - 13:00 */
  FirstQuarter: 0,

  /** 1:00 pm - 7:00 pm / 13:00 - 19:00 */
  SecondQuarter: 1,

  /** 7:00 pm - 1:00 am / 19:00 - 01:00 */
  ThirdQuarter: 2,

  /** 1:00 am - 7:00 am / 01:00 - 07:00 */
  ForthQuarter: 3,
}

/**
 * The aggregated severity/hazard index for each waypoint can be utilized to
 * color-code segments of a route, indicating the safety level for drivers.
 *
 * - **0**: No hazard
 * - **1**: Be informed, be aware
 * - **2**: Pay attention, be prepared
 * - **3**: Take action
 * - **4**: Life-threatening, emergency
 */
union HazardIndex {
  integer,

  /** No hazard */
  NoHazard: 0,

  /** Be informed */
  Informed: 1,

  /** Pay attention */
  PayAttention: 2,

  /** Take action */
  TakeAction: 3,

  /** Emergency */
  Emergency: 4,
}

/**
 * A predefined list of eight keywords used to describe the current status of a
 * severe weather alert.
 */
union LatestStatusKeyword {
  string,

  /** Indicates that the alert has been canceled before its scheduled expiration time. */
  Cancel: "Cancel",

  /**
   * Indicates that the alert has been updated since its initial issuance, but
   * no changes were made to `alertDetails`, `startTime`, `endTime`, or `class`.
   */
  Continue: "Continue",

  /** Indicates that the alert has been modified to correct a previous error. */
  Correct: "Correct",

  /** Indicates that the alert has expired and is no longer active. */
  Expire: "Expire",

  /**
   * Indicates that the alert has been extended in duration, area, or both since
   * its initial issuance.
   */
  Extend: "Extend",

  /** The status of an alert when first issued. */
  New: "New",

  /** Indicates that the alert has been modified since its initial issuance. */
  Update: "Update",

  /**
   * Indicates that the alert has been elevated to a higher class or category
   * since first issued.
   */
  Upgrade: "Upgrade",
}

/**
 * The `basinId` enum categorizes the different ocean basins where tropical
 * storms can originate. Each basin is assigned a unique identifier to help
 * specify the location of the storm's origin.
 */
union BasinId {
  string,

  /**
   * **The Atlantic Ocean**. Crucial for tracking hurricanes that affect the
   * Americas and the Caribbean. It is one of the most active regions for
   * tropical storms.
   */
  AL: "AL",

  /**
   * **The Central Pacific Ocean**. This basin is used for storms affecting Hawaii
   * and surrounding areas.
   */
  CP: "CP",

  /**
   * **The Eastern Pacific Ocean**. This basin tracks storms impacting the western
   * coast of the Americas, including Mexico and Central America. It is adjacent
   * to the Central Pacific basin.
   */
  EP: "EP",

  /**
   * **The North Indian Ocean**. This basin covers storms impacting South Asia,
   * including countries like India and Bangladesh, which are frequently
   * affected by cyclones.
   */
  NI: "NI",

  /**
   * **The Northwest Pacific Ocean**. This basin is important for tracking typhoons
   * that affect East Asia, including countries like China, Japan, and the
   * Philippines. It is the most active tropical storm regions globally.
   */
  NP: "NP",

  /**
   * **The South Indian Ocean**. This basin, positioned south of the equator, covers
   * cyclones impacting Madagascar, Africa, and surrounding regions.
   */
  SI: "SI",

  /**
   * **The South Pacific Ocean**. This basin, positioned south of the equator, is
   * relevant for cyclones affecting Australia and the South Pacific islands.
   */
  SP: "SP",
}

/** Identifies the pollutant with the highest concentration. */
union DominantPollutant {
  string,

  /**
   * Carbon monoxide (**CO**) is a colorless, odorless, and tasteless but highly
   * toxic gas produced by the incomplete combustion of carbon-containing fuels.
   * Common sources include vehicle exhaust, gas stoves, furnaces, and wood
   * fires.
   */
  `Carbon Monoxide`: "Carbon Monoxide",

  /**
   * Nitrogen dioxide (**NO2**) is a significant atmospheric pollutant. It is
   * regulated and subject to recommended limit guidelines set by the World
   * Health Organization (WHO).
   */
  `Nitrogen Dioxide`: "Nitrogen Dioxide",

  /**
   * Ozone (**O3**) is a key component of photochemical smog, the brown, harmful
   * haze that envelops many large cities, resulting from a photochemical
   * reaction between sunlight and certain specific pollutants.
   */
  Ozone: "Ozone",

  /**
   * Particulate matter 2.5 (**PM2.5**) refers to fine particles with diameters that
   * are generally 2.5 micrometers and smaller. These particles are more than 100 times
   * thinner than a human hair and can remain suspended in the air for extended periods.
   */
  `Particulate Matter 2.5`: "Particulate Matter 2.5",

  /**
   * Particulate matter 10 (**PM10**) refers to particles with diameters that are generally 10
   * micrometers and smaller. These particles can include dust, pollen, soot, smoke, and liquid droplets.
   */
  `Particulate Matter 10`: "Particulate Matter 10",

  /**
   * Sulfur dioxide (**SO2**) is a heavy, colorless inorganic gas with a pungent,
   * irritating odor. It is mainly produced by burning fossil fuels at power
   * plants and industrial facilities, but it can also be emitted from natural
   * sources such as volcanoes.
   */
  `Sulfur Dioxide`: "Sulfur Dioxide",
}

/** A description for the six types of pollutants tracked by the Azure Maps Weather service. */
union PollutantType {
  string,

  /**
   * The average concentration of carbon monoxide (CO) in micrograms per cubic
   * meter (µg/m³) over the past hour.
   *
   * CO is a colorless, odorless, and tasteless but highly toxic gas produced by
   * the incomplete combustion of carbon-containing fuels. Common sources
   * include vehicle exhaust, gas stoves, furnaces, and wood fires.
   */
  CO: "CO",

  /**
   * The average concentration of nitrogen dioxide (NO2) in micrograms per cubic
   * meter (µg/m³) over the past hour.
   *
   * NO2 is a significant atmospheric pollutant. It is regulated and subject to
   * recommended limit guidelines set by the World Health Organization (WHO).
   */
  NO2: "NO2",

  /**
   * The average concentration of Ozone (O3) in micrograms per cubic meter
   * (µg/m³) over the past hour.
   *
   * O3 is a key component of photochemical smog, the brown, harmful haze that
   * envelops many large cities, resulting from a photochemical reaction between
   * sunlight and specific pollutants.
   */
  O3: "O3",

  /**
   * The average concentration of particles smaller than 2.5 microns in
   * diameter, measured in micrograms per cubic meter (µg/m³), over the past
   * hour.
   *
   * PM2.5, also known as aerosols, consists of fine dust and tiny liquid
   * droplets suspended in the air.
   */
  PM2_5: "PM2.5",

  /**
   * The average concentration of particles with diameters between 2.5 and 10
   * microns, measured in micrograms per cubic meter (µg/m³) over the past hour.
   *
   * Particulate matter 10 (PM10), also known as aerosols, consists of fine dust
   * and tiny liquid droplets suspended in the air.
   */
  PM10: "PM10",

  /**
   * The average concentration of Sulfur dioxide (SO2) in micrograms per cubic
   * meter (µg/m³) over the past hour.
   *
   * SO2 is a dense, colorless inorganic gas with a pungent, irritating odor. It
   * is primarily produced by the combustion of fossil fuels at power plants and
   * industrial facilities, but it can also be emitted from natural sources such
   * as volcanoes.
   */
  SO2: "SO2",
}

/**
 * Defines the duration for the air quality forecast, with options ranging from
 * 1 to 7 days. The default duration is 1 day.
 */
union DailyDuration {
  integer,

  /** 1 day */
  OneDay: 1,

  /** 2 days */
  TwoDays: 2,

  /** 3 days */
  ThreeDays: 3,

  /** 4 days */
  FourDays: 4,

  /** 5 days */
  FiveDays: 5,

  /** 6 days */
  SixDays: 6,

  /** 7 days */
  SevenDays: 7,
}

/** Duration in hours for which the forecast is requested. */
union HourlyDuration {
  integer,

  /**
   * 1 Hour
   */
  OneHour: 1,

  /**
   * 12 Hours
   */
  TwelveHours: 12,

  /**
   * 24 Hours
   */
  TwentyFourHours: 24,

  /**
   * 48 Hours
   */
  FortyEightHours: 48,

  /**
   * 72 Hours
   */
  SeventyTwoHours: 72,

  /**
   * 96 Hours
   */
  NinetySixHours: 96,
}

/**
 * The response returned by the Get Hourly Forecast operation, containing
 * hour-by-hour weather forecasts for a specified location. The number of
 * `HourlyForecast` entries returned matches the requested forecast
 * duration - one of *1*, *12*, *24*, *48*, *72*, or *96* hours (see the
 * `HourlyDuration` union).
 */
model HourlyForecastResult {
  /**
   * The hour-by-hour forecast entries, one per hour in the requested
   * window, in chronological order. Each entry carries the expected
   * temperature, RealFeel, dew point, wind, precipitation outlook
   * (probability and amounts for rain, snow, and ice), cloud cover,
   * visibility, UV index, ceiling, and other observations for that hour.
   * For example, a duration of *12* returns 12 entries beginning
   * *2019-11-14T16:00:00-08:00* and stepping forward one hour at a time.
   */
  @visibility(Lifecycle.Read)
  forecasts?: HourlyForecast[];
}

/**
 * The `HourlyForecast` object provides hourly weather details, including date and
 * time, expected and perceived temperatures, and dew point. It covers wind
 * speed and direction, wind gusts, relative humidity, visibility, and
 * precipitation probability. It indicates if precipitation is expected and
 * specifies its type. Additional properties include UV index, cloud cover
 * percentage, and cloud ceiling height. It also features an icon code and
 * phrase describing the weather condition.
 */
model HourlyForecast {
  /**
   * Date and time of the forecast in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss±hh:mm). For example, *2019-11-14T16:00:00-08:00*.
   */
  date?: utcDateTime;

  /**
   * A numeric value that corresponds to an image displaying the `iconPhrase`.
   * For more information, see [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * A descriptive term that corresponds to a specific weather condition, such
   * as *Sunny*. It is paired with an `iconCode`, which is a numeric value
   * representing an image that visually depicts the weather condition described
   * by the `iconPhrase`. For more information, see [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconPhrase?: string;

  /**
   * A boolean value that indicates whether precipitation (rain, snow, sleet, or
   * hail) is expected during the specified timeframe. Returns true if
   * precipitation is expected, otherwise false.
   */
  hasPrecipitation?: boolean;

  /**
   * A boolean value that indicates whether it is daylight during the specified
   * hour. Returns true if it is daylight, otherwise false.
   */
  isDaylight?: boolean;

  /**
   * The expected temperature for the specified hour, measured in degrees
   * Celsius (°C) or Fahrenheit (°F), depending on the unit specified in the
   * request.
   */
  temperature?: WeatherValue;

  /**
   * Provides RealFeel™ Temperature values for the specified hour, measured in
   * degrees Celsius (°C) or Fahrenheit (°F), depending on the unit specified in
   * the request. This metric, developed by AccuWeather, incorporates over a
   * dozen factors, including humidity, wind speed, cloud cover, and sun
   * intensity, to offer a comprehensive measure of how the weather actually
   * feels.
   *
   * For more information, see [What is the AccuWeather RealFeel
   * Temperature?](https://www.accuweather.com/en/weather-news/what-is-the-accuweather-realfeel-temperature/156655)
   */
  realFeelTemperature?: WeatherValue;

  /**
   * Returns the temperature a parcel of air would have if it were cooled to
   * saturation (100% relative humidity) by the evaporation of water into it.
   * This property is important for understanding heat stress and the cooling
   * effect of evaporation.
   */
  wetBulbTemperature?: WeatherValue;

  /**
   * The temperature at which air becomes saturated with moisture and dew begins
   * to form. It is measured in degrees Fahrenheit (°F) or Celsius (°C), depending
   * on the unit specified. This value is crucial for understanding humidity
   * levels, as a higher dew point indicates more moisture in the air, making it
   * feel more humid.
   */
  dewPoint?: WeatherValue;

  /**
   * Provides the expected wind speed and direction. Wind speed is measured in
   * kilometers per hour (km/h) or miles per hour (mph), based on the specified
   * unit. Wind direction is measured in azimuth degrees, ranging from 0° (true
   * North) to 359°, moving clockwise (east is 90°, south is 180°, west is
   * 270°).
   */
  wind?: WindDetails;

  /**
   * Returns the expected maximum wind gust speed during each hour of the
   * forecast period, measured in kilometers per hour (km/h) or miles per hour
   * (mph), based on the specified unit. Wind direction is given in azimuth
   * degrees, ranging from 0° (true North) to 359°, moving clockwise. Wind gusts
   * are brief increases in wind speed, important for understanding short-term
   * variations that can impact activities like aviation, sailing, and outdoor
   * events.
   */
  windGust?: WindDetails;

  /**
   * The amount of water vapor present in the air, expressed as a percentage of
   * the maximum amount the air can hold at the same temperature. This value
   * indicates how close the air is to being saturated with moisture, affecting
   * how comfortable or humid the environment feels.
   */
  relativeHumidity?: int32;

  /**
   * Returns the distance at which an object or light can be clearly discerned
   * for each hour of the forecast period, measured in kilometers (km) or miles
   * (mi), depending on the unit specified in the request. This indicates how
   * far one can clearly see, which is crucial for activities like driving and
   * aviation.
   */
  visibility?: WeatherValue;

  /**
   * The height of the lowest layer of clouds above the ground, measured in feet
   * or meters based on the unit specified in the request. This measurement is
   * crucial for aviation and weather forecasting.
   */
  ceiling?: WeatherValue;

  /**
   * Provides the ultraviolet (UV) index for each hour of the forecast period.
   * This index indicates the level of ultraviolet radiation expected, helping
   * users understand the potential risk of sun exposure during different times
   * of the day. Supported values are:
   *
   * - 0-2: Low danger from the sun's UV rays or the average person.
   * - 3-5: Moderate risk of harm from unprotected sun exposure.
   * - 6-7: High risk of harm from unprotected sun exposure.
   * - 8-10: Very high risk of harm from unprotected sun exposure.
   * - 11+: Extreme risk of harm from unprotected sun exposure.
   */
  uvIndex?: int32;

  /**
   * Provides a descriptive phrase that indicates the level of UV radiation,
   * such as Low, Moderate, High, or Very High.
   */
  uvIndexPhrase?: string;

  /**
   * Shows the probability of precipitation during the specified hour, expressed
   * as a percentage from 0 to 100. A value of 0 means no chance of
   * precipitation, while 100 means precipitation is certain. This helps users
   * assess the likelihood of rain, snow, or other forms of precipitation.
   */
  precipitationProbability?: int32;

  /**
   * Shows the probability of rain during the specified timeframe, expressed as
   * a percentage from 0 to 100. A value of 0 means no chance of rain, while 100
   * means rain is certain.
   */
  rainProbability?: int32;

  /**
   * Shows the probability of snow during the specified hour, expressed as a
   * percentage from 0 to 100. A value of 0 means no chance of snow, while 100
   * means snow is certain.
   */
  snowProbability?: int32;

  /**
   * Shows the probability of ice formation during the specified hour, expressed
   * as a percentage from 0 to 100. A value of 0 means no chance of ice
   * formation, while 100 means ice formation is certain. This information helps
   * users evaluate the potential for icy conditions.
   */
  iceProbability?: int32;

  /**
   * Returns the total amount of liquid precipitation (such as rain) expected
   * during each hour of the forecast period, measured in millimeters (mm) or
   * inches (in), depending on the unit specified in the request.
   */
  totalLiquid?: WeatherValue;

  /**
   * Returns the amount of rainfall expected during each hour in the forecast,
   * measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  rain?: WeatherValue;

  /**
   * Returns the amount of snow accumulation expected during the specified hour,
   * measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  snow?: WeatherValue;

  /**
   * Returns estimated ice accumulation for each hour in the forecast, measured
   * in millimeters (mm) or inches (in), depending on the unit specified in the
   * request.
   */
  ice?: WeatherValue;

  /**
   * The percentage of the sky covered by clouds at the specified hour. This
   * value ranges from 0% (clear skies) to 100% (completely overcast). May be
   * NULL.
   */
  cloudCover?: int32;
}

/**
 * Values for weather-related metrics such as temperature, dew point, and wind
 * speed, presented in either metric or imperial units, as specified in the unit
 * URI parameter. For more information, see [Unit
 * types](/azure/azure-maps/weather-services-concepts#unit-types) in the article
 * Weather services in Azure Maps.
 */
model WeatherValue {
  /** The measured value expressed in the specified unit. */
  value?: float32;

  /**
   * The unit of measurement used in the return value, such as "C" for Celsius,
   * "F" for Fahrenheit.
   */
  unit?: string;

  /**
   * An integer representing the type of unit. For example, 0 for feet, 1 for
   * inches, 2 for miles. For a complete list, see [Unit
   * types](/azure/azure-maps/weather-services-concepts#unit-types) in the
   * article Weather services in Azure Maps.
   */
  unitType?: UnitType;
}

/**
 * Provides the forecasted wind speed, measured in units such as kilometers
 * per hour (km/h) or miles per hour (mph), depending on the unit specified
 * in the request. Also indicates the wind direction measured in azimuth
 * degrees, starting at true North and moving clockwise. North corresponds
 * to 0°, east to 90°, south to 180°, and west to 270°. Possible values range
 * from 0° to 359°.
 */
model WindDetails {
  /**
   * Wind direction is measured in azimuth degrees, starting at true North (0°)
   * and moving clockwise. East corresponds to 90°, south to 180°, and west to
   * 270°. Possible values range from 0° to 359°. This property returns an
   * integer representing the wind direction.
   */
  direction?: WindDirection;

  /**
   * The expected wind speed, measured in kilometers per hour (km/h) or miles
   * per hour (mph), depending on the unit specified in the request.
   */
  speed?: WeatherValue;
}

/**
 * Provides details about wind direction, including the direction in azimuth
 * degrees and a localized abbreviation of the wind direction.
 */
model WindDirection {
  /**
   * Wind direction is measured in azimuth degrees, starting at true North and
   * moving clockwise. North corresponds to 0 degrees, east to 90 degrees, south
   * to 180 degrees, and west to 270 degrees. Possible values range from 0 to
   * 359 degrees.
   */
  degrees?: int32;

  /**
   * A localized abbreviation of the wind direction, returned in the language
   * specified in the request. For example, `N` for North, `E` for East, `S` for
   * South, and `W` for West.
   */
  localizedDescription?: string;
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
 * The response returned by the Get Minute Forecast operation, providing a
 * minute-by-minute precipitation outlook for a specified location over the
 * next 120 minutes at the requested resolution (1, 5, or 15 minutes). The
 * response is organized into three layers: an overall `summary` with phrase
 * descriptions and a representative icon for the whole period; an
 * `intervalSummaries` array that groups consecutive minutes into longer
 * stretches of similar conditions (such as *Rain ending in 25 min*); and an
 * `intervals` array containing the detailed per-minute forecast points,
 * including precipitation intensity (`dbz`), precipitation type, cloud
 * cover, and the colors used to render radar-style visualizations.
 */
model MinuteForecastResult {
  /**
   * Top-level phrase summaries that describe the precipitation outlook for
   * the entire ~120-minute forecast window. Includes short, brief, and long
   * variants so the appropriate level of detail can be displayed for the
   * available UI space, plus a representative `iconCode` for the period.
   */
  @visibility(Lifecycle.Read)
  summary?: MinuteForecastSummary;

  /**
   * Phrase summaries that divide the forecast window into one or more
   * contiguous stretches of similar conditions - for example, *Rain ending
   * in 25 min* followed by *Partly cloudy*. Each entry specifies the
   * minutes it covers (`startMinute`, `endMinute`, `totalMinutes`),
   * provides short, brief, and long phrase variants, and includes an
   * `iconCode` for the stretch. Together, these summaries cover the full
   * forecast period.
   */
  @visibility(Lifecycle.Read)
  intervalSummaries?: IntervalSummary[];

  /**
   * The detailed per-step forecast points that make up the minute-by-minute
   * forecast. Each `ForecastInterval` covers 1, 5, or 15 minutes - depending
   * on the resolution requested - and reports the start time, precipitation
   * intensity (`dbz`), precipitation type and threshold, a short
   * descriptive phrase, an icon code, cloud cover, and the colors used to
   * render a radar-style display.
   */
  @visibility(Lifecycle.Read)
  intervals?: ForecastInterval[];
}

/**
 * Provides phrase summaries describing the precipitation outlook for the
 * upcoming minute-by-minute forecast period. Multiple phrase lengths are
 * included - short (~25 characters), brief (~60 characters), and long
 * (60+ characters) - so applications can display the level of detail that
 * best fits the available UI space. An `iconCode` indicates the
 * representative weather icon for the period.
 */
model MinuteForecastSummary {
  /**
   * A brief phrase describing the precipitation outlook for the next 60
   * minutes only (a shorter window than the other phrases on this object).
   * Up to approximately 60 characters.
   */
  briefPhrase60?: string;

  /**
   * A short phrase describing the precipitation outlook for the full ~120
   * minute forecast window. Up to approximately 25 characters.
   */
  shortPhrase?: string;

  /**
   * A brief phrase describing the precipitation outlook for the full ~120
   * minute forecast window. Up to approximately 60 characters.
   */
  briefPhrase?: string;

  /**
   * A long phrase describing the precipitation outlook for the full ~120
   * minute forecast window. Supports more than 60 characters.
   */
  longPhrase?: string;

  /**
   * A representative weather icon code for the full ~120 minute forecast
   * window. The numeric value corresponds to an Azure Maps weather icon -
   * for the complete list, see [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;
}

/**
 * Describes the weather outlook for a contiguous window inside the
 * minute-by-minute forecast - typically a stretch of similar conditions such
 * as *Rain ending in 25 min* or *Light snow starting in 10 min*. Each summary
 * specifies the window in minutes from the forecast start (`startMinute`,
 * `endMinute`, `totalMinutes`), provides phrase descriptions at three lengths
 * (short, brief, and long) so the appropriate level of detail can be shown
 * for the available UI space, and includes an `iconCode` for the
 * representative weather icon. A `MinuteForecastResult` returns one or more
 * `IntervalSummary` entries that together cover the forecast period.
 */
model IntervalSummary {
  /**
   * The first minute of this interval, expressed as a number of minutes from
   * the start of the forecast (minute 0).
   */
  startMinute?: int32;

  /**
   * The last minute of this interval, expressed as a number of minutes from
   * the start of the forecast (minute 0).
   */
  endMinute?: int32;

  /** The length of this interval, in minutes (`endMinute` - `startMinute` + 1). */
  totalMinutes?: int32;

  /** A short phrase describing the precipitation conditions during this interval. Up to 25 characters. */
  shortPhrase?: string;

  /** A brief phrase describing the precipitation conditions during this interval. Up to 60 characters. */
  briefPhrase?: string;

  /**
   * A long phrase describing the precipitation conditions during this interval. Supports
   * more than 60 characters.
   */
  longPhrase?: string;

  /**
   * The representative weather icon code for this interval. The numeric value
   * corresponds to an Azure Maps weather icon - for the complete list, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;
}

/**
 * Represents a single time slice within a minute-by-minute forecast,
 * describing the expected weather conditions during that interval. Each
 * interval covers 1, 5, or 15 minutes - depending on the resolution
 * requested - and includes the start time, precipitation intensity (`dbz`),
 * precipitation type and threshold, a short descriptive phrase, an icon
 * code, cloud cover, and the full-spectrum and simplified colors used to
 * visually represent the conditions on a radar-style display.
 */
model ForecastInterval {
  /**
   * The start of this forecast interval, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (`yyyy-mm-ddThh:mm:ss±hh:mm`). For example, *2019-11-14T15:18:00-08:00*.
   */
  startTime?: utcDateTime;

  /**
   * The start of this forecast interval expressed as a number of minutes from
   * the start of the forecast (minute 0). Pairs with `startTime` and matches
   * the `startMinute` field on the corresponding `IntervalSummary`.
   */
  minute?: int32;

  /**
   * Forecasted radar reflectivity in decibels relative to Z (dBZ), used as a
   * measure of precipitation intensity. Higher values indicate heavier
   * precipitation; a value of 0 indicates no precipitation.
   */
  dbz?: float64;

  /**
   * A short phrase describing the precipitation conditions during this
   * interval (for example, *Light rain*). Up to approximately 25 characters.
   */
  shortPhrase?: string;

  /**
   * The intensity bucket the precipitation falls into for the current
   * `precipitationType` - for example, *light*, *moderate*, or *heavy*. Used
   * with `precipitationType` to determine `simplifiedColor`. Returned only
   * when `dbz` is greater than zero.
   */
  threshold?: string;

  /**
   * The full-spectrum color that maps to `dbz`, used to render this interval
   * on a radar-style display. Returned only when `dbz` is greater than zero.
   */
  color?: ColorValue;

  /**
   * A simplified color derived from `precipitationType` and `threshold`,
   * suitable for UIs that need quick, easy-to-read radar visualizations
   * rather than the full dBZ color spectrum. Returned only when `dbz` is
   * greater than zero.
   */
  simplifiedColor?: ColorValue;

  /**
   * The type of precipitation expected during this interval - one of *Rain*,
   * *Snow*, *Ice*, or *Mix*. Returned only when `dbz` is greater than zero.
   */
  precipitationType?: PrecipitationType;

  /**
   * The representative weather icon code for this interval. The numeric value
   * corresponds to an Azure Maps weather icon - for the complete list, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * The percentage of the sky covered by clouds during this interval, from 0
   * (clear) to 100 (overcast). May be NULL.
   */
  cloudCover?: int32;
}

/**
 * An RGB color, returned in both component (`red`, `green`, `blue`) and
 * hexadecimal (`hex`) form. Used by the minute-by-minute forecast to render
 * each interval on a radar-style display - see `ForecastInterval.color` for
 * the full-spectrum color mapped to `dbz`, and
 * `ForecastInterval.simplifiedColor` for the coarser color derived from
 * `precipitationType` and `threshold`. For the underlying color mappings, see
 * [Weather services in Azure
 * Maps](/azure/azure-maps/weather-services-concepts#radar-images).
 */
model ColorValue {
  /** Red component of the RGB value. Valid values range from 0-255. */
  red?: int32;

  /** Green component of the RGB value. Valid values range from 0-255. */
  green?: int32;

  /** Blue component of the RGB value. Valid values range from 0-255. */
  blue?: int32;

  /**
   * The same color as a hexadecimal RGB string prefixed with `#` - for
   * example, *#FF0000* for red.
   */
  hex?: string;
}

/**
 * The response returned by the Get Quarter-Day Forecast operation, providing
 * weather forecasts in 6-hour quarter-day blocks (morning, afternoon,
 * evening, and overnight) for a specified location. The number of
 * `QuarterDayForecast` entries returned matches the requested `duration` -
 * for example, a 1-day forecast returns 4 quarters and a 5-day forecast
 * returns 20.
 */
model QuarterDayForecastResult {
  /**
   * The forecasted quarter-day periods, in chronological order. Each entry is
   * a `QuarterDayForecast` covering one of the four 6-hour blocks (morning,
   * afternoon, evening, or overnight) and reports the temperature range,
   * wind, precipitation outlook, cloud cover, and other conditions for that
   * block.
   */
  @visibility(Lifecycle.Read)
  forecasts?: QuarterDayForecast[];
}

/**
 * The forecast for one 6-hour quarter-day period - morning (7am-1pm),
 * afternoon (1pm-7pm), evening (7pm-1am), or overnight (1am-7am) - at the
 * specified location. Includes the quarter's date and identifier, an icon
 * and descriptive phrase, the high/low temperature range and RealFeel,
 * humidity and dew point, wind and gust details, visibility, cloud cover,
 * and precipitation and thunderstorm outlook (probability, type, intensity,
 * and accumulation totals).
 */
model QuarterDayForecast {
  /**
   * The calendar date this quarter-day belongs to, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (`yyyy-mm-ddThh:mm:ss±hh:mm`) at the start of the day. For example,
   * *2019-11-14T00:00:00-08:00*. Use `effectiveDate` for the actual start
   * time of this quarter.
   */
  date?: utcDateTime;

  /**
   * The start of this quarter-day period, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (`yyyy-mm-ddThh:mm:ss±hh:mm`). For example, *2019-11-14T07:00:00-08:00*
   * for the morning quarter on November 14, 2019.
   */
  effectiveDate?: utcDateTime;

  /**
   * Identifies which 6-hour quarter of the day this forecast covers:
   *
   * - 0: Morning (7am - 1pm)
   * - 1: Afternoon (1pm - 7pm)
   * - 2: Evening (7pm - 1am)
   * - 3: Overnight (1am - 7am)
   */
  quarter?: DayQuarter;

  /**
   * The representative weather icon code for this quarter-day period. The
   * numeric value corresponds to an Azure Maps weather icon - for the
   * complete list, see [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * A short descriptive term that pairs with `iconCode` to label this
   * quarter-day's weather - for example, *Sunny* or *Partly Cloudy*. For
   * more information, see [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconPhrase?: string;

  /**
   * A brief textual description of the weather conditions for this
   * quarter-day. More descriptive than `iconPhrase` - where `iconPhrase`
   * might return *Thunderstorms*, `phrase` may return *Cloudy with a couple
   * of showers and a thunderstorm*.
   */
  phrase?: string;

  /**
   * The expected high and low temperatures during this quarter-day period,
   * in degrees Celsius (°C) or Fahrenheit (°F), depending on the unit
   * specified in the request.
   */
  temperature?: WeatherValueRange;

  /**
   * The high and low RealFeel™ Temperature values for this quarter-day, in
   * degrees Celsius (°C) or Fahrenheit (°F), depending on the unit specified
   * in the request. Developed by AccuWeather, RealFeel combines air
   * temperature with humidity, wind, cloud cover, sun intensity, and other
   * factors to indicate how the weather actually feels. For more
   * information, see [What is the AccuWeather RealFeel
   * Temperature?](https://www.accuweather.com/en/weather-news/what-is-the-accuweather-realfeel-temperature/156655)
   */
  realFeelTemperature?: WeatherValueRange;

  /**
   * The dew point during this quarter-day - the temperature to which air
   * must cool to become saturated (100% relative humidity). Measured in
   * degrees Celsius (°C) or Fahrenheit (°F), depending on the unit specified
   * in the request. A higher dew point indicates more moisture in the air.
   */
  dewPoint?: WeatherValue;

  /**
   * The relative humidity during this quarter-day, expressed as a
   * percentage from 0 to 100 of the maximum amount of water vapor the air
   * can hold at the same temperature.
   */
  relativeHumidity?: int32;

  /**
   * The expected wind speed and direction during this quarter-day. Speed
   * is in kilometers per hour (km/h) or miles per hour (mph) depending on
   * the unit specified in the request; direction is in azimuth degrees,
   * measured clockwise from true North (0° = N, 90° = E, 180° = S, 270° =
   * W).
   */
  wind?: WindDetails;

  /**
   * The expected maximum wind-gust speed and direction during this
   * quarter-day, using the same units and azimuth convention as `wind`.
   * Wind gusts are brief spikes in wind speed that can affect activities
   * such as aviation, sailing, and outdoor events.
   */
  windGust?: WindDetails;

  /**
   * The distance at which an object or light can be clearly discerned
   * during this quarter-day, in kilometers (km) or miles (mi) depending on
   * the unit specified in the request.
   */
  visibility?: WeatherValue;

  /**
   * The percentage of the sky covered by clouds during this quarter-day,
   * from 0 (clear) to 100 (overcast). May be NULL.
   */
  cloudCover?: int32;

  /**
   * `true` if precipitation (rain, snow, sleet, or hail) is expected during
   * this quarter-day; otherwise `false`.
   */
  hasPrecipitation?: boolean;

  /**
   * The type of precipitation expected during this quarter-day - one of
   * *Rain*, *Snow*, *Ice*, or *Mix*. Returned only when `hasPrecipitation`
   * is `true`.
   */
  precipitationType?: PrecipitationType;

  /**
   * The intensity of the expected precipitation - typically *Light*,
   * *Moderate*, or *Heavy*. Returned only when `hasPrecipitation` is
   * `true`.
   */
  precipitationIntensity?: string;

  /**
   * The probability of precipitation during this quarter-day, from 0 (no
   * chance) to 100 (certain).
   */
  precipitationProbability?: int32;

  /**
   * The probability of a thunderstorm during this quarter-day, from 0 (no
   * chance) to 100 (certain).
   */
  thunderstormProbability?: int32;

  /**
   * The total amount of liquid precipitation (such as rain, plus the liquid
   * equivalent of snow or ice) expected during this quarter-day, in
   * millimeters (mm) or inches (in) depending on the unit specified in the
   * request.
   */
  totalLiquid?: WeatherValue;

  /**
   * The amount of rainfall expected during this quarter-day, in millimeters
   * (mm) or inches (in) depending on the unit specified in the request.
   */
  rain?: WeatherValue;

  /**
   * The amount of snow accumulation expected during this quarter-day, in
   * millimeters (mm) or inches (in) depending on the unit specified in the
   * request.
   */
  snow?: WeatherValue;

  /**
   * The estimated ice accumulation expected during this quarter-day, in
   * millimeters (mm) or inches (in) depending on the unit specified in the
   * request.
   */
  ice?: WeatherValue;
}

/**
 * Provides the highest and lowest forecasted temperatures for the specified
 * timeframe, measured in degrees Celsius (°C) or Fahrenheit (°F), based on the
 * unit specified in the request.
 */
model WeatherValueRange {
  /**
   * Provides the minimum temperature for the specified timeframe, measured in
   * degrees Celsius (°C) or Fahrenheit (°F), based on the unit specified in the
   * request.
   */
  minimum?: WeatherValue;

  /**
   * Provides the maximum temperature for the specified timeframe, measured in
   * degrees Celsius (°C) or Fahrenheit (°F), based on the unit specified in the
   * request.
   */
  maximum?: WeatherValue;
}

/**
 * The response returned by the Get Current Conditions operation, containing
 * one or more current-conditions observations for a specified location. By
 * default a single observation for the present time is returned; when the
 * `duration` parameter is set to 6 or 24, the response also includes one
 * observation per past hour over that window.
 */
model CurrentConditionsResult {
  /**
   * The current-conditions observations, in chronological order with the
   * most recent first. By default a single entry - the latest observation
   * - is returned; the response may also contain one entry per hour over a
   * recent rolling window (typically the past 6 or 24 hours), depending on
   * the request.
   */
  @visibility(Lifecycle.Read)
  results?: CurrentConditions[];
}

/**
 * A single weather observation for the specified location, returned by the
 * Get Current Conditions operation. Depending on the request's `duration`,
 * this observation may be the latest (most recent) reading or one of the
 * preceding hourly observations. By default a simplified subset is
 * returned: observation date and time, weather phrase, icon code,
 * precipitation indicator, and temperature. When the request asks for full
 * details, every property is included, adding measurements such as
 * RealFeel, dew point, wind, visibility, cloud cover, pressure, and
 * rolling precipitation and temperature summaries for the past several
 * hours.
 */
model CurrentConditions {
  /**
   * The date and time of this observation, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: utcDateTime;

  /**
   * A short descriptive term for the weather conditions at the observation
   * time - for example, *Sunny* or *Partly Cloudy*. Pairs with `iconCode`,
   * which identifies the matching weather icon. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  phrase?: string;

  /**
   * The representative weather icon code for this observation, paired with
   * the `phrase` property. The numeric value corresponds to an Azure Maps
   * weather icon - for the complete list, see [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be
   * NULL.
   */
  iconCode?: IconCode;

  /**
   * `true` if precipitation (rain, snow, sleet, or hail) is occurring at the
   * observation time; otherwise `false`.
   */
  hasPrecipitation?: boolean;

  /**
   * `true` if it is daytime at the specified location at the observation
   * time; `false` if it is nighttime.
   */
  isDayTime?: boolean;

  /**
   * The air temperature at the observation time, in degrees Celsius (°C) or
   * Fahrenheit (°F), depending on the unit specified in the request.
   */
  temperature?: WeatherValue;

  /**
   * The RealFeel™ Temperature at the observation time, in degrees Celsius
   * (°C) or Fahrenheit (°F), depending on the unit specified in the request.
   * Developed by AccuWeather, RealFeel combines air temperature with
   * humidity, wind, cloud cover, sun intensity, and other factors to
   * indicate how the weather actually feels. For more information, see
   * [What is the AccuWeather RealFeel
   * Temperature?](https://www.accuweather.com/en/weather-news/what-is-the-accuweather-realfeel-temperature/156655)
   */
  realFeelTemperature?: WeatherValue;

  /**
   * The RealFeel™ Temperature at the observation time in shaded areas, in
   * degrees Celsius (°C) or Fahrenheit (°F), depending on the unit specified
   * in the request. Like `realFeelTemperature`, but excludes the warming
   * effect of direct sunlight, giving a more accurate sense of how the
   * weather feels in the shade.
   */
  realFeelTemperatureShade?: WeatherValue;

  /**
   * The relative humidity at the observation time, expressed as a percentage
   * from 0 to 100 of the maximum amount of water vapor the air can hold at
   * the same temperature.
   */
  relativeHumidity?: int32;

  /**
   * The dew point at the observation time - the temperature to which air
   * must cool to become saturated (100% relative humidity). Measured in
   * degrees Celsius (°C) or Fahrenheit (°F), depending on the unit specified
   * in the request. A higher dew point indicates more moisture in the air.
   */
  dewPoint?: WeatherValue;

  /**
   * The wind speed and direction at the observation time. Speed is in
   * kilometers per hour (km/h) or miles per hour (mph) depending on the unit
   * specified in the request; direction is in azimuth degrees, measured
   * clockwise from true North (0° = N, 90° = E, 180° = S, 270° = W).
   */
  wind?: WindDetails;

  /**
   * The maximum short-burst wind-gust speed and direction at the observation
   * time, using the same units and azimuth convention as `wind`. Wind gusts
   * are brief spikes in wind speed that can affect activities such as
   * aviation, sailing, kite flying, and other outdoor events.
   */
  windGust?: WindDetails;

  /**
   * The ultraviolet (UV) index at the observation time, indicating the risk
   * of harm from unprotected sun exposure. Supported values are:
   *
   * - 0-2: Low danger from the sun's UV rays for the average person.
   * - 3-5: Moderate risk of harm from unprotected sun exposure.
   * - 6-7: High risk of harm from unprotected sun exposure.
   * - 8-10: Very high risk of harm from unprotected sun exposure.
   * - 11+: Extreme risk of harm from unprotected sun exposure.
   */
  uvIndex?: int32;

  /**
   * A short descriptive label for `uvIndex` - for example, *Low*, *Moderate*,
   * *High*, *Very High*, or *Extreme*.
   */
  uvIndexPhrase?: string;

  /**
   * The horizontal visibility at the observation time - the distance at
   * which an object or light can be clearly discerned - in kilometers (km)
   * or miles (mi) depending on the unit specified in the request.
   */
  visibility?: WeatherValue;

  /**
   * A code identifying the dominant factor reducing visibility at the
   * observation time, such as fog, smoke, haze, or precipitation. Useful for
   * activities that depend on clear visibility, like driving and aviation.
   *
   * Possible values:
   *
   * - **A** = heavy thunderstorm/hail
   * - **BD** = blowing dust
   * - **BN** = blowing sand
   * - **BS** = blowing snow
   * - **D** = dust
   * - **F** = fog
   * - **GF** = ground fog
   * - **HZ** = haze
   * - **I** = ice
   * - **IC** = ice crystals
   * - **IF** = ice fog
   * - **IP** = ice pellets
   * - **IPW** = ice pellets shower
   * - **K** = smoke
   * - **L** = drizzle
   * - **R** = rain
   * - **RS** = rain/snow
   * - **RW** = rain shower
   * - **S** = snow
   * - **SG** = snow granules
   * - **SP** = snow pellets
   * - **SW** = snow shower
   * - **T** = thunderstorm
   * - **UP** = undefined precipitation
   * - **ZL** = freezing drizzle
   * - **ZR** = freezing rain
   * - **+** = heavy
   * - **-** = light
   */
  obstructionsToVisibility?: string;

  /**
   * The percentage of the sky covered by clouds at the observation time,
   * from 0 (clear) to 100 (overcast). May be NULL.
   */
  cloudCover?: int32;

  /**
   * The cloud ceiling at the observation time - the height above the ground
   * of the lowest cloud layer - in feet (ft) or meters (m) depending on the
   * unit specified in the request. Important for aviation, since it affects
   * flight visibility and operations.
   */
  ceiling?: WeatherValue;

  /**
   * The atmospheric (air) pressure at ground level at the observation time,
   * in millibars (mb) or inches of mercury (inHg), depending on the unit
   * specified in the request.
   */
  pressure?: WeatherValue;

  /**
   * The recent trend in atmospheric pressure - rising, falling, or steady.
   * Useful for anticipating short-term weather changes; falling pressure
   * often signals deteriorating weather, while rising pressure typically
   * indicates improving conditions.
   */
  pressureTendency?: PressureTendency;

  /**
   * The change in air temperature compared to 24 hours ago, in degrees
   * Celsius (°C) or Fahrenheit (°F), depending on the unit specified in the
   * request. Positive values indicate the air is warmer than yesterday at
   * the same time; negative values indicate it is cooler.
   */
  pastTwentyFourHourTemperatureDeparture?: WeatherValue;

  /**
   * The apparent temperature at the observation time - how the air actually
   * feels to humans, taking into account air temperature, relative humidity,
   * and wind speed. Measured in degrees Celsius (°C) or Fahrenheit (°F),
   * depending on the unit specified in the request.
   */
  apparentTemperature?: WeatherValue;

  /**
   * The wind chill temperature at the observation time - how cold the air
   * feels on exposed skin due to the combined effect of wind and low
   * temperature. Typically lower than the actual air temperature. Measured
   * in degrees Celsius (°C) or Fahrenheit (°F), depending on the unit
   * specified in the request.
   */
  windChillTemperature?: WeatherValue;

  /**
   * The wet-bulb temperature at the observation time - the temperature the
   * air would reach if cooled to saturation (100% relative humidity) by
   * evaporating water into it at constant pressure. Measured in degrees
   * Celsius (°C) or Fahrenheit (°F), depending on the unit specified in the
   * request. Useful for assessing heat stress and evaporative cooling.
   */
  wetBulbTemperature?: WeatherValue;

  /**
   * A summary of liquid-equivalent precipitation amounts at the observation
   * location over rolling windows of the past 1, 3, 6, 9, 12, 18, and 24
   * hours, in millimeters (mm) or inches (in) depending on the unit
   * specified in the request.
   */
  precipitationSummary?: PrecipitationSummary;

  /**
   * A summary of the highest and lowest air temperatures observed at this
   * location over rolling windows of the past 6, 12, and 24 hours, in
   * degrees Celsius (°C) or Fahrenheit (°F) depending on the unit specified
   * in the request.
   */
  temperatureSummary?: TemperatureSummary;
}

/**
 * The recent trend in atmospheric pressure - whether the pressure is
 * rising, falling, or steady - returned as both a localized phrase and a
 * one-letter code. Useful for anticipating short-term weather changes;
 * falling pressure often signals deteriorating weather, while rising
 * pressure typically indicates improving conditions.
 */
model PressureTendency {
  /**
   * A short phrase describing the pressure tendency - for example, *Falling*,
   * *Steady*, or *Rising* - returned in the language specified in the
   * request.
   */
  localizedDescription?: string;

  /**
   * A language-independent one-letter code for the pressure tendency:
   * **F** = Falling, **S** = Steady, **R** = Rising.
   */
  code?: string;
}

/**
 * The total liquid-equivalent precipitation that has fallen at the
 * observation location over rolling windows ending at the observation time.
 * Each value covers the full window measured back from "now" - for example,
 * `past3Hours` is the running total for the most recent three hours, not
 * just the third hour - so the windows overlap and longer windows include
 * the precipitation reported for the shorter ones. Snow and ice contribute
 * their melted (liquid) equivalent. Reported in millimeters (mm) or inches
 * (in) depending on the unit specified in the request.
 */
model PrecipitationSummary {
  /** Liquid-equivalent precipitation that has fallen in the past hour. */
  pastHour?: WeatherValue;

  /** Liquid-equivalent precipitation that has fallen in the past 3 hours. */
  past3Hours?: WeatherValue;

  /** Liquid-equivalent precipitation that has fallen in the past 6 hours. */
  past6Hours?: WeatherValue;

  /** Liquid-equivalent precipitation that has fallen in the past 9 hours. */
  past9Hours?: WeatherValue;

  /** Liquid-equivalent precipitation that has fallen in the past 12 hours. */
  past12Hours?: WeatherValue;

  /** Liquid-equivalent precipitation that has fallen in the past 18 hours. */
  past18Hours?: WeatherValue;

  /** Liquid-equivalent precipitation that has fallen in the past 24 hours. */
  past24Hours?: WeatherValue;
}

/**
 * The highest and lowest air temperatures observed at the location over
 * rolling windows ending at the observation time. Each value covers the
 * full window measured back from "now" - for example, `past12Hours` reports
 * the high and low across the most recent 12 hours, not just the twelfth
 * hour - so the windows overlap and longer windows include the
 * temperatures reported for the shorter ones. Reported in degrees Celsius
 * (°C) or Fahrenheit (°F) depending on the unit specified in the request.
 */
model TemperatureSummary {
  /** Highest and lowest temperatures observed in the past 6 hours. */
  past6Hours?: PastHoursTemperature;

  /** Highest and lowest temperatures observed in the past 12 hours. */
  past12Hours?: PastHoursTemperature;

  /** Highest and lowest temperatures observed in the past 24 hours. */
  past24Hours?: PastHoursTemperature;
}

/**
 * The highest and lowest air temperatures observed during one of the rolling
 * windows on `TemperatureSummary` (past 6, 12, or 24 hours), in degrees
 * Celsius (°C) or Fahrenheit (°F) depending on the unit specified in the
 * request.
 */
model PastHoursTemperature {
  /** The lowest temperature observed during the window. */
  minimum?: WeatherValue;

  /** The highest temperature observed during the window. */
  maximum?: WeatherValue;
}

/**
 * The response returned by the Get Daily Forecast operation, providing a
 * day-by-day weather forecast for a specified location. Includes a top-level
 * `summary` describing the dominant conditions and severity for the requested
 * window, plus a `forecasts` array with one `DailyForecast` entry per day.
 * The number of entries matches the requested `duration`
 * (1, 5, 10, 15, 25, or 45 days; 25 and 45 require an S1 SKU).
 */
model DailyForecastResult {
  /**
   * A high-level summary of the dominant weather conditions across the
   * requested forecast window. The summary may cover only part of the window
   * - for example, when significant weather (such as a storm system) is
   * expected during a portion of it - rather than the entire period.
   */
  @visibility(Lifecycle.Read)
  summary?: DailyForecastSummary;

  /**
   * The per-day forecasts, in chronological order with one entry per day
   * in the requested `duration`. Each entry is a `DailyForecast`
   * reporting the day's high/low temperature, RealFeel range, hours of
   * sunshine, heating/cooling degree-day totals, air-and-pollen indices,
   * separate day and night detail blocks (precipitation, wind, cloud
   * cover, and more), and the data sources contributing to the forecast.
   */
  @visibility(Lifecycle.Read)
  forecasts?: DailyForecast[];
}

/**
 * A high-level summary of the dominant weather conditions across part or
 * all of the requested daily-forecast window. The summarized window can be
 * narrower than the full request - for example, when significant weather
 * (such as a storm system) is expected during only a portion of the
 * period - and is delimited by `startDate` and `endDate`. The conditions
 * themselves are described both as a free-form `phrase`, a one or
 * two-word `category` label, and a numeric `severity` rating.
 */
model DailyForecastSummary {
  /**
   * The start of the window covered by this summary, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format - for example,
   * *2019-10-27T19:39:57-08:00*. May be later than the start of the
   * requested forecast window if the summarized event begins partway
   * through it.
   */
  startDate?: utcDateTime;

  /**
   * The end of the window covered by this summary, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format - for example,
   * *2019-10-29T07:00:00-08:00*. May be earlier than the end of the
   * requested forecast window if the summarized event ends before it.
   */
  endDate?: utcDateTime;

  /**
   * A numeric severity rating for the summarized weather event. Lower
   * numbers (excluding **0**) indicate higher severity:
   *
   * - **0**: Unknown
   * - **1**: Significant
   * - **2**: Major
   * - **3**: Moderate
   * - **4**: Minor
   * - **5**: Minimal
   * - **6**: Insignificant
   * - **7**: Informational
   */
  severity?: int32;

  /**
   * A brief, free-form textual summary of the dominant weather conditions
   * for the summarized window, returned in the language specified in the
   * request. For example, *Expect showers Tuesday through Thursday*.
   */
  phrase?: string;

  /**
   * A one or two-word label categorizing the dominant weather conditions
   * for the summarized window - for example, *Sunny*, *Partly Cloudy*,
   * *Rain*, or *Snow*.
   */
  category?: string;
}

/**
 * The forecast for one calendar day at the specified location, returned as
 * one entry per day in the `forecasts` array on `DailyForecastResult`.
 * Includes the day's high/low temperature range, RealFeel ranges (regular
 * and shaded), expected hours of sunshine, heating/cooling degree-day
 * totals, an array of air-quality, pollen, and UV-index indicators, and
 * separate detail blocks for the daytime and nighttime portions of the day
 * (precipitation, wind, cloud cover, and more). The `sources` array lists
 * the data providers contributing to the forecast.
 */
model DailyForecast {
  /**
   * The calendar date this forecast covers, in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (`yyyy-mm-ddThh:mm:ss-hh:mm`). For example, *2025-04-29T07:00:00-07:00*.
   */
  date?: utcDateTime;

  /**
   * The forecasted high and low air temperatures for the day, in degrees
   * Celsius (°C) or Fahrenheit (°F), depending on the unit specified in
   * the request.
   */
  temperature?: WeatherValueRange;

  /**
   * The high and low RealFeel™ Temperature values for the day, in degrees
   * Celsius (°C) or Fahrenheit (°F), depending on the unit specified in the
   * request. Developed by AccuWeather, RealFeel combines air temperature
   * with humidity, wind, cloud cover, sun intensity, and other factors to
   * indicate how the weather actually feels. For more information, see
   * [What is the AccuWeather RealFeel
   * Temperature?](https://www.accuweather.com/en/weather-news/what-is-the-accuweather-realfeel-temperature/156655)
   */
  realFeelTemperature?: WeatherValueRange;

  /**
   * The high and low RealFeel™ Temperature values for the day in shaded
   * areas, in degrees Celsius (°C) or Fahrenheit (°F), depending on the
   * unit specified in the request. Like `realFeelTemperature`, but excludes
   * the warming effect of direct sunlight, giving a more accurate sense of
   * how the weather feels in the shade.
   */
  realFeelTemperatureShade?: WeatherValueRange;

  /**
   * The expected number of hours of sunshine during the day, useful for
   * planning outdoor activities and gauging overall daytime conditions.
   */
  hoursOfSun?: float32;

  /**
   * Heating and cooling degree-day totals for the day, used to estimate
   * energy demand for building climate control.
   */
  degreeDaySummary?: DegreeDaySummary;

  /**
   * Forecasted air-quality, pollen, and UV-index indicators for the day.
   * Each entry reports a name (such as *Tree*, *Grass*, *Ragweed*, *Mold*,
   * *AirQuality*, or *UVIndex*), a numeric value, and a qualitative
   * `category` (such as *Low*, *Moderate*, *High*, *Good*, *Unhealthy*, or
   * *Hazardous*) so applications can flag potential health risks.
   */
  airAndPollen?: AirAndPollen[];

  /**
   * The detailed forecast for the daytime portion of the day - including
   * temperature, precipitation, wind, cloud cover, and other key
   * attributes.
   */
  day?: DailyForecastDetail;

  /**
   * The detailed forecast for the nighttime portion of the day - including
   * temperature, precipitation, wind, cloud cover, and other key
   * attributes.
   */
  night?: DailyForecastDetail;

  /** The data providers that contributed to this day's forecast. */
  sources?: string[];
}

/**
 * Heating and cooling degree-day totals for a single day, used to estimate
 * the energy demand for heating or cooling a building. Each value is the
 * number of degrees by which the day's mean temperature differs from the
 * **65°F (18°C)** baseline, in the temperature unit specified in the
 * request - degrees below the baseline contribute to `heating`, degrees
 * above it contribute to `cooling`.
 */
model DegreeDaySummary {
  /**
   * Heating Degree Days (HDD) - the number of degrees the day's mean
   * temperature falls **below** the 65°F (18°C) baseline. Higher values
   * indicate greater heating demand. Reported in degrees Celsius (°C) or
   * Fahrenheit (°F) depending on the unit specified in the request.
   */
  heating?: WeatherValue;

  /**
   * Cooling Degree Days (CDD) - the number of degrees the day's mean
   * temperature rises **above** the 65°F (18°C) baseline. Higher values
   * indicate greater cooling demand. Reported in degrees Celsius (°C) or
   * Fahrenheit (°F) depending on the unit specified in the request.
   */
  cooling?: WeatherValue;
}

/**
 * One entry in `DailyForecast.airAndPollen` describing a single pollen,
 * air-quality, or UV-index indicator for the day. The `name` property
 * determines which kind of indicator the entry represents:
 *
 * - **Pollen**: `name` is *Tree*, *Grass*, *Ragweed*, or *Mold*. `value`
 *   gives the forecast amount and `category` / `categoryValue` rate it
 *   from *Low* to *High*.
 * - **Air quality**: `name` is *AirQuality* and `type` identifies the
 *   pollutant being measured (one of *PM2.5*, *PM10*, *O3*, *NO2*,
 *   *SO2*, or *CO*). `category` / `categoryValue` rate the air quality
 *   from *Good* to *Hazardous*.
 * - **UV index**: `name` is *UVIndex*. `value` is the UV index (0 to
 *   11+), and `category` / `categoryValue` rate the exposure risk from
 *   *Low* to *Extreme*.
 *
 * `category` is the qualitative label for the indicator and
 * `categoryValue` is the matching 1-6 rating, where **1** indicates
 * the safest conditions and **6** the most hazardous.
 */
model AirAndPollen {
  /**
   * Identifies which indicator this entry represents. Either the name
   * of a pollen source (*Tree*, *Grass*, *Ragweed*, or *Mold*),
   * *AirQuality* (in which case `type` identifies the pollutant), or
   * *UVIndex*.
   */
  name?: string;

  /**
   * The numeric measurement for this indicator. The unit depends on
   * `name`:
   *
   * - For pollen, the forecast pollen count.
   * - For air quality, the pollutant concentration in units appropriate
   *   to the pollutant - typically micrograms per cubic meter (µg/m³)
   *   for particulate matter and parts per billion (ppb) for gases such
   *   as ozone.
   * - For UV index, an index value from 0 to 11+.
   *
   * Both air quality and UV index are themselves indices, so they are
   * reported as unitless numbers.
   */
  value?: int32;

  /**
   * A short qualitative label for the indicator, returned in the
   * language specified in the request. Possible values depend on
   * `name`:
   *
   * - Pollen: *Low*, *Moderate*, *High*, or *Very High*.
   * - Air quality: *Good*, *Moderate*, *Unhealthy for Sensitive
   *   Groups*, *Unhealthy*, *Very Unhealthy*, or *Hazardous*.
   * - UV index: *Low*, *Moderate*, *High*, *Very High*, or *Extreme*.
   */
  category?: string;

  /**
   * A 1-6 numeric rating that pairs with `category`, where **1**
   * indicates the safest conditions and **6** the most hazardous. Use
   * this when a stable, language-independent numeric value is needed
   * instead of the localized `category` label.
   */
  categoryValue?: int32;

  /**
   * When `name` is *AirQuality*, the specific pollutant being measured
   * - one of *PM2.5*, *PM10*, *O3* (ozone), *NO2* (nitrogen dioxide),
   * *SO2* (sulfur dioxide), or *CO* (carbon monoxide). Not returned for
   * pollen or UV-index entries.
   */
  type?: string;
}

/**
 * Forecast details for one half of a day. The same shape is used for
 * both `DailyForecast.day` (sunrise to sunset) and `DailyForecast.night`
 * (sunset to next sunrise), so all references to "this period" below
 * mean that specific daytime or nighttime portion - never the full
 * 24-hour day. Includes a forecast icon and phrases, precipitation
 * type / intensity / probabilities, accumulation totals, hours of
 * precipitation, wind, and cloud cover.
 */
model DailyForecastDetail {
  /**
   * Numeric value representing an image that corresponds to the
   * forecasted weather condition for this period, described by the
   * `iconPhrase` property. The numeric value corresponds to an Azure
   * Maps weather icon - for the complete list, see [Weather services in
   * Azure Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   * May be NULL.
   */
  iconCode?: IconCode;

  /**
   * A short phrase that describes the icon, returned in the language
   * specified in the request. For example, *Sunny*.
   */
  iconPhrase?: string;

  /**
   * Information about the local weather data provider whose icon code
   * and weather code were used for this period, when one was selected.
   */
  localSource?: LocalSource;

  /**
   * `true` if any precipitation (rain, snow, sleet, or hail) is expected
   * during this period; `false` otherwise.
   */
  hasPrecipitation?: boolean;

  /**
   * The dominant type of precipitation expected during this period -
   * one of *Rain*, *Snow*, *Ice*, or *Mix*. Returned only when
   * `hasPrecipitation` is `true`.
   */
  precipitationType?: PrecipitationType;

  /**
   * A short qualitative description of the precipitation intensity for
   * this period - for example, *Light*, *Moderate*, or *Heavy*.
   * Returned in the language specified in the request, and only when
   * `hasPrecipitation` is `true`.
   */
  precipitationIntensity?: string;

  /**
   * A short phrase that describes the forecast for this period,
   * returned in the language specified in the request. Azure Maps tries
   * to keep this phrase under 30 characters, but some languages or
   * weather events may produce a longer string.
   */
  shortPhrase?: string;

  /**
   * A longer, more descriptive phrase for this period, returned in the
   * language specified in the request. Azure Maps tries to keep this
   * phrase under 100 characters, but some languages or weather events
   * may produce a longer string.
   */
  longPhrase?: string;

  /**
   * The probability of any precipitation during this period, expressed
   * as a percentage from 0 to 100, where **0** means no chance of
   * precipitation and **100** means precipitation is certain.
   */
  precipitationProbability?: int32;

  /**
   * The probability of a thunderstorm during this period, expressed as
   * a percentage from 0 to 100, where **0** means no chance of a
   * thunderstorm and **100** means a thunderstorm is certain.
   */
  thunderstormProbability?: int32;

  /**
   * The probability of rain during this period, expressed as a
   * percentage from 0 to 100, where **0** means no chance of rain and
   * **100** means rain is certain.
   */
  rainProbability?: int32;

  /**
   * The probability of snow during this period, expressed as a
   * percentage from 0 to 100, where **0** means no chance of snow and
   * **100** means snow is certain.
   */
  snowProbability?: int32;

  /**
   * The probability of ice formation during this period, expressed as
   * a percentage from 0 to 100, where **0** means no chance of ice and
   * **100** means icy conditions are certain.
   */
  iceProbability?: int32;

  /**
   * The forecasted wind speed and direction for this period. Wind speed
   * is in kilometers per hour (km/h) or miles per hour (mph) depending
   * on the unit specified in the request. Wind direction is measured in
   * azimuth degrees, from 0° (true North) to 359°, moving clockwise -
   * east is 90°, south is 180°, west is 270°.
   */
  wind?: WindDetails;

  /**
   * The expected maximum short-burst wind speed and direction during
   * this period. Wind gusts are sudden, brief increases in wind speed
   * that matter for activities such as aviation, sailing, and kite
   * flying. Speed is in kilometers per hour (km/h) or miles per hour
   * (mph) depending on the unit specified in the request, and direction
   * uses the same azimuth convention as `wind`.
   */
  windGust?: WindDetails;

  /**
   * The total amount of liquid precipitation (such as rain, plus the
   * liquid equivalent of any snow or ice) expected during this period,
   * in millimeters (mm) or inches (in) depending on the unit specified
   * in the request.
   */
  totalLiquid?: WeatherValue;

  /**
   * The amount of rainfall expected during this period, in millimeters
   * (mm) or inches (in) depending on the unit specified in the request.
   */
  rain?: WeatherValue;

  /**
   * The amount of snow accumulation expected during this period, in
   * centimeters (cm) or inches (in) depending on the unit specified in
   * the request.
   */
  snow?: WeatherValue;

  /**
   * The amount of ice accumulation expected during this period, in
   * millimeters (mm) or inches (in) depending on the unit specified in
   * the request.
   */
  ice?: WeatherValue;

  /**
   * The total number of hours during this period when any precipitation
   * (rain, snow, sleet, or hail) is expected.
   */
  hoursOfPrecipitation?: float32;

  /**
   * The total number of hours during this period when rain is expected.
   */
  hoursOfRain?: float32;

  /**
   * The total number of hours during this period when snow is expected.
   */
  hoursOfSnow?: float32;

  /**
   * The total number of hours during this period when ice formation is
   * expected.
   */
  hoursOfIce?: float32;

  /**
   * The percentage of the sky covered by clouds during this period,
   * from **0** (clear skies) to **100** (completely overcast). May be
   * NULL.
   */
  cloudCover?: int32;
}

/**
 * Information about a local weather data provider used to source the
 * forecast on `DailyForecastDetail.localSource`. Identifies the provider
 * (`id`, `name`) and exposes the provider's native `weatherCode` so that
 * applications can render the provider's own icon set instead of the
 * default Azure Maps icons.
 */
model LocalSource {
  /** A numeric identifier that uniquely identifies the local data provider. */
  id?: int32;

  /**
   * The name of the local data provider, returned in the language
   * specified in the request when available; otherwise returned in
   * English or the language in which the provider supplied it.
   */
  name?: string;

  /**
   * The provider-native weather code for this forecast, suitable for
   * mapping to the provider's own icon set instead of the default Azure
   * Maps `iconCode`.
   */
  weatherCode?: string;
}

/**
 * The response returned by the Get Weather Along Route operation,
 * providing the forecast for a sequence of waypoints along a road
 * route. Includes a top-level `summary` with the highest hazard index
 * across the route and a representative weather icon, plus a
 * `waypoints` array containing one detailed forecast per requested
 * waypoint - cloud cover, temperature, wind, precipitation, lightning
 * count, sun glare, hazards, and notifications.
 */
model WeatherAlongRouteResult {
  /**
   * A high-level overview of conditions across the entire route - a
   * representative weather `iconCode` and the maximum hazard index
   * encountered at any waypoint - useful for surfacing a single
   * route-level status.
   */
  @visibility(Lifecycle.Read)
  summary?: WeatherAlongRouteSummary;

  /**
   * The per-waypoint forecasts, returned in the same order as the
   * waypoints supplied in the request (one entry per waypoint). Each
   * `WaypointForecast` reports cloud cover, weather hazards, lightning
   * count, hazard notifications, precipitation type and intensity, sun
   * glare, temperature, and wind details for its location.
   */
  @visibility(Lifecycle.Read)
  waypoints?: WaypointForecast[];
}

/**
 * The route-level summary on `WeatherAlongRouteResult.summary`,
 * giving a single high-level snapshot of conditions across the entire
 * route. Includes a representative weather `iconCode` for the route
 * and an aggregated `hazards` block reporting the maximum hazard
 * index and the specific hazard types encountered at any waypoint.
 * Use this when a single route-level indicator is needed; for
 * per-waypoint detail, use `WeatherAlongRouteResult.waypoints`.
 */
model WeatherAlongRouteSummary {
  /**
   * The representative weather icon code for the route as a whole.
   * The numeric value corresponds to an Azure Maps weather icon - for
   * the complete list, see [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * The aggregated weather hazards across all waypoints on the route -
   * `maxHazardIndex` reports the highest severity encountered at any
   * waypoint and `hazardDetails` enumerates the specific hazard types
   * (heavy rain, snow, ice, lightning, severe weather warnings, and so
   * on) detected anywhere along the route.
   */
  hazards?: WeatherHazards;
}

/**
 * A summary of the significant weather hazards at a single location.
 * The same shape is used in two places by the Get Weather Along Route
 * response: on `WeatherAlongRouteSummary.hazards`, where it aggregates
 * across the entire route (max severity at any waypoint), and on
 * `WaypointForecast.hazards`, where it describes the hazards at one
 * specific waypoint. Conveys both a top-level `maxHazardIndex` rating
 * the worst hazard in scope (from **0** - no hazard - to **4** -
 * life-threatening) and a `hazardDetails` array enumerating each
 * specific hazard type encountered (rain, snow, ice, hail, sun glare,
 * lightning, wind, and severe weather warnings such as floods,
 * tornadoes, tsunamis, and severe thunderstorms).
 */
model WeatherHazards {
  /**
   * The highest hazard-severity rating in scope - the maximum across
   * the entire route when used on `WeatherAlongRouteSummary.hazards`,
   * or the worst hazard at this specific waypoint when used on
   * `WaypointForecast.hazards`. Useful for color-coding route segments
   * or waypoint markers to indicate safety levels:
   *
   * - **0**: No hazard
   * - **1**: Be informed, be aware
   * - **2**: Pay attention, be prepared
   * - **3**: Take action
   * - **4**: Life-threatening, emergency
   */
  maxHazardIndex?: HazardIndex;

  /**
   * The individual hazards contributing to `maxHazardIndex`. Each
   * `HazardDetail` identifies a specific hazard type (rain, snow, ice,
   * hail, sun glare, lightning, wind, or a severe weather warning such
   * as a flood, tornado, tsunami, or severe thunderstorm) along with
   * its severity and a short descriptive phrase. See the
   * `HazardDetail.hazardCode` documentation for the complete list of
   * supported hazard codes.
   */
  hazardDetails?: HazardDetail[];
}

/**
 * One entry in `WeatherHazards.hazardDetails` describing a single
 * weather hazard at the location (route-level when carried on
 * `WeatherAlongRouteSummary.hazards`, or per-waypoint when carried on
 * `WaypointForecast.hazards`). Combines a `hazardCode` identifying the
 * specific hazard type, a `hazardIndex` rating its individual severity
 * on the 0-4 scale, and a `shortPhrase` suitable for display in a UI.
 */
model HazardDetail {
  /**
   * The severity rating for this specific hazard, on the same 0-4
   * scale as `WeatherHazards.maxHazardIndex`:
   *
   * - **0**: No hazard
   * - **1**: Be informed, be aware
   * - **2**: Pay attention, be prepared
   * - **3**: Take action
   * - **4**: Life-threatening, emergency
   */
  hazardIndex?: HazardIndex;

  /**
   * A language-independent code identifying the type of hazard.
   * Supported values:
   *
   * - `LightRain`, `ModerateRain`, `HeavyRain`
   * - `LightMix`, `ModerateMix`, `HeavyMix`
   * - `LightSnow`, `ModerateSnow`, `HeavySnow`
   * - `LightIce`, `ModerateIce`, `HeavyIce`
   * - `Hail`, `LargeHail`
   * - `SunGlare`, `SunGlareHigh`
   * - `Lightning`, `SevereLightning`
   * - `WindModerate`, `WindHigh`, `WindExtreme`
   * - `FloodWarning`, `FlashFloodWarning`
   * - `TornadoWarning`, `TsunamiWarning`
   * - `SevereThunderstormWarning`
   */
  hazardCode?: string;

  /**
   * A short, displayable phrase describing the hazard, returned in
   * the language specified in the request. Up to 25 characters.
   */
  shortPhrase?: string;
}

/**
 * The detailed forecast for one waypoint along a road route, returned as
 * one entry per requested waypoint in
 * `WeatherAlongRouteResult.waypoints` (same order as the waypoints
 * supplied in the request). Reports the conditions at that location: a
 * representative `iconCode` and `shortPhrase`, whether it is day or
 * night, cloud cover, temperature, wind and wind-gust details,
 * precipitation type and intensity, a lightning-strike count, the sun
 * glare hazard for the driver, the `WeatherHazards` aggregated at the
 * waypoint, and any free-form hazard `notifications`.
 */
model WaypointForecast {
  /**
   * The representative weather icon code for this waypoint. The numeric
   * value corresponds to an Azure Maps weather icon - for the complete
   * list, see [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * A brief, displayable phrase describing the forecasted weather
   * conditions at this waypoint - for example, *Mostly cloudy* or
   * *Light rain*. Returned in the language specified in the request.
   */
  shortPhrase?: string;

  /**
   * `true` if it is daytime at this waypoint at the forecast time;
   * `false` if it is nighttime.
   */
  isDayTime?: boolean;

  /**
   * The percentage of the sky covered by clouds at this waypoint, from
   * **0** (clear skies) to **100** (completely overcast). May be NULL.
   */
  cloudCover?: int32;

  /**
   * The forecasted air temperature at this waypoint, in degrees Celsius
   * (°C) or Fahrenheit (°F), depending on the unit specified in the
   * request.
   */
  temperature?: WeatherValue;

  /**
   * The forecasted wind speed and direction at this waypoint. Speed is
   * in kilometers per hour (km/h) or miles per hour (mph) depending on
   * the unit specified in the request; direction is in azimuth degrees,
   * measured clockwise from true North (0° = N, 90° = E, 180° = S,
   * 270° = W).
   */
  wind?: WindDetails;

  /**
   * The forecasted maximum short-burst wind-gust speed and direction at
   * this waypoint, using the same units and azimuth convention as
   * `wind`. Wind gusts are brief spikes in wind speed that can affect
   * activities such as driving high-profile vehicles, aviation, and
   * sailing.
   */
  windGust?: WindDetails;

  /**
   * The expected precipitation at this waypoint - radar reflectivity
   * (`dbz`) measuring intensity, plus the precipitation `type` (rain,
   * snow, ice, hail, or mix).
   */
  precipitation?: WeatherAlongRoutePrecipitation;

  /**
   * The number of lightning strikes expected near this waypoint during
   * the forecast period. **0** indicates no lightning activity; higher
   * values indicate more strikes, which can be used as a proxy for
   * thunderstorm intensity.
   */
  lightningCount?: int32;

  /**
   * The sun-glare driving hazard at this waypoint. Reports a glare
   * index from **0** to **100** along with the vehicle heading used to
   * compute it, where **50** and above can be hazardous and **100**
   * indicates driving directly into the sun under clear conditions.
   */
  sunGlare?: SunGlare;

  /**
   * The aggregated weather hazards at this waypoint - `maxHazardIndex`
   * gives the worst hazard's severity on the 0-4 scale, and
   * `hazardDetails` enumerates the specific hazards (heavy rain, snow,
   * ice, lightning, sun glare, severe weather warnings, and so on)
   * detected at the waypoint. Uses the same shape as
   * `WeatherAlongRouteSummary.hazards`, but scoped to this single
   * waypoint instead of the entire route.
   */
  hazards?: WeatherHazards;

  /**
   * Free-form hazard notifications relevant to this waypoint - each
   * `WeatherNotification` carries a hazard code, severity, and short
   * descriptive phrase. Empty when no notifications apply.
   */
  notifications?: WeatherNotification[];
}

/**
 * The expected precipitation at a single waypoint along the route,
 * returned as `WaypointForecast.precipitation`. Reports the forecast
 * intensity as radar reflectivity (`dbz`) together with the
 * precipitation `type` (rain, snow, ice, hail, or mix). A `dbz` of
 * **0** indicates no precipitation, in which case `type` may still be
 * returned to indicate the precipitation type that *would* occur if
 * any fell at the waypoint (for example, snow during cold weather).
 */
model WeatherAlongRoutePrecipitation {
  /**
   * Forecasted radar reflectivity in decibels relative to Z (dBZ),
   * used as a measure of precipitation intensity. Values range from
   * **0.0** to **100.0**; higher values indicate heavier
   * precipitation, and **0.0** indicates no precipitation.
   */
  dbz?: float64;

  /**
   * The type of precipitation expected at the waypoint - one of
   * `RAIN`, `HAIL`, `SNOW`, `ICE`, or `MIX`.
   */
  type?: string;
}

/**
 * The sun-glare driving hazard at a single waypoint, returned as
 * `WaypointForecast.sunGlare`. Reports a `glareIndex` from **0** to
 * **100** measuring the intensity of glare a driver would experience
 * at the waypoint, together with the `calculatedVehicleHeading` used
 * to compute it - the heading is either the value supplied for the
 * waypoint in the request or, if none was supplied, one inferred from
 * the neighboring waypoints.
 */
model SunGlare {
  /**
   * The vehicle heading used to compute `glareIndex`, in azimuth
   * degrees from **0°** (true North) to **359°**, measured clockwise -
   * east is 90°, south is 180°, west is 270°. If a heading was
   * supplied for the waypoint in the request, that value is echoed
   * back; otherwise the service calculates one from the headings of
   * the neighboring waypoints when available.
   */
  calculatedVehicleHeading?: int32;

  /**
   * An index from **0** to **100** indicating the intensity of sun
   * glare for a driver at the waypoint, given
   * `calculatedVehicleHeading` and the position of the sun. Values of
   * **50** and above can be hazardous for some drivers; **100**
   * indicates driving directly into the sun under clear conditions.
   */
  glareIndex?: int32;
}

/**
 * One free-form hazard notification raised at a single waypoint along the
 * route, returned as an entry in `WaypointForecast.notifications`. Each
 * notification combines a `type` classifying the notification, a
 * `hazardCode` identifying the specific hazard, a `hazardIndex` rating its
 * severity on the 0-4 scale, and a `shortPhrase` suitable for display.
 * Notifications complement `WaypointForecast.hazards` - the latter
 * enumerates every active hazard at the waypoint, while `notifications`
 * carries only the ones the service has flagged as worth surfacing to the
 * driver.
 */
model WeatherNotification {
  /**
   * A short label classifying the notification. Returned in the language
   * specified in the request.
   */
  type?: string;

  /**
   * The severity rating for this notification, on the same 0-4 scale used
   * across the Get Weather Along Route response:
   *
   * - **0**: No hazard
   * - **1**: Be informed, be aware
   * - **2**: Pay attention, be prepared
   * - **3**: Take action
   * - **4**: Life-threatening, emergency
   */
  hazardIndex?: HazardIndex;

  /**
   * A language-independent code identifying the specific hazard the
   * notification refers to. Uses the same set of values as
   * `HazardDetail.hazardCode`:
   *
   * - `LightRain`, `ModerateRain`, `HeavyRain`
   * - `LightMix`, `ModerateMix`, `HeavyMix`
   * - `LightSnow`, `ModerateSnow`, `HeavySnow`
   * - `LightIce`, `ModerateIce`, `HeavyIce`
   * - `Hail`, `LargeHail`
   * - `SunGlare`, `SunGlareHigh`
   * - `Lightning`, `SevereLightning`
   * - `WindModerate`, `WindHigh`, `WindExtreme`
   * - `FloodWarning`, `FlashFloodWarning`
   * - `TornadoWarning`, `TsunamiWarning`
   * - `SevereThunderstormWarning`
   */
  hazardCode?: string;

  /**
   * A short, displayable phrase describing the notification, returned in
   * the language specified in the request.
   */
  shortPhrase?: string;
}

/**
 * The response returned by the Get Severe Weather Alerts operation,
 * containing every severe weather alert active at the specified location.
 * Alerts cover phenomena such as hurricanes, thunderstorms, flooding,
 * lightning, heat waves, and forest fires - whatever local meteorological
 * authorities have issued. The `results` array is empty when no alerts are
 * in effect.
 */
model SevereWeatherAlertsResult {
  /**
   * The severe weather alerts active at the specified location, ordered by
   * `priority` (highest priority first). Empty when no alerts are in
   * effect.
   */
  @visibility(Lifecycle.Read)
  results?: SevereWeatherAlert[];
}

/**
 * One severe weather alert active at the specified location, returned as
 * an entry in `SevereWeatherAlertsResult.results`. Combines metadata about
 * the alert itself (country, identifier, category, severity classification,
 * priority, issuing source, and any disclaimer) with a `description`
 * carrying short localized and English summary phrases and an `alertAreas`
 * array describing the specific geographic areas the alert covers, the
 * times during which it is in effect, and the full alert detail. The
 * underlying alerts are issued by official government meteorological
 * agencies and leading global weather alert providers, and cover phenomena
 * such as hurricanes, thunderstorms, flooding, lightning, heat waves, and
 * forest fires.
 */
model SevereWeatherAlert {
  /**
   * The 2-character [ISO 3166-1 Alpha-2 country
   * code](https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes)
   * for the country or region the alert was issued in - for example,
   * `US` or `CA`.
   */
  countryCode?: string;

  /**
   * A numeric identifier for the alert, unique within the issuing
   * provider.
   */
  alertId?: int32;

  /**
   * Short summary phrases for the alert (for example, *Heat Warning* or
   * *Tornado Watch*), returned both in the language specified in the
   * request (`localized`) and in English (`english`).
   */
  description?: SevereWeatherAlertDescription;

  /**
   * A short, language-independent label classifying the alert by the
   * weather phenomenon it concerns - for example, `NON-PRECIPITATION`,
   * `PRECIPITATION`, `THUNDERSTORM`, `TROPICAL`, or `FIRE`. The exact
   * set of values depends on the issuing provider.
   */
  category?: string;

  /**
   * The importance of the alert within its originating country or
   * region, where **1** is the highest priority and larger numbers are
   * lower priority. The exact scale is provider-specific and may change
   * over time as alert systems evolve.
   */
  priority?: int32;

  /**
   * A provider-specific classification of the alert (for example, a
   * warning class or alert kind), when one is supplied by the issuing
   * agency. Not available in all countries and may be omitted.
   */
  class?: string;

  /**
   * The severity level of the alert, when one is supplied by the
   * issuing agency. The exact set of values is provider-specific. Not
   * available in all countries and may be omitted.
   */
  level?: string;

  /**
   * The name of the agency that issued the alert - for example,
   * *Environment Canada* or *U.S. National Weather Service*. Alerts are
   * typically issued by official government meteorological agencies or
   * leading global weather alert providers.
   */
  source?: string;

  /**
   * A numeric identifier for the source provider that pairs with
   * `source`. Suitable for stable, language-independent lookup of the
   * provider.
   */
  sourceId?: int32;

  /**
   * A disclaimer about the alert information from the source - for
   * example, a note about possible delays or data limitations. If
   * present, it must be displayed alongside the alert. Not always
   * returned.
   */
  disclaimer?: string;

  /**
   * The geographic areas covered by the alert. Each `AlertArea`
   * identifies one affected area by name, gives the alert's start and
   * end times for that area, the most recent alert status, and (when
   * the request asks for full details) the complete alert detail text.
   * An alert may cover one or several areas - for example, a heat
   * warning may apply to multiple adjacent regions on the same advisory.
   */
  alertAreas?: AlertArea[];
}

/**
 * Short summary phrases for a severe weather alert, returned on
 * `SevereWeatherAlert.description`. The same phrase is provided twice: once
 * translated into the language specified on the request (`localized`) and
 * once in English (`english`), so callers can display a localized label to
 * end users while still keeping a stable, language-independent string for
 * logging, matching, or fallback display.
 */
model SevereWeatherAlertDescription {
  /**
   * The summary phrase translated into the language specified on the request
   * (for example, *Avis de chaleur* for French). If no language was specified
   * on the request, this matches `english`.
   */
  localized?: string;

  /**
   * The summary phrase in English (en-US) - for example, *Heat Warning* or
   * *Tornado Watch*. Always returned in English regardless of the requested
   * language, which makes it suitable as a stable, language-independent
   * label.
   */
  english?: string;
}

/**
 * One geographic area covered by a severe weather alert, returned as an
 * entry in `SevereWeatherAlert.alertAreas`. Each `AlertArea` identifies the
 * affected area by `name`, gives the start and end times during which the
 * alert is in effect there (`startTime`, `endTime`), reports the most
 * recent status of the alert in that area (`latestStatus`), and carries a
 * short displayable `summary` of the alert. When the request asks for full
 * details, the complete alert text is also returned in `alertDetails`,
 * with `alertDetailsLanguageCode` identifying the language it is supplied
 * in.
 */
model AlertArea {
  /**
   * The name of the geographic area affected by the alert in this entry -
   * for example, *Kirkland Lake - Englehart*. Identifies the specific
   * region or locality the times, status, and detail text on this
   * `AlertArea` apply to.
   */
  name?: string;

  /**
   * A short, displayable summary of the alert for this area, including the
   * timeframe during which it is in effect and the issuing source. For
   * example, *Heat Warning in effect until Thursday, 3:16 AM EDT. Source:
   * Environment Canada*.
   */
  summary?: string;

  /**
   * The date and time at which the alert begins for this area, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   * If the alert spans multiple time zones, the value reflects the local
   * time at the coordinates supplied on the request.
   */
  startTime?: utcDateTime;

  /**
   * The date and time at which the alert ends or will end for this area,
   * in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   * If the alert spans multiple time zones, the value reflects the local
   * time at the coordinates supplied on the request.
   */
  endTime?: utcDateTime;

  /**
   * The most recent status of the alert in this area (for example,
   * whether it is newly issued, continuing, or has been canceled).
   * Returned as both a localized phrase and a language-independent
   * `LatestStatusKeyword` value.
   */
  latestStatus?: LatestStatus;

  /**
   * The complete free-form alert text issued by the source for this area,
   * suitable for displaying the full advisory. Returned only when the
   * request asks for full details. The text is returned in whatever
   * language the issuing provider supplied it in, which may differ from
   * the language requested for the rest of the response; the companion
   * `alertDetailsLanguageCode` identifies that language. Some countries
   * or regions may offer both their native language and English.
   */
  alertDetails?: string;

  /**
   * The language of `alertDetails`, as an [ISO 639-1 Alpha-2 language
   * code](https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes) -
   * for example, `en-CA` for Canadian English. May differ from the
   * language requested for the rest of the response. Returned only when
   * the request asks for full details.
   */
  alertDetailsLanguageCode?: string;
}

/**
 * The most recent status of a severe weather alert in a specific area,
 * returned on `AlertArea.latestStatus`. The same status keyword (one of
 * `New`, `Continue`, `Update`, `Correct`, `Extend`, `Upgrade`, `Cancel`,
 * or `Expire` - see `LatestStatusKeyword` for the complete list) is
 * returned twice: once translated into the language specified on the
 * request (`localized`), and once in English (`english`), so callers can
 * display a localized label to end users while still keeping a stable,
 * language-independent value for switching on status.
 */
model LatestStatus {
  /**
   * The status keyword translated into the language specified on the
   * request - for example, *Continu* for French. If no language was
   * specified on the request, this matches `english`.
   */
  localized?: string;

  /**
   * The status keyword in English (en-US) - one of the values defined by
   * `LatestStatusKeyword` (`New`, `Continue`, `Update`, `Correct`,
   * `Extend`, `Upgrade`, `Cancel`, or `Expire`). Always returned in
   * English regardless of the requested language, which makes it suitable
   * for stable, language-independent status checks.
   */
  english?: LatestStatusKeyword;
}

/**
 * The response returned by the Get Daily Indices operation, providing
 * activity-suitability ratings for the specified location. The `results`
 * array contains one `DailyIndex` entry per day per index, each scoring
 * the day's weather conditions for an outdoor activity such as running,
 * golfing, kite flying, or barbecuing.
 */
model DailyIndicesResult {
  /**
   * The daily index ratings for the queried location, in chronological
   * order starting with the current day. The array contains one
   * `DailyIndex` entry per day per index, with the number of days
   * controlled by the requested `duration` (1, 5, 10, or 15 days).
   */
  @visibility(Lifecycle.Read)
  results?: DailyIndex[];
}

/**
 * A single index rating in the `DailyIndicesResult.results` array, scoring
 * how well one day's weather conditions are suited to a particular outdoor
 * activity such as running, golfing, kite flying, or barbecuing. Each
 * entry includes the activity name (for example, *Ski Weather Forecast*),
 * the date it applies to, a numeric `value` from **0.0** to **10.0**, a
 * matching qualitative `category` label (for example, *Poor*), and a
 * short `description` of the conditions (for example, *Expect poor
 * conditions for skiing.*). A response may contain many entries - one
 * per day per index - covering each day in the requested `duration` and
 * each requested index.
 */
model DailyIndex {
  /**
   * The display name of the index, identifying the activity or condition
   * it rates - for example, *Running Forecast*, *Golf Weather Forecast*,
   * *Kite Flying Forecast*, or *Beach & Pool Forecast*. Returned in the
   * language specified in the request. For the full list of supported
   * indices, see [Index
   * IDs](/azure/azure-maps/weather-services-concepts#index-ids-and-index-groups-ids)
   * in the *Weather services in Azure Maps* concepts article.
   */
  indexName?: string;

  /**
   * The numeric identifier of the index, suitable for stable,
   * language-independent lookup of the activity that pairs with
   * `indexName`. For example, **1** identifies *Running Forecast*, **5**
   * identifies *Golf Weather Forecast*, and **9** identifies *Kite
   * Flying Forecast*. For the complete mapping, see [Index
   * IDs](/azure/azure-maps/weather-services-concepts#index-ids-and-index-groups-ids)
   * in the *Weather service in Azure Maps* concepts article.
   */
  indexId?: int32;

  /**
   * The date the index applies to, expressed as midnight local time at
   * the forecast location in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss±hh:mm) - for example,
   * *2020-07-14T07:00:00-04:00*. The time component is always 00:00:00 in
   * the location's local offset; treat this as the calendar day the
   * `value` and `category` cover, not as an observation timestamp.
   */
  dateTime?: utcDateTime;

  /**
   * The numeric suitability score for the activity on this day, from
   * **0.0** to **10.0**. By default **10.0** indicates the most favorable
   * conditions and **0.0** the least favorable, but a few indices invert
   * the scale - check `ascending` before interpreting the value. For
   * example, a `value` of **9.2** for the *Running Forecast* with
   * `ascending` = `true` means very good running weather. For the
   * per-index value-to-category ranges, see [Daily index range
   * sets](/azure/azure-maps/daily-index-range-sets) in the *Weather
   * services in Azure Maps* concepts article.
   */
  value?: float32;

  /**
   * A short qualitative label describing `value` and `categoryValue` -
   * for example, *Excellent*, *Very Good*, *Good*, *Fair*, *Poor*, or
   * *Very Poor*. The exact set of labels depends on the index (for
   * example, *Mosquito Activity* uses *Low*, *Moderate*, *High*, *Very
   * High*, *Extreme*). Returned in the language specified in the
   * request.
   */
  category?: string;

  /**
   * A 1-5 numeric rating that pairs with `category`, suitable for
   * stable, language-independent comparisons. The mapping between the
   * number and the qualitative label depends on `ascending`:
   *
   * - When `ascending` is `true`, **5** is the best rating and **1**
   *   the worst (for example, **5** = *Excellent*).
   * - When `ascending` is `false`, **1** is the best rating and **5**
   *   the worst (for example, for *Mosquito Activity*: **1** = *Low*,
   *   **2** = *Moderate*, **3** = *High*, **4** = *Very High*,
   *   **5** = *Extreme*).
   */
  categoryValue?: int32;

  /**
   * Indicates which end of the **0.0**-**10.0** `value` scale (and the
   * 1-5 `categoryValue` scale) is the most favorable, since the
   * direction varies by index:
   *
   * - `true`: higher is better - **10.0** is the best `value`, **0.0**
   *   the worst (for example, *Running Forecast*, *Golf Weather
   *   Forecast*).
   * - `false`: lower is better - **0.0** is the best `value`, **10.0**
   *   the worst (for example, *Mosquito Activity*, where the rating
   *   measures a hazard rather than a benefit).
   *
   * Use this flag whenever comparing `value` or `categoryValue` across
   * indices.
   */
  ascending?: boolean;

  /**
   * A short, human-readable explanation of the rating for this day,
   * suitable for display in a UI - for example, *This is an excellent
   * day for outdoor running!*, *This is a great day for golf.*, or
   * *Conditions are very good today for kite-flying.* Returned in the
   * language specified in the request.
   */
  description?: string;
}

/**
 * The response returned by the Get Tropical Storm Active operation, listing
 * every tropical storm currently active worldwide as reported by national
 * weather forecasting agencies. Each entry in the `results` array is an
 * `ActiveStorm` carrying the storm's name, originating ocean basin,
 * government-issued identifier, year of origin, and active and subtropical
 * status. When the result set is too large to fit in a single response,
 * `nextLink` carries the URL for the next page.
 */
model ActiveStormResult {
  /**
   * The currently active tropical storms, with one entry per storm. Each
   * `ActiveStorm` reports the storm's name (for example, *Hilda*), the
   * originating ocean basin (for example, *EP* for the Eastern Pacific),
   * the government-issued identifier and year of origin, and whether the
   * storm is still active and whether it is classified as subtropical.
   */
  results?: ActiveStorm[];

  /**
   * The URL to retrieve the next page of results when the response is
   * paginated, suitable for navigating through result sets too large to
   * return in a single call. Empty when there are no further pages.
   */
  nextLink?: string;
}

/**
 * A single tropical storm currently active worldwide, returned as one entry
 * in `ActiveStormResult.results`. Each entry summarizes the storm with the
 * identifiers needed to reference it elsewhere in the Get Tropical Storm
 * APIs - the originating ocean basin (`basinId`), the government-issued
 * identifier (`govId`), and the year of origin (`year`) - together with
 * the storm's official name (for example, *Hilda* or *LUPIT*) and flags
 * indicating whether it is still active and whether it is classified as
 * subtropical.
 */
model ActiveStorm {
  /**
   * The four-digit calendar year in which the tropical storm originated -
   * for example, *2021*. Combined with `basinId` and `govId`, this
   * uniquely identifies the storm across years.
   */
  year?: string;

  /**
   * The ocean basin where the tropical storm originated. One of the
   * `BasinId` values - **AL** (Atlantic), **CP** (Central Pacific),
   * **EP** (Eastern Pacific), **NI** (North Indian), **NP** (Northwest
   * Pacific), **SI** (South Indian), or **SP** (South Pacific). For
   * example, *EP* for a storm originating in the Eastern Pacific.
   */
  basinId?: BasinId;

  /**
   * The official name of the storm as designated by the relevant national
   * weather forecasting agency - for example, *Hilda* or *LUPIT*. Storms
   * that have not yet been formally named are typically identified by a
   * placeholder such as *TD 9E* or a number-word like *TWELVE*.
   */
  name?: string;

  /**
   * `true` if the tropical storm is currently active and still being
   * tracked by the issuing agency; `false` if it is no longer active.
   */
  isActive?: boolean;

  /**
   * `true` if the storm is classified as a subtropical cyclone - a hybrid
   * system with characteristics of both tropical and extratropical
   * cyclones; `false` otherwise.
   */
  isSubtropical?: boolean;

  /**
   * The government-issued identifier assigned to the storm by its
   * national weather forecasting agency, unique within
   * (`basinId`, `year`). Use this together with `basinId` and `year` to
   * reference the storm in the other Get Tropical Storm operations.
   */
  govId?: int32;
}

/**
 * The response returned by the Get Tropical Storm Search operation, listing
 * the tropical storms that match the supplied search criteria (typically a
 * basin and year). Each entry in the `results` array is a
 * `StormSearchResultItem` carrying the storm's name, originating ocean
 * basin, government-issued identifier, year of origin, and active,
 * retired, and subtropical status. When the result set is too large to
 * fit in a single response, `nextLink` carries the URL for the next page.
 */
model StormSearchResult {
  /**
   * The tropical storms matching the search criteria, with one entry per
   * storm. Each `StormSearchResultItem` reports the storm's name (for
   * example, *Ana*, *Ida*, or *Henri* in the *AL* basin for *2021*), the
   * originating ocean basin, the government-issued identifier and year of
   * origin, and whether the storm is still active, has been retired, and
   * whether it is classified as subtropical.
   */
  results?: StormSearchResultItem[];

  /**
   * The URL to retrieve the next page of results when the response is
   * paginated, suitable for navigating through result sets too large to
   * return in a single call. Empty when there are no further pages.
   */
  nextLink?: string;
}

/**
 * A single tropical storm matching a Get Tropical Storm Search request,
 * returned as one entry in `StormSearchResult.results`. Each entry
 * summarizes the storm with the identifiers needed to reference it
 * elsewhere in the Get Tropical Storm APIs - the originating ocean basin
 * (`basinId`), the government-issued identifier (`govId`), and the year of
 * origin (`year`) - together with the storm's official name (for example,
 * *Ana* or *Henri*) and flags indicating whether it is currently active,
 * has been retired, and whether it is classified as subtropical.
 */
model StormSearchResultItem {
  /**
   * The four-digit calendar year in which the tropical storm originated -
   * for example, *2021*. Combined with `basinId` and `govId`, this
   * uniquely identifies the storm across years.
   */
  year?: string;

  /**
   * The ocean basin where the tropical storm originated. One of the
   * `BasinId` values - **AL** (Atlantic), **CP** (Central Pacific),
   * **EP** (Eastern Pacific), **NI** (North Indian), **NP** (Northwest
   * Pacific), **SI** (South Indian), or **SP** (South Pacific). For
   * example, *AL* for a storm originating in the Atlantic basin.
   */
  basinId?: BasinId;

  /**
   * The official name of the storm as designated by the relevant national
   * weather forecasting agency - for example, *Ana*, *Henri*, or *Ida*.
   * Storms that have not yet been formally named are typically identified
   * by a placeholder such as *TD 9E* or a number-word like *TWELVE*.
   */
  name?: string;

  /**
   * `true` if the tropical storm is currently active and still being
   * tracked by the issuing agency; `false` if it is no longer active.
   */
  isActive?: boolean;

  /**
   * `true` if the storm's name has been permanently retired in its source
   * basin and will not be reused for future storms; `false` otherwise.
   * Names are typically retired only when a storm is so deadly or costly
   * that future use of the name would be inappropriate.
   */
  isRetired?: boolean;

  /**
   * `true` if the storm is classified as a subtropical cyclone - a hybrid
   * system with characteristics of both tropical and extratropical
   * cyclones; `false` otherwise.
   */
  isSubtropical?: boolean;

  /**
   * The government-issued identifier assigned to the storm by its national
   * weather forecasting agency, unique within (`basinId`, `year`). Use
   * this together with `basinId` and `year` to reference the storm in the
   * other Get Tropical Storm operations.
   */
  govId?: int32;
}

/**
 * The response returned by the Get Tropical Storm Forecast operation,
 * giving the official government-issued forecast track for a single
 * tropical storm identified by `basinId`, `govId`, and `year`. Each entry
 * in the `results` array is a `StormForecast` reporting the storm's
 * forecasted position, status, sustained wind and wind-gust speeds, and
 * forecast window for one point in time along the predicted track. When
 * the result set is too large to fit in a single response, `nextLink`
 * carries the URL for the next page.
 */
model StormForecastResult {
  /**
   * The forecast points along the storm's predicted track, in chronological
   * order. Each `StormForecast` reports the storm's position, classification
   * (for example, *Tropical Storm*), sustained wind and wind-gust speeds,
   * and the forecast window for one valid time - for example, a Northwest
   * Pacific (*NP*) storm forecast at *2021-04-25T06:00:00+00:00* at
   * (latitude *22*, longitude *137.8*) with a sustained wind of
   * *74.1 km/h* and a wind gust of *92.6 km/h*.
   */
  results?: StormForecast[];

  /**
   * The URL to retrieve the next page of results when the response is
   * paginated, suitable for navigating through result sets too large to
   * return in a single call. Empty when there are no further pages.
   */
  nextLink?: string;
}

/**
 * A single forecast point along a tropical storm's predicted track,
 * returned as one entry in `StormForecastResult.results`. Each entry
 * reports the storm's forecasted position, sustained wind and wind-gust
 * speeds, the storm's classification at the forecast time (for example,
 * *Tropical Storm*), and the forecast window for that valid time. When
 * the request asks for wind-radii detail, the entry also carries a
 * `windRadiiSummary` array describing the wind distribution around the
 * storm's center.
 */
model StormForecast {
  /**
   * The valid time of this forecast point - the future moment the
   * forecasted position and conditions apply to - in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example,
   * *2021-04-25T06:00:00+00:00*.
   */
  dateTime?: string;

  /**
   * The time at which the forecast was issued, in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example,
   * *2021-04-24T18:00:00+00:00*. Typically earlier than `dateTime`,
   * since a single forecast run predicts conditions at several future
   * valid times.
   */
  initializedDateTime?: string;

  /**
   * The storm's forecasted position at this point on the track, given as
   * latitude and longitude - for example, latitude *22*, longitude
   * *137.8*.
   */
  location?: LatLongPair;

  /**
   * The expected maximum short-burst wind-gust speed and direction at this
   * forecast point, measured in kilometers per hour (km/h) or miles per
   * hour (mph) depending on the unit specified in the request - for
   * example, *92.6 km/h*. Wind direction is in azimuth degrees, measured
   * clockwise from true North (0° = N, 90° = E, 180° = S, 270° = W). May
   * be NULL.
   */
  maxWindGust?: WeatherValue;

  /**
   * The maximum sustained wind speed expected at this forecast point,
   * measured in kilometers per hour (km/h) or miles per hour (mph)
   * depending on the unit specified in the request - for example,
   * *74.1 km/h*.
   */
  sustainedWind?: WeatherValue;

  /**
   * The storm's classification at this forecast point, in English - for
   * example, *Tropical Storm*. Possible values:
   *
   * - Cyclonic storm
   * - Deep depression
   * - Depression
   * - Extremely severe cyclonic storm
   * - Hurricane category (1-5)
   * - Intense tropical cyclone
   * - Moderate tropical storm
   * - Post-tropical cyclone
   * - Potential tropical cyclone
   * - Severe cyclonic storm
   * - Severe tropical storm
   * - Subtropical
   * - Super cyclonic storm
   * - Tropical cyclone
   * - Tropical cyclone category (1-5)
   * - Tropical depression
   * - Tropical disturbance
   * - Tropical storm
   * - Typhoon
   * - Very intense tropical cyclone
   * - Very severe cyclonic storm
   * - Very strong typhoon
   * - Violent typhoon
   */
  status?: string;

  /**
   * The forecast window covering this point on the track - the time range
   * the forecast applies to, the storm's classification at the start and
   * end of that range, and the left and right edges of the storm's
   * projected path. When the request asks for the window geometry,
   * `WeatherWindow.geometry` carries a GeoJSON representation of the
   * affected area.
   */
  window?: WeatherWindow;

  /**
   * Wind radii summaries describing the wind distribution around the
   * storm's center at this forecast point - one entry per wind-speed
   * threshold (such as the 34-, 50-, and 64-knot radii), each enumerating
   * how far winds at or above that speed extend in the NE, SE, SW, and NW
   * quadrants. Returned only when the request asks for wind-radii detail.
   */
  windRadiiSummary?: StormWindRadiiSummary[];
}

/**
 * The forecast window covering one segment of a tropical storm's predicted
 * track, returned as `StormForecast.window`. Each window represents the
 * area of uncertainty around the storm's projected path - bounded in time
 * by `beginDateTime` and `endDateTime` and laterally by the `left` and
 * `right` points marking the left and right edges of the path relative to
 * the storm's direction of travel - and reports the storm's classification
 * at the start and end of the segment (`beginStatus`, `endStatus`). When
 * the request asks for the window geometry, `geometry` carries a GeoJSON
 * representation of the affected area.
 */
model WeatherWindow {
  /**
   * The point at the left edge of the storm's projected path for this
   * segment - left relative to the storm's direction of travel - given as
   * latitude and longitude. For example, latitude *22.56387*, longitude
   * *137.739517*.
   */
  left?: LatLongPair;

  /**
   * The point at the right edge of the storm's projected path for this
   * segment - opposite `left`, right of the storm's direction of travel -
   * given as latitude and longitude. For example, latitude *21.4361*,
   * longitude *137.860489*.
   */
  right?: LatLongPair;

  /**
   * The date and time at which this segment of the forecast window begins,
   * in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  beginDateTime?: utcDateTime;

  /**
   * The date and time at which this segment of the forecast window ends,
   * in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  endDateTime?: utcDateTime;

  /**
   * The storm's classification at the start of this window segment - for
   * example, *Tropical Storm*. Uses the same set of values as
   * `StormForecast.status`.
   */
  beginStatus?: string;

  /**
   * The storm's classification at the end of this window segment - for
   * example, *Tropical Storm*. Uses the same set of values as
   * `StormForecast.status`.
   */
  endStatus?: string;

  /**
   * A GeoJSON representation of the area affected by the storm across this
   * window segment, suitable for rendering the projected path on a map.
   * Returned only when the request asks for the window geometry.
   */
  geometry?: GeoJsonGeometry;
}

/**
 * A wind radii summary describing the wind distribution around a tropical
 * storm's center for a single wind-speed threshold (typically the 34-,
 * 50-, or 64-knot radii). Returned as one entry per threshold in
 * `StormForecast.windRadiiSummary` (forecast track) or
 * `StormLocation.windRadiiSummary` (observed track) when the request asks
 * for wind-radii detail. Combines the threshold itself (`windSpeed`) with
 * a `radiusSectorData` array carrying one sector per quadrant (NE, SE,
 * SW, NW) that records how far winds at or above that speed extend from
 * the storm's center. When the request also asks for the radii geometry,
 * `radiiGeometry` carries a GeoJSON representation of the affected area.
 */
model StormWindRadiiSummary {
  /**
   * The valid time the wind-radii data applies to, in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: string;

  /**
   * The wind-speed threshold this entry describes (typically **34**, **50**,
   * or **64** knots). All four sectors in `radiusSectorData` describe the
   * extent of winds at or above this speed in their respective quadrants.
   * Reported in kilometers per hour (km/h) or miles per hour (mph)
   * depending on the unit specified in the request.
   */
  windSpeed?: WeatherValue;

  /**
   * One `RadiusSector` per compass quadrant - NE (0°-90°), SE (90°-180°),
   * SW (180°-270°), and NW (270°-360°) - giving the maximum distance from
   * the storm's center at which winds at or above `windSpeed` are expected
   * in that quadrant.
   */
  radiusSectorData?: RadiusSector[];

  /**
   * A GeoJSON representation of the area around the storm's center where
   * winds at or above `windSpeed` are expected, suitable for rendering the
   * wind radii on a map. Returned only when the request asks for the radii
   * geometry.
   */
  radiiGeometry?: GeoJsonGeometry;
}

/**
 * One quadrant of a tropical storm's wind radii, returned as one entry in
 * `StormWindRadiiSummary.radiusSectorData`. Each sector is bracketed in
 * direction by `beginBearing` and `endBearing` (azimuth degrees clockwise
 * from true North) and in distance by `range` (nautical miles), recording
 * how far winds at or above the parent summary's `windSpeed` threshold
 * extend in that quadrant. The four sectors on a `StormWindRadiiSummary`
 * typically span **0°-90°** (NE), **90°-180°** (SE), **180°-270°** (SW),
 * and **270°-360°** (NW).
 */
model RadiusSector {
  /**
   * The starting angle of the sector, in azimuth degrees clockwise from
   * true North (0° = N, 90° = E, 180° = S, 270° = W). For example, **0**
   * for the NE quadrant.
   */
  beginBearing?: float64;

  /**
   * The ending angle of the sector, using the same azimuth convention as
   * `beginBearing`. For example, **90** for the NE quadrant. Together with
   * `beginBearing`, this defines the sector's angular span.
   */
  endBearing?: float64;

  /**
   * The maximum distance from the storm's center, in nautical miles (NM),
   * at which winds at or above the parent
   * `StormWindRadiiSummary.windSpeed` threshold are expected within this
   * sector.
   */
  range?: float64;
}

/**
 * The response returned by the Get Tropical Storm Locations operation,
 * giving the observed track of a single tropical storm identified by
 * `basinId`, `govId`, and `year`. Each entry in the `results` array is a
 * `StormLocation` reporting the storm's position, classification, sustained
 * wind and wind-gust speeds, minimum pressure, movement, and lifecycle
 * flags at one observed point in time. When the result set is too large
 * to fit in a single response, `nextLink` carries the URL for the next
 * page.
 */
model StormLocationsResult {
  /**
   * The observed points along the storm's track, in reverse chronological
   * order (most recent observation first). Each `StormLocation` reports the
   * storm's position, classification (for example, *Tropical Depression*
   * or *Tropical Storm*), sustained wind and wind-gust speeds, minimum
   * pressure, and movement at one observation time - for example, a
   * Northwest Pacific (*NP*) storm observed at *2021-02-22T00:00:00+00:00*
   * at (latitude *10.4*, longitude *125.7*) with a sustained wind of
   * *46.3 km/h* and a wind gust of *64.8 km/h*.
   */
  results?: StormLocation[];

  /**
   * The URL to retrieve the next page of results when the response is
   * paginated, suitable for navigating through result sets too large to
   * return in a single call. Empty when there are no further pages.
   */
  nextLink?: string;
}

/**
 * A single observed location fix along a tropical storm's track, returned as
 * one entry in `StormLocationsResult.results`. Each entry captures where the
 * storm's center was at a specific point in time and the conditions observed
 * there - position (latitude/longitude), sustained wind and peak wind gust,
 * minimum central pressure, the storm's direction and forward speed of motion,
 * and its lifecycle classification (for example, *Tropical Depression* or
 * *Tropical Storm*). Together, the sequence of entries forms the storm's
 * observed track and is used to follow how its position, intensity, and
 * structure evolved.
 */
model StormLocation {
  /**
   * The date and time of the observation, in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss+hh:mm). For example, *2021-02-22T00:00:00+00:00*.
   * Successive entries in `StormLocationsResult.results` typically step
   * backward in time at a fixed cadence (for example, every 6 hours).
   */
  dateTime?: string;

  /**
   * Latitude and longitude coordinates of the storm's center at this
   * observation time. For example, latitude *10.4* and longitude *125.7*.
   */
  location?: LatLongPair;

  /**
   * The peak wind gust observed near the storm's center at this time, in
   * kilometers per hour (km/h) or miles per hour (mph) depending on the unit
   * specified in the request - for example, *64.8 km/h*. Wind gusts are short,
   * sudden bursts of wind that exceed the sustained wind reported in
   * `sustainedWind`. May be NULL when no gust observation is available.
   */
  maxWindGust?: WeatherValue;

  /**
   * The maximum 1-minute sustained wind associated with the storm at this
   * observation time, in kilometers per hour (km/h) or miles per hour (mph)
   * depending on the unit specified in the request - for example, *46.3 km/h*
   * for a tropical depression up to *83.3 km/h* once the system has reached
   * tropical-storm strength. Sustained wind, together with `status`, is the
   * primary measure of the storm's current intensity.
   */
  sustainedWind?: WeatherValue;

  /**
   * The lowest atmospheric pressure measured at the storm's center at this
   * time, in millibars (mb) or inches of mercury (inHg) depending on the unit
   * specified in the request. Lower central pressure generally indicates a
   * stronger storm. May be NULL when no pressure observation is available.
   */
  minimumPressure?: WeatherValue;

  /**
   * The direction the storm is moving and how fast it is moving in that
   * direction at this observation time. The direction is given in azimuth
   * degrees, measured clockwise from true North (0° = N, 90° = E, 180° = S,
   * 270° = W) - for example, **305°** with a localized description of *NW*, or
   * **270°** with a localized description of *W*. The forward speed is in
   * kilometers per hour (km/h) or miles per hour (mph) depending on the unit
   * specified in the request - for example, *9.3 km/h*.
   */
  movement?: WindDetails;

  /**
   * The storm's lifecycle classification at this observation time, in English.
   * Typical values include *Tropical Depression* (sustained winds below tropical-storm strength), *Tropical Storm*, and *Hurricane* / *Typhoon*
   * (depending on basin), and may also reflect subtropical or post-tropical
   * stages indicated by `isSubtropical` and `isPostTropical`.
   */
  status?: string;

  /**
   * `true` if at this observation time the storm is classified as a
   * subtropical cyclone - a hybrid system with characteristics of both
   * tropical and extratropical cyclones. `false` otherwise.
   */
  isSubtropical?: boolean;

  /**
   * `true` if at this observation time the system has the potential to develop
   * into a tropical cyclone, used to flag pre-genesis disturbances. `false`
   * otherwise.
   */
  hasTropicalPotential?: boolean;

  /**
   * `true` if at this observation time the storm has transitioned from a
   * tropical cyclone to a post-tropical cyclone (for example, an
   * extratropical or remnant low). `false` otherwise.
   */
  isPostTropical?: boolean;

  /**
   * The wind-radii summary observed around the storm's center at this time,
   * with one entry per wind-speed threshold (typically **34**, **50**, and
   * **64** knots). Each entry describes how far winds at or above that
   * threshold extended from the center in each compass quadrant (NE, SE, SW,
   * NW). Returned only when the request asks for wind radii detail.
   */
  windRadiiSummary?: StormWindRadiiSummary[];
}

/**
 * The response returned by the Get Current Air Quality operation, providing
 * the current air-quality conditions at a specified location. The `results`
 * array contains a single `AirQuality` entry summarizing the local and
 * globally-normalized air-quality indices, the dominant pollutant, a
 * qualitative category and matching color, a short description of the health
 * implications, and (when requested) per-pollutant detail.
 */
model AirQualityResult {
  /**
   * The current air-quality reading at the location, returned as a
   * single-element array. The entry reports the local air-quality index
   * (`index`), the internationally normalized index (`globalIndex`), the
   * `dominantPollutant` (for example, *Ozone*), a qualitative `category`
   * (such as *Fair*) with matching `categoryColor` (for example,
   * *#FFC300*), a short `description` of the health implications, and -
   * when the request asks for pollutant detail - a `pollutants` array
   * with one entry per measured pollutant.
   */
  results?: AirQuality[];

  /**
   * The URL to retrieve the next page of results when the response is
   * paginated, suitable for navigating through result sets too large to
   * return in a single call. Empty when there are no further pages.
   */
  nextLink?: string;
}

/**
 * The current air-quality reading at one location, returned as the entry in
 * `AirQualityResult.results`. Combines the air-quality index reported by the
 * local regulating body (`index`) with an internationally normalized index
 * (`globalIndex`), identifies the `dominantPollutant` driving the result,
 * and pairs them with a localized qualitative `category` and a matching
 * `categoryColor` suitable for color-coded UI. A short `description`
 * explains what the reading means for everyday activities and any health
 * precautions, and - when the request asks for pollutant detail - the
 * `pollutants` array carries a per-pollutant breakdown.
 */
model AirQuality {
  /**
   * The date and time the air-quality reading applies to, in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss+hh:mm). For example, *2021-07-19T02:00:00+00:00*.
   */
  dateTime?: utcDateTime;

  /**
   * The air-quality index (AQI) on the scale set by the local regulating
   * body for the queried location. AQI scales vary widely between countries
   * and regions, so the same numeric value can mean different things at
   * different locations - use `category` for a label that is consistent
   * across locations. For example, *21.6* on the scale used for the queried
   * location. For background, see [Air quality
   * index](https://en.wikipedia.org/wiki/Air_quality_index) on Wikipedia.
   */
  index?: float32;

  /**
   * An internationally normalized air-quality index that is comparable
   * across locations regardless of the local AQI scale. Ratings range from
   * 0 to 300 and up, with higher numbers indicating worse air quality. The
   * index covers concentrations of **PM2.5**, **PM10**, **NO2**, **SO2**,
   * **CO**, and **O3**. For example, *22.1*.
   */
  globalIndex?: float32;

  /**
   * The pollutant driving the current `index` and `globalIndex` - one of
   * the `DominantPollutant` values, such as *Ozone* or *NO2*. Useful for
   * surfacing which substance is most responsible for the current air
   * quality.
   */
  dominantPollutant?: DominantPollutant;

  /**
   * A short qualitative summary of the current air quality, returned in
   * the language specified in the request. Typical values include *Good*,
   * *Fair*, *Moderate*, *Poor*, and *Hazardous*; the exact set depends on
   * the regulating body for the queried location.
   */
  category?: string;

  /**
   * A hexadecimal color code matching `category`, suitable for color-coding
   * the air-quality reading in a UI - for example, *#FFC300* for *Fair*.
   * Each `category` value has a distinct color so that the reading can be
   * recognized at a glance.
   */
  categoryColor?: string;

  /**
   * A free-form sentence or two explaining the current air quality and
   * any precautions sensitive groups should consider, returned in the
   * language specified in the request. For example, *The air quality is
   * generally acceptable for most individuals. However, sensitive groups
   * may experience minor to moderate symptoms from long-term exposure.*
   */
  description?: string;

  /**
   * Per-pollutant detail behind the overall reading, with one `Pollutant`
   * entry per measured species (typically *Nitrogen Dioxide*, *Ozone*,
   * *Particulate Matter 10*, *Particulate Matter 2.5*, *Carbon Monoxide*,
   * and *Sulfur Dioxide*). Each entry reports the pollutant's
   * concentration and its individual `index` and `globalIndex`
   * contributions. Returned only when the request asks for pollutant
   * detail.
   */
  pollutants?: Pollutant[];
}

/**
 * A single pollutant measured at the queried location, returned as one entry
 * in `AirQuality.pollutants`. Each entry identifies the pollutant (by code
 * and English name), reports its measured `concentration` in the air, and
 * gives the pollutant's individual contribution to the local AQI (`index`)
 * and the internationally normalized index (`globalIndex`) - the same two
 * scales reported at the overall reading on `AirQuality`, but restricted
 * to this pollutant. A typical air-quality reading carries one entry per
 * pollutant - *Nitrogen Dioxide*, *Ozone*, *Particulate Matter 10*,
 * *Particulate Matter 2.5*, *Carbon Monoxide*, and *Sulfur Dioxide* - so
 * callers can see which substances are present and how much each
 * contributes.
 */
model Pollutant {
  /**
   * The pollutant code, used as a stable, language-independent identifier -
   * one of the `PollutantType` values (**PM2.5**, **PM10**, **O3**, **NO2**,
   * **SO2**, or **CO**). Additional pollutant types may be added in the
   * future.
   */
  type?: PollutantType;

  /**
   * The pollutant's English name that pairs with `type` - for example,
   * *Nitrogen Dioxide* for **NO2**, *Ozone* for **O3**, *Particulate Matter
   * 10* for **PM10**, *Particulate Matter 2.5* for **PM2.5**, *Carbon
   * Monoxide* for **CO**, or *Sulfur Dioxide* for **SO2**. Always returned
   * in English regardless of the requested language, which makes it
   * suitable as a stable display label when localized text is not
   * required.
   */
  name?: string;

  /**
   * This pollutant's contribution to the overall air-quality index (AQI)
   * on the scale set by the local regulating body for the queried
   * location. Uses the same local scale as `AirQuality.index`, so the
   * raw number is comparable to the overall reading at the same location
   * but not directly comparable across locations - for example, *21.6*
   * for *Ozone* on a reading with overall `index` *21.6* (Ozone is the
   * dominant pollutant). For background, see [Air quality
   * index](https://en.wikipedia.org/wiki/Air_quality_index) on Wikipedia.
   */
  index?: float32;

  /**
   * This pollutant's contribution to the internationally normalized
   * air-quality index, on the same 0-to-300+ scale as
   * `AirQuality.globalIndex` so that per-pollutant values can be
   * compared across locations. Higher values denote a larger
   * contribution to poor air quality. For example, *22.1* for *Ozone*
   * or *6.7* for *Nitrogen Dioxide*.
   */
  globalIndex?: float32;

  /**
   * The pollutant's measured concentration in the air, in micrograms per
   * cubic meter (µg/m³) for *NO2*, *O3*, *PM10*, *PM2.5*, *CO*, and
   * *SO2* - for example, *53.5 µg/m³* for *Ozone* or *13.4 µg/m³* for
   * *Nitrogen Dioxide* - or in parts per million (ppm) when reported in
   * that unit. Concentration is the raw measurement that feeds into
   * `index` and `globalIndex`.
   */
  concentration?: WeatherValue;
}

/**
 * The response returned by the Get Daily Air Quality Forecasts operation,
 * containing one forecasted air-quality reading per day for the queried
 * location across the requested forecast horizon. The horizon is set by the
 * caller's requested forecast duration (a `DailyDuration` value of 1, 2, 3,
 * 4, 5, 6, or 7 days), so `results` carries that many entries in
 * chronological order - for example, a 3-day request returns daily readings
 * for *2021-07-18*, *2021-07-19*, and *2021-07-20*. Each entry summarizes
 * the day's expected air quality on the same scales used by the current
 * air-quality reading, so it pairs naturally with `AirQualityResult` for
 * showing "today plus the next several days" views.
 */
model DailyAirQualityForecastResult {
  /**
   * The list of forecasted daily air-quality readings for the queried
   * location, one entry per day, in chronological order starting with the
   * earliest forecasted day. The number of entries matches the requested
   * forecast duration - for example, a 3-day request returns three entries
   * with `dateTime` values *2021-07-18T07:00:00+00:00*,
   * *2021-07-19T07:00:00+00:00*, and *2021-07-20T07:00:00+00:00*. Each
   * entry reports the day's `index`, `globalIndex`, `dominantPollutant`,
   * `category`, `categoryColor`, and a textual `description`.
   */
  results?: DailyAirQuality[];

  /**
   * The URL to retrieve the next page of results when the response is
   * paginated, suitable for navigating through result sets too large to
   * return in a single call. Empty when there are no further pages.
   */
  nextLink?: string;
}

/**
 * The forecasted air-quality reading for a single day at the queried
 * location, returned as one entry in `DailyAirQualityForecastResult.results`.
 * Each entry summarizes the day's expected air quality on the same scales
 * used by `AirQuality` for the current reading - the local AQI (`index`),
 * the internationally normalized index (`globalIndex`), the
 * `dominantPollutant`, a short `category` label (for example, *Fair*) and
 * matching `categoryColor` swatch (for example, *#FFC300*), and a textual
 * `description` of what the reading means for people. Across the entries
 * in a single forecast response the values typically evolve from day to
 * day - in the example response *globalIndex* runs *42.2* -> *37* -> *40*
 * across three consecutive days while the dominant pollutant stays
 * *Ozone*.
 */
model DailyAirQuality {
  /**
   * The day this forecast covers, in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss+hh:mm) - for example,
   * *2021-07-18T07:00:00+00:00*. Forecast entries within a single
   * response use sequential `dateTime` values, one per day.
   */
  dateTime?: utcDateTime;

  /**
   * The forecasted overall air-quality index (AQI) for the day, on the
   * scale set by the local regulating body for the queried location. Like
   * `AirQuality.index`, this is comparable across days at the same
   * location - for example, *35.1*, *31.6*, and *33.6* on three
   * consecutive days - but not directly comparable across locations
   * because each region uses its own scale. Use `category` for a
   * location-independent label. For background, see [Air quality
   * index](https://en.wikipedia.org/wiki/Air_quality_index) on Wikipedia.
   */
  index?: float32;

  /**
   * The forecasted air-quality index on the internationally normalized
   * 0-to-300+ scale, where higher values denote poorer air quality. The
   * scale is the same as `AirQuality.globalIndex`, so values are
   * comparable across locations and across days - for example, *42.2*,
   * *37*, and *40* on three consecutive forecast days. The index reflects
   * concentrations of **PM2.5**, **PM10**, **NO2**, **SO2**, **CO**, and
   * **O3**.
   */
  globalIndex?: float32;

  /**
   * The pollutant expected to have the highest concentration during the
   * day - one of the `DominantPollutant` values, for example *Ozone*.
   * This is the pollutant that typically drives the day's `index` and
   * `globalIndex` values.
   */
  dominantPollutant?: DominantPollutant;

  /**
   * A one-word summary of the day's forecasted air quality (for example,
   * *Excellent*, *Fair*, or *Poor*), returned in the requested language.
   * Pairs with `categoryColor` for a quick visual cue and with
   * `description` for a longer explanation. Because the label is
   * derived from the local AQI bands, it is comparable across locations
   * even when raw `index` values are not.
   */
  category?: string;

  /**
   * The hexadecimal color associated with `category`, suitable for
   * styling a UI swatch or badge - for example, *#FFC300* for *Fair*.
   * Categories and colors are consistent across daily forecast entries
   * so the same label always renders with the same color.
   */
  categoryColor?: string;

  /**
   * A short, human-readable explanation of the day's forecasted air
   * quality and any precautions it suggests, returned in the requested
   * language - for example, *"The air quality is generally acceptable
   * for most individuals. However, sensitive groups may experience minor
   * to moderate symptoms from long-term exposure."* Intended for direct
   * display alongside `category` and `categoryColor`.
   */
  description?: string;
}

/**
 * The response returned by the Get Daily Historical Actuals operation,
 * containing one observed historical weather record per day for the queried
 * location across the requested date range. The range is set by the
 * caller's requested start and end dates (up to 31 days), so `results`
 * carries one entry per day in chronological order - for example, a
 * 3-day request spanning *2012-01-20* through *2012-01-22* returns three
 * entries with `date` values *2012-01-20T00:00:00-04:00*,
 * *2012-01-21T00:00:00-04:00*, and *2012-01-22T00:00:00-04:00*. Each
 * entry reports what actually happened that day - observed minimum,
 * maximum, and average temperature plus precipitation, snowfall, snow
 * depth, and heating/cooling degree-day totals - which makes the
 * response useful for backfilling weather history into reports or
 * climatology studies.
 */
model DailyHistoricalActualsResult {
  /**
   * The list of observed historical weather records for the queried
   * location, one entry per day, in chronological order starting with
   * the earliest day in the requested range. The number of entries
   * matches the number of days from the requested start date through
   * the requested end date (up to 31 days). Each entry reports the
   * day's `temperature` (`minimum`, `maximum`, and `average`),
   * `precipitation`, `snowfall`, `snowDepth`, and `degreeDaySummary`
   * (`heating` and `cooling`).
   */
  results?: DailyHistoricalActuals[];

  /**
   * The URL to retrieve the next page of results when the response is
   * paginated, suitable for navigating through result sets too large to
   * return in a single call. Empty when there are no further pages.
   */
  nextLink?: string;
}

/**
 * The observed weather summary for a single past day at the queried
 * location, returned as one entry in `DailyHistoricalActualsResult.results`.
 * Each entry reports what was actually measured that day - minimum,
 * maximum, and average `temperature`; accumulated `precipitation`,
 * `snowfall`, and `snowDepth`; and a `degreeDaySummary` of heating and
 * cooling demand. Across the entries in a single response the values
 * change from day to day - in the example response the average daily
 * temperature warms from *-8.6 °C* on *2012-01-20* to *-5.3 °C* on
 * *2012-01-21* to *-3.6 °C* on *2012-01-22*, while accumulated snow
 * depth on the ground falls from *15.2 cm* to *12.7 cm* to *10.2 cm*
 * over the same three days.
 */
model DailyHistoricalActuals {
  /**
   * The day this observation covers, in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss+hh:mm) - for example,
   * *2012-01-20T00:00:00-04:00*. Observation entries within a single
   * response use sequential `date` values, one per day.
   */
  date?: utcDateTime;

  /**
   * The observed minimum, maximum, and average air temperature for the
   * day at the queried location, in degrees Celsius (°C) or Fahrenheit
   * (°F) depending on the unit specified in the request - for example,
   * minimum *-11.1 °C*, maximum *-6.1 °C*, and average *-8.6 °C* on
   * *2012-01-20*. The `WeatherValueMaxMinAvg` shape pairs naturally with
   * the same three-value pattern used by the records and normals
   * responses for the same calendar day.
   */
  temperature?: WeatherValueMaxMinAvg;

  /**
   * Observed heating and cooling degree-day totals for the day at the
   * queried location, used to estimate energy demand for building
   * climate control. Heating degree-days accumulate when the average
   * temperature is below the reference balance point and cooling
   * degree-days accumulate when it is above - for example, the cold
   * winter day *2012-01-20* records `degreeDaySummary.heating` of
   * *27 °C* and `degreeDaySummary.cooling` of *0 °C*.
   */
  degreeDaySummary?: DegreeDaySummary;

  /**
   * The amount of liquid-equivalent precipitation (rain plus melted
   * snow) that fell during the day at the queried location, in
   * millimeters (mm) or inches (in) depending on the unit specified in
   * the request - for example, *10.9 mm* on *2012-01-20* (a wet day)
   * compared with *0 mm* on the following two dry days.
   */
  precipitation?: WeatherValue;

  /**
   * The amount of new snow that fell during the day at the queried
   * location, in centimeters (cm) or inches (in) depending on the unit
   * specified in the request - for example, *12.19 cm* on
   * *2012-01-20*, *0.51 cm* on *2012-01-21*, and *0 cm* on
   * *2012-01-22*. Snowfall is the day's fresh accumulation;
   * `snowDepth` is the total depth left on the ground.
   */
  snowfall?: WeatherValue;

  /**
   * The total depth of snow on the ground at the queried location at
   * the end of the day, in centimeters (cm) or inches (in) depending
   * on the unit specified in the request - for example, *15.2 cm*,
   * *12.7 cm*, and *10.2 cm* on three consecutive days as the
   * snowpack settles and melts. Snow depth reflects the combined
   * effect of all prior `snowfall` minus melting and compaction.
   */
  snowDepth?: WeatherValue;
}

/**
 * A three-value temperature summary - `minimum`, `maximum`, and `average` -
 * for a single day at the queried location, in degrees Celsius (°C) or
 * Fahrenheit (°F) depending on the unit specified in the request. Used for
 * the `temperature` field on `DailyHistoricalActuals` (what was actually
 * observed on the day) and on `DailyHistoricalNormals` (the 30-year average
 * for that calendar day) so the two responses can be compared
 * field-for-field. For example, on *2012-01-20* the observed reading was
 * minimum *-11.1 °C*, maximum *-6.1 °C*, and average *-8.6 °C*, while the
 * 30-year normal for the same calendar day was minimum *-3.7 °C*, maximum
 * *4.4 °C*, and average *0.4 °C* - the difference reveals an unusually
 * cold day relative to climate normals.
 */
model WeatherValueMaxMinAvg {
  /**
   * The highest temperature for the day at the queried location, in
   * degrees Celsius (°C) or Fahrenheit (°F) depending on the unit
   * specified in the request - for example, *-6.1 °C* observed on
   * *2012-01-20* or *4.4 °C* as the 30-year normal for that calendar
   * day.
   */
  maximum?: WeatherValue;

  /**
   * The lowest temperature for the day at the queried location, in
   * degrees Celsius (°C) or Fahrenheit (°F) depending on the unit
   * specified in the request - for example, *-11.1 °C* observed on
   * *2012-01-20* or *-3.7 °C* as the 30-year normal for that calendar
   * day. Always less than or equal to `maximum`.
   */
  minimum?: WeatherValue;

  /**
   * The mean temperature for the day at the queried location, in
   * degrees Celsius (°C) or Fahrenheit (°F) depending on the unit
   * specified in the request - for example, *-8.6 °C* observed on
   * *2012-01-20* or *0.4 °C* as the 30-year normal for that calendar
   * day. Falls between `minimum` and `maximum`.
   */
  average?: WeatherValue;
}

/**
 * The response returned by the Get Daily Historical Records operation,
 * containing one all-time record summary per calendar day for the queried
 * location across the requested date range. The range is set by the
 * caller's requested start and end dates (up to 31 days), so `results`
 * carries one entry per calendar day in chronological order - for
 * example, a 3-day request spanning *2012-01-20* through *2012-01-22*
 * returns three entries with `date` values *2012-01-20T00:00:00-04:00*,
 * *2012-01-21T00:00:00-04:00*, and *2012-01-22T00:00:00-04:00*. Each
 * entry reports the most extreme values ever recorded at the location
 * for that calendar day across the full historical archive (record
 * high and low temperature, plus record-setting precipitation and
 * snowfall), each tagged with the year the record was set - useful for
 * comparing today's conditions against the all-time benchmarks for the
 * same date.
 */
model DailyHistoricalRecordsResult {
  /**
   * The list of all-time record summaries for the queried location, one
   * entry per calendar day, in chronological order starting with the
   * earliest day in the requested range. The number of entries matches
   * the number of days from the requested start date through the
   * requested end date (up to 31 days). Each entry reports the day's
   * record `temperature` (`maximum`, `minimum`, and the long-term
   * `average`), record `precipitation`, and record `snowfall`, each
   * paired with the `year` the extreme was observed - for example, the
   * record low on *2012-01-22* is *-21.7 °C* set in *1984*.
   */
  results?: DailyHistoricalRecords[];

  /**
   * The URL to retrieve the next page of results when the response is
   * paginated, suitable for navigating through result sets too large to
   * return in a single call. Empty when there are no further pages.
   */
  nextLink?: string;
}

/**
 * The all-time record summary for a single calendar day at the queried
 * location, returned as one entry in `DailyHistoricalRecordsResult.results`.
 * Each entry reports the most extreme values ever recorded at the location
 * for that calendar day across the full historical archive: the record
 * high and low `temperature` (each tagged with the `year` it was set, plus
 * the long-term average for the date), the record `precipitation` total,
 * and the record `snowfall` total. Across the entries in a single response
 * the records vary by date - in the example response the record high
 * temperature climbs *18.3 °C* (set in *1951*) on *2012-01-20*, then
 * *16.7 °C* (*1959*) on *2012-01-21*, then *21.1 °C* (*1906*) on
 * *2012-01-22*, while the record lows fall *-19.4 °C* (*1984*),
 * *-21.1 °C* (*1985*), and *-21.7 °C* (*1984*) on the same three days.
 */
model DailyHistoricalRecords {
  /**
   * The calendar day this record summary covers, in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss+hh:mm) - for example,
   * *2012-01-20T00:00:00-04:00*. Only the month and day are meaningful
   * for record lookups; the year on `date` is the year of the request,
   * while the year of each individual record is carried on the
   * `WeatherValueYear.year` field.
   */
  date?: utcDateTime;

  /**
   * The record-setting `maximum` and `minimum` temperatures ever
   * observed at the queried location for this calendar day - each
   * tagged with the year the record was set - together with the
   * long-term `average` temperature for the date, in degrees Celsius
   * (°C) or Fahrenheit (°F) depending on the unit specified in the
   * request. For example, on *2012-01-20* the record high is
   * *18.3 °C* (set in *1951*), the record low is *-19.4 °C*
   * (*1984*), and the long-term average is *-0.6 °C*.
   */
  temperature?: WeatherValueYearMaxMinAvg;

  /**
   * The largest single-day precipitation total ever observed at the
   * queried location for this calendar day, tagged with the year it
   * was set, in millimeters (mm) or inches (in) depending on the unit
   * specified in the request - for example, *48 mm* set in *1978* on
   * *2012-01-20*. Only the record `maximum` is reported because
   * minimum precipitation for any calendar day is trivially zero.
   */
  precipitation?: WeatherValueYearMax;

  /**
   * The largest single-day snowfall total ever observed at the queried
   * location for this calendar day, tagged with the year it was set,
   * in centimeters (cm) or inches (in) depending on the unit specified
   * in the request - for example, *12.19 cm* set in *1978* on
   * *2012-01-20*, or *34.29 cm* set in *2014* on *2012-01-21*. Only
   * the record `maximum` is reported because minimum snowfall for any
   * calendar day is trivially zero.
   */
  snowfall?: WeatherValueYearMax;
}

/**
 * The record-temperature triple for a single calendar day at a location -
 * record `maximum` and `minimum` (each tagged with the year the record was
 * set) plus the long-term `average` for that calendar date. Used as the
 * `temperature` field on `DailyHistoricalRecords`. Values are in degrees
 * Celsius (°C) or Fahrenheit (°F) depending on the unit specified in the
 * request. For example, on *2012-01-20* the record high is *18.3 °C* set
 * in *1951*, the record low is *-19.4 °C* set in *1984*, and the
 * long-term average for the date is *-0.6 °C*.
 */
model WeatherValueYearMaxMinAvg {
  /**
   * The all-time highest temperature ever observed at the queried
   * location for this calendar day, tagged with the year the record was
   * set, in degrees Celsius (°C) or Fahrenheit (°F) depending on the
   * unit specified in the request - for example, *18.3 °C* set in
   * *1951* on *2012-01-20*. Always greater than or equal to `minimum`.
   */
  maximum?: WeatherValueYear;

  /**
   * The all-time lowest temperature ever observed at the queried
   * location for this calendar day, tagged with the year the record was
   * set, in degrees Celsius (°C) or Fahrenheit (°F) depending on the
   * unit specified in the request - for example, *-19.4 °C* set in
   * *1984* on *2012-01-20*. Always less than or equal to `maximum`.
   */
  minimum?: WeatherValueYear;

  /**
   * The long-term average temperature for this calendar day at the
   * queried location, in degrees Celsius (°C) or Fahrenheit (°F)
   * depending on the unit specified in the request - for example,
   * *-0.6 °C* on *2012-01-20*. The average is a multi-year climate
   * value tied to the calendar date rather than to any single year, so
   * unlike `maximum` and `minimum` it is a `WeatherValue` and carries
   * no `year` field.
   */
  average?: WeatherValue;
}

/**
 * A single record-setting measurement tagged with the year the record was
 * set, used as a building block for the all-time daily extremes returned
 * on `DailyHistoricalRecords` - specifically the record `maximum` and
 * record `minimum` of `WeatherValueYearMaxMinAvg` (record-high and
 * record-low temperature) and the record `maximum` of
 * `WeatherValueYearMax` (greatest precipitation, snowfall, and similar
 * accumulated metrics). Each entry pairs the `value` and its `unit`/
 * `unitType` with the `year` in which that value was observed at the
 * queried location for the calendar day in question - for example,
 * *21.1 °C* set in *1906* (record high on *2012-01-22*), *-21.7 °C* set
 * in *1984* (record low on *2012-01-22*), or *48 mm* of precipitation
 * set in *1978*.
 */
model WeatherValueYear {
  /**
   * The numeric record value, in the unit specified by `unit` /
   * `unitType` - for example, *21.1* for the *21.1 °C* record high on
   * *2012-01-22*, *-21.7* for the *-21.7 °C* record low on the same
   * day, or *48* for the *48 mm* precipitation record set in *1978*.
   * The metric this value represents (record-high temperature,
   * record-low temperature, greatest precipitation, greatest snowfall,
   * and so on) is determined by which `WeatherValueYearMaxMinAvg` or
   * `WeatherValueYearMax` field this entry appears under.
   */
  value?: float32;

  /**
   * Short string label for the unit of `value` - for example, *C* for
   * Celsius or *F* for Fahrenheit on temperature records, *mm* or *in*
   * on precipitation records, and *cm* or *in* on snowfall records.
   * Which unit is used depends on the unit specified in the request.
   */
  unit?: string;

  /**
   * An integer representing the type of unit. For a complete list, see
   * [Unit types](/azure/azure-maps/weather-services-concepts#unit-types)
   * in the article Weather services in Azure Maps.
   */
  unitType?: int32;

  /**
   * The four-digit calendar year in which `value` was observed at the
   * queried location for this calendar day, identifying when the record
   * was set - for example, *1906* for the record high on *2012-01-22*,
   * *1984* for the record low on the same day, and *1978* for the
   * record precipitation. Note that the `year` of the surrounding
   * `DailyHistoricalRecords.date` is just the year from the request
   * window and is unrelated to the record year reported here; only the
   * month and day of `date` identify the calendar day whose all-time
   * record is being returned.
   */
  year?: int32;
}

/**
 * A single-value record-high summary for a calendar day at the queried
 * location: only `maximum` (tagged with the year the record was set
 * via `WeatherValueYear`). Used by `DailyHistoricalRecords.precipitation`
 * and `DailyHistoricalRecords.snowfall` to report the greatest amount
 * ever observed on that calendar day. Carries no minimum because the
 * lowest amount of precipitation or snowfall for any given calendar
 * day is trivially zero and therefore uninformative; symmetric metrics
 * like temperature use `WeatherValueYearMaxMinAvg` instead.
 */
model WeatherValueYearMax {
  /**
   * The all-time greatest amount ever observed at the queried location
   * for this calendar day, tagged with the year the record was set.
   * Units depend on which `DailyHistoricalRecords` field this entry
   * appears under - precipitation values are in millimeters (mm) or
   * inches (in), and snowfall values are in centimeters (cm) or inches
   * (in), each according to the unit specified in the request. For
   * example, *48 mm* of precipitation set in *1978*, or *12.19 cm* of
   * snowfall set in *1978* (with *34.29 cm* set in *2014* on a
   * different calendar day).
   */
  maximum?: WeatherValueYear;
}

/**
 * The response returned by the Get Daily Historical Normals operation,
 * containing the daily climate-normal series for the requested location
 * and calendar-day range. Each day's normals are 30-year averages
 * computed over the *1991-2020* climate baseline. Up to 31 contiguous
 * calendar days can be returned in a single response.
 */
model DailyHistoricalNormalsResult {
  /**
   * The per-day climate-normal entries, one per calendar day in the
   * requested range, in chronological order. Each entry carries the
   * normal `temperature` (high, low, and average), the normal
   * `precipitation` accumulation, and a `degreeDaySummary` (cooling
   * and heating degree days) for that calendar day - all 30-year
   * averages over the *1991-2020* baseline. For example, the entry
   * for *2012-01-20* reports a normal high of *4.4 °C*, a normal low
   * of *-3.7 °C*, a normal average of *0.4 °C*, *2.5 mm* of
   * precipitation, and *0* cooling / *18* heating degree days.
   */
  results?: DailyHistoricalNormals[];

  /**
   * The URL of the next page of results, if any. Present when the
   * response is paginated and additional pages are available; absent
   * on the final page.
   */
  nextLink?: string;
}

/**
 * A single calendar day of climate-normal data for the queried
 * location, computed as a 30-year average over the *1991-2020*
 * climate baseline. Bundles the normal `temperature` (high, low, and
 * average), the normal `precipitation` accumulation, and a
 * `degreeDaySummary` (cooling and heating degree days) for that day.
 * Returned as one element of `DailyHistoricalNormalsResult.results`,
 * in chronological order.
 */
model DailyHistoricalNormals {
  /**
   * The calendar day these normals describe, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) extended format with
   * a time-zone offset (yyyy-mm-ddThh:mm:ss+hh:mm). For example,
   * *2012-01-20T00:00:00-04:00* - the time component is always
   * *00:00:00* and the offset reflects the queried location's standard
   * time.
   */
  date?: utcDateTime;

  /**
   * The 30-year normal high, low, and average temperatures for this
   * calendar day at the queried location, computed over the
   * *1991-2020* baseline. Values are in degrees Celsius (°C) or
   * Fahrenheit (°F) according to the unit specified in the request -
   * for example, on *2012-01-20* the normal high is *4.4 °C*, the
   * normal low is *-3.7 °C*, and the normal average is *0.4 °C*.
   */
  temperature?: WeatherValueMaxMinAvg;

  /**
   * The 30-year normal cooling and heating degree days for this
   * calendar day at the queried location, computed over the
   * *1991-2020* baseline. For *2012-01-20* this entry reports *0*
   * cooling degree days and *18* heating degree days, with `unit` *C*
   * indicating the temperature scale used to compute them.
   */
  degreeDaySummary?: DegreeDaySummary;

  /**
   * The 30-year normal precipitation accumulation for this calendar
   * day at the queried location, computed over the *1991-2020*
   * baseline. Values are in millimeters (mm) or inches (in) according
   * to the unit specified in the request - for example, *2.5 mm* of
   * precipitation on *2012-01-20*.
   */
  precipitation?: WeatherValue;
}
