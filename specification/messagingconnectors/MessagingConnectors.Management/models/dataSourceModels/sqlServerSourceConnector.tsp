import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.SqlServer;

@doc("Enum DecimalHandlingMode for SqlServer")
union SqlServerDecimalHandlingMode {
  @doc("The Precise mode.")
  PreciseMode: "Precise",

  @doc("The Double mode.")
  DoubleMode: "Double",

  @doc("The String mode.")
  StringMode: "String",

  string,
}

@doc("Enum SkippedOperationsMode for SqlServer")
union SqlServerSkippedOperationsMode {
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
union SqlServerSnapshotMode {
  @doc("The connector performs a database snapshot as described in the default workflow for creating an initial snapshot. After the snapshot completes, the connector begins to stream event records for subsequent database changes.")
  Initial: "Initial",

  @doc("The connector performs a database snapshot and stops before streaming any change event records, not allowing any subsequent change events to be captured.")
  InitialOnly: "InitialOnly",

  @doc("The connector captures the structure of all relevant tables, performing all the steps described in the default snapshot workflow, except that it does not create READ events to represent the data set at the point of the connector’s start-up (Step 7.b).")
  NoData: "NoData",

  string,
}

@doc("SnapshotSelectStatementOverride Item")
model SqlServerSnapshotSelectStatementOverrideItem {
  @doc("Table name")
  tableName: string;

  @doc("select statement")
  selectStatement: string;
}

@doc("Configuration for SqlServerSourceConnector")
model SqlServerSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of SqlServerSourceConnector")
  connectorType: Models.Connector.ConnectorType.SqlServerSource;

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

  @doc("Tables used as source.")
  tableIncludeList?: string;

  @doc("Tables to be excluded.")
  tableExcludeList?: string;

  @doc("Columns to be included.")
  columnIncludeList?: string;

  @doc("Columns to be excluded.")
  columnExcludeList?: string;

  @doc("Handling mode for DECIMAL and NUMERIC.")
  decimalHandlingMode?: SqlServerDecimalHandlingMode;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Select table rows to include in the snapshot.")
  snapshotSelectStatementOverrides?: SqlServerSnapshotSelectStatementOverrideItem[];

  @doc("Operation types to be skipped.")
  skippedOperations?: SqlServerSkippedOperationsMode[];

  @doc("Whether read replica only.")
  isReadOnlyReplica?: boolean;

  @doc("Specifies the criteria for running a snapshot when the connector starts.")
  snapshotMode?: SqlServerSnapshotMode;

  @doc("A Boolean value that specifies whether the connector records schema structures from all tables in a schema or database, or only from tables that are designated for capture.")
  isStoreOnlyCapturedTablesDdl?: boolean;

  @doc("A Boolean value that specifies whether the connector enable delta flow feature.")
  isDeltaFlowEnabled?: boolean;

  @doc("A Boolean value that specifies whether the connector should publish changes in the database schema to a Kafka topic with the same name as the database server ID.")
  includeSchemaChanges?: boolean;
}
