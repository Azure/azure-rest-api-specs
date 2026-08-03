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

namespace Microsoft.EventHub;
/**
 * Single Event Hubs Cluster resource in List or Get operations.
 */
model EventHubsCluster is TrackedResource<ClusterProperties> {
  /**
   * The name of the Event Hubs Cluster.
   */
  @maxLength(50)
  @minLength(6)
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface EventHubsClusters {
  /**
   * Gets the resource description of the specified Event Hubs Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_Get")
  get is ArmResourceRead<EventHubsCluster>;

  /**
   * Creates or updates an instance of an Event Hubs Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EventHubsCluster>;

  /**
   * Modifies mutable properties on the Event Hubs Cluster. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Clusters_Update")
  update is ArmCustomPatchAsync<EventHubsCluster, EventHubsCluster>;

  /**
   * Deletes an existing Event Hubs Cluster. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_Delete")
  delete is ArmResourceDeleteAsync<EventHubsCluster>;

  /**
   * Lists the available Event Hubs Clusters within an ARM resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<EventHubsCluster>;

  // /**
  //  * List the quantity of available pre-provisioned Event Hubs Clusters, indexed by Azure region.
  //  */
  // #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  // @operationId("Clusters_ListAvailableClusterRegion")
  // listAvailableClusterRegion is ArmListBySubscription<EventHubsCluster>;

  /**
   * Lists the available Event Hubs Clusters within an ARM resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListBySubscription")
  listBySubscription is ArmListBySubscription<EventHubsCluster>;

  /**
   * List all Event Hubs Namespace IDs in an Event Hubs Dedicated Cluster.
   */
  // FIXME: Clusters_ListNamespaces could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListNamespaces")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}/namespaces")
  @get
  listNamespaces is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Event Hubs Cluster.
       */
      @maxLength(50)
      @minLength(6)
      @path
      clusterName: string;
    },
    EHNamespaceIdListResult
  >;

  /**
   * Get all Event Hubs Cluster settings - a collection of key/value pairs which represent the quotas and settings imposed on the cluster.
   */
  // FIXME: Configuration_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configuration_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default")
  @get
  getall is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Event Hubs Cluster.
       */
      @maxLength(50)
      @minLength(6)
      @path
      clusterName: string;
    },
    ClusterQuotaConfigurationProperties
  >;
}

@@projectedName(EventHubsClusters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(EventHubsClusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsClusters.createOrUpdate::parameters.resource,
  "Parameters for creating a eventhub cluster resource."
);
@@projectedName(EventHubsClusters.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(EventHubsClusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsClusters.update::parameters.properties,
  "The properties of the Event Hubs Cluster which should be updated."
);
