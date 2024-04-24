import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/cluster.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft Inventory",
  version: "2024-01-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.Inventory;

@tenantResource
model ClusterResource is ProxyResource<ClusterProperties> {
  @pattern("[a-zA-Z0-9]+[-_]*")
  @key("clusterName")
  @segment("physicalClusters")
  @doc("Cluster")
  @path
  name: string;
}

@armResourceOperations
interface Clusters {
  getCluster is ArmLocResourceRead<ClusterResource>;
  list is ArmLocResourceListByParent<ClusterResource>;
}
