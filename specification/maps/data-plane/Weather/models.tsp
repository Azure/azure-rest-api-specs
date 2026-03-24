import "@typespec/rest";
import "@typespec/http";
import "./common/common.tsp";

namespace MapsWeather;

/** Desired response format. */
union JsonFormat {
  string,

  /**
   * [The JavaScript Object Notation Data Interchange
   * Format](https://tools.ietf.org/html/rfc8259)
   */
  json: "json",
}

/** Unit of measurement for weather data. */
union WeatherDataUnit {
  string,

  /**
   * Return data using imperial units such as Fahrenheit (F) for temperature and
   * mile (mi) for distance.
   */
  imperial: "imperial",

  /**
   * Return data using metric units such as Celsius (C) for temperature and
   * kilometer (km) for distance.
   */
  metric: "metric",
}

/**
 * Numeric value representing an image that corresponds to the current weather
 * condition described by the `Phrase` property. For more information, see
 * [Weather services in Azure
 * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
 */
union IconCode {
  integer,

  /**
   * Sunny
   */
  Sunny: 1,

  /**
   * Mostly Sunny
   */
  MostlySunny: 2,

  /**
   * Partly Sunny
   */
  PartlySunny: 3,

  /**
   * Intermittent Clouds
   */
  IntermittentClouds: 4,

  /**
   * Hazy Sunshine
   */
  HazySunshine: 5,

  /**
   * Mostly Cloudy
   */
  MostlyCloudy: 6,

  /**
   * Cloudy
   */
  Cloudy: 7,

  /**
   * Dreary (Overcast)
   */
  Dreary: 8,

  /**
   * Fog
   */
  Fog: 11,

  /**
   * Showers
   */
  Showers: 12,

  /**
   * Mostly Cloudy with Showers
   */
  MostlyCloudyWithShowers: 13,

  /**
   * Partly Sunny with Showers
   */
  PartlySunnyWithShowers: 14,

  /**
   * Thunderstorms
   */
  Thunderstorms: 15,

  /**
   * Mostly Cloudy with Thunderstorms
   */
  MostlyCloudyWithThunderstorms: 16,

  /**
   * Partly Sunny with Thunderstorms
   */
  PartlySunnyWithThunderstorms: 17,

  /**
   * Rain
   */
  Rain: 18,

  /**
   * Flurries
   */
  Flurries: 19,

  /**
   * Mostly Cloudy with Flurries
   */
  MostlyCloudyWithFlurries: 20,

  /**
   * Partly Sunny with Flurries
   */
  PartlySunnyWithFlurries: 21,

  /**
   * Snow
   */
  Snow: 22,

  /**
   * Mostly Cloudy with Snow
   */
  MostlyCloudyWithSnow: 23,

  /**
   * Ice
   */
  Ice: 24,

  /**
   * Sleet
   */
  Sleet: 25,

  /**
   * Freezing Rain
   */
  FreezingRain: 26,

  /**
   * Rain and Snow
   */
  RainAndSnow: 29,

  /**
   * Hot
   */
  Hot: 30,

  /**
   * Cold
   */
  Cold: 31,

  /**
   * Windy
   */
  Windy: 32,

  /**
   * Clear
   */
  Clear: 33,

  /**
   * Mostly Clear
   */
  `Mostly Clear`: 34,

  /**
   * Partly Cloudy
   */
  `Partly Cloudy`: 35,

  /**
   * Intermittent Clouds (Night)
   */
  IntermittentCloudsNight: 36,

  /**
   * Hazy Moonlight
   */
  HazyMoonlight: 37,

  /**
   * Mostly Cloudy (Night)
   */
  MostlyCloudyNight: 38,

  /**
   * Partly Cloudy with Showers
   */
  PartlyCloudyWithShowers: 39,

  /**
   * Mostly Cloudy with Showers (Night)
   */
  MostlyCloudyWithShowersNight: 40,

  /**
   * Partly Cloudy with Thunderstorms
   */
  `Partly Cloudy with Thunderstorms`: 41,

  /**
   * Mostly Cloudy with Thunderstorms (Night)
   */
  MostlyCloudyWithThunderstormsNight: 42,

  /**
   * Mostly Cloudy with Flurries (Night)
   */
  MostlyCloudyWithFlurriesNight: 43,

  /**
   * Mostly Cloudy with Snow (Night)
   */
  MostlyCloudyWithSnowNight: 44,
}

/**
 * An integer representing the unit type.  For example, 17 for Celsius, 18 for
 * Fahrenheit. Can be used for unit translation. For a complete list, see [Weather
 * services in Azure
 * Maps](/azure/azure-maps/weather-services-concepts#unit-types).
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
 * Specifies the type of precipitation. Valid values are Rain, Snow, Ice, or Mix.
 * This property is included in the response when dBZ is greater than zero.
 */
union PrecipitationType {
  string,

  /**
   * Ice
   */
  Ice: "Ice",

  /**
   * Mix
   */
  Mix: "Mix",

  /**
   * Rain
   */
  Rain: "Rain",

  /**
   * Snow
   */
  Snow: "Snow",
}

/**
 * Divides the day into four 6-hour quarters. Valid values are 0-3:<ul><li>0:
 * Morning (7am - 1pm)</li><li>1: Afternoon (1pm - 7pm)</li><li>2: Evening (7pm -
 * 1am)</li><li>3: Overnight (1am - 7am)</li></ul>
 */
union DayQuarter {
  integer,

  /**
   * 7:00 am - 1:00 pm / 7:00- 13:00
   */
  FirstQuarter: 0,

  /**
   * 1:00 pm - 7:00 pm/ 13:00- 19:00
   */
  SecondQuarter: 1,

  /**
   * 7:00 pm - 1:00 am/ 19:00 - 01:00
   */
  ThirdQuarter: 2,

  /**
   * 1:00 am - 7:00 am/ 01:00 - 07:00
   */
  ForthQuarter: 3,
}

/**
 * The aggregated severity/hazard index for each waypoint, which can be used to
 * color-code route segments to indicate driver safety.
 *   * `0` - No hazard.
 *   * `1` - Be informed, be aware.
 *   * `2` - Pay attention, be prepared.
 *   * `3` - Take action.
 *   * `4` - Life threatening, emergency.
 */
union HazardIndex {
  integer,

  /**
   * No hazard
   */
  NoHazard: 0,

  /**
   * Be informed
   */
  Informed: 1,

  /**
   * Pay attention
   */
  PayAttention: 2,

  /**
   * Take action
   */
  TakeAction: 3,

  /**
   * Emergency
   */
  Emergency: 4,
}

/**
 * A predefined list of eight keywords used to describe the current status of a
 * severe weather alert.
 */
union LatestStatusKeyword {
  string,

  /**
   * Indicates that the alert has been canceled before its originally scheduled
   * expiration time.
   */
  Cancel: "Cancel",

  /**
   * Indicates that the alert has been updated since its initial issuance, but no
   * changes were made to `alertDetails`, `startTime`, `endTime`, or `class`.
   */
  Continue: "Continue",

  /**
   * Indicates that the alert has been modified to correct a previous error.
   */
  Correct: "Correct",

  /**
   * Indicates that the alert has expired and is no longer active.
   */
  Expire: "Expire",

  /**
   * Indicates that the alert has been extended in duration, area, or both since its
   * initial issuance.
   */
  Extend: "Extend",

  /**
   * The status of an alert when first issued.
   */
  New: "New",

  /**
   * Indicates that the alert has been modified since its initial issuance.
   */
  Update: "Update",

  /**
   * Indicates that the alert has been elevated to a higher class or category since
   * first issued.
   */
  Upgrade: "Upgrade",
}

/** Basin identifier for tropical storms. */
union BasinId {
  string,

  /**
   * **The Atlantic Ocean**. Crucial for tracking hurricanes that affect the
   * Americas and the Caribbean. It is one of the most active regions for tropical
   * storms.
   */
  AL: "AL",

  /**
   * **The Central Pacific Ocean**. This basin is used for storms affecting Hawaii
   * and surrounding areas.
   */
  CP: "CP",

  /**
   * **The Eastern Pacific Ocean**. This basin tracks storms impacting the western
   * coast of the Americas, including Mexico and Central America. It is adjacent to
   * the Central Pacific basin.
   */
  EP: "EP",

  /**
   * **The North Indian Ocean**. This basin covers storms impacting South Asia,
   * including countries like India and Bangladesh, which are frequently affected by
   * cyclones.
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

/**
 * Identifies the pollutant with the highest concentration.
 */
union DominantPollutant {
  string,

  /**
   * Carbon monoxide (CO) is a colorless, odorless, and tasteless but highly toxic
   * gas produced by the incomplete combustion of carbon-containing fuels. Common
   * sources include vehicle exhaust, gas stoves, furnaces, and wood fires.
   */
  `Carbon Monoxide`: "Carbon Monoxide",

  /**
   * Nitrogen dioxide (NO2) is a significant atmospheric pollutant. It is regulated
   * and subject to recommended limit guidelines set by the World Health
   * Organization (WHO).
   */
  `Nitrogen Dioxide`: "Nitrogen Dioxide",

  /**
   * Ozone (O3) is a key component of photochemical smog, the brown, harmful haze
   * that envelops many large cities, resulting from a photochemical reaction
   * between sunlight and certain specific pollutants.
   */
  Ozone: "Ozone",

  /**
   * Particulate matter 2.5 (PM2.5) refers to fine particles with diameters that are
   * generally 2.5 micrometers and smaller. These particles are more than 100 times
   * thinner than a human hair and can remain suspended in the air for extended
   * periods
   */
  `Particulate Matter 2.5`: "Particulate Matter 2.5",

