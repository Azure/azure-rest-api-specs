import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsWeather;

namespace Customizations;

@@clientName(HourlyForecast.date, "timestamp", "!autorest");
@@clientName(HourlyForecast.ceiling, "cloudCeiling", "!autorest");
@@clientName(HourlyForecast.uvIndexPhrase, "uvIndexDescription", "!autorest");

@@clientName(WeatherValue.unit, "unitLabel", "!autorest");

@@clientName(WindDirection.localizedDescription, "description", "!autorest");

@@clientName(
  MinuteForecastSummary.shortPhrase,
  "shortDescription",
  "!autorest"
);
@@clientName(
  MinuteForecastSummary.briefPhrase,
  "briefDescription",
  "!autorest"
);

@@clientName(IntervalSummary.shortPhrase, "shortDescription", "!autorest");
@@clientName(IntervalSummary.briefPhrase, "briefDescription", "!autorest");

@@clientName(ForecastInterval.dbz, "decibelRelativeToZ", "!autorest");
@@clientName(ForecastInterval.shortPhrase, "shortDescription", "!autorest");

@@clientName(QuarterDayForecast.date, "dateTime", "!autorest");

@@clientName(CurrentConditions.phrase, "description", "!autorest");
@@clientName(CurrentConditions.isDayTime, "isDaytime", "!autorest");
@@clientName(
  CurrentConditions.uvIndexPhrase,
  "uvIndexDescription",
  "!autorest"
);
@@clientName(CurrentConditions.ceiling, "cloudCeiling", "!autorest");

@@clientName(PressureTendency.localizedDescription, "description", "!autorest");

@@clientName(DailyForecast.date, "dateTime", "!autorest");
@@clientName(
  DailyForecast.degreeDaySummary,
  "meanTemperatureDeviation",
  "!autorest"
);
@@clientName(DailyForecast.airAndPollen, "airQuality", "!autorest");
@@clientName(DailyForecast.day, "daytimeForecast", "!autorest");
@@clientName(DailyForecast.night, "nighttimeForecast", "!autorest");

@@clientName(AirAndPollen.name, "description", "!autorest");
@@clientName(AirAndPollen.type, "airQualityType", "!autorest");

@@clientName(DailyForecastDetail.shortPhrase, "shortDescription", "!autorest");

@@clientName(WeatherHazards.hazardDetails, "details", "!autorest");

@@clientName(HazardDetail.shortPhrase, "shortDescription", "!autorest");

@@clientName(WaypointForecast.shortPhrase, "shortDescription", "!autorest");
@@clientName(WaypointForecast.isDayTime, "isDaytime", "!autorest");

@@clientName(WeatherNotification.shortPhrase, "shortDescription", "!autorest");

@@clientName(SevereWeatherAlert.class, "classification", "!autorest");
@@clientName(SevereWeatherAlert.alertAreas, "alertDetails", "!autorest");

@@clientName(
  SevereWeatherAlertDescription.localized,
  "description",
  "!autorest"
);
@@clientName(SevereWeatherAlertDescription.english, "status", "!autorest");

@@clientName(AlertArea, "AlertDetails", "!autorest");
@@clientName(AlertArea.summary, "description", "!autorest");
@@clientName(AlertArea.alertDetails, "details", "!autorest");
@@clientName(AlertArea.alertDetailsLanguageCode, "language", "!autorest");

@@clientName(DailyIndex.category, "categoryDescription", "!autorest");
@@clientName(DailyIndex.ascending, "isAscending", "!autorest");

@@clientName(ActiveStormResult.results, "activeStorms", "!autorest");

@@clientName(StormSearchResult.results, "storms", "!autorest");

@@clientName(StormForecastResult.results, "stormForecasts", "!autorest");

@@clientName(StormForecast.dateTime, "timestamp", "!autorest");
@@clientName(
  StormForecast.initializedDateTime,
  "initializedTimestamp",
  "!autorest"
);
@@clientName(StormForecast.location, "coordinates", "!autorest");
@@clientName(StormForecast.window, "weatherWindow", "!autorest");

@@clientName(WeatherWindow.left, "topLeft", "!autorest");
@@clientName(WeatherWindow.right, "bottomRight", "!autorest");
@@clientName(WeatherWindow.beginDateTime, "beginTimestamp", "!autorest");
@@clientName(WeatherWindow.endDateTime, "endTimestamp", "!autorest");

@@clientName(StormWindRadiiSummary.dateTime, "timestamp", "!autorest");

@@clientName(RadiusSector.range, "radius", "!autorest");

@@clientName(StormLocationsResult.results, "stormLocations", "!autorest");

@@clientName(StormLocation.dateTime, "timestamp", "!autorest");
@@clientName(StormLocation.location, "coordinates", "!autorest");

@@clientName(AirQualityResult.results, "airQualityResults", "!autorest");

@@clientName(AirQuality.dateTime, "timestamp", "!autorest");

@@clientName(
  DailyAirQualityForecastResult.results,
  "airQualityResults",
  "!autorest"
);

@@clientName(DailyAirQuality.dateTime, "timestamp", "!autorest");

@@clientName(
  DailyHistoricalActualsResult.results,
  "historicalActuals",
  "!autorest"
);

@@clientName(DailyHistoricalActuals.date, "timestamp", "!autorest");

@@clientName(
  DailyHistoricalRecordsResult.results,
  "historicalRecords",
  "!autorest"
);

@@clientName(DailyHistoricalRecords.date, "timestamp", "!autorest");

@@clientName(
  DailyHistoricalNormalsResult.results,
  "historicalNormals",
  "!autorest"
);

@@clientName(DailyHistoricalNormals.date, "timestamp", "!autorest");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Legacy.clientDefaultValue(
  ResponseFormatParameters.format,
  "json",
  "!autorest"
);

// Flatten operations onto client instead of having an operation group attribute
@client({
  name: "MapsWeatherClient",
  service: MapsWeather,
})
interface MapsWeatherClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getHourlyForecast is Weather.getHourlyForecast;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getMinuteForecast is Weather.getMinuteForecast;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getQuarterDayForecast is Weather.getQuarterDayForecast;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getCurrentConditions is Weather.getCurrentConditions;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDailyForecast is Weather.getDailyForecast;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getWeatherAlongRoute is Weather.getWeatherAlongRoute;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSevereWeatherAlerts is Weather.getSevereWeatherAlerts;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDailyIndices is Weather.getDailyIndices;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTropicalStormActive is Weather.getTropicalStormActive;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTropicalStormSearch is Weather.getTropicalStormSearch;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTropicalStormForecast is Weather.getTropicalStormForecast;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTropicalStormLocations is Weather.getTropicalStormLocations;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getCurrentAirQuality is Weather.getCurrentAirQuality;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getAirQualityDailyForecasts is Weather.getAirQualityDailyForecasts;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getAirQualityHourlyForecasts is Weather.getAirQualityHourlyForecasts;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDailyHistoricalActuals is Weather.getDailyHistoricalActuals;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDailyHistoricalRecords is Weather.getDailyHistoricalRecords;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDailyHistoricalNormals is Weather.getDailyHistoricalNormals;
}
