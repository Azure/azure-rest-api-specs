import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("Represents a kubernetes version resource.")
@parentResource(SubscriptionLocationResource)
@removed(Versions.v2026_02_01)
model KubernetesVersion
  is Azure.ResourceManager.ProxyResource<KubernetesVersionProperties> {
  ...ResourceNameParameter<
    Resource = KubernetesVersion,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@removed(Versions.v2026_02_01)
interface KubernetesVersions {
  @doc("List all kubernetes versions.")
  list is ArmResourceListAtScope<KubernetesVersion>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Represents properties of a kubernetes version.")
@removed(Versions.v2026_02_01)
model KubernetesVersionProperties {
  @doc("Represents kubernetes version.")
  version: string;
}
