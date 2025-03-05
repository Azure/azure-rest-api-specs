import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

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
   * If eTag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.",
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility("read")
  etag?: string;

  /**
   * The sku of the managed cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 Property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ManagedCluster,
    Response = ArmResourceUpdatedResponse<ManagedCluster> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> & {
      @bodyRoot
      _: ManagedCluster;
    })
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
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedCluster,
    LroHeaders = ArmCombinedLroHeaders
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
  @tag("FaultSimulation")
  getFaultSimulation is ArmResourceActionSync<
    ManagedCluster,
    FaultSimulationIdContent,
    ArmResponse<FaultSimulation>
  >;

  /**
   * Gets the list of recent fault simulations for the cluster.
   */
  @tag("FaultSimulation")
  listFaultSimulation is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<FaultSimulationListResult>
  >;

  /**
   * Starts a fault simulation on the cluster.
   */
  @tag("FaultSimulation")
  startFaultSimulation is ArmResourceActionAsync<
    ManagedCluster,
    FaultSimulationContent,
    never,
    LroHeaders = ArmLroLocationHeader<FinalResult = FaultSimulation> &
      ArmAsyncOperationHeader
  >;

  /**
   * Stops a fault simulation on the cluster.
   */
  @tag("FaultSimulation")
  stopFaultSimulation is ArmResourceActionAsync<
    ManagedCluster,
    FaultSimulationIdContent,
    never,
    LroHeaders = ArmLroLocationHeader<FinalResult = FaultSimulation> &
      ArmAsyncOperationHeader
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Day 0 property, tagging for sdk generation"
interface ManagedGetAzResiliencyStatus {
  /**
   * Action to get Az Resiliency Status of all the Base resources constituting Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @action("getazresiliencystatus")
  @tag("ManagedAzResiliencyStatus")
  @operationId("managedAzResiliencyStatus_Get")
  managedAzResiliencyStatusGet is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<ManagedAzResiliencyStatus>
  >;
}

@armResourceOperations
interface ManagedApplyMaintenanceWindow {
  /**
   * Action to Apply Maintenance window on the Service Fabric Managed Clusters, right now. Any pending update will be applied.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @action("applyMaintenanceWindow")
  @operationId("managedApplyMaintenanceWindow_Post")
  post is ArmResourceActionSync<ManagedCluster, void, OkResponse>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Day 0 property, tagging for sdk generation"
interface ManagedGetMaintenanceWindowStatus {
  /**
   * Action to get Maintenance Window Status of the Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @tag("ManagedMaintenanceWindowStatus")
  @action("getMaintenanceWindowStatus")
  @operationId("managedMaintenanceWindowStatus_Get")
  managedMaintenanceWindowStatusGet is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<ManagedMaintenanceWindowStatus>
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
