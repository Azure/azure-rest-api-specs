import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
@doc("Definition of the webhook type.")
@parentResource(AutomationAccount)
model Webhook is ProxyResource<WebhookProperties> {
  @doc("The webhook name.")
  @path
  @key("webhookName")
  @segment("webhooks")
  name: string;
}

@armResourceOperations
interface Webhooks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the webhook identified by webhook name.")
  @operationId("Webhook_Get")
  get is ArmResourceRead<Webhook>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the webhook identified by webhook name.")
  @operationId("Webhook_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Webhook>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the webhook identified by webhook name.")
  @operationId("Webhook_Update")
  update is ArmCustomPatchSync<Webhook, WebhookUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the webhook by name.")
  @operationId("Webhook_Delete")
  delete is ArmResourceDeleteSync<Webhook>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of webhooks.")
  @operationId("Webhook_ListByAutomationAccount")
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

@@projectedName(Webhooks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Webhooks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Webhooks.createOrUpdate::parameters.resource,
  "The create or update parameters for webhook."
);
@@projectedName(Webhooks.update::parameters.properties, "json", "parameters");
@@extension(Webhooks.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Webhooks.update::parameters.properties,
  "The update parameters for webhook."
);
