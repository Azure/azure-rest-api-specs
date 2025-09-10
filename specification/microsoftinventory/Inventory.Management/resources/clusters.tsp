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
@service(#{ title: "Microsoft Inventory" })
@versioned(Microsoft.Inventory.Versions)
namespace Microsoft.Inventory;

@tenantResource
@parentResource(TenantLocationResource)
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
  get is ArmResourceRead<ClusterResource>;
  list is ArmResourceListByParent<ClusterResource>;
}
