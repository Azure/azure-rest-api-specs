import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerRegistry;
@doc("An object that represents a webhook for a container registry.")
@parentResource(Registry)
model Webhook is TrackedResource<WebhookProperties> {
  @doc("The name of the webhook.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  @key("webhookName")
  @segment("webhooks")
  name: string;
}

@armResourceOperations
interface Webhooks {
  @doc("Gets the properties of the specified webhook.")
  get is ArmResourceRead<Webhook>;

  @doc("Creates a webhook for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<Webhook>;

  @doc("Updates a webhook with the specified parameters.")
  update is ArmCustomPatchAsync<Webhook, WebhookUpdateParameters>;

  @doc("Deletes a webhook from a container registry.")
  delete is ArmResourceDeleteAsync<Webhook>;

  @doc("Lists all the webhooks for the specified container registry.")
  list is ArmResourceListByParent<Webhook>;

  @doc("Triggers a ping event to be sent to the webhook.")
  ping is ArmResourceActionSync<Webhook, void, EventInfo>;

  @doc("Lists recent events for the specified webhook.")
  listEvents is ArmResourceActionSync<Webhook, void, EventListResult>;

  @doc("Gets the configuration of service URI and custom headers for the webhook.")
  getCallbackConfig is ArmResourceActionSync<Webhook, void, CallbackConfig>;
}
