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
 * A numeric value that corresponds to an image displaying the `iconPhrase`.
 * These icons visually represent various weather conditions. For more
 * information including a complete list of icons and phrases, see [Weather
 * services in Azure
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
 * An integer value associated with the type of unit being displayed. Can be
 * used for unit translation. For more information, see [Weather services in
 * Azure Maps ](/azure/azure-maps/weather-services-concepts#unit-types).
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
 * Specifies the type of precipitation. Valid values are Rain, Snow, Ice, or
 * Mix. This property is included in the response when dBZ is greater than zero.
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

  /** 7:00 am - 1:00 pm / 7:00- 13:00 */
  FirstQuarter: 0,

  /** 1:00 pm - 7:00 pm/ 13:00- 19:00 */
  SecondQuarter: 1,

  /** 7:00 pm - 1:00 am/ 19:00 - 01:00 */
  ThirdQuarter: 2,

  /** 1:00 am - 7:00 am/ 01:00 - 07:00 */
  ForthQuarter: 3,
}

/**
 * The aggregated severity/hazard index for each waypoint can be utilized to
 * color-code segments of a route, indicating the safety level for drivers.
 *
 * - 0: No hazard.
 * - 1: Be informed, be aware.
 * - 2: Pay attention, be prepared.
 * - 3: Take action.
 * - 4: Life threatening, emergency.
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
   * no changes were made to `alertDetails`, `startTime`, `endTime`, or `class`.
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
   * The **Atlantic Ocean**. Crucial for tracking hurricanes that affect the
   * Americas and the Caribbean. It is one of the most active regions for
   * tropical storms.
   */
  AL: "AL",

  /**
   * The **Central Pacific Ocean**. This basin is used for storms affecting Hawaii
   * and surrounding areas.
   */
  CP: "CP",

  /**
   * The **Eastern Pacific Ocean**. This basin tracks storms impacting the western
   * coast of the Americas, including Mexico and Central America. It is adjacent
   * to the Central Pacific basin.
   */
  EP: "EP",

  /**
   * The **North Indian Ocean**. This basin covers storms impacting South Asia,
   * including countries like India and Bangladesh, which are frequently
   * affected by cyclones.
   */
  NI: "NI",

  /**
   * The **Northwest Pacific Ocean**. This basin is important for tracking typhoons
   * that affect East Asia, including countries like China, Japan, and the
   * Philippines. It is the most active tropical storm regions globally.
   */
  NP: "NP",

  /**
   * The **South Indian Ocean**. This basin, positioned south of the equator, covers
   * cyclones impacting Madagascar, Africa, and surrounding regions.
   */
  SI: "SI",

  /**
   * The **South Pacific Ocean**. This basin, positioned south of the equator, is
   * relevant for cyclones affecting Australia and the South Pacific islands.
   */
  SP: "SP",
}

/** Identifies the pollutant with the highest concentration. */
union DominantPollutant {
  string,

  /**
   * Carbon monoxide (CO) is a colorless, odorless, and tasteless but highly
   * toxic gas produced by the incomplete combustion of carbon-containing fuels.
   * Common sources include vehicle exhaust, gas stoves, furnaces, and wood
   * fires.
   */
  `Carbon Monoxide`: "Carbon Monoxide",

  /**
   * Nitrogen dioxide (NO2) is a significant atmospheric pollutant. It is
   * regulated and subject to recommended limit guidelines set by the World
   * Health Organization (WHO).
   */
  `Nitrogen Dioxide`: "Nitrogen Dioxide",

  /**
   * Ozone (O3) is a key component of photochemical smog, the brown, harmful
   * haze that envelops many large cities, resulting from a photochemical
   * reaction between sunlight and certain specific pollutants.
   */
  Ozone: "Ozone",

  /**
   * Particulate matter 2.5 (PM2.5) also known as aerosols, is a mix of fine
   * dust and tiny liquid droplets suspended in the air. There are 4
   * categories:
   *
   * - PM10 (Course)
   * - PM2.5 (Fine)
   * - PM1 (very fine)
   * - PM0.1 (ultrafine).
   */
  `Particulate Matter 2.5`: "Particulate Matter 2.5",

  /**
   * Particulate matter 10 (PM10) also known as aerosols, is a mix of fine dust
   * and tiny liquid droplets suspended in the air. There are 4 categories of
   * particulate matter:
   *
   * - PM10 (Course)
   * - PM2.5 (Fine)
   * - PM1 (very fine)
   * - PM0.1 (ultrafine).
   */
  `Particulate Matter 10`: "Particulate Matter 10",

  /**
   * Sulfur dioxide (SO2) is a heavy, colorless inorganic gas with a pungent,
   * irritating odor. It is mainly produced by burning fossil fuels at power
   * plants and industrial facilities, but it can also be emitted from natural
   * sources such as volcanoes.
   */
  `Sulfur Dioxide`: "Sulfur Dioxide",
}

/** A description for each type of pollutant, such as **CO**, **NO2**, **O3**, **PM10**, **PM2.5** and **SO2**. */
union PollutantType {
  string,

  /**
   * The average concentration of carbon monoxide (CO) in parts per million
   * (ppm) over the past hour.
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
   * droplets suspended in the air. There are four categories of particulate
   * matter:
   *
   * - PM10 (Course)
   * - PM2.5 (Fine)
   * - PM1 (very fine)
   * - PM0.1 (ultrafine).
   */
  PM2_5: "PM2.5",

