import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

/**
 * Represents a kubernetes version resource.
 */
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_03_01_preview)
model KubernetesVersion
  is Azure.ResourceManager.ProxyResource<KubernetesVersionProperties> {
  ...ResourceNameParameter<
    Resource = KubernetesVersion,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@added(Versions.v2026_03_01_preview)
interface KubernetesVersions {
  /**
   * List all kubernetes versions.
   */
  list is ArmResourceListAtScope<KubernetesVersion>;
}
