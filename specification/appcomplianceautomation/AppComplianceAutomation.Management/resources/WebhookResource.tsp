import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation webhook resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy DO NOT EVER COPY THIS"
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
  @path
  name: string;

  /**
   * Webhook property.
   */
  @extension("x-ms-client-flatten", true)
  @extension("x-ms-client-name", "properties")
  properties: WebhookProperties; // Replace 'WebhookProperties' with the actual type
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface Webhook {
  /**
   * Get the AppComplianceAutomation webhook and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhook_Get")
  get is ArmResourceRead<WebhookResource>;

  /**
   * Create a new AppComplianceAutomation webhook or update an exiting AppComplianceAutomation webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhook_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<WebhookResource>;

  /**
   * Update an exiting AppComplianceAutomation webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility
  @operationId("Webhook_Update")
  update is ArmCustomPatchSync<
    WebhookResource,
    WebhookResourcePatch,
    Response = ArmResponse<WebhookResource>,
    Error = ErrorResponse
  >;

  /**
   * Delete an AppComplianceAutomation webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhook_Delete")
  delete is ArmResourceDeleteSync<WebhookResource>;

  /**
   * Get the AppComplianceAutomation webhook list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhook_List")
  list is ArmResourceListByParent<
    WebhookResource,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<WebhookResource>;
      ...QueryParameters;
    }
  >;
}

@@doc(Webhook.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(Webhook.update::parameters.properties,
  "Parameters for the create or update operation"
);

@@encodedName(Webhook.update::parameters.properties,
  "application/json",
  "parameters"
);

@@encodedName(Webhook.createOrUpdate::parameters.resource,
  "application/json",
  "parameters"
);

@@OpenAPI.extension(Webhook.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);

@@clientName(Webhook.createOrUpdate::parameters.resource, "parameters");
