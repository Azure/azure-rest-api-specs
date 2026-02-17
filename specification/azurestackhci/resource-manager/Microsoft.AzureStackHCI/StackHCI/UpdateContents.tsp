import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

/**
 * Represents a update content.
 */
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_03_01_preview)
model UpdateContent
  is Azure.ResourceManager.ProxyResource<UpdateContentProperties> {
  ...ResourceNameParameter<
    Resource = UpdateContent,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@added(Versions.v2026_03_01_preview)
interface UpdateContents {
  /**
   * Gets content for an update.
   */
  get is ArmResourceRead<UpdateContent>;

  /**
   * List all update contents.
   */
  list is ArmResourceListByParent<
    UpdateContent,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}
