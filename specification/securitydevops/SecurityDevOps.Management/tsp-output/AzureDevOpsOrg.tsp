import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsConnector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityDevOps;
@doc("Azure DevOps Org Proxy Resource.")
@parentResource(AzureDevOpsConnector)
model AzureDevOpsOrg is ProxyResource<AzureDevOpsOrgProperties> {
  @doc("Name of the AzureDevOps Org.")
  @key("azureDevOpsOrgName")
  @segment("orgs")
  name: string;
}

@armResourceOperations
interface AzureDevOpsOrg {
  @doc("Returns a monitored AzureDevOps Org resource for a given ID.")
  get is ArmResourceRead<AzureDevOpsOrg>;
  @doc("Creates or updates an Azure DevOps Org.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureDevOpsOrg>;
  @doc("Update monitored AzureDevOps Org details.")
  update is ArmCustomPatchAsync<AzureDevOpsOrg, AzureDevOpsOrg>;

  list is ArmResourceListByParent<AzureDevOpsOrg>;
}
