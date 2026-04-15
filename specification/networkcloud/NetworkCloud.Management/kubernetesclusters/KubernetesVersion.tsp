import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./KubernetesVersion_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;
/**
 * The name of the Kubernetes version resource.
 */
@added(Versions.v2026_01_01_preview)
model KubernetesVersionNameParameter
  is ResourceNameParameter<
    Resource = KubernetesVersion,
    KeyName = "kubernetesVersionName",
    SegmentName = "kubernetesVersions",
    NamePattern = "^default$"
  >;

/**
 * KubernetesVersion represents the available Kubernetes versions for a cluster.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
@added(Versions.v2026_01_01_preview)
model KubernetesVersion
  is Azure.ResourceManager.TrackedResource<KubernetesVersionProperties, false> {
  ...KubernetesVersionNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@added(Versions.v2026_01_01_preview)
@armResourceOperations
interface KubernetesVersions {
  /**
   * Retrieve the Kubernetes version resource that describes the available Kubernetes versions for deployment.
   */
  get is ArmResourceRead<KubernetesVersion>;

  /**
   * Create the Kubernetes version resource or update its tags. This resource is system managed and should only be created with the name "default".
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    KubernetesVersion,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = KubernetesVersion>
  >;

  /**
   * Update tags associated with the Kubernetes version resource. No other properties are supported for update.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    KubernetesVersion,
    PatchModel = KubernetesVersionPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = KubernetesVersion> &
      ArmLroLocationHeader<FinalResult = KubernetesVersion>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the specified Kubernetes version resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    KubernetesVersion,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of Kubernetes version resources in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    KubernetesVersion,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<KubernetesVersionList>
  >;

  /**
   * Get a list of Kubernetes version resources in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    KubernetesVersion,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<KubernetesVersionList>
  >;
}

@@doc(KubernetesVersion.name, "The name of the Kubernetes version resource.");
@@doc(KubernetesVersion.properties, "The list of the resource properties.");
@@doc(KubernetesVersions.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(KubernetesVersions.update::parameters.properties, "The request body.");
