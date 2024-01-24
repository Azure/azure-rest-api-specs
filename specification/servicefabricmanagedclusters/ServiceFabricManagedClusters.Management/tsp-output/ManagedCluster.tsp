import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The managed cluster resource
 *
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ManagedClusterProperties)
@includeInapplicableMetadataInPayload(false)
model ManagedCluster extends Resource {
  /**
   * The name of the cluster resource.
   */
  @path
  @key("clusterName")
  @segment("managedClusters")
  name: string;

  /**
   * The sku of the managed cluster
   */
  sku: Sku;

  /**
   * The managed cluster resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedClusterProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedCluster,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  /**
   * Update the tags of of a Service Fabric managed cluster resource with the specified name.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ManagedCluster, ManagedClusterUpdateParameters>;

  /**
   * Delete a Service Fabric managed cluster resource with the specified name.
   */
  delete is ArmResourceDeleteAsync<
    ManagedCluster,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedClusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ManagedCluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the subscription.
   */
  listBySubscription is ArmListBySubscription<ManagedCluster>;

  /**
   * Action to get Az Resiliency Status of all the Base resources constituting Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("managedAzResiliencyStatus_Get")
  get is ArmResourceActionSync<ManagedCluster, void, ManagedAzResiliencyStatus>;
}

@@projectedName(ManagedClusters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedClusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedClusters.createOrUpdate::parameters.resource,
  "The cluster resource."
);
@@projectedName(ManagedClusters.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ManagedClusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedClusters.update::parameters.properties,
  "The managed cluster resource updated tags."
);
