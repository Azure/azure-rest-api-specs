import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkCloudCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("ClusterMetricsConfiguration represents the metrics configuration of an on-premises Network Cloud cluster.")
@parentResource(NetworkCloudCluster)
model NetworkCloudClusterMetricsConfiguration
  is TrackedResource<ClusterMetricsConfigurationProperties> {
  @doc("The name of the metrics configuration for the cluster.")
  @pattern("^default$")
  @path
  @key("metricsConfigurationName")
  @segment("metricsConfigurations")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface NetworkCloudClusterMetricsConfigurations {
  @doc("Get metrics configuration of the provided cluster.")
  get is ArmResourceRead<NetworkCloudClusterMetricsConfiguration>;
  @doc("Create new or update the existing metrics configuration of the provided cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkCloudClusterMetricsConfiguration>;
  @doc("Patch properties of metrics configuration for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.")
  update is ArmResourcePatchAsync<
    NetworkCloudClusterMetricsConfiguration,
    ClusterMetricsConfigurationProperties
  >;
  @doc("Delete the metrics configuration of the provided cluster.")
  delete is ArmResourceDeleteAsync<NetworkCloudClusterMetricsConfiguration>;
  @doc("Get a list of metrics configurations for the provided cluster.")
  listByCluster is ArmResourceListByParent<NetworkCloudClusterMetricsConfiguration>;
}
