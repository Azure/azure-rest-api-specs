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
model AutomationWebhook is ProxyResource<WebhookProperties> {
  @doc("The webhook name.")
  @path
  @key("webhookName")
  @segment("webhooks")
  name: string;
}

@armResourceOperations
interface AutomationWebhooks {
  @doc("Retrieve the webhook identified by webhook name.")
  get is ArmResourceRead<AutomationWebhook>;
  @doc("Create the webhook identified by webhook name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationWebhook>;
  @doc("Update the webhook identified by webhook name.")
  update is ArmResourcePatchSync<AutomationWebhook, WebhookProperties>;
  @doc("Delete the webhook by name.")
  delete is ArmResourceDeleteSync<AutomationWebhook>;
  @doc("Retrieve a list of webhooks.")
  listByAutomationAccount is ArmResourceListByParent<
    AutomationWebhook,
    {
      ...BaseParameters<AutomationWebhook>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
