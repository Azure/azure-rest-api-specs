import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ClusterPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;
/**
 * The cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ClusterPool)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ClusterResourceProperties)
model Cluster extends TrackedResourceBase {
  /**
   * The name of the HDInsight cluster.
   */
  @path
  @key("clusterName")
  @segment("clusters")
  @visibility("read")
  name: string;

  /**
   * Gets or sets the properties. Define cluster specific properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterResourceProperties;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets a HDInsight cluster.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Creates a cluster.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing Cluster.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterPatch,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a cluster.
   */
  delete is ArmResourceDeleteAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the HDInsight cluster pools under a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListByClusterPoolName")
  listByClusterPoolName is ArmResourceListByParent<Cluster>;

  /**
   * Resize an existing Cluster.
   */
  resize is ArmResourceActionAsync<
    Cluster,
    ClusterResizeData,
    Cluster,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Operations on jobs of HDInsight on AKS cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ClusterJobs_RunJob")
  runJob is ArmResourceActionAsync<
    Cluster,
    ClusterJob,
    ClusterJob,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Lists the config dump of all services running in cluster.
   */
  // FIXME: Clusters_ListServiceConfigs could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters/{clusterName}/serviceConfigs")
  @get
  listServiceConfigs is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the cluster pool.
       */
      @path
      clusterPoolName: string;

      /**
       * The name of the HDInsight cluster.
       */
      @path
      clusterName: string;
    },
    ServiceConfigListResult
  >;

  /**
   * Lists the lists of instance views
   */
  // FIXME: Clusters_ListInstanceViews could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters/{clusterName}/instanceViews")
  @get
  listInstanceViews is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the cluster pool.
       */
      @path
      clusterPoolName: string;

      /**
       * The name of the HDInsight cluster.
       */
      @path
      clusterName: string;
    },
    ClusterInstanceViewsResult
  >;

  /**
   * Gets the status of a cluster instance.
   */
  // FIXME: Clusters_GetInstanceView could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters/{clusterName}/instanceViews/default")
  @get
  getInstanceView is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the cluster pool.
       */
      @path
      clusterPoolName: string;

      /**
       * The name of the HDInsight cluster.
       */
      @path
      clusterName: string;
    },
    ClusterInstanceViewResult
  >;

  /**
   * Get jobs of HDInsight on AKS cluster.
   */
  // FIXME: ClusterJobs_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ClusterJobs_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters/{clusterName}/jobs")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the cluster pool.
       */
      @path
      clusterPoolName: string;

      /**
       * The name of the HDInsight cluster.
       */
      @path
      clusterName: string;
    },
    ClusterJobList
  >;
}

@@projectedName(Clusters.create::parameters.resource,
  "json",
  "HDInsightCluster"
);
@@extension(Clusters.create::parameters.resource,
  "x-ms-client-name",
  "HDInsightCluster"
);
@@doc(Clusters.create::parameters.resource, "The cluster to create.");
@@projectedName(Clusters.update::parameters.properties,
  "json",
  "ClusterPatchRequest"
);
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "ClusterPatchRequest"
);
@@doc(Clusters.update::parameters.properties, "Patch a cluster.");
@@projectedName(Clusters.resize::parameters.body,
  "json",
  "ClusterResizeRequest"
);
@@extension(Clusters.resize::parameters.body,
  "x-ms-client-name",
  "ClusterResizeRequest"
);
@@doc(Clusters.resize::parameters.body, "Resize a cluster.");
@@projectedName(Clusters.runJob::parameters.body, "json", "ClusterJob");
@@extension(Clusters.runJob::parameters.body, "x-ms-client-name", "ClusterJob");
@@doc(Clusters.runJob::parameters.body, "The Cluster job.");
