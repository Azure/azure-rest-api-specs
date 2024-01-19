import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
@doc("A cluster resource")
@parentResource(PrivateCloud)
model Cluster is ProxyResource<ClusterProperties> {
  @doc("Name of the cluster in the private cloud")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Clusters {
  @doc("Get a cluster by name in a private cloud")
  get is ArmResourceRead<Cluster>;

  @doc("Create or update a cluster in a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Cluster>;

  @doc("Update a cluster in a private cloud")
  update is ArmCustomPatchAsync<Cluster, ClusterUpdate>;

  @doc("Delete a cluster in a private cloud")
  delete is ArmResourceDeleteAsync<Cluster>;

  @doc("List clusters in a private cloud")
  list is ArmResourceListByParent<Cluster>;

  @doc("List hosts by zone in a cluster")
  listZones is ArmResourceActionSync<Cluster, void, ClusterZoneList>;
}

@@projectedName(Clusters.createOrUpdate::parameters.resource,
  "json",
  "cluster"
);
@@extension(Clusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cluster"
);
@@doc(Clusters.createOrUpdate::parameters.resource,
  "A cluster in the private cloud"
);
@@projectedName(Clusters.update::parameters.properties,
  "json",
  "clusterUpdate"
);
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "clusterUpdate"
);
@@doc(Clusters.update::parameters.properties,
  "The cluster properties to be updated"
);
