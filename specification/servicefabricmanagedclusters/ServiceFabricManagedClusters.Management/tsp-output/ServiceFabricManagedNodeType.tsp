import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceFabricManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabricManagedClusters;
@doc("Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.")
@parentResource(ServiceFabricManagedCluster)
model ServiceFabricManagedNodeType is ProxyResource<NodeTypeProperties> {
  @doc("The name of the node type.")
  @path
  @key("nodeTypeName")
  @segment("nodeTypes")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ServiceFabricManagedNodeTypes {
  @doc("Get a Service Fabric node type of a given managed cluster.")
  get is ArmResourceRead<ServiceFabricManagedNodeType>;
  @doc("Create or update a Service Fabric node type of a given managed cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceFabricManagedNodeType>;
  @doc("Update the configuration of a node type of a given managed cluster, only updating tags.")
  update is ArmTagsPatchSync<ServiceFabricManagedNodeType>;
  @doc("Delete a Service Fabric node type of a given managed cluster.")
  delete is ArmResourceDeleteAsync<ServiceFabricManagedNodeType>;
  @doc("Gets all Node types of the specified managed cluster.")
  listByManagedClusters is ArmResourceListByParent<ServiceFabricManagedNodeType>;
  @doc("Restarts one or more nodes on the node type. It will disable the fabric nodes, trigger a restart on the VMs and activate the nodes back again.")
  restart is ArmResourceActionAsync<
    ServiceFabricManagedNodeType,
    NodeTypeActionParameters,
    void
  >;
  @doc("Reimages one or more nodes on the node type. It will disable the fabric nodes, trigger a reimage on the VMs and activate the nodes back again.")
  reimage is ArmResourceActionAsync<
    ServiceFabricManagedNodeType,
    NodeTypeActionParameters,
    void
  >;
  @doc("Deletes one or more nodes on the node type. It will disable the fabric nodes, trigger a delete on the VMs and removes the state from the cluster.")
  deleteNode is ArmResourceActionAsync<
    ServiceFabricManagedNodeType,
    NodeTypeActionParameters,
    void
  >;
  @summary("Gets a Service Fabric node type SKUs.")
  @doc("Get a Service Fabric node type supported SKUs.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/nodeTypes/{nodeTypeName}/skus")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The customer subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster resource.")
      @path
      clusterName: string;

      @doc("The name of the node type.")
      @path
      nodeTypeName: string;
    },
    NodeTypeListSkuResult
  >;
}
