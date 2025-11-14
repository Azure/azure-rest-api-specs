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
 * Represents a os image resource.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model OsImage is Azure.ResourceManager.ProxyResource<OsImageProperties> {
  ...ResourceNameParameter<
    Resource = OsImage,
    KeyName = "osImageName",
    SegmentName = "osImages",
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
interface OsImages {
  /**
   * Get a os image.
   */
  get is ArmResourceRead<
    OsImage,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List all os images.
   */
  listBySubscriptionLocationResource is ArmResourceListByParent<
    OsImage,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(OsImage.name, "The name of the OsImage");
@@doc(OsImage.properties,
  "The resource-specific properties for this resource."
);
