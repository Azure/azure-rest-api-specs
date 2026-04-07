import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./KubernetesCluster_models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the Kubernetes cluster.
 */
model KubernetesClusterNameParameter
  is ResourceNameParameter<
    Resource = KubernetesCluster,
    KeyName = "kubernetesClusterName",
    SegmentName = "kubernetesClusters",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * KubernetesCluster represents the Kubernetes cluster hosted on Network Cloud.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model KubernetesCluster
  is Azure.ResourceManager.TrackedResource<KubernetesClusterProperties, false> {
  ...KubernetesClusterNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
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
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = KubernetesCluster>
  >;

  /**
   * Patch the properties of the provided Kubernetes cluster, or update the tags associated with the Kubernetes cluster. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    KubernetesCluster,
    PatchModel = KubernetesClusterPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = KubernetesCluster> &
      ArmLroLocationHeader<FinalResult = KubernetesCluster>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided Kubernetes cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    KubernetesCluster,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of Kubernetes clusters in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    KubernetesCluster,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<KubernetesClusterList>
  >;

  /**
   * Get a list of Kubernetes clusters in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    KubernetesCluster,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<KubernetesClusterList>
  >;

  /**
   * Restart a targeted node of a Kubernetes cluster.
   */
  restartNode is ActionAsync<
    KubernetesCluster,
    KubernetesClusterRestartNodeParameters,
    OperationStatusResult
  >;
}

@@doc(KubernetesCluster.name, "The name of the Kubernetes cluster.");
@@doc(KubernetesCluster.properties, "The list of the resource properties.");
@@doc(KubernetesClusters.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(KubernetesClusters.update::parameters.properties, "The request body.");
@@doc(KubernetesClusters.restartNode::parameters.body, "The request body.");
