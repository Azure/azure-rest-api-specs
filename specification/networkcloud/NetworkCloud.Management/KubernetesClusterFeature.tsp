import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./KubernetesCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * KubernetesClusterFeature represents the feature of a Kubernetes cluster.
 */
@parentResource(KubernetesCluster)
model KubernetesClusterFeature
  is Azure.ResourceManager.TrackedResource<KubernetesClusterFeatureProperties> {
  ...ResourceNameParameter<
    Resource = KubernetesClusterFeature,
    KeyName = "featureName",
    SegmentName = "features",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9])$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface KubernetesClusterFeatures {
  /**
   * Get properties of the provided the Kubernetes cluster feature.
   */
  get is ArmResourceRead<KubernetesClusterFeature>;

  /**
   * Create a new Kubernetes cluster feature or update properties of the Kubernetes cluster feature if it exists.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    KubernetesClusterFeature,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    }
  >;

  /**
   * Patch properties of the provided Kubernetes cluster feature.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    KubernetesClusterFeature,
    PatchModel = KubernetesClusterFeaturePatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmResponse<KubernetesClusterFeature> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = KubernetesClusterFeature> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: KubernetesClusterFeature;

      /**
       * The URL to retrieve the status of the asynchronous operation.
       */
      @header("Location")
      location: string;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided Kubernetes cluster feature.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    KubernetesClusterFeature,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of features for the provided Kubernetes cluster.
   */
  listByKubernetesCluster is ArmResourceListByParent<
    KubernetesClusterFeature,
    Response = ArmResponse<KubernetesClusterFeatureList>
  >;
}

@@doc(KubernetesClusterFeature.name, "The name of the feature.");
@@encodedName(KubernetesClusterFeature.eTag, "application/json", "etag");
@@doc(KubernetesClusterFeature.properties,
  "The list of the resource properties."
);
@@doc(KubernetesClusterFeatures.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(KubernetesClusterFeatures.update::parameters.properties,
  "The request body."
);
