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

@doc("Type of AzureServiceBusType")
union AzureServiceBusType {
  @doc("Topic type")
  Topic: "Topic",

  @doc("Queue type")
  Queue: "Queue",

  string,
}

@doc("Configuration for AzureServiceBusSourceConnector")
model AzureServiceBusSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of AzureServiceBusSource")
  connectorType: ConnectorType.AzureServiceBusSource;

  @doc("Name for topic Or Queue.")
  topicOrQueueName: string;

  @doc("Name for subscription.")
  subscriptionName?: string;

  @doc("connectionString for AzureServiceBusSource.")
  @secret
  connectionString: string;

  @doc("AzureServiceBusSource type.")
  serviceBusType: AzureServiceBusType;
}
