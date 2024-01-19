import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsProject.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityDevOps;
@doc("Azure DevOps Repo Proxy Resource.")
@parentResource(AzureDevOpsProject)
model AzureDevOpsRepo is ProxyResource<AzureDevOpsRepoProperties> {
  @doc("Name of the AzureDevOps Repo.")
  @path
  @key("azureDevOpsRepoName")
  @segment("repos")
  name: string;
}

@armResourceOperations
interface AzureDevOpsRepos {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a monitored AzureDevOps Project resource for a given ID.")
  @operationId("AzureDevOpsRepo_Get")
  get is ArmResourceRead<AzureDevOpsRepo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an Azure DevOps Repo.")
  @operationId("AzureDevOpsRepo_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AzureDevOpsRepo,
    BaseParameters<AzureDevOpsRepo>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update monitored AzureDevOps Project details.")
  @operationId("AzureDevOpsRepo_Update")
  update is ArmCustomPatchAsync<AzureDevOpsRepo, AzureDevOpsRepo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsRepo_List")
  list is ArmResourceListByParent<AzureDevOpsRepo>;
}

@@projectedName(AzureDevOpsRepos.createOrUpdate::parameters.resource,
  "json",
  "azureDevOpsRepo"
);
@@extension(AzureDevOpsRepos.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "azureDevOpsRepo"
);
@@doc(AzureDevOpsRepos.createOrUpdate::parameters.resource,
  "Azure DevOps Repo resource payload."
);
@@projectedName(AzureDevOpsRepos.update::parameters.properties,
  "json",
  "azureDevOpsRepo"
);
@@extension(AzureDevOpsRepos.update::parameters.properties,
  "x-ms-client-name",
  "azureDevOpsRepo"
);
@@doc(AzureDevOpsRepos.update::parameters.properties,
  "Azure DevOps Org resource payload."
);
