import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

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
@parentResource(SignalRResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  SharedPrivateLinkResourceProperties
)
model SharedPrivateLinkResource extends ProxyResourceBase {
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
interface SharedPrivateLinkResources {
  /**
   * Get the specified shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRSharedPrivateLinkResources_Get")
  get is ArmResourceRead<SharedPrivateLinkResource>;

  /**
   * Create or update a shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRSharedPrivateLinkResources_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SharedPrivateLinkResource>;

  /**
   * Delete the specified shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRSharedPrivateLinkResources_Delete")
  delete is ArmResourceDeleteAsync<SharedPrivateLinkResource>;

  /**
   * List shared private link resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRSharedPrivateLinkResources_List")
  list is ArmResourceListByParent<SharedPrivateLinkResource>;
}

@@projectedName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "The shared private link resource"
);
