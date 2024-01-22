import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a webhook for a container registry.
 */
@parentResource(Registry)
model Webhook is TrackedResource<WebhookProperties> {
  /**
   * The name of the webhook.
   */
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("webhookName")
  @segment("webhooks")
  name: string;
}

@armResourceOperations
interface Webhooks {
  /**
   * Gets the properties of the specified webhook.
   */
  get is ArmResourceRead<Webhook>;

  /**
   * Creates a webhook for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Webhook,
    BaseParameters<Webhook>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a webhook with the specified parameters.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Webhook,
    WebhookUpdateParameters,
    BaseParameters<Webhook>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a webhook from a container registry.
   */
  delete is ArmResourceDeleteAsync<
    Webhook,
    BaseParameters<Webhook>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the webhooks for the specified container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhooks_List")
  list is ArmResourceListByParent<Webhook>;

  /**
   * Triggers a ping event to be sent to the webhook.
   */
  ping is ArmResourceActionSync<Webhook, void, EventInfo>;

  /**
   * Lists recent events for the specified webhook.
   */
  listEvents is ArmResourceActionSync<Webhook, void, EventListResult>;

  /**
   * Gets the configuration of service URI and custom headers for the webhook.
   */
  getCallbackConfig is ArmResourceActionSync<Webhook, void, CallbackConfig>;
}

@@projectedName(Webhooks.create::parameters.resource,
  "json",
  "webhookCreateParameters"
);
@@extension(Webhooks.create::parameters.resource,
  "x-ms-client-name",
  "webhookCreateParameters"
);
@@doc(Webhooks.create::parameters.resource,
  "The parameters for creating a webhook."
);
@@projectedName(Webhooks.update::parameters.properties,
  "json",
  "webhookUpdateParameters"
);
@@extension(Webhooks.update::parameters.properties,
  "x-ms-client-name",
  "webhookUpdateParameters"
);
@@doc(Webhooks.update::parameters.properties,
  "The parameters for updating a webhook."
);
