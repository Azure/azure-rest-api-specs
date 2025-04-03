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

@doc("Configuration for SqlServerSourceConnector")
model SqlServerSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of SqlServerSourceConnector")
  connectorType: ConnectorType.SqlServerSource;

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

  @doc("Operation types to be skipped.")
  skippedOperations?: SkippedOperationsModes[];

  @doc("Whether read replica only.")
  isReadOnlyReplica?: boolean;
}
