import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AvsPrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Avs;
@doc("A cluster resource")
@parentResource(AvsPrivateCloud)
model AvsPrivateCloudCluster is ProxyResource<ClusterProperties> {
  @doc("Name of the cluster in the private cloud")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface AvsPrivateCloudClusters {
  @doc("Get a cluster by name in a private cloud")
  get is ArmResourceRead<AvsPrivateCloudCluster>;
  @doc("Create or update a cluster in a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AvsPrivateCloudCluster>;
  @doc("Update a cluster in a private cloud")
  update is ArmResourcePatchAsync<AvsPrivateCloudCluster, ClusterProperties>;
  @doc("Delete a cluster in a private cloud")
  delete is ArmResourceDeleteAsync<AvsPrivateCloudCluster>;
  @doc("List clusters in a private cloud")
  list is ArmResourceListByParent<AvsPrivateCloudCluster>;
  @doc("List hosts by zone in a cluster")
  listZones is ArmResourceActionSync<
    AvsPrivateCloudCluster,
    {},
    ClusterZoneList
  >;
}
