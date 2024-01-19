import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsOrg.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityDevOps;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a monitored AzureDevOps Project resource for a given ID.")
  @operationId("AzureDevOpsProject_Get")
  get is ArmResourceRead<AzureDevOpsProject>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates an Azure DevOps Project.")
  @operationId("AzureDevOpsProject_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AzureDevOpsProject,
    BaseParameters<AzureDevOpsProject>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update monitored AzureDevOps Project details.")
  @operationId("AzureDevOpsProject_Update")
  update is ArmCustomPatchAsync<AzureDevOpsProject, AzureDevOpsProject>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsProject_List")
  list is ArmResourceListByParent<AzureDevOpsProject>;
}

@@projectedName(AzureDevOpsProjects.createOrUpdate::parameters.resource,
  "json",
  "azureDevOpsProject"
);
@@extension(AzureDevOpsProjects.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "azureDevOpsProject"
);
@@doc(AzureDevOpsProjects.createOrUpdate::parameters.resource,
  "Azure DevOps Org resource payload."
);
@@projectedName(AzureDevOpsProjects.update::parameters.properties,
  "json",
  "azureDevOpsProject"
);
@@extension(AzureDevOpsProjects.update::parameters.properties,
  "x-ms-client-name",
  "azureDevOpsProject"
);
@@doc(AzureDevOpsProjects.update::parameters.properties,
  "Azure DevOps Org resource payload."
);
