import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.AzureServiceBus;

@doc("Type of AzureServiceBusType")
union AzureServiceBusType {
  @doc("Queue type")
  Queue: "Queue",

  @doc("Topic type")
  Topic: "Topic",

  string,
}

@doc("Configuration for AzureServiceBusSourceConnector")
model AzureServiceBusSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of AzureServiceBusSource")
  connectorType: Models.Connector.ConnectorType.AzureServiceBusSource;

  @doc("Name for topic Or Queue.")
  topicOrQueueName: string;

  @doc("Gets or sets the connection string for the Azure Servicebus instance.")
  @secret
  connectionString: string;

  @doc("Name for subscription.")
  subscriptionName?: string;

  @doc("AzureServiceBusSource type.")
  serviceBusType: AzureServiceBusType;
}