  /**
   * The average concentration of particles with diameters between 2.5 and 10
   * microns, measured in micrograms per cubic meter (µg/m³) over the past hour.
   *
   * Particulate matter 10 (PM10), also known as aerosols, consists of fine dust
   * and tiny liquid droplets suspended in the air. There are four categories of
   * particulate matter:
   *
   * - PM10 (Course)
   * - PM2.5 (Fine)
   * - PM1 (very fine)
   * - PM0.1 (ultrafine).
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

/** An array of `HourlyForecast` objects, one for each of the requested hours. */
model HourlyForecastResult {
  /** An array of `HourlyForecast` objects, one for each of the requested hours. */
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
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  date?: utcDateTime;

  /**
   * A numeric value that corresponds to an image displaying the `iconPhrase`.
   * For more information, see [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * A descriptive term that corresponds to a specific weather condition, such
   * as 'Sunny'. It is paired with an `iconCode`, which is a numeric value
   * representing an image that visually depicts the weather condition described
   * by the `iconPhrase`. For more information, see [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
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
   * Celsius (C) or Fahrenheit (F), depending on the unit specified in the
   * request.
   */
  temperature?: WeatherValue;

  /**
   * Provides RealFeel™ Temperature values for the specified hour, measured in
   * degrees Celsius (C) or Fahrenheit (F), depending on the unit specified in
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
   * to form. It is measured in degrees Fahrenheit (F) or Celsius (C), depending
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

/** Returns the expected wind speed and direction. */
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
   * specified in the request. For example, 'N' for North, 'E' for East, 'S' for
   * South, and 'W' for West.
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
 * An array of minute-by-minute weather forecasts for a specified location,
 * detailing precipitation type, intensity, cloud cover, and temperature for
 * each interval.
 */
model MinuteForecastResult {
  /** Phrase summaries for the entire forecast period. */
  @visibility(Lifecycle.Read)
  summary?: MinuteForecastSummary;

  /**
   * Provides concise weather summaries for each forecast interval, detailing
   * start and end times, duration, and a brief description, such as "Rain
   * ending in 25 min."
   */
  @visibility(Lifecycle.Read)
  intervalSummaries?: IntervalSummary[];

  /**
   * Contains an array of `ForecastInterval` objects, each providing detailed
   * forecast data for a specific time interval within the minute-by-minute
   * forecast.
   */
  @visibility(Lifecycle.Read)
  intervals?: ForecastInterval[];
}

/** Phrase summaries for the entire forecast period. */
model MinuteForecastSummary {
  /** Summary phrase for the next 60 minutes. Phrase length is approximately 60 characters. */
  briefPhrase60?: string;

  /** Short summary phrase for the next 120 minutes. Phrase length is approximately 25 characters. */
  shortPhrase?: string;

  /** Summary phrase for the next 120 minutes. Phrase length is approximately 60 characters. */
  briefPhrase?: string;

  /** Long summary phrase for the next 120 minutes. Phrase length is 60+ characters. */
  longPhrase?: string;

  /**
   * A numeric value that corresponds to an image displaying the `iconPhrase`.
   * For more information, see [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;
}

/**
 * The `IntervalSummary` provides a summary of weather conditions for a specified
 * interval. This object includes aggregated data such as average precipitation
 * intensity, predominant precipitation type, and overall cloud cover for the
 * interval. It helps users quickly understand the general weather trends over
 * the forecast period
 */
model IntervalSummary {
  /** Specifies the first minute of the forecast interval for which the summary applies. */
  startMinute?: int32;

  /** Specifies the last minute of the forecast interval for which the weather data is provided. */
  endMinute?: int32;

  /** The number of minutes for which the summary applies. */
  totalMinutes?: int32;

  /** A short phrase describing precipitation condition for the interval. Up to 25 characters. */
  shortPhrase?: string;

  /** A brief phrase describing precipitation condition for the interval. Up to 60 characters. */
  briefPhrase?: string;

  /**
   * A long phrase describing precipitation condition for the interval. Supports
   * more than 60 characters.
   */
  longPhrase?: string;

  /**
   * A numeric value that corresponds to an image displaying the `iconPhrase`.
   * For more information, see [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;
}

/**
 * Provides minute-by-minute weather forecasts for a specified location over the
 * next 120 minutes. Forecasts can be requested in 1, 5, or 15 minutes
 * intervals.
 */
model ForecastInterval {
  /**
   * Date and time of the start of the forecast interval, displayed in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  startTime?: utcDateTime;

  /** Specifies the first minute of the forecast interval for which the weather data is provided. */
  minute?: int32;

  /**
   * dBZ is a unit used to measure the intensity of precipitation. It indicates
   * the strength of the radar signal when it bounces off raindrops, snowflakes,
   * or hail. Higher dBZ values correspond to heavier precipitation.
   */
  dbz?: float64;

  /** A brief description of the expected weather conditions during the forecast interval. */
  shortPhrase?: string;

  /**
   * Specifies the precipitation intensity level at which a certain type of
   * precipitation (such as rain, snow, or ice) is considered significant. This
   * helps categorize and visualize precipitation events based on their
   * intensity. Along with `precipitationType`, it is used to determine the
   * `simplifiedColor`. This property is included in the response when dBZ is
   * greater than zero.
   */
  threshold?: string;

  /**
   * The full spectrum color that maps to the dBZ. This property is included in
   * the response when dBZ is greater than zero.
   */
  color?: ColorValue;

  /**
   * Used for visual representations based on precipitation type and threshold.
   * It maps colors to specific precipitation types and their intensities,
   * making it easier to quickly identify weather conditions without detailed
   * color mappings. This is suitable for applications that require quick,
   * easy-to-understand visual cues. This property is included in the response
   * when dBZ is greater than zero.
   */
  simplifiedColor?: ColorValue;

  /**
   * Specifies the type of precipitation. Valid values are Rain, Snow, Ice, or
   * Mix. This property is included in the response when `dBZ` is greater than
   * zero.
   */
  precipitationType?: PrecipitationType;

  /**
   * A numeric value that corresponds to an image displaying the `iconPhrase`.
   * For more information, see [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * The percentage of the sky covered by clouds at the specified time. Valid
   * values range from 0% (no clouds) to 100% (completely overcast). May be
   * NULL.
   */
  cloudCover?: int32;
}

/**
 * The full spectrum color that maps to the `dBZ`. A value is only returned if
 * the `dBZ` value is greater than zero. Used to provide a visual representation
 * of various weather conditions. For more information on color mappings, see
 * [Weather service in Azure
 * Maps](/azure/azure-maps/weather-services-concepts#radar-images).
 */
model ColorValue {
  /** Red component of the RGB value. Valid values range from 0-255. */
  red?: int32;

  /** Green component of the RGB value. Valid values range from 0-255. */
  green?: int32;

  /** Blue component of the RGB value. Valid values range from 0-255. */
  blue?: int32;

  /** Hexadecimal color value. For example, red is '#FF0000'. */
  hex?: string;
}

/**
 * Returns an array of `QuarterDayForecast` objects, each providing detailed
 * forecast data for the requested quarter-day periods.
 */
model QuarterDayForecastResult {
  /**
   * An array of all requested quarter-day forcast results, each providing
   * detailed forecast data for a specific quarter-day forecast.
   */
  @visibility(Lifecycle.Read)
  forecasts?: QuarterDayForecast[];
}

/**
 * Provides detailed weather forecasts for the requested quarter-day period
 * (morning, afternoon, evening, overnight) at the specified location. Each
 * forecast includes comprehensive data such as temperature, dew point,
 * humidity, wind speed and direction, visibility, cloud cover, and
 * precipitation probability, type, and intensity.
 */
model QuarterDayForecast {
  /**
   * Date of the forecast in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)
   * format (yyyy-mm-ddThh:mm:ss-hh:mm). For example,
   * *2025-06-19T00:00:00+00:00*.
   */
  date?: utcDateTime;

  /**
   * Date and time at the beginning of the quarter day forecast, displayed in
   * [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  effectiveDate?: utcDateTime;

  /**
   * Specifies the quarter-day period:
   *
   * - 0: morning (7am - 1pm)
   * - 1: afternoon (1pm - 7pm)
   * - 2: evening (7pm - 1am)
   * - 3: overnight (1am - 7am)
   */
  quarter?: DayQuarter;

  /**
   * A numeric value that corresponds to an image displaying the `iconPhrase`.
   * For more information, see [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * A one or two word descriptive term that corresponds to a specific weather
   * condition, such as 'Sunny'. It is paired with an `iconCode`, which is a
   * numeric value representing an image that visually depicts the weather
   * condition described by the `iconPhrase`. For more information, see [Weather
   * services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconPhrase?: string;

  /**
   * Provides a brief textual description of the weather conditions for each
   * quarter of the day. It uses more descriptive terms than iconePhrase, which
   * might return 'Thunderstorms' where phrase returns 'Cloudy with a couple of
   * showers and a thunderstorm'. This makes it easy to understand and integrate
   * into applications for clear and concise weather forecasts.
   */
  phrase?: string;

  /**
   * The expected temperature for the specified quarter-day period, measured in
   * degrees Celsius (C) or Fahrenheit (F), depending on the unit specified in
   * the request.
   */
  temperature?: WeatherValueRange;

  /**
   * Provides RealFeel™ Temperature values for the specified quarter-day period,
   * measured in degrees Celsius (C) or Fahrenheit (F), depending on the unit
   * specified in the request. This metric, developed by AccuWeather,
   * incorporates over a dozen factors, including humidity, wind speed, cloud
   * cover, and sun intensity, to offer a comprehensive measure of how the
   * weather actually feels.
   *
   * For more information, see [What is the AccuWeather RealFeel
   * Temperature?](https://www.accuweather.com/en/weather-news/what-is-the-accuweather-realfeel-temperature/156655)
   */
  realFeelTemperature?: WeatherValueRange;

  /**
   * The temperature at which air becomes saturated with moisture and dew begins
   * to form. It is measured in degrees Fahrenheit (F) or Celsius (C), depending
   * on the unit specified. This value is crucial for understanding humidity
   * levels, as a higher dew point indicates more moisture in the air, making it
   * feel more humid.
   */
  dewPoint?: WeatherValue;

  /**
   * The amount of water vapor present in the air, expressed as a percentage of
   * the maximum amount the air can hold at the same temperature. This value
   * indicates how close the air is to being saturated with moisture, affecting
   * how comfortable or humid the environment feels.
   */
  relativeHumidity?: int32;

  /**
   * Provides the expected wind speed and direction. Wind speed is measured in
   * kilometers per hour (km/h) or miles per hour (mph), based on the specified
   * unit. Wind direction is measured in azimuth degrees, ranging from 0° (true
   * North) to 359°, moving clockwise (east is 90°, south is 180°, west is
   * 270°).
   */
  wind?: WindDetails;

  /**
   * Expected maximum wind gust speed and direction during each quarter of the
   * forecast period, measured in kilometers per hour (km/h) or miles per hour
   * (mph), based on the specified unit. Wind direction is given in azimuth
   * degrees, ranging from 0° (true North) to 359°, moving clockwise. This is
   * important for understanding short-term variations in wind speed, which can
   * impact activities such as aviation, sailing, and outdoor events.
   */
  windGust?: WindDetails;

  /**
   * Returns the distance at which an object or light can be clearly discerned
   * for each quarter of the forecast period, measured in kilometers (km) or
   * miles (mi), depending on the unit specified in the request. This indicates
   * how far one can clearly see, which is crucial for activities like driving
   * and aviation.
   */
  visibility?: WeatherValue;

  /**
   * The percentage of the sky covered by clouds at a given location during the
   * specified timeframe. This value ranges from 0% (clear skies) to 100%
   * (completely overcast). May be NULL.
   */
  cloudCover?: int32;

  /**
   * A boolean value that indicates whether precipitation (rain, snow, sleet, or
   * hail) is expected during the specified timeframe. Returns true if
   * precipitation is expected, otherwise false.
   */
  hasPrecipitation?: boolean;

  /**
   * Indicates the type of precipitation, which can be *Rain*, *Snow*, *Ice*, or
   * *Mix*. This property is included in the response when `hasPrecipitation` is
   * true.
   */
  precipitationType?: PrecipitationType;

  /**
   * Indicates the intensity of precipitation (light, moderate, heavy). Only
   * returned if `hasPrecipitation` is true.
   */
  precipitationIntensity?: string;

  /**
   * Shows the probability of precipitation during the specified quarter-day
   * period, expressed as a percentage from 0 to 100. A value of 0 means no
   * chance of precipitation, while 100 means precipitation is certain. This
   * helps users assess the likelihood of rain, snow, or other forms of
   * precipitation.
   */
  precipitationProbability?: int32;

  /**
   * Shows the probability of a thunderstorm occurring during the specified
   * quarter-day period, expressed as a percentage from 0 to 100. A value of 0
   * means no chance of a thunderstorm, while 100 means a thunderstorm is
   * certain.
   */
  thunderstormProbability?: int32;

  /**
   * Indicates the total amount of liquid precipitation (such as rain) expected
   * during each quarter of the forecast period, measured in millimeters (mm) or
   * inches (in), depending on the unit specified in the request.
   */
  totalLiquid?: WeatherValue;

  /**
   * Returns the amount of rainfall expected during the specified quarter-day
   * period, measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  rain?: WeatherValue;

  /**
   * Returns the amount of snow accumulation expected during the specified
   * quarter-day period, measured in millimeters (mm) or inches (in), depending
   * on the unit specified in the request.
   */
  snow?: WeatherValue;

  /**
   * Returns estimated ice accumulation for each quarter-day period in the
   * forecast, measured in millimeters (mm) or inches (in), depending on the
   * unit specified in the request.
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
   * degrees Celsius (C) or Fahrenheit (F), based on the unit specified in the
   * request.
   */
  minimum?: WeatherValue;

  /**
   * Provides the maximum temperature for the specified timeframe, measured in
   * degrees Celsius (C) or Fahrenheit (F), based on the unit specified in the
   * request.
   */
  maximum?: WeatherValue;
}

/** Current weather conditions result. */
model CurrentConditionsResult {
  /**
   * An array of `CurrentConditions` objects. The number of objects corresponds
   * to the `duration` parameter specified in the request (0, 6, or 24),
   * representing the most current weather conditions, 6 hourly conditions, or
   * 24 hourly conditions.
   */
  @visibility(Lifecycle.Read)
  results?: CurrentConditions[];
}

/**
 * Returns current weather conditions for a specific location. By default, if
 * the `details` URI parameter is not provided, a simplified version of the data
 * is returned, including the observation date and time, weather description,
 * icon code, precipitation indicator, and temperature. When the `details` URI
 * parameter is set to *true*, all properties are included.
 */
model CurrentConditions {
  /**
   * Date and time of the current observation, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: utcDateTime;

  /**
   * A descriptive term that corresponds to a specific weather condition, such
   * as 'Sunny'. It is paired with an `iconCode`, which is a numeric value
   * representing an image that visually depicts the weather condition described
   * by the `iconPhrase`. For more information, see [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  phrase?: string;

  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons). May be
   * NULL.
   */
  iconCode?: IconCode;

  /**
   * A boolean value that indicates the presence of precipitation (such as rain,
   * snow, sleet, hail). Returns true if precipitation is expected, otherwise
   * false.
   */
  hasPrecipitation?: boolean;

  /**
   * Indicates whether it is currently daytime at the specified location.
   * Returns true for daytime and false for nighttime.
   */
  isDayTime?: boolean;

  /**
   * The current temperature for the specified location, measured in degrees
   * Celsius (C) or Fahrenheit (F), depending on the unit specified in the
   * request.
   */
  temperature?: WeatherValue;

  /**
   * The current RealFeel™ Temperature values, measured in degrees Celsius (C)
   * or Fahrenheit (F), depending on the unit specified in the request. This
   * metric, developed by AccuWeather, incorporates over a dozen factors,
   * including humidity, wind speed, cloud cover, and sun intensity, to offer a
   * comprehensive measure of how the weather actually feels.
   *
   * For more information, see [What is the AccuWeather RealFeel
   * Temperature?](https://www.accuweather.com/en/weather-news/what-is-the-accuweather-realfeel-temperature/156655
   */
  realFeelTemperature?: WeatherValue;

  /**
   * A temperature value that uses a variety of factors to determine how the
   * temperature actually feels outside in the shade, measured in degrees
   * Celsius (C) or Fahrenheit (F), depending on the unit specified in the
   * request.
   */
  realFeelTemperatureShade?: WeatherValue;

  /**
   * The amount of water vapor present in the air, expressed as a percentage of
   * the maximum amount the air can hold at the same temperature. This value
   * indicates how close the air is to being saturated with moisture, affecting
   * how comfortable or humid the environment feels.
   */
  relativeHumidity?: int32;

  /**
   * The temperature at which air becomes saturated with moisture and dew begins
   * to form. It is measured in degrees Fahrenheit (F) or Celsius (C), depending
   * on the unit specified. This value is crucial for understanding humidity
   * levels, as a higher dew point indicates more moisture in the air, making it
   * feel more humid.
   */
  dewPoint?: WeatherValue;

  /**
   * Provides the current wind speed and direction. Wind speed is measured in
   * kilometers per hour (km/h) or miles per hour (mph), based on the specified
   * unit. Wind direction is measured in azimuth degrees, ranging from 0° (true
   * North) to 359°, moving clockwise (east is 90°, south is 180°, west is
   * 270°).
   */
  wind?: WindDetails;

  /**
   * Returns the current expected maximum short-burst wind speed and direction,
   * measured in kilometers per hour (km/h) or miles per hour (mph), depending
   * on the unit specified in the request. Wind direction is given in azimuth
   * degrees, ranging from 0° (true North) to 359°, moving clockwise. Wind gusts
   * are a sudden, brief increase in wind speed, important for understanding
   * short-term variations that can impact activities like aviation, sailing,
   * kite flying and other outdoor events.
   */
  windGust?: WindDetails;

  /**
   * Provides the current ultraviolet (UV) index, helping users understand the
   * current risk of sun exposure. Supported values are:
   *
   * - 0-2: Low danger from the sun's UV rays or the average person.
   * - 3-5: Moderate risk of harm from unprotected sun exposure.
   * - 6-7: High risk of harm from unprotected sun exposure.
   * - 8-10: Very high risk of harm from unprotected sun exposure.
   * - 11+: Extreme risk of harm from unprotected sun exposure.
   */
  uvIndex?: int32;

  /**
   * Descriptive phrase indicating the current level of UV radiation, such as
   * Low, Moderate, High, or Very High, to help users understand sun exposure
   * risk.
   */
  uvIndexPhrase?: string;

  /**
   * Returns the distance at which an object or light can be clearly discerned,
   * measured in kilometers (km) or miles (mi), depending on the unit specified
   * in the request. This indicates how far one can clearly see, which is
   * crucial for activities like driving and aviation.
   */
  visibility?: WeatherValue;

  /**
   * Identifies any factors that may impair visibility. This can include
   * elements such as fog, smoke, haze, or heavy precipitation, providing
   * crucial information for activities that depend on clear visibility, like
   * driving or aviation.
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
   * The percentage of the sky covered by clouds, ranging from 0% (clear sky) to
   * 100% (completely overcast). May be NULL.
   */
  cloudCover?: int32;

  /**
   * Cloud ceiling: The height of the lowest layer of clouds above the ground,
   * measured in feet or meters, depending on the unit specified in the request.
   * This value is crucial for aviation and weather forecasting, as it indicates
   * the altitude at which clouds begin to form, affecting visibility and flight
   * safety.
   */
  ceiling?: WeatherValue;

  /**
   * Atmospheric pressure (measured air pressure at ground level) in millibars
   * (mb) or inches of mercury (inHg), depending on the unit specified in the
   * request.
   */
  pressure?: WeatherValue;

  /**
   * Provides information about the trend of atmospheric pressure over a
   * specified period. This property indicates whether the pressure is rising,
   * falling, or steady, which can be useful for understanding short-term
   * weather changes.
   */
  pressureTendency?: PressureTendency;

  /**
   * Indicates the difference between the current temperature and the
   * temperature recorded 24 hours ago, measured in degrees Celsius (C) or
   * Fahrenheit (F), depending on the unit specified in the request. This value
   * helps to understand how much the temperature has changed over the past day,
   * providing insights into short-term temperature trends.
   */
  pastTwentyFourHourTemperatureDeparture?: WeatherValue;

  /**
   * Apparent temperature represents how the outdoor temperature feels to
   * humans, considering air temperature, relative humidity, and wind speed. It
   * is measured in degrees Celsius (C) or Fahrenheit (F), depending on the unit
   * specified in the request. This value provides a more accurate
   * representation of perceived temperature rather than the actual air
   * temperature.
   */
  apparentTemperature?: WeatherValue;

  /**
   * Indicates the perceived temperature felt on exposed skin due to the
   * combined effect of wind and cold air. This temperature is typically lower
   * than the actual air temperature and is measured in degrees Celsius (°C) or
   * Fahrenheit (°F), based on the unit specified in the request.
   */
  windChillTemperature?: WeatherValue;

  /**
   * Temperature air would reach if cooled to saturation (100% relative
   * humidity) by evaporating water into it at constant pressure, crucial for
   * assessing heat stress and evaporation cooling. Measured in degrees Celsius
   * (C) or Fahrenheit (F), depending on the unit specified in the request.
   */
  wetBulbTemperature?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * 1, 3, 6, 9, 12, 18 and 24 hours, measured in millimeters (mm) or inches
   * (in), depending on the unit specified in the request. This property helps
   * users understand recent precipitation trends and current conditions at a
   * specific location.
   */
  precipitationSummary?: PrecipitationSummary;

  /**
   * Provides the highest and lowest temperatures recorded over the past 6, 12
   * and 24 hours, measured in degrees Celsius (C) or Fahrenheit (F), depending
   * on the unit specified in the request.
   */
  temperatureSummary?: TemperatureSummary;
}

/**
 * Indicates the trend of atmospheric pressure over a specified period, showing
 * whether the pressure is rising, falling, or steady. This information is
 * useful for understanding short-term weather changes.
 */
model PressureTendency {
  /** Description of the pressure tendency in the language specified in the request. */
  localizedDescription?: string;

  /**
   * Pressure tendency codes universally understood: **F** for Falling, **S** for
   * Steady, and **R** for Rising.
   */
  code?: string;
}

/**
 * Summary of precipitation amounts over the past 24 hours, with measurements at
 * the following intervals: 1, 3, 6, 9, 12, 18, and 24 hours.
 */
model PrecipitationSummary {
  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * hour, measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  pastHour?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * three hours, measured in millimeters (mm) or inches (in), depending on the
   * unit specified in the request.
   */
  past3Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * six hours, measured in millimeters (mm) or inches (in), depending on the
   * unit specified in the request.
   */
  past6Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * nine hours, measured in millimeters (mm) or inches (in), depending on the
   * unit specified in the request.
   */
  past9Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * 12 hours, measured in millimeters (mm) or inches (in), depending on the
   * unit specified in the request.
   */
  past12Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * 18 hours, measured in millimeters (mm) or inches (in), depending on the
   * unit specified in the request.
   */
  past18Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * 24 hours, measured in millimeters (mm) or inches (in), depending on the
   * unit specified in the request.
   */
  past24Hours?: WeatherValue;
}

/** Provides the highest and lowest temperatures recorded over the past 6, 12 and 24 hours. */
model TemperatureSummary {
  /** Provides the highest and lowest temperatures recorded over the past 6 hours. */
  past6Hours?: PastHoursTemperature;

  /** Provides the highest and lowest temperatures recorded over the past 12 hours. */
  past12Hours?: PastHoursTemperature;

  /** Provides the highest and lowest temperatures recorded over the past 24 hours. */
  past24Hours?: PastHoursTemperature;
}

/** Provides the highest and lowest temperature recorded for the past 6, 12 and 24 hours. */
model PastHoursTemperature {
  /** The lowest temperature recorded during the specified timeframe. */
  minimum?: WeatherValue;

  /** The highest temperature recorded during the specified timeframe. */
  maximum?: WeatherValue;
}

/** Daily weather forecast result. */
model DailyForecastResult {
  /**
   * Summary for the main conditions for the requested time period. Notice that
   * summary can cover only part of the time period.
   */
  @visibility(Lifecycle.Read)
  summary?: DailyForecastSummary;

  /**
   * Forecast data for each requested day.
   */
  @visibility(Lifecycle.Read)
  forecasts?: DailyForecast[];
}

/**
 * Summary for the main conditions for the requested time period. Notice that
 * summary can cover only part of the time period.
 */
model DailyForecastSummary {
  /**
   * The start date and time for the forecast summary, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as
   * *2019-10-27T19:39:57-08:00*.
   */
  startDate?: utcDateTime;

  /**
   * The end date and time for the forecast summary, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as
   * *2019-10-27T19:39:57-08:00*.
   */
  endDate?: utcDateTime;

  /**
   * Severity values indicate a level of danger assigned to the weather event.
   * Lower numbers represent higher severity. The following list shows all
   * possible values along with a description for each level.
   *
   * Severity (Description)
   *
   * - 0 (Unknown)
   * - 1 (Significant)
   * - 2 (Major)
   * - 3 (Moderate)
   * - 4 (Minor)
   * - 5 (Minimal)
   * - 6 (Insignificant)
   * - 7 (Informational)
   */
  severity?: int32;

  /**
   * Provides a brief textual summary of the daily weather conditions, displayed
   * in the specified language.
   */
  phrase?: string;

  /**
   * Provides a one or two-word summary of the forecasted weather conditions,
   * such as Sunny, Partly Cloudy, Rain, or Snow.
   */
  category?: string;
}

/**
 * Provides detailed weather information for a specific day, such as
 * temperature, wind, precipitation, air quality, and UV index.
 *
 * Provides comprehensive weather information for a specific day. This object
 * includes various properties that detail different aspects of the daily
 * weather forecast.
 */
model DailyForecast {
  /**
   * Date of the daily forecast, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  date?: utcDateTime;

  /**
   * Provides the forecasted high and low temperatures for the day, in degrees
   * Celsius (C) or Fahrenheit (F), depending on the `unit` specified in the
   * request.
   */
  temperature?: WeatherValueRange;

  /**
   * Provides RealFeel™ Temperature values for the specified day, measured in
   * degrees Celsius (C) or Fahrenheit (F), depending on the unit specified in
   * the request. This metric, developed by AccuWeather, incorporates over a
   * dozen factors, including humidity, wind speed, cloud cover, and sun
   * intensity, to offer a comprehensive measure of how the weather actually
   * feels.
   *
   * For more information, see [What is the AccuWeather RealFeel
   * Temperature?](https://www.accuweather.com/en/weather-news/what-is-the-accuweather-realfeel-temperature/156655)
   */
  realFeelTemperature?: WeatherValueRange;

  /**
   * Provides RealFeel™ Temperature values for the specified day in shaded
   * areas. This metric, developed by AccuWeather, incorporates over a dozen
   * factors, including humidity, wind speed, cloud cover, and sun intensity, to
   * offer a comprehensive measure of how the weather actually feels in the
   * shade.
   *
   * For more information, see [What is the AccuWeather RealFeel
   * Temperature?](https://www.accuweather.com/en/weather-news/what-is-the-accuweather-realfeel-temperature/156655)
   */
  realFeelTemperatureShade?: WeatherValueRange;

  /**
   * Provides the expected number of hours of sunshine for the specified day.
   * This property helps users understand how much sunlight they can anticipate,
   * which can be useful for planning outdoor activities and understanding the
   * overall weather conditions.
   */
  hoursOfSun?: float32;

  /**
   * Provides a summary of heating and cooling degree days, which measure
   * temperature deviations from a standard of 65°F / 18°C to indicate energy
   * usage for heating or cooling.
   *
   * Provides a summary of heating and cooling degree days. Heating Degree Days
   * (HDD) measure the demand for energy to heat a building, calculated based on
   * the degrees a day's average temperature is below 65°F/18°C. Cooling Degree
   * Days (CDD) measure the demand for energy to cool a building, calculated
   * based on the degrees a day's average temperature is above 65°F/18°C. This
   * summary aids in energy management and planning.
   */
  degreeDaySummary?: DegreeDaySummary;

  /**
   * A list containing pollutants, pollen levels, and the UV index for the daily
   * forecast. Each list item includes forecasted amounts and categories (e.g.,
   * low, high, good, moderate, unhealthy, hazardous) to assess potential health
   * risks.
   */
  airAndPollen?: AirAndPollen[];

  /**
   * Provides detailed weather information for the daytime weather forecast,
   * including temperature, precipitation, wind, and other key attributes.
   *
   * Provides comprehensive weather details that encompasses various attributes
   * describing different facets of the daytime weather forecast.
   */
  day?: DailyForecastDetail;

  /**
   * Provides detailed weather information for the nighttime weather forecast,
   * including temperature, precipitation, wind, and other key attributes.
   *
   * Provides comprehensive weather details that encompasses various attributes
   * describing different facets of the nighttime weather forecast.
   */
  night?: DailyForecastDetail;

  /** A list of sources contributing to the weather forecast data. */
  sources?: string[];
}

/**
 * A summary of heating and cooling degree day information. Heating Degree Days
 * (HDD) indicate the demand for energy needed to heat a building, calculated
 * based on the number of degrees that a day's average temperature is below the
 * baseline temperature of 65 degrees F/ 18 degree C. Cooling Degree Days (CDD)
 * indicate the demand for energy needed to cool a building, calculated based on
 * the number of degrees that a day's average temperature is above the baseline
 * temperature of 65 degrees F/ 18 degree C. This summary helps in determining
 * the energy requirements for heating and cooling which is useful for energy
 * management and planning.
 */
model DegreeDaySummary {
  /**
   * Heating Degree Days (HDD) indicate the demand for energy needed to heat a
   * building, calculated based on the number of degrees that a day's average
   * temperature is below the baseline temperature of 65 degrees F/ 18 degree C.
   */
  heating?: WeatherValue;

  /**
   * Cooling Degree Days (CDD) indicate the demand for energy needed to cool a
   * building, calculated based on the number of degrees that a day's average
   * temperature is above the baseline temperature of 65 degrees F/ 18 degree C.
   */
  cooling?: WeatherValue;
}

/**
 * The `AirAndPollen` object provides comprehensive environmental data. It
 * identifies various pollen types such as tree, grass, ragweed, and mold, and
 * pollutants including **PM2.5**, **PM10**, **O3**, **NO2**, **SO2**, and
 * **CO**. Additionally, it reports the UV Index on a scale from 1 to 10,
 * offers qualitative descriptions of air quality or pollen levels, and
 * provides numerical measurements of the concentration of pollutants or pollen
 * in the air. This detailed information helps users assess air quality and
 * pollen conditions along their travel route.
 */
model AirAndPollen {
  /**
   * For pollen: Returns the name of the pollen, such as tree, grass, ragweed,
   * or mold.
   *
   * For pollutants: When the name property is 'AirQuality', the name of the
   * pollutant is returned in the type property. Valid pollutants include **PM2.5**,
   * **PM10**, **O3**, **NO2**, **SO2**, and **CO**.
   *
   * For UV Index: When the name property is 'UVIndex', the UV index is returned
   * in the value property. Valid UV Index values range from 0 to 11+ and
   * represent the intensity of ultraviolet radiation. UV Index values are
   * categorized as follows:
   *
   * - 0-2: Low
   * - 3-5: Moderate
   * - 6-7: High
   * - 8-10: Very High
   */
  name?: string;

  /**
   * Provides a numerical measurement of the concentration of pollutants or
   * pollen in the air. This value is typically expressed in units relevant to
   * the type of pollutant or pollen being measured, such as micrograms per
   * cubic meter (µg/m³) for particulate matter or parts per billion (ppb) for
   * gases like ozone. Both air quality and UV are indices, so they are
   * unitless.
   */
  value?: int32;

  /**
   * Provides a one-word qualitative description of the air quality or pollen
   * level for the forecast period in the specified language. This property
   * categorizes the air quality or pollen count into different levels, such as
   * low, high, good, moderate, unhealthy, hazardous giving users an
   * easy-to-understand assessment of the current conditions.
   */
  category?: string;

  /**
   * Provides a numerical representation of the air quality or pollen level.
   * This value corresponds to the qualitative `category` property, offering a
   * precise way to quantify the air quality or pollen level.
   */
  categoryValue?: int32;

  /**
   * Specifies the type of air pollutant being measured. Only used when the
   * *name* property equals *`AirQuality`*. Examples of air pollutants include
   * Particulate Matter (**PM2.5**, **PM10**), Ozone (**O3**), Nitrogen Dioxide (**NO2**),
   * Sulfur Dioxide (**SO2**), and Carbon Monoxide (**CO**).
   */
  type?: string;
}

/** Detailed weather forecast for a portion of the day. */
model DailyForecastDetail {
  /**
   * Numeric value representing an image that corresponds to the forecasted
   * weather condition for the specified portion of the day, described by the
   * `iconPhrase` property. For more information, see [Weather services in
   * Azure Maps](/azure/azure-maps/weather-services-concepts#weather-icons).
   * May be NULL.
   */
  iconCode?: IconCode;

  /**
   * Phrase description of the icon. Displayed in specified language. For example,
   * 'Sunny'.
   */
  iconPhrase?: string;

  /**
   * Local weather data provider information.
   */
  localSource?: LocalSource;

  /**
   * A boolean value that indicates whether precipitation (rain, snow, sleet, or
   * hail) is expected during the specified timeframe. Returns true if precipitation
   * is expected, otherwise false.
   */
  hasPrecipitation?: boolean;

  /**
   * Specifies the type of precipitation. Valid values are Rain, Snow, Ice, or Mix.
   * This property is included in the response when dBZ is greater than zero.
   */
  precipitationType?: PrecipitationType;

  /**
   * Description of the intensity.
   */
  precipitationIntensity?: string;

  /**
   * Phrase description of the forecast in specified language. Azure Maps attempts
   * to keep this phrase under 30 characters in length, but some languages/weather
   * events may result in a longer phrase length, exceeding 30 characters.
   */
  shortPhrase?: string;

  /**
   * Phrase description of the forecast in specified language. Azure Maps attempts
   * to keep this phrase under 100 characters in length, but some languages/weather
   * events may result in a longer phrase length, exceeding 100 characters.
   */
  longPhrase?: string;

  /**
   * Shows the probability of precipitation during the specified day, expressed
   * as a percentage from 0 to 100. A value of 0 means no chance of
   * precipitation, while 100 means precipitation is certain. This helps users
   * assess the likelihood of rain, snow, or other forms of precipitation.
   */
  precipitationProbability?: int32;

  /**
   * Shows the probability of a thunderstorm during the specified day, expressed
   * as a percentage from 0 to 100. A value of 0 means no chance of a thunderstorm,
   * while 100 means a thunderstorm is certain. This helps users assess the
   * likelihood of thunderstorms.
   */
  thunderstormProbability?: int32;

  /**
   * Shows the probability of rain during the specified day, expressed as a
   * percentage from 0 to 100. A value of 0 means no chance of rain, while 100
   * means rain is certain. This helps users assess the likelihood of rain.
   */
  rainProbability?: int32;

  /**
   * Shows the probability of snow during the specified day, expressed as a
   * percentage from 0 to 100. A value of 0 means no chance of snow, while 100
   * means snow is certain. This helps users assess the likelihood of snow.
   */
  snowProbability?: int32;

  /**
   * Shows the probability of ice formation during the specified day, expressed
   * as a percentage from 0 to 100. A value of 0 means no chance of ice
   * formation, while 100 means ice formation is certain. This information helps
   * users evaluate the potential for icy conditions.
   */
  iceProbability?: int32;

  /**
   * Provides the forecasted wind speed and direction. Wind speed is measured
   * in kilometers per hour (km/h) or miles per hour (mph), based on the
   * specified unit. Wind direction is measured in azimuth degrees, ranging
   * from 0° (true North) to 359°, moving clockwise (east is 90°, south is
   * 180°, west is 270°).
   */
  wind?: WindDetails;

  /**
   * Returns the expected maximum short-burst wind speed and direction,
   * measured in kilometers per hour (km/h) or miles per hour (mph), depending
   * on the unit specified in the request. Wind direction is given in azimuth
   * degrees, ranging from 0° (true North) to 359°, moving clockwise. Wind gusts
   * are a sudden, brief increase in wind speed, important for understanding
   * short-term variations that can impact activities like aviation, sailing,
   * kite flying and other outdoor events.
   */
  windGust?: WindDetails;

  /**
   * Returns the total amount of liquid precipitation (such as rain) expected
   * during each day of the forecast period, measured in millimeters (mm) or
   * inches (in), depending on the unit specified in the request.
   */
  totalLiquid?: WeatherValue;

  /**
   * Returns the amount of rainfall expected during each day in the forecast,
   * measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  rain?: WeatherValue;

  /**
   * Returns the amount of snow accumulation expected during the specified day,
   * measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  snow?: WeatherValue;

  /**
   * Returns the amount of ice accumulation expected during the specified day,
   * measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  ice?: WeatherValue;

  /**
   * Shows the total number of hours during the specified day when precipitation is expected. This
   * helps users understand the duration of potential rain, snow, or other forms of precipitation.
   */
  hoursOfPrecipitation?: float32;

  /**
   * Shows the total number of hours during the specified day when rain is expected.
   * This helps users understand the duration of potential rain events.
   */
  hoursOfRain?: float32;

  /**
   * Shows the total number of hours during the specified day when snow is expected.
   * This helps users understand the duration of potential snow events.
   */
  hoursOfSnow?: float32;

  /**
   * Shows the total number of hours during the specified day when ice formation is expected.
   * This helps users understand the duration of potential icy conditions.
   */
  hoursOfIce?: float32;

  /**
   * The percentage of the sky covered by clouds at the specified day. This
   * value ranges from 0% (clear skies) to 100% (completely overcast). May be
   * NULL.
   */
  cloudCover?: int32;
}

/**
 * Local weather data provider information.
 */
model LocalSource {
  /**
   * Numeric identifier, unique to the local data provider.
   */
  id?: int32;

  /**
   * Name of the local data provider. Name is displayed in the language specified by
   * language code in URL, if available. Otherwise, Name is displayed in English or
   * the language in which the name was provided.
   */
  name?: string;

  /**
   * Weather code provided by the local data provider. This weather code allows the
   * forecast to be matched to icons provided by the local data provider instead of
   * Azure Maps icons.
   */
  weatherCode?: string;
}

/**
 * The `WeatherAlongRouteResult` object offers a comprehensive weather summary for
 * a route, accompanied by an array of `WeatherWaypoint` objects. Each waypoint
 * provides detailed weather information for its specific location along the
 * route.
 */
model WeatherAlongRouteResult {
  /**
   * A summary of weather conditions for each waypoint along the route,
   * including key details like a weather icon and phrase (Sunny, Partly Cloudy,
   * Rain, Snow) and any expected weather hazards.
   */
  @visibility(Lifecycle.Read)
  summary?: WeatherAlongRouteSummary;

  /**
   * An array of `WeatherWaypoint` objects, returned in the same order as
   * specified in the request. Each `WeatherWaypoint` provides detailed weather
   * information for a waypoint along the route, including cloud cover, weather
   * hazards, lightning count, hazard notifications, precipitation forecasts,
   * sun glare ratings, temperature, and wind details.
   */
  @visibility(Lifecycle.Read)
  waypoints?: WaypointForecast[];
}

/**
 * Each `WeatherAlongRouteSummary` object provides a concise overview of the
 * weather conditions at a specific waypoint along the route. It includes key
 * details such as a weather icon and descriptive phrase (such as Sunny, Partly
 * Cloudy, Rain, Snow), as well as any significant weather hazards that are
 * expected. This summary helps users quickly understand the weather they might
 * encounter at each waypoint along the route.
 */
model WeatherAlongRouteSummary {
  /**
   * A numeric value that corresponds to an image displaying the `iconPhrase`.
   * For more information, see [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * A summary of significant weather hazards expected at specific waypoints
   * along the route. This includes details about severe storms, heavy rain,
   * snow, and other conditions that could impact travel safety.
   */
  hazards?: WeatherHazards;
}

/**
 * Provides detailed information about potential weather hazards along a route,
 * including various intensities of rain, snow, ice, hail, sun glare, and wind.
 * It also includes warnings for severe conditions like floods, tornadoes,
 * tsunamis, and thunderstorms. A hazard index rates the severity from 0 (no
 * hazard) to 4 (life-threatening).
 */
model WeatherHazards {
  /**
   * An aggregated severity/hazard index for each waypoint, useful for
   * color-coding route segments to indicate safety levels. The index is rated
   * as follows:
   *
   * - **0**: No hazard
   * - **1**: Be informed, be aware
   * - **2**: Pay attention, be prepared
   * - **3**: Take action
   * - **4**: Life-threatening, emergency
   */
  maxHazardIndex?: HazardIndex;

  /**
   * Specifies the type of weather hazards that could impact each waypoint along
   * a route. Possible hazards include various intensities of rain, snow, ice,
   * hail, sun glare, lightning, wind, and severe weather warnings such as
   * flood, tornado, tsunami, and severe thunderstorms.
   */
  hazardDetails?: HazardDetail[];
}

/**
 * Provides detailed information about specific weather hazards affecting the
 * waypoint. This includes the type and severity of the hazard, helping users
 * understand potential risks along their journey.
 */
model HazardDetail {
  /**
   * An aggregated severity/hazard index for each waypoint, useful for
   * color-coding route segments to indicate safety levels. The index is rated
   * as follows:
   *
   * - **0**: No hazard
   * - **1**: Be informed, be aware
   * - **2**: Pay attention, be prepared
   * - **3**: Take action
   * - **4**: Life-threatening, emergency
   */
  hazardIndex?: HazardIndex;

  /**
   * A unique identifier for each type of hazard:
   *
   * - LightRain
   * - ModerateRain
   * - HeavyRain
   * - LightMix
   * - ModerateMix
   * - HeavyMix
   * - LightSnow
   * - ModerateSnow
   * - HeavySnow
   * - LightIce
   * - ModerateIce
   * - HeavyIce
   * - Hail
   * - LargeHail
   * - `SunGlare`
   * - SunGlareHigh
   * - Lightning
   * - SevereLightning
   * - WindModerate
   * - WindHigh
   * - WindExtreme
   * - FloodWarning
   * - FlashFloodWarning
   * - TornadoWarning
   * - TsunamiWarning
   * - SevereThunderstormWarning
   */
  hazardCode?: string;

  /**
   * A short, displayable phrase detailling the hazard at the specified
   * waypoint. Up to 25 characters.
   */
  shortPhrase?: string;
}

/**
 * Provides a detailed weather forecast and hazard warnings for specific
 * waypoints along a route.
 */
model WaypointForecast {
  /**
   * Returns a numeric value that corresponds to an image displaying the
   * `iconPhrase`. For more information, see [Weather services in Azure
   * Maps ](/azure/azure-maps/weather-services-concepts#weather-icons).
   */
  iconCode?: IconCode;

  /**
   * A brief, displayable phrase describing the forecasted weather conditions
   * and precipitation type/intensity at the specified waypoint.
   */
  shortPhrase?: string;

  /**
   * Indicates whether it is currently daytime at the specified waypoint.
   * Returns true if it is daytime and false if it is nighttime
   */
  isDayTime?: boolean;

  /**
   * The percentage of the sky covered by clouds at the specified waypoint. This
   * value ranges from 0% (clear skies) to 100% (completely overcast). May be
   * NULL.
   */
  cloudCover?: int32;

  /**
   * Returns the temperature at a specific waypoint along the route, measured in
   * degrees Celsius (C) or Fahrenheit (F), depending on the unit specified in
   * the request.
   */
  temperature?: WeatherValue;

  /**
   * Provides the expected wind speed and direction. Wind speed is measured in
   * kilometers per hour (km/h) or miles per hour (mph), based on the specified
   * unit. Wind direction is measured in azimuth degrees, ranging from 0° (true
   * North) to 359°, moving clockwise (east is 90°, south is 180°, west is
   * 270°).
   */
  wind?: WindDetails;

  /**
   * Returns the expected maximum short-burst wind speed and direction at a
   * specific waypoint along the route, measured in kilometers per hour (km/h)
   * or miles per hour (mph), depending on the unit specified in the request.
   * Wind direction is given in azimuth degrees, ranging from 0° (true North) to
   * 359°, moving clockwise.
   */
  windGust?: WindDetails;

  /** Returns the amount of precipitation expected at the specified waypoint. */
  precipitation?: WeatherAlongRoutePrecipitation;

  /** Estimation of thunderstorm intensity on an open scale. A value of 0
   * means there is no thunderstorm; values of 1 and higher mean there is
   * a thunderstorm in increasing intensity. */
  lightningCount?: int32;

  /**
   * Indicates the level of sun glare as a driving hazard at the specified
   * waypoint. Returns a glare index from 0 to 100, where values of 50 and above
   * can be hazardous, and a value of 100 indicates driving directly into the
   * sun under clear conditions.
   */
  sunGlare?: SunGlare;

  /**
   * A list of weather hazards expected at specific waypoints along the route.
   * This includes details about severe storms, heavy rain, snow, and other
   * conditions that could impact travel safety.
   */
  hazards?: WeatherHazards;

  /** Returns a list of weather hazard notifications relevant to the specified waypoint. */
  notifications?: WeatherNotification[];
}

/** Weather forecast for precipitation along the route. */
model WeatherAlongRoutePrecipitation {
  /**
   * Returns the forecasted radar reflectivity in decibels relative to Z (dBZ),
   * which measures precipitation intensity. Values range from 0.0 to 100.0,
   * with higher values indicating heavier precipitation.
   */
  dbz?: float64;

  /**
   * Type of precipitation. If precipitation occurs, it will be classified as
   * 'RAIN,' 'HAIL,' 'SNOW,' 'ICE,' or 'MIX.'
   */
  type?: string;
}

/**
 * Indicates the level of sun glare as a driving hazard at the specified
 * waypoint. Returns a glare index from 0 to 100, where values of 50 and above
 * can be hazardous, and a value of 100 indicates driving directly into the sun
 * under clear conditions.
 */
model SunGlare {
  /**
   * If a vehicle heading value is not provided for a waypoint, the service will
   * calculate the heading based on the locations of neighboring waypoints, if
   * available.
   */
  calculatedVehicleHeading?: int32;

  /**
   * An index ranging from 0 to 100 that indicates the intensity of sun glare
   * for a driver. Values of 50 and above may pose a hazard for some drivers,
   * while a value of 100 signifies driving directly into the sun under clear
   * conditions.
   */
  glareIndex?: int32;
}

/**
 * Provides alerts for significant weather changes along a route, including
 * hazard type, severity index, and descriptive message.
 */
model WeatherNotification {
  /** Need a list of possible types. */
  type?: string;

  /**
   * An aggregated severity/hazard index for each waypoint, useful for
   * color-coding route segments to indicate safety levels. The index is rated
   * as follows:
   *
   * - **0**: No hazard
   * - **1**: Be informed, be aware
   * - **2**: Pay attention, be prepared
   * - **3**: Take action
   * - **4**: Life-threatening, emergency
   */
  hazardIndex?: HazardIndex;

  /**
   * A unique identifier for each type of hazard:
   *
   * - LightRain
   * - ModerateRain
   * - HeavyRain
   * - LightMix
   * - ModerateMix
   * - HeavyMix
   * - LightSnow
   * - ModerateSnow
   * - HeavySnow
   * - LightIce
   * - ModerateIce
   * - HeavyIce
   * - Hail
   * - LargeHail
   * - SunGlare
   * - SunGlareHigh
   * - Lightning
   * - SevereLightning
   * - WindModerate
   * - WindHigh
   * - WindExtreme
   * - FloodWarning
   * - FlashFloodWarning
   * - TornadoWarning
   * - TsunamiWarning
   * - SevereThunderstormWarning
   */
  hazardCode?: string;

  /**
   * A short, displayable phrase that helps users quickly understand the
   * forecasted weather conditions and precipitation intensity/type at the
   * specified waypoint.
   */
  shortPhrase?: string;
}

/**
 * This object is returned from a successful Get Severe Weather Alerts call.
 */
model SevereWeatherAlertsResult {
  /** A list of all severe weather alerts for the specified location. */
  @visibility(Lifecycle.Read)
  results?: SevereWeatherAlert[];
}

/**
 * A `SevereWeatherAlert` object provides detailed information about significant
 * weather conditions that could pose risks to life and property. These alerts
 * cover various severe weather phenomena, such as hurricanes, thunderstorms,
 * flooding, lightning, heat waves, or forest fires, and include details about
 * active alerts for a specified location.
 */
model SevereWeatherAlert {
  /**
   * 2-character ISO 3166-1 Alpha-2 country code, for example, "US". For more
   * information, see [ISO 3166 country
   * codes](https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes).
   */
  countryCode?: string;

  /** A unique numerical identifier assigned to a weather alert. */
  alertId?: int32;

  /**
   * A `SevereWeatherAlertDescription` object that contains a short summary
   * phrase for the alert, returned both in the language specified in the
   * request (`localized`) and in English (`english`).
   */
  description?: SevereWeatherAlertDescription;

  /** A classification word or phrase that describes the alert type. */
  category?: string;

  /**
   * A numerical value indicating the importance or ranking order of the alert
   * within its originating country or region. A lower number denotes higher
   * priority, with 1 being the highest. This value can vary by country or
   * region and may change over time as alert systems evolve.
   */
  priority?: int32;

  /**
   * The classification of the alert. This field is not available in all
   * countries and therefore may not be returned.
   */
  class?: string;

  /** Severity level of the alert. Not available in all countries. */
  level?: string;

  /**
   * The provider of the alert information, in the language specified in the
   * request. If no language is specified, English (en-US) is used. Alerts are
   * typically issued by official government meteorological agencies or leading
   * global weather alert providers.
   */
  source?: string;

  /** A numerical identifier linked to the name of the source provider for the alert data. */
  sourceId?: int32;

  /**
   * A disclaimer regarding the source of the alert information, which may
   * include details about delays or potential issues. If present, it must be
   * displayed with the alert.
   */
  disclaimer?: string;

  /**
   * An array of `AlertArea` objects, each representing a specific area covered by
   * the alert. These objects collectively define the regions affected by the
   * severe weather alert. Each `AlertArea` includes the name of the affected
   * area, a brief description of the alert, and the geographical coordinates
   * that define it. This helps identify the locations under threat and provides
   * essential information specific to those areas.
   */
  alertAreas?: AlertArea[];
}

/**
 * Description of a severe weather alert.
 */
model SevereWeatherAlertDescription {
  /**
   * A short phrase that summarizes the alert in the specified language. If not
   * specified, English (en-US) is used.
   */
  localized?: string;

  /** A short phrase that summarizes the alert in English (en-US). */
  english?: string;
}

/**
 * Details of a severe weather alert issued for the affected area(s). If
 * multiple alerts are active for the same location, they will be ordered by
 * priority in the response, with the highest priority alert appearing first.
 */
model AlertArea {
  /**
   * Specifies the name of the geographical area affected by the alert. This
   * parameter helps identify the specific region or locality that is under the
   * severe weather alert.
   */
  name?: string;

  /**
   * A brief description of the alert. For example:
   * 
   * 'Heat Advisory in effect until 10:00 PM PDT. Source: U.S. National Weather Service'
   */
  summary?: string;

  /**
   * The date and time at which the alert began in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*. If
   * the alert spans multiple time zones, the response will provide the local
   * time corresponding to the requested coordinates.
   */
  startTime?: utcDateTime;

  /**
   * The date and time at which the alert ended or will end in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_format (yyyy-mm-ddThh:mm:ss-hh:mm).
   * For example, *2025-04-29T07:00:00-07:00*. If the alert spans multiple time
   * zones, the response will provide the local time corresponding to the
   * requested coordinates.
   */
  endTime?: utcDateTime;

  /** The most recent status of the alert in the specified area. */
  latestStatus?: LatestStatus;

  /**
   * Provides complete details related to the alert, returned when the `details`
   * URI parameter is set to true. The `language` parameter does not apply to
   * this field. This field is always returned in the language chosen by the
   * issuing provider, and Azure Maps only returns the information created by
   * the provider. Note that some countries/regions may offer both their native
   * language and English.
   */
  alertDetails?: string;

  /**
   * Specifies the language of the severe weather alert details, which may
   * differ from the requested language. The language code follows the [ISO
   * 639-1 Alpha-2
   * standard](https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes).
   * Only returned when details=True.
   */
  alertDetailsLanguageCode?: string;
}

/**
 * Returns a keyword indicating the latest status of the alert in the specified
 * location. For a list of all possible keywords, see the `LatestStatusKeyword`
 * enum.
 */
model LatestStatus {
  /**
   * A keyword indicating the latest status of the alert, in the specified
   * language. If not specified, English (en-US) is used.
   */
  localized?: string;

  /** A keyword indicating the latest status of the alert, in English (en-US). */
  english?: LatestStatusKeyword;
}

/**
 * This object is returned from a successful Get Daily Indices call.
 */
model DailyIndicesResult {
  /**
   * A list of all daily indices for the queried location.
   */
  @visibility(Lifecycle.Read)
  results?: DailyIndex[];
}

/**
 * The `DailyIndex` object helps users plan outdoor activities based on weather
 * conditions by providing the activity name, such as 'Ski Weather Forecast'; a
 * numerical rating from 0.0 to 10.0 indicating suitability; a text rating, such
 * as 'Poor'; and a brief description of the conditions, such as 'Expect poor
 * conditions for skiing.'
 */
model DailyIndex {
  /**
   * The name of the index, indicating the type of activity or condition it
   * relates to, such as running, golfing, or other outdoor activities. For more
   * information, see [Index
   * IDs](/azure/azure-maps/weather-services-concepts#index-ids-and-index-groups-ids)
   * in the *Weather service in Azure Maps* concepts article.
   */
  indexName?: string;

  /**
   * A numeric identifier that uniquely represents a specific index type,
   * distinguishing between different indices for various outdoor activities.
   * For example, an 'indexId' of 1 corresponds to the 'Running' index, and an
   * 'indexId' of 5 corresponds to the 'Golfing' index. For more information,
   * see [Index
   * IDs](/azure/azure-maps/weather-services-concepts#index-ids-and-index-groups-ids)
   * in the *Weather service in Azure Maps* concepts article.
   */
  indexId?: int32;

  /**
   * Date and time of the observation in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: utcDateTime;

  /**
   * A numerical value ranging from 0.0 to 10.0 that quantifies the suitability
   * of weather conditions for a specific activity or condition, such as running
   * or golfing. Higher values typically indicate more favorable conditions. For
   * example, a value of 8 for the 'Running' index suggests very good weather
   * for running, while a value of 6 for the 'Golfing' index indicates good but
   * slightly less ideal conditions. For more information, see [Daily index
   * range sets](/azure/azure-maps/daily-index-range-sets) in the *Weather
   * service in Azure Maps* concepts article.
   */
  value?: float32;

  /**
   * Provides a qualitative assessment of the index, describing the
   * `categoryValue` property. Categories vary among indices and may include
   * values such as Excellent, Good, Fair, Poor, and Very Poor.
   */
  category?: string;

  /**
   * Provides a numeric representation of the category property, indicating the
   * qualitative assessment of the index. Values range from 1 to 5 and should be
   * used with the ascending flag, as they can differ among indices. For
   * example, for Mosquito Activity:
   * 
   * - Low = 1
   * - Moderate = 2
   * - High = 3
   * - Very High = 4
   * - Extreme = 5
   */
  categoryValue?: int32;

  /**
   * Indicates the direction of the `value` and `categoryValue` properties. When
   * true, the poorest value is 0 and the best value is 10. When false, the
   * poorest value is 10 and the best value is 0.
   */
  ascending?: boolean;

  /**
   * Provides a brief, user-friendly explanation of the index value, helping
   * users understand its significance in relation to specific weather
   * conditions or activities. For example, if the index value for Outdoor
   * Barbecue is 'Excellent', the description will be 'This is a great day for
   * an outdoor barbecue!'
   */
  description?: string;
}

/**
 * The `ActiveStormResult` object provides comprehensive information about ongoing
 * tropical storms. It includes an array of `ActiveStorm` objects, each detailing
 * specific attributes of individual storms. These attributes encompass the
 * storm's government ID, basin ID, year of origin, name, and subtropical
 * status.
 */
model ActiveStormResult {
  /**
   * An array of `ActiveStorm` objects, each providing essential details about an
   * ongoing tropical storm, as reported by national weather forecasting
   * agencies.
   */
  results?: ActiveStorm[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated.
   *
   * This is useful when the response is too large to be returned in a single
   * call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * Provides essential details about ongoing tropical storms, as reported by
 * national weather forecasting agencies.
 */
model ActiveStorm {
  /** Specifies the year in which the tropical storm originated. */
  year?: string;

  /**
   * Categorizes the different ocean basins where tropical storms can originate.
   * Each basin is assigned a unique identifier to help specify the location of
   * the storm's origin. Valid Basin identifiers include **AL**, **CP**, **EP**,
   * **NI**, **NP**, **SI**, and **SP**.
   */
  basinId?: BasinId;

  /** The name of the storm. */
  name?: string;

  /**
   * Indicates whether the tropical storm is currently active. If true, the
   * storm is active; if false, the storm is not active
   */
  isActive?: boolean;

  /**
   * If true, the storm is classified as a subtropical cyclone — a hybrid system
   * with characteristics of both tropical and extratropical cyclones. If false,
   * the storm is not subtropical.
   */
  isSubtropical?: boolean;

  /**
   * A unique identifier assigned to tropical storms by national weather
   * forecasting agencies. This identifier helps track and reference specific
   * storms accurately, including its status, location, and intensity.
   */
  govId?: int32;
}

/**
 * Contains a list of government-issued storms that meet the specified search
 * criteria, including details such as the storm's basin ID, government-issued
 * ID and status.
 */
model StormSearchResult {
  /**
   * Array of `StormSearchResultItem` objects, each representing a tropical storm
   * matching the search criteria provided in the request.
   */
  results?: StormSearchResultItem[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated.
   *
   * This is useful when the response is too large to be returned in a single
   * call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * A government-issued storm event, including the storm's basin identifier
 * (`basinId`), government-issued identifier (`govId`) and status. This object is
 * returned as part of an array within the `StormSearchResult` object.
 */
model StormSearchResultItem {
  /** Specifies the year in which the tropical storm originated. */
  year?: string;

  /**
   * The `basinId` enum categorizes the different ocean basins where tropical
   * storms can originate. Each basin is assigned a unique identifier to help
   * specify the location of the storm's origin. Valid Basin identifiers include
   * **AL**, **CP**, **EP**, **NI**, **NP**, **SI**, and **SP**.
   */
  basinId?: BasinId;

  /**
   * Identifies the tropical storm by its official name, as designated by the
   * relevant national weather forecasting agency.
   */
  name?: string;

  /**
   * Indicates whether the tropical storm is currently active. If true, the
   * storm is active; if false, the storm is not active
   */
  isActive?: boolean;

  /** Returns true if the storm has been permanently retired in the source basin. */
  isRetired?: boolean;

  /**
   * If true, the storm is classified as a subtropical cyclone — a hybrid system
   * with characteristics of both tropical and extratropical cyclones. If false,
   * the storm is not subtropical.
   */
  isSubtropical?: boolean;

  /**
   * A Government storm ID is a unique identifier assigned to tropical storms by
   * national weather forecasting agencies. This ID is used to track and manage
   * storm information, including its status, location, and intensity. It helps
   * meteorologists, emergency services, and the public stay informed about
   * active storm events.
   */
  govId?: int32;
}

/**
 * An array of `StormForecast` objects, each detailing individual storm forecasts
 * issued by government authorities.
 */
model StormForecastResult {
  /**
   * An array of forecast data for tropical storms, including predicted paths,
   * intensities, and other relevant details. These forecasts are issued by
   * government authorities.
   */
  results?: StormForecast[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated.
   *
   * This is useful when the response is too large to be returned in a single
   * call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * The `StormForecast` object contains detailed Government-issued information
 * about forecasted tropical storms, including the storm's location, status,
 * forecast creation date, wind speed, and wind radii.
 */
model StormForecast {
  /**
   * Date and time that the current forecast is valid, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: string;

  /**
   * Date and time that the forecast was created, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  initializedDateTime?: string;

  /**
   * Specifies the geographical coordinates (latitude and longitude) of the
   * storm's forecasted position.
   */
  location?: LatLongPair;

  /**
   * Specifies the expected maximum wind gust speed and direction expected
   * during the storm, measured in kilometers per hour (km/h) or miles per hour
   * (mph), based on the specified unit. Wind direction is given in azimuth
   * degrees, ranging from 0° (true North) to 359°, moving clockwise. May be
   * NULL.
   */
  maxWindGust?: WeatherValue;

  /**
   * Specifies the maximum sustained wind speed expected during the storm,
   * measured in kilometers per hour (km/h) or miles per hour (mph), based on
   * the unit specified in the request.
   */
  sustainedWind?: WeatherValue;

  /**
   * Indicates the current state or condition of the storm. This property
   * provides information on whether the storm is active, dissipating, or has
   * reached another significant status. Possible values:
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
   * Provides forecast details for the storm within the specified time frame. If
   * the `windowGeometry` parameter is set to true in the API request, this
   * property will include GeoJSON details for the window geometry.
   */
  window?: WeatherWindow;

  /**
   * Contains an array of `StormWindRadiiSummary` objects, detailing wind radii in
   * different quadrants around the storm's center. Displayed when details=true
   * or `radiiGeometry`=true in the request.
   */
  windRadiiSummary?: StormWindRadiiSummary[];
}

/**
 * Provides details about the forecast window for a tropical storm, including
 * the start and end times (`beginDateTime`, `endDateTime`), storm status at the
 * start and end (`beginStatus`, `endStatus`), the movement coordinates (geometry),
 * and the locations of points on the left and right sides of the window (left,
 * right). This object helps track the storm's movement and status over a
 * specified timeframe.
 */
model WeatherWindow {
  /**
   * Specifies the western geographical boundary of the forecast window using
   * latitude and longitude coordinates, valid at the specified time.
   */
  left?: LatLongPair;

  /**
   * Specifies the eastern geographical boundary of the forecast window using
   * latitude and longitude coordinates, valid at the specified time.
   */
  right?: LatLongPair;

  /**
   * The date and time when the forecast window begins. It is displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, 2025-04-29T07:00:00-07:00.
   */
  beginDateTime?: utcDateTime;

  /**
   * The date and time when the forecast window ends. It is displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, 2025-04-29T07:00:00-07:00.
   */
  endDateTime?: utcDateTime;

  /**
   * The status of the tropical storm at the start of the forecast window,
   * including its classification, such as tropical depression, tropical storm,
   * or hurricane.
   */
  beginStatus?: string;

  /**
   * The status of the tropical storm at the end of the forecast window,
   * including its classification, such as tropical depression, tropical storm,
   * or hurricane.
   */
  endStatus?: string;

  /**
   * GeoJSON data that maps out the area affected by the storm during the
   * forecast window. Displayed when windowGeometry=true is specified in the
   * request.
   */
  geometry?: GeoJsonGeometry;
}

/**
 * The `StormWindRadiiSummary` object provides a high-level overview of the wind
 * distribution around a tropical storm. It includes the geometric
 * representation of wind radii (`radiiGeometry`), detailed sector-based wind data
 * (`radiusSectorData`), and the wind speeds at various distances from the storm's
 * center (`windSpeed`). These properties collectively help in understanding the
 * spatial extent and intensity of winds associated with the storm. Displayed
 * when the request includes details=true or `radiiGeometry`=true.
 */
model StormWindRadiiSummary {
  /**
   * Date and time that the wind radii summary data is valid, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: string;

  /**
   * The overall wind speed associated with the storm's wind radii data,
   * measured in kilometers per hour (km/h) or miles per hour (mph), based on
   * the unit specified in the request. This single wind speed value applies
   * collectively to all the sectors within the `radiusSectorData` array, which
   * provides detailed geographical information for the NE, SE, SW, and NW
   * quadrants of the storm's wind radii.
   */
  windSpeed?: WeatherValue;

  /**
   * An array of `RadiusSector` objects. Each object contains detailed
   * geographical information (in GeoJSON format) needed to plot wind radius
   * quadrants: 0–90° for NE, 90–180° for SE, 180–270° for SW, and 270–360° for
   * NW.
   */
  radiusSectorData?: RadiusSector[];

  /**
   * A GeoJSON object that is returned when the `radiiGeometry` parameter is set
   * to true in the API request. It provides detailed geographical information
   * about the storm's wind radii, including the spatial representation of areas
   * affected by different wind speeds.
   */
  radiiGeometry?: GeoJsonGeometry;
}

/**
 * Provides the necessary information to plot wind radius quadrants.
 * `beginBearing` and `endBearing` indicate the angles in degrees (Bearing 0–90
 * = NE quadrant; 90–180 = SE quadrant; 180–270 = SW quadrant; 270–360 = NW
 * quadrant). `range` specifies the radius in nautical miles.
 */
model RadiusSector {
  /**
   * Specifies the starting angle of the quadrant, measured in degrees from true
   * north. This property defines the orientation of the sector within the
   * radius.
   */
  beginBearing?: float64;

  /**
   * Specifies the ending angle of the quadrant, measured in degrees from true
   * north. This property, along with `beginBearing`, defines the angular span of
   * the sector within the radius.
   */
  endBearing?: float64;

  /** The radius of the quadrant in nautical miles. */
  range?: float64;
}

/**
 * Contains an array of `StormLocation` objects, representing government-issued
 * active storm events. Includes details such as latitude and longitude
 * coordinates, wind speed and direction, wind radii, basin identifier, minimum
 * pressure, movement, status, and other relevant attributes.
 */
model StormLocationsResult {
  /**
   * Array of data points, each detailing the location of an individual
   * government-issued storm, including coordinates, geometry, basin ID, date,
   * wind details, and wind radii.
   */
  results?: StormLocation[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated.
   *
   * This is useful when the response is too large to be returned in a single
   * call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * Contains detailed information about a tropical storm's location, including
 * latitude and longitude coordinates, wind speed and direction, wind radii, and
 * basin identifier. Essential for tracking and forecasting the storm's movement
 * and intensity.
 */
model StormLocation {
  /**
   * The date and time when the forecast is valid, in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: string;

  /** Specifies the latitude and longitude coordinates of the storm's center. */
  location?: LatLongPair;

  /**
   * Specifies the expected maximum wind gust speed and direction expected
   * during the storm, measured in kilometers per hour (km/h) or miles per hour
   * (mph), based on the specified unit. Wind direction is given in azimuth
   * degrees, ranging from 0° (true North) to 359°, moving clockwise. May be
   * NULL.
   */
  maxWindGust?: WeatherValue;

  /**
   * Maximum sustained wind speed associated with the storm, measured in
   * kilometers per hour (km/h) or miles per hour (mph), based on the specified
   * unit.
   */
  sustainedWind?: WeatherValue;

  /**
   * Specifies the lowest atmospheric pressure associated with the storm,
   * measured in millibars (mb) or inches of mercury (inHg), depending on the
   * unit specified in the request. This value may be NULL.
   */
  minimumPressure?: WeatherValue;

  /**
   * Returns the storm's current direction (in degrees) and speed, measured in
   * kilometers per hour (km/h) or miles per hour (mph), depending on the
   * specified unit.
   */
  movement?: WindDetails;

  /**
   * Returns the current classification or stage of the storm in English, such
   * as a tropical depression, tropical storm, or hurricane.
   */
  status?: string;

  /**
   * If true, the storm is classified as a subtropical cyclone — a hybrid system
   * with characteristics of both tropical and extratropical cyclones. If false,
   * the storm is not subtropical.
   */
  isSubtropical?: boolean;

  /**
   * Returns true if the storm has the potential to develop into a tropical
   * cyclone, aiding in the assessment of storm intensification.
   */
  hasTropicalPotential?: boolean;

  /**
   * Returns true if the storm has transitioned from a tropical cyclone to a
   * post-tropical cyclone, aiding in understanding the storm's lifecycle phase.
   */
  isPostTropical?: boolean;

  /**
   * Contains an array of `StormWindRadiiSummary` objects, detailing wind radii in
   * different quadrants around the storm's center. Displayed when details=true
   * or `radiiGeometry`=true in the request.
   */
  windRadiiSummary?: StormWindRadiiSummary[];
}

/**
 * An array of [AirQuality](#airquality) objects, each providing comprehensive
 * information about the current air quality at the specified location.
 */
model AirQualityResult {
  /**
   * Detailed air quality results within the specified location, including
   * properties such as the air quality index (AQI), dominant pollutant,
   * pollutant levels, risk level, and suggested precautions.
   */
  results?: AirQuality[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated.
   *
   * This is useful when the response is too large to be returned in a single
   * call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * The `AirQuality` object provides comprehensive information about the current
 * air quality at the specified location. This includes the concentration levels
 * of various pollutants, numerical Air Quality Index (AQI) values indicating
 * the overall air quality, and identification of the dominant pollutant
 * affecting the air quality. Additionally, it offers a risk level summary,
 * which briefly outlines potential health risks and suggests precautions.
 */
model AirQuality {
  /**
   * Date and time the air quality data applies to, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: utcDateTime;

  /**
   * The air quality index (AQI) is an air quality rating scale set by local
   * regulating bodies. Scales can vary widely based on location. For more
   * information, see [Air quality
   * index](https://en.wikipedia.org/wiki/Air_quality_index) in Wikipedia.
   */
  index?: float32;

  /**
   * Provides an internationally standardized way to understand the
   * concentration of pollutants in the air. Ratings range from 0 to 300 and up,
   * with higher numbers representing worse air quality. The pollutants measured
   * includes **PM2.5**, **PM10**, **NO2**, **SO2**, **CO**, and **O3**.
   */
  globalIndex?: float32;

  /** Identifies the pollutant with the highest concentration. */
  dominantPollutant?: DominantPollutant;

  /**
   * Provides a one-word description of the air quality for the forecast period
   * in the specified language, such as Poor, Fair, or Excellent.
   */
  category?: string;

  /**
   * Provides a unique hexadecimal color code corresponding to the air quality
   * category for each day in the forecast period. This color helps users
   * quickly identify the air quality level visually, with each color
   * corresponding to a category such as Poor, Fair, or Excellent.
   */
  categoryColor?: string;

  /**
   * A textual explanation of this air quality result in the requested language.
   */
  description?: string;

  /**
   * An array containing detailed information about each pollutant in the
   * response. Returned when the `pollutants` URI Parameter is *true*.
   */
  pollutants?: Pollutant[];
}

/**
 * Detailed information about an individual pollutant. Not returned if
 * `pollutants`=false.
 */
model Pollutant {
  /**
   * The type of pollutant, such as **PM2.5**, **PM10**, **O3**, **NO2**, **SO2**, and **CO**. Note that
   * additional types may be added.
   */
  type?: PollutantType;

  /** The name of the pollutant in English, such as Ozone, Nitrogen Dioxide, and Carbon Monoxide. */
  name?: string;

  /**
   * The air quality index (AQI) as defined by local regulatory bodies. The
   * scale can vary significantly by location. For more information, see [Air
   * quality index](https://en.wikipedia.org/wiki/Air_quality_index) in
   * Wikipedia.
   */
  index?: float32;

  /**
   * An internationally normalized air quality rating on a scale from 0 to 300+,
   * where higher values denote poorer air quality. This index measures
   * concentrations of **PM2.5**, **PM10**, **NO2**, **SO2**, **CO**, and **O3**.
   */
  globalIndex?: float32;

  /**
   * Specifies the level of the pollutant in the air, measured in micrograms per
   * cubic meter (µg/m³) or parts per million (ppm).
   */
  concentration?: WeatherValue;
}

/**
 * Returns an array of `DailyAirQuality` objects, each detailing the forecasted
 * air quality for a specific day. The number of days included is determined by
 * the `duration` URI parameter (1-7 days, default is 1).
 */
model DailyAirQualityForecastResult {
  /**
   * Detailed air quality forecast data for each day within the requested
   * duration, including properties such as date, air quality index (AQI),
   * dominant pollutant, pollutant levels, risk level, and suggested
   * precautions.
   */
  results?: DailyAirQuality[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated.
   *
   * This is useful when the response is too large to be returned in a single
   * call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * Provides a summary of the forecasted air quality conditions for a specific
 * day and location, in the requested language. The returned properties include:
 * category, which indicates the air quality level; `categoryColor`, representing
 * the color associated with the air quality category; description, offering a
 * textual explanation of the air quality; `dominantPollutant`, identifying the
 * primary pollutant affecting air quality; `globalIndex`, providing a
 * standardized air quality index; and index, detailing the specific air quality
 * index value for the day.
 */
model DailyAirQuality {
  /**
   * Date and time of the daily air quality forecast, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: utcDateTime;

  /**
   * The air quality index (AQI) is a rating scale set by local regulating
   * bodies, which can vary widely by location. For more information, see [Air
   * quality index](https://en.wikipedia.org/wiki/Air_quality_index) in
   * Wikipedia.
   */
  index?: float32;

  /**
   * Provides an internationally standardized air quality rating from 0 to 300
   * and above, with higher numbers indicating worse air quality. The index
   * measures pollutants such as **PM2.5**, **PM10**, **NO2**, **SO2**, **CO**, and **O3**.
   */
  globalIndex?: float32;

  /** Identifies the pollutant with the highest concentration. */
  dominantPollutant?: DominantPollutant;

  /**
   * Provides a one-word summary of the air quality for the forecast period in
   * the specified language, such as Poor, Fair, or Excellent. This summary
   * helps users quickly understand the overall air quality conditions.
   */
  category?: string;

  /**
   * Provides a unique hexadecimal color code for each air quality category in
   * the daily forecast, visually representing levels such as Poor, Fair, or
   * Excellent.
   */
  categoryColor?: string;

  /**
   * Provides a summary of the forecasted air quality conditions for a specific
   * day and location, in the requested language.
   */
  description?: string;
}

/**
 * Returns an array of `DailyHistoricalActuals` objects, each detailing the
 * observed historical weather data for the specified date and location. The
 * number of days included is determined by the `startDate` and `endDate` URI
 * parameters which can include up to 31 days.
 */
model DailyHistoricalActualsResult {
  /**
   * Aggregates detailed historical weather data for specific dates and
   * locations, including temperature, precipitation, snowfall, snow depth, and
   * degree day summaries.
   */
  results?: DailyHistoricalActuals[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated.
   *
   * This is useful when the response is too large to be returned in a single
   * call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * Provides climatology data for a specific day, including observed
 * temperatures, precipitation, snowfall, snow depth, and heating/cooling degree
 * days.
 */
model DailyHistoricalActuals {
  /**
   * The date and time for the requested weather data in ISO 8061 format
   * displayed in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  date?: utcDateTime;

  /**
   * Provides the observed maximum, minimum, and average temperatures for a
   * specific day at a given location.
   */
  temperature?: WeatherValueMaxMinAvg;

  /**
   * Provides a summary of heating and cooling degree days, which measure
   * temperature deviations from a standard of 65°F / 18°C to indicate energy
   * usage for heating or cooling.
   *
   * Provides a summary of heating and cooling degree days. Heating Degree Days
   * (HDD) measure the demand for energy to heat a building, calculated based on
   * the degrees a day's average temperature is below 65°F/18°C. Cooling Degree
   * Days (CDD) measure the demand for energy to cool a building, calculated
   * based on the degrees a day's average temperature is above 65°F/18°C. This
   * summary aids in energy management and planning.
   */
  degreeDaySummary?: DegreeDaySummary;

  /**
   * The amount of precipitation accumulated over the specified day, measured in
   * centimeters (cm) or inches (in), depending on the unit specified in the
   * request.
   */
  precipitation?: WeatherValue;

  /**
   * Provides the amount of snow that has fallen over the specified day,
   * measured in centimeters (cm) or inches (in), based on the specified unit in
   * the request.
   */
  snowfall?: WeatherValue;

  /**
   * Provides the average accumulated snow depth, measured in centimeters (cm)
   * or inches (in), based on the specified unit in the request.
   */
  snowDepth?: WeatherValue;
}

/**
 * Provides the minimum, maximum, and average temperatures for the specified
 * timeframe, measured in degrees Celsius (C) or Fahrenheit (F), based on the
 * unit specified in the request.
 */
model WeatherValueMaxMinAvg {
  /**
   * Provides the maximum temperature for the specified timeframe, measured in
   * degrees Celsius (C) or Fahrenheit (F), based on the unit specified in the
   * request.
   */
  maximum?: WeatherValue;

  /**
   * Provides the minimum temperature for the specified timeframe, measured in
   * degrees Celsius (C) or Fahrenheit (F), based on the unit specified in the
   * request.
   */
  minimum?: WeatherValue;

  /**
   * Provides the average temperature for the specified timeframe, measured in
   * degrees Celsius (C) or Fahrenheit (F), based on the unit specified in the
   * request.
   */
  average?: WeatherValue;
}

/**
 * Provides an array of historical Daily Historical Records for specified dates
 * and locations, each with aggregate detailed climatology data for the
 * requested day, such as record temperatures, precipitation, and snowfall.
 */
model DailyHistoricalRecordsResult {
  /**
   * Aggregates detailed climatology data for each requested day, including
   * record temperatures, precipitation, snowfall, snow depth, and degree day
   * summaries.
   */
  results?: DailyHistoricalRecords[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated.
   *
   * This is useful when the response is too large to be returned in a single
   * call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/** Daily historical weather records. */
model DailyHistoricalRecords {
  /**
   * Date of the historical record, displayed in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  date?: utcDateTime;

  /**
   * Returns the year in which both the minimum and the maximum temperatures
   * occurred on a specified day, along with the recorded amounts. Also returns
   * the average temperature for the given date. Measured in degrees Celsius (C)
   * or Fahrenheit (F), depending on the unit specified in the request.
   */
  temperature?: WeatherValueYearMaxMinAvg;

  /**
   * The amount of precipitation accumulated over the specified day, measured in
   * centimeters (cm) or inches (in), based on the specified unit in the
   * request.
   */
  precipitation?: WeatherValueYearMax;

  /**
   * Returns the year in which the record high snowfall occurred on a specified
   * date, along with the recorded amounts, measured in centimeters (cm) or
   * inches (in), based on the unit specified in the request.
   */
  snowfall?: WeatherValueYearMax;
}

/**
 * The WeatherUnitYearMaxMinAvg object returns the year in which both the
 * minimum and the maximum temperatures occurred on a specified day, along with
 * the recorded amounts. Also returns the average temperature for the given
 * date. Measured in degrees Celsius (C) or Fahrenheit (F), depending on the
 * unit specified in the request.
 */
model WeatherValueYearMaxMinAvg {
  /**
   * Returns the year in which the maximum amount of precipitation and snowfall
   * occurred on a specified day, along with the recorded amounts. These values
   * are measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  maximum?: WeatherValueYear;

  /**
   * Returns the year in which the minimum amount of precipitation and snowfall
   * occurred on a specified day, along with the recorded amounts. These values
   * are measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  minimum?: WeatherValueYear;

  /** The average air temperature for the requested time and location. */
  average?: WeatherValue;
}

/**
 * Record-setting values, by year, for daily weather-related metrics such as
 * temperature, dew point, and wind speed, presented in either metric or
 * imperial units as specified in the unit URI parameter. For more information,
 * see [Unit types](/azure/azure-maps/weather-services-concepts#unit-types) in
 * the article Weather services in Azure Maps.
 */
model WeatherValueYear {
  /**
   * The value property represents the specific measurement for any given
   * weather parameter. For example, if the weather parameter is maximum
   * temperature, and the location is Dilworth Park in Philadelphia, PA
   * the value is 21.1 °C.
   */
  value?: float32;

  /**
   * The unit of measurement used in the return value, such as "C" for Celsius,
   * "F" for Fahrenheit.
   */
  unit?: string;

  /**
   * An integer representing the type of unit. For example, 17 for Celsius, 18
   * for Fahrenheit. For a complete list, see [Unit
   * types](/azure/azure-maps/weather-services-concepts#unit-types) in the
   * article Weather services in Azure Maps.
   */
  unitType?: int32;

  /**
   * Specifies the year for which the historical weather data is being returned.
   * For example, if the weather parameter is maximum temperature and the
   * location is Dilworth Park in Philadelphia, PA, the record-setting year is
   * 1906.
   */
  year?: int32;
}

/**
 * The WeatherUnitYearMax object returns the year and the recorded amounts for
 * the maximum temperature, precipitation, and snowfall that occurred on a
 * specified day.
 */
model WeatherValueYearMax {
  /**
   * Returns the year in which the maximum amount of precipitation and snowfall
   * occurred on a specified day, along with the recorded amounts. These values
   * are measured in millimeters (mm) or inches (in), depending on the unit
   * specified in the request.
   */
  maximum?: WeatherValueYear;
}

/**
 * Returns an array of `DailyHistoricalNormals` objects, each detailing
 * climatology data such as past daily normal temperatures, precipitation, and
 * cooling/heating degree day information for the specified date range,
 * calculated as a 30-year average (1991-2020). The number of days included is
 * determined by the `startDate` and `endDate` URI parameters, which can include
 * up to 31 days.
 */
model DailyHistoricalNormalsResult {
  /**
   * Aggregates detailed climatology data for each requested day, including
   * normal temperatures, precipitation, snowfall, snow depth, and degree day
   * summaries.
   */
  results?: DailyHistoricalNormals[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated.
   *
   * This is useful when the response is too large to be returned in a single
   * call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/** Daily historical normal weather data. */
model DailyHistoricalNormals {
  /**
   * Date of the historical normals, displayed in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  date?: utcDateTime;

  /**
   * Provides the normal high, low, and average temperatures for a specific day
   * at a given location, calculated as a 30-year average (1991-2020).
   */
  temperature?: WeatherValueMaxMinAvg;

  /**
   * Provides a summary of heating and cooling degree days, which measure
   * temperature deviations from a standard of 65°F / 18°C to indicate energy
   * usage for heating or cooling.
   *
   * Provides a summary of heating and cooling degree days. Heating Degree Days
   * (HDD) measure the demand for energy to heat a building, calculated based on
   * the degrees a day's average temperature is below 65°F/18°C. Cooling Degree
   * Days (CDD) measure the demand for energy to cool a building, calculated
   * based on the degrees a day's average temperature is above 65°F/18°C. This
   * summary aids in energy management and planning.
   */
  degreeDaySummary?: DegreeDaySummary;

  /**
   * Provides the amount of precipitation accumulated over the specified day,
   * measured in centimeters (cm) or inches (in), based on the specified unit in
   * the request.
   */
  precipitation?: WeatherValue;
}
