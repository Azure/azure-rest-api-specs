import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.MessagingConnectors;

@doc("Provisioning states of Connector ARM Resource")
@lroStatus
enum ConnectorProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,

  @doc("Creating State")
  Creating,

  @doc("Updating State")
  Updating,
}

@doc("Business State of Connector")
enum ConnectorState {
  @doc("Unknown State")
  Unknown,

  @doc("Creating State")
  Creating,

  @doc("Initializing State")
  Initializing,

  @doc("Running State")
  Running,

  @doc("Updating State")
  Updating,

  @doc("Degraded State")
  Degraded,

  @doc("Stopped State")
  Stopped,

  @doc("Paused State")
  Paused,

  @doc("Deleting State")
  Deleting,

  @doc("Failed State")
  Failed,
}

@doc("Enum of Directions of Connector")
enum Direction {
  @doc("Unknown direction")
  Unknown,

  @doc("Source Connector")
  Source,

  @doc("Sink Connector")
  Sink,
}

@doc("Enum of the type of Connector")
enum ConnectorType {
  @doc("Unknown source connector.")
  Unknown,

  @doc("Google pub sub source connector.")
  GooglePubSubSource,

  @doc("Amazon kinesis source connector.")
  KinesisSource,

  @doc("Postgre sql source connector.")
  PostgreSqlSource,

  @doc("Sql server source connector.")
  SqlServerSource,

  @doc("Cosmos db source connector.")
  CosmosDbSource,

  @doc("BitCoin source connector.")
  BitCoinSource,

  @doc("Kafka source connector.")
  KafkaSource,

  @doc("confluent source connector.")
  ConfluentSource,

  @doc("mysql source connector.")
  MySqlSource,
}

@doc("Enum of the type of Converter")
enum ConverterType {
  @doc("Unknown converter.")
  Unknown,

  @doc("This represents a converter for byte arrays format.")
  ByteArrayConverter,

  @doc("This represents a converter for string format.")
  StringConverter,

  @doc("This represents a converter for json format.")
  JsonConverter,

  @doc("This represents a converter for Avro format.")
  AvroConverter,

  @doc("This represents a converter for csv format.")
  CsvConverter,
}

@doc("Enum of the OffsetPolicy for CosmosDB connector")
enum OffsetPolicyForCosmosDB {
  @doc("use the latest (most recent) source offset,")
  UseLatestSourceOffset,

  @doc("use the earliest recorded offset")
  UseEarliestRecordedOffset,
}

@doc("Basic info for EventHub")
model EventHubConfig {
  @doc("namespace of the EventHub.")
  namespaceHostName: string;

  @doc("name of the EventHub.")
  eventHubName: string;

  @doc("connectionString of the EventHub.")
  @secret
  connectionString: string;
}

@doc("Properties of one arm resource")
model ResourceProperties {
  @doc("Properties of one Connector")
  connectorProperties: ConnectorProperties;

  @doc("State of provisioning of the MessagingConnector ARM Resource")
  @visibility("read")
  provisioningState?: ConnectorProvisioningState;
}

@doc("Basic info for Connector")
@discriminator("connectorType")
model ConnectorProperties {
  @doc("Max Tasks count of the Connector.")
  maxTasks: int32;

  @doc("Type of the Connector.")
  valueConverter: ConverterType;

  @doc("Direction of the Connector.")
  connectorDirection?: Direction;

  @doc("Type of the Connector.")
  connectorType: ConnectorType;

  @doc("connectionString of the EventHub.")
  eventHubConfig: EventHubConfig;

  @doc("State of the MessagingConnector")
  connectorState?: ConnectorState;
}

@doc("Configuration for BitCoinSourceConnector")
model BitCoinSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of BitCoinSourceConnector")
  connectorType: ConnectorType.BitCoinSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;
}

