import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Connector;

@doc("Enum of the type of Connector")
union ConnectorType {
  @doc("Google pub sub source connector.")
  GooglePubSubSource: "GooglePubSubSource",

  @doc("Amazon kinesis source connector.")
  KinesisSource: "KinesisSource",

  @doc("Postgre sql source connector.")
  PostgreSqlSource: "PostgreSqlSource",

  @doc("Sql server source connector.")
  SqlServerSource: "SqlServerSource",

  @doc("Cosmos db source connector.")
  CosmosDbSource: "CosmosDbSource",

  @doc("Confluent source connector.")
  ConfluentSource: "ConfluentSource",

  @doc("Mysql source connector.")
  MySqlSource: "MySqlSource",

  @doc("Servicebus source connector.")
  AzureServiceBusSource: "AzureServiceBusSource",

  @doc("Hana database source connector.")
  HanaDatabaseSource: "HanaDatabaseSource",

  @doc("Azure Data Explorer source connector.")
  AzureDataExplorerSource: "AzureDataExplorerSource",

  @doc("Mqtt source connector.")
  MqttSource: "MqttSource",

  @doc("SolacePubsub source connector.")
  SolacePubsubSource: "SolacePubsubSource",

  @doc("ManagedAzureMapsWeatherSource source connector.")
  ManagedAzureMapsWeatherSource: "ManagedAzureMapsWeatherSource",

  @doc("EventHub source connector.")
  EventHubSource: "EventHubSource",

  @doc("Dataverse source connector.")
  DataverseSource: "DataverseSource",

  @doc("Dataverse source connector.")
  AzureBlobSource: "AzureBlobSource",

  @doc("SampleData source connector.")
  SampleDataSource: "SampleDataSource",

  string,
}

@doc("Enum of the type of Connector")
union ConnectorSubType {
  @doc("EventHub Source.")
  EventHubSource: "EventHubSource",

  @doc("IoTHub Source.")
  IoTHubSource: "IoTHubSource",

  string,
}
