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

namespace Microsoft.Sql;
/**
 * An Azure SQL virtual cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(VirtualClusterProperties)
@includeInapplicableMetadataInPayload(false)
model VirtualCluster extends TrackedResource {
  /**
   * The name of the virtual cluster.
   */
  @path
  @key("virtualClusterName")
  @segment("virtualClusters")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: VirtualClusterProperties;
}

@armResourceOperations
interface VirtualClusters {
  /**
   * Gets a virtual cluster.
   */
  get is ArmResourceRead<VirtualCluster>;

  /**
   * Updates an existing virtual cluster.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<VirtualCluster, VirtualClusterUpdate>;

  /**
   * Deletes a virtual cluster.
   */
  delete is ArmResourceDeleteAsync<VirtualCluster>;

  /**
   * Gets a list of virtual clusters in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualClusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualCluster>;

  /**
   * Gets a list of all virtualClusters in the subscription.
   */
  list is ArmListBySubscription<VirtualCluster>;

  /**
   * Synchronizes the DNS server settings used by the managed instances inside the given virtual cluster.
   */
  updateDnsServers is ArmResourceActionAsync<
    VirtualCluster,
    void,
    UpdateVirtualClusterDnsServersOperation
  >;
}

@@projectedName(VirtualClusters.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(VirtualClusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(VirtualClusters.update::parameters.properties,
  "The requested virtual cluster resource state."
);
