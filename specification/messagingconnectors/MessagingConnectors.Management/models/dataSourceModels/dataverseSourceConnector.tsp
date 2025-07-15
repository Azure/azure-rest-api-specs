import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.Dataverse;

@doc("The position of events in an Event Hub partition")
union DataverseEventPosition {
  @doc("Corresponds to the first record of the partition.")
  Earliest: "Earliest",

  @doc("Corresponds to the end of the partition.")
  Latest: "Latest",

  string,
}

@doc("Configuration for DataverseSourceConnector")
model DataverseSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of DataverseSourceConnector")
  connectorType: Models.Connector.ConnectorType.DataverseSource;

  @doc("Namespace of the EventHub.")
  eventHubNamespaceHostname: string;

  @doc("Name of the EventHub.")
  eventHub: string;

  @doc("ConsumerGroup of the EventHub.")
  consumerGroup: string;

  @doc("The position of events in an Event Hub partition.")
  startEventPosition: DataverseEventPosition;

  @doc("Authentication for EventHub, OAuth or ConnectionString.")
  authentication: Models.Auth.Authentication;

  @doc("OffsetStartTime in utcDateTime zone.")
  offsetStartTime?: utcDateTime;

  @doc("List of post entity images")
  postEntityImages: string[];
}
