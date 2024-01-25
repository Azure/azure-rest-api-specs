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
 * Cluster represents the on-premises Network Cloud cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ClusterProperties)
model Cluster extends TrackedResourceBase {
  /**
   * The name of the cluster.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("clusterName")
  @segment("clusters")
  @visibility("read")
  name: string;

  /**
   * The extended location of the cluster manager associated with the cluster.
   */
  extendedLocation: ExtendedLocation;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ClusterProperties;
}

@armResourceOperations
interface Clusters {
  /**
   * Get properties of the provided cluster.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create a new cluster or update the properties of the cluster if it exists.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch the properties of the provided cluster, or update the tags associated with the cluster. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterPatchParameters,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete the provided cluster.
   */
  delete is ArmResourceDeleteAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of clusters in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  /**
   * Get a list of clusters in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<Cluster>;

  /**
   * Deploy the cluster to the provided rack.
   */
  deploy is ArmResourceActionAsync<
    Cluster,
    ClusterDeployParameters,
    OperationStatusResult,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Update the version of the provided cluster to one of the available supported versions.
   */
  updateVersion is ArmResourceActionAsync<
    Cluster,
    ClusterUpdateVersionParameters,
    OperationStatusResult,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;
}

@@projectedName(Clusters.createOrUpdate::parameters.resource,
  "json",
  "clusterParameters"
);
@@extension(Clusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "clusterParameters"
);
@@doc(Clusters.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(Clusters.update::parameters.properties,
  "json",
  "clusterUpdateParameters"
);
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "clusterUpdateParameters"
);
@@doc(Clusters.update::parameters.properties, "The request body.");
@@projectedName(Clusters.deploy::parameters.body,
  "json",
  "clusterDeployParameters"
);
@@extension(Clusters.deploy::parameters.body,
  "x-ms-client-name",
  "clusterDeployParameters"
);
@@doc(Clusters.deploy::parameters.body, "The request body.");
@@projectedName(Clusters.updateVersion::parameters.body,
  "json",
  "clusterUpdateVersionParameters"
);
@@extension(Clusters.updateVersion::parameters.body,
  "x-ms-client-name",
  "clusterUpdateVersionParameters"
);
@@doc(Clusters.updateVersion::parameters.body, "The request body.");
