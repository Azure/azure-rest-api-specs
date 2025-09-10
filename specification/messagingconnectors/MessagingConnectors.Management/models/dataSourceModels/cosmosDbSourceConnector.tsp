import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.CosmosDb;

@doc("Enum of the OffsetPolicy for CosmosDB connector")
union CosmosDbOffsetPolicy {
  @doc("use the latest (most recent) source offset")
  UseLatestSourceOffset: "UseLatestSourceOffset",

  @doc("use the earliest recorded offset")
  UseEarliestRecordedOffset: "UseEarliestRecordedOffset",

  string,
}

@doc("Configuration for CosmosDbSourceConnector")
model CosmosDbSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of CosmosDbSourceConnector")
  connectorType: Models.Connector.ConnectorType.CosmosDbSource;

  @doc("PollIntervalInMs policy.")
  pollIntervalInMs: int32;

  @doc("Endpoint of CosmosDB.")
  cosmosEndpoint: string;

  @doc("DatabaseName for CosmosDB server.")
  databaseName: string;

  @doc("Container for CosmosDB server.")
  container: string;

  @doc("masterKey for CosmosDB server.")
  @secret
  masterKey: string;

  @doc("useLatestOffset policy")
  offsetPolicy: CosmosDbOffsetPolicy;
}
