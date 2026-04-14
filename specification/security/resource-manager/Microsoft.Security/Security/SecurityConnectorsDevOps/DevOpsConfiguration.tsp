import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecurityConnectorsDevOpsAPI;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
alias DevOpsConfigurationOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";

    /** The security connector name. */
    @path
    @segment("securityConnectors")
    @key
    securityConnectorName: string;
  },
  {
    @path
    @segment("devops")
    @key
    devop: "default";
  }
>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
alias DevOpsOperationResultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";

    /** The security connector name. */
    @path
    @segment("securityConnectors")
    @key
    securityConnectorName: string;

    @path
    @segment("devops")
    @key
    devop: "default";
  },
  {
    @path
    @segment("operationResults")
    @key
    operationResultId: string;
  }
>;
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

@armResourceOperations(#{ omitTags: true })
interface DevOpsConfigurations {
  /**
   * Gets a DevOps Configuration.
   */
  @summary("Gets a DevOps Configuration.")
  @tag("DevOps")
  get is DevOpsConfigurationOps.Read<DevOpsConfiguration>;

  /**
   * Creates or updates a DevOps Configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates a DevOps Configuration.")
  @tag("DevOps")
  createOrUpdate is DevOpsConfigurationOps.CreateOrUpdateAsync<
    DevOpsConfiguration,
    Response = ArmResourceUpdatedResponse<DevOpsConfiguration> | ArmResourceCreatedResponse<DevOpsConfiguration> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader> & {
      @bodyRoot
      _: DevOpsConfiguration;
    })
  >;

  /**
   * Updates a DevOps Configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates a DevOps Configuration.")
  @tag("DevOps")
  @patch(#{ implicitOptionality: false })
  update is DevOpsConfigurationOps.CustomPatchAsync<
    DevOpsConfiguration,
    PatchModel = DevOpsConfiguration,
    Response = ArmResponse<DevOpsConfiguration> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = DevOpsConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: DevOpsConfiguration;
    })
  >;

  /**
   * Deletes a DevOps Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a DevOps Connector.")
  @tag("DevOps")
  delete is DevOpsConfigurationOps.DeleteWithoutOkAsync<
    DevOpsConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List DevOps Configurations.
   */
  @summary("List DevOps Configurations.")
  @tag("DevOps")
  list is DevOpsConfigurationOps.List<
    DevOpsConfiguration,
    Response = ArmResponse<DevOpsConfigurationListResponse>
  >;

  /**
   * Returns a list of all Azure DevOps organizations accessible by the user token consumed by the connector.
   */
  @summary("Returns a list of all Azure DevOps organizations accessible by the user token consumed by the connector.")
  @tag("DevOps")
  @action("listAvailableAzureDevOpsOrgs")
  listAvailable is DevOpsConfigurationOps.ActionSync<
    DevOpsConfiguration,
    void,
    ArmResponse<AzureDevOpsOrgListResponse>
  >;

  /**
   * Returns a list of all GitHub owners accessible by the user token consumed by the connector.
   */
  @summary("Returns a list of all GitHub owners accessible by the user token consumed by the connector.")
  @tag("DevOps")
  @action("listAvailableGitHubOwners")
  gitHubOwnersListAvailable is DevOpsConfigurationOps.ActionSync<
    DevOpsConfiguration,
    void,
    ArmResponse<GitHubOwnerListResponse>
  >;

  /**
   * Returns a list of all GitLab groups accessible by the user token consumed by the connector.
   */
  @summary("Returns a list of all GitLab groups accessible by the user token consumed by the connector.")
  @tag("DevOps")
  @action("listAvailableGitLabGroups")
  gitLabGroupsListAvailable is DevOpsConfigurationOps.ActionSync<
    DevOpsConfiguration,
    void,
    ArmResponse<GitLabGroupListResponse>
  >;

  /**
   * Get devops long running operation result.
   */
  @summary("Get devops long running operation result.")
  @tag("DevOps")
  @get
  devOpsOperationResultsGet is DevOpsOperationResultOps.Read<Azure.ResourceManager.CommonTypes.OperationStatusResult>;
}

@@doc(DevOpsConfiguration.name, "");
@@doc(DevOpsConfiguration.properties, "DevOps Configuration properties.");
@@doc(DevOpsConfigurations.createOrUpdate::parameters.resource,
  "The DevOps configuration resource payload."
);
@@doc(DevOpsConfigurations.update::parameters.properties,
  "The DevOps configuration resource payload."
);
