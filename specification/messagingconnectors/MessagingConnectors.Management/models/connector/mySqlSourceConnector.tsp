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

@doc("Type of SnapshotLockingMode")
union SnapshotLockingModeForMysql {
  @doc("Minimal type")
  Minimal: "Minimal",

  @doc("Extended type")
  Extended: "Extended",

  @doc("None type")
  None: "None",

  string,
}

@doc("Configuration for MySqlSourceConnector")
model MySqlSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of MySqlSourceConnector")
  connectorType: ConnectorType.MySqlSource;

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

  @doc("Tables to be included, regex supported.")
  tableIncludeList?: string;

  @doc("Tables to be excluded, regex supported.")
  tableExcludeList?: string;

  @doc("Snapshot Locking Mode.")
  snapshotLockingMode?: SnapshotLockingModeForMysql;

  @doc("Columns to be included, regex supported.")
  columnIncludeList?: string;

  @doc("Columns to be excluded, regex supported.")
  columnExcludeList?: string;

  @doc("Handling mode for DECIMAL and NUMERIC.")
  decimalHandlingMode?: DecimalHandlingModes;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Select table rows to include in the snapshot.")
  snapshotSelectStatementOverrides?: SnapshotSelectStatementOverrideItem[];

  @doc("Operation types to be skipped.")
  skippedOperations?: SkippedOperationsModes[];
}
