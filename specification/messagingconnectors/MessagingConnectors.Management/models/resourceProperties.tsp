import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("Properties of one Azure MessagingConnector resource")
@discriminator("direction")
model ConnectorProperties {
  @doc("Direction of connector")
  direction: Direction;

  @doc("Max Tasks count of the Connector.")
  maxTasks: int32;

  @doc("networkProperties config.")
  networkProperties?: NetworkProperties;

  @doc("Scale config.")
  scalingProperties: ScalingProperties;

  @doc("State of the MessagingConnector")
  connectorState?: ConnectorState;

  @doc("State of provisioning of the MessagingConnector ARM Resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ConnectorProvisioningState;
}

@doc("Provisioning states of Connector ARM Resource")
@lroStatus
union ConnectorProvisioningState {
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",

  @doc("Creating State")
  Creating: "Creating",

  @doc("Updating State")
  Updating: "Updating",

  string,
}

@doc("Base properties for Source Connector")
model SourceConnectorProperties extends ConnectorProperties {
  @doc("Source Connector")
  direction: Direction.Source;

  @doc("Type of the Connector.")
  converterConfig: ConverterConfig;

  @doc("connectionString of the EventHub.")
  eventHubConfig: EventHubConfig;

  @doc("Data format of the data source")
  sourceDataFormat?: SourceDataFormat;

  @doc("Cloud events config")
  cloudEventsConfig?: CloudEventsConfig;

  @doc("Special properties for source.")
  dataSourceProperties: DataSourceProperties;
}

@doc("Base properties for source.")
@discriminator("connectorType")
model DataSourceProperties {
  @doc("Type of the Connector.")
  connectorType: ConnectorType;

  @doc("Subtype of the Connector.")
  connectorSubType?: ConnectorSubType;
}

@doc("Connector job execution status")
union ConnectorState {
  @doc("Unknown State")
  Unknown: "Unknown",

  @doc("Creating State")
  Creating: "Creating",

  @doc("Initializing State")
  Initializing: "Initializing",

  @doc("Running State")
  Running: "Running",

  @doc("Updating State")
  Updating: "Updating",

  @doc("Degraded State")
  Degraded: "Degraded",

  @doc("Stopped State")
  Stopped: "Stopped",

  @doc("Paused State")
  Paused: "Paused",

  @doc("Deleting State")
  Deleting: "Deleting",

  @doc("Failed State")
  Failed: "Failed",

  string,
}

@doc("Enum of Directions of Connector")
union Direction {
  @doc("Source Connector")
  Source: "Source",

  @doc("Sink Connector")
  Sink: "Sink",

  string,
}

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
