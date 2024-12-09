import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;

@doc("Provisioning states of Connector ARM Resource")
@lroStatus
union ConnectorProvisioningState {
  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("Accepted State")
  Accepted: "Accepted",

  @doc("Creating State")
  Creating: "Creating",

  @doc("Updating State")
  Updating: "Updating",

  string,
}

@doc("Business State of Connector")
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
  @doc("Unknown direction")
  Unknown: "Unknown",

  @doc("Source Connector")
  Source: "Source",

  @doc("Sink Connector")
  Sink: "Sink",

  string,
}

@doc("Enum of the type of Connector")
union ConnectorType {
  @doc("Unknown source connector.")
  Unknown: "Unknown",

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

  @doc("BitCoin source connector.")
  BitCoinSource: "BitCoinSource",

  @doc("Kafka source connector.")
  KafkaSource: "KafkaSource",

  @doc("confluent source connector.")
  ConfluentSource: "ConfluentSource",

  @doc("mysql source connector.")
  MySqlSource: "MySqlSource",

  @doc("servicebus source connector.")
  AzureServiceBusSource: "AzureServiceBusSource",

  @doc("hana database source connector.")
  @added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
  HanaDatabaseSource: "HanaDatabaseSource",

  @doc("Azure Data Explorer source connector.")
  @added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
  AzureDataExplorerSource: "AzureDataExplorerSource",

  @doc("mqtt source connector.")
  @added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
  MqttSource: "MqttSource",

  string,
}

@doc("Enum of the type of Converter")
union ConverterType {
  @doc("Unknown converter.")
  Unknown: "Unknown",

  @doc("This represents a converter for byte arrays format.")
  ByteArrayConverter: "ByteArrayConverter",

  @doc("This represents a converter for string format.")
  StringConverter: "StringConverter",

  @doc("This represents a converter for json format.")
  JsonConverter: "JsonConverter",

  @doc("This represents a converter for Avro format.")
  AvroConverter: "AvroConverter",

  @doc("This represents a converter for csv format.")
  CsvConverter: "CsvConverter",

  string,
}

@doc("Enum of the OffsetPolicy for CosmosDB connector")
union OffsetPolicyForCosmosDB {
  @doc("use the latest (most recent) source offset")
  UseLatestSourceOffset: "UseLatestSourceOffset",

  @doc("use the earliest recorded offset")
  UseEarliestRecordedOffset: "UseEarliestRecordedOffset",

  string,
}

@doc("Enum of the SaslMechanism for Confluent connector")
union SaslMechanismForConfluent {
  @doc("The PLAIN sasl mechanism.")
  Plain: "PLAIN",

  @doc("The SCRAM-SHA-256 sasl mechanism.")
  ScramSha256: "SCRAM-SHA-256",

  @doc("The SCRAM-SHA-512 sasl mechanism.")
  ScramSha512: "SCRAM-SHA-512",

  string,
}

@doc("Enum of the SecurityProtocol for Confluent connector")
union SecurityProtocolForConfluent {
  @doc("The SASL_PLAINTEXT security protocol.")
  SaslPlainText: "SASL_PLAINTEXT",

  @doc("The PLAINTEXT security protocol.")
  PlainText: "PLAINTEXT",

  @doc("The SASL_SSL security protocol.")
  SaslSsl: "SASL_SSL",

  @doc("The SSL security protocol.")
  Ssl: "SSL",

  string,
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

@doc("Source data format Types")
union SourceDataFormatTypes {
  @doc("Do not use SourceDataFormat feature.")
  None: "None",

  @doc("JSON format")
  JSON: "JSON",

  @doc("CSV format")
  CSV: "CSV",

  string,
}

@doc("Source data format base model")
@discriminator("type")
model SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatTypes;
}

@doc("JSON source data format model")
model JsonSourceDataFormat extends SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatTypes.JSON;

  @doc("Charset supported by Java language")
  textCharset: string;
}

@doc("Delimiter for csv")
union CsvDelimiters {
  @doc("Pipe delimiter")
  Pipe: "Pipe",

  @doc("Comma delimiter")
  Comma: "Comma",

  @doc("SemiColon delimiter")
  SemiColon: "SemiColon",

  @doc("Space delimiter")
  Space: "Space",

  @doc("Tab delimiter")
  Tab: "Tab",

  string,
}

@doc("CsvHeader types")
union CsvHeaderTypes {
  @doc("include CSV header")
  IncludeHeader: "IncludeHeader",

  @doc("exclude CSV header")
  ExcludeHeader: "ExcludeHeader",

  string,
}

@doc("CSV Source data format model")
model CsvSourceDataFormat extends SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatTypes.CSV;

  @doc("CSV header type")
  header: CsvHeaderTypes;

  @doc("CSV Delimiter")
  delimiter: CsvDelimiters;

  @doc("Charset supported by Java language")
  textCharset: string;
}

