import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GitLabGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecurityConnectorsDevOpsAPI;
/**
 * GitLab Project resource.
 */
@parentResource(GitLabGroup)
model GitLabProject
  is Azure.ResourceManager.ProxyResource<GitLabProjectProperties> {
  ...ResourceNameParameter<
    Resource = GitLabProject,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
alias GitLabProjectOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @segment("gitLabGroups")
    @key
    groupFQName: string;
  },
  {
    @path
    @segment("projects")
    @key
    projectName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface GitLabProjects {
  /**
   * Returns a monitored GitLab Project resource for a given fully-qualified group name and project name.
   */
  @summary("Returns a monitored GitLab Project resource for a given fully-qualified group name and project name.")
  @tag("DevOps")
  get is GitLabProjectOps.Read<GitLabProject>;

  /**
   * Gets a list of GitLab projects that are directly owned by given group and onboarded to the connector.
   */
  @summary("Gets a list of GitLab projects that are directly owned by given group and onboarded to the connector.")
  @tag("DevOps")
  list is GitLabProjectOps.List<
    GitLabProject,
    Response = ArmResponse<GitLabProjectListResponse>
  >;
}

@@doc(GitLabProject.name, "The project name.");
@@doc(GitLabProject.properties, "GitLab Project properties.");
