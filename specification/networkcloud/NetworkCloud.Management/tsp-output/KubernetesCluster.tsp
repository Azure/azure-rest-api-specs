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
 * KubernetesCluster represents the Kubernetes cluster hosted on Network Cloud.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(KubernetesClusterProperties)
model KubernetesCluster extends TrackedResourceBase {
  /**
   * The name of the Kubernetes cluster.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("kubernetesClusterName")
  @segment("kubernetesClusters")
  @visibility("read")
  name: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  extendedLocation: ExtendedLocation;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: KubernetesClusterProperties;
}

@armResourceOperations
interface KubernetesClusters {
  /**
   * Get properties of the provided the Kubernetes cluster.
   */
  get is ArmResourceRead<KubernetesCluster>;

  /**
   * Create a new Kubernetes cluster or update the properties of the existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    KubernetesCluster,
    BaseParameters<KubernetesCluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch the properties of the provided Kubernetes cluster, or update the tags associated with the Kubernetes cluster. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    KubernetesCluster,
    KubernetesClusterPatchParameters,
    BaseParameters<KubernetesCluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete the provided Kubernetes cluster.
   */
  delete is ArmResourceDeleteAsync<
    KubernetesCluster,
    BaseParameters<KubernetesCluster>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of Kubernetes clusters in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("KubernetesClusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<KubernetesCluster>;

  /**
   * Get a list of Kubernetes clusters in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<KubernetesCluster>;

  /**
   * Restart a targeted node of a Kubernetes cluster.
   */
  restartNode is ArmResourceActionAsync<
    KubernetesCluster,
    KubernetesClusterRestartNodeParameters,
    OperationStatusResult,
    BaseParameters<KubernetesCluster>,
    ArmLroLocationHeader
  >;
}

@@projectedName(KubernetesClusters.createOrUpdate::parameters.resource,
  "json",
  "kubernetesClusterParameters"
);
@@extension(KubernetesClusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "kubernetesClusterParameters"
);
@@doc(KubernetesClusters.createOrUpdate::parameters.resource,
  "The request body."
);
@@projectedName(KubernetesClusters.update::parameters.properties,
  "json",
  "kubernetesClusterUpdateParameters"
);
@@extension(KubernetesClusters.update::parameters.properties,
  "x-ms-client-name",
  "kubernetesClusterUpdateParameters"
);
@@doc(KubernetesClusters.update::parameters.properties, "The request body.");
@@projectedName(KubernetesClusters.restartNode::parameters.body,
  "json",
  "kubernetesClusterRestartNodeParameters"
);
@@extension(KubernetesClusters.restartNode::parameters.body,
  "x-ms-client-name",
  "kubernetesClusterRestartNodeParameters"
);
@@doc(KubernetesClusters.restartNode::parameters.body, "The request body.");