@doc("Configuration for ConfluentSourceConnector")
model ConfluentSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of ConfluentSourceConnector")
  connectorType: ConnectorType.ConfluentSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("bootstrapServers of the Confluent server.")
  bootstrapServers: string;

  @doc("Topic of the Confluent.")
  topic: string;

  @doc("ConsumerGroup of the Confluent.")
  consumerGroup: string;

  @doc("AutoOffsetReset policy of the Confluent consume.")
  autoOffsetReset: string;

  @doc("User of the Confluent.")
  user: string;

  @doc("Password of the Confluent.")
  @secret
  password: string;
}

@doc("Configuration for CosmosDbSourceConnector")
model CosmosDbSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of CosmosDbSourceConnector")
  connectorType: ConnectorType.CosmosDbSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("PollIntervalInMs policy.")
  pollIntervalInMs: int32;

  @doc("Endpoint of CosmosDB.")
  cosmosEndpoint: string;

  @doc("DatabaseName for CosmosDB server.")
  databaseName: string;

  @doc("Container for CosmosDB server.")
  container: string;

  @doc("masterKey for CosmosDB server.")
  @secret
  masterKey: string;

  @doc("useLatestOffset policy")
  offsetPolicy: OffsetPolicyForCosmosDB;
}

@doc("Configuration for GooglePubSubSourceConnector")
model GooglePubSubSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of GooglePubSubSourceConnector")
  connectorType: ConnectorType.GooglePubSubSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("ProjectId for pubsub server.")
  projectId: string;

  @doc("SubscriptionName for pubsub server.")
  subscriptionName: string;

  @doc("AccountKey for pubsub server.")
  @secret
  accountKey: string;
}

@doc("Configuration for KinesisSourceConnector")
model KinesisSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of KinesisSourceConnector")
  connectorType: ConnectorType.KinesisSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("AccessKeyId for AWS Kinesis Server.")
  awsAccessKeyId: string;

  @doc("SecretAccessKey for AWS Kinesis Server.")
  @secret
  awsSecretAccessKey: string;

  @doc("Region of AWS Kinesis Server.")
  awsKinesisRegion: string;

  @doc("StreamName in AWS Kinesis Server.")
  awsKinesisStreamName: string;
}

@doc("Configuration for PostgreSqlSourceConnector")
model PostgreSqlSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of PostgreSqlSourceConnector")
  connectorType: ConnectorType.PostgreSqlSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("HostName for PostgreSql Server.")
  hostName: string;

  @doc("Port for PostgreSql Server.")
  port: int32;

  @doc("DatabaseName for PostgreSql Server.")
  databaseName: string;

  @doc("Username for PostgreSql Server.")
  username: string;

  @doc("Password for PostgreSql Server.")
  @secret
  password: string;

  @doc("ReplicationSlotName for PostgreSql Server.")
  replicationSlotName: string;

  @doc("Tables used as source.")
  tableNames: string;
}

@doc("Configuration for SqlServerSqlSourceConnector")
model SqlServerSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of SqlServerSqlSourceConnector")
  connectorType: ConnectorType.SqlServerSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("HostName for SqlServer.")
  hostName: string;

  @doc("Port for SqlServer.")
  port: int32;

  @doc("DatabaseName for SqlServer.")
  databaseName: string;

  @doc("Username for SqlServer.")
  username: string;

  @doc("Password for SqlServer.")
  @secret
  password: string;

  @doc("Tables used as source.")
  tableNames: string;
}

@doc("Configuration for MySqlSourceConnector")
model MySqlSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of MySqlSourceConnector")
  connectorType: ConnectorType.MySqlSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("HostName for MySql.")
  hostName: string;

  @doc("Port for MySql.")
  port: int32;

  @doc("DatabaseName for MySql.")
  databaseName: string;

  @doc("Username for MySql.")
  username: string;

  @doc("Password for MySql.")
  @secret
  password: string;

  @doc("Server id for MySql.")
  serverId: int32;

  @doc("Tables used as source.")
  tableNames: string;
}
