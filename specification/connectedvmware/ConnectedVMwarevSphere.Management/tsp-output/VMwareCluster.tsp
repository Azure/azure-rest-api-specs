import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ConnectedVMwarevSphere;
@doc("Define the cluster.")
model VMwareCluster is TrackedResource<ClusterProperties> {
  @doc("Name of the cluster.")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface VMwareClusters {
  @doc("Implements cluster GET method.")
  get is ArmResourceRead<VMwareCluster>;
  @doc("Create Or Update cluster.")
  create is ArmResourceCreateOrUpdateAsync<VMwareCluster>;
  @doc("API to update certain properties of the cluster resource.")
  update is ArmTagsPatchSync<VMwareCluster>;
  @doc("Implements cluster DELETE method.")
  delete is ArmResourceDeleteAsync<
    VMwareCluster,
    {
      ...BaseParameters<VMwareCluster>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VMwareCluster>;
  @doc("List of clusters in a subscription.")
  list is ArmListBySubscription<VMwareCluster>;
}
