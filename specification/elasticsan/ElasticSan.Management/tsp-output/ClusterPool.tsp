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
@doc("Cluster pool.")
model ClusterPool is TrackedResource<ClusterPoolResourceProperties> {
  @doc("The name of the cluster pool.")
  @path
  @key("clusterPoolName")
  @segment("clusterpools")
  name: string;
}

@armResourceOperations
interface ClusterPools {
  @doc("Gets a cluster pool.")
  get is ArmResourceRead<ClusterPool>;

  @doc("Creates or updates a cluster pool.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ClusterPool,
    BaseParameters<ClusterPool>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates an existing Cluster Pool Tags.")
  updateTags is ArmCustomPatchAsync<
    ClusterPool,
    TagsObject,
    BaseParameters<ClusterPool>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a Cluster Pool.")
  delete is ArmResourceDeleteAsync<ClusterPool>;

  @doc("Lists the HDInsight cluster pools under a resource group.")
  listByResourceGroup is ArmResourceListByParent<ClusterPool>;

  @doc("Gets the list of Cluster Pools within a Subscription.")
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
