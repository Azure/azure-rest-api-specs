import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("Configuration for DataverseSourceConnector")
model DataverseSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of DataverseSourceConnector")
  connectorType: ConnectorType.DataverseSource;

  @doc("Namespace of the EventHub.")
  eventHubNamespaceHostname: string;

  @doc("Name of the EventHub.")
  eventHub: string;

  @doc("ConsumerGroup of the EventHub.")
  consumerGroup: string;

  @doc("The position of events in an Event Hub partition.")
  startEventPosition: EventPosition;

  @doc("Authentication for EventHub, OAuth or ConnectionString.")
  authentication: Authentication;

  @doc("OffsetStartTime in utcDateTime zone.")
  offsetStartTime?: utcDateTime;

  @doc("List of post entity images")
  postEntityImages: string[];
}
