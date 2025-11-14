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
 * Represents a update content.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model UpdateContent
  is Azure.ResourceManager.ProxyResource<UpdateContentProperties> {
  ...ResourceNameParameter<
    Resource = UpdateContent,
    KeyName = "updateContentName",
    SegmentName = "updateContents",
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
interface UpdateContents {
  /**
   * Gets content for an update.
   */
  get is ArmResourceRead<
    UpdateContent,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List all update contents.
   */
  list is ArmResourceListByParent<
    UpdateContent,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(UpdateContent.name, "The name of the UpdateContent");
@@doc(UpdateContent.properties,
  "The resource-specific properties for this resource."
);
