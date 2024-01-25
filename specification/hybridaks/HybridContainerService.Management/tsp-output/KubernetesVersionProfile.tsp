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

namespace Microsoft.HybridContainerService;
/**
 * The supported kubernetes versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  KubernetesVersionProfileProperties
)
model KubernetesVersionProfile extends ExtensionResourceBase {
  @key("kubernetesVersion")
  @segment("kubernetesVersions")
  @visibility("read")
  name: string;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  extendedLocation?: ExtendedLocation;

  @extension("x-ms-client-flatten", true)
  properties?: KubernetesVersionProfileProperties;
}

@armResourceOperations
interface KubernetesVersionProfiles {
  /**
   * Lists the supported kubernetes versions for the specified custom location
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GetKubernetesVersions")
  getKubernetesVersions is ArmResourceRead<KubernetesVersionProfile>;

  /**
   * Puts the default kubernetes version resource type (one time operation, before listing the kubernetes versions)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PutKubernetesVersions")
  putKubernetesVersions is ArmResourceCreateOrReplaceAsync<
    KubernetesVersionProfile,
    BaseParameters<KubernetesVersionProfile>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete the default kubernetes versions resource type
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DeleteKubernetesVersions")
  deleteKubernetesVersions is ArmResourceDeleteWithoutOkAsync<
    KubernetesVersionProfile,
    BaseParameters<KubernetesVersionProfile>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the supported kubernetes versions for the specified custom location
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("KubernetesVersions_List")
  list is ArmResourceListByParent<KubernetesVersionProfile>;
}

@@projectedName(KubernetesVersionProfiles.putKubernetesVersions::parameters.resource,
  "json",
  "kubernetesVersions"
);
@@extension(KubernetesVersionProfiles.putKubernetesVersions::parameters.resource,
  "x-ms-client-name",
  "kubernetesVersions"
);
@@doc(KubernetesVersionProfiles.putKubernetesVersions::parameters.resource,
  "Kubernetes Versions resource definition"
);
