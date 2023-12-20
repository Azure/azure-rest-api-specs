import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerRegistry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("An object that represents a webhook for a container registry.")
@parentResource(ContainerRegistry)
model ContainerRegistryWebhook is TrackedResource<WebhookProperties> {
  @doc("The name of the webhook.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("webhookName")
  @segment("webhooks")
  name: string;
}

@armResourceOperations
interface ContainerRegistryWebhooks {
  @doc("Gets the properties of the specified webhook.")
  get is ArmResourceRead<ContainerRegistryWebhook>;
  @doc("Creates a webhook for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<ContainerRegistryWebhook>;
  @doc("Updates a webhook with the specified parameters.")
  update is ArmResourcePatchAsync<ContainerRegistryWebhook, WebhookProperties>;
  @doc("Deletes a webhook from a container registry.")
  delete is ArmResourceDeleteAsync<ContainerRegistryWebhook>;
  @doc("Lists all the webhooks for the specified container registry.")
  list is ArmResourceListByParent<ContainerRegistryWebhook>;
  @doc("Triggers a ping event to be sent to the webhook.")
  ping is ArmResourceActionSync<ContainerRegistryWebhook, void, EventInfo>;
  @doc("Lists recent events for the specified webhook.")
  listEvents is ArmResourceActionSync<
    ContainerRegistryWebhook,
    void,
    EventListResult
  >;
  @doc("Gets the configuration of service URI and custom headers for the webhook.")
  getCallbackConfig is ArmResourceActionSync<
    ContainerRegistryWebhook,
    void,
    CallbackConfig
  >;
}