@doc("Base class for Converter config")
@discriminator("type")
model ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType;
}

@doc("CsvConverter config")
model CsvConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.CsvConverter;
}

@doc("AvroConverter config")
model AvroConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.AvroConverter;
}

@doc("StringConverter config")
model StringConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.StringConverter;
}

@doc("ByteArrayConverter config")
model ByteArrayConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.ByteArrayConverter;
}

@doc("Json Decimal Format configuration")
union JsonDecimalFormat {
  @doc("Type of Base64.")
  Base64: "Base64",

  @doc("Type of Numeric.")
  Numeric: "Numeric",

  string,
}

@doc("JsonConverter config")
model JsonConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.JsonConverter;

  @doc("Whether schemas enabled.")
  schemasEnabled?: boolean;

  @doc("Format for Decimal type.")
  decimalFormat?: JsonDecimalFormat;
}

@doc("CloudEvents types")
union CloudEventsTypes {
  @doc("Do not use CloudEventsConfig")
  None: "None",

  @doc("CatalogCloudEventsConfig")
  Catalog: "Catalog",

  string,
}

@doc("Cloud events config")
@discriminator("type")
model CloudEventsConfig {
  @doc("Type of CloudEventsConfig.")
  type: CloudEventsTypes;
}

@doc("Catalog schema id config")
model CatalogSchemaId {
  @doc("SchemaGroup id.")
  schemaGroupId: string;

  @doc("Schema id.")
  schemaId: string;

  @doc("Endpoint for catalog.")
  endpoint: string;
}

@doc("Catalog cloud events transform config.")
model CatalogCloudEventsConfig extends CloudEventsConfig {
  @doc("Type of CatalogCloudEventsConfig.")
  type: CloudEventsTypes.Catalog;

  @doc("Whether auto-register new schemas.")
  autoRegisterSchemas: boolean;

  @doc("Catalog schemaIds.")
  @OpenAPI.extension("x-ms-identifiers", [])
  catalogSchemaIds: CatalogSchemaId[];

  @doc("access token.")
  @secret
  accessToken: string;
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

  @doc("Type of the Connector.")
  converterConfig: ConverterConfig;

  @doc("Direction of the Connector.")
  connectorDirection?: Direction;

  @doc("Type of the Connector.")
  connectorType: ConnectorType;

  @doc("connectionString of the EventHub.")
  eventHubConfig: EventHubConfig;

  @doc("Data format of the data source")
  sourceDataFormat?: SourceDataFormat;

  @doc("Cloud events config")
  cloudEventsConfig?: CloudEventsConfig;

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

  @doc("Sasl mechanism of the confluent.")
  saslMechanism: SaslMechanismForConfluent;

  @doc("Security protocol of the confluent.")
  securityProtocol: SecurityProtocolForConfluent;
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

@doc("StartPosition types for Kinesis")
union KinesisStartPositionType {
  @doc("TrimHorizon type")
  TrimHorizon: "TrimHorizon",

  @doc("Latest type")
  Latest: "Latest",

  @doc("AtSequenceNumber type")
  AtSequenceNumber: "AtSequenceNumber",

  @doc("AfterSequenceNumber type")
  AfterSequenceNumber: "AfterSequenceNumber",

  @doc("AtTimestamp type")
  AtTimestamp: "AtTimestamp",

  string,
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

  @doc("startPosition supported by Kinesis.")
  startPosition: KinesisStartPositionType;

  @doc("startSequence for startPosition.")
  startSequence?: string;

  @doc("startTime for startPosition.")
  startTime?: utcDateTime;
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

  @doc("Snapshot Locking Mode")
  @added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
  snapshotLockingMode?: SnapshotLockingModeForMysql;
}

@doc("Type of AzureServiceBusType")
@added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
union SnapshotLockingModeForMysql {
  @doc("Minimal type")
  Minimal: "Minimal",

  @doc("Extended type")
  Extended: "Extended",

  @doc("None type")
  None: "None",

  string,
}

@doc("Type of AzureServiceBusType")
union AzureServiceBusType {
  @doc("Topic type")
  Topic: "Topic",

  @doc("Queue type")
  Queue: "Queue",

  string,
}

@doc("Configuration for AzureServiceBusSourceConnector")
model AzureServiceBusSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of AzureServiceBusSource")
  connectorType: ConnectorType.AzureServiceBusSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("Name for topic Or Queue.")
  topicOrQueueName: string;

  @doc("Name for subscription.")
  subscriptionName?: string;

  @doc("connectionString for AzureServiceBusSource.")
  connectionString: string;

  @doc("AzureServiceBusSource type.")
  serviceBusType: AzureServiceBusType;
}

