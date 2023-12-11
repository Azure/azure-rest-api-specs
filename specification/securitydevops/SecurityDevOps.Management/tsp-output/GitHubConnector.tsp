import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityDevOps;
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
  @doc("Returns a monitored GitHub Connector resource for a given ID.")
  get is ArmResourceRead<GitHubConnector>;
  @doc("Create or update a monitored GitHub Connector resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GitHubConnector>;
  @doc("Update monitored GitHub Connector details.")
  update is ArmResourcePatchAsync<GitHubConnector, GitHubConnectorProperties>;
  @doc("Delete monitored GitHub Connector details.")
  delete is ArmResourceDeleteAsync<GitHubConnector>;

  listByResourceGroup is ArmResourceListByParent<GitHubConnector>;
  @doc("Returns a list of monitored GitHub Connectors.")
  listBySubscription is ArmListBySubscription<GitHubConnector>;
  @summary("Returns a list of monitored GitHub repositories.")
  @doc("Returns a list of monitored GitHub repositories.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/repos")
  @get
  ListByConnector is Azure.Core.Foundations.Operation<
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
    GitHubRepoListResponse
  >;

  @summary("Returns the summary of the GitHub Connector Stats.")
  @doc("Returns the summary of the GitHub Connector Stats.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/stats")
  @get
  Get is Azure.Core.Foundations.Operation<
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
