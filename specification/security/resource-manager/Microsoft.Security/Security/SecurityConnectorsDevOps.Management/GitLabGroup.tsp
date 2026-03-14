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

@armResourceOperations
interface GitLabGroups {
  /**
   * Returns a monitored GitLab Group resource for a given fully-qualified name.
   */
  get is ArmResourceRead<GitLabGroup>;

  /**
   * Returns a list of GitLab groups onboarded to the connector.
   */
  list is ArmResourceListByParent<
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
  gitLabSubgroupsList is ArmResourceActionSync<
    GitLabGroup,
    void,
    ArmResponse<GitLabGroupListResponse>
  >;
}

@@doc(GitLabGroup.name, "The GitLab group fully-qualified name.");
@@doc(GitLabGroup.properties, "GitLab Group properties.");
