import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation webhook resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ReportResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(WebhookProperties)
model WebhookResource extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Webhook Name.
   */
  @pattern("^[-a-zA-Z0-9_]{1,50}$")
  @key("webhookName")
  @segment("webhooks")
  @visibility("read")
  name: string;

  /**
   * Webhook property.
   */
  @extension("x-ms-client-flatten", true)
  @extension("x-ms-client-name", "properties")
  properties: WebhookProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface WebhookResources {
  /**
   * Get the AppComplianceAutomation webhook and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhooks_Get")
  get is ArmResourceRead<WebhookResource>;

  /**
   * Create a new AppComplianceAutomation webhook or update an exiting AppComplianceAutomation webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhooks_CreateOrUpdate")
  createOrUpdate is AcatOperations.AcatResourceCreateOrReplaceSync<WebhookResource>;

  /**
   * Update an exiting AppComplianceAutomation webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Webhooks_Update")
  update is Azure.ResourceManager.Foundations.ArmUpdateOperation<WebhookResource, WebhookResourcePatch, ArmResponse<WebhookResource>, ErrorResponse>;

  /**
   * Delete an AppComplianceAutomation webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhooks_Delete")
  delete is ArmResourceDeleteSync<WebhookResource>;

  /**
   * Get the AppComplianceAutomation webhook list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhooks_List")
  list is ArmResourceListByParent<
    WebhookResource,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<WebhookResource>;
      ...QueryParameters;
    }
  >;
}

@@doc(WebhookResources.createOrUpdate::parameters.parameters,
  "Parameters for the create or update operation"
);
@@doc(WebhookResources.update::parameters.properties,
  "Parameters for the create or update operation"
);

@@encodedName(WebhookResources.update::parameters.properties,
  "application/json",
  "parameters"
);
