import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

/**
 * Represents a platform update resource.
 */
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_03_01_preview)
model PlatformUpdate
  is Azure.ResourceManager.ProxyResource<PlatformUpdateProperties> {
  ...ResourceNameParameter<
    Resource = PlatformUpdate,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@added(Versions.v2026_03_01_preview)
interface PlatformUpdates {
  /**
   * Get a platform update.
   */
  get is ArmResourceRead<PlatformUpdate>;

  /**
   * List all platform updates.
   */
  list is ArmResourceListByParent<
    PlatformUpdate,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}
