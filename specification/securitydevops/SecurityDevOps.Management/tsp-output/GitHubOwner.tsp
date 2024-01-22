import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GitHubConnector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityDevOps;
/**
 * GitHub repo owner Proxy Resource.
 */
@parentResource(GitHubConnector)
model GitHubOwner is ProxyResource<GitHubOwnerProperties> {
  /**
   * Name of the GitHub Owner.
   */
  @path
  @key("gitHubOwnerName")
  @segment("owners")
  name: string;
}

@armResourceOperations
interface GitHubOwners {
  /**
   * Returns a monitored GitHub repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubOwner_Get")
  get is ArmResourceRead<GitHubOwner>;

  /**
   * Create or update a monitored GitHub owner.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubOwner_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GitHubOwner,
    BaseParameters<GitHubOwner>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch a monitored GitHub repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("GitHubOwner_Update")
  update is ArmCustomPatchAsync<GitHubOwner, GitHubOwner>;

  /**
   * Returns a list of monitored GitHub owners.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubOwner_List")
  list is ArmResourceListByParent<GitHubOwner>;
}

@@projectedName(GitHubOwners.createOrUpdate::parameters.resource,
  "json",
  "gitHubOwner"
);
@@extension(GitHubOwners.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "gitHubOwner"
);
@@doc(GitHubOwners.createOrUpdate::parameters.resource, "Github owner.");
@@projectedName(GitHubOwners.update::parameters.properties,
  "json",
  "gitHubOwner"
);
@@extension(GitHubOwners.update::parameters.properties,
  "x-ms-client-name",
  "gitHubOwner"
);
@@doc(GitHubOwners.update::parameters.properties, "Github owner.");
