import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./KubernetesClusterFeature_models.tsp";
import "./KubernetesCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the feature.
 */
model KubernetesClusterFeatureNameParameter
  is ResourceNameParameter<
    Resource = KubernetesClusterFeature,
    KeyName = "featureName",
    SegmentName = "features",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9])$"
  >;

/**
 * KubernetesClusterFeature represents the feature of a Kubernetes cluster.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
@parentResource(KubernetesCluster)
model KubernetesClusterFeature
  is Azure.ResourceManager.TrackedResource<KubernetesClusterFeatureProperties> {
  ...KubernetesClusterFeatureNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
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
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = KubernetesClusterFeature>
  >;

  /**
   * Patch properties of the provided Kubernetes cluster feature.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    KubernetesClusterFeature,
    PatchModel = KubernetesClusterFeaturePatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = KubernetesClusterFeature> &
      ArmLroLocationHeader<FinalResult = KubernetesClusterFeature>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided Kubernetes cluster feature.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    KubernetesClusterFeature,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of features for the provided Kubernetes cluster.
   */
  listByKubernetesCluster is ArmResourceListByParent<
    KubernetesClusterFeature,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<KubernetesClusterFeatureList>
  >;
}

@@doc(KubernetesClusterFeature.name, "The name of the feature.");
@@doc(KubernetesClusterFeature.properties,
  "The list of the resource properties."
);
@@doc(KubernetesClusterFeatures.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(KubernetesClusterFeatures.update::parameters.properties,
  "The request body."
);
