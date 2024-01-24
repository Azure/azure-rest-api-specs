import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A cluster resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@Azure.ResourceManager.Private.armResourceInternal(ClusterProperties)
@includeInapplicableMetadataInPayload(false)
model Cluster extends ProxyResourceBase {
  /**
   * Name of the cluster in the private cloud
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  /**
   * The properties of a cluster resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterProperties;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Clusters {
  /**
   * Get a cluster by name in a private cloud
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create or update a cluster in a private cloud
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cluster>;

  /**
   * Update a cluster in a private cloud
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Cluster, ClusterUpdate>;

  /**
   * Delete a cluster in a private cloud
   */
  delete is ArmResourceDeleteAsync<Cluster>;

  /**
   * List clusters in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_List")
  list is ArmResourceListByParent<Cluster>;

  /**
   * List hosts by zone in a cluster
   */
  listZones is ArmResourceActionSync<Cluster, void, ClusterZoneList>;
}

@@projectedName(Clusters.createOrUpdate::parameters.resource,
  "json",
  "cluster"
);
@@extension(Clusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cluster"
);
@@doc(Clusters.createOrUpdate::parameters.resource,
  "A cluster in the private cloud"
);
@@projectedName(Clusters.update::parameters.properties,
  "json",
  "clusterUpdate"
);
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "clusterUpdate"
);
@@doc(Clusters.update::parameters.properties,
  "The cluster properties to be updated"
);
