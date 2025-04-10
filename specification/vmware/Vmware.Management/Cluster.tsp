import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A cluster resource
 */
@parentResource(PrivateCloud)
model Cluster is Azure.ResourceManager.ProxyResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = "^[-\\w\\._]+$"
  >;

  /**
   * The SKU (Stock Keeping Unit) assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: Sku;
}

@armResourceOperations
interface Clusters {
  /**
   * Get a Cluster
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create a Cluster
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cluster>;

  /**
   * Update a Cluster
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Cluster,
    PatchModel = ClusterUpdate,
    Response = ArmResponse<Cluster> | ArmResourceCreatedResponse<Cluster>
  >;

  /**
   * Delete a Cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Cluster resources by PrivateCloud
   */
  list is ArmResourceListByParent<Cluster, Response = ArmResponse<ClusterList>>;

  /**
   * List hosts by zone in a cluster
   */
  listZones is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ClusterZoneList>
  >;
}

@@doc(Cluster.name, "Name of the cluster");
@@doc(Cluster.properties,
  "The resource-specific properties for this resource."
);
@@doc(Clusters.update::parameters.properties,
  "The cluster properties to be updated."
);
