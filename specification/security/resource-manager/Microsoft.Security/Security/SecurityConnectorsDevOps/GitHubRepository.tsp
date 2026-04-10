import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GitHubOwner.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecurityConnectorsDevOpsAPI;
/**
 * GitHub Repository resource.
 */
@parentResource(GitHubOwner)
model GitHubRepository
  is Azure.ResourceManager.ProxyResource<GitHubRepositoryProperties> {
  ...ResourceNameParameter<
    Resource = GitHubRepository,
    KeyName = "repoName",
    SegmentName = "repos",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
alias GitHubRepositoryOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @segment("gitHubOwners")
    @key
    ownerName: string;
  },
  {
    @path
    @segment("repos")
    @key
    repoName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface GitHubRepositories {
  /**
   * Returns a monitored GitHub repository.
   */
  @summary("Returns a monitored GitHub repository.")
  @tag("DevOps")
  get is GitHubRepositoryOps.Read<GitHubRepository>;

  /**
   * Returns a list of GitHub repositories onboarded to the connector.
   */
  @summary("Returns a list of GitHub repositories onboarded to the connector.")
  @tag("DevOps")
  list is GitHubRepositoryOps.List<
    GitHubRepository,
    Response = ArmResponse<GitHubRepositoryListResponse>
  >;

  /**
   * Creates a GitHub issue for the specified repository and assessment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a GitHub issue for the specified repository and assessment.")
  @tag("DevOps")
  @action("issues")
  create is GitHubRepositoryOps.ActionAsync<
    GitHubRepository,
    IssueCreationRequest,
    ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;
}

@@doc(GitHubRepository.name, "The repository name.");
@@doc(GitHubRepository.properties, "GitHub Repository properties.");
@@doc(GitHubRepositories.create::parameters.body,
  "The request model containing details for creating the GitHub issue."
);

