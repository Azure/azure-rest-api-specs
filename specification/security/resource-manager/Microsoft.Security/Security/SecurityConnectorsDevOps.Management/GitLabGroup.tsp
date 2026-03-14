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

namespace Microsoft.Security;
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

@armResourceOperations
interface GitLabGroups {
  /**
   * Returns a monitored GitLab Group resource for a given fully-qualified name.
   */
  get is GitLabGroupOps.Read<GitLabGroup>;

  /**
   * Returns a list of GitLab groups onboarded to the connector.
   */
  list is GitLabGroupOps.List<
    GitLabGroup,
    Response = ArmResponse<GitLabGroupListResponse>
  >;

  /**
   * Gets nested subgroups of given GitLab Group which are onboarded to the connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GitLabSubgroups_List")
  @list
  @action("listSubgroups")
  gitLabSubgroupsList is GitLabGroupOps.ActionSync<
    GitLabGroup,
    void,
    ArmResponse<GitLabGroupListResponse>
  >;
}

@@doc(GitLabGroup.name, "The GitLab group fully-qualified name.");
@@doc(GitLabGroup.properties, "GitLab Group properties.");
