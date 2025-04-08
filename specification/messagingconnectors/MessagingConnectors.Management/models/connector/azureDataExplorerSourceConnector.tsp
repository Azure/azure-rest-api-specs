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

@doc("Configuration for AzureDataExplorerSourceConnector")
model AzureDataExplorerSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of AzureDataExplorerSourceConnector")
  connectorType: ConnectorType.AzureDataExplorerSource;

  @doc("Url of AzureDataExplorer cluster.")
  clusterUrl: string;

  @doc("Database name for AzureDataExplorer.")
  database: string;

  @doc("AzureDataExplorer table names use commas to separate multiple tables.")
  tableNames: string;

  @doc("Auth of AzureDataExplorer")
  authentication: Authentication;
}
