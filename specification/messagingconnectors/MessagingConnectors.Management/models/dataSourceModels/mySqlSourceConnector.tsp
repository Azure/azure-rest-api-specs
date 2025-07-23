import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.MySql;

@doc("Type of SnapshotLockingMode")
union MySqlSnapshotLockingMode {
  @doc("None type")
  None: "None",

  @doc("Minimal type")
  Minimal: "Minimal",

  @doc("Extended type")
  Extended: "Extended",

  string,
}

@doc("Enum DecimalHandlingMode for mysql")
union MySqlDecimalHandlingMode {
  @doc("The Precise mode.")
  PreciseMode: "Precise",

  @doc("The Double mode.")
  DoubleMode: "Double",

  @doc("The String mode.")
  StringMode: "String",

  string,
}

@doc("SnapshotSelectStatementOverride Item")
model MySqlSnapshotSelectStatementOverrideItem {
  @doc("Table name")
  tableName: string;

  @doc("select statement")
  selectStatement: string;
}

@doc("Enum SkippedOperationsMode for mysql")
union MySqlSkippedOperationsMode {
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
union MySqlSnapshotMode {
  @doc("The connector runs a snapshot only when no offsets have been recorded for the logical server name, or if it detects that an earlier snapshot failed to complete. After the snapshot completes, the connector begins to stream event records for subsequent database changes.")
  Initial: "Initial",

  @doc("The connector runs a snapshot only when no offsets have been recorded for the logical server name. After the snapshot completes, the connector stops. It does not transition to streaming to read change events from the binlog.")
  InitialOnly: "InitialOnly",

  @doc("The connector runs a snapshot that captures only the schema, but not any table data. Set this option if you do not need the topics to contain a consistent snapshot of the data, but you want to capture any schema changes that were applied after the last connector restart.")
  NoData: "NoData",

  string,
}

@doc("Configuration for MySqlSourceConnector")
model MySqlSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of MySqlSourceConnector")
  connectorType: Models.Connector.ConnectorType.MySqlSource;

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

  @doc("Snapshot Locking Mode.")
  snapshotLockingMode?: MySqlSnapshotLockingMode;

  @doc("Tables used as source.")
  tableIncludeList?: string;

  @doc("Tables to be excluded.")
  tableExcludeList?: string;

  @doc("Columns to be included.")
  columnIncludeList?: string;

  @doc("Columns to be excluded.")
  columnExcludeList?: string;

  @doc("Handling mode for DECIMAL and NUMERIC.")
  decimalHandlingMode?: MySqlDecimalHandlingMode;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Select table rows to include in the snapshot.")
  snapshotSelectStatementOverrides?: MySqlSnapshotSelectStatementOverrideItem[];

  @doc("Operation types to be skipped.")
  skippedOperations?: MySqlSkippedOperationsMode[];

  @doc("Specifies the criteria for running a snapshot when the connector starts.")
  snapshotMode?: MySqlSnapshotMode;
}
