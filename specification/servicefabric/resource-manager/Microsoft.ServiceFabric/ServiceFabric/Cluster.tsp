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
 * The cluster resource
 *
 */
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface Clusters {
  /**
   * Get a Service Fabric cluster resource created or in the process of being created in the specified resource group.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create or update a Service Fabric cluster resource with the specified name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cluster,
    Response = ArmResourceUpdatedResponse<Cluster> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Cluster;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update the configuration of a Service Fabric cluster resource with the specified name.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Cluster,
    PatchModel = ClusterUpdateParameters,
    Response = ArmResponse<Cluster> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Cluster;
    })
  >;

  /**
   * Delete a Service Fabric cluster resource with the specified name.
   */
  delete is ArmResourceDeleteSync<Cluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the subscription.
   */
  list is ArmListBySubscription<Cluster>;

  /**
   * If a target is not provided, it will get the minimum and maximum versions available from the current cluster version. If a target is given, it will provide the required path to get from the current cluster version to the target version.
   */
  listUpgradableVersions is ArmResourceActionSync<
    Cluster,
    UpgradableVersionsDescription,
    ArmResponse<UpgradableVersionPathResult>,
    OptionalRequestBody = true
  >;
}

@@doc(Cluster.name, "The name of the cluster resource.");
@@doc(Cluster.properties, "The cluster resource properties");
@@doc(Clusters.createOrUpdate::parameters.resource, "The cluster resource.");
@@doc(Clusters.update::parameters.properties,
  "The parameters which contains the property value and property name which used to update the cluster configuration."
);
@@doc(Clusters.listUpgradableVersions::parameters.body,
  "The upgrade path description with target version."
);
