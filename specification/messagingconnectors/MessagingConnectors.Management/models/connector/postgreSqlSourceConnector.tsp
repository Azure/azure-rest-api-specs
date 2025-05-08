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

@doc("Type of PublicationAutocreateMode")
union PublicationAutocreateModes {
  @doc("The AllTables mode.")
  AllTables: "AllTables",

  @doc("The Disabled mode.")
  Disabled: "Disabled",

  @doc("The Filtered mode.")
  Filtered: "Filtered",

  string,
}

@doc("Enum DecimalHandlingMode for Cdc")
union DecimalHandlingMode {
  @doc("The Precise mode.")
  PreciseMode: "Precise",

  @doc("The Double mode.")
  DoubleMode: "Double",

  @doc("The String mode.")
  StringMode: "String",

  string,
}

@doc("Enum SkippedOperationsMode for Cdc")
union SkippedOperationsMode {
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
model SnapshotSelectStatementOverrideItem {
  @doc("Table name")
  tableName: string;

  @doc("select statement")
  selectStatement: string;
}

@doc("Configuration for PostgreSqlSourceConnector")
model PostgreSqlSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of PostgreSqlSourceConnector")
  connectorType: ConnectorType.PostgreSqlSource;

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
  decimalHandlingMode?: DecimalHandlingMode;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Select table rows to include in the snapshot.")
  snapshotSelectStatementOverrides?: SnapshotSelectStatementOverrideItem[];

  @doc("Publication creation mode.")
  publicationAutocreateMode?: PublicationAutocreateModes;

  @doc("Operation types to be skipped.")
  skippedOperations?: SkippedOperationsMode[];

  @doc("Publication Name of Postgre.")
  publicationName?: string;
}
