import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebPubSubResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * A hub setting
 */
@parentResource(WebPubSubResource)
model WebPubSubHub
  is Azure.ResourceManager.ProxyResource<WebPubSubHubProperties, false> {
  ...ResourceNameParameter<
    Resource = WebPubSubHub,
    KeyName = "hubName",
    SegmentName = "hubs",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    WebPubSubHub,
    Response =
      | OkResponse
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List hub settings.
   */
  list is ArmResourceListByParent<
    WebPubSubHub,
    Response = ArmResponse<WebPubSubHubList>
  >;
}

@@doc(WebPubSubHub.name, "The hub name.");
@@doc(WebPubSubHub.properties, "Properties of a hub.");
@@doc(WebPubSubHubs.createOrUpdate::parameters.resource,
  "The resource of WebPubSubHub and its properties"
);
