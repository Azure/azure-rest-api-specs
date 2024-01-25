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

namespace Microsoft.OperationalInsights;
/**
 * The top level Log Analytics cluster resource container.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ClusterProperties)
model Cluster extends TrackedResourceBase {
  /**
   * Name of the Log Analytics Cluster.
   */
  @path
  @key("clusterName")
  @segment("clusters")
  @visibility("read")
  name: string;

  /**
   * Log Analytics cluster properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets a Log Analytics cluster instance.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create or update a Log Analytics cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cluster>;

  /**
   * Updates a Log Analytics cluster.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Cluster, ClusterPatch>;

  /**
   * Deletes a cluster instance.
   */
  delete is ArmResourceDeleteAsync<Cluster>;

  /**
   * Gets Log Analytics clusters in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  /**
   * Gets the Log Analytics clusters in a subscription.
   */
  list is ArmListBySubscription<Cluster>;
}

@@projectedName(Clusters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Clusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.createOrUpdate::parameters.resource,
  "The parameters required to create or update a Log Analytics cluster."
);
@@projectedName(Clusters.update::parameters.properties, "json", "parameters");
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.update::parameters.properties,
  "The parameters required to patch a Log Analytics cluster."
);
