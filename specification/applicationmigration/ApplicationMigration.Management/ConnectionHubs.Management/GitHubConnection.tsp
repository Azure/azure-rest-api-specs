import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@parentResource(ConnectionHub)
@doc("GitHub Connection resource.")
model GitHubConnection is ProxyResource<GitHubConnectionProperties> {
  @doc("The connection name.")
  @key("connectionId")
  @segment("githubConnections")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9]$")
  name: string;
}

@doc("GitHub Connection properties.")
model GitHubConnectionProperties {
  @doc("GitHub App ID")
  appId: string;

  @doc("Customer key vault url which stores private key of GitHub App.")
  tokenSecretId: string;

  @doc("GitHub Installation ID.")
  installationId: string;

  @doc("List of repositories.")
  @identifiers(#["url"])
  repos: Repository[];

  @doc("Connection status.")
  @visibility(Lifecycle.Read)
  status?: ConnectionStatus;

  @doc("ID of the GitHub Webhook created.")
  @visibility(Lifecycle.Read)
  webhookId?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
