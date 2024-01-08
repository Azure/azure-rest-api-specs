import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

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
  @doc("Lists the supported kubernetes versions for the specified custom location")
  getKubernetesVersions is ArmResourceRead<KubernetesVersionProfile>;
  @doc("Puts the default kubernetes version resource type (one time operation, before listing the kubernetes versions)")
  putKubernetesVersions is ArmResourceCreateOrUpdateAsync<KubernetesVersionProfile>;
  @doc("Delete the default kubernetes versions resource type")
  deleteKubernetesVersions is ArmResourceDeleteWithoutOkAsync<KubernetesVersionProfile>;
  @doc("Lists the supported kubernetes versions for the specified custom location")
  listByArm is ArmResourceListByParent<KubernetesVersionProfile>;
}
