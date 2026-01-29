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
model KubernetesVersion
  is Azure.ResourceManager.ProxyResource<KubernetesVersionProperties> {
  ...ResourceNameParameter<
    Resource = KubernetesVersion,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
interface KubernetesVersions {
  @doc("List all kubernetes versions.")
  list is ArmResourceListAtScope<KubernetesVersion>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Represents properties of a kubernetes version.")
model KubernetesVersionProperties {
  @doc("Represents kubernetes version.")
  version: string;
}
