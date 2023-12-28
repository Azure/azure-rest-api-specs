import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("Definition of the webhook type.")
@parentResource(AutomationAccount)
model Webhook is ProxyResource<WebhookProperties> {
  @doc("The webhook name.")
  @key("webhookName")
  @segment("webhooks")
  name: string;
}

@armResourceOperations
interface Webhook {
  @doc("Retrieve the webhook identified by webhook name.")
  get is ArmResourceRead<Webhook>;
  @doc("Create the webhook identified by webhook name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Webhook>;
  @doc("Update the webhook identified by webhook name.")
  update is ArmCustomPatchSync<Webhook, WebhookUpdateParameters>;
  @doc("Delete the webhook by name.")
  delete is ArmResourceDeleteSync<Webhook>;
  @doc("Retrieve a list of webhooks.")
  listByAutomationAccount is ArmResourceListByParent<
    Webhook,
    {
      ...BaseParameters<Webhook>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
