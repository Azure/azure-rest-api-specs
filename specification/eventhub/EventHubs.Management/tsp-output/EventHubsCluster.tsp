import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.EventHub;
@doc("Single Event Hubs Cluster resource in List or Get operations.")
model EventHubsCluster is TrackedResource<ClusterProperties> {
  @doc("The name of the Event Hubs Cluster.")
  @maxLength(50)
  @minLength(6)
  @key("clusterName")
  @segment("clusters")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
@projectedName("client", "Clusters")
interface EventHubsClusters_Clusters {
  @doc("Gets the resource description of the specified Event Hubs Cluster.")
  get is ArmResourceRead<EventHubsCluster>;

  @doc("Creates or updates an instance of an Event Hubs Cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EventHubsCluster>;

  @doc("Modifies mutable properties on the Event Hubs Cluster. This operation is idempotent.")
  update is ArmCustomPatchAsync<EventHubsCluster, EventHubsCluster>;

  @doc("Deletes an existing Event Hubs Cluster. This operation is idempotent.")
  delete is ArmResourceDeleteAsync<EventHubsCluster>;

  @doc("Lists the available Event Hubs Clusters within an ARM resource group")
  listByResourceGroup is ArmResourceListByParent<EventHubsCluster>;

  @doc("List the quantity of available pre-provisioned Event Hubs Clusters, indexed by Azure region.")
  listAvailableClusterRegion is ArmListBySubscription<EventHubsCluster>;

  @doc("Lists the available Event Hubs Clusters within an ARM resource group")
  listBySubscription is ArmListBySubscription<EventHubsCluster>;

  @doc("List all Event Hubs Namespace IDs in an Event Hubs Dedicated Cluster.")
  // FIXME: Clusters_ListNamespaces could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}/namespaces")
  @get
  ListNamespaces is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Event Hubs Cluster.")
      @maxLength(50)
      @minLength(6)
      @path
      clusterName: string;
    },
    EHNamespaceIdListResult
  >;
}

@armResourceOperations
@projectedName("client", "Configuration")
interface EventHubsClusters_Configuration {
  @doc("Get all Event Hubs Cluster settings - a collection of key/value pairs which represent the quotas and settings imposed on the cluster.")
  // FIXME: Configuration_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Event Hubs Cluster.")
      @maxLength(50)
      @minLength(6)
      @path
      clusterName: string;
    },
    ClusterQuotaConfigurationProperties
  >;
}
