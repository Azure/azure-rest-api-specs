import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.Oracle;

@doc("Type of SnapshotLockingMode")
union OracleSnapshotLockingMode {
  @doc("None type")
  None: "None",

  @doc("Shared type")
  Shared: "Shared",

  string,
}

@doc("Type of SnapshotMode")
union OracleSnapshotMode {
  @doc("When the connector starts, it performs an initial database snapshot. After the snapshot completes, the connector begins to stream event records for subsequent database changes.")
  Initial: "Initial",

  @doc("The connector performs a database a snapshot only when no offsets have been recorded for the logical server name. After the snapshot completes, the connector stops. It does not transition to streaming event records for subsequent database changes.")
  InitialOnly: "InitialOnly",

  @doc("The connector runs a snapshot that captures the structure of all relevant tables, but it does not create READ events to represent the data set at the point of the connector’s start-up.")
  NoData: "NoData",

  string,
}

@doc("Enum DecimalHandlingMode for Cdc")
union OracleDecimalHandlingMode {
  @doc("The Precise mode.")
  PreciseMode: "Precise",

  @doc("The Double mode.")
  DoubleMode: "Double",

  @doc("The String mode.")
  StringMode: "String",

  string,
}

@doc("Configuration for OracleSourceConnector")
model OracleSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of OracleSourceConnector")
  connectorType: Models.Connector.ConnectorType.OracleSource;

  @doc("Specifies the raw database JDBC URL. Valid values include raw TNS names and RAC connection strings.")
  databaseUrl: string;

  @doc("DatabaseName for Oracle DB.")
  databaseName: string;

  @doc("Username for Oracle DB.")
  username: string;

  @doc("Password for Oracle DB.")
  @secret
  password: string;

  @doc("The name of the Oracle pluggable database that the connector captures changes from. Used in container database (CDB) installations only.")
  databasePdbName?: string;

  @doc("Snapshot Locking Mode.")
  oracleSnapshotLockingMode?: OracleSnapshotLockingMode;

  @doc("Snapshot Mode.")
  oracleSnapshotMode?: OracleSnapshotMode;

  @doc("Tables used as source, comma-separated table name list or regular expressions")
  tableIncludeList?: string;

  @doc("Tables to be excluded, comma-separated table name list or regular expressions")
  tableExcludeList?: string;

  @doc("Columns to be included, comma-separated table name list or regular expressions")
  columnIncludeList?: string;

  @doc("Columns to be excluded, comma-separated table name list or regular expressions")
  columnExcludeList?: string;

  @doc("Handling mode for DECIMAL and NUMERIC.")
  oracleDecimalHandlingMode?: OracleDecimalHandlingMode;

  @doc("A Boolean value that specifies whether the connector records schema structures from all tables in a schema or database, or only from tables that are designated for capture.")
  isStoreOnlyCapturedTablesDdl?: boolean;

  @doc("A Boolean value that specifies whether the connector should publish changes in the database schema to a Kafka topic with the same name as the database server ID.")
  includeSchemaChanges?: boolean;
}
