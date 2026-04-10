import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevOpsConfiguration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecurityConnectorsDevOpsAPI;
/**
 * GitLab Group resource.
 */
@parentResource(DevOpsConfiguration)
model GitLabGroup
  is Azure.ResourceManager.ProxyResource<GitLabGroupProperties> {
  ...ResourceNameParameter<
    Resource = GitLabGroup,
    KeyName = "groupFQName",
    SegmentName = "gitLabGroups",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
alias GitLabGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @segment("gitLabGroups")
    @key
    groupFQName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface GitLabGroups {
  /**
   * Returns a monitored GitLab Group resource for a given fully-qualified name.
   */
  @summary("Returns a monitored GitLab Group resource for a given fully-qualified name.")
  @tag("DevOps")
  get is GitLabGroupOps.Read<GitLabGroup>;

  /**
   * Returns a list of GitLab groups onboarded to the connector.
   */
  @summary("Returns a list of GitLab groups onboarded to the connector.")
  @tag("DevOps")
  list is GitLabGroupOps.List<
    GitLabGroup,
    Response = ArmResponse<GitLabGroupListResponse>
  >;

  /**
   * Gets nested subgroups of given GitLab Group which are onboarded to the connector.
   */
  @summary("Gets nested subgroups of given GitLab Group which are onboarded to the connector.")
  @tag("DevOps")
  @action("listSubgroups")
  gitLabSubgroupsList is GitLabGroupOps.ActionSync<
    GitLabGroup,
    void,
    ArmResponse<GitLabGroupListResponse>
  >;
}

@@doc(GitLabGroup.name, "The GitLab group fully-qualified name.");
@@doc(GitLabGroup.properties, "GitLab Group properties.");

