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
@doc("GitHub repo Proxy Resource.")
@parentResource(GitHubOwner)
model GitHubRepo is ProxyResource<GitHubRepoProperties> {
  @doc("Name of the GitHub Repo.")
  @path
  @key("gitHubRepoName")
  @segment("repos")
  name: string;
}

@armResourceOperations
interface GitHubRepos {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a monitored GitHub repository.")
  @operationId("GitHubRepo_Get")
  get is ArmResourceRead<GitHubRepo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a monitored GitHub repository.")
  @operationId("GitHubRepo_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    GitHubRepo,
    BaseParameters<GitHubRepo>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patch a monitored GitHub repository.")
  @operationId("GitHubRepo_Update")
  update is ArmCustomPatchAsync<GitHubRepo, GitHubRepo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a list of monitored GitHub repositories.")
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
