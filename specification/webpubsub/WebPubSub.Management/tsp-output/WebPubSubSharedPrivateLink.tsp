import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebPubSub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * Describes a Shared Private Link Resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(WebPubSub)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  SharedPrivateLinkResourceProperties
)
model WebPubSubSharedPrivateLink extends ProxyResourceBase {
  /**
   * The name of the shared private link resource
   */
  @path
  @key("sharedPrivateLinkResourceName")
  @segment("sharedPrivateLinkResources")
  @visibility("read")
  name: string;

  /**
   * Describes the properties of an existing Shared Private Link Resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: SharedPrivateLinkResourceProperties;
}

@armResourceOperations
interface WebPubSubSharedPrivateLinks {
  /**
   * Get the specified shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSubSharedPrivateLinkResources_Get")
  get is ArmResourceRead<WebPubSubSharedPrivateLink>;

  /**
   * Create or update a shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSubSharedPrivateLinkResources_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WebPubSubSharedPrivateLink>;

  /**
   * Delete the specified shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSubSharedPrivateLinkResources_Delete")
  delete is ArmResourceDeleteAsync<WebPubSubSharedPrivateLink>;

  /**
   * List shared private link resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSubSharedPrivateLinkResources_List")
  list is ArmResourceListByParent<WebPubSubSharedPrivateLink>;
}

@@projectedName(WebPubSubSharedPrivateLinks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(WebPubSubSharedPrivateLinks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(WebPubSubSharedPrivateLinks.createOrUpdate::parameters.resource,
  "The shared private link resource"
);
