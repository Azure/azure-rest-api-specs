import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityDevOps;

model AzureDevOpsConnector is TrackedResource<AzureDevOpsConnectorProperties> {
  @doc("Name of the AzureDevOps Connector.")
  @key("azureDevOpsConnectorName")
  @segment("azureDevOpsConnectors")
  name: string;
}

@armResourceOperations
@projectedName("client", "AzureDevOpsConnector")
interface AzureDevOpsConnectors_AzureDevOpsConnector {
  @doc("Returns a monitored AzureDevOps Connector resource for a given ID.")
  get is ArmResourceRead<AzureDevOpsConnector>;

  @doc("Creates or updates an Azure DevOps Connector.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureDevOpsConnector>;

  @doc("Update monitored AzureDevOps Connector details.")
  update is ArmCustomPatchAsync<AzureDevOpsConnector, AzureDevOpsConnector>;

  @doc("Delete monitored AzureDevOps Connector details.")
  delete is ArmResourceDeleteAsync<AzureDevOpsConnector>;

  listByResourceGroup is ArmResourceListByParent<AzureDevOpsConnector>;

  @doc("Returns a list of monitored AzureDevOps Connectors.")
  listBySubscription is ArmListBySubscription<AzureDevOpsConnector>;
}

@armResourceOperations
@projectedName("client", "AzureDevOpsRepo")
interface AzureDevOpsConnectors_AzureDevOpsRepo {
  // FIXME: AzureDevOpsRepo_ListByConnector could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/repos")
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

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;
    },
    ResourceListResult<AzureDevOpsRepo>
  >;
}

@armResourceOperations
@projectedName("client", "AzureDevOpsConnectorStats")
interface AzureDevOpsConnectors_AzureDevOpsConnectorStats {
  @summary("Returns the summary of the AzureDevOps Connector Stats.")
  @doc("Returns the summary of the AzureDevOps Connector Stats.")
  // FIXME: AzureDevOpsConnectorStats_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/stats")
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

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;
    },
    AzureDevOpsConnectorStatsListResponse
  >;
}
