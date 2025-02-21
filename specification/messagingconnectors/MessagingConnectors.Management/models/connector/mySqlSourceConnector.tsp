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

  @doc("Snapshot Locking Mode.")
  snapshotLockingMode?: SnapshotLockingModeForMysql;
}
