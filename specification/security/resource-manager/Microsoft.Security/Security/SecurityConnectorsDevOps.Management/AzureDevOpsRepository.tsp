import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsProject.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Azure DevOps Repository resource.
 */
@parentResource(AzureDevOpsProject)
model AzureDevOpsRepository
  is Azure.ResourceManager.ProxyResource<AzureDevOpsRepositoryProperties> {
  ...ResourceNameParameter<
    Resource = AzureDevOpsRepository,
    KeyName = "repoName",
    SegmentName = "repos",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AzureDevOpsRepositories {
  /**
   * Returns a monitored Azure DevOps repository resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AzureDevOpsRepos_Get")
  get is ArmResourceRead<AzureDevOpsRepository>;

  /**
   * Creates or updates a monitored Azure DevOps repository resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AzureDevOpsRepos_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AzureDevOpsRepository>;

  /**
   * Updates a monitored Azure DevOps repository resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("AzureDevOpsRepos_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AzureDevOpsRepository,
    PatchModel = AzureDevOpsRepository,
    Response = ArmResponse<AzureDevOpsRepository> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = AzureDevOpsRepository> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AzureDevOpsRepository;
    })
  >;

  /**
   * Returns a list of Azure DevOps repositories onboarded to the connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AzureDevOpsRepos_List")
  list is ArmResourceListByParent<
    AzureDevOpsRepository,
    Response = ArmResponse<AzureDevOpsRepositoryListResponse>
  >;
}

@@doc(AzureDevOpsRepository.name, "The repository name.");
@@doc(AzureDevOpsRepository.properties, "Azure DevOps Repository properties.");
@@doc(AzureDevOpsRepositories.createOrUpdate::parameters.resource,
  "The Azure DevOps repository resource payload."
);
@@doc(AzureDevOpsRepositories.update::parameters.properties,
  "The Azure DevOps repository resource payload."
);
