import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.
 */
@parentResource(ManagedCluster)
model NodeType is Azure.ResourceManager.ProxyResource<NodeTypeProperties> {
  ...ResourceNameParameter<
    Resource = NodeType,
    KeyName = "nodeTypeName",
    SegmentName = "nodeTypes",
    NamePattern = ""
  >;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The node type sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: NodeTypeSku;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NodeType,
    Response = ArmResourceUpdatedResponse<NodeType> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: NodeType;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update the configuration of a node type of a given managed cluster, only updating tags.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NodeType,
    PatchModel = NodeTypeUpdateParameters
  >;

  /**
   * Delete a Service Fabric node type of a given managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NodeType>;

  /**
   * Gets all Node types of the specified managed cluster.
   */
  listByManagedClusters is ArmResourceListByParent<NodeType>;

  /**
   * Deallocates one or more nodes on the node type. It will disable the fabric nodes, trigger a shutdown on the VMs and release them from the cluster.
   */
  deallocate is ArmResourceActionAsyncBase<
    NodeType,
    NodeTypeActionParameters,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NodeType>
  >;

  /**
   * Deletes one or more nodes on the node type. It will disable the fabric nodes, trigger a delete on the VMs and removes the state from the cluster.
   */
  deleteNode is ArmResourceActionAsyncBase<
    NodeType,
    NodeTypeActionParameters,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NodeType>
  >;

  /**
   * Gets a fault simulation by the simulationId.
   */
  getFaultSimulation is ArmResourceActionSync<
    NodeType,
    FaultSimulationIdContent,
    ArmResponse<FaultSimulation>
  >;

  /**
   * Gets the list of recent fault simulations for the node type.
   */
  listFaultSimulation is ArmResourceActionSync<
    NodeType,
    void,
    ArmResponse<FaultSimulationListResult>
  >;

  /**
   * Redeploys one or more nodes on the node type. It will disable the fabric nodes, trigger a shut down on the VMs, move them to a new node, and power them back on.
   */
  redeploy is ArmResourceActionAsyncBase<
    NodeType,
    NodeTypeActionParameters,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NodeType>
  >;

  /**
   * Reimages one or more nodes on the node type. It will disable the fabric nodes, trigger a reimage on the VMs and activate the nodes back again.
   */
  reimage is ArmResourceActionAsyncBase<
    NodeType,
    NodeTypeActionParameters,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NodeType>
  >;

  /**
   * Restarts one or more nodes on the node type. It will disable the fabric nodes, trigger a restart on the VMs and activate the nodes back again.
   */
  restart is ArmResourceActionAsyncBase<
    NodeType,
    NodeTypeActionParameters,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NodeType>
  >;

  /**
   * Starts one or more nodes on the node type. It will trigger an allocation of the fabric node if needed and activate them.
   */
  start is ArmResourceActionAsyncBase<
    NodeType,
    NodeTypeActionParameters,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NodeType>
  >;

  /**
   * Starts a fault simulation on the node type.
   */
  startFaultSimulation is ArmResourceActionAsync<
    NodeType,
    FaultSimulationContent,
    ArmResponse<FaultSimulation>
  >;

  /**
   * Stops a fault simulation on the node type.
   */
  stopFaultSimulation is ArmResourceActionAsync<
    NodeType,
    FaultSimulationIdContent,
    ArmResponse<FaultSimulation>
  >;

  /**
   * Get a Service Fabric node type supported SKUs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("skus")
  @operationId("NodeTypeSkus_List")
  list is ArmResourceActionSync<
    NodeType,
    void,
    ArmResponse<NodeTypeListSkuResult>
  >;
}

@@doc(NodeType.name, "The name of the node type.");
@@doc(NodeType.properties, "The node type properties");
@@doc(NodeTypes.createOrUpdate::parameters.resource, "The node type resource.");
@@doc(NodeTypes.update::parameters.properties,
  "The parameters to update the node type configuration."
);
@@doc(NodeTypes.deallocate::parameters.body,
  "parameters for deallocate action."
);
@@doc(NodeTypes.deleteNode::parameters.body, "parameters for delete action.");
@@doc(NodeTypes.getFaultSimulation::parameters.body,
  "parameter with fault simulation id."
);
@@doc(NodeTypes.redeploy::parameters.body, "parameters for redeploy action.");
@@doc(NodeTypes.reimage::parameters.body, "parameters for reimage action.");
@@doc(NodeTypes.restart::parameters.body, "parameters for restart action.");
@@doc(NodeTypes.start::parameters.body, "parameters for start action.");
@@doc(NodeTypes.startFaultSimulation::parameters.body,
  "parameters describing the fault simulation."
);
@@doc(NodeTypes.stopFaultSimulation::parameters.body,
  "parameter with fault simulation id."
);
