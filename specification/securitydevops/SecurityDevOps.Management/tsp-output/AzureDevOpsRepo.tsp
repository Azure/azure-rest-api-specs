import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsProject.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityDevOps;
@doc("Azure DevOps Repo Proxy Resource.")
@parentResource(AzureDevOpsProject)
model AzureDevOpsRepo is ProxyResource<AzureDevOpsRepoProperties> {
  @doc("Name of the AzureDevOps Repo.")
  @key("azureDevOpsRepoName")
  @segment("repos")
  name: string;
}

@armResourceOperations
interface AzureDevOpsRepo {
  @doc("Returns a monitored AzureDevOps Project resource for a given ID.")
  get is ArmResourceRead<AzureDevOpsRepo>;
  @doc("Updates an Azure DevOps Repo.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureDevOpsRepo>;
  @doc("Update monitored AzureDevOps Project details.")
  update is ArmCustomPatchAsync<AzureDevOpsRepo, AzureDevOpsRepo>;

  list is ArmResourceListByParent<AzureDevOpsRepo>;
}
