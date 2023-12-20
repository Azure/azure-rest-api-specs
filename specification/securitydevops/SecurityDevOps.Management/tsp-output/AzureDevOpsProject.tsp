import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsOrg.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityDevOps;
@doc("Azure DevOps Project Proxy Resource.")
@parentResource(AzureDevOpsOrg)
model AzureDevOpsProject is ProxyResource<AzureDevOpsProjectProperties> {
  @doc("Name of the AzureDevOps Project.")
  @path
  @key("azureDevOpsProjectName")
  @segment("projects")
  name: string;
}

@armResourceOperations
interface AzureDevOpsProjects {
  @doc("Returns a monitored AzureDevOps Project resource for a given ID.")
  get is ArmResourceRead<AzureDevOpsProject>;
  @doc("Creates or updates an Azure DevOps Project.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureDevOpsProject>;
  @doc("Update monitored AzureDevOps Project details.")
  update is ArmResourcePatchAsync<
    AzureDevOpsProject,
    AzureDevOpsProjectProperties
  >;

  list is ArmResourceListByParent<AzureDevOpsProject>;
}
