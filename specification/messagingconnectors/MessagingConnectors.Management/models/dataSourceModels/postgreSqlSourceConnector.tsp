import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.PostgreSql;

@doc("Type of PublicationAutocreateMode")
union PostgreSqlPublicationAutocreateMode {
  @doc("The AllTables mode.")
  AllTables: "AllTables",

  @doc("The Disabled mode.")
  Disabled: "Disabled",

  @doc("The Filtered mode.")
  Filtered: "Filtered",

  string,
}

@doc("Enum DecimalHandlingMode for postgresql")
union PostgreSqlDecimalHandlingMode {
  @doc("The Precise mode.")
  PreciseMode: "Precise",

  @doc("The Double mode.")
  DoubleMode: "Double",

  @doc("The String mode.")
  StringMode: "String",

  string,
}

@doc("Enum SkippedOperationsMode for postgresql")
union PostgreSqlSkippedOperationsMode {
  @doc("The InsertOrCreate mode.")
  InsertOrCreate: "InsertOrCreate",

  @doc("The Update mode.")
  Update: "Update",

  @doc("The Delete mode.")
  Delete: "Delete",

  @doc("The Truncate mode.")
  Truncate: "Truncate",

  @doc("The None mode.")
  None: "None",

  string,
}

@doc("Specifies the criteria for running a snapshot when the connector starts")
union PostgreSqlSnapshotMode {
  @doc("The connector performs a snapshot only when no offsets have been recorded for the logical server name.")
  Initial: "Initial",

  @doc("The connector performs an initial snapshot and then stops, without processing any subsequent changes.")
  InitialOnly: "InitialOnly",

  @doc("The connector never performs snapshots. When a connector is configured this way, after it starts.")
  NoData: "NoData",

  string,
}

@doc("Specifies the criteria for running a snapshot when the connector starts")
union PostgreSqlSslMode {
  @doc("Allow attempts to use an unencrypted connection first and, failing that, a secure (encrypted) connection.")
  Allow: "Allow",

  @doc("Prefer attempts to use a secure (encrypted) connection first and, failing that, an unencrypted connection.")
  Prefer: "Prefer",

  @doc("Require uses a secure (encrypted) connection, and fails if one cannot be established.")
  Require: "Require",

  @doc("Verify-ca behaves like require but also verifies the server TLS certificate against the configured Certificate Authority (CA) certificates, or fails if no valid matching CA certificates are found.")
  VerifyCa: "VerifyCa",

  @doc("Verify-full behaves like verify-ca but also verifies that the server certificate matches the host to which the connector is trying to connect.")
  VerifyFull: "VerifyFull",

  string,
}

@doc("Controls whether a tombstone event should be generated after a delete event")
union PostgreSqlTimePrecisionMode {
  @doc("Captures the time and timestamp values exactly as in the database using either millisecond, microsecond, or nanosecond precision values based on the database column’s type.")
  Adaptive: "Adaptive",

  @doc("Captures the date, datetime and timestamp values exactly as in the database using either millisecond, microsecond, or nanosecond precision values based on the database column’s type. An exception is TIME type fields, which are always captured as microseconds.")
  AdaptiveTimeMicroseconds: "AdaptiveTimeMicroseconds",

  @doc("Always represents time and timestamp values by using Kafka Connect’s built-in representations for Time, Date, and Timestamp, which use millisecond precision regardless of the database columns' precision.")
  Connect: "Connect",

  string,
}

@doc("Specifies how schema names should be adjusted for compatibility with the message converter used by the connector")
union PostgreSqlSchemaNameAdjustmentMode {
  @doc("Does not apply any adjustment.")
  None: "None",

  @doc("Replaces the characters that cannot be used in the Avro type name with underscore.")
  Avro: "Avro",

  @doc("Replaces the underscore or characters that cannot be used in the Avro type name with corresponding Unicode characters.")
  AvroUnicode: "AvroUnicode",

