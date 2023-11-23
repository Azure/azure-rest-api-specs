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
  @path
  @key("gitHubOwnerName")
  @segment("owners")
  name: string;
}

@armResourceOperations
interface GitHubOwners {
  @doc("Returns a monitored GitHub repository.")
  get is ArmResourceRead<GitHubOwner>;
  @doc("Create or update a monitored GitHub owner.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GitHubOwner>;
  @doc("Patch a monitored GitHub repository.")
  update is ArmResourcePatchAsync<GitHubOwner, GitHubOwnerProperties>;
  @doc("Returns a list of monitored GitHub owners.")
  list is ArmResourceListByParent<GitHubOwner>;
}
