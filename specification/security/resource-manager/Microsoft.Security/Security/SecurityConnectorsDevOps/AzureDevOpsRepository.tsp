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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecurityConnectorsDevOpsAPI;
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
alias AzureDevOpsRepositoryOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    @path
    @segment("azureDevOpsOrgs")
    @key
    orgName: string;

    @path
    @segment("projects")
    @key
    projectName: string;
  },
  {
    @path
    @segment("repos")
    @key
    repoName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AzureDevOpsRepositories {
  /**
   * Returns a monitored Azure DevOps repository resource.
   */
  @summary("Returns a monitored Azure DevOps repository resource.")
  @tag("DevOps")
  get is AzureDevOpsRepositoryOps.Read<AzureDevOpsRepository>;

  /**
   * Creates or updates a monitored Azure DevOps repository resource.
   */
  @summary("Creates or updates a monitored Azure DevOps repository resource.")
  @tag("DevOps")
  createOrUpdate is AzureDevOpsRepositoryOps.CreateOrUpdateAsync<AzureDevOpsRepository>;

  /**
   * Updates a monitored Azure DevOps repository resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates a monitored Azure DevOps repository resource.")
  @tag("DevOps")
  @patch(#{ implicitOptionality: false })
  update is AzureDevOpsRepositoryOps.CustomPatchAsync<
    AzureDevOpsRepository,
    PatchModel = AzureDevOpsRepository,
    Response = ArmResponse<AzureDevOpsRepository> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AzureDevOpsRepository> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AzureDevOpsRepository;
    })
  >;

  /**
   * Returns a list of Azure DevOps repositories onboarded to the connector.
   */
  @summary("Returns a list of Azure DevOps repositories onboarded to the connector.")
  @tag("DevOps")
  list is AzureDevOpsRepositoryOps.List<
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