  /**
   * Particulate matter 10 (PM10) refers to particles with diameters that are
   * generally 10 micrometers and smaller. These particles can include dust, pollen,
   * soot, smoke, and liquid droplets.
   */
  `Particulate Matter 10`: "Particulate Matter 10",

  /**
   * Sulfur dioxide (SO2) is a heavy, colorless inorganic gas with a pungent,
   * irritating odor. It is mainly produced by burning fossil fuels at power plants
   * and industrial facilities, but it can also be emitted from natural sources such
   * as volcanoes.
   */
  `Sulfur Dioxide`: "Sulfur Dioxide",
}

/**
 * Specifies the six types of pollutants tracked by the Azure Maps Weather service.
 */
union PollutantType {
  string,

  /**
   * Carbon monoxide
   */
  CO: "CO",

  /**
   * Nitrogen dioxide
   */
  NO2: "NO2",

  /**
   * Ozone
   */
  O3: "O3",

  /**
   * Particulate matter 2.5
   */
  PM2_5: "PM2.5",

  /**
   * Particulate matter 10
   */
  PM10: "PM10",

  /**
   * Sulfur dioxide
   */
  SO2: "SO2",
}

/** Duration in days for which the forecast is requested. */
union DailyDuration {
  integer,

  /**
   * 1 day
   */
  OneDay: 1,

  /**
   * 2 days
   */
  TwoDays: 2,

  /**
   * 3 days
   */
  ThreeDays: 3,

  /**
   * 4 days
   */
  FourDays: 4,

  /**
   * 5 days
   */
  FiveDays: 5,

  /**
   * 6 days
   */
  SixDays: 6,

  /**
   * 7 days
   */
  SevenDays: 7,
}

/** Duration in hours for which the forecast is requested. */
union HourlyDuration {
  integer,

