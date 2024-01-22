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

namespace Microsoft.HDInsight;
/**
 * Cluster pool.
 */
model ClusterPool is TrackedResource<ClusterPoolResourceProperties> {
  /**
   * The name of the cluster pool.
   */
  @path
  @key("clusterPoolName")
  @segment("clusterpools")
  name: string;
}

@armResourceOperations
interface ClusterPools {
  /**
   * Gets a cluster pool.
   */
  get is ArmResourceRead<ClusterPool>;

  /**
   * Creates or updates a cluster pool.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterPool,
    BaseParameters<ClusterPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing Cluster Pool Tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchAsync<
    ClusterPool,
    TagsObject,
    BaseParameters<ClusterPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a Cluster Pool.
   */
  delete is ArmResourceDeleteAsync<ClusterPool>;

  /**
   * Lists the HDInsight cluster pools under a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ClusterPools_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ClusterPool>;

  /**
   * Gets the list of Cluster Pools within a Subscription.
   */
  listBySubscription is ArmListBySubscription<ClusterPool>;
}

@@projectedName(ClusterPools.createOrUpdate::parameters.resource,
  "json",
  "ClusterPool"
);
@@extension(ClusterPools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "ClusterPool"
);
@@doc(ClusterPools.createOrUpdate::parameters.resource,
  "The Cluster Pool to create."
);
@@projectedName(ClusterPools.updateTags::parameters.properties,
  "json",
  "clusterPoolTags"
);
@@extension(ClusterPools.updateTags::parameters.properties,
  "x-ms-client-name",
  "clusterPoolTags"
);
@@doc(ClusterPools.updateTags::parameters.properties,
  "Parameters supplied to update tags."
);
