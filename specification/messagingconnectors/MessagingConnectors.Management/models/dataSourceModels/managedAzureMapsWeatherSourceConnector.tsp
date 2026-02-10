import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.ManagedAzureMapsWeather;

@doc("Type of weather data unit")
union WeatherDataUnit {
  @doc("Metric data unit")
  Metric: "Metric",

  @doc("Imperial data unit")
  Imperial: "Imperial",

  string,
}

@doc("Configuration for ManagedAzureMapsWeatherSourceConnector")
model ManagedAzureMapsWeatherSourceConnectorProperties
  extends DataSourceProperties {
  @doc("Type of ManagedAzureMapsWeatherSource")
  connectorType: Models.Connector.ConnectorType.ManagedAzureMapsWeatherSource;

  @doc("Name of the location")
  locationName?: string;

  @doc("Longitude of the location.")
  longitude: float64;

  @doc("Latitude of the location.")
  latitude: float64;

  @doc("Whether get the full details for the weather data.")
  details?: boolean;

  @doc("The language of the weather data.")
  language?: string;

  @doc("The data unit for the weather.")
  unit?: WeatherDataUnit;

  @doc("The polling interval in minutes.")
  pollIntervalInMinutes?: int32;
}