  /**
   * 1 Hours
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

/** Hourly weather forecast result. */
model HourlyForecastResult {
  /**
   * Forecast data for each returned hour.
   */
  @visibility(Lifecycle.Read)
  forecasts?: HourlyForecast[];
}

/** Hourly weather forecast data. */
model HourlyForecast {
  /**
   * Date and time of the forecast in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, for
   * example, 2019-10-27T19:39:57-08:00.
   */
  date?: utcDateTime;

  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
   */
  iconCode?: IconCode;

  /**
   * Phrase description of the weather icon.
   */
  iconPhrase?: string;

  /**
   * A boolean value that indicates whether precipitation (rain, snow, sleet, or
   * hail) is expected during the specified timeframe. Returns true if precipitation
   * is expected, otherwise false.
   */
  hasPrecipitation?: boolean;

  /**
   * Specifies whether or not it is daylight. True indicates day light.
   */
  isDaylight?: boolean;

  /**
   * Temperature being returned.
   */
  temperature?: WeatherValue;

  /**
   * RealFeel™ Temperature being returned. Describes what the temperature really
   * feels like in the shade.
   */
  realFeelTemperature?: WeatherValue;

  /**
   * The temperature to which air may be cooled by evaporating water into it at
   * constant pressure until it reaches saturation.
   */
  wetBulbTemperature?: WeatherValue;

  /**
   * The dewpoint temperature in specified unit. The dewpoint temperature is the
   * temperature that the air must be cooled to in order to reach saturation.
   */
  dewPoint?: WeatherValue;

  /**
   * Wind details being returned including speed and direction.
   */
  wind?: WindDetails;

  /**
   * Wind gust. Wind gust is a sudden, brief increase in speed of the wind.
   */
  windGust?: WindDetails;

  /**
   * Relative humidity is the amount of water vapor present in air expressed as a
   * percentage of the amount needed for saturation at the same temperature.
   */
  relativeHumidity?: int32;

  /**
   * Visibility in specified unit. A measure of the distance at which an object or
   * light can be clearly discerned.
   */
  visibility?: WeatherValue;

  /**
   * Cloud ceiling in specified unit. The ceiling is a measurement of the height of
   * the base of the lowest clouds.
   */
  ceiling?: WeatherValue;

  /**
   * Measure of the strength of the ultraviolet radiation from the sun. Supported
   * values are:
   *   * `0-2` - Low danger from the sun's UV rays or the average person.
   *   * `3-5` - Moderate risk of harm from unprotected sun exposure.
   *   * `6-7` - High risk of harm from unprotected sun exposure.
   *   * `8-10` - Very high risk of harm from unprotected sun exposure.
   *   * `11+` - Extreme risk of harm from unprotected sun exposure.
   */
  uvIndex?: int32;

  /**
   * Phrase associated with the `uvIndex`.
   */
  uvIndexPhrase?: string;

  /**
   * Percent representing the probability of precipitation. For example, '20'.
   */
  precipitationProbability?: int32;

  /**
   * Percent representing the probability of rain. For example, '50'.
   */
  rainProbability?: int32;

  /**
   * Percent representing the probability of snow. For example, '50'.
   */
  snowProbability?: int32;

  /**
   * Percent representing the probability of snow. For example, '5'.
   */
  iceProbability?: int32;

  /**
   * Total liquid equivalent of precipitation during the forecast period.
   */
  totalLiquid?: WeatherValue;

  /**
   * Rain
   */
  rain?: WeatherValue;

  /**
   * Snow
   */
  snow?: WeatherValue;

  /**
   * Ice
   */
  ice?: WeatherValue;

  /**
   * Percent representing cloud cover.
   */
  cloudCover?: int32;
}

/**
 * Specific value of a given unit related to weather.
 */
model WeatherValue {
  /**
   * Rounded value.
   */
  value?: float32;

  /**
   * Type of unit for the returned value.
   */
  unit?: string;

  /**
   * An integer representing the unit type.  For example, 17 for Celsius, 18 for
   * Fahrenheit. Can be used for unit translation. For a complete list, see [Weather
   * services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#unit-types).
   */
  unitType?: UnitType;
}

/**
 * Wind details being returned including speed and direction.
 */
model WindDetails {
  /**
   * Wind direction
   */
  direction?: WindDirection;

  /**
   * Speed of the wind in specified unit.
   */
  speed?: WeatherValue;
}

/**
 * Wind direction
 */
model WindDirection {
  /**
   * Wind direction in Azimuth degrees,  starting at true North and continuing in
   * clockwise direction. North is 0 degrees, east is 90 degrees, south is 180
   * degrees, west is 270 degrees. Possible values 0-359.
   */
  degrees?: int32;

  /**
   * Direction abbreviation in the specified language.
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

/** Minute-by-minute weather forecast result. */
model MinuteForecastResult {
  /**
   * Phrase summaries for the entire forecast period.
   */
  @visibility(Lifecycle.Read)
  summary?: MinuteForecastSummary;

  /**
   * Summary information for each interval in the forecast. The Summaries breaks
   * down each potential interval where precipitation starts and stops.
   */
  @visibility(Lifecycle.Read)
  intervalSummaries?: IntervalSummary[];

  /**
   * Forecast data for each interval in the forecast.
   */
  @visibility(Lifecycle.Read)
  intervals?: ForecastInterval[];
}

/**
 * Phrase summaries for the entire forecast period.
 */
model MinuteForecastSummary {
  /**
   * Summary phrase for the next 60 minutes. Phrase length is approximately 60
   * characters.
   */
  briefPhrase60?: string;

  /**
   * Short summary phrase for the next 120 minutes. Phrase length is approximately
   * 25 characters.
   */
  shortPhrase?: string;

  /**
   * Summary phrase for the next 120 minutes. Phrase length is approximately 60
   * characters.
   */
  briefPhrase?: string;

  /**
   * Long summary phrase for the next 120 minutes. Phrase length is 60+ characters.
   */
  longPhrase?: string;

  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
   */
  iconCode?: IconCode;
}

/** Summary information for a forecast interval. */
model IntervalSummary {
  /**
   * The first minute to which the summary applies.
   */
  startMinute?: int32;

  /**
   * The last minute to which the summary applies.
   */
  endMinute?: int32;

  /**
   * The number of minutes for which the summary applies.
   */
  totalMinutes?: int32;

  /**
   * Short summary phrase. Phrase length is approximately 25 characters.
   */
  shortPhrase?: string;

  /**
   * Brief summary phrase. Phrase length is approximately 60 characters.
   */
  briefPhrase?: string;

  /**
   * Long summary phrase. Phrase length is 60+ characters.
   */
  longPhrase?: string;

  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
   */
  iconCode?: IconCode;
}

/** Forecast data for a specific interval. */
model ForecastInterval {
  /**
   * The date and time for the start of the interval in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, for
   * example, 2019-10-27T19:39:57-08:00.
   */
  startTime?: utcDateTime;

  /**
   * The first minute for the interval.
   */
  minute?: int32;

  /**
   * A unit that represents forecasted precipitation intensity.
   */
  dbz?: float64;

  /**
   * A short phrase describing precipitation condition for the interval.
   */
  shortPhrase?: string;

  /**
   * Key that specifies the threshold value. Along with precipitationType, can be
   * used to determine the simplifiedColor. If dBZ is zero, not present in the
   * response.
   */
  threshold?: string;

  /**
   * The full spectrum color that maps to the dBZ (decibel relative to Z). If dBZ is
   * zero, color is not present in the response.
   */
  color?: ColorValue;

  /**
   * The band color that maps to the precipitation type and threshold. If dBZ is
   * zero, not present in the response.
   */
  simplifiedColor?: ColorValue;

  /**
   * Specifies the type of precipitation. Valid values are Rain, Snow, Ice, or Mix.
   * This property is included in the response when dBZ is greater than zero.
   */
  precipitationType?: PrecipitationType;

  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
   */
  iconCode?: IconCode;

  /**
   * Percent representing cloud cover.
   */
  cloudCover?: int32;
}

/** Color value represented as RGB and hexadecimal. */
model ColorValue {
  /**
   * Red component of the RGB value.
   */
  red?: int32;

  /**
   * Green component of the RGB value.
   */
  green?: int32;

  /**
   * Blue component of the RGB value
   */
  blue?: int32;

  /**
   * Hexadecimal color value.
   */
  hex?: string;
}

/** Quarter-day weather forecast result. */
model QuarterDayForecastResult {
  /**
   * Forecast data for each quarter in the response.
   */
  @visibility(Lifecycle.Read)
  forecasts?: QuarterDayForecast[];
}

/** Quarter-day weather forecast data. */
model QuarterDayForecast {
  /**
   * Date of the forecast as example, 2019-10-27T00:00:00
   */
  date?: utcDateTime;

  /**
   * Date and time of the beginning of the forecast quarter displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, for
   * example, 2019-10-27T19:39:57-08:00.
   */
  effectiveDate?: utcDateTime;

  /**
   * Divides the day into four 6-hour quarters. Valid values are 0-3:<ul><li>0:
   * Morning (7am - 1pm)</li><li>1: Afternoon (1pm - 7pm)</li><li>2: Evening (7pm -
   * 1am)</li><li>3: Overnight (1am - 7am)</li></ul>
   */
  quarter?: DayQuarter;

  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
   */
  iconCode?: IconCode;

  /**
   * Phrase description of the icon. Displayed in specified language. For example,
   * 'Sunny'.
   */
  iconPhrase?: string;

  /**
   * Short summary phrase summary for quarter.
   */
  phrase?: string;

  /**
   * Temperature values for the quarter.
   */
  temperature?: WeatherValueRange;

  /**
   * RealFeel™ Temperature values for the quarter.
   */
  realFeelTemperature?: WeatherValueRange;

  /**
   * The dewpoint temperature in specified unit. The dewpoint temperature is the
   * temperature that the air must be cooled to in order to reach saturation.
   */
  dewPoint?: WeatherValue;

  /**
   * Relative humidity is the amount of water vapor present in air expressed as a
   * percentage of the amount needed for saturation at the same temperature.
   */
  relativeHumidity?: int32;

  /**
   * Wind details being returned including speed and direction.
   */
  wind?: WindDetails;

  /**
   * Wind gust. Wind gust is a sudden, brief increase in speed of the wind.
   */
  windGust?: WindDetails;

  /**
   * Visibility in specified unit. A measure of the distance at which an object or
   * light can be clearly discerned.
   */
  visibility?: WeatherValue;

  /**
   * Percent representing cloud cover.
   */
  cloudCover?: int32;

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
   * Percent representing the probability of precipitation. For example, '20'.
   */
  precipitationProbability?: int32;

  /**
   * Percent representing the probability of a thunderstorm. For example, '10'.
   */
  thunderstormProbability?: int32;

  /**
   * Total liquid equivalent of precipitation during the forecast period.
   */
  totalLiquid?: WeatherValue;

  /**
   * Rain
   */
  rain?: WeatherValue;

  /**
   * Snow
   */
  snow?: WeatherValue;

  /**
   * Ice
   */
  ice?: WeatherValue;
}

/**
 * Returned temperature values.
 */
model WeatherValueRange {
  /**
   * Minimum temperature for the time period.
   */
  minimum?: WeatherValue;

  /**
   * Maximum temperature for the time period
   */
  maximum?: WeatherValue;
}

/** Current weather conditions result. */
model CurrentConditionsResult {
  /**
   * Detailed current weather conditions.
   */
  @visibility(Lifecycle.Read)
  results?: CurrentConditions[];
}

/** Current weather conditions data. */
model CurrentConditions {
  /**
   * Date and time of the current observation displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, for
   * example, 2019-10-27T19:39:57-08:00.
   */
  dateTime?: utcDateTime;

  /**
   * Phrase description of the current weather condition.  Displayed in specified
   * language.
   */
  phrase?: string;

  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
   */
  iconCode?: IconCode;

  /**
   * A boolean value that indicates whether precipitation (rain, snow, sleet, or
   * hail) is expected during the specified timeframe. Returns true if precipitation
   * is expected, otherwise false.
   */
  hasPrecipitation?: boolean;

  /**
   * Indicates the time of the day. True indicates 'day',', false indicates 'night.
   */
  isDayTime?: boolean;

  /**
   * Temperature being returned.
   */
  temperature?: WeatherValue;

  /**
   * RealFeel™ Temperature being returned.
   */
  realFeelTemperature?: WeatherValue;

  /**
   * RealFeel™ Temperature being returned. Describes what the temperature really
   * feels like in the shade.
   */
  realFeelTemperatureShade?: WeatherValue;

  /**
   * Relative humidity is the amount of water vapor present in air expressed as a
   * percentage of the amount needed for saturation at the same temperature.
   */
  relativeHumidity?: int32;

  /**
   * The dewpoint temperature in specified unit. The dewpoint temperature is the
   * temperature that the air must be cooled to in order to reach saturation.
   */
  dewPoint?: WeatherValue;

  /**
   * Wind details being returned including speed and direction.
   */
  wind?: WindDetails;

  /**
   * Wind gust. Wind gust is a sudden, brief increase in speed of the wind.
   */
  windGust?: WindDetails;

  /**
   * Measure of the strength of the ultraviolet radiation from the sun. Supported
   * values are:
   *   * `0-2` - Low danger from the sun's UV rays or the average person.
   *   * `3-5` - Moderate risk of harm from unprotected sun exposure.
   *   * `6-7` - High risk of harm from unprotected sun exposure.
   *   * `8-10` - Very high risk of harm from unprotected sun exposure.
   *   * `11+` - Extreme risk of harm from unprotected sun exposure.
   */
  uvIndex?: int32;

  /**
   * Phrase associated with the `uvIndex`.
   */
  uvIndexPhrase?: string;

  /**
   * Visibility in specified unit. A measure of the distance at which an object or
   * light can be clearly discerned.
   */
  visibility?: WeatherValue;

  /**
   * Cause of limited visibility.
   *
   * Possible values:
   *
   * - _A = heavy thunderstorm/hail_
   * - _BD = blowing dust_
   * - _BN = blowing sand_
   * - _BS = blowing snow_
   * - _D = dust_
   * - _F = fog_
   * - _GF = ground fog_
   * - _HZ = haze_
   * - _I = ice_
   * - _IC = ice crystals_
   * - _IF = ice fog_
   * - _IP = ice pellets_
   * - _IPW = ice pellets shower_
   * - _K = smoke_
   * - _L = drizzle_
   * - _R = rain_
   * - _RS = rain/snow_
   * - _RW = rain shower_
   * - _S = snow_
   * - _SG = snow granules_
   * - _SP = snow pellets_
   * - _SW = snow shower_
   * - _T = thunderstorm_
   * - _UP = undefined precipitation_
   * - _ZL = freezing drizzle_
   * - _ZR = freezing rain_
   * - _+ = heavy_
   * - _- = light_
   */
  obstructionsToVisibility?: string;

  /**
   * Percent representing cloud cover.
   */
  cloudCover?: int32;

  /**
   * Cloud ceiling in specified unit. The ceiling is a measurement of the height of
   * the base of the lowest clouds.
   */
  ceiling?: WeatherValue;

  /**
   * Atmospheric pressure in specified unit.
   */
  pressure?: WeatherValue;

  /**
   * Atmospheric pressure change.
   */
  pressureTendency?: PressureTendency;

  /**
   * Departure from the temperature observed 24 hours ago in specified unit.
   */
  pastTwentyFourHourTemperatureDeparture?: WeatherValue;

  /**
   * Perceived outdoor temperature caused by the combination of air temperature,
   * relative humidity, and wind speed in specified unit.
   */
  apparentTemperature?: WeatherValue;

  /**
   * Perceived air temperature on exposed skin due to wind.
   */
  windChillTemperature?: WeatherValue;

  /**
   * The temperature to which air may be cooled by evaporating water into it at
   * constant pressure until it reaches saturation.
   */
  wetBulbTemperature?: WeatherValue;

  /**
   * Summary of precipitation amounts over the past 24 hours.
   */
  precipitationSummary?: PrecipitationSummary;

  /**
   * Summary of temperature fluctuations over the past 6, 12, and 24 hours.
   */
  temperatureSummary?: TemperatureSummary;
}

/** Atmospheric pressure tendency. */
model PressureTendency {
  /**
   * Description of the pressure tendency in specified language
   */
  localizedDescription?: string;

  /**
   * Pressure tendency code regardless of language. One of F=Falling, S=Steady,
   * R=Rising.
   */
  code?: string;
}

/** Summary of precipitation amounts. */
model PrecipitationSummary {
  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * hour.
   */
  pastHour?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * three hours.
   */
  past3Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past six
   * hours. Contains Metric and Imperial Values.
   */
  past6Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past
   * nine hours.
   */
  past9Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past 12
   * hours.
   */
  past12Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past 18
   * hours.
   */
  past18Hours?: WeatherValue;

  /**
   * The amount of precipitation (liquid equivalent) that has fallen in the past 24
   * hours.
   */
  past24Hours?: WeatherValue;
}

/** Summary of temperature fluctuations. */
model TemperatureSummary {
  /**
   * Summary of temperature fluctuations over the past 6 hours.
   */
  past6Hours?: PastHoursTemperature;

  /**
   * Summary of temperature fluctuations over the past 12 hours.
   */
  past12Hours?: PastHoursTemperature;

  /**
   * Summary of temperature fluctuations over the past 24 hours.
   */
  past24Hours?: PastHoursTemperature;
}

/**
 * Summary of temperature fluctuations over the number of past hours.
 */
model PastHoursTemperature {
  /**
   * minimum
   */
  minimum?: WeatherValue;

  /**
   * maximum
   */
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
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  startDate?: utcDateTime;

  /**
   * The end date and time for the forecast summary, in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  endDate?: utcDateTime;

  /**
   * Indicates the severity of the forecasted weather as an integer. Lower numbers
   * represent higher severity: 0 = Unknown, 1 = Significant, 2 = Major, 3 =
   * Moderate, 4 = Minor, 5 = Minimal, 6 = Insignificant, 7 = Informational.
   */
  severity?: int32;

  /**
   * Provides a brief textual summary of the daily weather conditions, displayed in
   * the specified language.
   */
  phrase?: string;

  /**
   * Provides a one or two-word summary of the forecasted weather conditions, such
   * as Sunny, Partly Cloudy, Rain, or Snow.
   */
  category?: string;
}

/**
 * Provides detailed weather information for a specific day, such as temperature,
 * wind, precipitation, air quality, and UV index.
 */
model DailyForecast {
  /**
   * Date and time of the current observation, displayed in [ISO
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
   * degrees Celsius (C) or Fahrenheit (F), depending on the unit specified in the
   * request. This metric, developed by AccuWeather, incorporates over a dozen
   * factors, including humidity, wind speed, cloud cover, and sun intensity, to
   * offer a comprehensive measure of how the weather actually feels.
   */
  realFeelTemperature?: WeatherValueRange;

  /**
   * Provides RealFeel™ Temperature values for the specified day in shaded areas.
   * This metric, developed by AccuWeather, incorporates over a dozen factors,
   * including humidity, wind speed, cloud cover, and sun intensity, to offer a
   * comprehensive measure of how the weather actually feels in the shade.
   */
  realFeelTemperatureShade?: WeatherValueRange;

  /**
   * Provides the expected number of hours of sunshine for the specified day.
   */
  hoursOfSun?: float32;

  /**
   * Provides a summary of heating and cooling degree days. Heating Degree Days
   * (HDD) measure the demand for energy to heat a building, calculated based on the
   * degrees a day's average temperature is below 65°F/18°C. Cooling Degree Days
   * (CDD) measure the demand for energy to cool a building, calculated based on the
   * degrees a day's average temperature is above 65°F/18°C. This summary aids in
   * energy management and planning.
   */
  degreeDaySummary?: DegreeDaySummary;

  /**
   * A list containing pollutants, pollen levels, and the UV index for the daily
   * forecast. Each list item includes forecasted amounts and categories (e.g., low,
   * high, good, moderate, unhealthy, hazardous) to assess potential health risks.
   */
  airAndPollen?: AirAndPollen[];

  /**
   * Provides detailed weather information for the daytime weather forecast,
   * including temperature, precipitation, wind, and other key attributes.
   */
  day?: DailyForecastDetail;

  /**
   * Provides detailed weather information for the nighttime weather forecast,
   * including temperature, precipitation, wind, and other key attributes.
   */
  night?: DailyForecastDetail;

  /**
   * A list of sources contributing to the weather forecast data.
   */
  sources?: string[];
}

/** Summary of heating and cooling degree days. */
model DegreeDaySummary {
  /**
   * Number of degrees that the mean temperature is below 65 degrees F/ 18 degree C.
   */
  heating?: WeatherValue;

  /**
   * Number of degrees that the mean temperature is above 65 degrees F/ 18 degree C.
   */
  cooling?: WeatherValue;
}

/**
 * The AirAndPollen object provides comprehensive environmental data. It
 * identifies various pollen types such as tree, grass, ragweed, and mold, and
 * pollutants including PM2.5, PM10, O3, NO2, SO2, and CO. Additionally, it
 * reports the UV Index on a scale from 1 to 10, offers qualitative descriptions
 * of air quality or pollen levels, and provides numerical measurements of the
 * concentration of pollutants or pollen in the air. This detailed information
 * helps users assess air quality and pollen conditions along their travel route.
 */
model AirAndPollen {
  /**
   * **For pollen:**
   * Returns the name of the pollen, such as tree, grass, ragweed, or mold.
   *
   * **For pollutants:**
   * When the `name` property is `AirQuality`, the name of the pollutant is returned
   * in the `type` property.
   * Valid pollutants include: PM2.5, PM10, O3, NO2, SO2, and CO.
   *
   * **For UV Index:**
   * When the `name` property is `UVIndex`, the UV index is returned in the `value`
   * property. Valid UV Index values range from 0 to 11+ and represent the intensity
   * of ultraviolet radiation.
   * UV Index values are categorized as follows:
   * <ul><li><B>0-2</B>: Low</li><li><B>3-5</B>: Moderate</li><li><B>6-7</B>:
   * High</li><li><B>8-10</B>: Very High</li><li><B>11+</B>: Extreme</li></ul>
   */
  name?: string;

  /**
   * Provides a numerical measurement of the concentration of pollutants or pollen
   * in the air. This value is typically expressed in units relevant to the type of
   * pollutant or pollen being measured, such as micrograms per cubic meter (µg/m³)
   * for particulate matter or parts per billion (ppb) for gases like ozone. Both
   * air quality and UV are indices, so they are unitless.
   */
  value?: int32;

  /**
   * Provides a one-word qualitative description of the air quality or pollen level
   * for the forecast period in the specified language. This property categorizes
   * the air quality or pollen count into different levels, such as low, high, good,
   * moderate, unhealthy, hazardous giving users an easy-to-understand assessment of
   * the current conditions.
   */
  category?: string;

  /**
   * Provides a numerical representation of the air quality or pollen level. This
   * value corresponds to the qualitative `category` property, offering a precise
   * way to quantify the air quality or pollen level. These values range from 1 to
   * 6, with 1 implying good conditions and 6 implying hazardous conditions.
   */
  categoryValue?: int32;

  /**
   * Specifies the type of air pollutant being measured. Only used when the `name`
   * property equals *AirQuality*. Examples of air pollutants include Particulate
   * Matter (PM2.5, PM10), Ozone (O3), Nitrogen Dioxide (NO2), Sulfur Dioxide (SO2),
   * and Carbon Monoxide (CO).
   */
  type?: string;
}

/** Detailed weather forecast for a portion of the day. */
model DailyForecastDetail {
  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
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
   * Percent representing the probability of precipitation. For example, '20'.
   */
  precipitationProbability?: int32;

  /**
   * Percent representing the probability of a thunderstorm. For example, '80'.
   */
  thunderstormProbability?: int32;

  /**
   * Percent representing the probability of rain. For example, '40'.
   */
  rainProbability?: int32;

  /**
   * Percent representing the probability of snow. For example, '30'.
   */
  snowProbability?: int32;

  /**
   * Percent representing the probability of ice. For example, '30'.
   */
  iceProbability?: int32;

  /**
   * Wind details being returned including speed and direction.
   */
  wind?: WindDetails;

  /**
   * Wind gust. Wind gust is a sudden, brief increase in speed of the wind.
   */
  windGust?: WindDetails;

  /**
   * Total liquid equivalent of precipitation during the forecast period.
   */
  totalLiquid?: WeatherValue;

  /**
   * Rain
   */
  rain?: WeatherValue;

  /**
   * Snow
   */
  snow?: WeatherValue;

  /**
   * Ice
   */
  ice?: WeatherValue;

  /**
   * Hours of precipitation
   */
  hoursOfPrecipitation?: float32;

  /**
   * Hours of rain.
   */
  hoursOfRain?: float32;

  /**
   * Hours of snow.
   */
  hoursOfSnow?: float32;

  /**
   * Hours of ice.
   */
  hoursOfIce?: float32;

  /**
   * Percent representing cloud cover.
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
 * This object is returned from a successful Weather Along Route.
 */
model WeatherAlongRouteResult {
  /**
   * Short summary of the weather along the route.
   */
  @visibility(Lifecycle.Read)
  summary?: WeatherAlongRouteSummary;

  /**
   * Data for each waypoint returned in the same order as specified in the request.
   */
  @visibility(Lifecycle.Read)
  waypoints?: WaypointForecast[];
}

/**
 * Short summary of the weather along the route.
 */
model WeatherAlongRouteSummary {
  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
   */
  iconCode?: IconCode;

  /**
   * Description of the weather hazard affecting the trip.
   */
  hazards?: WeatherHazards;
}

/**
 * Description of the weather hazard affecting the trip.
 */
model WeatherHazards {
  /**
   * The aggregated severity/hazard index for each waypoint, which can be used to
   * color-code route segments to indicate driver safety.
   *   * `0` - No hazard.
   *   * `1` - Be informed, be aware.
   *   * `2` - Pay attention, be prepared.
   *   * `3` - Take action.
   *   * `4` - Life threatening, emergency.
   */
  maxHazardIndex?: HazardIndex;

  /**
   * Details of the weather hazards affecting the trip.
   */
  hazardDetails?: HazardDetail[];
}

/** Details about a weather hazard. */
model HazardDetail {
  /**
   * The aggregated severity/hazard index for each waypoint, which can be used to
   * color-code route segments to indicate driver safety.
   *   * `0` - No hazard.
   *   * `1` - Be informed, be aware.
   *   * `2` - Pay attention, be prepared.
   *   * `3` - Take action.
   *   * `4` - Life threatening, emergency.
   */
  hazardIndex?: HazardIndex;

  /**
   * A unique identifier (non-displayable) for each type of hazard: LightRain,
   * ModerateRain, HeavyRain, LightMix, ModerateMix, HeavyMix, LightSnow,
   * ModerateSnow, HeavySnow, LightIce, ModerateIce, HeavyIce, Hail, LargeHail,
   * SunGlare, SunGlareHigh, Lightning, SevereLightning, WindModerate, WindHigh,
   * WindExtreme, FloodWarning, FlashFloodWarning, TornadoWarning, TsunamiWarning,
   * SevereThunderstormWarning.
   */
  hazardCode?: string;

  /**
   * A displayable short phrase describing the forecasted conditions and
   * precipitation intensity/type.
   */
  shortPhrase?: string;
}

/** Weather forecast data for a waypoint along a route. */
model WaypointForecast {
  /**
   * Numeric value representing an image that corresponds to the current weather
   * condition described by the `Phrase` property. For more information, see
   * [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#weather-icons). May be NULL.
   */
  iconCode?: IconCode;

  /**
   * A displayable short phrase describing the forecasted conditions and
   * precipitation intensity/type.
   */
  shortPhrase?: string;

  /**
   * Indicates the time of the day. True indicates 'day',', false indicates 'night.
   */
  isDayTime?: boolean;

  /**
   * Percent representing cloud cover.
   */
  cloudCover?: int32;

  /**
   * Specific value of a given unit related to weather.
   */
  temperature?: WeatherValue;

  /**
   * Wind details being returned including speed and direction.
   */
  wind?: WindDetails;

  /**
   * Wind details being returned including speed and direction.
   */
  windGust?: WindDetails;

  /**
   * Precipitation forecast of the weather along the route.
   */
  precipitation?: WeatherAlongRoutePrecipitation;

  /**
   * Estimation of thunderstorm intensity on an open scale. A value of 0 means there
   * is no thunderstorm; values of 1 and higher mean there is a thunderstorm in
   * increasing intensity.
   */
  lightningCount?: int32;

  /**
   * A rating that indicates how blinding the sun is for the driver.
   */
  sunGlare?: SunGlare;

  /**
   * Description of the weather hazard affecting the trip.
   */
  hazards?: WeatherHazards;

  /**
   * List of weather hazard notifications.
   */
  notifications?: WeatherNotification[];
}

/**
 * Precipitation forecast of the weather along the route.
 */
model WeatherAlongRoutePrecipitation {
  /**
   * The forecasted precipitation intensity in dBZ (decibels relative to Z) from 0.0
   * to 100.0.
   */
  dbz?: float64;

  /**
   * Precipitation type. If precipitation should occur, the type that it will be:
   * "RAIN," "HAIL," "SNOW," "ICE," or "MIX."
   */
  type?: string;
}

/**
 * A rating that indicates how blinding the sun is for the driver.
 */
model SunGlare {
  /**
   * If the vehicle heading value is not provided for a waypoint, then the service
   * will calculate a heading based upon the location of neighboring waypoints if
   * provided.
   */
  calculatedVehicleHeading?: int32;

  /**
   * An index from 0 to 100 indicating sun glare intensity for a driver. A value of
   * 50 and above can be considered a hazard for some drivers and a value of 100
   * signifies the driver is driving straight into the sun and atmospheric
   * conditions are clear allowing for the full intensity of the sun to blind the
   * driver.
   */
  glareIndex?: int32;
}

/** Weather hazard notification. */
model WeatherNotification {
  /**
   * A type of notification generated to warn drivers of the onset of a hazard, or
   * increase in intensity of a hazard.
   */
  type?: string;

  /**
   * The aggregated severity/hazard index for each waypoint, which can be used to
   * color-code route segments to indicate driver safety.
   *   * `0` - No hazard.
   *   * `1` - Be informed, be aware.
   *   * `2` - Pay attention, be prepared.
   *   * `3` - Take action.
   *   * `4` - Life threatening, emergency.
   */
  hazardIndex?: HazardIndex;

  /**
   * A unique identifier (non-displayable) for each type of hazard: LightRain,
   * ModerateRain, HeavyRain, LightMix, ModerateMix, HeavyMix, LightSnow,
   * ModerateSnow, HeavySnow, LightIce, ModerateIce, HeavyIce, Hail, LargeHail,
   * SunGlare, SunGlareHigh, Lightning, SevereLightning, WindModerate, WindHigh,
   * WindExtreme, FloodWarning, FlashFloodWarning, TornadoWarning, TsunamiWarning,
   * SevereThunderstormWarning.
   */
  hazardCode?: string;

  /**
   * A displayable short phrase describing the forecasted conditions and
   * precipitation intensity/type.
   */
  shortPhrase?: string;
}

/**
 * This object is returned from a successful Get Severe Weather Alerts call.
 */
model SevereWeatherAlertsResult {
  /**
   * A list of all severe weather alerts for the queried location.
   */
  @visibility(Lifecycle.Read)
  results?: SevereWeatherAlert[];
}

/**
 * Information about a severe weather alert.
 */
model SevereWeatherAlert {
  /**
   * 2-character ISO 3166-1 Alpha-2 country code, for example, "US".
   */
  countryCode?: string;

  /**
   * A unique numerical identifier for a weather alert.
   */
  alertId?: int32;

  /**
   * Description of the alert.
   */
  description?: SevereWeatherAlertDescription;

  /**
   * Category of the alert.
   */
  category?: string;

  /**
   * Number signifying the importance or ranking order of the given alert within the
   * country/region it has originated. A lower number signifies a higher priority.
   * For example, 1 is the highest priority. The number varies by country/region and
   * can change over time as each country/region evolves their alert systems.
   */
  priority?: int32;

  /**
   * Classification of the alert. This field is not available for all countries and
   * therefore not always returned.
   */
  class?: string;

  /**
   * Severity level of the alert. This field is not available for all countries and
   * therefore not always returned.
   */
  level?: string;

  /**
   * The provider of the alert information. By default the source is returned in
   * English (en-US). The alerts are from official Government Meteorological
   * Agencies and leading global weather alert providers.
   */
  source?: string;

  /**
   * A numerical identifier associated with the source provider name of the alert
   * data.
   */
  sourceId?: int32;

  /**
   * A disclaimer regarding the source of the alert information. This field is not
   * always available. For example, disclaimer may include details about the delays
   * or potential issues related to the alarm.
   */
  disclaimer?: string;

  /**
   * Information about the alert specific to the affected area(s).
   */
  alertAreas?: AlertDetails[];
}

/**
 * Description of a severe weather alert.
 */
model SevereWeatherAlertDescription {
  /**
   * Description of the alert in the specified language. By default English (en-US)
   * is returned if the language parameter is not specified in the request.
   */
  localized?: string;

  /**
   * Description of the alert in English (en-US).
   */
  english?: string;
}

/**
 * Information about a severe weather alert issued within an affected area(s). If
 * multiple alerts are active for the same location, the alerts will be returned
 * in order of `priority` within the API response, with the highest priority alert
 * being returned at the top of the response.
 */
model AlertDetails {
  /**
   * The name of an area which is affected by the alert. The location that was
   * requested falls under the alert area.
   */
  name?: string;

  /**
   * Text summarizing the alert in the returned area.
   */
  summary?: string;

  /**
   * The start date and time of the alert in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, for
   * example, 2019-10-27T19:39:57-08:00. If the alert crosses multiple time zones
   * the returned time in the response is the local time to the requested coordinate
   * location.
   */
  startTime?: utcDateTime;

  /**
   * The date and time at which the alert ended or will end in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_format (yyyy-mm-ddThh:mm:ss-hh:mm). For
   * example, *2025-04-29T07:00:00-07:00*. If the alert spans multiple time zones,
   * the response will provide the local time corresponding to the requested
   * coordinates.
   */
  endTime?: utcDateTime;

  /**
   * The latest status of the alert in the current area.
   */
  latestStatus?: LatestStatus;

  /**
   * Full details associated with the alert. Returned if `details=True`. This field
   * is always returned in the language(s) of choice by the issuing provider and
   * Azure Maps only returns what is created by the provider. Please note, some
   * countries/regions may offer their native language and English. Language
   * parameter won't apply to this field.
   */
  alertDetails?: string;

  /**
   * Language of the `alertDetails`. This field  helps to point out that the
   * language of the `alertDetails` may differ from the requested language
   * parameter. Returned if `details=True`. Language code has been derived from the
   * ISO 639-1 Alpha-2 codes.
   */
  alertDetailsLanguageCode?: string;
}

/**
 * The latest status on the alert in the current area.
 */
model LatestStatus {
  /**
   * The latest status keyword for the alert, in the specified language. By default,
   * returned in English (en-US).
   */
  localized?: string;

  /**
   * Latest status keyword for the alert, in English (en-US).
   */
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
 * The DailyIndex object helps users plan outdoor activities based on weather
 * conditions by providing the activity name, such as 'Ski Weather Forecast'; a
 * numerical rating from 0.0 to 10.0 indicating suitability; a text rating, such
 * as 'Poor'; and a brief description of the conditions, such as 'Expect poor
 * conditions for skiing.'
 */
model DailyIndex {
  /**
   * The name of the index, indicating the type of activity or condition it relates
   * to, such as running, golfing, or other outdoor activities. For more
   * information, see [Index
   * IDs](/azure/azure-maps/weather-services-concepts#index-ids-and-index-groups-ids)
   * in the *Weather service in Azure Maps* concepts article.
   */
  indexName?: string;

  /**
   * A numeric identifier that uniquely represents a specific index type,
   * distinguishing between different indices for various outdoor activities. For
   * example, an 'indexId' of 1 corresponds to the 'Running' index, and an 'indexId'
   * of 5 corresponds to the 'Golfing' index. For more information, see [Index
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
   * A numerical index value ranging from 0.0 to 10.0 that quantifies the
   * suitability of weather conditions for a specific activity or condition, such as
   * running or golfing. Higher values typically indicate more favorable conditions,
   * depending on the value of the `ascending` property. For example, a value of 8
   * for the 'Running' index suggests very good weather for running, while a value
   * of 6 for the 'Golfing' index indicates good but slightly less ideal conditions.
   * For more information, see [Daily index range
   * sets](/azure/azure-maps/daily-index-range-sets) in the *Weather service in
   * Azure Maps* concepts article.
   */
  value?: float32;

  /**
   * Provides a qualitative assessment of the index, describing the `categoryValue`
   * property. Categories vary among indices and may include values such as
   * Excellent, Very Good, Good, Fair, and Poor.
   */
  category?: string;

  /**
   * Provides a numeric representation of the category property, indicating the
   * qualitative assessment of the index. Values range from 1 to 5 and should be
   * used with the ascending flag, as they can differ among indices. For example,
   * for Mosquito Activity: Low=1, Moderate=2, High=3, Very High=4, Extreme=5.
   */
  categoryValue?: int32;

  /**
   * Indicates the direction of the `value` and `categoryValue` properties. When
   * true, the poorest index value is 0 and the best index value is 10. When false,
   * the poorest index value is 10 and the best index value is 0.
   */
  ascending?: boolean;

  /**
   * Provides a brief, user-friendly explanation of the index value, helping users
   * understand its significance in relation to specific weather conditions or
   * activities. For example, if the index value for Outdoor Barbecue is
   * 'Excellent', the description will be 'This is a great day for an outdoor
   * barbecue!'
   */
  description?: string;
}

/**
 * The ActiveStormResult object provides comprehensive information about ongoing
 * tropical storms. It includes an array of [ActiveStorm](#ActiveStorm) objects,
 * each detailing specific attributes of individual storms. These attributes
 * encompass the storm's government ID, basin ID, year of origin, name, and
 * subtropical status.
 */
model ActiveStormResult {
  /**
   * An array of [ActiveStorm](#ActiveStorm) objects, each providing essential
   * details about an ongoing tropical storm, as reported by national weather
   * forecasting agencies.
   */
  results?: ActiveStorm[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated. This is useful when the response is too large to be returned in a
   * single call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * Provides essential details about ongoing tropical storms, as reported by
 * national weather forecasting agencies.
 */
model ActiveStorm {
  /**
   * Specifies the year in which the tropical storm originated.
   */
  year?: string;

  /**
   * Categorizes the different ocean basins where tropical storms can originate.
   * Each basin is assigned a unique identifier to help specify the location of the
   * storm's origin. Valid Basin identifiers include AL, CP, EP, NI, NP, SI, and SP.
   */
  basinId?: BasinId;

  /**
   * The name of the storm.
   */
  name?: string;

  /**
   * Indicates whether the tropical storm is currently active. If true, the storm is
   * active; if false, the storm is not active.
   */
  isActive?: boolean;

  /**
   * A return value of true indicates that the storm is classified as a subtropical
   * cyclone, meaning it has both tropical and extratropical features.
   */
  isSubtropical?: boolean;

  /**
   * A unique identifier assigned to tropical storms by national weather forecasting
   * agencies. This identifier helps track and reference specific storms accurately,
   * including its status, location, and intensity.
   */
  govId?: int32;
}

/**
 * Contains a list of government-issued storms that meet the specified search
 * criteria, including details such as the storm's basin ID, government-issued ID
 * and status.
 */
model StormSearchResult {
  /**
   * Array of [StormSearchResultItem](#stormsearchresultitem) objects, each
   * representing a tropical storm matching the search criteria provided in the
   * request.
   */
  results?: StormSearchResultItem[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated. This is useful when the response is too large to be returned in a
   * single call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * A government-issued storm event, including the storm's basin identifier
 * (basinId), government-issued identifier (govId) and status. This object is
 * returned as part of an array within the [StormSearchResult](#stormsearchresult)
 * object.
 */
model StormSearchResultItem {
  /**
   * Specifies the year in which the tropical storm originated.
   */
  year?: string;

  /**
   * Categorizes the different ocean basins where tropical storms can originate.
   * Each basin is assigned a unique identifier to help specify the location of the
   * storm's origin. Valid Basin identifiers include AL, CP, EP, NI, NP, SI, and SP.
   */
  basinId?: BasinId;

  /**
   * Identifies the tropical storm by its official name, as designated by the
   * relevant national weather forecasting agency.
   */
  name?: string;

  /**
   * Indicates whether the tropical storm is currently active. If true, the storm is
   * active; if false, the storm is not active
   */
  isActive?: boolean;

  /**
   * Returns true if the storm has been permanently retired in the source basin.
   */
  isRetired?: boolean;

  /**
   * Returns true if the storm is classified as a subtropical cyclone, meaning it
   * has both tropical and extratropical features.
   */
  isSubtropical?: boolean;

  /**
   * A unique identifier assigned to tropical storms by national weather forecasting
   * agencies. This identifier helps track and reference specific storms accurately,
   * including its status, location, and intensity. This will match the depression
   * number.
   */
  govId?: int32;
}

/**
 * An array of [StormForecast](#stormforecast) objects, each detailing individual
 * storm forecasts issued by government authorities.
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
   * paginated. This is useful when the response is too large to be returned in a
   * single call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * The StormForecast object contains detailed Government-issued information about
 * forecasted tropical storms, including the storm's location, status, forecast
 * creation date, wind speed, and wind radii.
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
   * Specifies the geographical coordinates (latitude and longitude) of the storm's
   * forecasted position.
   */
  location?: LatLongPair;

  /**
   * Specifies the expected maximum wind gust speed and direction expected during
   * the storm, measured in kilometers per hour (km/h) or miles per hour (mph),
   * based on the specified unit. Wind direction is given in azimuth degrees,
   * ranging from 0° (true North) to 359°, moving clockwise. May be NULL.
   */
  maxWindGust?: WeatherValue;

  /**
   * Specifies the maximum sustained wind speed expected during the storm, measured
   * in  kilometers per hour (km/h) or miles per hour (mph), based on the unit
   * specified in the request. May be NULL.
   */
  sustainedWind?: WeatherValue;

  /**
   * Indicates the current state or condition of the storm. This property provides
   * information on whether the storm is active, dissipating, or has reached another
   * significant status. Possible values:<ul><li>Cyclonic storm</li><li>Deep
   * depression</li><li>Depression</li><li>Extremely severe cyclonic
   * storm</li><li>Hurricane category (1-5)</li><li>Intense tropical
   * cyclone</li><li>Moderate tropical storm</li><li>Post-tropical
   * cyclone</li><li>Potential tropical cyclone</li><li>Severe cyclonic
   * storm</li><li>Severe tropical storm</li><li>Subtropical</li><li>Super cyclonic
   * storm</li><li>Tropical cyclone</li><li>Tropical cyclone category
   * (1-5)</li><li>Tropical depression</li><li>Tropical disturbance</li><li>Tropical
   * storm</li><li>Typhoon</li><li>Very intense tropical cyclone</li><li>Very severe
   * cyclonic storm</li><li>Very strong typhoon</li><li>Violent typhoon</li></ul>
   */
  status?: string;

  /**
   * Provides forecast details for the storm within the specified time frame. If the
   * `windowGeometry` parameter is set to true in the API request, this property
   * will include GeoJSON details for the window geometry.
   */
  window?: WeatherWindow;

  /**
   * Contains an array of [StormWindRadiiSummary](#stormwindradiisummary) objects,
   * detailing wind radii in different quadrants around the storm's center.
   * Displayed when `details=true` or `radiiGeometry=true` in the request.
   */
  windRadiiSummary?: StormWindRadiiSummary[];
}

/**
 * A location represented as a latitude and longitude.
 */
model LatLongPair {
  /**
   * Latitude property
   */
  latitude?: float64;

  /**
   * Longitude property
   */
  longitude?: float64;
}

/**
 * Forecast window for the storm
 */
model WeatherWindow {
  /**
   * Location of the point on the left side of the window at the time of the
   * timeframe.
   */
  left?: LatLongPair;

  /**
   * Location of the point on the right side of the window at the end of the
   * timeframe.
   */
  right?: LatLongPair;

  /**
   * DateTime of the beginning of the window of movement, displayed in ISO8601
   * format.
   */
  beginDateTime?: utcDateTime;

  /**
   * DateTime of the end of the window of movement, displayed in ISO8601 format.
   */
  endDateTime?: utcDateTime;

  /**
   * Storm status at the beginning of the window.
   */
  beginStatus?: string;

  /**
   * Storm status at the end of the window.
   */
  endStatus?: string;

  /**
   * Displayed when windowGeometry=true in request. GeoJSON object containing
   * coordinates describing the window of movement during the specified timeframe.
   */
  geometry?: GeoJsonGeometry;
}

/**
 * The StormWindRadiiSummary object provides a high-level overview of the wind
 * distribution around a tropical storm. It includes the geometric representation
 * of wind radii (radiiGeometry), detailed sector-based wind data
 * (radiusSectorData), and the wind speeds at various distances from the storm's
 * center (windSpeed). These properties collectively help in understanding the
 * spatial extent and intensity of winds associated with the storm. Displayed when
 * the request includes `details=true` or `radiiGeometry=true`.
 */
model StormWindRadiiSummary {
  /**
   * Date and time that the wind radii summary data is valid, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: string;

  /**
   * The overall wind speed associated with the storm's wind radii data. This single
   * wind speed value applies collectively to all the sectors within the
   * [radiusSectorData](#radiusSectorData) array, which provides detailed
   * geographical information for the NE, SE, SW, and NW quadrants of the storm's
   * wind radii.
   */
  windSpeed?: WeatherValue;

  /**
   * An array of [RadiusSector](#RadiusSector) objects. Each object contains
   * detailed geographical information (in geoJSON format) needed to plot wind
   * radius quadrants: 0-90° for NE, 90-180° for SE, 180-270° for SW, and 270-360°
   * for NW.
   */
  radiusSectorData?: RadiusSector[];

  /**
   * A GeoJSON object that is returned when the `radiiGeometry` parameter is set to
   * true in the request. It provides detailed geographical information about the
   * storm's wind radii, including the spatial representation of areas affected by
   * different wind speeds.
   */
  radiiGeometry?: GeoJsonGeometry;
}

/**
 * Bearing 0-90 = NE quadrant; 90-180 = SE quadrant; 180-270 = SW quadrant;
 * 270-360 = NW quadrant.
 */
model RadiusSector {
  /**
   * Bearing, in degrees, of the beginning of the quadrant.
   */
  beginBearing?: float64;

  /**
   * Bearing, in degrees, of the end of the quadrant.
   */
  endBearing?: float64;

  /**
   * The radius of the quadrant, in nautical miles.
   */
  range?: float64;
}

/**
 * Contains an array of [StormLocation](#stormlocation) objects, representing
 * government-issued active storm events. Includes details such as latitude and
 * longitude coordinates, wind speed and direction, wind radii, basin identifier,
 * minimum pressure, movement, status, and other relevant attributes.
 */
model StormLocationsResult {
  /**
   * Array of data points, each detailing the location of an individual
   * government-issued storm, including coordinates, geometry, basin ID, date, wind
   * details, and wind radii.
   */
  results?: StormLocation[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated. This is useful when the response is too large to be returned in a
   * single call, allowing users to navigate through multiple pages of results.
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
   * Date and time that the forecast is valid, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: string;

  /**
   * Specifies the latitude and longitude coordinates of the storm's center.
   */
  location?: LatLongPair;

  /**
   * Specifies the expected maximum wind gust speed and direction expected during
   * the storm, measured in kilometers per hour (km/h) or miles per hour (mph),
   * based on the specified unit. Wind direction is given in azimuth degrees,
   * ranging from 0° (true North) to 359°, moving clockwise. May be NULL.
   */
  maxWindGust?: WeatherValue;

  /**
   * Maximum sustained wind speed associated with the storm, measured in kilometers
   * per hour (km/h) or miles per hour (mph), based on the specified unit. May be
   * NULL.
   */
  sustainedWind?: WeatherValue;

  /**
   * Specifies the lowest atmospheric pressure associated with the storm, measured
   * in millibars (mb) or  inches of mercury (inHg), depending on the unit specified
   * in the request. This value may be NULL.
   */
  minimumPressure?: WeatherValue;

  /**
   * Returns the storm's current direction (in degrees) and speed, measured in
   * kilometers per hour (km/h) or miles per hour (mph), depending on the specified
   * unit.
   */
  movement?: WindDetails;

  /**
   * Returns the current classification or stage of the storm in English, such as a
   * tropical depression, tropical storm, or hurricane.
   */
  status?: string;

  /**
   * A return value of true indicates that the storm is classified as a subtropical
   * cyclone, meaning it has both tropical and extratropical features.
   */
  isSubtropical?: boolean;

  /**
   * True when storm may develop into a Tropical System.
   */
  hasTropicalPotential?: boolean;

  /**
   * Returns true if the storm has transitioned from a tropical cyclone to a
   * post-tropical cyclone, aiding in understanding the storm's lifecycle phase.
   */
  isPostTropical?: boolean;

  /**
   * Contains an array of [StormWindRadiiSummary](#stormwindradiisummary) objects,
   * detailing wind radii in different quadrants around the storm's center.
   * Displayed when `details=true` or `radiiGeometry=true` in the request.
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
   * properties such as the air quality index (AQI), dominant pollutant, pollutant
   * levels, risk level, and suggested precautions.
   */
  results?: AirQuality[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated. This is useful when the response is too large to be returned in a
   * single call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * The AirQuality object provides comprehensive information about the current air
 * quality at the specified location. This includes the concentration levels of
 * various pollutants, numerical Air Quality Index (AQI) values indicating the
 * overall air quality, and identification of the dominant pollutant affecting the
 * air quality. Additionally, it offers a risk level summary, which briefly
 * outlines potential health risks and suggests precautions.
 */
model AirQuality {
  /**
   * Date and time of the current observation, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: utcDateTime;

  /**
   * The air quality index (AQI) is an air quality rating scale set by local
   * regulating bodies. Scales can vary widely based on location. For more
   * information, see [Air quality
   * index](https://en.wikipedia.org/wiki/Air_quality_index) in Wikipedia.
   */
  index?: float32;

  /**
   * Represents a normalized global air quality index aligned with international
   * scientific standards, including World Health Organization (WHO) guidelines and
   * U.S. EPA AQI definitions.
   *
   * The value reflects overall air quality based on measured pollutant
   * concentrations, where the pollutant posing the greatest potential health impact
   * determines the final index value.
   *
   * The returned value uses an AQI-style range from 0 to 250+ and maps to defined
   * air quality categories.
   *
   * The dominant pollutant is the pollutant with the highest individual index
   * value.
   *
   * For example, if pollutant index values are:
   * <ul><li><b>VOCs</b>: 10</li><li><b>PM2.5</b>: 25</li><li><b>PM10</b>:
   * 30</li><li><b>NO&#8322;</b>: 50</li></ul>
   *
   * The resulting <B>globalIndex</B> value is <B>50</B>, and the dominant pollutant
   * is <b>NO&#8322;</b>.
   *
   * Air quality categories associated with the index value are:
   * <ul><li><b>0-20</b>: Excellent</li><li><b>21-50</b>:
   * Fair</li><li><b>51-100</b>: Poor</li><li><b>101-150</b>:
   * Unhealthy</li><li><b>151-250</b>: Very unhealthy</li><li><b>251+</b>:
   * Dangerous</li></ul>
   */
  globalIndex?: float32;

  /**
   * Identifies the pollutant with the highest concentration.
   */
  dominantPollutant?: DominantPollutant;

  /**
   * Provides a one-word description of the air quality for the forecast period in
   * the specified language, such as Poor, Fair, or Excellent.
   */
  category?: string;

  /**
   * Provides a unique hexadecimal color code corresponding to the air quality
   * category for each day in the forecast period. This color helps users quickly
   * identify the air quality level visually, with each color corresponding to a
   * category such as Poor, Fair, or Excellent.
   */
  categoryColor?: string;

  /**
   * A textual explanation of this air quality result in the requested language.
   */
  description?: string;

  /**
   * An array containing detailed information about each pollutant in the response.
   * Returned when the `pollutants` URI Parameter is *true*.
   */
  pollutants?: Pollutant[];
}

/**
 * Detailed information about an individual pollutant. Not returned if
 * `pollutants`=false.
 */
model Pollutant {
  /**
   * Type of pollutant. Please note that more may be added at any time.
   */
  type?: PollutantType;

  /**
   * The name of the pollutant in English.
   */
  name?: string;

  /**
   * Air quality rating on a scale set by local regulating bodies. Scales can vary
   * widely based on location. See
   * [Wikipedia](https://en.wikipedia.org/wiki/Air_quality_index) for more
   * information.
   */
  index?: float32;

  /**
   * Represents a normalized global air quality index aligned with international
   * scientific standards, including World Health Organization (WHO) guidelines and
   * U.S. EPA AQI definitions.
   *
   * The value reflects overall air quality based on measured pollutant
   * concentrations, where the pollutant posing the greatest potential health impact
   * determines the final index value.
   *
   * The returned value uses an AQI-style range from 0 to 250+ and maps to defined
   * air quality categories.
   *
   * The dominant pollutant is the pollutant with the highest individual index
   * value.
   *
   * For example, if pollutant index values are:
   * <ul><li><b>VOCs</b>: 10</li><li><b>PM2.5</b>: 25</li><li><b>PM10</b>:
   * 30</li><li><b>NO&#8322;</b>: 50</li></ul>
   *
   * The resulting <B>globalIndex</B> value is <B>50</B>, and the dominant pollutant
   * is <b>NO&#8322;</b>.
   *
   * Air quality categories associated with the index value are:
   * <ul><li><b>0-20</b>: Excellent</li><li><b>21-50</b>:
   * Fair</li><li><b>51-100</b>: Poor</li><li><b>101-150</b>:
   * Unhealthy</li><li><b>151-250</b>: Very unhealthy</li><li><b>251+</b>:
   * Dangerous</li></ul>
   */
  globalIndex?: float32;

  /**
   * An object containing the number of pollutant particles per volume of air.
   */
  concentration?: WeatherValue;
}

/**
 * Returns an array of [DailyAirQuality](#dailyairquality) objects, each detailing
 * the forecasted air quality for a specific day. The number of days included is
 * determined by the `duration` URI parameter (1-7 days, default is 1).
 */
model DailyAirQualityForecastResult {
  /**
   * Detailed air quality forecast data for each day within the requested duration,
   * including properties such as date, air quality index (AQI), dominant pollutant,
   * pollutant levels, risk level, and suggested precautions.
   */
  results?: DailyAirQuality[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated. This is useful when the response is too large to be returned in a
   * single call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * Provides a summary of the forecasted air quality conditions for a specific day
 * and location, in the requested language. This includes key metrics such as the
 * air quality index (AQI), the dominant pollutant expected for that day, and a
 * brief description of the overall air quality. The information helps users
 * understand what to expect regarding air quality and any potential health
 * implications for the forecasted day.
 */
model DailyAirQuality {
  /**
   * Date and time of the current observation, displayed in [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  dateTime?: utcDateTime;

  /**
   * The air quality index (AQI) is a rating scale set by local regulating bodies,
   * which can vary widely by location. For more information, see [Air quality
   * index](https://en.wikipedia.org/wiki/Air_quality_index) in Wikipedia.
   */
  index?: float32;

  /**
   * Represents a normalized global air quality index aligned with international
   * scientific standards, including World Health Organization (WHO) guidelines and
   * U.S. EPA AQI definitions.
   *
   * The value reflects overall air quality based on measured pollutant
   * concentrations, where the pollutant posing the greatest potential health impact
   * determines the final index value.
   *
   * The returned value uses an AQI-style range from 0 to 250+ and maps to defined
   * air quality categories.
   *
   * The dominant pollutant is the pollutant with the highest individual index
   * value.
   *
   * For example, if pollutant index values are:
   * <ul><li><b>VOCs</b>: 10</li><li><b>PM2.5</b>: 25</li><li><b>PM10</b>:
   * 30</li><li><b>NO&#8322;</b>: 50</li></ul>
   *
   * The resulting <B>globalIndex</B> value is <B>50</B>, and the dominant pollutant
   * is <b>NO&#8322;</b>.
   *
   * Air quality categories associated with the index value are:
   * <ul><li><b>0-20</b>: Excellent</li><li><b>21-50</b>:
   * Fair</li><li><b>51-100</b>: Poor</li><li><b>101-150</b>:
   * Unhealthy</li><li><b>151-250</b>: Very unhealthy</li><li><b>251+</b>:
   * Dangerous</li></ul>
   */
  globalIndex?: float32;

  /**
   * The pollutant with the highest concentration.
   */
  dominantPollutant?: DominantPollutant;

  /**
   * Provides a one-word summary of the air quality for the forecast period in the
   * specified language, such as Poor, Fair, or Excellent. This summary helps users
   * quickly understand the overall air quality conditions.
   */
  category?: string;

  /**
   * Provides a unique hexadecimal color code for each air quality category in the
   * daily forecast, visually representing levels such as Poor, Fair, or Excellent.
   */
  categoryColor?: string;

  /**
   * Provides a summary of the forecasted air quality conditions for a specific day
   * and location, in the requested language.
   */
  description?: string;
}

/**
 * Returns an array of [DailyHistoricalActuals](#dailyhistoricalactuals) objects,
 * each detailing the observed historical weather data for the specified date and
 * location. The number of days included is determined by the `startDate` and
 * `endDate` URI parameters which can include up to 31 days.
 */
model DailyHistoricalActualsResult {
  /**
   * Aggregates detailed historical weather data for specific dates and locations,
   * including temperature, precipitation, snowfall, snow depth, and degree day
   * summaries.
   */
  results?: DailyHistoricalActuals[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated. This is useful when the response is too large to be returned in a
   * single call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * Provides climatology data for a specific day, including observed temperatures,
 * precipitation, snowfall, snow depth, and heating/cooling degree days.
 */
model DailyHistoricalActuals {
  /**
   * The date and time for the requested weather data in ISO 8061 format displayed
   * in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  date?: utcDateTime;

  /**
   * Provides the observed maximum, minimum, and average temperatures for a specific
   * day at a given location.
   */
  temperature?: WeatherValueMaxMinAvg;

  /**
   * Provides a summary of heating and cooling degree days. Heating Degree Days
   * (HDD) measure the demand for energy to heat a building, calculated based on the
   * degrees a day's average temperature is below 65°F/18°C. Cooling Degree Days
   * (CDD) measure the demand for energy to cool a building, calculated based on the
   * degrees a day's average temperature is above 65°F/18°C. This summary aids in
   * energy management and planning.
   */
  degreeDaySummary?: DegreeDaySummary;

  /**
   * The amount of precipitation accumulated over the specified day, measured in
   * millimeters (mm) or inches (in), depending on the unit specified in the
   * request.
   */
  precipitation?: WeatherValue;

  /**
   * Provides the amount of snow that has fallen over the specified day, measured in
   * centimeters (cm) or inches (in), based on the specified unit in the request.
   */
  snowfall?: WeatherValue;

  /**
   * Provides the average accumulated snow depth, measured in centimeters (cm) or
   * inches (in), based on the specified unit in the request.
   */
  snowDepth?: WeatherValue;
}

/**
 * Returned temperature values.
 */
model WeatherValueMaxMinAvg {
  /**
   * Maximum temperature for the time period.
   */
  maximum?: WeatherValue;

  /**
   * Minimum temperature for the time period.
   */
  minimum?: WeatherValue;

  /**
   * Average temperature for the time period.
   */
  average?: WeatherValue;
}

/**
 * Provides an array of historical Daily Historical Records for specified dates
 * and locations, each with aggregate detailed climatology data for the requested
 * day, such as record temperatures, precipitation, and snowfall.
 */
model DailyHistoricalRecordsResult {
  /**
   * Aggregates detailed climatology data for each requested day, including record
   * temperatures, precipitation, snowfall, snow depth, and degree day summaries.
   */
  results?: DailyHistoricalRecords[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated. This is useful when the response is too large to be returned in a
   * single call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/** Daily historical weather records. */
model DailyHistoricalRecords {
  /**
   * Date and time of the current observation, displayed in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  date?: utcDateTime;

  /**
   * Returns the year in which both the minimum and the maximum temperatures
   * occurred on a specified day, along with the recorded amounts. Also returns the
   * average temperature for the given date. Measured in degrees Celsius (C) or
   * Fahrenheit (F), depending on the unit specified in the request.
   */
  temperature?: WeatherValueYearMaxMinAvg;

  /**
   * The amount of precipitation accumulated over the specified day, measured in
   * millimeters (mm) or inches (in), based on the specified unit in the request.
   */
  precipitation?: WeatherValueYearMax;

  /**
   * Returns the year in which the record high snowfall occurred on a specified
   * date, along with the recorded amounts, measured in centimeters (cm) or inches
   * (in), based on the unit specified in the request.
   */
  snowfall?: WeatherValueYearMax;
}

/**
 * Returned temperature values.
 */
model WeatherValueYearMaxMinAvg {
  /**
   * Maximum temperature for the time period.
   */
  maximum?: WeatherValueYear;

  /**
   * Minimum temperature for the time period.
   */
  minimum?: WeatherValueYear;

  /**
   * Average temperature for the time period.
   */
  average?: WeatherValue;
}

/** Weather value with associated year of occurrence. */
model WeatherValueYear {
  /**
   * Rounded value.
   */
  value?: float32;

  /**
   * Type of unit for the returned value.
   */
  unit?: string;

  /**
   * Numeric ID value associated with the type of unit being displayed. Can be used
   * for unit translation. Please refer to [Weather services in Azure
   * Maps](/azure/azure-maps/weather-services-concepts#daily-index-range-sets) for
   * details.
   */
  unitType?: int32;

  /**
   * Year the value occurred.
   */
  year?: int32;
}

/**
 * Returned temperature values.
 */
model WeatherValueYearMax {
  /**
   * Maximum temperature for the time period.
   */
  maximum?: WeatherValueYear;
}

/**
 * Returns an array of [DailyHistoricalNormals](#dailyhistoricalnormals) objects,
 * each detailing climatology data such as past daily normal temperatures,
 * precipitation, and cooling/heating degree day information for the specified
 * date range, calculated as a 30-year average (1991-2020). The number of days
 * included is determined by the `startDate` and `endDate` URI parameters, which
 * can include up to 31 days.
 */
model DailyHistoricalNormalsResult {
  /**
   * Aggregates detailed climatology data for each requested day, including normal
   * temperatures, precipitation, snowfall, snow depth, and degree day summaries.
   */
  results?: DailyHistoricalNormals[];

  /**
   * Contains the URL to fetch the next page of results if the response is
   * paginated. This is useful when the response is too large to be returned in a
   * single call, allowing users to navigate through multiple pages of results.
   */
  nextLink?: string;
}

/** Daily historical normal weather data. */
model DailyHistoricalNormals {
  /**
   * Date and time of the current observation, displayed in [ISO
   * 8601](https://en.wikipedia.org/wiki/ISO_8601) format
   * (yyyy-mm-ddThh:mm:ss-hh:mm). For example, *2025-04-29T07:00:00-07:00*.
   */
  date?: utcDateTime;

  /**
   * Provides the normal high, low, and average temperatures for a specific day at a
   * given location, calculated as a 30-year average (1991-2020).
   */
  temperature?: WeatherValueMaxMinAvg;

  /**
   * Provides a summary of heating and cooling degree days. Heating Degree Days
   * (HDD) measure the demand for energy to heat a building, calculated based on the
   * degrees a day's average temperature is below 65°F/18°C. Cooling Degree Days
   * (CDD) measure the demand for energy to cool a building, calculated based on the
   * degrees a day's average temperature is above 65°F/18°C. This summary aids in
   * energy management and planning.
   */
  degreeDaySummary?: DegreeDaySummary;

  /**
   * Provides the amount of precipitation accumulated over the specified day,
   * measured in millimeters (mm) or inches (in), based on the specified unit in the
   * request.
   */
  precipitation?: WeatherValue;
}
