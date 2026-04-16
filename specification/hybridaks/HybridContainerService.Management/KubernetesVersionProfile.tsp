import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * The supported kubernetes versions.
 */
@singleton("default")
model KubernetesVersionProfile
  is ExtensionResource<KubernetesVersionProfileProperties> {
  ...ResourceNameParameter<
    KubernetesVersionProfile,
    "kubernetesVersion",
    "kubernetesVersions"
  >;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Well-known envelope property"
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface KubernetesVersionProfiles {
  /**
   * Lists the supported kubernetes versions for the specified custom location
   */
  getKubernetesVersions is ArmResourceRead<
    KubernetesVersionProfile,
    BaseParameters = CustomLocationResourceUriParameters
  >;

  /**
   * Puts the default kubernetes version resource type (one time operation, before listing the kubernetes versions)
   */
  createKubernetesVersions is ArmResourceCreateOrReplaceAsync<
    KubernetesVersionProfile,
    BaseParameters = CustomLocationResourceUriParameters
  >;

  /**
   * Delete the default kubernetes versions resource type
   */
  deleteKubernetesVersions is ArmResourceDeleteWithoutOkAsync<
    KubernetesVersionProfile,
    BaseParameters = CustomLocationResourceUriParameters
  >;

  /**
   * Lists the supported kubernetes versions for the specified custom location
   */
  list is ArmResourceListByParent<
    KubernetesVersionProfile,
    BaseParameters = CustomLocationResourceUriParameters
  >;
}

@@doc(KubernetesVersionProfiles.createKubernetesVersions::parameters.resource,
  "Kubernetes Versions resource definition"
);
