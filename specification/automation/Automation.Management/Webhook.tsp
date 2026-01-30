import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the webhook type.
 */
@parentResource(AutomationAccount)
model Webhook is Azure.ResourceManager.ProxyResource<WebhookProperties> {
  ...ResourceNameParameter<
    Resource = Webhook,
    KeyName = "webhookName",
    SegmentName = "webhooks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Webhooks {
  /**
   * Retrieve the webhook identified by webhook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/webhookoperations")
  get is ArmResourceRead<Webhook>;

  /**
   * Create the webhook identified by webhook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/webhookoperations")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    Webhook,
    Request = WebhookCreateOrUpdateParameters
  >;

  /**
   * Update the webhook identified by webhook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/webhookoperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Webhook, PatchModel = WebhookUpdateParameters>;

  /**
   * Delete the webhook by name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/webhookoperations")
  delete is ArmResourceDeleteSync<Webhook, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of webhooks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/webhookoperations")
  listByAutomationAccount is ArmResourceListByParent<
    Webhook,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(Webhook.name, "The webhook name.");
@@doc(Webhook.properties, "Gets or sets the webhook properties.");
@@doc(Webhooks.createOrUpdate::parameters.resource,
  "The create or update parameters for webhook."
);
@@doc(Webhooks.update::parameters.properties,
  "The update parameters for webhook."
);
