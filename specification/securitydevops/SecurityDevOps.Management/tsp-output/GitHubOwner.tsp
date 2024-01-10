import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GitHubConnector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityDevOps;
@doc("GitHub repo owner Proxy Resource.")
@parentResource(GitHubConnector)
model GitHubOwner is ProxyResource<GitHubOwnerProperties> {
  @doc("Name of the GitHub Owner.")
  @key("gitHubOwnerName")
  @segment("owners")
  name: string;
}

@armResourceOperations
@projectedName("client", "GitHubOwner")
interface GitHubOwners_GitHubOwner {
  @doc("Returns a monitored GitHub repository.")
  get is ArmResourceRead<GitHubOwner>;

  @doc("Create or update a monitored GitHub owner.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GitHubOwner>;

  @doc("Patch a monitored GitHub repository.")
  update is ArmCustomPatchAsync<GitHubOwner, GitHubOwner>;

  @doc("Returns a list of monitored GitHub owners.")
  list is ArmResourceListByParent<GitHubOwner>;
}
