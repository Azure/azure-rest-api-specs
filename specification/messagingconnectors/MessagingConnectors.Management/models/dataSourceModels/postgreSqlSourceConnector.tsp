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

@doc("SnapshotSelectStatementOverride Item")
model PostgreSqlSnapshotSelectStatementOverrideItem {
  @doc("Table name")
  tableName: string;

  @doc("select statement")
  selectStatement: string;
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
}
