import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * DevOps Configuration resource.
 */
@singleton("default")
model DevOpsConfiguration
  is Azure.ResourceManager.ProxyResource<DevOpsConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = DevOpsConfiguration,
    KeyName = "devop",
    SegmentName = "devops",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DevOpsConfigurations {
  /**
   * Gets a DevOps Configuration.
   */
  get is ArmResourceRead<DevOpsConfiguration>;

  /**
   * Creates or updates a DevOps Configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DevOpsConfiguration,
    Response = ArmResourceUpdatedResponse<DevOpsConfiguration> | ArmResourceCreatedResponse<DevOpsConfiguration> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DevOpsConfiguration;
    })
  >;

  /**
   * Updates a DevOps Configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DevOpsConfiguration,
    PatchModel = DevOpsConfiguration,
    Response = ArmResponse<DevOpsConfiguration> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = DevOpsConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: DevOpsConfiguration;
    })
  >;

  /**
   * Deletes a DevOps Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DevOpsConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List DevOps Configurations.
   */
  list is ArmResourceListByParent<
    DevOpsConfiguration,
    Response = ArmResponse<DevOpsConfigurationListResponse>
  >;

  /**
   * Returns a list of all Azure DevOps organizations accessible by the user token consumed by the connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AzureDevOpsOrgs_ListAvailable")
  @list
  @action("listAvailableAzureDevOpsOrgs")
  listAvailable is ArmResourceActionSync<
    DevOpsConfiguration,
    void,
    ArmResponse<AzureDevOpsOrgListResponse>
  >;

  /**
   * Returns a list of all GitHub owners accessible by the user token consumed by the connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GitHubOwners_ListAvailable")
  @list
  @action("listAvailableGitHubOwners")
  gitHubOwnersListAvailable is ArmResourceActionSync<
    DevOpsConfiguration,
    void,
    ArmResponse<GitHubOwnerListResponse>
  >;

  /**
   * Returns a list of all GitLab groups accessible by the user token consumed by the connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GitLabGroups_ListAvailable")
  @list
  @action("listAvailableGitLabGroups")
  gitLabGroupsListAvailable is ArmResourceActionSync<
    DevOpsConfiguration,
    void,
    ArmResponse<GitLabGroupListResponse>
  >;

  /**
   * Get devops long running operation result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevOpsOperationResults_Get")
  @get
  @action("{operationResultId}")
  devOpsOperationResultsGet is ArmResourceActionSync<
    DevOpsConfiguration,
    void,
    ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>,
    Parameters = {
      /**
       * The operation result Id.
       */
      @path
      operationResultId: string;
    }
  >;
}

@@doc(DevOpsConfiguration.name, "");
@@doc(DevOpsConfiguration.properties, "DevOps Configuration properties.");
@@doc(DevOpsConfigurations.createOrUpdate::parameters.resource,
  "The DevOps configuration resource payload."
);
@@doc(DevOpsConfigurations.update::parameters.properties,
  "The DevOps configuration resource payload."
);
