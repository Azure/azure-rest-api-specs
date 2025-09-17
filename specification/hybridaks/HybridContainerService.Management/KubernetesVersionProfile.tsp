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
  is Azure.ResourceManager.ExtensionResource<KubernetesVersionProfileProperties> {
  ...ResourceNameParameter<
    Resource = KubernetesVersionProfile,
    KeyName = "kubernetesVersion",
    SegmentName = "kubernetesVersions"
  >;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface KubernetesVersionProfiles {
  /**
   * Lists the supported kubernetes versions for the specified custom location
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetKubernetesVersions")
  getKubernetesVersions is ArmResourceRead<
    KubernetesVersionProfile,
    BaseParameters = CustomLocationResourceUriParameters
  >;

  /**
   * Puts the default kubernetes version resource type (one time operation, before listing the kubernetes versions)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PutKubernetesVersions")
  putKubernetesVersions is ArmResourceCreateOrReplaceAsync<
    KubernetesVersionProfile,
    BaseParameters = CustomLocationResourceUriParameters
  >;

  /**
   * Delete the default kubernetes versions resource type
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("DeleteKubernetesVersions")
  deleteKubernetesVersions is ArmResourceDeleteWithoutOkAsync<
    KubernetesVersionProfile,
    BaseParameters = CustomLocationResourceUriParameters,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists the supported kubernetes versions for the specified custom location
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KubernetesVersions_List")
  list is ArmResourceListByParent<
    KubernetesVersionProfile,
    BaseParameters = CustomLocationResourceUriParameters,
    Response = ArmResponse<KubernetesVersionProfileList>
  >;
}

// ,
    //

@@doc(KubernetesVersionProfile.name, "");
@@doc(KubernetesVersionProfile.properties, "");
@@doc(KubernetesVersionProfiles.putKubernetesVersions::parameters.resource,
  "Kubernetes Versions resource definition"
);
