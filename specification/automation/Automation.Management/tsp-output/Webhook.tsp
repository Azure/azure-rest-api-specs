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
/**
 * Definition of the webhook type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(WebhookProperties)
@includeInapplicableMetadataInPayload(false)
model Webhook extends ProxyResourceBase {
  /**
   * The webhook name.
   */
  @path
  @key("webhookName")
  @segment("webhooks")
  name: string;

  /**
   * Gets or sets the webhook properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WebhookProperties;
}

@armResourceOperations
interface Webhooks {
  /**
   * Retrieve the webhook identified by webhook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhook_Get")
  get is ArmResourceRead<Webhook>;

  /**
   * Create the webhook identified by webhook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhook_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Webhook>;

  /**
   * Update the webhook identified by webhook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Webhook_Update")
  update is ArmCustomPatchSync<Webhook, WebhookUpdateParameters>;

  /**
   * Delete the webhook by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhook_Delete")
  delete is ArmResourceDeleteSync<Webhook>;

  /**
   * Retrieve a list of webhooks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhook_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    Webhook,
    {
      ...BaseParameters<Webhook>;

      /**
       * The filter to apply on the operation.
       */
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
