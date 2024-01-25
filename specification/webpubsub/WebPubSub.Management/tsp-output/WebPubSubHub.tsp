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
 * A hub setting
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(WebPubSub)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(WebPubSubHubProperties)
model WebPubSubHub extends ProxyResourceBase {
  /**
   * The hub name.
   */
  @path
  @key("hubName")
  @segment("hubs")
  @visibility("read")
  name: string;

  /**
   * Properties of a hub.
   */
  @extension("x-ms-client-flatten", true)
  properties: WebPubSubHubProperties;
}

@armResourceOperations
interface WebPubSubHubs {
  /**
   * Get a hub setting.
   */
  get is ArmResourceRead<WebPubSubHub>;

  /**
   * Create or update a hub setting.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WebPubSubHub>;

  /**
   * Delete a hub setting.
   */
  delete is ArmResourceDeleteAsync<WebPubSubHub>;

  /**
   * List hub settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSubHubs_List")
  list is ArmResourceListByParent<WebPubSubHub>;
}

@@projectedName(WebPubSubHubs.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(WebPubSubHubs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(WebPubSubHubs.createOrUpdate::parameters.resource,
  "The resource of WebPubSubHub and its properties"
);
