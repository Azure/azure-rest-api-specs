import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The managed cluster resource
 *
 */
model ManagedCluster
  is Azure.ResourceManager.TrackedResource<ManagedClusterProperties> {
  ...ResourceNameParameter<
    Resource = ManagedCluster,
    KeyName = "clusterName",
    SegmentName = "managedClusters",
    NamePattern = ""
  >;

  /**
   * The sku of the managed cluster
   */
  sku: Sku;
}

@armResourceOperations
interface ManagedClusters {
  /**
   * Get a Service Fabric managed cluster resource created or in the process of being created in the specified resource group.
   */
  get is ArmResourceRead<ManagedCluster>;

  /**
   * Create or update a Service Fabric managed cluster resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedCluster,
    Response = ArmResourceUpdatedResponse<ManagedCluster> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ManagedCluster;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update the tags of of a Service Fabric managed cluster resource with the specified name.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    ManagedCluster,
    PatchModel = ManagedClusterUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed cluster resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedCluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ManagedCluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the subscription.
   */
  listBySubscription is ArmListBySubscription<ManagedCluster>;

  /**
   * Gets a fault simulation by the simulationId.
   */
  getFaultSimulation is ArmResourceActionSync<
    ManagedCluster,
    FaultSimulationIdParameters,
    ArmResponse<FaultSimulation>
  >;

  /**
   * Gets the list of recent fault simulations for the cluster.
   */
  listFaultSimulation is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<FaultSimulationListResult>
  >;

  /**
   * Starts a fault simulation on the cluster.
   */
  startFaultSimulation is ArmResourceActionAsync<
    ManagedCluster,
    FaultSimulationParameters,
    ArmResponse<FaultSimulation>
  >;

  /**
   * Stops a fault simulation on the cluster.
   */
  stopFaultSimulation is ArmResourceActionAsync<
    ManagedCluster,
    FaultSimulationIdParameters,
    ArmResponse<FaultSimulation>
  >;

  /**
   * Action to Apply Maintenance window on the Service Fabric Managed Clusters, right now. Any pending update will be applied.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("applyMaintenanceWindow")
  @operationId("managedApplyMaintenanceWindow_Post")
  post is ArmResourceActionSync<ManagedCluster, void, OkResponse>;

  /**
   * Action to get Maintenance Window Status of the Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("getMaintenanceWindowStatus")
  @operationId("managedMaintenanceWindowStatus_Get")
  managedMaintenanceWindowStatusGet is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<ManagedMaintenanceWindowStatus>
  >;

  /**
   * Action to get Az Resiliency Status of all the Base resources constituting Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("getazresiliencystatus")
  @operationId("managedAzResiliencyStatus_Get")
  managedAzResiliencyStatusGet is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<ManagedAzResiliencyStatus>
  >;
}

@@doc(ManagedCluster.name, "The name of the cluster resource.");
@@doc(ManagedCluster.properties, "The managed cluster resource properties");
@@doc(ManagedClusters.createOrUpdate::parameters.resource,
  "The cluster resource."
);
@@doc(ManagedClusters.update::parameters.properties,
  "The managed cluster resource updated tags."
);
@@doc(ManagedClusters.getFaultSimulation::parameters.body,
  "parameter with fault simulation id."
);
@@doc(ManagedClusters.startFaultSimulation::parameters.body,
  "parameters describing the fault simulation."
);
@@doc(ManagedClusters.stopFaultSimulation::parameters.body,
  "parameter with fault simulation id."
);