@doc("Configuration for HanaDatabaseSourceConnector")
@added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
model HanaDatabaseSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of HanaDatabaseSourceConnector")
  connectorType: ConnectorType.HanaDatabaseSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("Url of HANA database.")
  connectionUrl: string;

  @doc("User for HANA database.")
  userName: string;

  @doc("Password for HANA database.")
  @secret
  password: string;

  @doc("The query mode in which data should be fetched from SAP DB table.")
  queryMode?: HanaQueryMode;

  @doc("HANA schema to source data from, default as the HANA username..")
  schema?: string;

  @doc("Table name for HANA database.")
  table?: string;

  @doc("The query statement when queryMode is set to query.")
  query?: string;

  @doc("Max rows to include in a single batch call. Should be an integer.")
  batch?: int32;

  @doc("The poll interval at which the data should be fetched from SAP DB table.")
  interval?: int32;

  @doc("The number of topic partitions that the Source connector can use to publish the data.")
  partitions?: int32;

  @doc("Whether the DECIMAL column types are mapped to the default decimal type or one of the primitive types.")
  numericMapping?: HanaNumericMapping;

  @doc("The mode in which data should be fetched from SAP DB table.")
  mode?: HanaMode;

  @doc("In order to fetch data from a SAP DB table when mode is set to incrementing, an incremental (or auto-incremental) column needs to be provided.")
  incrementingColumn?: string;
}

@doc("Type of HanaQueryMode")
@added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
union HanaQueryMode {
  @doc("Table type")
  Table: "Table",

  @doc("Query type")
  Query: "Query",

  string,
}

@doc("Type of HanaNumericMapping")
@added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
union HanaNumericMapping {
  @doc("Table type")
  None: "None",

  @doc("Query type")
  BestFit: "BestFit",

  @doc("BestFitEagerDouble type")
  BestFitEagerDouble: "BestFitEagerDouble",

  string,
}

@doc("Type of HanaNumericMapping")
@added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
union HanaMode {
  @doc("Bulk mode")
  Bulk: "Bulk",

  @doc("Incrementing mode")
  Incrementing: "Incrementing",

  string,
}

@doc("Configuration for AzureDataExplorerSourceConnector")
@added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
model AzureDataExplorerSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of AzureDataExplorerSourceConnector")
  connectorType: ConnectorType.AzureDataExplorerSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("Url of AzureDataExplorer cluster.")
  clusterUrl: string;

  @doc("Database name for AzureDataExplorer.")
  database: string;

  @doc("AzureDataExplorer table names use commas to separate multiple tables.")
  tableNames: string;

  @doc("The uniquely identifies your application in the Microsoft identity platform.")
  applicationClientId: string;

  @doc("A secret string that the application uses to prove its identity when requesting a token.")
  @secret
  applicationSecret: string;

  @doc("AAD tenant Id GUID or microsoft.com")
  aadAuthorityId: string;
}

@doc("Configuration for MqttSourceConnector")
@added(Microsoft.MessagingConnectors.Versions.v2024_11_01_preview)
model MqttSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of MqttSourceConnector")
  connectorType: ConnectorType.MqttSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;

  @doc("Mqtt server version.")
  serverVersion: MqttVersion;

  @doc("Topic to subscribe to.")
  topic: string;

  @doc("URL of the broker where to establish the connection.")
  brokerUrl: string;

  @doc("Username to use when connecting to the MQTT v5 compliant broker.")
  username?: string;

  @doc("Password to use when connecting to the MQTT v5 compliant broker.")
  @secret
  password?: string;
}

@doc("Version for Mqtt server")
union MqttVersion {
  @doc("Mqtt v5")
  V5: "V5",

  @doc("Mqtt v3 and below")
  V3AndBelow: "V3AndBelow",

  string,
}

@doc("Type of DataRange")
union DataRangeType {
  @doc("Unknown type")
  Unknown: "Unknown",

  @doc("Max limit range type")
  Limit: "Limit",

  string,
}

@doc("Base config for DataRange")
@discriminator("type")
model DataRangeBaseConfig {
  @doc("type of dataRange")
  type: DataRangeType;
}

@doc("DataRange by max records limit")
model DataRangeLimit extends DataRangeBaseConfig {
  @doc("Limit type of DataRange")
  type: DataRangeType.Limit;

  @doc("Max Limit for DataRange")
  limit: int32;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Properties of one DataPreview")
model DataPreviewProperties {
  @doc("Properties of one Connector Source")
  connectorProperties: ConnectorProperties;

  @doc("DataRange for DataPreview")
  dataRange: DataRangeBaseConfig;
}

@doc("Properties of DataPreview results")
model DataPreviewResults {
  @doc("Count of DataPreview results")
  count: int32;

  @doc("Content of DataPreview results")
  results: string[];
}
