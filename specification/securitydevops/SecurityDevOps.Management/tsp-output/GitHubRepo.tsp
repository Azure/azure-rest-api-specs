import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GitHubOwner.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityDevOps;
@doc("GitHub repo Proxy Resource.")
@parentResource(GitHubOwner)
model GitHubRepo is ProxyResource<GitHubRepoProperties> {
  @doc("Name of the GitHub Repo.")
  @key("gitHubRepoName")
  @segment("repos")
  name: string;
}

@armResourceOperations
@projectedName("client", "GitHubRepo")
interface GitHubRepos_GitHubRepo {
  @doc("Returns a monitored GitHub repository.")
  get is ArmResourceRead<GitHubRepo>;

  @doc("Create or update a monitored GitHub repository.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GitHubRepo>;

  @doc("Patch a monitored GitHub repository.")
  update is ArmCustomPatchAsync<GitHubRepo, GitHubRepo>;

  @doc("Returns a list of monitored GitHub repositories.")
  list is ArmResourceListByParent<GitHubRepo>;
}
