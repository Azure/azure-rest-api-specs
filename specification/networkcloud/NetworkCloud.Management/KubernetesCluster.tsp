import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * KubernetesCluster represents the Kubernetes cluster hosted on Network Cloud.
 */
model KubernetesCluster
  is Azure.ResourceManager.TrackedResource<KubernetesClusterProperties, false> {
  ...ResourceNameParameter<
    Resource = KubernetesCluster,
    KeyName = "kubernetesClusterName",
    SegmentName = "kubernetesClusters",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The extended location of the cluster associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation: ExtendedLocation;
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
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Patch the properties of the provided Kubernetes cluster, or update the tags associated with the Kubernetes cluster. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    KubernetesCluster,
    PatchModel = KubernetesClusterPatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;
    },
    Response = ArmResponse<KubernetesCluster> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = KubernetesCluster> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: KubernetesCluster;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided Kubernetes cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    KubernetesCluster,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;
    },
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of Kubernetes clusters in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    KubernetesCluster,
    Response = ArmResponse<KubernetesClusterList>
  >;

  /**
   * Get a list of Kubernetes clusters in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    KubernetesCluster,
    Response = ArmResponse<KubernetesClusterList>
  >;

  /**
   * Restart a targeted node of a Kubernetes cluster.
   */
  restartNode is ArmResourceActionAsync<
    KubernetesCluster,
    KubernetesClusterRestartNodeParameters,
    ArmResponse<OperationStatusResult>
  >;
}

@@doc(KubernetesCluster.name, "The name of the Kubernetes cluster.");
@@encodedName(KubernetesCluster.eTag, "application/json", "etag");
@@doc(KubernetesCluster.properties, "The list of the resource properties.");
@@doc(KubernetesClusters.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(KubernetesClusters.update::parameters.properties, "The request body.");
@@doc(KubernetesClusters.restartNode::parameters.body, "The request body.");
