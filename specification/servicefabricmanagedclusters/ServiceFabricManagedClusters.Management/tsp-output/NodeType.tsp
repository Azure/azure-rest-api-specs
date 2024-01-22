import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.
 */
@parentResource(ManagedCluster)
model NodeType is ProxyResource<NodeTypeProperties> {
  /**
   * The name of the node type.
   */
  @path
  @key("nodeTypeName")
  @segment("nodeTypes")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface NodeTypes {
  /**
   * Get a Service Fabric node type of a given managed cluster.
   */
  get is ArmResourceRead<NodeType>;

  /**
   * Create or update a Service Fabric node type of a given managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NodeType,
    BaseParameters<NodeType>,
    ArmLroLocationHeader
  >;

  /**
   * Update the configuration of a node type of a given managed cluster, only updating tags.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<NodeType, NodeTypeUpdateParameters>;

  /**
   * Delete a Service Fabric node type of a given managed cluster.
   */
  delete is ArmResourceDeleteAsync<
    NodeType,
    BaseParameters<NodeType>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all Node types of the specified managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeTypes_ListByManagedClusters")
  listByManagedClusters is ArmResourceListByParent<NodeType>;

  /**
   * Restarts one or more nodes on the node type. It will disable the fabric nodes, trigger a restart on the VMs and activate the nodes back again.
   */
  restart is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    void,
    BaseParameters<NodeType>,
    ArmLroLocationHeader
  >;

  /**
   * Reimages one or more nodes on the node type. It will disable the fabric nodes, trigger a reimage on the VMs and activate the nodes back again.
   */
  reimage is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    void,
    BaseParameters<NodeType>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes one or more nodes on the node type. It will disable the fabric nodes, trigger a delete on the VMs and removes the state from the cluster.
   */
  deleteNode is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    void,
    BaseParameters<NodeType>,
    ArmLroLocationHeader
  >;

  /**
   * Get a Service Fabric node type supported SKUs.
   */
  // FIXME: NodeTypeSkus_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeTypeSkus_List")
  @summary("Gets a Service Fabric node type SKUs.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/nodeTypes/{nodeTypeName}/skus")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The customer subscription identifier.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the cluster resource.
       */
      @path
      clusterName: string;

      /**
       * The name of the node type.
       */
      @path
      nodeTypeName: string;
    },
    NodeTypeListSkuResult
  >;
}

@@projectedName(NodeTypes.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NodeTypes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NodeTypes.createOrUpdate::parameters.resource, "The node type resource.");
@@projectedName(NodeTypes.update::parameters.properties, "json", "parameters");
@@extension(NodeTypes.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NodeTypes.update::parameters.properties,
  "The parameters to update the node type configuration."
);
@@projectedName(NodeTypes.restart::parameters.body, "json", "parameters");
@@extension(NodeTypes.restart::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(NodeTypes.restart::parameters.body, "parameters for restart action.");
@@projectedName(NodeTypes.reimage::parameters.body, "json", "parameters");
@@extension(NodeTypes.reimage::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(NodeTypes.reimage::parameters.body, "parameters for reimage action.");
@@projectedName(NodeTypes.deleteNode::parameters.body, "json", "parameters");
@@extension(NodeTypes.deleteNode::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(NodeTypes.deleteNode::parameters.body, "parameters for delete action.");
