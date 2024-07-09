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

  @doc("Extended location pointing to the underlying infrastructure")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface KubernetesVersionProfiles {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the supported kubernetes versions for the specified custom location")
  @operationId("GetKubernetesVersions")
  getKubernetesVersions is ArmResourceRead<KubernetesVersionProfile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Puts the default kubernetes version resource type (one time operation, before listing the kubernetes versions)")
  @operationId("PutKubernetesVersions")
  putKubernetesVersions is ArmResourceCreateOrUpdateAsync<
    KubernetesVersionProfile,
    BaseParameters<KubernetesVersionProfile>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the default kubernetes versions resource type")
  @operationId("DeleteKubernetesVersions")
  deleteKubernetesVersions is ArmResourceDeleteWithoutOkAsync<
    KubernetesVersionProfile,
    BaseParameters<KubernetesVersionProfile>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the supported kubernetes versions for the specified custom location")
  @operationId("KubernetesVersions_List")
  list is ArmResourceListByParent<KubernetesVersionProfile>;
}
