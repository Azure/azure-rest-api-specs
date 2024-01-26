import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GitHubOwner.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityDevOps;
/**
 * GitHub repo Proxy Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(GitHubOwner)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(GitHubRepoProperties)
model GitHubRepo extends ProxyResourceBase {
  /**
   * Name of the GitHub Repo.
   */
  @path
  @key("gitHubRepoName")
  @segment("repos")
  @visibility("read")
  name: string;

  /**
   * GitHub Repo properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GitHubRepoProperties;
}

@armResourceOperations
interface GitHubRepos {
  /**
   * Returns a monitored GitHub repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubRepo_Get")
  get is ArmResourceRead<GitHubRepo>;

  /**
   * Create or update a monitored GitHub repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubRepo_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GitHubRepo,
    BaseParameters<GitHubRepo>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch a monitored GitHub repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("GitHubRepo_Update")
  update is ArmCustomPatchAsync<GitHubRepo, GitHubRepo>;

  /**
   * Returns a list of monitored GitHub repositories.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubRepo_List")
  list is ArmResourceListByParent<GitHubRepo>;
}

@@projectedName(GitHubRepos.createOrUpdate::parameters.resource,
  "json",
  "gitHubRepo"
);
@@extension(GitHubRepos.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "gitHubRepo"
);
@@doc(GitHubRepos.createOrUpdate::parameters.resource, "Github repo.");
@@projectedName(GitHubRepos.update::parameters.properties,
  "json",
  "gitHubRepo"
);
@@extension(GitHubRepos.update::parameters.properties,
  "x-ms-client-name",
  "gitHubRepo"
);
@@doc(GitHubRepos.update::parameters.properties, "Github repo.");
