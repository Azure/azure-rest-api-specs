import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsOrg.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Azure DevOps Project resource.
 */
@parentResource(AzureDevOpsOrg)
model AzureDevOpsProject
  is Azure.ResourceManager.ProxyResource<AzureDevOpsProjectProperties> {
  ...ResourceNameParameter<
    Resource = AzureDevOpsProject,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AzureDevOpsProjects {
  /**
   * Returns a monitored Azure DevOps project resource.
   */
  get is ArmResourceRead<AzureDevOpsProject>;

  /**
   * Creates or updates a monitored Azure DevOps project resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AzureDevOpsProject>;

  /**
   * Updates a monitored Azure DevOps project resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AzureDevOpsProject,
    PatchModel = AzureDevOpsProject,
    Response = ArmResponse<AzureDevOpsProject> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = AzureDevOpsProject> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AzureDevOpsProject;
    })
  >;

  /**
   * Returns a list of Azure DevOps projects onboarded to the connector.
   */
  list is ArmResourceListByParent<
    AzureDevOpsProject,
    Response = ArmResponse<AzureDevOpsProjectListResponse>
  >;
}

@@doc(AzureDevOpsProject.name, "The project name.");
@@doc(AzureDevOpsProject.properties, "Azure DevOps Project properties.");
@@doc(AzureDevOpsProjects.createOrUpdate::parameters.resource,
  "The Azure DevOps project resource payload."
);
@@doc(AzureDevOpsProjects.update::parameters.properties,
  "The Azure DevOps project resource payload."
);
