import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";
import "./models.tsp";
import "./ConnectionHub.tsp";
import "./GitHubConnection.tsp";
import "./GitHubIssue.tsp";

using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@armResourceOperations
interface ConnectionHubs {
  @summary("Get a Connection Hub")
  get is ArmResourceRead<ConnectionHub>;

  @summary("Create or update a Connection Hub")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConnectionHub>;

  @summary("Update a Connection Hub")
  update is ArmResourcePatchSync<ConnectionHub, ConnectionHubProperties>;

  @summary("Delete a Connection Hub")
  delete is ArmResourceDeleteWithoutOkAsync<ConnectionHub>;

  @summary("List Connection Hubs by resource group")
  listByResourceGroup is ArmResourceListByParent<ConnectionHub>;

  @summary("List Connection Hubs by subscription")
  listBySubscription is ArmListBySubscription<ConnectionHub>;
}

@armResourceOperations
interface GitHubConnections {
  @summary("Get a GitHub Connection")
  get is ArmResourceRead<GitHubConnection>;

  @summary("Create or update a GitHub Connection")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GitHubConnection>;

  @summary("Delete a GitHub Connection")
  delete is ArmResourceDeleteWithoutOkAsync<GitHubConnection>;

  @summary("List GitHub Connections by resource group.")
  listByConnectionHub is ArmResourceListByParent<GitHubConnection>;
}

@armResourceOperations
interface GitHubIssues {
  @summary("Get a GitHub Issue")
  get is ArmResourceRead<GitHubIssue>;

  @summary("Create or update a GitHub Issue")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GitHubIssue>;

  @summary("Delete a GitHub Issue")
  delete is ArmResourceDeleteWithoutOkAsync<GitHubIssue>;

  @summary("List GitHub Issues by GitHub Connection")
  listByGitHubConnection is ArmResourceListByParent<GitHubIssue>;
}
