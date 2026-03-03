import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

#suppress "@azure-tools/typespec-azure-core/casing-style" "IoTHubSource"
namespace Microsoft.MessagingConnectors.Models.DataSource.IoTHubSource;

@doc("The position of events in an iot hub partition")
union IoTHubEventPosition {
  @doc("Corresponds to the first record of the partition.")
  Earliest: "Earliest",

  @doc("Corresponds to the end of the partition.")
  Latest: "Latest",

  @doc("Corresponds to the special position for one time.")
  CustomStartTime: "CustomStartTime",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IoTHubSourceConnectorProperties"
@doc("Configuration for IoTHubSourceConnector")
model IoTHubSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of IoTHubSourceConnector")
  connectorType: Models.Connector.ConnectorType.IoTHubSource;

  @doc("hostname of the iotHub.")
  iotHubHostname: string;

  @doc("ConsumerGroup of the iot hub.")
  consumerGroup: string;

  @doc("The position of events in an iot hub partition.")
  startEventPosition: IoTHubEventPosition;

  @doc("Authentication for iot hub, currently only support ConnectionString.")
  authentication: Models.Auth.Authentication;

  @doc("OffsetStartTime in utcDateTime zone.")
  offsetStartTime?: utcDateTime;
}
