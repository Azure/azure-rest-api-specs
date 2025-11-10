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

@parentResource(GitHubConnection)
@doc("GitHub Issue resource.")
model GitHubIssue is ProxyResource<GitHubIssueProperties> {
  @doc("The GitHub issue name.")
  @key("githubIssueId")
  @segment("githubIssues")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9]$")
  name: string;
}

@doc("GitHub Issue properties.")
model GitHubIssueProperties {
  @doc("GitHub Issue status.")
  @visibility(Lifecycle.Read)
  status?: GitHubIssueStatus;

  @doc("GitHub Issue title.")
  title: string;

  @doc("GitHub Issue body.")
  body: string;

  @doc("GitHub Issue URL.")
  @visibility(Lifecycle.Read)
  githubIssueUrl?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
