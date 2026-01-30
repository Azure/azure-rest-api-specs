import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.DeltaChangeFeed;

@doc("DeltaChangeFeedConnector tracks changes on the Mirror Db Delta Tables recording those changes as events in Kafka topics")
model DeltaChangeFeedSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of DeltaChangeFeedSourceConnector")
  connectorType: Models.Connector.ConnectorType.DeltaChangeFeedSource;

  @doc("Authentication for Delta Change Feed - OAuth.")
  authentication: Models.Auth.Authentication;

  @doc("OneLake DFS Global Endpoint")
  oneLakeDfsGlobalEndpoint: string;

  @doc("MirrorDb Workspace Id.")
  workspaceId: string;

  @doc("ArtifactId of Mirror Db artifact.")
  artifactId: string;

  @doc("A comma-separated list that match fully-qualified tables or path for DeltaChangeFeed collections to be monitored. By default, all tables are monitored. Expectation: containername.tablename")
  mirrorDbTablesList: string;

  @doc("Specifies the maximum number of documents that should be read in one go from each collection while taking a snapshot.")
  snapshotFetchSize?: int32;
}
