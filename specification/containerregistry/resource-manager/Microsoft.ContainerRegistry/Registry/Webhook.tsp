import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./Webhook.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a webhook for a container registry.
 */
@parentResource(Registry)
model Webhook is Azure.ResourceManager.TrackedResource<WebhookProperties> {
  ...ResourceNameParameter<
    Resource = Webhook,
    KeyName = "webhookName",
    SegmentName = "webhooks",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
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
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    Webhook,
    Request = WebhookCreateParameters
  >;

  /**
   * Updates a webhook with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Webhook,
    PatchModel = WebhookUpdateParameters,
    Response = ArmResponse<Webhook> | ArmResourceCreatedResponse<
      Webhook,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = Webhook> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a webhook from a container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Webhook,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the webhooks for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    Webhook,
    Response = ArmResponse<WebhookListResult>
  >;

  /**
   * Triggers a ping event to be sent to the webhook.
   */
  ping is ArmResourceActionSync<Webhook, void, ArmResponse<EventInfo>>;

  /**
   * Lists recent events for the specified webhook.
   */
  @list
  listEvents is ArmResourceActionSync<
    Webhook,
    void,
    ArmResponse<EventListResult>
  >;

  /**
   * Gets the configuration of service URI and custom headers for the webhook.
   */
  getCallbackConfig is ArmResourceActionSync<
    Webhook,
    void,
    ArmResponse<CallbackConfig>
  >;
}

@@maxLength(Webhook.name, 50);
@@minLength(Webhook.name, 5);
@@doc(Webhook.name, "The name of the webhook.");
@@doc(Webhook.properties, "The properties of the webhook.");
@@doc(Webhooks.create::parameters.resource,
  "The parameters for creating a webhook."
);
@@doc(Webhooks.update::parameters.properties,
  "The parameters for updating a webhook."
);
