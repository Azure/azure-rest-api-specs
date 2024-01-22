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
/**
 * Azure DevOps Project Proxy Resource.
 */
@parentResource(AzureDevOpsOrg)
model AzureDevOpsProject is ProxyResource<AzureDevOpsProjectProperties> {
  /**
   * Name of the AzureDevOps Project.
   */
  @path
  @key("azureDevOpsProjectName")
  @segment("projects")
  name: string;
}

@armResourceOperations
interface AzureDevOpsProjects {
  /**
   * Returns a monitored AzureDevOps Project resource for a given ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsProject_Get")
  get is ArmResourceRead<AzureDevOpsProject>;

  /**
   * Creates or updates an Azure DevOps Project.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsProject_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AzureDevOpsProject,
    BaseParameters<AzureDevOpsProject>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update monitored AzureDevOps Project details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
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
