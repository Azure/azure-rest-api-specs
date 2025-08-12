import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.MongoDb;

@doc("Specifies the criteria for performing a snapshot when the connector starts.")
union MongoDbSnapshotMode {
  @doc("When the connector starts, it performs an initial database snapshot. After the snapshot completes, the connector begins to stream event records for subsequent database changes.")
  Initial: "Initial",

  @doc("The connector performs a database a snapshot only when no offsets have been recorded for the logical server name. After the snapshot completes, the connector stops. It does not transition to streaming event records for subsequent database changes.")
  InitialOnly: "InitialOnly",

  @doc("The connector runs a snapshot that captures the structure of all relevant tables, but it does not create READ events to represent the data set at the point of the connector’s start-up.")
  NoData: "NoData",

  string,
}

@doc("MongoDbConnector tracks a MongoDb replica set or a MongoDb shared cluster for document changes in databases and collections, recording those changes as events in Kafka topics")
model MongoDbSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of MongoDbSourceConnector")
  connectorType: Models.Connector.ConnectorType.MongoDbSource;

  @doc("Server address of MongoDb Server.")
  server: string;

  @doc("Username for MongoDb.")
  username: string;

  @doc("Password for MongoDb.")
  @secret
  password: string;

  @doc("Name of the MongoDb replica set.")
  replicaSet?: string;

  @doc("Enables or disables TLS/SSL for the connection.")
  enableTls?: boolean;

  @doc("A comma-separated list of regular expressions that match database names to be monitored. By default, all databases are monitored.")
  databaseIncludeList?: string;

  @doc("A comma-separated list of regular expressions that match database names to be excluded from monitoring.")
  databaseExcludeList?: string;

  @doc("A comma-separated list of regular expressions that match fully-qualified namespaces for MongoDb collections to be monitored. By default, the connector monitors all collections except those in the local and admin databases.")
  collectionIncludeList?: string;

  @doc("A comma-separated list of regular expressions that match fully-qualified namespaces for MongoDb collections to be excluded from monitoring.")
  collectionExcludeList?: string;

  @doc("Specifies the criteria for performing a snapshot when the connector starts.")
  snapshotMode?: MongoDbSnapshotMode;

  @doc("Specifies the maximum number of documents that should be read in one go from each collection while taking a snapshot.")
  snapshotFetchSize?: int32;
}
