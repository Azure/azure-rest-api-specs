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

namespace Microsoft.NetworkCloud;
/**
 * ClusterManager represents a control-plane to manage one or more on-premises clusters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ClusterManagerProperties)
@includeInapplicableMetadataInPayload(false)
model ClusterManager extends TrackedResourceBase {
  /**
   * The name of the cluster manager.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("clusterManagerName")
  @segment("clusterManagers")
  name: string;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ClusterManagerProperties;
}

@armResourceOperations
interface ClusterManagers {
  /**
   * Get the properties of the provided cluster manager.
   */
  get is ArmResourceRead<ClusterManager>;

  /**
   * Create a new cluster manager or update properties of the cluster manager if it exists.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterManager,
    BaseParameters<ClusterManager>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch properties of the provided cluster manager, or update the tags assigned to the cluster manager. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ClusterManager, ClusterManagerPatchParameters>;

  /**
   * Delete the provided cluster manager.
   */
  delete is ArmResourceDeleteAsync<
    ClusterManager,
    BaseParameters<ClusterManager>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of cluster managers in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ClusterManagers_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ClusterManager>;

  /**
   * Get a list of cluster managers in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<ClusterManager>;
}

@@projectedName(ClusterManagers.createOrUpdate::parameters.resource,
  "json",
  "clusterManagerParameters"
);
@@extension(ClusterManagers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "clusterManagerParameters"
);
@@doc(ClusterManagers.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(ClusterManagers.update::parameters.properties,
  "json",
  "clusterManagerUpdateParameters"
);
@@extension(ClusterManagers.update::parameters.properties,
  "x-ms-client-name",
  "clusterManagerUpdateParameters"
);
@@doc(ClusterManagers.update::parameters.properties, "The request body.");
