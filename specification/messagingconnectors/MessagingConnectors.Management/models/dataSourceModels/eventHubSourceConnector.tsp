import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.EventHub;

@doc("The position of events in an Event Hub partition")
union EventHubEventPosition {
  @doc("Corresponds to the first record of the partition.")
  Earliest: "Earliest",

  @doc("Corresponds to the end of the partition.")
  Latest: "Latest",

  @doc("Corresponds to the special position for one time.")
  CustomStartTime: "CustomStartTime",

  string,
}

@doc("Configuration for EventHubSourceConnector")
model EventHubSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of EventHubSourceConnector")
  connectorType: Models.Connector.ConnectorType.EventHubSource;

  @doc("namespace of the EventHub.")
  eventHubNamespaceHostname: string;

  @doc("Name of the EventHub.")
  eventHub: string;

  @doc("ConsumerGroup of the EventHub.")
  consumerGroup: string;

  @doc("The position of events in an Event Hub partition.")
  startEventPosition: EventHubEventPosition;

  @doc("Authentication for EventHub, OAuth or ConnectionString.")
  authentication: Models.Auth.Authentication;

  @doc("OffsetStartTime in utcDateTime zone.")
  offsetStartTime?: utcDateTime;
}
