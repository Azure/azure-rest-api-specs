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

@doc("Mode of DecimalHandling")
union DecimalHandlingModes {
  @doc("precise mode")
  Precise: "Precise",

  @doc("Double mode")
  Double: "Double",

  @doc("Double mode")
  String: "String",

  string,
}

@doc("Mode of PublicationAutocreateMode")
union PublicationAutocreateModes {
  @doc("AllTables mode")
  AllTables: "AllTables",

  @doc("Disabled mode")
  Disabled: "Disabled",

  @doc("Filtered mode")
  Filtered: "Filtered",

  string,
}

@doc("Mode of SkippedOperationsMode")
union SkippedOperationsModes {
  @doc("InsertOrCreate mode")
  InsertOrCreate: "InsertOrCreate",

  @doc("Update mode")
  Update: "Update",

  @doc("Delete mode")
  Delete: "Delete",

  @doc("Truncate mode")
  Truncate: "Truncate",

  @doc("None mode")
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

  @doc("Tables to be included, regex supported.")
  tableIncludeList?: string;

  @doc("Tables to be excluded, regex supported.")
  tableExcludeList?: string;

  @doc("Columns to be included, regex supported.")
  columnIncludeList?: string;

  @doc("Columns to be excluded, regex supported.")
  columnExcludeList?: string;

  @doc("Handling mode for DECIMAL and NUMERIC.")
  decimalHandlingMode?: DecimalHandlingModes;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Select table rows to include in the snapshot.")
  snapshotSelectStatementOverrides?: SnapshotSelectStatementOverrideItem[];

  @doc("Publication creation mode.")
  publicationAutocreateMode?: PublicationAutocreateModes;

  @doc("Operation types to be skipped.")
  skippedOperations?: SkippedOperationsModes[];

  @doc("Publication Name of Postgre.")
  publicationName?: string;
}
