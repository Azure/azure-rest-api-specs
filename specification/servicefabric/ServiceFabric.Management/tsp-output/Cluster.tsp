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
* The cluster resource

*/
model Cluster is TrackedResource<ClusterProperties> {
  /**
   * The name of the cluster resource.
   */
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cluster>;

  /**
   * Update the configuration of a Service Fabric cluster resource with the specified name.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Cluster, ClusterUpdateParameters>;

  /**
   * Delete a Service Fabric cluster resource with the specified name.
   */
  delete is ArmResourceDeleteSync<Cluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListByResourceGroup")
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
    UpgradableVersionPathResult
  >;
}

@@projectedName(Clusters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Clusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.createOrUpdate::parameters.resource, "The cluster resource.");
@@projectedName(Clusters.update::parameters.properties, "json", "parameters");
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.update::parameters.properties,
  "The parameters which contains the property value and property name which used to update the cluster configuration."
);
@@projectedName(Clusters.listUpgradableVersions::parameters.body,
  "json",
  "versionsDescription"
);
@@extension(Clusters.listUpgradableVersions::parameters.body,
  "x-ms-client-name",
  "versionsDescription"
);
@@doc(Clusters.listUpgradableVersions::parameters.body,
  "The upgrade path description with target version."
);
