import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

/**
 * Represents a os image resource.
 */
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_03_01_preview)
model OsImage is Azure.ResourceManager.ProxyResource<OsImageProperties> {
  ...ResourceNameParameter<
    Resource = OsImage,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@added(Versions.v2026_03_01_preview)
interface OsImages {
  /**
   * Get a os image.
   */
  get is ArmResourceRead<OsImage>;

  /**
   * List all os images.
   */
  list is ArmResourceListAtScope<OsImage>;
}
