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
@doc("The supported kubernetes versions.")
@singleton("default")
model KubernetesVersionProfile
  is ExtensionResource<KubernetesVersionProfileProperties> {
  @key("kubernetesVersion")
  @segment("kubernetesVersions")
  name: string;

  @doc("Extended Location definition")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface KubernetesVersionProfiles {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the supported kubernetes versions from the underlying custom location")
  @operationId("GetKubernetesVersions")
  getKubernetesVersions is ArmResourceRead<KubernetesVersionProfile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Puts the kubernetes version resource type")
  @operationId("PutKubernetesVersions")
  putKubernetesVersions is ArmResourceCreateOrUpdateAsync<
    KubernetesVersionProfile,
    BaseParameters<KubernetesVersionProfile>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the kubernetes versions resource type")
  @operationId("DeleteKubernetesVersions")
  deleteKubernetesVersions is ArmResourceDeleteWithoutOkAsync<
    KubernetesVersionProfile,
    BaseParameters<KubernetesVersionProfile>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the supported kubernetes versions from the underlying custom location")
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
