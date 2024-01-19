import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityDevOps;
@doc("Represents an ARM resource for /subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.SecurityDevOps/gitHubConnectors.")
model GitHubConnector is TrackedResource<GitHubConnectorProperties> {
  @doc("Name of the GitHub Connector.")
  @path
  @key("gitHubConnectorName")
  @segment("gitHubConnectors")
  name: string;
}

@armResourceOperations
interface GitHubConnectors {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a monitored GitHub Connector resource for a given ID.")
  @operationId("GitHubConnector_Get")
  get is ArmResourceRead<GitHubConnector>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a monitored GitHub Connector resource.")
  @operationId("GitHubConnector_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    GitHubConnector,
    BaseParameters<GitHubConnector>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update monitored GitHub Connector details.")
  @operationId("GitHubConnector_Update")
  update is ArmCustomPatchAsync<GitHubConnector, GitHubConnector>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete monitored GitHub Connector details.")
  @operationId("GitHubConnector_Delete")
  delete is ArmResourceDeleteAsync<GitHubConnector>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubConnector_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<GitHubConnector>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a list of monitored GitHub Connectors.")
  @operationId("GitHubConnector_ListBySubscription")
  listBySubscription is ArmListBySubscription<GitHubConnector>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubRepo_ListByConnector")
  @summary("Returns a list of monitored GitHub repositories.")
  @doc("Returns a list of monitored GitHub repositories.")
  // FIXME: GitHubRepo_ListByConnector could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/repos")
  @get
  listByConnector is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;
    },
    ResourceListResult<GitHubRepo>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubConnectorStats_Get")
  @summary("Returns the summary of the GitHub Connector Stats.")
  @doc("Returns the summary of the GitHub Connector Stats.")
  // FIXME: GitHubConnectorStats_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/stats")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;
    },
    GitHubConnectorStatsListResponse
  >;
}

@@projectedName(GitHubConnectors.createOrUpdate::parameters.resource,
  "json",
  "gitHubConnector"
);
@@extension(GitHubConnectors.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "gitHubConnector"
);
@@doc(GitHubConnectors.createOrUpdate::parameters.resource,
  "Connector resource payload."
);
@@projectedName(GitHubConnectors.update::parameters.properties,
  "json",
  "gitHubConnector"
);
@@extension(GitHubConnectors.update::parameters.properties,
  "x-ms-client-name",
  "gitHubConnector"
);
@@doc(GitHubConnectors.update::parameters.properties,
  "Connector resource payload."
);
