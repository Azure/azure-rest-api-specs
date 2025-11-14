import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Represents a platform update resource.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model PlatformUpdate
  is Azure.ResourceManager.ProxyResource<PlatformUpdateProperties> {
  ...ResourceNameParameter<
    Resource = PlatformUpdate,
    KeyName = "platformUpdateName",
    SegmentName = "platformUpdates",
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
interface PlatformUpdates {
  /**
   * Get a platform update.
   */
  get is ArmResourceRead<
    PlatformUpdate,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List all platform updates.
   */
  list is ArmResourceListByParent<
    PlatformUpdate,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(PlatformUpdate.name, "The name of the PlatformUpdate");
@@doc(PlatformUpdate.properties,
  "The resource-specific properties for this resource."
);
