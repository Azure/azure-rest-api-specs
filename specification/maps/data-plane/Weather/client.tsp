import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsWeather;

namespace Customizations;

@@clientName(HourlyForecast.date, "timestamp");
@@clientName(HourlyForecast.ceiling, "cloudCeiling");
@@clientName(HourlyForecast.uvIndexPhrase, "uvIndexDescription");

@@clientName(WeatherValue.unit, "unitLabel");

@@clientName(WindDirection.localizedDescription, "description");

@@clientName(MinuteForecastSummary.shortPhrase, "shortDescription");
@@clientName(MinuteForecastSummary.briefPhrase, "briefDescription");

@@clientName(IntervalSummary.shortPhrase, "shortDescription");
@@clientName(IntervalSummary.briefPhrase, "briefDescription");

@@clientName(ForecastInterval.dbz, "decibelRelativeToZ");
@@clientName(ForecastInterval.shortPhrase, "shortDescription");

@@clientName(QuarterDayForecast.date, "dateTime");

@@clientName(CurrentConditions.phrase, "description");
@@clientName(CurrentConditions.isDayTime, "isDaytime");
@@clientName(CurrentConditions.uvIndexPhrase, "uvIndexDescription");
@@clientName(CurrentConditions.ceiling, "cloudCeiling");

@@clientName(PressureTendency.localizedDescription, "description");

@@clientName(DailyForecast.date, "dateTime");
@@clientName(DailyForecast.degreeDaySummary, "meanTemperatureDeviation");
@@clientName(DailyForecast.airAndPollen, "airQuality");
@@clientName(DailyForecast.day, "daytimeForecast");
@@clientName(DailyForecast.night, "nighttimeForecast");

@@clientName(AirAndPollen.name, "description");
@@clientName(AirAndPollen.type, "airQualityType");

@@clientName(DailyForecastDetail.shortPhrase, "shortDescription");

@@clientName(WeatherHazards.hazardDetails, "details");

@@clientName(HazardDetail.shortPhrase, "shortDescription");

@@clientName(WaypointForecast.shortPhrase, "shortDescription");
@@clientName(WaypointForecast.isDayTime, "isDaytime");

@@clientName(WeatherNotification.shortPhrase, "shortDescription");

@@clientName(SevereWeatherAlert.class, "classification");
@@clientName(SevereWeatherAlert.alertAreas, "alertDetails");

@@clientName(SevereWeatherAlertDescription.localized, "description");
@@clientName(SevereWeatherAlertDescription.english, "status");

@@clientName(AlertArea, "AlertDetails");
@@clientName(AlertArea.summary, "description");
@@clientName(AlertArea.alertDetails, "details");
@@clientName(AlertArea.alertDetailsLanguageCode, "language");

@@clientName(DailyIndex.category, "categoryDescription");
@@clientName(DailyIndex.ascending, "isAscending");

@@clientName(ActiveStormResult.results, "activeStorms");

@@clientName(StormSearchResult.results, "storms");

@@clientName(StormForecastResult.results, "stormForecasts");

@@clientName(StormForecast.dateTime, "timestamp");
@@clientName(StormForecast.initializedDateTime, "initializedTimestamp");
@@clientName(StormForecast.location, "coordinates");
@@clientName(StormForecast.window, "weatherWindow");

@@clientName(WeatherWindow.left, "topLeft");
@@clientName(WeatherWindow.right, "bottomRight");
@@clientName(WeatherWindow.beginDateTime, "beginTimestamp");
@@clientName(WeatherWindow.endDateTime, "endTimestamp");

@@clientName(StormWindRadiiSummary.dateTime, "timestamp");

@@clientName(RadiusSector.range, "radius");

@@clientName(StormLocationsResult.results, "stormLocations");

@@clientName(StormLocation.dateTime, "timestamp");
@@clientName(StormLocation.location, "coordinates");

@@clientName(AirQualityResult.results, "airQualityResults");

@@clientName(AirQuality.dateTime, "timestamp");

@@clientName(DailyAirQualityForecastResult.results, "airQualityResults");

@@clientName(DailyAirQuality.dateTime, "timestamp");

@@clientName(DailyHistoricalActualsResult.results, "historicalActuals");

@@clientName(DailyHistoricalActuals.date, "timestamp");

@@clientName(DailyHistoricalRecordsResult.results, "historicalRecords");

@@clientName(DailyHistoricalRecords.date, "timestamp");

@@clientName(DailyHistoricalNormalsResult.results, "historicalNormals");

@@clientName(DailyHistoricalNormals.date, "timestamp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Legacy.clientDefaultValue(ResponseFormatParameters.format, "json");

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