  string,
}

@doc("Specifies how field names should be adjusted for compatibility with the message converter used by the connector.")
union PostgreSqlFieldNameAdjustmentMode {
  @doc("Does not apply any adjustment.")
  None: "None",

  @doc("Replaces the characters that cannot be used in the Avro type name with underscore.")
  Avro: "Avro",

  @doc("Replaces the underscore or characters that cannot be used in the Avro type name with corresponding Unicode characters.")
  AvroUnicode: "AvroUnicode",

  string,
}

@doc("SnapshotSelectStatementOverride Item")
model PostgreSqlSnapshotSelectStatementOverrideItem {
  @doc("Table name")
  tableName: string;

  @doc("select statement")
  selectStatement: string;
}

@doc("Configuration for PostgreSqlSourceConnector")
model PostgreSqlSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of PostgreSqlSourceConnector")
  connectorType: Models.Connector.ConnectorType.PostgreSqlSource;

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

  @doc("Tables used as source.")
  tableIncludeList?: string;

  @doc("Tables to be excluded.")
  tableExcludeList?: string;

  @doc("Columns to be included.")
  columnIncludeList?: string;

  @doc("Columns to be excluded.")
  columnExcludeList?: string;

  @doc("Handling mode for DECIMAL and NUMERIC.")
  decimalHandlingMode?: PostgreSqlDecimalHandlingMode;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Select table rows to include in the snapshot.")
  snapshotSelectStatementOverrides?: PostgreSqlSnapshotSelectStatementOverrideItem[];

  @doc("Publication creation mode.")
  publicationAutocreateMode?: PostgreSqlPublicationAutocreateMode;

  @doc("Operation types to be skipped.")
  skippedOperations?: PostgreSqlSkippedOperationsMode[];

  @doc("Publication Name of Postgre.")
  publicationName?: string;

  @doc("Specifies the criteria for running a snapshot when the connector starts.")
  snapshotMode?: PostgreSqlSnapshotMode;

  @doc("Whether to use an encrypted connection to the PostgreSQL server")
  sslmode?: PostgreSqlSslMode;

  @doc("Fully-qualified name of the data collection that is used to send signals to the connector. Use the following format to specify the collection name:schemaName.tableName")
  signalDataCollection?: string;

  @doc("Controls how frequently the connector sends heartbeat messages to a Kafka topic. The default behavior is that the connector does not send heartbeat messages.")
  heartbeatIntervalMs?: int32;

  @doc("Specifies a query that the connector executes on the source database when the connector sends a heartbeat message.")
  heartbeatActionQuery?: string;

  @doc("Positive integer value that specifies the maximum size of each batch of events that the connector processes.")
  maxBatchSize?: int32;

  @doc("Positive integer value that specifies the maximum number of records that the blocking queue can hold.")
  maxQueueSize?: int32;

  @doc("Positive integer value that specifies the number of milliseconds the connector should wait for new change events to appear before it starts processing a batch of events.")
  pollIntervalMs?: int32;

  @doc("Specifies whether the connector creates a failover slot. If you omit this setting, or if the primary server runs PostgreSQL 16 or earlier, the connector does not create a failover slot.")
  slotFailover?: boolean;

  @doc("Specifies how schema names should be adjusted for compatibility with the message converter used by the connector. ")
  schemaNameAdjustmentMode?: PostgreSqlSchemaNameAdjustmentMode;

  @doc("Specifies how field names should be adjusted for compatibility with the message converter used by the connector. ")
  fieldNameAdjustmentMode?: PostgreSqlFieldNameAdjustmentMode;

  @doc("Time, date, and timestamps can be represented with different kinds of precision.")
  timePrecisionMode?: PostgreSqlTimePrecisionMode;

  @doc("A Boolean value that specifies whether the connector enable delta flow feature.")
  isDeltaFlowEnabled?: boolean;
}
